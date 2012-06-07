MyRouter = Backbone.Router.extend
  routes:
    "": "home",

  home: ->
    Session.set('page', 'home');

Router = new MyRouter

Meteor.startup ->
  Backbone.history.start pushState: true
  Meteor.call 'login', '1', '1', (err, result) ->
    console.log err?, result
    Session.set 'user', result.user

Template.main.user = ->
  return Session.get('user')