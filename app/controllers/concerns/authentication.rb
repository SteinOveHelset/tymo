module Authentication
    extend ActiveSupport::Concern
  
    included do
        helper_method :current_user
        helper_method :check_authenticated
        helper_method :set_active_team
    end
  
    def current_user
        @current_user ||= session[:user_id] && User.find_by(id: session[:user_id])
    end

    def check_authenticated
        if not current_user
            redirect_to new_user_session_path, alert: "You need to be logged in!"
        end
    end

    def set_active_team
        @active_team = current_user.teams.find_by(id: session[:active_team_id])

        if current_user.teams.size == 1
            @active_team = current_user.teams.first
            session[:active_team_id] = @active_team.id
        end
        
        unless @active_team
            redirect_to dashboard_teams_path, alert: "Please select a team."
        end
    end
end