Feature: Todo.Model
  In order to understand how Todo.Model works
  As a Backbone learner
  I want to detail it step-by-step

  Scenario: Setup
    Then Declare global variable for the application
    And Scaffold a module to encapsulate the code

  Scenario: Constructor
    Then Extend Backbone.Model
    And Assign the result to app.Todo

  Scenario: Defaults
    Given This model has two properties, "title" and "completed" respectively
    Then Set "title" to empty string
    And Set "completed" to false

  Scenario: Toggle
    Given I want to set the model to done or todo
    When I change the value of this Todo's checkbox (set it to checked or unchecked)
    Then I want model.completed? to equal checkbox.checked?