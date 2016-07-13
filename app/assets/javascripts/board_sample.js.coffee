jQuery ->
  posts = new Posts()
  posts.startPolling(5 * 1000)
  new PostsView(collection: posts)
  new AddPostView(collection: posts)