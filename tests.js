semanticity = new Semanticity();

Tinytest.add('Semanticity - new Semanticity', function (test) {
  test.instanceOf(semanticity, Semanticity)
  test.instanceOf(semanticity.collection, Meteor.Collection)
});

Tinytest.add('Semanticity - can have more then one instance of Semanticity', function (test) {
  s1 = new Semanticity('1_test')
  s2 = new Semanticity('2_test')
  test.instanceOf(s1, Semanticity)
  test.instanceOf(s2, Semanticity)
});

Tinytest.add('Semanticity - collection name should default to semanticity_sets', function (test) {
  test.equal(semanticity.collection._name, 'semanticity_sets')
});

Tinytest.add('Semanticity - collection name can be changes', function (test) {
  s = new Semanticity('3_test')
  test.equal(s.collection._name, '3_test')
});

Tinytest.add('Semanticity - Semanticity.create', function (test) {
  id = semanticity.create({col: 'sub',id: 'adfjksajkl'}, 'predicate', {col: 'sub',id:'adfjksajkl'})
  test.equal(id, semanticity.collection.findOne()._id)
});
