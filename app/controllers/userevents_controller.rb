class UsereventsController < ApplicationController
  def create
  	render :json => params
  end

  def whatever
  	render modal
  end
end
