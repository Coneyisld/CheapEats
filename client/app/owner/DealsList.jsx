import React from 'react';
import Deal from './Deal.jsx';
import axios from 'axios';
import Modal from 'react-modal';

class DealsList extends React.Component {
  constructor(props) {
    super(props);
    let now = new Date();
    if(now.getDate() < 10){
      var d =  '0' + now.getDate().toString();
    }
    this.today = now.getFullYear() + '-' + (now.getMonth() + 1) + '-' + d;
    this.state = {
      modifyModal: false,
      mName: '',
      mPrice: 0,
      mDescription: '',
      mImageURL: '',
      mStartDate: this.today,
      mStartTime: '00:00',
      mEndDate: this.today,
      mEndTime: '00:00',
      prevName: '',
    };
  }

  addDeal() {
    // add to list and send save request to server
    this.setState({
      modifyModal: true,
      mName: '',
      mPrice: 0,
      mDescription: '',
      mImageURL: '',
      mStartDate: this.today, 
      mStartTime: '00:00',
      mEndDate: this.today,
      mEndTime: '00:00',
      prevName: '',
    });
  }

  closeModal() {
    this.setState({
      modifyModal: false,
    });
  }

  modifyDeal(deal) {
    this.setState({
      modifyModal: true,
      mName: deal.dealname,
      mPrice: deal.price,
      mDescription: deal.description,
      mImageURL: deal.imageurl,
      mStartDate: deal.startdate,
      mStartTime: deal.starttime,
      mEndDate: deal.enddate,
      mEndTime: deal.endtime,
      prevName: deal.dealname,
    });
  }

  updateName(event) {
    this.setState({
      mName: event.target.value,
    });
  }

  updatePrice(event) {
    this.setState({
      mPrice: event.target.value,
    });
  }

  updateDescription(event) {
    this.setState({
      mDescription: event.target.value,
    });
  }

  updateImageURL(event) {
    this.setState({
      mImageURL: event.target.value,
    });
  }

  updateStartDate(event) {
    console.log(event.target.value);
    this.setState({
      mStartDate: event.target.value,
    });
  }

  updateStartTime(event) {
    console.log(event.target.value);
    this.setState({
      mStartTime: event.target.value,
    });
  }

  updateEndDate(event) {
    this.setState({
      mEndDate: event.target.value,
    });
  }

  updateEndTime(event) {
    this.setState({
      mEndTime: event.target.value,
    });
  }

  updateDeal() {
    this.setState({
      modifyModal: false,
    });
    if(this.props.selected !== '') {
      if(this.state.prevName === '') {
        axios.post('/owner/deals', {
          dealName: this.state.mName,
          price: this.state.mPrice,
          description: this.state.mDescription,
          imageURL: this.state.mImageURL,
          startDate: this.state.mStartDate,
          startTime: this.state.mStartTime,
          endDate: this.state.mEndDate,
          endTime: this.state.mEndTime,
          restaurant: this.props.selected,
        }).then(res => {
          this.props.setDeals(res.data);
        }).catch(err => {
          console.log('error in post deals\n', err);
        });
      } else {
        axios.put('/owner/deals', {
          dealName: this.state.mName,
          price: this.state.mPrice,
          description: this.state.mDescription,
          imageURL: this.state.mImageURL,
          startDate: this.state.mStartDate,
          startTime: this.state.mStartTime,
          endDate: this.state.mEndDate,
          endTime: this.state.mEndTime,
          restaurant: this.props.selected,
          prevName: this.state.prevName,
        }).then(res => {
          this.props.setDeals(res.data);
        }).catch(err => {
          console.log('error in put deals\n', err);
        });
      }
    }
  }

  render() {
    return (
      <div className="col3">
        <h3>DealsList</h3>
        <div className="scroll">
          {this.props.deals.map(deal => 
            <Deal deal={deal} key={deal.dealname} 
              modifyDeal={this.modifyDeal.bind(this)}/>)}
        </div>
        <button type="button" onClick={this.addDeal.bind(this)}>add Deal</button>

        <Modal
          id="modifyDeal"
          closeTimeoutMS={150}
          contentLabel="modifyDeal"
          isOpen={this.state.modifyModal}>

          <h1>Deal Info.</h1>
          Name: <input type="text" value={this.state.mName} onChange={this.updateName.bind(this)} /> <br />
          Price: <input type="number" step="0.01" min="0" value={this.state.mPrice} onChange={this.updatePrice.bind(this)} /> <br />
          Description: <input type="text" value={this.state.mDescription} onChange={this.updateDescription.bind(this)} /> <br />
          Image URL: <input type="text" value={this.state.mImageURL} onChange={this.updateImageURL.bind(this)} /> <br />
          Start Date: <input type="date" value={this.state.mStartDate} onChange={this.updateStartDate.bind(this)} /> <br />
          Start Time: <input type="time" value={this.state.mStartTime} onChange={this.updateStartTime.bind(this)} /> <br />
          End Date: <input type="date" value={this.state.mEndDate} onChange={this.updateEndDate.bind(this)} /> <br />
          End Time: <input type="time" value={this.state.mEndTime} onChange={this.updateEndTime.bind(this)} /> <br />
          
          <button onClick={this.updateDeal.bind(this)}>Update</button>
          <button onClick={this.closeModal.bind(this)}>Cancel</button>
          <button onClick={this.closeModal.bind(this)}>Delete</button>
        </Modal>
      </div>
    );
  }
}


export default DealsList;