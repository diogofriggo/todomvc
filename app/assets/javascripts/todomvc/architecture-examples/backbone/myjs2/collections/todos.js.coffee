TodoCollection = Backbone.Collection.extend
    model: app.TodoModel
    localStorage: new Store('todos-backbone')
    completed: ->
        @filter (todo) -> todo.get('completed')
    remaining: ->
        @difference(@completed())
    nextOrder: ->
        if @isEmpty() then 1 else @last().get('order') + 1
    comparator: (todo) ->
        todo.get('order')
app.TodoCollection = new TodoCollection()