// Give our package a description
Package.describe({
  summary: "A triple relationship API for local resources."
});

// Tell Meteor what to do with our package at bundle time
Package.on_use(function (api) {
  api.use('coffeescript', 'server')
  api.use('underscore', 'server')
  api.add_files(['aa_semanticity.coffee', 'getters.coffee'], 'server');
});
