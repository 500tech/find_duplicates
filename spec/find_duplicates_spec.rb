require 'spec_helper'
require 'pry'
describe FindDuplicates do
  before do 
    setup
  end

  context 'duplicate records' do
    before do
      @first = TestDuplicates.create!(title: 'first!')
      @second = TestDuplicates.create!(title: 'second!')
      @third = TestDuplicates.create!(title: 'first!')
    end

    it 'class duplicates' do
      expect(TestDuplicates.duplicates(:title)).not_to be_empty
    end
    it 'instance duplicates' do
      expect(@first.duplicates(:title)).to match_array([@third])
    end
    it 'duplicates_with_self' do
      expect(@first.duplicates_with_self(:title)).to match_array([@first, @third])
    end
    it 'duplicate?' do
      expect(@first.duplicate?(:title)).to be_truthy
    end
  end
  context 'no duplicate records' do
    before do
      @first = TestDuplicates.create!(title: 'first!')
      @second = TestDuplicates.create!(title: 'second!')
      @third = TestDuplicates.create!(title: 'third!')
    end
    it 'duplicates' do
      expect(TestDuplicates.duplicates(:title)).to be_empty
    end
    it 'instance duplicates' do
      expect(@first.duplicates(:title)).to be_empty
    end
    it 'duplicates_with_self' do
      expect(@first.duplicates_with_self(:title)).to match_array([@first])
    end
    it 'duplicate?' do
      expect(@first.duplicate?(:title)).to be_falsey
    end
  end
end


