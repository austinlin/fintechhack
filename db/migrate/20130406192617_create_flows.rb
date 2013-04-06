class CreateFlows < ActiveRecord::Migration
  def change
    create_table :flows do |t|
      t.date :day
      t.integer :fund_id
      t.decimal :cashflow #this is a call or distribution
      t.decimal :stock_price
      t.decimal :total_shares
      t.timestamps
    end
  end
end