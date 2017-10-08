import React from 'react';
import RestaurantList from './RestaurantList.jsx';
import DealsList from './DealsList.jsx';
import CheapItemList from './CheapItemList.jsx';
import axios from 'axios';

class Owner extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      owner: '', // ownerId
      selected: '',
      cheapItems: [],
      deals: [],
    }
  }

  componentDidMount() {
    axios.get('/owner/login')
      .then(res => {
        this.setState({
          owner: res.data,
        });
      });
  }


  selectRestaurant(name) {
    this.setState({
      selected: name,
    });
    Promise.all([
      axios.get('/owner/deals', 
        {params: {restaurant: name}}),
      axios.get('/owner/cheapitems', 
        {params: {restaurant: name}}),
    ]).then(data => {
      this.setState({
          deals: data[0].data,
          cheapItems: data[1].data,
        });
    });
  }
  
  logout() {
    axios.get('/owner/logout')
      .then(res => {
        window.location='/login';
      });
  }

  setDeals(deals) {
    this.setState({
      deals: deals,
    });
  }

  setItems(items) {
    this.setState({
      cheapItems: items,
    });
  }

  render() {
    return (
      <div>
        <h1>{this.state.owner}</h1>
        <button type="button" onClick={this.logout.bind(this)}>Logout</button> <br/>
        <RestaurantList 
          restaurants={this.state.restaurants} 
          select={this.selectRestaurant.bind(this)}
          selected={this.state.selected} />
        <CheapItemList 
          items={this.state.cheapItems}
          selected={this.state.selected} 
          setItems={this.setItems.bind(this)} />
        <DealsList 
          deals={this.state.deals}
          selected={this.state.selected} 
          setDeals={this.setDeals.bind(this)} />

      </div>
    );
  }
}


export default Owner;