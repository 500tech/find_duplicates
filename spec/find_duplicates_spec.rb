require 'spec_helper'
require 'pry'
describe FindDuplicates do
  before do 
    setup
  end

  context 'single' do
    context 'duplicate records' do
      before do
        @first = TestDuplicates.create!(title: 'first!')
        @second = TestDuplicates.create!(title: 'second!')
        @third = TestDuplicates.create!(title: 'first!')
      end

      it 'class duplicates' do
        expect(TestDuplicates.duplicates(:title)).to match_array([@first, @third])
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
  context 'multiple' do
    context 'duplicate records' do
      before do
        @first = TestDuplicatesMultiple.create!(first_name: 'first!', last_name: 'first!')
        @second = TestDuplicatesMultiple.create!(first_name: 'first!', last_name: 'first!')
        @third = TestDuplicatesMultiple.create!(first_name: 'second!', last_name: 'first!')
        @forth = TestDuplicatesMultiple.create!(first_name: 'first!', last_name: 'second!')
      end

      it 'class duplicates' do
        expect(TestDuplicatesMultiple.duplicates(:first_name, :last_name)).to match_array([@first, @second])
      end
      it 'instance duplicates' do
        expect(@first.duplicates(:first_name, :last_name)).to match_array([@second])
      end
      it 'duplicates_with_self' do
        expect(@first.duplicates_with_self(:first_name, :last_name)).to match_array([@first, @second])
      end
      it 'duplicate?' do
        expect(@first.duplicate?(:first_name, :last_name)).to be_truthy
      end
    end
    context 'no duplicate records' do
      before do
        @first = TestDuplicatesMultiple.create!(first_name: 'first!', last_name: 'first!')
        @second = TestDuplicatesMultiple.create!(first_name: 'first!', last_name: 'second!')
        @third = TestDuplicatesMultiple.create!(first_name: 'second!', last_name: 'first!')
      end
      it 'duplicates' do
        expect(TestDuplicatesMultiple.duplicates(:first_name, :last_name)).to be_empty
      end
      it 'instance duplicates' do
        expect(@first.duplicates(:first_name, :last_name)).to be_empty
      end
      it 'duplicates_with_self' do
        expect(@first.duplicates_with_self(:first_name, :last_name)).to match_array([@first])
      end
      it 'duplicate?' do
        expect(@first.duplicate?(:first_name, :last_name)).to be_falsey
      end
    end
  end
  context 'params' do
    it 'single param' do
      td = TestDuplicatesMultiple.new
      td.send(:set_fields, [:first_name])
      expect(td.instance_variable_get(:@fields)).to eql(['first_name'])
    end
    it 'multiple params' do
      td = TestDuplicatesMultiple.new
      td.send(:set_fields, [:first_name, :last_name])
      expect(td.instance_variable_get(:@fields)).to eql(['first_name', 'last_name'])
    end
    it 'params array' do
      td = TestDuplicatesMultiple.new
      td.send(:set_fields, [[:first_name, :last_name]])
      expect(td.instance_variable_get(:@fields)).to eql(['first_name', 'last_name'])
    end
  end
end


