app.TodoView = Backbone.View.extend
    tagName: 'li'
    template: _.template($('#item-template').html())
    events:
        'click :checkbox.toggle': 'toggle'
        'click :button.destroy': 'destroy'
        'dblclick li label': 'beginEdit'
        'blur :text.edit': 'endEdit'
        'keypress :text.edit': 'keypress'
    initialize: ->
        this.listenTo(this.model, 'change', this.render)
        this.listenTo(this.model, 'destroy', this.remove)
        this.listenTo(this.model, 'visible', this.toggleVisible)
    render: ->
        this.$el.html(this.template(this.model.toJSON()))
        this.$el.toggleClass('completed', this.model.get('completed'))
        this.$el.toggleClass('hidden', this.shouldBeHidden())
        this.$input = this.$('.edit')
        this
    shouldBeHidden: ->
        this.model.status() != app.TodoFilter
    toggle: ->
        this.model.toggle()
    destroy: ->
        this.model.destroy()
    beginEdit: ->
        this.$el.addClass('editing')
        this.$input.focus()
    endEdit: ->
        this.$el.removeClass('editing')
        if this.$input.is(':empty') then this.model.destroy()
        else this.model.save({ title: this.$input.val() })
    keypress: (event) ->
        this.endEdit() if event.which == app.EVENT_KEY