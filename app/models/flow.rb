class Flow < ActiveRecord::Base
  attr_accessible :fund_id, :day, :cashflow, :stock_price, :total_shares

  validates :fund_id, presence: true
  validates :day, presence: true
  validates :cashflow, presence: true
  validates :fund, presence: true

  default_scope order: 'flows.day'

  belongs_to :fund

  def self.import(file)
  	CSV.foreach(file.path, headers: true) do |row|
  		flow = find_by_fund_id_and_day(row["fund id"], Date.strptime(row["date"], "%m/%d/%y")) || 
  			Flow.new(fund_id: row["fund id"], day: Date.strptime(row["date"], "%m/%d/%y"))
  		flow.assign_attributes(cashflow: row["cash flow"])
  		flow.save!
  	end
  end
end