#= require base-app

#= require views/application

app.addInitializer ->
  console.log 'here'
  app.view = new app.views.Application el: $(".content")[0]
  app.view.render()