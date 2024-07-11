class DashboardController < ApplicationController
  layout "dashboard"

  # Check if user is authenticated - and set active team
  before_action :check_authenticated
  before_action :set_active_team

  def index
    @team = @active_team

    @todays_entries = @active_team.entries.where(created_by_id: current_user.id).from_today.order(end_time: :desc)
    @todays_minutes = @todays_entries.sum { |entry| (entry.end_time - entry.start_time) / 60 }

    @thisweeks_entries = @active_team.entries.where(created_by_id: current_user.id).from_thisweek.order(end_time: :desc)
    @thisweeks_minutes = @thisweeks_entries.sum { |entry| (entry.end_time - entry.start_time) / 60 }
  end
end
