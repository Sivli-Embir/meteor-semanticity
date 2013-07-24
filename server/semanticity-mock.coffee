class @SemanticityMock
  constructor:  () ->
    @collection = new Meteor.Collection(null)

  create: (subject, predicate, target) =>
    console.log('create called')

  remove: (id) =>
    console.log('remove called')

  find: (query, options) =>
    new SemanticityCursor()

  findOne: (query, options) =>
    console.log('findOne called')

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
