module Dashboard
  class ProjectsController < ApplicationController
    layout "dashboard"

    # Check if user is authenticated
    before_action :check_authenticated

    before_action :set_active_team
    before_action :set_clients, only: [:new, :create, :edit, :update]
    
    def show
      @project = @active_team.projects.find(params[:id])
    end

    def new
      @project = Project.new
      @project.client_id = params[:client_id]
    end
  
    def create
      @project = @active_team.projects.create(project_params)
      @project.created_by_id = current_user.id

      if @project.save
        redirect_to dashboard_project_path(@project), notice: "Project successfully created"
      else
        render :new, status: :unprocessable_entity
      end
    end
    
    def edit
      @project = @active_team.projects.find(params[:id])
    end

    def update
      @project = @active_team.projects.find(params[:id])

      if @project.update(project_params)
        redirect_to dashboard_project_path(@project), notice: "Project successfully updated"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @project = @active_team.projects.find(params[:id])
      client = @project.client
      @project.destroy

      redirect_to dashboard_client_path(client), status: :see_other, notice: "Project successfully deleted"
    end

    private

    def set_clients
      @clients = @active_team.clients
    end

    def project_params
      params.require(:project).permit(:client_id, :title, :description, :budget)
    end
  end
end
