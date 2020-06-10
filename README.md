## Introduction
Hi! :) Thank you for allowing me the opportunity to do this take home challenge! I really enjoyed this challenge. Feel free to let me know if there are any issues or concerns regarding this take home challenge. My email is anto.chan101@gmail.com and a good number to reach me is 617-459-0216.

## Installation
There are depencies for this project, more information listed below. Remember to run `pod install` as I used cocoapods! 

## Features

### Landing/Home Page (First Page)
The home page is a simple `UITableView` with it's `TableHeaderView` showing information such as the general location (in this case the Envoy Office), number of results loaded, and total number of results from the Foursquare API based on the query! Each `tableViewCell` is made up of the `VenueTableComponent`, which has a photo from from the `/photos` endpoint, name, location, price tier, distance and ratings.

<img src="https://i.ibb.co/cNxb3Mg/Screen-Shot-2020-06-10-at-3-45-49-AM.png" alt="IMG-1158" width="250" height="500"> <img src="https://i.ibb.co/gV7pdmY/Screen-Shot-2020-06-10-at-3-44-50-AM.png" alt="IMG-1159" width="250" height="500">

## Extra Features on Home Page
1. Pagination feature (Loading 10 venues per page)
2. Extra information on how many venues have been loaded and out of how many
3. On specified queries (more later), we show what query we are using for the current home data. e.g. `Showing 10 out of 48 arts venue within 955 meters` 

<img src="https://i.ibb.co/WpGzz1z/Screen-Shot-2020-06-10-at-3-44-59-AM.png" alt="IMG-1158" width="250" height="500">

### Filter page (Top Right Button)
The filter page is the extra feature I decided to add! On this page there are filter queries such as radius range from the Envoy Office and a category search (coffee, food, shops, arts). You may also notice an extra two `TextFields` containing the `clientId` and `clientSecret`. This is a way to use your own Foursquare keys to test when free API calls have reached the limit.

## Architecture
I decided to go with the **MVVM** pattern

## Libraries
I used a few 3rd party libraries for this take home challenge 
1. `Kingfisher`, used mainly for ease in downloading/caching images through just the `imageURL`. 
2. `IQKeyboardManager`, having used a few textfields in the filter page it makes sure the keyboard is easily dismissable from the view and doesn't block content.
3. `Cosmos`, an easy and efficient way to have customizable star ratings for the star reviews part.

## Tests
I included a few unit tests primarily on the `HomeViewModel`.

## Final Note
Thank you again for taking the time to read over this take home challenge! Again, if there are any questions please feel free to reach out :D Have a great day!
