require 'test_helper'

class EmergencyNotificationsControllerTest < ActionController::TestCase
  setup do
    @emergency_notification = emergency_notifications(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:emergency_notifications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create emergency_notification" do
    assert_difference('EmergencyNotification.count') do
      post :create, emergency_notification: { message: @emergency_notification.message, title: @emergency_notification.title }
    end

    assert_redirected_to emergency_notification_path(assigns(:emergency_notification))
  end

  test "should show emergency_notification" do
    get :show, id: @emergency_notification
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @emergency_notification
    assert_response :success
  end

  test "should update emergency_notification" do
    patch :update, id: @emergency_notification, emergency_notification: { message: @emergency_notification.message, title: @emergency_notification.title }
    assert_redirected_to emergency_notification_path(assigns(:emergency_notification))
  end

  test "should destroy emergency_notification" do
    assert_difference('EmergencyNotification.count', -1) do
      delete :destroy, id: @emergency_notification
    end

    assert_redirected_to emergency_notifications_path
  end
end
