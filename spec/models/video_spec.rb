require 'rails_helper'

describe Video, type: :model do
  describe 'validations' do
    it {should validate_numericality_of(:position).only_integer}
    it {should validate_numericality_of(:position).is_greater_than_or_equal_to(0)}
  end
  describe 'relationships' do
    it {should have_many(:bookmarks)}
    it {should have_many(:users).through(:bookmarks)}
    it {should belong_to(:tutorial)}
  end
end
