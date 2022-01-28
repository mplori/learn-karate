
Feature: Sign up new user


    Background: Preconditions
        * def dataGenerator = Java.type('helpers.DataGenerator')
        Given url apiURL

    @debug
    Scenario: New user Sign Up
        * def randomEmail = dataGenerator.getRandomEmail()
        * def randomUsername = dataGenerator.getRandomUsername()


        Given path 'users'
        And request 
            """
                {
                    "user": {
                        "email": #(randomEmail),
                        "password": "Karate1234",
                        "username": #(randomUsername)
                    }
                } 
            """ 
        When method Post
        Then status 200
        And match response ==
        """
            {
                "user": {
                    "email": #(randomEmail),
                    "username": #(randomUsername),
                    "bio": null,
                    "image": "#string",
                    "token": "#string"
                }
            }
        """


