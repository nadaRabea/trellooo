require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Associations' do
    it do
      should have_many(:created_lists)
        .class_name('List')
        .with_foreign_key('creator_id')
        .dependent(:destroy)
    end  
    it { should have_and_belong_to_many(:lists) }
    it { should have_many(:cards).dependent(:destroy) }    
    it { should have_many(:comments).dependent(:destroy) }
  end
end
