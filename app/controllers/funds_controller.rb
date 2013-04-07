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

  def show
    @fund = Fund.find(params[:id])
    @flows = Flow.where(fund_id: @fund.id)
    #@valuations = Valuation.where(fund_id: @fund.id)

    #@flows_and_valuations = (@flows + @valuations).sort_by {|hash| hash[:day]}
  end
end
