export default {
  template: '#vue-template-messages',

  data() {
    return {
      isOpen: false,
    }
  },

  methods: {
    api_request (url, data) {
      const method = 'POST'
      const body = JSON.stringify(data)
      const headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      }
      fetch(url, {method, headers, body})
        .then((res)=> res.json())
        .catch(console.error)
    },
    open () {
      if (this.isOpen) return
      this.isOpen = true
      $('.chat').find('.new-icon').css('display', 'none')
      const message_id = $('#messages').find('p').last().attr('id')
      this.api_request(`/api/read_message/${$('#messages').data('customer_room_id')}`, {message_id: message_id})
    },
    close () {
      if (!this.isOpen) return
      this.isOpen = false
    }
  },
}