Feature: Todo.Collection
  In order to understand how Todo.Collection works
  As a Backbone learner
  I want to detail it step-by-step

  Scenario: Setup
    Then Declare global variable for the application
    And Scaffold a module to encapsulate the code

  Scenario: Constructor
    Then Extend Backbone.Collection
    And Assign the result to a variable

  Scenario: Model
    Given Backbone.Collection requires a model to be passed
    Then Pass it app.Todo

  Scenario: LocalStorage
    Given I want to store my todos in the browser's localStorage
    And By definition not use a server-backed database
    Then Create new Store (defined by Backbone) passing in a name

  Scenario: Completed
    Given I want to show the todos that have been completed
    Then Filter todos that return true for todo.completed

  Scenario: Remaining
    Given I want to show the todos to be done
    Then Filter todos that are not in the set [todos that are completed]

  Scenario: NextOrder
    Given I want to order my todos sequentially - in the order they are added
    And Not by their guids
    Then Return 1 if there are no todos
    And Return last todo's order + 1 otherwise

  Scenario: Comparator
    Given This is a method defined by Backbone
    Then Return todo.order

  Scenario: Finally
    Given I want to store this Collection in the app global variable
    Then Instantiate this Collection
    And Assign it to app.Todos