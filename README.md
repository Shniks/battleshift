# BattleShift

This is a brownfield project that builds upon a pre-existing API implementation of the game Battleship. The game, as implemented, allows a player to play against a computer through an API. We updated the existing project to include multiplayer functionality and basic levels of security.

### Basic Instructions

- Users register for an account
- An email is sent to each user with their unique API key along with a link to activate their account
- Once the account is activated, the users are able to send POST requests using their API keys to create and play a new game

The project specs can be found [here](http://backend.turing.io/module3/projects/battleshift).

### Prerequisites

```
Ruby Version 2.4 or higher
Rails Version 5 or higher
Postgresql
```

### Installation Instructions

Clone this repository into your machine using the following command:
```ruby
git clone git@github.com:pollockcl/battleshift.git
```

Switch into the directory ```battleshift``` and run bundle as follows:
```ruby
bundle
```

Setup the database by running the following commands:
```ruby
rake db:create db:migrate
```

To create users, start the server by entering the following command in your terminal:
```ruby
rails s
```

Click on 'Register' to create a new user and then follow the instructions in the email.


### Authors

[Clee Pollock](https://github.com/pollockcl)  
[Nikhil Shahi](https://github.com/Shniks)
