
Feature: Tests for the home page

Background: Define URL
    Given url apiURL

    

   Scenario: Get all tags
        Given path 'tags'
        When method Get
        Then status 200
      
        # Verify certain values of the array 
        And match response.tags contains ['implementations','welcome']

        # Verify that certain value should not be there
        And match response.tags !contains 'truck'
        And match response.tags contains any ['fish', 'dog', 'introduction']

        # Verify that the values of the  "tags" is an array
        And match response.tags =="#array"

        # Verify that each value of the array is a string
        And match each response.tags =="#string"



    Scenario: Get 10 articles from the page
        * def timeValidator = read('classpath:helpers/timeValidator.js') 



        Given params {limit: 10, offset: 0}
        Given path 'articles'
        When method Get
        Then status 200

        # Verify that the limit of the array is 10
        # And match response.articles == '#[3]' 

        #  # Verify that article count is: 3
        #  And match response.articlesCount == 3
        # And match response.articlesCount != 3
        # And match response == { "articles": "#[10]", "articlesCount": 3}
        # And match response.articles[0].createdAt contains '2022'
        # # And match response.articles[*].favoritesCount contains 579
        # And match response.articles[*].author.bio contains null
        # And match each response..following == false 
        # And match each response..following == '#boolean' 
        # And match each response..favoritesCount == '#number'

        # #  '##' means that  either null or string values are acceptable. Also means that bio is optional. The test will pass even though the bio info is missing
        # And match each response..bio == '##string'
        
        #schema validation
        And match each response.articles ==
        """
            {
            "slug": "#string",
            "title": "#string",
            "description": "#string",
            "body": "#string",
            "createdAt": "#? timeValidator(_)",
            "updatedAt": "#? timeValidator(_)",
            "tagList": "#array",
            "author": {
                "username": "#string",
                "bio": '##string',
                "image": "#string",
                "following": '#boolean'
            },
            "favoritesCount": '#number',
            "favorited": '#boolean'
        }
        """