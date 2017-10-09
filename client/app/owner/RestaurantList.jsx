import React from 'react';
import Restaurant from './Restaurant.jsx';
import axios from 'axios';
import Modal from 'react-modal';


class RestaurantList extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      restaurants: [],      
      modifyModal: false, // RestaurantList
      mName: '',
      mAddress: '',
      mZIP: '',
      mType: '',
      mImageURL: '',
      mRestaurantURL: '',
      mYelpID: '',
      prevName: '',
      tempRList: [],
    }
    this.updateRestaurantList = this.updateRestaurantList.bind(this);
  }

  componentDidMount() {
    axios.get('/owner/restaurants')
      .then(res => {
        this.setState({
          restaurants: res.data,
        });
      });
  }

  closeModal () {
    this.setState({
      modifyModal: false
    });
  }

  addRestaurant () {
    this.setState({
      modifyModal: true,
      mName: '',
      mAddress: '',
      mZIP: '',
      mType: '',
      mImageURL: '',
      mRestaurantURL: '',
      mYelpID: '',
      prevName: '',
    })
  }

  updateRestaurantList ({name = this.this.state.mName, type = this.state.mType,
      zip = this.state.mZIP, addr = this.state.mAddress} = {}) {
    console.log('/find/restaurants');
    axios.get('/find/restaurants', { 
      params: {
        term: `${name}, ${type}`,
        location: `${zip}, ${addr}`,
      },
    }).then(result => {
      console.log('result of restaurantSearch\n', result.data.businesses);
      if (result.data.businesses) {
        this.setState({
          tempRList: result.data.businesses,
        });
      }
    }).catch(err => {
      console.log('err in update restaurant\n', err);
    });
  }

  selectRestaurant (restaurant) {
    if(this.props.selected === restaurant.name) {
      this.setState({
        modifyModal: true,
        mName: restaurant.name,
        mAddress: restaurant.address,
        mZIP: restaurant.zip,
        mType: restaurant.type,
        mImageURL: restaurant.imageurl,
        mRestaurantURL: restaurant.restauranturl,
        mYelpID: restaurant.yelpid,
        prevName: restaurant.name,
      })
    } else {
      this.props.select(restaurant.name);
      this.setState({
        mName: restaurant.name,
        mAddress: restaurant.address,
        mZIP: restaurant.zip,
        mType: restaurant.type,
        mImageURL: restaurant.imageurl,
        mRestaurantURL: restaurant.restauranturl,
        mYelpID: restaurant.yelpid,
        prevName: restaurant.name,
      })
    }
  }

  updateMName(event) {
    this.setState({
      mName: event.target.value,
    });
    this.updateRestaurantList({name: event.target.value});
  }
  updateMAddress(event) {
    this.setState({
      mAddress: event.target.value,
    });
    this.updateRestaurantList({addr: event.target.value});
  }
  updateMZIP(event) {
    this.setState({
      mZIP: event.target.value,
    });
    this.updateRestaurantList({zip: event.target.value});
  }
  updateMType(event) {
    this.setState({
      mType: event.target.value,
    });
    this.updateRestaurantList({type: event.target.value});
  }
  updateMImageURL(event) {
    this.setState({
      mImageURL: event.target.value,
    })
  }
  updateMRestaurantURL(event) {
    this.setState({
      mRestaurantURL: event.target.value,
    })
  }
  updateMYelpID(event) {
    this.setState({
      mYelpID: event.target.value,
    })
  }

  updateRestaurant() {
    this.setState({
      modifyModal: false
    });
    if(this.state.prevName === ''){ // new
      axios.post('/owner/restaurants', {
        name: this.state.mName,
        address: this.state.mAddress,
        ZIP: this.state.mZIP,
        type: this.state.mType,
        imageURL: this.state.mImageURL,
        restaurantURL: this.state.mRestaurantURL,
        YelpID: this.state.mYelpID,
      }).then(result => {
        this.setState({
          restaurants: result.data,
        });
      }).catch(err => {
        console.log('err in saving restaurant\n', err);
      });
    } else { // update
      axios.put('/owner/restaurants', {
        name: this.state.mName,
        address: this.state.mAddress,
        ZIP: this.state.mZIP,
        type: this.state.mType,
        imageURL: this.state.mImageURL,
        restaurantURL: this.state.mRestaurantURL,
        YelpID: this.state.mYelpID,
        prevName: this.state.prevName,
      }).then(result => {
        this.setState({
          restaurants: result.data,
        });
      }).catch(err => {
        console.log('err in saving restaurant\n', err);
      });
    }
  }

  selectList(event) {
    let temp = this.state.tempRList.find(element => element.name === event.target.value);
    console.log('selectList', temp);
    this.setState({
      mAddress: `${temp.location.display_address[0]}, ${temp.location.display_address[1]}`,
      mZIP: temp.location.zip_code,
      mType: temp.categories[0].title,
      mImageURL: temp.image_url,
      mRestaurantURL: temp.url,
      mYelpID: temp.id,
    });
  }

  render() {
    return (
      <div className="col3">
        <h3>RestaurantList</h3>
        <div className="scroll">
          {this.state.restaurants.map(restaurant => 
            <Restaurant 
              key={restaurant.name} 
              restaurant={restaurant} 
              select={this.selectRestaurant.bind(this)}
              selected={this.props.selected} />
          )}
        </div>
        <button type="button" onClick={this.addRestaurant.bind(this)}>add Restaurant</button>        

        <Modal
          id="modifyRestaurant"
          closeTimeoutMS={150}
          contentLabel="modifyRestaurant"
          isOpen={this.state.modifyModal}
          style={{"content":{"top":"100px","left":"100px","right":"100px","bottom":"100px"}}}>

          <h1>Restaurant Info.</h1>
          Name: <input list="rl" onChange={this.updateMName.bind(this)} onInput={this.selectList.bind(this)} /> <datalist id="rl">{this.state.tempRList.map(r => <option label={r.name} value={r.name} />)}</datalist> <br />
          Address: <input type="text" value={this.state.mAddress} onChange={this.updateMAddress.bind(this)} /> <br />
          ZIP: <input type="text" value={this.state.mZIP} onChange={this.updateMZIP.bind(this)} /> <br />
          Type: <input type="text" value={this.state.mType} onChange={this.updateMType.bind(this)} /> <br />
          ImageURL: <input type="text" value={this.state.mImageURL} onChange={this.updateMImageURL.bind(this)} /> <br />
          RestaurantURL: <input type="text" value={this.state.mRestaurantURL} onChange={this.updateMRestaurantURL.bind(this)} /> <br />
          Yelp ID: <input type="text" value={this.state.mYelpID} onChange={this.updateMYelpID.bind(this)} /> <br />
          <button onClick={this.updateRestaurant.bind(this)}>Update</button>
          <button onClick={this.closeModal.bind(this)}>Cancel</button>
          <button onClick={this.closeModal.bind(this)}>Delete</button>
        </Modal>
      </div>
    );
  }
}


export default RestaurantList;

// Name: <input type="text" value={this.state.mName} onChange={this.updateMName.bind(this)} /> <br />

