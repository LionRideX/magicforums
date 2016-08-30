votesChannelFunctions = () ->

  if $('.comment-index').length > 0
    App.votes_channel = App.cable.subscriptions.create {
      channel: "VotesChannel"
    },
    connected: () ->
    disconnected: () ->
    received: (data) ->
      $("#comment_#{data.comment.id} .voting-score").html(data.value)

$(document).on 'turbolinks:load', votesChannelFunctions
