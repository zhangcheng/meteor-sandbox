var Store = function () {};

Store.set = function (name, value) {
  amplify.store(name, value);
  Session.set(name, value);
};

Store.get = function (name) {
  Session.set(name, amplify.store(name));
  return Session.get(name);
};