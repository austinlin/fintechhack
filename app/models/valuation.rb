class Valuation < ActiveRecord::Base
  attr_accessible :stock_price, :fund_id, :day, :value

  validates :fund_id, presence: true
  validates :day, presence: true
  validates :value, presence: true

  default_scope order:'valuations.day'

  belongs_to :fund

  def self.import(file)
  	CSV.foreach(file.path, headers: true) do |row|
  		valuation = Valuation.find_by_fund_id_and_day(row["fund id"], Date.strptime(row["date"], "%m/%d/%y")) || 
  			Valuation.new(fund_id: row["fund id"], day: Date.strptime(row["date"], "%m/%d/%y"))
  		valuation.assign_attributes(value: row["value"])
  		valuation.save!
  	end
  end
end
