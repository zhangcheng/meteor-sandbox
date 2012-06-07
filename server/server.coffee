Meteor.startup ->
  if Users.find().count() is 0
    Users.insert [
      username: "1"
      password: "1"
    ,
      username: "2"
      password: "2"
    ]

Meteor.methods
  login: (username, password) ->
    user = Users.findOne {username: username}
    if user
      sid = Sessions.insert {uid: user._id}
      delete user.password
      {sid: sid, user: user}