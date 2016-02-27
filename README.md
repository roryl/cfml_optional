# cfml_optional
##A CFC to handle Nulls in CFML

Handling NULL references can be tedious in some situations in CFML, particularly when using the ORM, which may often return NULL references, or using Java libraries which may return NULL.

cfml_optional is a signle Optional.cfc file which makes instatiating objects & values which may be null, and handling that null possibility gracefully.

Inspired by some use cases of Java Optional, but different Syntax that better fit my purposes. To understand a Java perspective on why you might use Optional you may read: http://www.oracle.com/technetwork/articles/java/java8-optional-2175753.html

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
The type signature of this function is 'any' but that is not precise enoug for some situations. It can either be a component, or null. Using Optional adds type information for IDE or user introspection and ensures that the caller must handle the Optional

```coldfusion
public Optional getMyEntity(){
  return new Optional(entityLoadByPK("myEntity",1));
}
```

####Deferred Handling
Sometimes a variable may be present or null, and you need to pass that onto some other function. However, maybe you'd rather handle the existence of the value later, rather than when it is passed. Wrapping possible null values allows you to pass the Optional around without getting null pointer or missing variables errors.

####Comparing possible Null values
In situations when you may want to compare two variables which one of them may be null, it requires a lot of conditional statements. Using Optional, equality can be checked more quickly. Consider the following:

```javascript
var test1 = variables.test1 //may be null
var test2 = variables.test2 //may be null
if(!isNull(test1) AND !isNull(test2){
  if(test1 == test2){
    //equal!
  } else {
    //not equal!
  }
} else if(isNull(test1) AND isNull(test2){
  //equal, they are both null!
} else if((!isNull(test1) AND isNull(test2)) OR (isNull(test1) AND !isNull(test2)){
    //not equal, one of them is null!
  }
}
```

This equality can be much more easily tested

```coldfusion
var test1 = new Optional(variables,"test1");
var test2 = new Optional(variables,"test2");
var result = test1.equals(test2);
```

###Instantiation Options

####A Value or Possible Null Value

```coldfusion
var Optional = new Optional(entityLoadByPK("MyEntity,1));
```

####A Closure which Wraps a possible Null value
Use this when you don't know if the variable you want to instantiate will exist or not at time of instantiation of the Optional

```coldfusion
var Optional = new Optional(
  function(){
    return variableWhichMayNotExist;
  }
);
```

####A scope and a key which may have a value or be null
```coldfusion
var Optional = new Optional(application,"key");
```

##Requirements
Only tested against Lucee 4.5+. Requires Closures which are on CF 10+ and Railo 4.2+

##Installation

###Traditional
Download the Optional.cfc file and place it anywhere to use it, usually in a Util directory

###CommandBox
cfml_option is a CommandBox package, install it using commandBox
[Obtain CommandBox package manager](http://www.ortussolutions.com/products/commandbox)

###For Production Use
`install https://github.com/roryl/cfml_optional/archive/master.zip --production`

###For Contributing to cfml_optional
This will install the testbox dependencies and unit tests
`install https://github.com/roryl/cfml_optional/archive/master.zip`

##Optional.cfc API

###public boolean function Exists()
###public any function if(required any if)
###public any function get()
###public any function ifElse(required any if, required any else)
###public any function elseThrow(message)
###public any function or(required any other)
###public any function else(required any other)
###public boolean function equals(required Optional value)
