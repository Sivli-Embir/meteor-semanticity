###
  Currently these are all just examples. 
  Eventually I would like to add true tri-store databases as extension packages.
  When that happens I would like to keep a single API for interfacing with them.

  Feel free to add more and push them to the git repository. (or keep them local)
  These are all nested in Semanticity so they will not pollute the global name space.
###

include Semanticity, findWithSubject: (subject, options) ->
  @collection.find({'subject.col': subject}, options);
include Semanticity, findWithPredicate: (predicate, options) ->
  @collection.find({'predicate': predicate}, options);
include Semanticity, findWithTarget: (target, options) ->
  @collection.find({'target.col': target}, options);


include Semanticity, findWithSubjectId: (subject, id, options) ->
  @collection.find({'subject.col': subject, 'subject.id': id}, options);
include Semanticity, findWithTargetId: (target, id, options) ->
  @collection.find({'target.col': target, 'target.id': id}, options);

include Semanticity, findTarget: (subject, id, target, predicate, options) ->
  query = {'subject.col': subject, 'subject.id': id}
  if predicate then _.extend query, {predicate: predicate}
  @collection.find(query, options);

include Semanticity, findSubject: (target, id, subject, predicate, options) ->
  query = {'target.col': target, 'target.id': id}
  if predicate then _.extend query, {predicate: predicate}
  @collection.find(query, options);
