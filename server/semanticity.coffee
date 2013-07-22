class @Semanticity
  constructor: (driver, collection) ->
    switch driver
      when 'mock', 'Mock', 'MOCK'  then return new SemanticityMock()
      else return new SemanticityCore(collection)  
