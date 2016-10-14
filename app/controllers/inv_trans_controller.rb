class InvTransController < ApplicationController
  before_action :set_inv_tran, only: [:show, :edit, :update, :destroy]
  before_filter :get_inv

  def index
    @inv_trans = @inv.inv_trans.all
  end

  def show
  end

  def new
    @inv_tran = @inv.inv_trans.new
  end

  def edit
  end

  def create
    @inv_tran = @inv.inv_trans.new
    @inv_tran[:transaction_desc] = inv_tran_params[:transaction_desc]
    if(!inv_tran_params["transaction_date(1i)"].nil? and 
       !inv_tran_params["transaction_date(2i)"].nil? and
       !inv_tran_params["transaction_date(3i)"].nil?)
       date = Date.new(inv_tran_params["transaction_date(1i)"].to_i, inv_tran_params["transaction_date(2i)"].to_i, inv_tran_params["transaction_date(3i)"].to_i)
       @inv_tran[:transaction_date] = date
    else
      @inv_tran[:transaction_date] = inv_tran_params[:transaction_date]
    end
    @inv_tran[:amount] = inv_tran_params[:amount]

    respond_to do |format|
      if @inv_tran.save
        format.html { redirect_to user_inv_path(current_user,@inv), notice: 'Inv tran was successfully created.' }
        format.json { render :show, status: :created }
      else
        format.html { render :new }
        format.json { render json: @inv_tran.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @inv_tran.update(inv_tran_params)
        format.html { redirect_to user_inv_path(current_user,@inv), notice: 'Inv tran was successfully updated.' }
        format.json { render :show, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @inv_tran.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @inv_tran.destroy
    respond_to do |format|
      format.html { redirect_to inv_url(@inv), notice: 'Inv tran was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_inv_tran
    @inv_tran = InvTran.find(params[:id])
  end

  def inv_tran_params
    params.require(:inv_tran).permit(:amount, :inv_desc,:transaction_desc, :inv_id, :transaction_date)
  end

  def get_inv
    if params[:inv_id] == "0"
      #@inv = Inv.find_by(inv_desc: inv_tran_params[:inv_desc])
      @inv = current_user.invs.find_by(inv_desc: inv_tran_params[:inv_desc])
#      params[:inv_desc] = (@inv.id).to_s
    else
      @inv = current_user.invs.find(params[:inv_id])
    end
  end
end
