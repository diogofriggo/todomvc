Feature: TodoView
  In order to understand how TodoView works
  As a Backbone learner
  I want to detail it step-by-step

  Scenario: Setup
    Then Declare global variable for the application
    And Scaffold a module to encapsulate the code

  Scenario: TagName
    Given I want to render this view to an html element
    Then Set this variable to the tag of that element, so that Backbone can create it
    And since it's a list this tag is a list item

  Scenario: Template
    Given I want to hold a reference to the todo item template
    Then Use Lo-Ash's template method (https://github.com/bestiejs/lodash)
    And Pass it the html of the desired template

  Scenario: Events
    Given I want my view to respond to its events
    Scenario:
      When I click one of the todo's respective checkbox
      Then Fire #ToggleCompleted
    Scenario:
      When I double click a todo's text (label)
      Then Fire #Edit
    Scenario:
      When I click on the red X that appear when I hover over a todo
      Then Fire #Clear
    Scenario:
      When I press a key on the todo's input
      Then Fire #UpdateOnEnter
    Scenario:
      When I leave the input I was editing (blur)
      Then Fire #Close

  Scenario: Initialize
    Given I want to listen to the events triggered on my app.Todo Model
    Then On change   fire #render
    Then On destroy  fire #remove
    Then On visible  fire #toggleVisible

  Scenario: Render
    Given I want to fill this view's element with the respective model's data
    Then Convert the model to JSON
    And Bind that to the template
    And Set the html of this view's element to that bound template
    Then Call this.toggleVisible
    And Assign this.$input to this.$('.edit')
    And Return this

  Scenario: ToggleVisible
    Given I want to toggle the visibility of this view
    Then toggle the class 'hidden' of this.$el based on this#isHidden()

  Scenario: IsHidden
    Given I want to report whether a todo is hidden based on its status and the selected filters
    | true -> Status = Completed and Filter = Active
    | true -> Status = Active and Filter = Completed

  Scenario: ToggleCompleted
    Given I want to check or uncheck all todos
    Then call the model's toggle method

  Scenario: Edit
    Given I want to turn a label into an input for editing
    Then Add class 'editing' to this element
    Then Focus the input

  Scenario: Close
    Given This method handles the event blur of the input
    And I want to save the update performed on the input
    Scenario: The input after being trimmed is not empty
      Then Call this.clear that it'll take care of destrying the model
    Scenario: The input after being trimmed is not empty
      Then Save the model with the new title

  Scenario: UpdateOnEnter
    Given I want to save the update performed on the input
    When The enter key is pressed
    Then Call this.close that it'll take care of updating

  Scenario: Clear
    Given That the model saved turned out to have an empty title
    Then Destroy this model