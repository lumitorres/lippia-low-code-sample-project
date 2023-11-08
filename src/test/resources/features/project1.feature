Feature: Clockify

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
    * define id = $.[0].id

  @addProject
  Scenario Outline: Add a new project
    Given call project1.feature@ListWorkspace
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{id}}/projects
    And set value <projectName> of key name in body add_project.json
    When execute method POST
    Then the status code should be 201

    Examples:
      | projectName |
      | "Project_1" |
      | "Project_2" |
      | "Project_3" |


 @listProject
  Scenario: Get all projects on workspace
    Given call project1.feature@ListWorkspace
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{id}}/projects
    When execute method GET
    Then the status code should be 200
    * define IdProject = $.[1].id
   * define UserIdp = $.[1].userId

   @projectById
  Scenario: Find project by ID
    Given call project1.feature@listWorkspace
    And call project1.feature@listProject
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{id}}/projects/{{IdProject}}
    When execute method GET
    Then the status code should be 200


  @addProject2
  Scenario: add project for archive and delete
    Given call project1.feature@ListWorkspace
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{id}}/projects
    And body add_project_archived.json
    When execute method POST
    Then the status code should be 201

  @listProject2
  Scenario: Get all projects on workspace
    Given call project1.feature@ListWorkspace
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{id}}/projects
    When execute method GET
    Then the status code should be 200
    * define IdProject2 = $.[0].id

    @archivedProject
    Scenario: archived project
      Given call project1.feature@ListWorkspace
      #And call project1.feature@addProject2
      And call project1.feature@listProject2
      And base url https://api.clockify.me/api
      And endpoint /v1/workspaces/{{id}}/projects/{{IdProject2}}
      And body archived.json
      When execute method PUT
      Then the status code should be 200

      @deleteProject
      Scenario: delete project
        Given call project1.feature@ListWorkspace
        And call project1.feature@listProject2
        And call project.feature@archivedProject
        And base url https://api.clockify.me/api
        And endpoint /v1/workspaces/{{id}}/projects/{{IdProject2}}
        When execute method DELETE
        Then the status code should be 200
#ok
  @UpdateProjectOnWorkspace
  Scenario: Update project on Workspace
    Given call project1.feature@listWorkspace
    And call project1.feature@listProject
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{id}}/projects/{{IdProject}}
    And body update_project_on_workspace.json
    When execute method PUT
    Then the status code should be 200
    And response should be name = actualizacion nombre2
    And response should be note = actualizando datos del proyecto2


#nofunca
  @UpdateProjectEstimate
  Scenario: Update project estimate
    Given call project1.feature@listWorkspace
    And call project1.feature@listProject
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{id}}/projects/{{IdProject}}/estimate
    And body update_project.json
    When execute method PATCH
    Then the status code should be 200
    #And response should be budgetEstimate.estimate = "0"
    #And response should be timeEstimate.estimate = "PT2H35M"
    #And validate schema update_project.json

  @UpdateProjectMemberShip
  Scenario: Update project estimate
    Given call project1.feature@listWorkspace
    And call project1.feature@listProject
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{workspaceId}/projects/{projectId}/memberships
    And body membership.json
    When execute method PATCH
    Then the status code should be 200



  @UpdateProjectTemplate

  @UpdateProjectUserCostRate

#no funca UserID
  @UpdateProjectUserBillableRate
  Scenario: Update Project User Billable Rate
    Given call project1.feature@ListWorkspace
    And call project1.feature@listProject
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{id}}/projects/{{IdProject}}/users/{{UserIdp}}/hourly-rate
    And body billableRate.json
    When execute method PUT
    Then the status code should be 200
    And response should be amount = 1



#ok
  @UpdateProjectEstimateNotAuthorized
  Scenario: Update project estimate
    Given call project1.feature@ListWorkspace
    And call project1.feature@listProject
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{id}}/projects/{{IdProject}}/estimate
    And body update_project_not_authorized.json.json
    When execute method PATCH
    Then the status code should be 403
#ok
  @projectByIdNotFound
  Scenario Outline: Find project by ID not found
    Given call project1.feature@listWorkspace
    And call project1.feature@listProject
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{id}}/projects/<NumberId>
    When execute method GET
    Then the status code should be 400
    Examples:
    |NumberId|
    |653842877ad2b332b9ff6545|
    |653842877ad2b332b9ff6573|











