Semanticity
==================

[![Build Status](https://travis-ci.org/CMToups/meteor-semanticity.png)](https://travis-ci.org/CMToups/meteor-semanticity)

This package manages resource (collection) relationships in Meteor JS, via Meteorite. Not production ready!

This is a very simple interface that lets you store relationships as subject-predicate/predicator-target. 
Relationships refer to the correlation between two objects stored in one or more **local** collections. 
It derives from, but is not compliant with, [W3C Semantic Web](http://www.w3.org/standards/semanticweb/) standards.

This is not a triple-store database engine but rather an extension for implementing them. 
Current implementation only uses Meteor Collections.




### How to setup

Get the package from Atmosphere and instantiate it in your app.

in the terminal *(or use git if you don't use Meteorite)*
```
mrt add semanticity
```
on the server
```
if(Meteor.isServer) {
  semanticity = new Semanticity();
}
```
Semanticity _now_ runs on the server and the client. 

### Drivers and Collections

By default Semanticity will use its core driver, which uses Meteor.Collections. 
The driver argument takes a switch string and looks for a named driver. 
If no driver is found (null, 'core', ect) it will use core. 

Additionally it creates the collection "semanticity_sets" by default. 
The second constructor option lets you overide this.

**Currently there are only the Core and Mock drivers. Feel free to help make more!**

```
semanticity = new Semanticity(null, new Meteor.Collection('custom_named_set');
```
You can use any collection you like so long as it is Meteor compatible. 
Here is an example with [smart-collections](https://github.com/arunoda/meteor-smart-collections).
```
semanticity = new Semanticity(null, new Meteor.SmartCollection('custom_named_set');
```
Or with Mock driver (for stubing out a new driver, see server/semanticity-mock.coffee)
```
semanticity = new Semanticity('mock');
```
### Creating Relationships

Subject and target are fields that have nested objects. The nested objects should have the col: and id: fields. 
The predicate can be any string but it may be wise not to add whitespace. This may become a restriction later.

```
subject = { col: 'collection_name', id: 'collection_id'}
target = { col: 'collection_name', id: 'collection_id'}
predicate = 'relationship_predicate'

id = semanticity.create(subject, predicate, target)
```
### Removing Relationships

To remove a relationship call the remove method. This functions like meteor collection remove.

```
semanticity.remove(id)
```
### Find and FindOne

Semanticity implements `find()` and `findOne()` just like Meteor, in the core driver they are the same methods. 
One key difference is what is returned is a Semanticity Cursor. 
This cursor functions just like the Meteor Collection Cursor and has all the methods defined in the Meteor Docs. 

### Subscriptions

```
Meteor.subscribe("posts");

Deps.autorun(function () {
  ids =  Posts.find({}).map(function(col) { return col._id})
  Meteor.subscribe("semanticity", {ids: ids, name: 'posts'})
  
  //Assuming you have set Session.get('currentPostId')
  
  ids = semanticity.find({
    'subject.col': 'comments', 
    predicate: 'belongs_to', 
    target: {col: 'posts', id: Session.get('currentPostId')} 
  }).map(function (col) {
    return col.subject.id
  });
  
  if (! _.isEmpty(ids)) { Meteor.subscribe('comments', ids); }
});
```
### Publications

```
Meteor.publish("posts", function () {
  return Posts.find({});
});

Meteor.publish("semanticity", function (collection) {
  //this is kinda crazy to ask users to define, this needs to be a method call.
  return semanticity.find({$or: [
    {'target.col': collection.name, 'target.id': {$in: collection.ids}}, 
    {'subject.col': collection.name, 'subject.id': {$in: collection.ids} }] 
  }).cursor; //for now be sure to call .cursor on the SemanticityCursor, this returns the Meteor cursor and all its ractive goodness.
});

Meteor.publish("comments", function (ids) { 
  return Comments.find({_id: {$in: ids}});
});
```

### TODO
* Add at least one driver.
* Clean up and reduce the README, also create a wiki.
* Add indexs.

### Collaboration and adding new drivers
All are welcome. 
If you wish to add a driver I would ask that you create it in separate smart package and overload all the methods in the Mock driver. 
Users will likely only need one driver so there is no point in polluting their app with useless drivers. This will also help manage dependancies.
I am still working out the logistics of how to do this.
