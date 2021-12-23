@tagfaeture
Feature: Testing Rest APIs for Req Res WebSite

Background: 
* url baseurl

@tag1
Scenario: Variable test

Given def user = { name: 'john', age: 21 }
And def lang = 'en'
When def session = { name: '#(user.name)', locale: '#(lang)', sessionUser: '#(user)'  }
* def enclosed = ({ name: user.name, locale: lang, sessionUser: user })

* match session == enclosed

* table cats
  | name   | age |
  | 'Bob'  | 2   |
  | 'Wild' | 4   |
  | 'Nyan' | 3   |
  
  * def data = {"name": "jhon", "last": "last", "first": "first"}
  
  * table nested
  | name   | age |
  | data  | 2   |
  | {"name": "bob"} | 4   |
  | data.last | 3   |
  
  * set search
  | path       | 0        | 1      | 2       |
  | name.first | 'John'   | 'Jane' |         |
  | name.last  | 'Smith'  | 'Doe'  | 'Waldo' |
  | age        | 20       |        |         |
  
  * text foo =
    """
    name,type
    Billie,LOL
    Bob,Wild
    """
* csv bar = foo
* match bar == [{ name: 'Billie', type: 'LOL' }, { name: 'Bob', type: 'Wild' }]
  
  * set nestedarr
  | path   			| value |
  | one    			| 1     |
  | two[0] 			| 2     |
  | two[1] 			| 3     |
  |three.val		|	3			|
  |three.head		|	5			|
  |	hello				|	6			|
  
 * print  nestedarr
 
 * print 'TEST TEST TEST', myVarName

@tag2
Scenario: Testing Rest API to get List of users
Given path '/api/users'
And param page = 2
And header Accept = 'application/json'
When method get
Then status 200
And match response.data[0].id == 7




