class @Semanticity
  constructor:  (collectionName) ->
    collectionName ?= 'semanticity_sets'
    @collection = new Meteor.Collection(collectionName)

  create: (subject, predicate, target) =>
    check(subject, {col: String, id: Match.Any})
    check(predicate, String)
    check(target, {col: String, id: Match.Any})

    if not subject.col then throw 'subject collection name undefined'
    if not subject.id then throw 'subject id name undefined'
    if not predicate then throw 'predicate name undefined'
    if not target.col then throw 'target collection name undefined'
    if not target.id then throw 'target id name undefined'

    @collection.insert({subject: subject, predicate: predicate, target: target})

  remove: (id) =>
    @collection.remove(id)

# easy way to extend Semanticity, see getters.coffee
@extend = (obj, mixin) ->
  obj[name] = method for name, method of mixin        
  obj

@include = (klass, mixin) ->
  extend klass.prototype, mixin
