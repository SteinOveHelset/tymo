module Dashboard
  class EntriesController < ApplicationController
    layout "dashboard"

    # Set active team or redirect to teams page
    before_action :set_active_team

    # Check if user is authenticated
    before_action :check_authenticated

    # Get projects from db for use in forms
    before_action :set_projects, only: [:new, :create, :edit, :update]

    # GET /dashboard/entries
    def index
      # Get todays entries

      @todays_entries = @active_team.entries.where(created_by_id: current_user.id).from_today.order(end_time: :desc)
      @todays_minutes = @todays_entries.sum { |entry| (entry.end_time - entry.start_time) / 60 }
  
      # Pagination

      if params[:page]
        @page = params[:page].to_i
      else
        @page = 1
      end

      @per_page = 5
      offset = (@page - 1) * @per_page

      # Get all entries from db

      @entries = @active_team.entries.where(created_by_id: current_user.id).limit(@per_page).offset(offset).order(end_time: :desc)
      @minutes = @active_team.entries.where(created_by_id: current_user.id).sum { |entry| (entry.end_time - entry.start_time) / 60 }
    end

    # GET /dashboard/entries/:id
    def show
      @entry = @active_team.entries.find(params[:id])
    end

    # GET /dashboard/entries/new
    def new
      @entry = Entry.new
    end
  
    # POST /dashboard/entries
    def create
      @entry = @active_team.entries.create(entry_params)
      @project = Project.find(entry_params[:project_id])
      @entry.created_by_id = current_user.id
      @entry.client_id = @project.client_id

      if @entry.save
        redirect_to dashboard_entry_path(@entry), notice: "Entry successfully created"
      else
        render :new, status: :unprocessable_entity
      end
    end

    # GET /dashboard/entries/:id/edit
    def edit
      @entry = current_user.entries.find(params[:id])
    end

    # PATCH/PUT /dashboard/entries/:id/
    def update
      @entry = current_user.entries.find(params[:id])

      if @entry.update(entry_params)
        redirect_to dashboard_entry_path(@entry), notice: "Entry successfully updated"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    # DELETE /dashboard/entries/:id/
    def destroy
      @entry = current_user.entries.find(params[:id])
      @entry.destroy

      redirect_to dashboard_path, status: :see_other, notice: "Entry successfully deleted"
    end

    private
    
      def entry_params
        params.require(:entry).permit(:project_id, :description, :start_time, :end_time)
      end

      def set_projects
        @projects = @active_team.projects
      end
  end
end