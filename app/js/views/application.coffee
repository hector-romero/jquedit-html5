#= require base-app
#= require views/templates/application
#= require vendor/highlight.pack

app.module 'views', (views) ->

  class FileHandler extends Backbone.View
    _lastHTML: ''
    interval: ''

    validateChange: =>
      current = @$el.html()
      return if current == @_lastHTML
      @_lastHTML = current
      @trigger('change')

    setFile:(file) ->
      console.log "Setting file", file
      @fileResult = null
      return @render() unless file
      me = this
      reader =  new FileReader()
      reader.onload = (e)->
        me.fileResult = e.target
        me.render()
      reader.readAsText(file)

    render: ->
      console.log "render"
      if @fileResult
        console.log @fileResult
        @$el.html @fileResult.result
      else
        @$el.html '<!-- No file selected -->'
#      @_lastHTML = @$el.html()
#      @trigger 'change'

    getRaw: ->
#      escape = (value) ->
#          return ('' + value)
#            .replace(/&/g, '&amp;')
#            .replace(/</g, '&lt;')
#            .replace(/>/g, '&gt;')
#            .replace(/"/g, '&quot;')
#            .replace(/\n/g,'<br/>')
#            .replace(/\ /g,'&nbsp;')

#      escape @$el.html()
      hljs.highlightAuto( @$el.html()).value

    initialize: ->
      @render()
      @interval = setInterval(@validateChange,100)
      jquedit =(selector) =>
        res = @$(selector)
#        @trigger 'change'
        res
#        res.length
#        res.html()

      jQuery("iframe")[0].contentWindow.$ = jquedit
      jQuery("iframe")[0].contentWindow.jquedit = jquedit


  class views.Application extends Backbone.View
    events:
      'change .file' : 'newFile'

    newFile:(e) ->
      console.log 'here'
      input = e.target
      @fileHandler.setFile input.files[0]

    showFileRaw: ->
      console.log 'herree'
      @$(".fileRaw").html @fileHandler.getRaw()
      hljs.highlightBlock(@$(".fileRaw")[0])

    render: ->
      console.log 'renderx'
      console.log @$el
      @$el.html JST['views/templates/application']()
      @fileHandler = new FileHandler()# el: @$(".fileRaw")[0]
      @listenTo @fileHandler,'change', @showFileRaw
      @showFileRaw()
      @$el

