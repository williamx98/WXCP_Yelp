# Project 3 - WXCP_Yelp

WXCP_Yelp is a Yelp search app using the [Yelp API](http://www.yelp.com/developers/documentation/v2/search_api).

Time spent: 4 hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] Table rows for search results should be dynamic height according to the content height. (3pt)
- [x] Custom cells should have the proper Auto Layout constraints. (+5pt)
- [x] Search bar should be in the navigation bar (doesn't have to expand to show location like the real Yelp app does). (+2pt)

The following **stretch** features are implemented:

- [x] Infinite scroll for restaurant results. (+3pt)
- [ ] Implement map view of restaurant results. (+3pt)
- [x] Implement the restaurant detail page. (+2pt)

The following **additional** features are implemented:

- [x] implented filter by location (not GPS, manual input through a settings page. Not persistent, yet. I have exams)
- [x] "dynamic" navigation bar. Cancel button and filter button will show/hide depending on searchbar focus
- [x] show an alert when a search returns no results
- [x] filter by price

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. adding a price filter feature
2. adding share on social media feature

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='https://github.com/willthexu/WXCP_Yelp/blob/master/advanced.gif' title='Video Walkthrough' width='250' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

The Yelp API will sometimes not have an image url avaible i.e business["image_path"] = "". This is problematic since it's not nil until it's forced unwrapped. Business class has been adjusted accordingly. 

The YelpClient class wasn't setup to allow changing of locations. The default location is San Francisco. I have changed the pre-made YelpClient to allow for extra functionality.  

## License

    Copyright 2018 Will Xu

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
