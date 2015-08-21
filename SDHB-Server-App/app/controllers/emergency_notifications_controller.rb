class EmergencyNotificationsController < ApplicationController
  before_action :set_emergency_notification, only: [:show, :edit, :update, :destroy]
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

  # POST /emergency_notifications
  # POST /emergency_notifications.json
  def create
    @emergency_notification = EmergencyNotification.new(emergency_notification_params)
	
	logger.error(@emergency_notification.message)
	logger.error(@emergency_notification.title)

    respond_to do |format|
      if @emergency_notification.save
        format.html { redirect_to @emergency_notification, notice: 'Emergency notification was successfully pushed.' }
        format.json { render :show, status: :created, location: @emergency_notification }
      else
        format.html { render :new }
        format.json { render json: @emergency_notification.errors, status: :unprocessable_entity }
      end
    end
#---------------------Sending Notification To GCM using "gcm" gem-------------------------------------------------------
	gcm = GCM.new("AIzaSyAEP2Sk1M2-aFax16by2LHozu1RWNoHE0c")
	options = {data:{title: @emergency_notification.title, message: @emergency_notification.message, notId:rand(1...1000)}, collapse_key: "updated_score",
	title: @emergency_notification.title}

	registration_ids = ["APA91bFipADOZyfJIYrBm6SUpNK_S6-6U0W5ckhshvQvVSphTFiH3uJZXIR3a1QdmNFlm4TXV3oAfR-dMF0cfW5RIc_s-wZXkZ44IAzpQhcD-A9aIzDx-DFltNoL5g7kfJPPrcd1edAOW1MbyKKYY_gbUrpeiteG0Q"]
	response = gcm.send(registration_ids, options)
	
	#curl -i -H "Content-type: application/json" -X POST http://128.199.73.221:3000/emergency_notifications -d '{"emergency_notification":{"title":"Testing.....", "message":"please work"}}'
	#Nexus 7 ID: APA91bEx_OaRh0c9wmQ9_5y9yKHGes-2S_-PyMBPxA1IlxGlFPpkMvBVyfrbHyc1nq2_cYcS6scuBaAFj4IiYiQYfMLZdJA1u0Aa1TimBPrhL7vG2P2a0mgEFClAZX1FfyZTr4UPGSDO_93wADa_9j7tDaxPEQrWUg
	#Weily S3: APA91bFipADOZyfJIYrBm6SUpNK_S6-6U0W5ckhshvQvVSphTFiH3uJZXIR3a1QdmNFlm4TXV3oAfR-dMF0cfW5RIc_s-wZXkZ44IAzpQhcD-A9aIzDx-DFltNoL5g7kfJPPrcd1edAOW1MbyKKYY_gbUrpeiteG0Q
	#Foster S3: APA91bGXOUN2izNliT7As7CQQOgJPQb_2tkROCFuxolgRhPqmduRFqKxx159OQW9jj84uyIAFUG9qRPdsFTRFD1pqfm2jyIi-Q5NzWu1bhi5hpNjvXgPqanqo9BU4cKJ9hZ4uxSNrfIu
#-----------------------------------------------------------------------------------------------------------------------	
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
