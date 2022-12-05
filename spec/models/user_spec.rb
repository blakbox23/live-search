require 'rails_helper'

RSpec.describe 'User', type: :model do
    it 'has many searches' do
        a = User.reflect_on_association(:searches)
        expect(a.macro).to eq(:has_many)
      end
  end