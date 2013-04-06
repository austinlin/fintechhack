class Addcolstofunds < ActiveRecord::Migration
  def change
  	add_column :funds, :fund_type, :string
  	add_column :funds, :ticker, :string
  end
end
