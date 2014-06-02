require "find_duplicates/version"
require 'active_record'
require 'active_support/concern'

module FindDuplicates
  extend ActiveSupport::Concern
  def duplicate?(field)
    duplicates_with_self(field).count > 1
  end

  def duplicates(field)
    duplicates_with_self(field).where('id <> ?', id)
  end

  def duplicates_with_self(field)
    self.class.where(field => self[field])
  end
  module ClassMethods
    def duplicates(field)
      field = field.to_sym
      where field => self.select(['count(*)', field]).group(field).having('count(*) > 1').map(&field)
    end
  end
end

class ActiveRecord::Base
  include FindDuplicates
end
