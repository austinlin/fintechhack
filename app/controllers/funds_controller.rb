class FundsController < ApplicationController
  def new
    @fund = Fund.new
  end

  def create
    @fund = Fund.new(params[:fund])
    if @fund.save
      flash[:success] = "New fund created!"
      redirect_to funds_path
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
      redirect_to dashboard_funds_path
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
    @funds = Fund.order(:name)
  end


  def snapshots
    
  end

  def settings
    
  end

  def fund_management

  end

  def alerts
  end
  
  def benchmark_data
    require 'price_pull'
    require 'json'
    
    #params[:fund_id] = 1
    #params[:benchmark_name] = 'IBM US Equity'
       
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
      trans = {}
      bmk_flows.keys.each do |dt|
        if dt <= x['day']
          trans[dt] = bmk_flows[dt]
        end
      end
      trans[x['day']] = bmk_vals[x['day']]
      
      irrs[x['day']] = rand(100) # todo: drop in IRR calculator
    end
    unless irrs.has_key?(end_date)
      trans = {}
      bmk_flows.keys.each do |dt|
        if dt <= end_date
          trans[dt] = bmk_flows[dt]
        end
      end
      trans[end_date] = bmk_vals[end_date]
      
      irrs[end_date] = rand(100) # todo: drop in IRR calculator
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
