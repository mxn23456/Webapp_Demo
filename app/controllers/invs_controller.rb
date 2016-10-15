class InvsController < ApplicationController
  before_action :set_inv, only: [:show, :edit, :update ]

  # GET /invs
  # GET /invs.json
  def index
    @invs = current_user.invs
    @last8Invs = Inv.get_recent_invs(current_user,8)
  end

  # POST /invs/get_month_of_year_transactions.json
  def get_month_of_year_transactions
    month = cash_flow_params[:month]	
    year = cash_flow_params[:year]
    if request.format.json?
      user = User.find(params[:user_id])
    end
    @trans = InvTran.getMonthOfYearTrans(user,month,year)
    render json: @trans
  end

  def show
    @new_tran = @inv.inv_trans.new
  end

  def new
    @user_inv = current_user.invs.new
  end

  def save_image
    @user_inv = current_user.invs.find(params[:id])
    if params["inv"] != nil
      @user_inv.update(:image => params["inv"]["image"])
      redirect_to user_inv_path(current_user,@user_inv), notice: 'Image was successfully updated'
    else
      redirect_to user_inv_path(current_user,@user_inv), notice: 'Please choose an image'
    end
  end

  def edit
    @user_inv = current_user.invs.find(params[:id])
  end

  def create
    @inv = current_user.invs.new(inv_params)

    respond_to do |format|
      if @inv.save
        format.html { redirect_to user_invs_path(current_user), notice: 'Inv was successfully created.' }
        #format.json { render :show, status: :created, location: @inv }
        format.json { render json: @inv }
      else
        format.html { render :new }
        format.json { render json: @inv.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @inv.update(inv_params)
        format.html { redirect_to @inv, notice: 'Inv was successfully updated.' }
        format.json { render :show, status: :ok, location: @inv }
      else
        format.html { render :edit }
        format.json { render json: @inv.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @inv = current_user.invs.find(params[:inv_id]) #NOTE bypass set_inv to conform with routing path
    @inv.image = nil
    @inv.destroy
    respond_to do |format|
      format.html { redirect_to user_invs_path(current_user), notice: 'Inv was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_inv
    @inv = current_user.invs.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def inv_params
    params.require(:inv).permit(:inv_desc, :notes, :image)
  end

  def cash_flow_params
    params.require(:cash_flow).permit(:month,:year)
  end

  def recent_invs_params
    params.require(:recent_invs).permit(:num_of_last_invs)
  end
end
