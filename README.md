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

*in the console*
```
mrt add semanticity
```
*on the server*
```
if(Meteor.isServer) {
  semanticity = new Semanticity();
}
```
Semanticity runs completely on the server and should not be sent down to the client.

### Custom and Multi Collections





