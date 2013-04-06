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

  def edit
    @fund = Fund.find(params[:id])
  end

  def update
    @fund = Fund.find(params[:id])
    if @fund.update_attributes(params[:fund])
      flash[:success] = "Fund updated"
      redirect_to funds_path
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
    @funds = Fund.order(:name)
  end

  def dashboard
    
  end

  def snapshots
    
  end

  def settings
    
  end

  def fund_management
    
  end

  def alerts
    
  end
end
