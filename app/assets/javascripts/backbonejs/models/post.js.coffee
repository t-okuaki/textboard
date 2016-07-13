@Post = Backbone.Model.extend
  urlRoot: '/posts'
  defaults:
    author: '名無しさん'
 
@Posts = Backbone.Collection.extend
  model: Post
  url: '/posts'

  startPolling: (@interval) ->
    @fetchInterval()

  fetchInterval: ->
    @fetch()
    setTimeout(_.bind(@fetchInterval, @), @interval)