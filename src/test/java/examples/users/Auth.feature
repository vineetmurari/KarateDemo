Feature: Testing Secured APIs online shop clothes web app

Background: 
* url 'http://localhost:3000'
* def json = 
"""
{
  "Item1": "Red Shirt",
  "Item2": "Blue Shirt",
  "Item3": "Green Shirt"
}
"""

## ThisissampleAPIKEYfromDB

#Scenario: GET Items
#
#Given path '/api/get/items'
#And header Accept = 'application/json'
#And header authorization = 'ThisissampleAPIKEYfromDB'
#When method get
#Then status 200
#And match response == json


Scenario Outline: Data Driven Test

* def sometoken = <token>
* def reqheaders = { Authorization: '#(sometoken)', accept: 'application/json' }


Given path '/api/get/items'
And headers reqheaders
When method get
Then status 200
And match response == json

Examples:
|token|
|'ThisissampleAPIKEYfromDB'|
|'S2luZzpRdWVlbg=='| 