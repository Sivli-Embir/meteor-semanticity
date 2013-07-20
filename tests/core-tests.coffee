# no db isolation in Tinytest *ANGRY FACE*
semanticity = new Semanticity();
s1 = new Semanticity(new Meteor.Collection('1_test'))
s2 = new Semanticity(new Meteor.Collection('2_test'))
s3 = new Semanticity(new Meteor.Collection('3_test'))
s4 = new Semanticity(new Meteor.SmartCollection('smart'))

Tinytest.add 'Semanticity - core - collection handle should be a vanilla Meteor.collection', (test) ->
  test.instanceOf(semanticity, Semanticity)
  test.instanceOf(semanticity.collection, Meteor.Collection)

Tinytest.add 'Semanticity - core - collection name should default to semanticity_sets', (test) ->
  test.equal(semanticity.collection._name, 'semanticity_sets')

Tinytest.add 'Semanticity - core - constructor should take a collection handle', (test) ->
  test.equal(s1.collection._name, '1_test')

Tinytest.add 'Semanticity - core - can have more then one instance of Semanticity', (test) ->
  test.instanceOf(s2, Semanticity)
  test.instanceOf(s3, Semanticity)

Tinytest.add 'Semanticity - core - constructor should take any kind of collection handle', (test) ->
  test.equal(s4.collection._name, 'smart')

Tinytest.add 'Semanticity - create - should create a valid triple', (test) ->
  id = semanticity.create({col: 'sub',id: 'adfjksajkl'}, 'predicate', {col: 'tar',id:'adfjksajkl'})
  test.equal({"subject":{col:"sub", id:"adfjksajkl"}, predicate:"predicate", target:{col:"tar", id:"adfjksajkl"}, _id: id}, semanticity.collection.findOne(id))


Tinytest.add 'Semanticity - create - should not create a triple if field not given', (test) ->
  #subject col
  test.throws ->
    semanticity.create({id: 'adfjksajkl'}, 'string', {col: 'tar', id:'adfjksajkl'})
 
  #subject id
  test.throws ->
    semanticity.create({col: 'sub'}, 'string', {col: 'tar', id:'adfjksajkl'})
 
  #predicate
  test.throws ->
    semanticity.create({col: 'sub', id: 'adfjksajkl'}, {}, {col: 'tar',id:'adfjksajkl'})
 
  #target col
  test.throws ->
    semanticity.create({col: 'sub', id: 'adfjksajkl'}, 'string', {id:'adfjksajkl'})
 
  #target id
  test.throws ->
    semanticity.create({col: 'sub', id: 'adfjksajkl'}, 'string', {col: 'tar'})
 


Tinytest.add 'Semanticity - create - should not create a  triple if field is invalid', (test) ->
  #subject col
  test.throws ->
    semanticity.create({col: '', id: 'adfjksajkl'}, 'string', {col: 'tar',id:'adfjksajkl'})
 
  #subject id
  test.throws ->
    semanticity.create({col: 'sub', id: ''}, 'string', {col: 'tar',id:'adfjksajkl'})
 
  #predicate
  test.throws ->
    semanticity.create({col: 'sub', id: 'adfjksajkl'}, '', {col: 'tar',id:'adfjksajkl'})
 
  #target col
  test.throws ->
    semanticity.create({col: 'sub', id: 'adfjksajkl'}, 'string', {col: '',id:'adfjksajkl'})
 
  #target id
  test.throws ->
    semanticity.create({col: 'sub', id: 'adfjksajkl'}, 'string', {col: 'tar',id:''})
 


Tinytest.add 'Semanticity - remove - should remove the triple', (test) ->
  id = semanticity.create({col: 'sub',id: 'adfjksajkl'}, 'predicate', {col: 'tar',id:'adfjksajkl'})
  semanticity.remove(id)
  test.equal(semanticity.collection.findOne(id), undefined)


Tinytest.add 'Semanticity - remove - should not batch remove', (test) ->
  id = semanticity.create({col: 'sub',id: 'adfjksajkl'}, 'predicate', {col: 'tar',id:'adfjksajkl'})
  semanticity.remove([id])
  test.equal(semanticity.collection.findOne(id)._id, id)

Tinytest.add 'Semanticity - core - include Semanticity, mixin should add methods to classes', (test) ->
  include Semanticity, toFoo: ->
    return 'foo'
  test.equal(semanticity.toFoo(), 'foo')
