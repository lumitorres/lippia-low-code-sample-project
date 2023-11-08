Feature: project clockify

  Background:

    And header Content-Type = application/json
    And header Accept = */*
    And header x-api-key = MjY5NWRlOTktYzBkZS00YWViLWJjZGItNjNiMjU2YTM2OTU1

  @crearworkspace
    Scenario: crear workspace exitosamente
    Given base url https://api.clockify.me/api/
    And endpoint /v1/workspaces
    And body crearworkspace.json
    And execute method POST
    Then the status code should be 201

  @workspaceId
  Scenario: Obtener workspaceId
    Given base url https://api.clockify.me/api/
    And endpoint /v1/workspaces
    When execute method GET
    Then the status code should be 200
    * define workId = $.[0].id

@prueba2
  Scenario Outline: Crear nuevo proyecto en un workspace
    Given call project.feature@workspaceId
    And base url https://api.clockify.me/api/
    And endpoint /v1/workspaces/{{workId}}/projects
    And set value <nameProject> of key <name> in body crearproyecto.json
    When execute method POST
    Then the status code should be 201

    Examples:
    |nameProject         |
    |       "proyecto1"    |
    |       "proyecto2"    |
    |       "proyecto3"    |

@proyectoId
Scenario: Get all projects on workspace
  Given call project.feature@workspaceId
  And base url https://api.clockify.me/api/
  And endpoint /v1/workspaces/{{workId}}/projects
  When execute method GET
  Then the status code should be 200
  * define projectId = $.[0].id

@prueba3
  Scenario: consultar proyecto por Id
    Given call project.feature@proyectoId
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workId}}/projects/{{projectId}}
    When execute method GET
    Then the status code should be 200

  Scenario: modificar dato







