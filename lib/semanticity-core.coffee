class @SemanticityCore
  constructor:  (collectionHandle) ->
    @collection = collectionHandle
    @collection ?= new Meteor.Collection('semanticity_sets')

  create: (subject, predicate, target, meta) =>
    check(subject, {col: String, id: Match.Any})
    check(predicate, String)
    check(target, {col: String, id: Match.Any})
    if meta then check(meta, Array)

    if not subject.col then throw 'subject collection name undefined'
    if not subject.id then throw 'subject id name undefined'
    if not predicate then throw 'predicate name undefined'
    if not target.col then throw 'target collection name undefined'
    if not target.id then throw 'target id name undefined'

    @collection.insert({subject: subject, predicate: predicate, target: target, meta: meta})

  remove: (id) =>
    @collection.remove(id)

  find: (query, options) =>
    new SemanticityCursor @collection.find(query, options)

  findOne: (query, options) =>
    @collection.findOne(query, options)

  class SemanticityCursor
    constructor:  (@cursor) ->
    
    map: (callback) =>
      @cursor.map(callback)
    forEach: (callback) =>
      @cursor.forEach(callback)
    fetch: () =>
      @cursor.fetch()
    count: =>
      @cursor.count()
    rewind: =>
      @cursor.rewind()
    observe: (callback) =>
      @cursor.observe(callback)
    observeChanges: (callback) =>
      @cursor.observeChanges(callback)
