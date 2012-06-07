MyRouter = Backbone.Router.extend
  routes:
    "": "home",

  home: ->
    Session.set('page', 'home');

Router = new MyRouter

Meteor.startup ->
  Backbone.history.start pushState: true

Template.main.user = ->
  return Session.get('user')

Template.main.events =
  'click .loginButton': (e) ->
    username = $('#username').val()
    if username
      Meteor.call 'login', username, username, (err, result) ->
        console.log err?, result
        Session.set 'user', result.user

  'click .logoutButton': (e) ->
    Session.set 'user', null
