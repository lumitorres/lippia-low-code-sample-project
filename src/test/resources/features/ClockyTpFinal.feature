Feature: project clockify final

  Background:

    And header Content-Type = application/json
    And header Accept = */*
    And header x-api-key = MjY5NWRlOTktYzBkZS00YWViLWJjZGItNjNiMjU2YTM2OTU1

  @ListWorkspace
  Scenario: Get all my workspaces
    Given base url https://api.clockify.me/api
    And endpoint /v1/workspaces
    When execute method GET
    Then the status code should be 200
    * define idWorkspace = $.[1].id
   