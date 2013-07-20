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

Tinytest.add('Semanticity - collection name can be changed', function (test) {
  s = new Semanticity('3_test')
  test.equal(s.collection._name, '3_test')
});

Tinytest.add('Semanticity - Semanticity.create should create a valid triple', function (test) {
  id = semanticity.create({col: 'sub',id: 'adfjksajkl'}, 'predicate', {col: 'sub',id:'adfjksajkl'})
  test.equal({"subject":{"col":"sub","id":"adfjksajkl"},"predicate":"predicate","target":{"col":"sub","id":"adfjksajkl"},"_id":id}, semanticity.collection.findOne(id))
});

Tinytest.add('Semanticity - Semanticity.create should not create a triple if field not given', function (test) {
  //subject col
  test.throws(function () {
    semanticity.create({id: 'adfjksajkl'}, 'string', {col: 'sub', id:'adfjksajkl'})
  })
  //subject id
  test.throws(function () {
    semanticity.create({col: 'sub'}, 'string', {col: 'sub', id:'adfjksajkl'})
  })
  //predicate
  test.throws(function () {
    semanticity.create({col: 'sub', id: 'sub'}, {}, {col: 'sub',id:'adfjksajkl'})
  })
  //target col
  test.throws(function () {
    semanticity.create({col: 'sub', id: 'adfjksajkl'}, 'string', {id:'adfjksajkl'})
  })
  //target id
  test.throws(function () {
    semanticity.create({col: 'sub', id: 'adfjksajkl'}, 'string', {col: 'sub'})
  })
});

Tinytest.add('Semanticity - Semanticity.create should not create a  triple if field is invalid', function (test) {
  //subject col
  test.throws(function () {
    semanticity.create({col: '', id: 'sub'}, 'string', {col: 'sub',id:'adfjksajkl'})
  })
  //subject id
  test.throws(function () {
    semanticity.create({col: 'sub', id: ''}, 'string', {col: 'sub',id:'adfjksajkl'})
  })
  //predicate
  test.throws(function () {
    semanticity.create({col: 'sub', id: 'sub'}, '', {col: 'sub',id:'adfjksajkl'})
  })
  //target col
  test.throws(function () {
    semanticity.create({col: 'sub', id: 'sub'}, 'string', {col: '',id:'adfjksajkl'})
  })
  //target id
  test.throws(function () {
    semanticity.create({col: 'sub', id: 'sub'}, 'string', {col: 'sub',id:''})
  })
});

Tinytest.add('Semanticity - Semanticity.remove should remove the triple', function (test) {
  id = semanticity.create({col: 'sub',id: 'adfjksajkl'}, 'predicate', {col: 'sub',id:'adfjksajkl'})
  semanticity.remove(id)
  test.equal(semanticity.collection.findOne(id), undefined)
});

Tinytest.add('Semanticity - Semanticity.remove should not batch remove', function (test) {
  id = semanticity.create({col: 'sub',id: 'adfjksajkl'}, 'predicate', {col: 'sub',id:'adfjksajkl'})
  semanticity.remove([id])
  test.equal(semanticity.collection.findOne(id)._id, id)
});
