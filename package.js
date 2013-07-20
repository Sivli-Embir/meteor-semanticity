 Package.describe({
  summary: "A triple relationship API for local resources."
});
 
Package.on_use(function (api) {
  api.use('coffeescript', 'server')
  api.use('underscore', 'server')
  api.add_files(['$semanticity.coffee', 'api.coffee'], 'server');
});

Package.on_test(function (api) {
  api.use(['semanticity','tinytest', 'test-helpers', 'coffeescript', 'smart-collections'], ['client', 'server']);
  api.add_files(['tests/core-tests.coffee', 'tests/query-tests.coffee'], ['server']);
});
