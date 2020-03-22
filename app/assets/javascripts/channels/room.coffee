App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    room_id = data['room_id']
    if $('#messages').data('room_id') == room_id
      if $('#messages').data('sender') == 'admin' && data['sender'] == 'ゲスト'
        api_request("/api/admins/read_message/#{$('#messages').data('admin_room_id')}", {message_id: data['message_id']})

      if $('#messages').data('sender') == 'customer' && data['sender'] == 'サポート'
        if $('.chat').find('.content').css('display') == 'block'
          api_request("/api/read_message/#{$('#messages').data('customer_room_id')}", {message_id: data['message_id']})
        else
          $('.chat').find('.new-icon').css('display', 'block')

      $('#messages').append "<p>#{data['sender']}: #{data['message']}</p>"

    if location.pathname == '/admins/rooms'
      room = $("#room_id_#{room_id}")
      room.find('.timestamp').text(data['timestamp'])
      room.find('.content').text("#{data['sender']}: #{data['message']}")
      if $('#messages').data('room_id') != room_id && !room.find('.timestamp').hasClass("unread")
        room.find('.timestamp').addClass('unread')

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