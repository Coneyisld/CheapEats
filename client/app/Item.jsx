import React from 'react';

const Item = (props) => (
     
    <div className="col-6 col-lg-4" >
      <h3>{props.data.dealname}</h3>
      <img src={props.data.imageurl} id="dealOfDayImg" />
      <p className="lead"> price: ${props.data.price}</p>
      <p className="lead"> description: ${props.data.description}</p>
      <p className="lead"> Expires @ {props.data.endtime}</p>
      <hr />
    </div>

)


export default Item