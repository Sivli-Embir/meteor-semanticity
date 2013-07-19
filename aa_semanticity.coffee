class @Semanticity
  constructor:  (collectionName) ->
    collectionName ?= 'semanticity_sets'
    @collection = new Meteor.Collection(collectionName)

  create: (subject, predicate, target) =>
    @collection.insert({subject: subject, predicate: predicate, target: target})

  deleteTriple: (id) =>
    @collection.remove(id)

# easy way to extend Semanticity, see getters.coffee
@extend = (obj, mixin) ->
  obj[name] = method for name, method of mixin        
  obj

@include = (klass, mixin) ->
  extend klass.prototype, mixin
