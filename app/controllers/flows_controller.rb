class FlowsController < ApplicationController
  def new
  	@flow = Flow.new
  end

  def create
  	@flow = Flow.new(params[:flow])
  	if @flow.save
  		flash[:success] = "New flow added!"
  		redirect_to fundmanagement_path
  	else
  		render 'new'
  	end
  end

  def edit
  	@flow = Flow.find(params[:id])
  end

  def index
  	@flows = Flow.all
  end

  def import
  	Flow.import(params[:file])
  	redirect_to fundmanagement_path, notice: "Cash flows imported."
  end

end