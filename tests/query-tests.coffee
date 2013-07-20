###

Its becoming clear that I am exceeding the scope of Tinytest. 
I (we?) should look into using an existing testing framework with more built in functionality.

###
semanticity = new Semanticity(new Meteor.Collection('queries'))
st_id1 = semanticity.create({col: 'sub',id: '1'}, 'predicate', {col: 'tar',id:'1'})
st_id2 = semanticity.create({col: 'sub',id: '2'}, 'predicate', {col: 'tar',id:'2'})
st_id3 = semanticity.create({col: 'sub',id: '3'}, 'predicate', {col: 'tar',id:'3'})

sr_id4 = semanticity.create({col: 'sub',id: '4'}, 'predicate', {col: 'rar',id:'1'})
sr_id4 = semanticity.create({col: 'sub',id: '5'}, 'predicate', {col: 'rar',id:'2'})
sr_id4 = semanticity.create({col: 'sub',id: '6'}, 'predicate', {col: 'rar',id:'3'})

pt_id1 = semanticity.create({col: 'pub',id: '1'}, 'predicate', {col: 'tar',id:'4'})
pt_id2 = semanticity.create({col: 'pub',id: '2'}, 'predicate', {col: 'tar',id:'5'})
pt_id3 = semanticity.create({col: 'pub',id: '3'}, 'predicate', {col: 'tar',id:'6'})

pr_id1 = semanticity.create({col: 'pub',id: '4'}, 'predicate', {col: 'rar',id:'4'})
pr_id2 = semanticity.create({col: 'pub',id: '5'}, 'predicate', {col: 'rar',id:'5'})
pr_id3 = semanticity.create({col: 'pub',id: '6'}, 'predicate', {col: 'rar',id:'6'})

# FIXURES NEEDED!!!

Tinytest.add 'Semanticity - queries - findWithSubject should find with subject', (test) ->
  out = semanticity.findWithSubject('sub')
  test.instanceOf(out, Object) #not null, and such function works. Second test checks for valid data.
  test.equal(out.fetch(), semanticity.collection.find({'subject.col': 'sub'}).fetch())

  out = semanticity.findWithSubject('tar')
  test.instanceOf(out, Object) 
  test.equal(out.fetch(), semanticity.collection.find({'subject.col': 'tars'}).fetch())
