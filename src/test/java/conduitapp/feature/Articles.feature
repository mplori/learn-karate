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
        And match response.article.title == 'Implementation6'

    Scenario: Create and delete article
        Given header Authorization = 'Token ' + token
        Given path 'articles'
        And request {"article": {"tagList": [],"title": "Delete article","description": "what is it?","body": "hey there "}}
        When method Post
        Then status 200
        * def articleID = response.article.slug

        Given params {limit: 10, offset: 0}
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].title == 'Delete Article'

        Given header Authorization = 'Token ' + token
        Given path 'articles', articleID
        When method Delete
        Then status 204 

        Given params {limit: 10, offset: 0}
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].title != 'Delete Article'