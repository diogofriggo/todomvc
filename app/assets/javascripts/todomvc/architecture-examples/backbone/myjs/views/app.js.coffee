$ ->
    app.AppView = Backbone.View.extend
        el: '#todoapp'
        statsTemplate: _.template($('#stats-template').html()),
        events:
            'keypress :text#new-todo': 'keypress'
            'click :button#clear-completed': 'clear'
            'click :checkbox#toggle-all': 'toggle'
        initialize: ->
            this.$checkbox = $(':checkbox#toggle-all')
            this.$input = $(':text#new-todo')
            this.$list = $('ul#todo-list')
            this.$header = $('header')
            this.$main = $('section#main')
            this.$footer = $('footer')

            this.listenTo(app.TodoCollection, 'add', this.addOne)
            this.listenTo(app.TodoCollection, 'reset', this.addAll)
            this.listenTo(app.TodoCollection, 'change:completed', this.filterOne)
            this.listenTo(app.TodoCollection, 'filter', this.filterAll)
            this.listenTo(app.TodoCollection, 'all', this.render)

            app.TodoCollection.fetch()
        render: ->
            if app.TodoCollection.isEmpty()
                this.$main.hide()
                this.$footer.hide()
            else
                this.$main.show()
                this.$footer.show()
                this.$footer.html(
                    this.statsTemplate(
                        completed: app.TodoCollection.completed().length
                        remaining: app.TodoCollection.remaining().length
                    )
                )
                $('ul#filters li a')
                    .removeClass('selected')
                    .filter("[href$=#{app.TodoFilter}]")
                    .addClass('selected')
                this.$checkbox.attr('checked', app.TodoCollection.all (todo) -> todo.get('completed'))
        addOne: (todo) ->
            li = new app.TodoView({ model: todo}).render().el
            this.$list.append(li)
        addAll: ->
            this.$list.html('')
            app.TodoCollection.each(this.addOne, this)
        filterOne: (todo) ->
            todo.trigger('visible')
        filterAll: ->
            app.TodoCollection.each(this.filterOne, this)
        keypress: (event) ->
            title = this.$input.val().trim()
            if event.which == app.ENTER_KEY and title
                app.TodoCollection.create
                    title: title
                    order: app.TodoCollection.nextOrder()
                    completed: false
                this.$input.val('')
        clear: ->
            app.TodoCollection.each (todo) -> todo.destroy() if todo.get('completed')
        toggle: ->
            app.TodoCollection.each (todo) -> todo.save({ completed: this.$checkbox.is(':checked') })