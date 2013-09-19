#= require base-app

#= require views/application

#= require vendor/prettify
#= require vendor/EventSource
#= require vendor/console



app.addInitializer ->
  console.log 'here'
  app.view = new app.views.Application el: $(".content")[0]
  app.view.render()
