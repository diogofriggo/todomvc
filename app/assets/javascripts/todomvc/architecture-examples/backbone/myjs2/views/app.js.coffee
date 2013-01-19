$ ->
    app.AppView = Backbone.View.extend
        el: '#todo-app'
        statsTemplate: _.template($('#stats-template').html()),
        events:
            'keypress :text#new-todo': 'keypress'
            'click :button#clear-completed': 'clear'
            'click :checkbox#toggle-all': 'toggle'
        initialize: ->
            @$checkbox = $(':checkbox#toggle-all')
            @$input = $(':text#new-todo')
            @$list = $('ul#todo-list')
            @$header = $('header')
            @$main = $('section#main')
            @$footer = $('footer')

            @listenTo(app.TodoCollection, 'add', @addOne)
            @listenTo(app.TodoCollection, 'reset', @addAll)
            @listenTo(app.TodoCollection, 'change:completed', @filterOne)
            @listenTo(app.TodoCollection, 'filter', @filterAll)
            @listenTo(app.TodoCollection, 'all', @render)

            app.TodoCollection.fetch()
        render: ->
            if app.TodoCollection.isEmpty()
                @$main.hide()
                @$footer.hide()
            else
                @$main.show()
                @$footer.show()
                @$footer.html(@statsTemplate(
                    completed: app.TodoCollection.completed().length
                    remaining: app.TodoCollection.remaining().length
                ))
                $('ul#filters li a')
                    .removeClass('selected')
                    .filter("[href$=#{app.TodoFilter}]")
                    .addClass('selected')
            @$checkbox.attr('checked', app.TodoCollection.all (todo) -> todo.get('completed'))
        addOne: (todo) ->
            li = new app.TodoView({ model: todo}).render().el
            @$list.append(li)
        addAll: ->
            @$list.html('')
            app.TodoCollection.each(@addOne, this)
        filterOne: (todo) ->
            todo.trigger('visible')
        filterAll: ->
            app.TodoCollection.each(@filterOne, this)
        keypress: (event) ->
            title = @$input.val().trim()
            if event.which == app.ENTER_KEY and title
                app.TodoCollection.create
                    title: title
                    order: app.TodoCollection.nextOrder()
                    completed: false
                @$input.val('')
        clear: -> _.invoke(app.TodoCollection.completed(), 'destroy');
        toggle: ->
            checked = @$checkbox.is(':checked')
            _.invoke(app.TodoCollection.toArray(), 'save', { completed: checked });