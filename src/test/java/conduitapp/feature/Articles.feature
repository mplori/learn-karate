Feature: Articles

    Background: Define URL
         Given url 'https://api.realworld.io/api/'
         Given path 'users/login'
         And request {"user": {"email": "krt@test.com","password": "karate1"}}
         When method Post
         Then status 200
         * def token = response.user.token 

    Scenario: Create a new article
    
        Given header Authorization = 'Token ' + token
        Given path 'articles'
        And request {"article": {"tagList": [],"title": "Implementation5","description": "what is it?","body": "hey there "}}
        When method Post
        Then status 200
        And match response.article.title == 'Implementation5'
