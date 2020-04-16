require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:room) { create(:room) }

  describe 'create' do
    subject { user.messages.build(content: 'hoge', room: room) }

    context 'Customerの場合' do
      let(:user) { create(:customer) }
      it 'messageを作成できる' do
        is_expected.to be_valid
      end
    end

    context 'Adminの場合' do
      let(:user) { create(:admin) }
      it 'messageを作成できる' do
        is_expected.to be_valid
      end
    end
  end

  describe 'sender_display_name' do
    before do
      user.messages.build(content: 'hoge', room: room)
    end

    subject { user.messages.first.messageable.sender_display_name }

    context 'Customerの場合' do
      let(:user) { create(:customer) }
      it { is_expected.to eq 'ゲスト' }
    end

    context 'Adminの場合' do
      let(:user) { create(:admin) }
      it { is_expected.to eq 'サポート' }
    end
  end

  describe 'sender' do
    before do
      user.messages.build(content: 'hoge', room: room)
    end

    subject { user.messages.first.messageable_type }

    context 'Customerの場合' do
      let(:user) { create(:customer) }
      it { is_expected.to eq 'Customer' }
    end

    context 'Adminの場合' do
      let(:user) { create(:admin) }
      it { is_expected.to eq 'Admin' }
    end
  end
end
