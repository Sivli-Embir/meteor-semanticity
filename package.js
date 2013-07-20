// Give our package a description
Package.describe({
  summary: "A triple relationship API for local resources."
});

// Tell Meteor what to do with our package at bundle time
Package.on_use(function (api) {
  api.use('coffeescript', 'server')
  api.use('underscore', 'server')
  api.add_files(['$semanticity.coffee', 'queries.coffee'], 'server');
});

Package.on_test(function (api) {
  api.use(['semanticity','tinytest', 'test-helpers', 'coffeescript', 'smart-collections'], ['client', 'server']);
  api.add_files(['tests/core-tests.coffee', 'tests/query-tests.coffee'], ['server']);
});
