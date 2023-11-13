Feature: Clockify TP Final

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

  @ListProject
  Scenario: Get all projects on workspace
    Given call ClockyTpFinal.feature@ListWorkspace
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{idWorkspace}}/projects
    When execute method GET
    Then the status code should be 200
    * define IdProject = $.[0].id
    * define UserId = $.[0].memberships.[0].userId
#
#  Scenario: Get time entries for a user on workspace
#    Given call ClockyTpFinal.feature@ListWorkspace
#    And call ClockyTpFinal.feature@listProject
#    And base url https://api.clockify.me/api
#    And endpoint /v1/workspaces/{{idWorkspace}}/user/{{UserId}}/time-entries
#    When execute method GET
#    Then the status code should be 200
#
#  @projectById
#  Scenario: Find project by ID
#    Given call project1.feature@listWorkspace
#    And call project1.feature@listProject
#    And base url https://api.clockify.me/api
#    And endpoint /v1/workspaces/{{id}}/projects/{{IdProject}}
#    When execute method GET
#    Then the status code should be 200