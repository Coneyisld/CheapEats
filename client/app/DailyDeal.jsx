import React from 'react';

const DailyDeal = (props) => (
<div>

<div className="jumbotron jumbotron-fluid" id="mainImg">
  <div className="container">
      <h1 className="display-3">Deal Of the Day!</h1>
  	<div id="mainBorder">
      <h2>{props.data[0].dealname}</h2>
      <img src={props.data[0].imageurl} id="dealOfDayImg" />
      <p className="lead"> price: ${props.data[0].price}</p>
      <p className="lead">description: {props.data[0].description}</p>
    </div>
  </div>
</div>

</div>
)


export default DailyDeal;