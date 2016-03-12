# DTG(DowntoGO)

## Description

Flatiron School 3-week group project. 

Our project is a rails application where users sign-in with facebook and see current events happening in NYC. After favoriting an event by 'pinning it,' a user is able to search for a date to that particular event. 

## Screenshots

Presentation slides: https://docs.google.com/presentation/d/1jBRzPxzBQ5xWOo3ENKrRr4x6WnJfqaKpaEtYr_JtYPY/edit?usp=sharing

## Background

We created this app because we because we wanted to be challeneged and create an unique and fun project.

## Features

Built on Devise for security. Users only have access to certain areas depending on their permissions. 
Omniauth Facebook. Users can sign in seamlessly.
Inbox - built on mailer gem
Events - Custom events page that has built in tinder-like matching functionality after favoriting the same event.

## Usage

Users sign in to the application on the homepage using facebook.
They have access to their events page and mailbox.
Users can search through events and if they click on an event a modal popup appears with more information. Users can pin (favorite) the event and are then presented with a tinder-like interface to find a date. 
After matching, messaging is enabled, though currently requires a page-refresh.

## Local Installation

1. Clone the repo. 
2. Ensure lines 240-244 of /config/initializers/devise.rb is configured for local. 
3. Migrate and seed the db (creates dummy users who all 'like' you).
4. Sign in with facebook on homepage, update your user profile, then view events and match!
5. Messaging currently requires a page refresh to update. 


## Future

## Authors

Samuel Joli, Steve Koltz, Mendel Blesofsky, Lewis Matos

## License

DTG is MIT Licensed. See LICENSE for details.
