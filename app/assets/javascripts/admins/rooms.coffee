$(document).ready ->
  $('.room').on 'ajax:success', (event) ->
    room = $("#room_id_#{$('#messages').data('room_id')}")
    room.find('.timestamp').removeClass('unread')