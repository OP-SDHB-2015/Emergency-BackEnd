class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!, :except => ["registerID"]
  skip_before_action :verify_authenticity_token

  # GET /users
  # GET /users.json
  def authenticate
    @users = User.all
  end
  
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end
  
  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # POST /users/registerID
  # POST /users/registerID.json
  #----------------Method for registering the ID------------------------------------------------------------------------
  def registerID
	p "POST successful"
	#render :text => params[:staffID, :lastName, :firstName, :region, :registrationID]
	user = User.create(staffID: params[:staffID], lastName: params[:lastName], firstName: params[:firstName], deviceID: params[:registrationID], authenticated: false, region: params[:region], group: 1)
  end
  #---------------------------------------------------------------------------------------------------------------------
  

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:staffID, :lastName, :firstName, :deviceID, :authenticated, :region, :group)
    end
end
