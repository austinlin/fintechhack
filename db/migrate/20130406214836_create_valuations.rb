class CreateValuations < ActiveRecord::Migration
  def change
    create_table :valuations do |t|
      t.decimal :stock_price
      t.integer :fund_id
      t.date :day
      t.decimal :value
      t.timestamps
    end
  end
end