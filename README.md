# cfml_optional
##A CFC to handle Nulls in CFML

Handling NULL references can be tedious in some situations in CFML, particularly when using the ORM, which may often return NULL references, or using Java libraries which may return NULL.

cfml_optional is a single Optional.cfc file which makes instatiating objects & values which may be null easier, and handling that null possibility gracefully.

Inspired by some use cases of Java Optional, but different Syntax that better fit my purposes. To understand a Java perspective on why you might use Optional you may read: http://www.oracle.com/technetwork/articles/java/java8-optional-2175753.html

###Table of Contents
- [Intended Uses](#intended-uses)
- [Instantiation](#instantiation)
- [Installation](#installation)
- [API Reference](#api-reference)


###Intended Uses
####Syntactic Sugar
When initializing objects which may be null, there is a common syntax:

```javascript
//Loading an entity
var myObj = entityLoad("myEntity",1,true);
if(isNull(myObj)){
  var myObj = entityNew("myEntity");
}
```

This can be very verbose, particularly if you need to instantiate a tree of objects

Lucee and CF11+ support Null-coalescing operator which is useful for short inline creation
```javascript
myObj = entityLoad("myEntity",1,true); ?: entityNew("myEntity");
```
For these simple cases like this, they are better than using Optional which is a little more verbose

Optional.cfc it is also possible to do this
```javascript
var myObj = new Optional(entityLoad("myEntity",1,true)).else(entityNew("myEntity"));
```

Which does the same thing 'Instantiate Optional and call else() on it. Else returns the value of the Optional, or executes else function, returning a new entity

####Type Hinting
The more common Use for Optional is as a return type to your functions to inform callers that your function may return a value or return null. Normally a function that may returns nulls may look like:

```javascript
public any function getMyEntity(){
  return entityLoadByPK("myEntity",1);
}
```
The type signature of this function is 'any' but that is not precise enough for some situations. It can either be a the entity, or null. Using Optional adds type information for IDE or user introspection and ensures that the caller must handle the Optional

```javascript
public Optional getMyEntity(){
  return new Optional(entityLoadByPK("myEntity",1));
}
```

####Deferred Handling
Sometimes a variable may be present or null, and you need to pass that onto some other function. However, maybe you'd rather handle the existence of the value later, rather than when it is passed. Wrapping possible null values allows you to pass the Optional around without getting null pointer or missing variable errors.

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

```javascript
var test1 = new Optional(variables,"test1");
var test2 = new Optional(variables,"test2");
var result = test1.equals(test2);
```

###Instantiation Options

####A Value or Possible Null Value

```javascript
var Optional = new Optional(entityLoadByPK("MyEntity,1));
```

####A Closure which Wraps a possible Null value
Use this when you don't know if the variable you want to instantiate will exist or not at time of instantiation of the Optional

```javascript
var Optional = new Optional(
  function(){
    return variableWhichMayNotExist;
  }
);
```

####A scope and a key which may have a value or be null
```javascript
var Optional = new Optional(application,"key");
```

##Subtyped Optional
By default, the Optional.cfc will return a value of any type, if it exists. If you want to ensure that the returned value matched a specific type (thus your function returns a NULL or an item of a specific type) then you can subtype the Optional.

Create your own CFC that will represent your desired type and extend Optional. Override the get function, with the appropriate return type, in this case an array: 
```javascript
//ArrayOptional.cfc
component extends="Optional" {

    public array function get(){
        return super.get();
    }

}
```
When we then create our ArrayOptional, it will type check the returned value to be an Array. For complex applications this can add some type guarantees

```javascript
var myArray = variableThatShouldBeArrayOrNull;
var ArrayOptional = new ArrayOptional(myArray);
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

##API Reference

###public boolean function Exists()
###public any function if(required any if)
###public any function get()
###public any function ifElse(required any if, required any else)
###public any function elseThrow(message)
###public any function or(required any other)
###public any function else(required any other)
###public boolean function equals(required Optional value)
