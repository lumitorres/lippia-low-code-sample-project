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
    * define workspaceId = $.[1].id

  @ListProject
  Scenario: Get all projects on workspace
    Given call ClockyTpFinal.feature@ListWorkspace
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/projects
    When execute method GET
    Then the status code should be 200
    * define projectId = $.[0].id
    * define userId = $.[0].memberships.[0].userId

  @ListTimeEntries
  Scenario: Get time entries for a user on workspace
    Given call ClockyTpFinal.feature@ListWorkspace
    And call ClockyTpFinal.feature@ListProject
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/user/{{userId}}/time-entries
    When execute method GET
    Then the status code should be 200
    * define timeEntryId = $.[0].id

  @AddProjectHours
  Scenario: Add time entry to a project
    Given call ClockyTpFinal.feature@ListWorkspace
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/time-entries
    And body add_time_entry.json
    When execute method POST
    Then the status code should be 201
#
#  @projectById
#  Scenario: Find project by ID
#    Given call project1.feature@listWorkspace
#    And call project1.feature@listProject
#    And base url https://api.clockify.me/api
#    And endpoint /v1/workspaces/{{id}}/projects/{{IdProject}}
#    When execute method GET
#    Then the status code should be 200