class Valuation < ActiveRecord::Base
  attr_accessible :stock_price, :fund_id, :day, :value

  validates :fund_id, presence: true
  validates :day, presence: true
  validates :value, presence: true

  default_scope order:'valuations.day'

  belongs_to :fund

end
