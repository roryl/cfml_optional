/**
* My xUnit Test
*/
component extends="testbox.system.BaseSpec"{

/*********************************** LIFE CYCLE Methods ***********************************/

	// executes before all test cases
	function beforeTests(){
	}

	// executes after all test cases
	function afterTests(){
	}

	// executes before every test case
	function setup( currentMethod ){
	}

	// executes after every test case
	function teardown( currentMethod ){
	}

/*********************************** TEST CASES BELOW ***********************************/

	// Remember that test cases MUST start or end with the keyword 'test'
	/*********
	* INIT Methods
	**********/
		function testShouldInitWithNull() labels="init" {
			var Optional = new Optional(javaCast("null", ""));
			expect(Optional).toBeInstanceOf("Optional");
			expect(Optional.exists()).toBeFalse();
			return false;
		}

		function testShouldInitWithValue() labels="init"{
			var Optional = new Optional(this);
			expect(Optional).toBeInstanceOf("Optional");
			expect(Optional.exists()).toBeTrue();
			return false;
		}

		function testShouldInitWithValueAndKey() labels="init"{
			local.key = "true";
			var Optional = new Optional(local,"key");
			expect(Optional).toBeInstanceOf("Optional");
			expect(Optional.exists()).toBeTrue();
			return false;
		}

		function testShouldInitWithValueAndMissingKey() labels="init"{
			//local.key = "true";
			var Optional = new Optional(local,"key");
			expect(Optional).toBeInstanceOf("Optional");
			expect(Optional.exists()).toBeFalse();
			return false;
		}

		function testShouldInitWithClosureThatReturnsError() labels="init"{
			//local.key = "true";
			var Optional = new Optional(function(){
				return local.key;
			});
			expect(Optional).toBeInstanceOf("Optional");
			expect(Optional.exists()).toBeFalse();
			return false;
		}

		function testShouldInitWithClosureThatReturnsValue() labels="init"{
			var key = "true";
			var Optional = new Optional(function(){
				return key;
			});
			expect(Optional).toBeInstanceOf("Optional");
			expect(Optional.exists()).toBeTrue();
			return false;
		}

	/**
	* Exists()
	**/
		function testExistsShouldReturnTrue(){
			var Optional = new Optional(true);
			expect(Optional.Exists()).toBeTrue();
		}

		function testExistsShouldReturnFalse(){
			var Optional = new Optional();
			expect(Optional.Exists()).toBeFalse();
		}

	/**
	* if()
	**/
		function testIfShouldExecuteIfExists(){
			var Optional = new Optional(true);
			var result = Optional.if(function(){return true;});
			expect(result).toBeTrue();
		}

		function testIfShouldExecuteIfEmpty(){
			var Optional = new Optional();
			expect(Optional.if(function(){return true;})).toBeNull();
		}

	/**
	* get()
	**/
		function testGetShouldReturnTheValueIfExists(){
			var Optional = new Optional(true);
			var result = Optional.get();
			expect(result).toBeTrue();
		}

		function testGetShouldReturnTheValueIfExists(){
			var Optional = new Optional();
			expect(function(){
				Optional.get();
			}).toThrow(message="Object was null, cannot return. Use Exists to check if the Optional value exists");
		}

	/**
	* ifElse()
	**/
		function testIfElseShouldReturnIFIfExists(){
			var Optional = new Optional(true);
			var result = Optional.ifElse(
				function(){
					return true;
				},
				function(){
					return false;
			})
			expect(result).toBeTrue();
		}

		function testIfElseShouldReturnIFIfNotExists(){
			var Optional = new Optional();
			var result = Optional.ifElse(
				function(){
					return true;
				},
				function(){
					return false;
			})
			expect(result).toBeFalse();
		}

	/**
	* elseThrow()
	**/
		function testElseThrowShouldNotThrowIfExists(){
			var Optional = new Optional(true);
			var result = Optional.elseThrow();
			expect(result).toBeTrue();
		}

		function testElseThrowShouldThrowIfNotExists(){
			var Optional = new Optional();
			expect(function(){
				return Optional.elseThrow("Threw my custom message")
			}).toThrow(message="Threw my custom message");
		}


	/**
	* or()
	**/
		function testOrShouldReturnIfExists(){
			var Optional = new Optional(true);
			var result = Optional.or("other");
			expect(result).toBe("other");
		}

		function testOrShouldReturnIfNotExists(){
			var Optional = new Optional();
			var result = Optional.or("other");
			expect(result).toBe("other");
		}

	/**
	* else()
	**/
		function testElseShouldNotCallElseIfExists(){
			var Optional = new Optional(true);
			var result = Optional.else(function(){});
			expect(result).toBeTrue();
		}

		function testElseShouldCallElseIfNotExists(){
			var Optional = new Optional();
			var result = Optional.else(function(){return true});
			expect(result).toBeTrue();
		}

	/**
	* equals()
	**/
		function testEqualsShouldEqualIfBothNull(){
			var Optional1 = new Optional();
			var Optional2 = new Optional();
			expect(Optional1.equals(Optional2)).toBeTrue();
			expect(Optional2.equals(Optional1)).toBeTrue();
		}

		function testEqualsShouldEqualIfBothNotNullAndSameValue(){
			var Optional1 = new Optional(true);
			var Optional2 = new Optional(true);
			expect(Optional1.equals(Optional2)).toBeTrue();
			expect(Optional2.equals(Optional1)).toBeTrue();
		}

		function testEqualsShouldNotEqualIfOneNullAndTheOtherNotNull(){
			var Optional1 = new Optional(true);
			var Optional2 = new Optional();
			expect(Optional1.equals(Optional2)).toBeFalse();
			expect(Optional2.equals(Optional1)).toBeFalse();
		}

		function testEqualsShouldNotEqualIfValuesAreNotEqual(){
			var Optional1 = new Optional(true);
			var Optional2 = new Optional(false);
			expect(Optional1.equals(Optional2)).toBeFalse();
			expect(Optional2.equals(Optional1)).toBeFalse();
		}

}
