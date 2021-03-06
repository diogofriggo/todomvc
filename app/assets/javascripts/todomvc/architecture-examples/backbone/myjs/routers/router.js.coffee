$ ->
    Workspace = Backbone.Router.extend
        routes:
            '*filter': 'setFilter'
        setFilter: (param) ->
            app.TodoFilter = param.trim() || '#\\/'
            app.TodoCollection.trigger('filter')
    app.TodoRouter = new Workspace()
    Backbone.history.start()