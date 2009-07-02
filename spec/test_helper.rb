class TestHelper
  attr_accessor :host, :username, :password
  attr_reader   :path
  
  def initialize
    @host     = "localhost"
    @username = "chris" #Insert username for db here
    @password = ""

    @path = File.expand_path(File.dirname(__FILE__))
  end
  
  def setup_postgresql
    ActiveRecord::Base.establish_connection(
      :adapter  => 'sqlite3',
      :database => 'tmp/testdb.sqlite3'
    )
    ActiveRecord::Base.logger = Logger.new(File.open("tmp/activerecord.log", "a"))
    
    load("spec/fixtures/schema.rb")
    
    10.times do
      Order.create(:ordered_on => 2.weeks.ago, :fulfilled_on => 2.days.ago)
    end

    10.times do
      Order.create(:ordered_on => 3.weeks.ago, :fulfilled_on => 2.days.ago)
    end
    
    5.times do
      Order.create(:ordered_on => 1.weeks.ago, :fulfilled_on => 2.days.ago)
    end
      
  end
  
end
