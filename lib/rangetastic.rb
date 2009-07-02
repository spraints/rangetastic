module Rangetastic
  
  def self.included(base)
    base.extend ClassMethods
  end
  
  module ClassMethods
    def acts_as_rangetastic(options = {:fields => []})
      named_scope :between, lambda{ |start_date, end_date, field|
        raise(ActiveRecord::StatementInvalid) unless options[:fields].include?(field)
        build_between_condition(start_date, end_date, field)
      }

      options[:fields].each do |field|
        scope_name = (field.sub(/_on$/,'') + '_between')
        named_scope scope_name, lambda { |start_date, end_date|
          build_between_condition(start_date, end_date, field)
        }
      end
    end

    private
    def build_between_condition(start_date, end_date, field)
      { :conditions => ["#{field} >= ? AND #{field} <= ?", start_date, end_date] }
    end
  end
end

ActiveRecord::Base.class_eval do
  include Rangetastic
end
