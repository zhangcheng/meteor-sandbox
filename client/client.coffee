MyRouter = Backbone.Router.extend
  routes:
    '': 'home',
    'u/:username': 'profile'

  home: ->
    console.log "route to home"
    store.set 'page', 'home'

  profile: (username) ->
    console.log "route to profile"
    store.set 'page', 'profile'
    store.set 'username', username

Router = new MyRouter

Meteor.startup ->
  Backbone.history.start pushState: true

Template.main.user = ->
  return store.get('user')

Template.main.page = ->
  return store.get('page')

Template.main.events =
  'click .loginButton': (e) ->
    username = $('#username').val()
    if username
      Meteor.call 'login', username, username, (err, result) ->
        console.log err?, result
        store.set 'user', result.user

  'click .logoutButton': (e) ->
    store.remove 'user'

Template.home.users = ->
  Users.find()

Template.profile.user = ->
  if store.get('page') is 'profile'
    Users.findOne {username: store.get('username')}
