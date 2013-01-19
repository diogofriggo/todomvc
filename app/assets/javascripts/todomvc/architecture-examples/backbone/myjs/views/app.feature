Feature: AppView
  In order to understand how AppView works
  As a Backbone learner
  I want to detail it step-by-step

  Scenario: Setup
    Then Declare global variable for the application
    And Scaffold a module to encapsulate the code
    And Pass jQuery to this module

  Scenario: El
    Given I want to render this view to an html element
    Then Set this variable to the id of that element

  Scenario: StatsTemplate
    Given I want to hold a reference to the { 1 Item Left - All | Active | Completed - Clear Completed } template
    Then Use Lo-Ash's template method (https://github.com/bestiejs/lodash)
    And Pass it the html of the desired template

  Scenario: Events
    Given I want my view to respond to its events
    Scenario:
      When I press a key on the todo's input
      Then Fire #CreateOnEnter
    Scenario:
      When I click on clear completed
      Then Fire #ClearCompleted
    Scenario:
      When I click on the uppermost checkbox
      Then Fire #ToggleAllComplete

  Scenario: Initialize
    Scenario: Instance variables
      Given I want to hold on to certain variables so that they are accessible throughout this view
      Then allCheckbox = the uppermost checkbox element
      Then $input = the main input field where we type todos
      Then $footer = the footer that holds the stats information
      Then $main = the container that holds the list of todos and the uppermost checkbox
    Scenario: Listeners
      Given I want to listen to the events triggered on my app.Todos collection
      Then On add               fire #addOne
      Then On reset             fire #addAll
      Then On change:completed  fire #filterOne
      Then On filter            fire #filterAll
      Then On all               fire #render
    Scenario: Fetch
      Given This view starts I want to load all the todos that may be on the browser's localStorage
      Then Call the app.Todo collection's fetch method

  Scenario: Render
      Then Get count of how many todos are completed
      Then Get count of how many todos are remaining
      Scenario: The Todos Collection is not empty
        Scenario: Show
          Then Call show on the main container
          And Call show on the stats footer
        Scenario: Stats
          Then Set the stats footer's html to this.statsTemplate({ completed, remaining })
        Scenario: Main
          Given Foreach todo's anchor tag
          Then Remove the class 'selected'
          And Filter the one that matches the filter defined in the url
            | All -> "[href="#/"]"
            | Active -> "[href="#/active"]"
            | Completed -> "[href="#/completed"]"
          And Then add the class selected to it
        Scenario: Finally
          Then Set $checkbox.checked to wheter all todos are completed
      Scenario: The Todos Collection is empty
        Scenario: Hide
          Then Call hide on the main container
          And Call hide on the stats footer

  Scenario: AddOne
    Given I want to render a new Todo
    And I receive a TodoModel as an argument
    Then Instantiate a new TodoView passing a { model: TodoModel } to it
    And Call the view render method and get the el property
    And Now append that to the todo list

  Scenario: AddAll
    Given I want to render all Todos that may be on the browser's localStorage
    Then First clear the html of the todo list
    Then Foreach todo call #addOne
    And Pass this as context

  Scenario: FilterOne
    Given I want notify a model that it has been filtered
    And That it should take appropriate action like be shown or hidden
    Then trigger 'visible' on the given Todo Model

  Scenario: FilterAll
    Given I want notify all models that they've been filtered
    Then Foreach Todo Model trigger 'visible'

  Scenario: NewAttributes
    Given I want to return the attributes for a new model
    Then
      | title: the value of the input trimmed
      | order: collection#nextOrder
      | completed: false

  Scenario: CreateOnEnter
    Given I want to create a new todo
    When The user presses Enter
    And The text is not empty
    Then Create a new todo with the values from #newAttributes
    And Clear the input

  Scenario: ClearCompleted
    Given I want to remove all the todos that are completed
    Then invoke 'destroy' for all completed todos

  Scenario: ToggleAllComplete
    Given I want to check or uncheck all todos
    When I click the uppermost checkbox
    Then Foreach todo save it with 'completed' = value of the uppermost checkbox




