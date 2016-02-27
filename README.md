# cfml_optional
##Class to handle Nulls in CFML

Handling NULL references can be tedious in some situations in CFML, particularly when using the ORM, which may often return NULL references, or using Java libraries which may return NULL. 

cfml_optional is a signle Optional.cfc file which makes instatiating objects & values which may be null, and handling that null possibility gracefully.

###Intended Uses
####Syntactic Sugar
When initializing objects which may be null, there is a common syntax:

```cfml
//Loading an entity
var myObj = entityLoad("myEntity",1,true);
if(isNull(myObj)){
  var myObj = entityNew("myEntity");
}
```

This can be very verbose, particularly if you need to instantiate a tree of objects

Optional.cfc makes this easier like the following

```coldfusion
var myObj = new Optional(entityLoad("myEntity",1,true)).else(entityNew("myEntity"));
```

Which does the same thing 'Instantiate Optional and call else() on it. Else returns the value of the Optional, or executes else function, returning a new entity

####Type Hinting
Use Optional as a return type to your functions to inform callers that your function may return a value or return null. Normally a function that may returns nulls may look like:

```coldfusion
public any function getMyEntity(){
  return entityLoadByPK("myEntity",1);
}
```
The type signature of this function is 'any' but that is inacurate. It can either be a component, or null. Using Optional adds type information for IDE or user introspection 

```coldfusion
public Optional getMyEntity(){
  return new Optional(entityLoadByPK("myEntity",1));
}
```

####Deferred Handling
Sometimes a variable may be present or null, and you need to pass that onto some other function. However, maybe you'd rather handle the existence of the value later, rather than when it is passed. Wrapping possible null values allows you to pass the Optional around without getting null pointer or missing variables errors.

