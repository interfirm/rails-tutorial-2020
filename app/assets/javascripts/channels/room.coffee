App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    if $('#messages').data('room_id') == data['room_id']
      if $('#messages').data('sender') == 'admin' && data['sender'] == 'customer'
        api_request("/api/admins/read_message/#{$('#messages').data('admin_room_id')}", {message_id: data['message_id']})

      if $('#messages').data('sender') == 'customer' && data['sender'] == 'admin'
        if $('.chat').find('.content').css('display') == 'block'
          api_request("/api/read_message/#{$('#messages').data('customer_room_id')}", {message_id: data['message_id']})
        else
          $('.chat').find('.new-icon').css('display', 'block')

      $('#messages').append data['message']

    if location.pathname == '/admins/rooms'
      if !$("#room_id_#{data['room_id']}").find('.timestamp').hasClass("unread")
        $("#room_id_#{data['room_id']}").find('.timestamp').addClass('unread')

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