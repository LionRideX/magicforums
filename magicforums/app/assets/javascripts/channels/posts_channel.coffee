postsChannelFunctions = () ->

  checkMe = (comment_id, username) ->
    unless $('meta[name=admin]').length > 0 || $("meta[user=#{username}]").length > 0
      $("#comment_#{comment_id}] .comment2").remove()
    $("#comment_#{comment_id}]").removeClass("hidden")


  createComment = (data) ->
    if $('.comment-index').data().id
     $('#comments').append(data.partial)
    checkMe(data.comment.id)

  updateComment = (data) ->
    if $('.comment-index').data().id
     $("#comment_#{data.comment.id}").after(data.partial).remove()
    checkMe(data.comment.id)

  destroyComment = (data) ->
    if $('.comment-index').data().id
     $("#comment_#{data.comment.id}").remove()
    checkMe(data.comment.id)



  if $('.comment-index').length > 0
    App.posts_channel = App.cable.subscriptions.create {
      channel: "PostsChannel"
    },
    connected: () ->

    disconnected: () ->

    received: (data) ->
      if $('.comment-index').data().id == data.post.id
        switch data.type
          when "create" then createComment(data)
          when "update" then updateComment(data)
          when "destroy" then destroyComment(data)

$(document).on 'turbolinks:load', postsChannelFunctions
