const path = require('path');
const models = require('../../../database');

const ownerRoutes = (app, passport) =>{

  const isLoggedIn = (req, res, next) => {
    if (req.isAuthenticated()) {
      return next();
    } else {
      console.log('not logged in');
      return res.redirect('/login');
    }
  };

  app.get('/owner', isLoggedIn,  (req, res, next) => {
    // display owner page
    console.log('GET owner');
    res.sendFile(path.join(__dirname, '../../../client/app/owner/owner.html'));
  });

  app.get('/owner/login', isLoggedIn, (req, res) => {
    res.send(req.user.login);
  });

  app.get('/login', (req, res, next) => {
    // display ownr login page
    console.log('GET login');
    res.sendFile(path.join(__dirname, '../../../client/public/login.html'));
  });

  app.post('/owner/login', 
    passport.authenticate('local-login', {
      successRedirect: '/owner',
      failureRedirect: '/login',
      session: true,
    })
  );

  app.get('/owner/logout', isLoggedIn, (req, res) => {
    console.log('GET owner/logout', req.user);
    req.logout();
    res.redirect('/login');
  });


  // TODO: implement signup
  app.get('/owner/signup', (req, res, next) => {
    // should display owner signup page
    console.log('GET owner/signup');
    res.send('GET owner/signup');
  });

  // TODO: implement signup
  app.post('/owner/signup', 
    passport.authenticate('local-signup', {
      successRedirect: '/owner',
      failureRedirect: '/signup',
      session: true,
    })
  );


  app.get('/owner/restaurants', isLoggedIn, (req, res, next) => {
    console.log('get owner/restaurants of', req.user.login);
    models.getRestaurants(req.user.login)
      .then(result => {
        res.send(result.rows);
      }).catch(err => {
        console.log('err in get restaurants\n', err)
        res.status(401).send();
      })
  });

  app.post('/owner/restaurants', isLoggedIn, (req, res, next) => {
    console.log('post owner restaurants', req.body);
    models.getOwnerByLogin(req.user.login)
      .then(result => {
        return models.saveRestaurant({
          'yelp_api_ID': req.body.YelpID,
          'address': req.body.address,
          'ZIP': req.body.ZIP,
          'type': req.body.type,
          'imageURL': req.body.imageURL,
          'restaurantURL': req.body.restaurantURL,
          'name': req.body.name,
          'owner_ID': result.rows[0].id,
        });
      }).then(result => {
        res.redirect('/owner/restaurants');
      }).catch(err => {
        console.log('err in post restaurant\n', err);
        res.status(401).send();
      });
  });

  app.put('/owner/restaurants', isLoggedIn, (req, res, next) => {
    console.log('put owner restaurants', req.body);
    models.getOwnerByLogin(req.user.login)
      .then(result => {
        return models.updateRestaurant(req.body.prevName, {
          'yelp_api_ID': req.body.YelpID,
          'address': req.body.address,
          'ZIP': req.body.ZIP,
          'type': req.body.type,
          'imageURL': req.body.imageURL,
          'restaurantURL': req.body.restaurantURL,
          'name': req.body.name,
          'owner_ID': result.rows[0].id,
        });
      }).then(result => {
        res.redirect(303, '/owner/restaurants');
      }).catch(err => {
        console.log('err in put restaurant\n', err);
        res.status(401).send();
      });
  });


  app.get('/owner/deals', isLoggedIn, (req, res, next) => {
    console.log('get owner/deals of', req.query.restaurant);
    models.getDealsByRestaurant(req.query.restaurant)
      .then(result => {
        res.send(result.rows);
      })
      .catch(err => {
        console.log('err in get deals\n', err)
        res.status(401).send();
      });
  });

  app.post('/owner/deals', isLoggedIn, (req, res) => {
    console.log('post owner deals', req.body);
    models.getYelpIdByRestaurantName(req.body.restaurant)
      .then(result => {
        return models.saveDeals({
          'yelp_ID': result.rows[0].id,
          'price': req.body.price,
          'dealName': req.body.dealName,
          'description': req.body.description,
          'imageURL': req.body.imageURL,
          'startTime': req.body.startTime,
          'startDate': req.body.startDate,
          'endTime': req.body.endTime,
          'endDate': req.body.endDate,
        });
      }).then((result) => {
        res.redirect('/owner/deals?restaurant='+req.body.restaurant);
      }).catch(err => {
        console.log('error in save deal\n', err);
      });
  });

  app.put('/owner/deals', isLoggedIn, (req, res) => {
    console.log('put owner deals', req.body);
    models.getYelpIdByRestaurantName(req.body.restaurant)
      .then(result => {
        return models.updateDeals(req.body.prevName, {
          'yelp_ID': result.rows[0].id,
          'price': req.body.price,
          'dealName': req.body.dealName,
          'description': req.body.description,
          'imageURL': req.body.imageURL,
          'startTime': req.body.startTime,
          'startDate': req.body.startDate,
          'endTime': req.body.endTime,
          'endDate': req.body.endDate,
        });
      }).then((result) => {
        res.redirect(303, '/owner/deals?restaurant='+req.body.restaurant);
      }).catch(err => {
        console.log('error in update deal\n', err);
      });
  });

  app.get('/owner/cheapitems', isLoggedIn, (req, res, next) => {
    console.log('get owner/cheapitems of', req.query.restaurant)
    models.getCheapItemsByRestaurant(req.query.restaurant)
      .then(result => {
        res.send(result.rows);
      }).catch(err => {
        console.log('error in get owner cheapitems\n', err);
      });
  });

  app.post('/owner/cheapItems', isLoggedIn, (req, res) => {
    console.log('post owner cheapitems', req.body);
    models.getYelpIdByRestaurantName(req.body.restaurant)
      .then(result => {
        return models.saveCheapItems({
          'yelp_ID': result.rows[0].id,
          'price': req.body.price,
          'menuItem': req.body.menuItem,
          'imageURL': req.body.imageURL,
          'description': req.body.description,
        });
      }).then(result => {
        res.redirect('/owner/cheapitems?restaurant='+req.body.restaurant);
      }).catch(err => {
        console.log('error in save cheapItems\n', err);
      });
  });

  app.put('/owner/cheapItems', isLoggedIn, (req, res) => {
    console.log('put owner cheapitems', req.body);
    models.getYelpIdByRestaurantName(req.body.restaurant)
      .then(result => {
        console.log('owner cheapItem update!!!!!')
        return models.updateCheapItems(req.body.prevName, {
          'yelp_ID': result.rows[0].id,
          'price': req.body.price,
          'menuItem': req.body.menuItem,
          'imageURL': req.body.imageURL,
          'description': req.body.description,
        });
      }).then(result => {
        res.redirect(303, '/owner/cheapitems?restaurant='+req.body.restaurant);
      }).catch(err => {
        console.log('error in update cheapItems\n', err);
      });
  });

}

module.exports = ownerRoutes;



