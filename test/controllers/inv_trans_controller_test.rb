require 'test_helper'

class InvTransControllerTest < ActionController::TestCase
  setup do
    @inv_tran = inv_trans(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:inv_trans)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create inv_tran" do
    assert_difference('InvTran.count') do
      post :create, inv_tran: { amount: @inv_tran.amount, investment_id: @inv_tran.investment_id, transaction_date: @inv_tran.transaction_date, transaction_desc: @inv_tran.transaction_desc }
    end

    assert_redirected_to inv_tran_path(assigns(:inv_tran))
  end

  test "should show inv_tran" do
    get :show, id: @inv_tran
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @inv_tran
    assert_response :success
  end

  test "should update inv_tran" do
    patch :update, id: @inv_tran, inv_tran: { amount: @inv_tran.amount, investment_id: @inv_tran.investment_id, transaction_date: @inv_tran.transaction_date, transaction_desc: @inv_tran.transaction_desc }
    assert_redirected_to inv_tran_path(assigns(:inv_tran))
  end

  test "should destroy inv_tran" do
    assert_difference('InvTran.count', -1) do
      delete :destroy, id: @inv_tran
    end

    assert_redirected_to inv_trans_path
  end
end
