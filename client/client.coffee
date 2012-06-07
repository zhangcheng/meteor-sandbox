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
  store.get('user')

Template.main.current_page_is = (page) ->
  store.get('page') is page

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

Template.profile.is_oneself = ->
  store.get('user').username is store.get('username')

Template.profile.thisuser = ->
  Users.findOne {username: store.get('username')}

Template.profile.is_followed = ->
  false
