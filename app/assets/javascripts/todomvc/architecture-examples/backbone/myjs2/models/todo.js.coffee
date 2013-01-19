app.TodoModel = Backbone.Model.extend
    defaults:
        title: ''
        completed: false
    toggle: -> @save { completed: !@get('completed') }
    status: -> if @get('completed') then 'completed' else 'active'