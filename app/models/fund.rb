class Fund < ActiveRecord::Base
  attr_accessible :name, :fund_type, :ticker
  	
  VALID_FUND_TYPES = ['Buyout', 'Energy', 'Growth', 'Real Estate', 'Opportunistic', 'Venture']

  validates :name, presence: true, uniqueness: true
  validates :fund_type, inclusion: { :in => VALID_FUND_TYPES, message: "%{value} is not a valid fund type"}
  validates :ticker, uniqueness: true



end