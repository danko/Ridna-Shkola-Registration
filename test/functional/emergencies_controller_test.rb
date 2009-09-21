require 'test_helper'

class EmergenciesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:emergencies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create emergency" do
    assert_difference('Emergency.count') do
      post :create, :emergency => { }
    end

    assert_redirected_to emergency_path(assigns(:emergency))
  end

  test "should show emergency" do
    get :show, :id => emergencies(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => emergencies(:one).id
    assert_response :success
  end

  test "should update emergency" do
    put :update, :id => emergencies(:one).id, :emergency => { }
    assert_redirected_to emergency_path(assigns(:emergency))
  end

  test "should destroy emergency" do
    assert_difference('Emergency.count', -1) do
      delete :destroy, :id => emergencies(:one).id
    end

    assert_redirected_to emergencies_path
  end
end
