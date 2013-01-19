$ ->
    app.TodoModel = Backbone.Model.extend
        defaults:
            title: ''
            completed: false
        toggle: (completed) ->
            this.save
                completed: completed
        status: ->
            if this.get('completed') then 'completed' else 'active'
