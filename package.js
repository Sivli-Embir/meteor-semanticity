 Package.describe({
  summary: "A triple relationship API for local resources."
});
 
Package.on_use(function (api) {
  api.use('coffeescript', ['client','server'])
  api.use('underscore', ['client','server'])
  api.add_files([
    'lib/semanticity-core.coffee', 
    'lib/semanticity-mock.coffee',
    'lib/semanticity.coffee'
    ], ['client','server']);
});

Package.on_test(function (api) {
  api.use(['semanticity','tinytest', 'test-helpers', 'coffeescript', 'smart-collections'], ['client', 'server']);
  api.add_files(['tests/core-tests.coffee'], ['server']);
});
