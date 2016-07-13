# 投稿一覧
@PostsView = Backbone.View.extend
  el: '#posts'
 
  initialize: ->
    @render()
    @listenTo(@collection, 'add', @addNew)
 
  addNew: (post) ->
    postView = new PostView(model: post)
    postView.render().$el
      .css("opacity", 0)
      .appendTo(@$el)
      .fadeTo(200, 1)
      .effect('highlight', {}, 500)
 
  render: ->
    @collection.each (post, i) =>
      postView = new PostView(model: post, index: i)
      @$el.append(postView.render().el)
    @
 
# 投稿
@PostView = Backbone.View.extend
  tagName: 'div'
  className: 'post'
  template: _.template($('#post-template').html())
  initialize: (@options) ->
  render: ->
    template = @template
      author: @model.get('author')
      created_at: moment(@model.get('created_at')).format('YYYY-MM-DD HH:mm:ss')
      body: @model.get('body')
      index: @options.index
    @$el.html(template)
    @

# 新規投稿
@AddPostView = Backbone.View.extend
  el: '#add-post'
  events:
    submit: 'submit'

  initialize: ->
    @initForm(new Post())

  # 登録フォームの初期化
  initForm: (post) ->
    $('#author').val(post.get('author'))
    $('#body').val(null)

  # 登録
  submit: (e) ->
    e.preventDefault()
    post = new Post(author: $('#author').val(), body: $('#body').val())
    @collection.fetch().then =>
      post.save().then =>
      @collection.add(post)
      @initForm(post)