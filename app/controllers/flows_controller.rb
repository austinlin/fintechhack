class FlowsController < ApplicationController
  def new
  	@flow = Flow.new
  end

  def create
  	@flow = Flow.new(params[:flow])
  	if @flow.save
  		flash[:success] = "New flow created"
  		redirect_to root_url
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
  	redirect_to root_url, notice: "Cash flows imported."
  end

end