#= require base-app

#= require views/application

app.addInitializer ->
  console.log 'here'
  app.view = new app.AppView el: $("content")[0]
  app.view.render()