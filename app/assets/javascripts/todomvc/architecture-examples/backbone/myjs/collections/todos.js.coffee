$ ->
    TodoCollection = Backbone.Collection.extend
        model: app.TodoModel
        localStorage: new Store('todos')
        completed: ->
            app.TodoCollection.filter (todo) ->
                todo.get('completed')
        remaining: ->
            app.TodoCollection.difference(this.completed());
        nextOrder: ->
            return 1 if app.TodoCollection.isEmpty()
            app.TodoCollection.last().get('order') + 1
        comparator: (todo) ->
            todo.get('order')

    app.TodoCollection = new TodoCollection()