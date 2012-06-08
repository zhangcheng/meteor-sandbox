Meteor.startup ->
  if Users.find().count() is 0
    Users.insert [
      username: "1"
      password: "1"
    ,
      username: "2"
      password: "2"
    ]

Meteor.publish 'users', ->
  Users.find()

Meteor.methods
  register: (username, password) ->
    user = Users.findOne {username: username}
    unless user
      Users.insert {username: username, password: password}
      Users.findOne {username: username}

  login: (username, password) ->
    user = Users.findOne {username: username}
    if user
      sid = Sessions.insert {uid: user._id}
      delete user.password
      {sid: sid, user: user}

  # active (follower) follow passive (followee)
  follow: (active, passive) ->
    console.log active, " to follow ", passive
    followee = Users.findOne {username: passive}
    if followee.followers
      if active in followee.followers
        return {err: 'already followed'}
    Users.update {username: passive}, {$push: {followers: active}}
    {}

  # active (follower) unfollow passive (followee)
  unfollow: (active, passive) ->
    console.log active, " to unfollow ", passive
    followee = Users.findOne {username: passive}
    if followee.followers
      if active in followee.followers
        Users.update {username: passive}, {$pop: {followers: active}}
        return {}
    return {err: 'not followed'}
