class ValuationsController < ApplicationController

  def new
  	@valuation = Valuation.new
  end

  def create
  	@valuation = Valuation.new(params[:valuation])
  	if @valuation.save
  		flash[:success] = "New valuation added!"
  		redirect_to fundmanagement_path
  	else
  		render 'new'
  	end
  end

  def edit
  	@valuation = Valuation.find(params[:id])
  end

  def index
  	@valuations = Valuation.all
  end

  def import
  	Valuation.import(params[:file])
  	redirect_to fundmanagement_path, notice: "Valuations imported."
  end

end