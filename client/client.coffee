MyRouter = Backbone.Router.extend
  routes:
    '': 'home',
    'u/:username': 'profile'

  home: ->
    console.log "route to home"
    showPage Template.users;

  profile: (username) ->
    console.log "route to profile"
    Session.set 'username', username
    showPage Template.profile;

Meteor.startup ->
  Store.get 'login'
  Meteor.subscribe 'users'
  Router = new MyRouter
  Backbone.history.start pushState: true

Template.user.is_logged_in = ->
  Session.get('login')

Template.user.username = ->
  Session.get('login').username

Template.user.events =
  'click #user .register': (e) ->
    username = $('#user .name').val()
    if username
      Meteor.call 'register', username, username, (err, result) ->
        console.log "register"

  'click #user .login': (e) ->
    username = $('#user .name').val()
    if username
      Meteor.call 'login', username, username, (err, result) ->
        Store.set 'login', result.user

  'click #user .logout': (e) ->
    Store.set 'login', null

showPage = (page) ->
  $('#page').html Meteor.ui.render -> page()

Template.users.users = ->
  Users.find()

Template.profile.profile = ->
  Users.findOne username: Session.get('username')

Template.profile.is_oneself = ->
  thatuser = Users.findOne username: Session.get('username')
  thatuser._id is Session.get('login')._id

Template.profile.is_followed = ->
  thatuser = Users.findOne username: Session.get('username')
  if thatuser.followers
    Session.get('login').username in thatuser.followers
  else
    false

Template.profile.events =
  'click #profile .follow': (e) ->
    Meteor.call 'follow', Session.get('login').username, Session.get('username'), (err, result) ->
      console.log "result: ", result

  'click #profile .unfollow': (e) ->
    Meteor.call 'unfollow', Session.get('login').username, Session.get('username'), (err, result) ->
      console.log "result: ", result

  'click #profile .pm': (e) ->
    msg = 'Greeting from ' + Session.get('login').username + ' to ' + Session.get('username')
    Meteor.call 'pm', Session.get('login').username, Session.get('username'), msg, (err, result) ->
      console.log "result: ", result
