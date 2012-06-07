MyRouter = Backbone.Router.extend
  routes:
    '': 'home',
    'u/:username': 'profile'

  home: ->
    console.log "route to home"
    Session.set 'page', 'home'

  profile: (username) ->
    console.log "route to profile"
    Session.set 'page', 'profile'

Router = new MyRouter

Meteor.startup ->
  Backbone.history.start pushState: true

Template.main.user = ->
  return store.get('user')

Template.main.events =
  'click .loginButton': (e) ->
    username = $('#username').val()
    if username
      Meteor.call 'login', username, username, (err, result) ->
        console.log err?, result
        store.set 'user', result.user

  'click .logoutButton': (e) ->
    store.remove 'user'
