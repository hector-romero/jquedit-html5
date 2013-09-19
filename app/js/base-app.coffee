#= require vendor/jquery
#= require vendor/underscore
#= require vendor/backbone
#
#window.onDeviceReady = (fn) ->
#    if window.cordova # /(iPhone|iPod|iPad|Android)/.test navigator.userAgent
#      document.addEventListener 'deviceready', fn, false
#    else
#      fn()

initializers = []
modules = []
App =
  addInitializer: (initializer) ->
    throw "Initializer is not a  funcition" unless _.isFunction(initializer)
    initializers.push initializer


  module: (moduleName,fn) ->
      throw "Module name must be a string" unless _.isString(moduleName)
      throw "Module must be a function" unless _.isFunction(fn)
      App[moduleName] or= {}
      modules.push -> fn App[moduleName]


  onLoad: ->
#    onDeviceReady ->
    for module in modules
      module()
    for initializer in initializers
      initializer()

#Exports:
window.app = App


