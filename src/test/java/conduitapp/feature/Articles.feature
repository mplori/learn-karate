Feature: Articles

    Background: Define URL 
         Given url apiURL
         
    # Scenario: Create a new article
    #     Given path 'articles'
    #     And request {"article": {"tagList": [],"title": "lor2","description": "what is it234243?","body": "hey there 234224234243"}}
    #     When method Post
    #     Then status 200
    #     And match response.article.title == 'lor2'

    Scenario: Create and delete article
        Given path 'articles'
        And request {"article": {"tagList": [],"title": "Delete article6","description": "what is it?","body": "hey there "}}
        When method Post
        Then status 200
        * def articleID = response.article.slug

        Given params {limit: 10, offset: 0}
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].title == 'Delete article6'

        Given path 'articles', articleID
        When method Delete
        Then status 204 

        Given params {limit: 20, offset: 0}
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].title != 'Delete article6'