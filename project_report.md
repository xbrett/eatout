# Project Report
## EatOut

## Meta
Who was on your team?

* Brett Adcock and Binh Le

What's the URL of your deployed app?

* https://eatout.foolsparadice.com

What's the URL of your github repository for your  app?

* https://github.com/xbrett/eatout

Is your app deployed and working?

* Yes.

For each team member, what work did that person do on the project?

### Brett
- Login and Registration
- Restaurant explore page
- User profiles 
- Reviews pages
- Google location API access

### Binh
- Chat via channels
  - Live updates
- Friends pages
  - Friend request and accept

### Togther
- Polishing clickthroughs
- Deployment
- Presentation prep

## App
What does your final app do?

* Eat out is a social media platform based around going out
to eat. Users can sign up, explore restaurants around them,
see user reviews, make friends and chat with one another.

How do users interact with your application?

* Users browse through the site like a traditional social media platform.
Page by page navigation via buttion clicks.

What can they accomplish by doing so?

* Users can explore restaurants to visit, and judge them based off of the
reviews of others. Users can also create reviews for restaurants they 
have visited and browse others' profiles to see thier reviews and friends.
Users can also browse friends, add/delete them, as well as live chat with
them.

For each project requirement above, how does your app meet that?

Our project is ambitious in creating a small scale social media platform
- Find nearby restaurants
- See details about the restaurant
- See user reviews about the restaurants
- Find friends with similar interests
- Chat with friends, and make plans

Our server side logic is in Elixir / Phoenix.

Our application has significant server-side logic:
 - EatOut was designed primarily as a server-side application.
    - HTML is generatd by the sever
    - Server makes requests to Google Places API
 - All chat messages are stored in our database.
 - Restaurant reviews are updated and stored on the server.


Our app is deployed to Brett's VPS.

We do not have any assets from CDNs.

Our app handles user accounts and stores them locally.

Users, Reviews, Chats, and Friends are stored in a PostGres database.

Our app uses the Google Places API.

Accessing the API is done server side.

Our app users Phoenix Channels for our chat system.
- Client messages are sent to the server which broadcast
- to the receiver in real-time.

We have worked with a 2 person team and all have contributed.

* What interesting stuff does your app include?

We included different pages for each restaurant,
and compiled reviews for each user on thier profile.

* What's the complex part of your app?


* What was the most significant challenge?

We believe our most significant challenge was figuring out the 
proper way to pass data around from the front end to the back end.
We struggled getting the geolocation data from the browser. Initially
we attempted to do this via an AJAX request on page load, but found
it difficult to get this implemented efficiently. We instead chose to
set the geolocation data in cookies and check to make sure they are
set on page load and accessable on the server in the connection.