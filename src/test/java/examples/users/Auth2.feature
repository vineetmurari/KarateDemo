@tagignore
Feature: Testing Secured APIs Auth2 online shop clothes web app

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
* def json1 = 
"""
{"Item1":"Red Shirt","Item2":"Blue Shirt","Item3":"Yellow Shirt"}
"""

* def oauth = Java.type('examples.users.Gettoken')
* def token = callonce oauth.get_github_access_token
* print '$%$%$%$%$%$%$% ---------------------- ()()()()()()()()()('




Scenario: GET Items

Given path '/api/get/items'
And header Accept = 'application/json'
And header authorization = token
When method get
Then status 200
And match response == json

Scenario: Get Pastorders

Given path '/api/get/pastorders'
And header Accept = 'application/json'
And header authorization = token
When method get
Then status 200
And match response == json1
 