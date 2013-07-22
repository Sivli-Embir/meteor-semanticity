class @SemanticityMock
  constructor:  () ->
    @collection = new Meteor.Collection(null)

  create: (subject, predicate, target) =>
    console.log('create called')

  remove: (id) =>
    console.log('remove called')

  find: (query, options) =>
    console.log('find called')

  findOne: (query, options) =>
    console.log('findOne called')
