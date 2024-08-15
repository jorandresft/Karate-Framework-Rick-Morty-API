# author: Jorge Franco
# date: 15/08/2024

Feature: Get data from a Rick and Morty location

  Background:
    * url api.baseUrl
    * def responseSuccessful = read("successful-response-get.json")
    * def responseDataCitadel = read("response-data-citadel-of-ricks.json")
    * def responseNotFound = read("not-found-location-get.json")
    * def responseNotProvideId = read("../error-not-provide-id-get.json")

  Scenario Outline: Get data from a rick and morty location
    Given path location = 'location/' + <id>
    When method GET
    Then status 200
    And match $ == responseSuccessful

    Examples:
      | id |
      | 3  |
      | 4  |
      | 5  |

  Scenario Outline: Get data of citadel of ricks
    Given path location = 'location/' + <id>
    When method GET
    Then status 200
    And match $ == responseDataCitadel

    Examples:
      | id |
      | 3  |

  Scenario Outline: Get data from a rick and morty location with not found
    Given path location = 'location/' + <id>
    When method get
    Then status 404
    And match $ == responseNotFound

    Examples:
      | id   |
      | 500  |
      | 890  |
      | 1000 |

  Scenario Outline: Get data from a rick and morty location with id invalid
    Given path character = 'character/' + <id>
    When method get
    Then status 500
    And match $ == responseNotProvideId

    Examples:
      | id        |
      | "citadel" |
      | "tierra"  |
      | "*&%"     |