# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#

removeUser = (id) ->
  $("#" + id).remove()

displayMessage = (action) ->
  $('.message').append(buildAlertDiv())
  $('.alert.alert-success').append(buildCloseLink())
  $('.alert.alert-success').append(buildInnerFlash(action))

buildAlertDiv = ->
  div = document.createElement('div')
  div.setAttribute('class', 'alert alert-success')
  return div

buildCloseLink = ->
  link = document.createElement('a')
  link.setAttribute('data-dismiss', 'alert')
  link.setAttribute('class', 'close')
  link.innerHTML = 'x'
  return link

buildInnerFlash = (action) ->
  innerDiv = document.createElement('div')
  if action == 'accept'
    innerHtml = 'Successfully accepted user.'
  else
    innerHtml = 'Successfully declined user.'
  innerDiv.innerHTML = innerHtml
  innerDiv.setAttribute('id', 'flash_notice')
  return innerDiv

$ ->
  $(".admin_director").click ->
    user_id = $(this).attr("data-id")
    action = $(this).attr("data-action")
    url = "/admin/director_action/" + user_id
    $.ajax({
      type: "POST",
      url: url,
      data: { user_id: user_id, action_perf: action },
      success:(data) ->
        removeUser(data.id)
        displayMessage(data.action_perf)
        return false
      error:(data) ->
        displayError()
        return false
    })
