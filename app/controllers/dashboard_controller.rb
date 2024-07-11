class DashboardController < ApplicationController
  layout "dashboard"
  before_action :set_active_team

  def index
    @team = @active_team

    @todays_entries = @active_team.entries.where(created_by_id: current_user.id).from_today.order(end_time: :desc)
    @todays_minutes = @todays_entries.sum { |entry| (entry.end_time - entry.start_time) / 60 }

    @thisweeks_entries = @active_team.entries.where(created_by_id: current_user.id).from_thisweek.order(end_time: :desc)
    @thisweeks_minutes = @thisweeks_entries.sum { |entry| (entry.end_time - entry.start_time) / 60 }
  end

  private

  def set_active_team
    if current_user
      @active_team = current_user.teams.find_by(id: session[:active_team_id])
      unless @active_team
        redirect_to dashboard_teams_path, alert: "Please select a team."
      end
    else
      redirect_to new_user_session_path, alert: "You need to be logged in!"
    end
  end
end
