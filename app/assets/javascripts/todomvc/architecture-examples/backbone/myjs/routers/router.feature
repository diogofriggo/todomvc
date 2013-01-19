Feature: TodoRouter
  In order to understand how TodoRouter works
  As a Backbone learner
  I want to detail it step-by-step

  Scenario: Setup
    Then Declare global variable for the application
    And Scaffold a module to encapsulate the code

  Scenario: Constructor
    Then Extend Backbone.Router
    And Assign the result to Workspace

  Scenario: Routes
    Given I want to declare a route definition
    Then Bind '*filter' to #setFilter

  Scenario: SetFilter
    Given I want to trigger the Collection#filter event
    And As a result hide or show models based on the routed filter
    And I receive a param argument
    Then Trim the param
    And Trigger the Collection#filter event

  Scenario: Finally
    Given I want to store this Router in the app global variable
    Then Instantiate this Router
    And Assign it to app.TodoRouter
    Given I want to start the routing
    Then call Backbone.history.start