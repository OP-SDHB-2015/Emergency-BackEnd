class EmergencyNotificationsController < ApplicationController
  before_action :set_emergency_notification, only: [:show, :edit, :update, :destroy]

  # GET /emergency_notifications
  # GET /emergency_notifications.json
  def index
    @emergency_notifications = EmergencyNotification.all
  end

  # GET /emergency_notifications/1
  # GET /emergency_notifications/1.json
  def show
  end

  # GET /emergency_notifications/new
  def new
    @emergency_notification = EmergencyNotification.new
  end

  # GET /emergency_notifications/1/edit
  def edit
  end

  # POST /emergency_notifications
  # POST /emergency_notifications.json
  def create
    @emergency_notification = EmergencyNotification.new(emergency_notification_params)

    respond_to do |format|
      if @emergency_notification.save
        format.html { redirect_to @emergency_notification, notice: 'Emergency notification was successfully created.' }
        format.json { render :show, status: :created, location: @emergency_notification }
      else
        format.html { render :new }
        format.json { render json: @emergency_notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /emergency_notifications/1
  # PATCH/PUT /emergency_notifications/1.json
  def update
    respond_to do |format|
      if @emergency_notification.update(emergency_notification_params)
        format.html { redirect_to @emergency_notification, notice: 'Emergency notification was successfully updated.' }
        format.json { render :show, status: :ok, location: @emergency_notification }
      else
        format.html { render :edit }
        format.json { render json: @emergency_notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /emergency_notifications/1
  # DELETE /emergency_notifications/1.json
  def destroy
    @emergency_notification.destroy
    respond_to do |format|
      format.html { redirect_to emergency_notifications_url, notice: 'Emergency notification was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_emergency_notification
      @emergency_notification = EmergencyNotification.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def emergency_notification_params
      params.require(:emergency_notification).permit(:title, :message)
    end
end