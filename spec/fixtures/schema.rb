ActiveRecord::Schema.define do
  create_table "orders", :force => true do |t|
    t.datetime :ordered_on, :fulfilled_on, :shipped_on
    t.timestamps
  end
end
