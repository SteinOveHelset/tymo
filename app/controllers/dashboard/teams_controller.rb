module Dashboard
  class TeamsController < ApplicationController
    layout "dashboard"

    # Check if user is authenticated
    before_action :check_authenticated
    
    # GET /dashboard/teams
    def index
      @teams = current_user.teams

      if session[:active_team_id]
        @active_team = current_user.teams.find_by(id: session[:active_team_id])
      else
        @active_team = nil
      end
    end

    # GET /dashboard/teams/new
    def new
      @team = Team.new
    end

    # POST /dashboard/teams
    def create
      @team = current_user.teams.create(team_params)
      @team.members << current_user
      @team.created_by_id = current_user.id

      if @team.save
        session[:active_team_id] = @team.id

        redirect_to dashboard_teams_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    # GET /dashboard/teams/:id
    def edit
      @team = Team.find(session[:active_team_id])
    end

    # PATCH/PUT /dashboard/teams/:id
    def update
      @team = Team.find(session[:active_team_id])

      if @team.update(team_params)
        redirect_to dashboard_teams_path, notice: "Team successfully updated"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    # DELETE /dashboard/teams/:id
    def destroy
      @team = Team.find(session[:active_team_id])
      @team.destroy

      session[:active_team_id] = nil

      redirect_to dashboard_teams_path, status: :see_other, notice: "Team successfully deleted"
    end

    # GET /dashboard/teams/:id/set_active_team/
    def set_active_team
      @team = current_user.teams.find(params[:team_id])

      if @team.id == session[:active_team_id]
        redirect_to dashboard_teams_path, notice: "This team is already active!"
      else
        session[:active_team_id] = @team.id
        redirect_to dashboard_teams_path, notice: "Active team set to #{@team.title}."
      end
    rescue ActiveRecord::RecordNotFound
      redirect_to dashboard_teams_path, alert: "Team not found."
    end

    private

      def team_params
        params.require(:team).permit(:title)
      end
  end
end
