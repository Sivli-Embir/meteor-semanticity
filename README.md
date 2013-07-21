Semanticity
==================

[![Build Status](https://travis-ci.org/CMToups/meteor-semanticity.png)](https://travis-ci.org/CMToups/meteor-semanticity)

This package manages resource (collection) relationships in meteor js, via meteorite. Not production ready!

This is a very simple API that lets you store relationships as subject-predicate-target. Relationships refer to the correlation between two objects stored in one or more **local** collections. It derives from, but is not complient with, *W3C Semantic Web* standards.

This is not a triple-store database engine but rather an extensible API for implementing them. 
Current implmentaion only uses Meteor Collections to save relations.




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

### more to come
