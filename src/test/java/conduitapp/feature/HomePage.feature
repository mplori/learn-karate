
Feature: Tests for the home page

Background: Define URL
    Given url 'https://api.realworld.io/api/'

    

   Scenario: Get all tags
        Given path 'tags'
        When method Get
        Then status 200
      
        # Verify certain values of the array 
        And match response.tags contains ['implementations','welcome']

        # Verify that certain value should not be there
        And match response.tags !contains 'truck'

        # Verify that the values of the  "tags" is an array
        And match response.tags =="#array"

        # Verify that each value of the array is a string
        And match each response.tags =="#string"



    Scenario: Get 10 articles from the page
        Given params {limit: 10, offset: 0}
        Given path 'articles'
        When method Get
        Then status 200

        # Verify that the limit of the array is 10
        And match response.articles == '#[3]'

         # Verify that article count is: 3
         And match response.articlesCount == 3
       
