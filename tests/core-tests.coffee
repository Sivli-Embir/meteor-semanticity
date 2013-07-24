# no db isolation in Tinytest *ANGRY FACE*
semanticity = new Semanticity();
s1 = new Semanticity(null, new Meteor.Collection('1_test'))
s2 = new Semanticity(null, new Meteor.Collection('2_test'))
s3 = new Semanticity(null, new Meteor.Collection('3_test'))
s4 = new Semanticity(null, new Meteor.SmartCollection('smart'))


Tinytest.add 'Semanticity - core - collection handle should be a vanilla Meteor.collection', (test) ->
  test.instanceOf(semanticity, SemanticityCore)
  test.instanceOf(semanticity.collection, Meteor.Collection)

Tinytest.add 'Semanticity - core - collection name should default to semanticity_sets', (test) ->
  test.equal(semanticity.collection._name, 'semanticity_sets')

Tinytest.add 'Semanticity - core - constructor should take a collection handle', (test) ->
  test.equal(s1.collection._name, '1_test')

Tinytest.add 'Semanticity - core - can have more then one instance of Semanticity', (test) ->
  test.instanceOf(s2, SemanticityCore)
  test.instanceOf(s3, SemanticityCore)

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

#must find a way to do fixtures
unless id then id = semanticity.create({col: 'sub',id: 'adfjksajkl'}, 'predicate', {col: 'tar',id:'dfjksajkl'})

Tinytest.add 'SemanticityCursor - new - should take a Meteor Cursor of the Semanticity collection', (test) ->
  out = semanticity.find({})
  test.equal(out.cursor._cursorDescription.collectionName, 'semanticity_sets')

Tinytest.add 'SemanticityCursor - map - use the Meteor Cursor map()', (test) ->
  test.equal(semanticity.find(id).map((o)->o.subject.col ), ['sub'])

Tinytest.add 'SemanticityCursor - forEach - use the Meteor Cursor forEach()', (test) ->
  sub = ''
  semanticity.find(id).forEach (o) ->
    sub = o.subject.col 
  test.equal(sub, 'sub')

Tinytest.add 'SemanticityCursor - fetch - use the Meteor Cursor fetch()', (test) ->
  test.equal(semanticity.find(id).fetch()[0].subject.col, 'sub')

Tinytest.add 'SemanticityCursor - rewind - use the Meteor Cursor rewind()', (test) ->
  cursor = semanticity.find(id)
  cursor.map(->)
  cursor.rewind()
  test.equal(cursor.map((o)->o.subject.col), ['sub'])

Tinytest.add 'SemanticityCursor - observe - use the Meteor Cursor observe()', (test) ->
  #I have no idea
  test.isTrue(false)

Tinytest.add 'SemanticityCursor - observeChange - use the Meteor Cursor observeChange()', (test) ->
  #I have no idea
  test.isTrue(false)
