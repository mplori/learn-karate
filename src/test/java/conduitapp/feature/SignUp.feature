@ignore
Feature: Sign up new user


    Background: Preconditions
        Given url apiURL

    @debug
    Scenario: New user Sign Up
        Given def userData = {"email":"KarateUserLor35@test.com","username":"KarateUserLor32"}
        Given path 'users'
        And request 
            """
                {
                    "user": {
                        "email": #(userData.email),
                        "password": "Karate1234",
                        "username": #(userData.username)
                    }
                } 
            """
        When method Post
        Then status 200


