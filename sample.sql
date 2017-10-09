
DROP TABLE IF EXISTS Deals cascade;
DROP SEQUENCE IF EXISTS Deals_seq;
CREATE SEQUENCE Deals_seq;

CREATE TABLE Deals (
  id INTEGER NOT NULL DEFAULT NEXTVAL ('Deals_seq'),
  yelp_ID INTEGER,
  price DECIMAL(4, 2),
  dealName VARCHAR(50),
  description TEXT,
  imageURL VARCHAR(150),
  startDate DATE,
  startTime TIME,
  endDate DATE,
  endTime TIME,
  PRIMARY KEY (id)
);

-- ---
-- Table 'CheapItems'
-- 
-- ---

DROP TABLE IF EXISTS CheapItems cascade;
DROP SEQUENCE IF EXISTS CheapItems_seq;
CREATE SEQUENCE CheapItems_seq;

CREATE TABLE CheapItems (
  id INTEGER NOT NULL DEFAULT NEXTVAL ('CheapItems_seq'),
  yelp_ID INTEGER,
  price DECIMAL(4, 2),
  menuItem VARCHAR(100),
  imageURL VARCHAR(150),
  description TEXT,
  PRIMARY KEY (id)
);

-- ---
-- Table 'Owners'
-- 
-- ---

DROP TABLE IF EXISTS Owners cascade;
DROP SEQUENCE IF EXISTS Owners_seq;
CREATE SEQUENCE Owners_seq;

CREATE TABLE Owners (
  id INTEGER NOT NULL DEFAULT NEXTVAL ('Owners_seq'),
  login CHAR(30),
  password CHAR(60),
  PRIMARY KEY (id)
);

-- ---
-- Table 'YelpData'
-- 
-- ---

DROP TABLE IF EXISTS YelpData cascade;
DROP SEQUENCE IF EXISTS YelpData_seq;
CREATE SEQUENCE YelpData_seq;

CREATE TABLE YelpData (
  id INTEGER NOT NULL DEFAULT NEXTVAL ('YelpData_seq'),
  yelp_api_ID VARCHAR(100),
  address TEXT,
  ZIP INTEGER,
  type VARCHAR(100),
  imageURL VARCHAR,
  restaurantURL VARCHAR,
  owner_ID INTEGER,
  name VARCHAR,
  PRIMARY KEY (id)
);

-- ---
-- Table 'Users'
-- 
-- ---

DROP TABLE IF EXISTS Users cascade;
DROP SEQUENCE IF EXISTS Users_seq;
CREATE SEQUENCE Users_seq;

CREATE TABLE Users (
  id INTEGER NOT NULL DEFAULT NEXTVAL ('Users_seq'),
  login VARCHAR(30),
  password VARCHAR(60),
  cheapitem_id INTEGER,
  PRIMARY KEY (id)
);

-- ---
-- Foreign Keys 
-- ---

ALTER TABLE Deals ADD FOREIGN KEY (yelp_ID) REFERENCES YelpData (id);
ALTER TABLE CheapItems ADD FOREIGN KEY (yelp_ID) REFERENCES YelpData (id);
ALTER TABLE YelpData ADD FOREIGN KEY (owner_ID) REFERENCES Owners (id);
ALTER TABLE Users ADD FOREIGN KEY (cheapitem_id) REFERENCES CheapItems (id);


INSERT INTO YelpData(yelp_api_ID, address, ZIP, type, imageURL, restaurantURL, name)
VALUES ('tú-lan-san-francisco-4', '8 6th St\nSan Francisco, CA 94013', 94103, 'Vietnamese', 'http://bit.ly/2ggP5Rz', 'http://tulan-vn-restaurant.com', 'Tu Lan');

INSERT INTO YelpData(yelp_api_ID, address, ZIP, type, imageURL, restaurantURL, name)
VALUES ('the-flying-falafel-san-francisco-3', '1051 Market St\nSan Francisco, CA 94013', 94013, 'Vegan', 'http://bit.ly/2xZrTyG', 'http://flyingfalafel.com', 'The Flying Falafel');

INSERT INTO YelpData(yelp_api_ID, address, ZIP, type, imageURL, restaurantURL, name)
VALUES ('box-kitchen-san-francisco', '431 Natoma St.\nSan Francisco, CA 94013', 94103, 'American', 'http://bit.ly/2ytyFA7', 'http://boxkitchensf.com', 'Box Kitchen');

INSERT INTO YelpData(yelp_api_ID, address, ZIP, type, imageURL, restaurantURL, name)
VALUES ('kaisen-sushi-san-francisco', '71 5th St.\nSan Francisco, CA 94013', 94013, 'Japanese', 'http://bit.ly/2z1PKhB', 'https://www.yelp.com/biz/kaisen-sushi-san-francisco', 'Kaisen Sushi');

INSERT INTO YelpData(yelp_api_ID, address, ZIP, type, imageURL, restaurantURL, name)
VALUES ('dotties-true-blue-cafe-san-francisco', '28 6th St.\nSan Francisco, CA 94013', 94103, 'American', 'http://bit.ly/2fVISxl', 'http://dottiestruebluesf.com', 'Dottie''s True Blue Cafe');

INSERT INTO YelpData(yelp_api_ID, address, ZIP, type, imageURL, restaurantURL, name)
VALUES ('el-picacho-san-francisco', '1601 Mission St.\nSan Francisco, CA 94013', 94103, 'Mexican', 'https://s3-media3.fl.yelpcdn.com/bphoto/hkrI6eSKnPOEqsIYV2gUKA/o.jpg', 'http://elpicachofoodtruck.com', 'El Picacho');

INSERT INTO YelpData(yelp_api_ID, address, ZIP, type, imageURL, restaurantURL, name)
VALUES ('pho-hour-san-francisco', '1114 Bryant St.\nSan Francisco, CA 94013', 94103, 'Vietnamese', 'https://s3-media1.fl.yelpcdn.com/bphoto/dTAOPhMsBkHl55bVnJqFPw/o.jpg', 'https://www.yelp.com/biz/pho-hour-san-francisco?osq=Restaurants', 'Pho Hour');

INSERT INTO YelpData(yelp_api_ID, address, ZIP, type, imageURL, restaurantURL, name)
VALUES ('wafl-san-francisco-2', '135 4th St.\nSan Francisco, CA 94013', 94103, 'Waffles', 'https://s3-media3.fl.yelpcdn.com/bphoto/CcGr_txbEXncEnM9jxqzPw/o.jpg', 'https://www.yelp.com/wafl-san-francisco-2', 'Wafl');

INSERT INTO YelpData(yelp_api_ID, address, ZIP, type, imageURL, restaurantURL, name)
VALUES ('frena-san-francisco-3', '132 6th St.\nSan Francisco, CA 94013', 94103, 'Bakery', 'https://s3-media3.fl.yelpcdn.com/bphoto/aVjHuyHA3kjg26msJHb_xA/o.jpg', 'https://www.frenabakery.com', 'Frena Kosher Savory Baked Goods');

INSERT INTO YelpData(yelp_api_ID, address, ZIP, type, imageURL, restaurantURL, name)
VALUES ('the-melt-san-francisco-9', '925 Market St.\nSan Francisco, CA 94013', 94103, 'American', 'https://s3-media1.fl.yelpcdn.com/bphoto/sqhIal4UaKQmfGMbran_Mw/o.jpg', 'http://themelt.com', 'The Melt');

INSERT INTO YelpData(yelp_api_ID, address, ZIP, type, imageURL, restaurantURL, name)
VALUES ('freshroll-vietnamese-rolls-and-bowls-san-francisco', '157 4th St.\nSan Francisco, CA 94013', 94103, 'Vietnamese', 'https://s3-media3.fl.yelpcdn.com/bphoto/Ds_7g32gpJqgW8tPcIisEA/o.jpg', 'http://eatatfreshroll.com', 'Freshroll Vietnamese Rolls & Bowls');


INSERT INTO owners (login, password) VALUES ('dottie',         '$2a$10$GkOsXnKFkDJdCvrcwqdeQ.IJwMi1L7Awt/ASLqqC90l6ChDEoDAEa'); -- dottie123!
INSERT INTO owners (login, password) VALUES ('tulan',          '$2a$10$r77J3S7bQwGXVshMEE8mN.J9nD2gVrxCI8TGx.SjO7dwgZbSCol1y'); -- tulangood
INSERT INTO owners (login, password) VALUES ('tworestaurants', '$2a$10$BfLR2MqVeKmfasaB/aeVxeqxgjH6aEgDR17or0mxl910MlEsloXrS'); -- 22
INSERT INTO owners (login, password) VALUES ('kaisen',         '$2a$10$6o/yeGO/MKeuavMJQa/HK.rCSkC8bkUJQYhd2hHZNHIqsHgwFLb0.'); -- kaisenkaisen
INSERT INTO owners (login, password) VALUES ('picacho',        '$2a$10$Npup.GRZnplibo3ZT1xJ1uadMbSCzs/1UgOFZOzRDuLJtZPpXleB6'); -- picacho
INSERT INTO owners (login, password) VALUES ('phohour',        '$2a$10$puQ3fPJWAcKZjzjlq9lOAuapzMj5XL5Nq.MQ7DdTgZRfMyctBLSQ.'); -- dj39983
INSERT INTO owners (login, password) VALUES ('wafl',           '$2a$10$CD5H1jOnVGKjN0GO0mJDU.Jj0jUHzXlB2VA7web3gadqlN3FMH4B.'); -- good
INSERT INTO owners (login, password) VALUES ('owner',          '$2a$10$lJFMYteYbQpeJTzCB1uSgewo.aAabLRY3kgtqXLFgPaOzkA5zrzSS'); -- owner
INSERT INTO owners (login, password) VALUES ('admin',          '$2a$10$55mkTRQa0LbF2zHD.zA4fujC93IGIKZRvovSCQFpDpl/aBfYjBBsK'); -- admin



UPDATE yelpdata SET owner_id = 1 where id = 5;
UPDATE yelpdata SET owner_id = 2 where id = 1;
UPDATE yelpdata SET owner_id = 3 where id = 2;
UPDATE yelpdata SET owner_id = 3 where id = 3;
UPDATE yelpdata SET owner_id = 4 where id = 4;
UPDATE yelpdata SET owner_id = 5 where id = 6;
UPDATE yelpdata SET owner_id = 6 where id = 7;
UPDATE yelpdata SET owner_id = 7 where id = 8;
UPDATE yelpdata SET owner_id = 8 where id = 9;
UPDATE yelpdata SET owner_id = 8 where id = 10;
UPDATE yelpdata SET owner_id = 8 where id = 11;




INSERT INTO Deals (yelp_ID, price, dealName, description, imageURL, startDate, startTime, endDate, endTime)
VALUES (4, 4.00, '$4 Appetizers', 'Gyoza, takoyaki, hand rolls and more!', 'http://bit.ly/2wBXPHY', '2017-10-09', '17:00', '2017-10-09', '19:30');

INSERT INTO Deals (yelp_ID, price, dealName, description, imageURL, startDate, startTime, endDate, endTime)
VALUES (2, 6.50, '$6.50 Flying Falafel', '$1 off our famous flying falafel pocket sandwich after 2pm', 'http://bit.ly/2xZrTyG', '2017-10-09', '14:00', '2017-10-09', '16:30');

INSERT INTO Deals (yelp_ID, price, dealName, description, imageURL, startDate, startTime, endDate, endTime)
VALUES (3, 10.50, 'Box Burger Special', 'Until 7pm, sink your teeth into our famous Box Burger with fries or salad for just $10', 'http://bit.ly/2xm26E0', '2017-10-09', '16:00', '2017-10-09', '19:00');

INSERT INTO Deals (yelp_ID, price, dealName, description, imageURL, startDate, startTime, endDate, endTime)
VALUES (5, 5.00, 'Muffin & coffee', 'Enjoy one of Dottie''s fresh-baked breakfast treats and coffee.', 'https://s3-media2.fl.yelpcdn.com/bphoto/tv_cKH8_3yMMwNA3EuktTA/348s.jpg', '2017-10-10', '06:00', '2017-10-10', '08:30');

INSERT INTO Deals (yelp_ID, price, dealName, description, imageURL, startDate, startTime, endDate, endTime)
VALUES (1, 7.00, 'Late night noodle soup', 'Any noodle soup only $7 after 8pm tonight', 'https://s3-media1.fl.yelpcdn.com/bphoto/lLrHtblYyL8PCp-IMygXBw/o.jpg', '2017-10-09', '20:00', '2017-10-09', '22:00');

INSERT INTO Deals (yelp_ID, price, dealName, description, imageURL, startDate, startTime, endDate, endTime)
VALUES (6, 2.00, '$2 tacos from 2-4pm', 'Tacos only $2 each, your choice of meat, onion, and cilantro', 'https://s3-media3.fl.yelpcdn.com/bphoto/hkrI6eSKnPOEqsIYV2gUKA/o.jpg', '2017-10-09', '14:00', '2017-10-09', '16:00');

INSERT INTO Deals (yelp_ID, price, dealName, description, imageURL, startDate, startTime, endDate, endTime)
VALUES (7, 7.25, 'Goi Ga Special after 2pm', 'Vietnamese-style chicken salad', 'https://i.ytimg.com/vi/qbQ5P3Okwkc/maxresdefault.jpg', '2017-10-09', '14:00', '2017-10-09', '22:00');

INSERT INTO Deals (yelp_ID, price, dealName, description, imageURL, startDate, startTime, endDate, endTime)
VALUES (7, 7.25, 'Goi Tom Thit Special after 2pm', 'Vietnamese-style shrimp and pork salad', 'https://d97hxkt8a8b5r.cloudfront.net/image-assets/152/52943/image.jpg', '2017-10-09', '14:00', '2017-10-09', '22:00');

INSERT INTO Deals (yelp_ID, price, dealName, description, imageURL, startDate, startTime, endDate, endTime)
VALUES (8, 6.99, 'Waffle Wednesday', 'Any sweet or savory Hong Kong style waffle only $6.99 on Wednesdays', 'https://s3-media3.fl.yelpcdn.com/bphoto/CcGr_txbEXncEnM9jxqzPw/o.jpg', '2017-10-11', '10:00', '2017-10-11', '21:00');

INSERT INTO Deals (yelp_ID, price, dealName, description, imageURL, startDate, startTime, endDate, endTime)
VALUES (9, 9.00, 'Burkekas and Turkish Coffee', 'Savory pastry filled with cheese, spinach or green olives, and our delicious Turkish coffee', 'https://s3-media1.fl.yelpcdn.com/bphoto/blD2gB86AzACHCyJBuYGEQ/o.jpg', '2017-10-09', '07:30', '2017-10-09', '10:00');

INSERT INTO Deals (yelp_ID, price, dealName, description, imageURL, startDate, startTime, endDate, endTime)
VALUES (10, 0.00, 'Free soft serve', 'Create an online ordering account at themelt.com and get a free soft serve ice cream', 'https://s3-media2.fl.yelpcdn.com/bphoto/fIa1P6-IUWbkLAuveg4slQ/o.jpg', '2017-10-01', '11:00', '2017-12-31', '22:00');

INSERT INTO Deals (yelp_ID, price, dealName, description, imageURL, startDate, startTime, endDate, endTime)
VALUES (11, 3.00, 'Freshroll Fridays', 'Every Friday, our Freshrolls are $3 each. Maxiumum 3 per customer.', 'https://s3-media1.fl.yelpcdn.com/bphoto/gafPBKrM13azie9Qruavsw/o.jpg', '2017-10-13', '11:00', '2017-10-13', '21:00');

INSERT INTO Deals (yelp_ID, price, dealName, description, imageURL, startDate, startTime, endDate, endTime)
VALUES (5, 9.99, 'Bloody Mary and Eggs', 'Join us Sunday for Soju Bloody Mary and eggs.', 'https://s3-media2.fl.yelpcdn.com/bphoto/EhIU9rlshiTdvMJnEOYqnA/o.jpg', '2017-10-14', '07:00', '2017-10-14', '11:00');

INSERT INTO Deals (yelp_ID, price, dealName, description, imageURL, startDate, startTime, endDate, endTime)
VALUES (3, 0.00, 'Free sliders on Monday!', 'Try our new sliders for free this Monday, October 9, from 5-9pm with any drink purchase', 'https://media-cdn.tripadvisor.com/media/photo-s/0c/ca/9b/9c/house-smoked-beef-brisket.jpg', '2017-10-09', '17:00', '2017-10-09', '21:00');

INSERT INTO Deals (yelp_ID, price, dealName, description, imageURL, startDate, startTime, endDate, endTime)
VALUES (9, 1.00, '$1 bagels after 3pm', 'Pick up your morning bagel the day before for only $1 each. Choose from Jerusalem Sesame, Onion, or Romania (based on supply).', 'https://s3-media4.fl.yelpcdn.com/bphoto/HHSm5DFhBm5UmKeFhvRc9A/o.jpg', '2017-10-09', '20:00', '2017-10-09', '22:00');



INSERT INTO CheapItems (yelp_ID, price, menuItem, imageURL, description)
VALUES (2, 6.00, 'Hummus Saucer', 'http://bit.ly/2ys7FAM', 'A bed of hummus dip with veggies and warm pita. Gluten-free.');

INSERT INTO CheapItems (yelp_ID, price, menuItem, imageURL, description)
VALUES (2, 9.70, 'Super Combo #2: Falafel and organic juice', 'http://bit.ly/2ys7FAM', 'Enjoy our famous falafel pocket or platter with fresh organic juice.');

INSERT INTO CheapItems (yelp_ID, price, menuItem, imageURL, description)
VALUES (4, 9.00, 'Crunchy Spicy Salmon/Tuna Roll', 'http://bit.ly/2yLzT5D', 'Spicy salmon or tuna roll with avocado and crispy tempura bits.');

INSERT INTO CheapItems (yelp_ID, price, menuItem, imageURL, description)
VALUES (5, 8.75, 'Eggs, home fries and toast', 'https://s3-media2.fl.yelpcdn.com/bphoto/Xrk1v9TvKTBEOIR3uYW6kg/348s.jpg', 'Two eggs, any way you like, with home fries and toast');

INSERT INTO CheapItems (yelp_ID, price, menuItem, imageURL, description)
VALUES (5, 8.95, 'Black bean chili and cornbread', 'https://foodtoglow.files.wordpress.com/2011/09/dsc_0024.jpg', 'Vegetarian black bean chili topped with cheese and onions and served with grilled chili-cheddar corn bread');

INSERT INTO CheapItems (yelp_ID, price, menuItem, imageURL, description)
VALUES (1, 8.95, 'Ginger Chicken', 'http://www.foodhoe.com/wp-content/uploads/2014/01/tulan_gingerchicken2.jpg', 'Vietnamese ginger chicken with steamed rice.');

INSERT INTO CheapItems (yelp_ID, price, menuItem, imageURL, description)
VALUES (3, 10.00, 'Tempest', 'http://bit.ly/2kq8kfQ', 'Fried egg, cheddar, heirloom tomato, kale, sriracha aioli, english muffin. Served with fries or house salad.');

INSERT INTO CheapItems (yelp_ID, price, menuItem, imageURL, description)
VALUES (6, 8.75, 'Burrito', 'https://s3-media3.fl.yelpcdn.com/bphoto/r1YT8SEWb5mVkdQ7yvpUvQ/o.jpg', 'Your choice of meat, rice, beans, pico de gallo, and salsa');

INSERT INTO CheapItems (yelp_ID, price, menuItem, imageURL, description)
VALUES (6, 7.50, 'Three Tacos', 'https://s3-media3.fl.yelpcdn.com/bphoto/hkrI6eSKnPOEqsIYV2gUKA/o.jpg', 'Your choice of meat, onion and cilantro');

INSERT INTO CheapItems (yelp_ID, price, menuItem, imageURL, description)
VALUES (7, 7.75, 'Pho Doc Biet', 'https://s3-media1.fl.yelpcdn.com/bphoto/dTAOPhMsBkHl55bVnJqFPw/o.jpg', 'Combo beef noodle soup');

INSERT INTO CheapItems (yelp_ID, price, menuItem, imageURL, description)
VALUES (7, 8.75, 'Bun Cha Gio Tom Nuong', 'http://www.phocowcali.com/wp-content/uploads/2012/04/48-bun-cha-gio-tom-nuong-988x617.jpg', 'BBQ Shrimp and Egg Roll with Vermicelli');

INSERT INTO CheapItems (yelp_ID, price, menuItem, imageURL, description)
VALUES (7, 5.05, 'Banh Mi Thit Nuong', 'https://s3-media2.fl.yelpcdn.com/bphoto/W9ZFYrO1M-Nv4uNnOlsQFw/o.jpg', 'Vietnamese-style pork sandwich');

INSERT INTO CheapItems (yelp_ID, price, menuItem, imageURL, description)
VALUES (8, 4.49, 'Waffledog', 'https://s3-media2.fl.yelpcdn.com/bphoto/O0lElNnMzu_PGHHqUPxm2w/o.jpg', 'Hong Kong style waffle wrapped around delicious sausage. 4.49 each or 2 for 7.49');

INSERT INTO CheapItems (yelp_ID, price, menuItem, imageURL, description)
VALUES (8, 5.99, 'Caesar Wafflepizza', 'https://s3-media3.fl.yelpcdn.com/bphoto/CcGr_txbEXncEnM9jxqzPw/o.jpg', 'Cherry tomatoes, lettuce, chicken breast, two types of cheese');

INSERT INTO CheapItems (yelp_ID, price, menuItem, imageURL, description)
VALUES (9, 7.99, 'Sambusak', 'https://s3-media2.fl.yelpcdn.com/bphoto/dXjkVeRTAgfeM3ewWyaZSw/o.jpg', 'Choose from nine different varieties of our delicious Frena savory pastries');

INSERT INTO CheapItems (yelp_ID, price, menuItem, imageURL, description)
VALUES (9, 7.99, 'Egg in the Basket with Mushrooms', 'https://s3-media4.fl.yelpcdn.com/bphoto/3-e_PhpAWQ0zamtfq-0z4Q/o.jpg', 'Classic shakshouka in a flat pastry with mushrooms and herbs.');

INSERT INTO CheapItems (yelp_ID, price, menuItem, imageURL, description)
VALUES (10, 4.99, 'Kids Meals for all ages', 'https://d2nf1zwnhfx4nb.cloudfront.net/3875/kid_kid_popup_choice.jpg?1495112549', 'Choose from Grilled Cheese, Cheese Burger, Mac n Cheese, or Chicken Caesar Salad. Served with apple slices.');

INSERT INTO CheapItems (yelp_ID, price, menuItem, imageURL, description)
VALUES (10, 7.49, 'Steak & Cheese', 'https://d2nf1zwnhfx4nb.cloudfront.net/3892/6115-cheesesteak-popup_standard-160510.jpg?1495112565', 'Our take on Philly-s favorite—Angus sirloin, cheddar, grilled onions, pickled jalapenos.');

INSERT INTO CheapItems (yelp_ID, price, menuItem, imageURL, description)
VALUES (11, 3.99, 'Freshroll', 'https://s3-media1.fl.yelpcdn.com/bphoto/gafPBKrM13azie9Qruavsw/o.jpg', 'One of our special rice paper wrapped rolls with your choice of Protein and Vegetable fillings. Three for 9.49.');

INSERT INTO CheapItems (yelp_ID, price, menuItem, imageURL, description)
VALUES (11, 9.49, 'Meat, Veggie, or Shrimp Bowl', 'https://s3-media3.fl.yelpcdn.com/bphoto/JVARF5wPgzVWdGcowKdKgw/o.jpg', 'Build your own bowl of fresh lemongrass pork, grilled chicken, tofu or garlic shrimp with veggies, herbs, and choice of sauce');



