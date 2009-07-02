module Rangetastic
  
  def self.included(base)
    base.extend ClassMethods
  end
  
  module ClassMethods
    def acts_as_rangetastic(options = {:fields => []})
      named_scope :between, lambda{ |start_date, end_date, fieldname|
        field = options[:fields].include?(fieldname) ? fieldname : raise(ActiveRecord::StatementInvalid)
        { :conditions => ["#{field} >= ? AND #{field} <= ?", start_date, end_date] }
      }

      options[:fields].each do |field|
        scope_name = (field.sub(/_on$/,'') + '_between')
        named_scope scope_name, lambda { |start_date, end_date|
          { :conditions => ["#{field} >= ? AND #{field} <= ?", start_date, end_date] }
        }
      end
    end
  end
end

ActiveRecord::Base.class_eval do
  include Rangetastic
end
