require 'test_helper'

class InvsControllerTest < ActionController::TestCase
  setup do
    @inv = invs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:invs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create inv" do
    assert_difference('Inv.count') do
      post :create, inv: { inv_desc: @inv.inv_desc, notes: @inv.notes }
    end

    assert_redirected_to inv_path(assigns(:inv))
  end

  test "should show inv" do
    get :show, id: @inv
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @inv
    assert_response :success
  end

  test "should update inv" do
    patch :update, id: @inv, inv: { inv_desc: @inv.inv_desc, notes: @inv.notes }
    assert_redirected_to inv_path(assigns(:inv))
  end

  test "should destroy inv" do
    assert_difference('Inv.count', -1) do
      delete :destroy, id: @inv
    end

    assert_redirected_to invs_path
  end
end
