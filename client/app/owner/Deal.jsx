import React from 'react';

class Deal extends React.Component {
  constructor(props) {
    super(props);
  }

  update() {
    this.props.modifyDeal(this.props.deal);
  }

  render() {
    return (
      <div className="deal card" onClick={this.update.bind(this)}>
        <h3>{this.props.deal.dealname}</h3>
        <p>{this.props.deal.price}</p>
        <p>{this.props.deal.description}</p>
        <p>{this.props.deal.imageurl}</p>
        <p>{this.props.deal.startdate}</p>
        <p>{this.props.deal.starttime}</p>
        <p>{this.props.deal.enddate}</p>
        <p>{this.props.deal.endtime}</p>
      </div>
    );
  }
}


export default Deal;