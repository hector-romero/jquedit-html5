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
App =
  addInitializer: (initializer) ->
    throw "Initializer is not a  funcition" unless _.isFunction(initializer)
    initializers.push initializer


  onLoad: ->
#    onDeviceReady ->
    for initializer in initializers
      initializer()

#Exports:
window.app = App


