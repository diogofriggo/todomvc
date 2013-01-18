Feature: App
  In order start the application
  As a Backbone learner
  I want to detail it step-by-step

  Scenario: Setup
    Then Declare global variable for the application
    Then Declare global variable for the ENTER_KEY
    And Scaffold a module to encapsulate the code

  Scenario: Constructor
    Given I want to kick-off the application
    Then Create a new app.AppView