include Semanticity, findWithSubject: (subject, options) ->
  @collection.find({'subject.col': subject}, options);

include Semanticity, findWithSubjectIde: (subject, id, options) ->
  @collection.find({'subject.col': subject, 'subject.id': id}, options);

include Semanticity, findWithPredicate: (predicate, options) ->
  @collection.find({'predicate': predicate}, options);

include Semanticity, findWithTarget: (target, options) ->
  @collection.find({'target.col': target}, options);

include Semanticity, findWithSubjectId: (subject, id, options) ->
  @collection.find({'subject.col': subject, 'subject.id': id}, options);

#not sure about everything under here, most of it smells and looks YAGTNI
include Semanticity, getSubjectIds: (subject, predicate ,target, id, options) ->
  query = {'subject.col': subject, predicate: predicate, target: {col: target, id: id}};
  filter = {fields: {'subject.id': 1}};

  if options then _.extend(filter, options)
  ids = []
  @collection.find(query, filter).forEach  (sem) ->
    ids.push(sem.subject.id)
  ids



include Semanticity, getTarget: (subject, predicate ,target, id, options) ->
  query = {'target.col': target, predicate: predicate, subject: {col: subject, id: id}};
  filter = {fields: {'subject.id': 1}};

  if (options) then _.extend(filter, options)
  ids = []
  @collection.find(query, filter).forEach (sem) ->
    ids.push(sem.target.id)
  ids;

include Semanticity, find: (args, options) ->
  ### possible arguments (args)

      subjectCol -- subject collection name
      subjectId   -- subject _id

      predicate   -- the triple predicate

      targetCol   -- target collection name
      targetId     -- target _id
  ###

  if (args.subjectId and args.subjectCol) 
    subject = {subject: {col: args.subjectCol, id: args.subjectId}}
  else 
    if (args.subjectCol) then subject = { 'subject.col': args.subjectCol}
    if (args.subjectId) then subject = { 'subject.id': args.subjectId}

  if (args.predicate) then predicate = {predicate: args.predicate}

  if (args.targetId and args.targetCol) 
    target = {target: {col: args.targetCol, id: args.targetId}}
  else 
    if (args.targetCol) then target = { 'target.col': args.targetCol}
    if (args.targetId) then target = { 'target.id': args.targetId}

  query = {}
  if subject then _.extend(query, subject) 
  if predicate then _.extend(query, predicate)
  if target then _.extend(query, target) 

  if (_.isEmpty(query))
    throw 'no query specified';

  @collection.find(query, options);
