
class PricePull
  # The Bloomberg API jar is saved in lib/java
  # It is used by the 'bberg' gem
  # BBERG_JAVA_HOME needs to be set to RAILS_ROOT/lib/java
  
  # ... ENV['BBERG_JAVA_HOME'] = Rails.root.join('lib', 'java').to_s
  
  # @param security Bloomberg ticker String, e.g. 'IBM US Equity' or 'SPX Index'
  # @param start_date type Date
  # @param end_date type Date
  #
  # @return hash of date, price pairs (types Date, Float)
  def self.get_for_range(security, start_date, end_date)
    require 'java'
    require 'bberg'
    
    server = '50.19.46.133'
    port   = 8194
    field  = 'PX_LAST'
    
    client = Bberg::Client.new(server, port)
    
    data = client.historical_data_request(security, start_date, end_date, fields: [field])
    data = data[security]
    # example data[security] for IBM 4/1-4/2:
    # [{"date"=>2013-04-01 00:00:00 -0400, "PX_LAST"=>212.38},
    # {"date"=>2013-04-02 00:00:00 -0400, "PX_LAST"=>214.36}]
    hash = {}
    data.each do |x|
      hash[x['date'].to_date] = x[field]
    end
    
    # example hash for IBM 4/1-4/2 (keys are type Date):
    # {Mon, 01 Apr 2013=>212.38,
    #  Tue, 02 Apr 2013=>214.36} 
    return hash
  end
  
  # @param security Bloomberg ticker String, e.g. 'IBM US Equity' or 'SPX Index'
  # @param date type Date
  #
  # @return price for given date (type Float)
  def self.get_for_date(security, date)
    get_for_range(security, date, date)[date]
  end
  
  def self.get(security, start_date, end_date)
    get_for_range(security, start_date, end_date)
  end
end
