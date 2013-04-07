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

  def show
    @fund = Fund.find(params[:id])
    @flows = Flow.where(fund_id: @fund.id)
    #@valuations = Valuation.where(fund_id: @fund.id)

    #@flows_and_valuations = (@flows + @valuations).sort_by {|hash| hash[:day]}
  end
end
