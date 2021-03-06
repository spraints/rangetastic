Introduction
============
Rangetastic allows you to filter results of a named_scope call on any dates using any of a list of whitelisted fields you specify.

Configuration & Usage
=====================

To acheive this you need to install rangetastic

    sudo gem install cherring-rangetastic
    
Then inside your environment.rb

    config.gem "cherring-rangetastic", :lib => "rangetastic", :source => "http://gems.github.com"
    
Then in your model pass in the fields you wish to allow to be searchable using the between filter

    class Order < ActiveRecord::Base
      acts_as_rangetastic :fields => ["ordered_on", "fulfilled_on"]
    end
    
You can then chain the between scope with any named_scope call you make:

    Order.fulfilled.between(1.week.ago, 10.minutes.ago, "fulfilled_on")
    Order.fulfilled.ordered_between(1.week.ago, 10.minutes.ago)
    
And if you (or someone nasty!) try to use a field that is not whitelisted, it will raise ActiveRecord::StatementInvalid
