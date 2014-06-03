require "find_duplicates/version"
require 'active_record'
require 'active_support/concern'

module FindDuplicates
  extend ActiveSupport::Concern
  def duplicate?(*args)
    set_fields(args)
    duplicates_with_self(@fields).count > 1
  end

  def duplicates(*args)
    set_fields(args)
    duplicates_with_self(@fields).where('id <> ?', id)
  end

  def duplicates_with_self(*args)
    set_fields(args)
    self.class.where(self.attributes.slice(*@fields))
  end
  module ClassMethods
    def duplicates(*args)
      set_fields(args)
      self.joins("join (
            select #{fields_str}, count(*) as qty
            from #{self.table_name}
            group by #{fields_str}
            having count(*) > 1
        ) t on #{fields_query}").all
    end
    private
      def set_fields(args)
        @fields = args.is_a?(Array) ? args : [args]
        @fields = @fields.flatten.map &:to_s
      end
      def fields_str
        @fields.join(',')
      end
      def fields_query
        @fields.map {|f| "#{self.table_name}.#{f} = t.#{f}"}.join(' and ')
      end
  end

  private
    def set_fields(args)
      @fields = args.is_a?(Array) ? args : [args]
      @fields = @fields.flatten.map &:to_s
    end
end

class ActiveRecord::Base
  include FindDuplicates
end
