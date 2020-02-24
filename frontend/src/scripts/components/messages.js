export default {
  template: '#vue-template-messages',

  data() {
    return {
      isOpen: false,
    }
  },

  methods: {
    open () {
      if (this.isOpen) return
      this.isOpen = true
    },
    close () {
      if (!this.isOpen) return
      this.isOpen = false
    }
  },
}
