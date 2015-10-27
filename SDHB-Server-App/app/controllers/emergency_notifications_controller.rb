class EmergencyNotificationsController < ApplicationController
  before_action :set_emergency_notification, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!, :except => ["countSuccess"]
  skip_before_action :verify_authenticity_token

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

  # GET /clear_notifications
  def clear_notifications
    #Delete everything in the notifications table
    EmergencyNotification.delete_all
    #redirect back to the all notifications view
	  redirect_to :action => 'list'
  end

  # POST /emergency_notifications
  # POST /emergency_notifications.json
  def create
    #create new Notification with parameters passed in
    @emergency_notification = EmergencyNotification.new(emergency_notification_params)
    #print notification details to logs and console for debug purposes
  	logger.error(@emergency_notification.message)
  	logger.error(@emergency_notification.title)
    #save notification
    @emergency_notification.save
    #redirect back to the all notifications view
    redirect_to :action => 'list'

#---------------------Sending Notification To GCM using "gcm" gem-------------------------------------------------------
	#set GCM ID for gem
	gcm = GCM.new("AIzaSyAEP2Sk1M2-aFax16by2LHozu1RWNoHE0c")

	#set what is sent in the notification
	options = {data:{title: @emergency_notification.title, message: @emergency_notification.message,
	notId:rand(1...1000)}, collapse_key: "updated_score", title: @emergency_notification.title}

	#Querying database for what users are authenticated
	authenticatedUsers = User.where(authenticated: true)

	#User device IDS to send the notification to
	registration_ids = authenticatedUsers.map {|u| u.deviceID}

	#Display IDS for debug purposes
	puts ["REGISTRATION ID = ", registration_ids]

	#Using GCM gem to send notification
	response = gcm.send(registration_ids, options)
#-----------------------------------------------------------------------------------------------------------------------
  end

  # POST /emergency_notifications_group
  # POST /emergency_notifications_group.json
  def createGroup
    #create new Notification with parameters passed in
    @emergency_notification = EmergencyNotification.new(emergency_notification_params)
    #print notification details to logs and console for debug purposes
  	logger.error(@emergency_notification.message)
  	logger.error(@emergency_notification.title)
  	logger.error(params[:group])
    #save notification
    @emergency_notification.save
    #redirect back to the all notifications view
    redirect_to :action => 'list'

#---------------------Sending Notification To GCM using "gcm" gem-------------------------------------------------------
	#set GCM ID for gem
	gcm = GCM.new("AIzaSyAEP2Sk1M2-aFax16by2LHozu1RWNoHE0c")

	#set what is sent in the notification
	options = {data:{title: @emergency_notification.title, message: @emergency_notification.message,
	notId:rand(1...1000)}, collapse_key: "updated_score", title: @emergency_notification.title}

	#retrieving the users group
	group = params[:group]

	#Querying database for what users are authenticated
	authenticatedUsers = User.where(authenticated: true, group: group)

	#User device IDS to send the notification to
	registration_ids = authenticatedUsers.map {|u| u.deviceID}

	#Display IDS for debug purposes
	puts ["REGISTRATION ID = ", registration_ids]

	#Using GCM gem to send notification
	response = gcm.send(registration_ids, options)
#-----------------------------------------------------------------------------------------------------------------------
  end

  # POST /emergency_notifications/countSuccess
  # POST /emergency_notifications/countSuccess.json
  def countSuccess
  	#When POST from app is received increment the confirmations counter on the last notification by +1
  	EmergencyNotification.last.increment!(:confirmations)
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
