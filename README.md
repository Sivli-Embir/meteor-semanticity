Semanticity
==================

[![Build Status](https://travis-ci.org/CMToups/meteor-semanticity.png)](https://travis-ci.org/CMToups/meteor-semanticity)

This package manages resource (collection) relationships in meteor js, via meteorite. Not production ready!

This is a very simple interface that lets you store relationships as subject-predicate-target. 
Relationships refer to the correlation between two objects stored in one or more **local** collections. 
It derives from, but is not compliant with, [W3C Semantic Web](http://www.w3.org/standards/semanticweb/) standards.

This is not a triple-store database engine but rather an extension for implementing them. 
Current implementation only uses Meteor Collections to save relations.




### How to setup

Get the package from Atmosphere and instanciate it in your app.

in the terminal
```
mrt add semanticity
```
on the server
```
if(Meteor.isServer) {
  semanticity = new Semanticity();
}
```
Semanticity runs completely on the server and should not be sent down to the client.

### Drivers and Collections

By default Semanticity will use its core driver, wich uses Meteor.Collections to create. 
The diver field takes a switch string and looks for a named driver. 
If no driver is found (null, 'core', ect) it will use core. 

Additnally it creates the collection "semanticity_sets" by default. 
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
Or with Mock driver (for testing, see server/semanticity-mock.coffee)
```
semanticity = new Semanticity('mock');
```


