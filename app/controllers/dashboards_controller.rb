class DashboardsController < ApplicationController
  def index
    @events = Event.all
  end
end
