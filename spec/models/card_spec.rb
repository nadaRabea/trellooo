require 'rails_helper'

RSpec.describe Card, type: :model do
  describe 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:list) }
    it { should have_many(:comments) }
  end
end
