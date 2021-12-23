Feature: Testing Rest APIs

Background: 
* url 'https://reqres.in'
* def reusefeature = call read('classpath:examples/users/Reuse.feature')
* print 'TEXT TEXT', reusefeature.add(1,2)

Scenario: Test Rest API Req Res WebSite

* def json_resp = 
"""
{
    "page": 2,
    "per_page": 6,
    "total": 12,
    "total_pages": 2,
    "data": [
        {
            "id": 7,
            "email": "michael.lawson@reqres.in",
            "first_name": "Michael",
            "last_name": "Lawson",
            "avatar": "https://reqres.in/img/faces/7-image.jpg"
        },
        {
            "id": 8,
            "email": "lindsay.ferguson@reqres.in",
            "first_name": "Lindsay",
            "last_name": "Ferguson",
            "avatar": "https://reqres.in/img/faces/8-image.jpg"
        },
        {
            "id": 9,
            "email": "tobias.funke@reqres.in",
            "first_name": "Tobias",
            "last_name": "Funke",
            "avatar": "https://reqres.in/img/faces/9-image.jpg"
        },
        {
            "id": 10,
            "email": "byron.fields@reqres.in",
            "first_name": "Byron",
            "last_name": "Fields",
            "avatar": "https://reqres.in/img/faces/10-image.jpg"
        },
        {
            "id": 11,
            "email": "george.edwards@reqres.in",
            "first_name": "George",
            "last_name": "Edwards",
            "avatar": "https://reqres.in/img/faces/11-image.jpg"
        },
        {
            "id": 12,
            "email": "rachel.howell@reqres.in",
            "first_name": "Rachel",
            "last_name": "Howell",
            "avatar": "https://reqres.in/img/faces/12-image.jpg"
        }
    ],
    "support": {
        "url": "https://reqres.in/#support-heading",
        "text": "To keep ReqRe free, contributions towards server costs are appreciated!"
    }
}

"""
* def sub = read('test.json')
* print sub

* def sub1 =

"""
 {
            "id": 9,
            "email": "tobias.funke@reqres.in",
            "first_name": "Tobias",
            "last_name": "Funke",
            "avatar": "https://reqres.in/img/faces/9-image.jpg"
        }
"""

* def expected = { "page": 2, data: [ '#(sub1)'] }

* def schema = read('test2.json')

Given path '/api/users'
And param page = 2
And header Accept = 'application/json'
When method get
Then status 200
And match response.data[0].id == 7
And match $.data[0].id == 7
And match $ != json_resp
And match $.data[*].email contains 'rachel.howell@reqres.in'
And match $.data[*] !contains sub
* match $ contains deep expected
* match $ contains deep {page : "#number", data: "#array"}
Then assert responseStatus == 200 || responseStatus == 204
And match responseType == 'json'
And match sub1.id == '#? _<10'
And match $.data == '#[]'
And match $ == schema

Scenario: Testing JS Functions
* def add = function(a,b) {return a+b}
* match add(1,2) == 3
* def jsonf = function(j){return j.val}
* match jsonf({val: "hello"}) == "hello"
* def mul = function(ob){return {val: ob.a*ob.b}}
* def rs = call mul {a:1, b:2}
* print rs
* def myfun = read('myfunc.js')
* def res = call myfun {value: "world"}
* print res
* def mymeth =
  """
  function(arg) {
    var myobj = Java.type('examples.users.TestKarateJava');
    var jd = new myobj();
    return jd.meth(arg);  
  }
  """
  * def result = call mymeth 'change'
  * print result
  
  * def JavaDemo = Java.type('examples.users.TestKarateJava')
	* def jd1 = new JavaDemo()
	* def result1 = jd1.meth('world')
	* print result1
	
	Scenario: Create USer
	
	* def payload = 
	"""
	{
    "name": "morpheus",
    "job": "leader"
}
	"""
	
	Given path '/api/users'
	And header Accept = 'application/json'
	And request payload
	When method post
	Then status 201
	And match responseType == 'json'
	And match $.job == 'leader'
	And print response
	
	Scenario: upadate USer
	
	* def payload = 
	"""
	{
    "name": "morpheus",
    "job": "zion resident"
}
	"""
	
	Given path '/api/users/2'
	And header Accept = 'application/json'
	And request payload
	When method put
	Then status 200
	And match responseType == 'json'
	And match $.job == 'zion resident'
	And print response
	
		Scenario: delete USer
	
	Given path '/api/users/2'
	And header Accept = 'application/json'
	When method delete
	Then status 204
	And match responseType == '#string'
	And print response
	
	
	

	
	
	




