_.each ['item-template', 'stats-template'], (name) ->
    $.ajax
        async: true,
        url: "../templates/#{name}",
        success: (html) ->
            $('body').append("<script type='text/template' id='#{name}'>#{html}</script>")