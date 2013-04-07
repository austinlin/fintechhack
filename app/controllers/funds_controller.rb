class FundsController < ApplicationController
  def new
    @fund = Fund.new
  end

  def create
    @fund = Fund.new(params[:fund])
    if @fund.save
      flash[:success] = "New fund created!"
      redirect_to fundmanagement_path
    else
      render 'new'
    end
  end

  def show
    @fund = Fund.find(params[:id])
    @flows = Flow.where(fund_id: @fund.id)
  end

  def edit
    @fund = Fund.find(params[:id])
  end

  def update
    @fund = Fund.find(params[:id])
    if @fund.update_attributes(params[:fund])
      flash[:success] = "Fund updated"
      redirect_to dashboard_path
    else
      render 'edit'
    end
  end

  def destroy
    Fund.find(params[:id]).destroy
    flash[:notice] = "Fund removed"
    redirect_to funds_path
  end

  def index
    
  end

  def dashboard
    @fund_chart2 = []
    @valuation_chart = []
    @valuation_chart_group = []
    @flow_chart_group = []
    @flow_chart1 = []
    @flow_chart2 = []
    @flow_chart3 = []
    @flow_chart3 = []
    @flow_chart4 = []
    @flow_chart5 = []
    @flow_chart6 = []
    @fund_counter = []
    @funds = Fund.order(:name)
    @categories = Fund.pluck(:fund_type).uniq
    @funds_sorted_by_type = []
    for i in 0..(@categories.count - 1)
        @funds_sorted_by_type[i] = Fund.where(:fund_type => @categories[i])
    end  
    @funds_count = Fund.count
    
    # @valuation_days = Valuation.where(:fund_id => 1).pluck(:day)
    # @valuation_values= Valuation.where(:fund_id => 1).pluck(:value)
    # @fund_chart = []

    # for i in 0..(@valuation_days.count - 1)
    #     @fund_chart[i] = {date: @valuation_days[i], value: @valuation_values[i]}
    # end
    @flow_days1 = Flow.where(:fund_id => 7).pluck(:day)
    @flow_cashflow1 = Flow.where(:fund_id => 7).pluck(:cashflow)
    for i in 0..(@flow_days1.count - 1)
        @flow_chart1[i] = {date: @flow_days1[i], value: @flow_cashflow1[i]}
    end
    @flow_days2 = Flow.where(:fund_id => 2).pluck(:day)
    @flow_cashflow2 = Flow.where(:fund_id => 2).pluck(:cashflow)
    for i in 0..(@flow_days2.count - 1)
        @flow_chart2[i] = {date: @flow_days2[i], value: @flow_cashflow2[i]}
    end
    @flow_days3 = Flow.where(:fund_id => 3).pluck(:day)
    @flow_cashflow3 = Flow.where(:fund_id => 3).pluck(:cashflow)
    for i in 0..(@flow_days3.count - 1)
        @flow_chart3[i] = {date: @flow_days3[i], value: @flow_cashflow3[i]}
    end
    @flow_days4 = Flow.where(:fund_id => 4).pluck(:day)
    @flow_cashflow4 = Flow.where(:fund_id => 4).pluck(:cashflow)
    for i in 0..(@flow_days1.count - 1)
        @flow_chart4[i] = {date: @flow_days4[i], value: @flow_cashflow4[i]}
    end
    @flow_days5 = Flow.where(:fund_id => 5).pluck(:day)
    @flow_cashflow5 = Flow.where(:fund_id => 5).pluck(:cashflow)
    for i in 0..(@flow_days5.count - 1)
        @flow_chart5[i] = {date: @flow_days5[i], value: @flow_cashflow5[i]}
    end
    @flow_days6 = Flow.where(:fund_id => 6).pluck(:day)
    @flow_cashflow6 = Flow.where(:fund_id => 6).pluck(:cashflow)
    for i in 0..(@flow_days6.count - 1)
        @flow_chart6[i] = {date: @flow_days6[i], value: @flow_cashflow6[i]}
    end

    #for i in 1..(@funds.count) #cycle through all funds
      # if Valuation.where(:fund_id => i).exists #build JSON object with valuation data for those that have it
      #   @valuation_days = Valuation.where(:fund_id => i).pluck(:day)
      #   @valuation_values = Valuation.where(:fund_id => i).pluck(:value)
      #   for j in 0..(@valuation_days.count - 1)
      #     @valuation_chart[j] = {date: @valuation_days[j], value: @valuation_values[j]}
      #     puts(@valuation_chart[j])
      #   end
      #   @valuation_chart_group[i] = {chart: i.to_s, value: @valuation_chart}
      #   puts(@valuation_chart_group[i])
      # end
      # if Flow.where(:fund_id => i).exists #build JSON object with valuation data for those that have it
      #   @flow_days = Flow.where(:fund_id => i).pluck(:day)
      #   @flow_cashflow = Flow.where(:fund_id => i).pluck(:cashflow)

      #   #@flow_chart_group = Flow.select([:day, :cashflow]).map {|e| {day: e.day, cashflow: e.cashflow} }
        
      #   for k in 0..(@flow_days.count - 1)
      #     @flow_chart[k] = {days: @flow_days[k], cashflow: @flow_cashflow[k]}
      #     #puts(@flow_chart[k])
      #   end
      #   @flow_chart_group[i] = @flow_chart
      #   #puts(@flow_chart_group[i])
      # end
    #end



  end


  def snapshots
    
  end

  def settings
    
  end

  def fund_management
    @funds = Fund.order(:name)
  end

  def alerts
  end
  
  require 'finance'
  include Finance
  def benchmark_data
    require 'price_pull'
    require 'json'
    
    params[:fund_id] = 1
    params[:benchmark_name] = 'IBM US Equity'
    
    unless params[:fund_id] and params[:benchmark_name]
      render text: 'error'
      return
    end
    
    fund = Fund.find(params[:fund_id])
    unless fund
      render text: 'no such fund'
      return
    end
    
    dates = {}
    
    fund_flows = fund.flows
    fund_flows_hash = {}
    fund_flows.each do |x|
      fund_flows_hash[x['day']] = x['cashflow']
    end
    fund_flows.each { |x| dates[x['day']] = 1 }
    
    vals = fund.valuations
    vals_hash = {}
    vals.each do |x|
      vals_hash[x['day']] = x['valuation']
    end
    vals.each { |x| dates[x['day']] = 1 }
    
    start_date = dates.keys.sort.first
    end_date   = dates.keys.sort.last
    
    px = PricePull.get(params[:benchmark_name], start_date, end_date)

    bmk_vals = {}
    bmk_flows = {}
    shares = 0
    dates.keys.sort.each do |dt|
      
      best_date = dt
      unless px[best_date]
        best_date = px.keys.sort.select{ |z| z < dt }.last
        unless px.has_key?(best_date)
          render text: 'error - missing benchmark price for ' + dt.to_s
          return
        end
      end
      
      # assume flows happen before valuation if they're on the same day
      if fund_flows_hash.has_key?(dt)
        bmk_flows[dt] = fund_flows_hash[dt]
        shares += fund_flows_hash[dt] / px[best_date]
      end
      
      if vals_hash.has_key?(dt)
        bmk_vals[dt] = shares * px[best_date]
      end
    end
    
    irrs = {}
    vals.each do |x|
      trans = []
      bmk_flows.keys.each do |dt|
        if dt <= x['day']
          trans << Transaction.new(bmk_flows[dt], date: Time.parse(dt.to_s))
        end
      end
      trans << Transaction.new(bmk_vals[x['day']], date: Time.parse(x['day'].to_s))
      
      irrs[x['day']] = trans.xirr(0.6)
    end
    unless irrs.has_key?(end_date)
      trans = []
      bmk_flows.keys.each do |dt|
        if dt <= end_date
          trans << Transaction.new(bmk_flows[dt], date: Time.parse(dt.to_s))
        end
      end
      trans << Transaction.new(bmk_vals[end_date], date: Time.parse(end_date.to_s))
      
      irrs[end_date] = trans.xirr(0.6)
    end
    
    render text: JSON.dump({
      #benchmark_valuations: bmk_vals,
      #benchmark_flows: bmk_flows,
      irrs: irrs.to_s
    })
  end

  def show
    @fund = Fund.find(params[:id])
    @flows = Flow.where(fund_id: @fund.id)
    @valuations = Valuation.where(fund_id: @fund.id)

    @flows_and_valuations = (@flows + @valuations).flatten.sort_by {|hash| hash[:day]}
  end
end
