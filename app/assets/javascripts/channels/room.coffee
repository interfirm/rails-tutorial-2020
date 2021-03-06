App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    room_id = data['room_id']
    receiver = $('#messages').data('sender')
    sender = data['sender']
    sender_display_name = data['sender_display_name']

    message = data['message']
    message_id = data['message_id']
    message_room_id = $('#messages').data('room_id')

    if message_room_id == room_id
      if receiver == 'admin' && sender == 'Customer'
        api_request("/api/admins/read_message/#{$('#messages').data('admin_room_id')}", {message_id: message_id})

      if receiver == 'customer' && sender == 'Admin'
        if $('.chat').find('.content').css('display') == 'block'
          api_request("/api/read_message/#{$('#messages').data('customer_room_id')}", {message_id: message_id})
        else
          $('.chat').find('.new-icon').css('display', 'block')

      $('#messages').append "<p>#{sender_display_name}: #{message}</p>"

    if location.pathname == '/admins/rooms'
      room = $("#room_id_#{room_id}")
      timestamp = room.find('.timestamp')

      timestamp.text(data['timestamp'])
      room.find('.content').text("#{sender_display_name}: #{message}")
      if message_room_id != room_id && !timestamp.hasClass("unread")
        timestamp.addClass('unread')

  speak: (message, room_id, sender) ->
    @perform 'speak', message: message, room_id: room_id, sender: sender

api_request = (url, data) ->
  method = 'POST'
  body = JSON.stringify(data)
  headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json'
  }
  fetch(url, {method, headers, body})
    .then((res)=> res.json())
    .catch(console.error)
  return

$(document).on 'keypress', '[data-behavior~=room_speaker]', (event) ->
  if event.keyCode is 13 # return = send
    App.room.speak event.target.value, $('#messages').data('room_id'), $('#messages').data('sender')
    event.target.value = ''
    event.preventDefault()