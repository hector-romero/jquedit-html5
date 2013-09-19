#= require base-app
#= require views/templates/application

class app.AppView extends Backbone.View

  render: ->
    console.log 'renderx'
    @$el.html JST['views/templates/application']()

