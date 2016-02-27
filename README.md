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

