$ ->
    app.TodoView = Backbone.View.extend
        tagName: 'li'
        template: _.template($('#item-template').html())
        events:
            'click :checkbox.toggle':	'toggleCompleted'
            'click :button.destroy':    'destroy'
            'dblclick label':	        'beginEdit'
            'blur :text.edit':		    'endEdit'
            'keypress :text.edit':	    'keypress'
        initialize: ->
            @listenTo(@model, 'change', @render)
            @listenTo(@model, 'destroy', @remove)
            @listenTo(@model, 'visible', @toggleVisible)
        render: ->
            @$el.html(@template(@model.toJSON()))
            @$el.toggleClass('completed', @model.get('completed'))
            @toggleVisible();
            @$input = @$('.edit')
            this
        toggleVisible: ->
            @$el.toggleClass('hidden', @shouldBeHidden())
        shouldBeHidden: ->
            app.TodoFilter != 'all' and @model.status() != app.TodoFilter
        toggleCompleted: ->
            @model.toggle()
        destroy: ->
            @model.destroy()
        beginEdit: ->
            @$el.addClass('editing')
            @$input.focus()
        endEdit: ->
            title = @$input.val().trim()
            if title then @model.save({ title: title })
            else @model.destroy()
            @$el.removeClass('editing')
        keypress: (event) ->
            @endEdit() if event.which == app.ENTER_KEY