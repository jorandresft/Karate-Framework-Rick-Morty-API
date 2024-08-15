# author: Jorge Franco
# date: 15/08/2024

Feature: Get data of a character from rick and morty

  Background:
    * url api.baseUrl
    * def responseSuccessful = read("successful-response-get.json")
    * def responseDataRick = read("response-data-rick.json")
    * def responseNotFound = read("not-found-get.json")
    * def responseNotProvideId = read("../error-not-provide-id-get.json")

    Scenario Outline: Get data of a character from rick and morty
      Given path character = 'character/' + <id>
      When method GET
      Then status 200
      And match $ == responseSuccessful

      Examples:
        | id |
        | 3  |
        | 4  |
        | 5  |

  Scenario Outline: Get data of rick
    Given path character = 'character/' + <id>
    When method GET
    Then status 200
    And match $ == responseDataRick

    Examples:
      | id |
      | 1  |

  Scenario Outline: Get data of a character with not found
    Given path character = 'character/' + <id>
    When method get
    Then status 404
    And match $ == responseNotFound

    Examples:
      | id   |
      | 1000 |
      | 954  |
      | 7895 |

  Scenario Outline: Get data of a character with id invalid
    Given path character = 'character/' + <id>
    When method get
    Then status 500
    And match $ == responseNotProvideId

    Examples:
      | id    |
      | "rick"  |
      | "morty" |
      | "***"   |
