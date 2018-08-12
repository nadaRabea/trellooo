require 'rails_helper'

RSpec.describe List, type: :model do
  describe 'Associations' do
    it { should belong_to(:creator) }
    it { should have_and_belong_to_many(:users) }
    it { should have_many(:cards).dependent(:destroy) }
  end
end
