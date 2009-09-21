require 'test_helper'

class ChecksControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:checks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create checks" do
    assert_difference('Checks.count') do
      post :create, :checks => { }
    end

    assert_redirected_to checks_path(assigns(:checks))
  end

  test "should show checks" do
    get :show, :id => checks(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => checks(:one).id
    assert_response :success
  end

  test "should update checks" do
    put :update, :id => checks(:one).id, :checks => { }
    assert_redirected_to checks_path(assigns(:checks))
  end

  test "should destroy checks" do
    assert_difference('Checks.count', -1) do
      delete :destroy, :id => checks(:one).id
    end

    assert_redirected_to checks_path
  end
end
