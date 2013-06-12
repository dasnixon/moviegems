# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#
$ ->
  $('.admin_director').click ->
    user_id = $(this).attr('id')
    action = $(this).attr('data-action')
    $.ajax ->
      type: 'POST',
      url: '/admin/' + action + '_director/' + user_id,
      data: { user_id: id },
      success:(data) ->
        alert "SUCCESS"
        return false
      error:(data) ->
        alert "ERROR"
        return false
