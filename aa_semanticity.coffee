class @Semanticity
  constructor:  (collectionHandle) ->
    @collection = collectionHandle
    @collection ?= new Meteor.Collection('semanticity_sets')

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

@extend = (obj, mixin) ->
  obj[name] = method for name, method of mixin        
  obj

@include = (klass, mixin) ->
  extend klass.prototype, mixin
