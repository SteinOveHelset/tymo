module Dashboard
  class ClientsController < ApplicationController
    layout "dashboard"

    # Check if user is authenticated - and set active team
    before_action :check_authenticated
    before_action :set_active_team
    
    def index
      @clients = @active_team.clients.includes(:projects)
    end

    def show
      @client = @active_team.clients.find(params[:id])
    end

    def new
      @client = Client.new
    end
  
    def create
      @client = @active_team.clients.create(client_params)
      @client.created_by_id = current_user.id

      if @client.save
        redirect_to dashboard_client_path(@client), notice: "Client successfully created"
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @client = @active_team.clients.find(params[:id])
    end

    def update
      @client = @active_team.clients.find(params[:id])

      if @client.update(client_params)
        redirect_to dashboard_client_path(@client), notice: "Client successfully updated"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @client = @active_team.clients.find(params[:id])
      @client.destroy

      redirect_to dashboard_clients_path, status: :see_other, notice: "Client successfully deleted"
    end

    private
    
    def client_params
      params.require(:client).permit(:title, :description, :color)
    end
  end
end