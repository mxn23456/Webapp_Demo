class ImagesController < ApplicationController
	before_action :set_image, only: [:show, :edit, :update, :destroy]
	before_filter :get_inv

	def index
		@images = @inv.images.all
	end

	def show
	end

	def new
		@image = @inv.images.new
	end

	def edit
	end

	def create
		@image = @inv.images.new(image_params)

		respond_to do |format|
			if @image.save
				format.html { redirect_to inv_images_url(@inv), notice: 'Image was successfully created.' }
				format.json { render :show, status: :created }
			else
				format.html { render :new }
				format.json { render json: @image.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		respond_to do |format|
			if @image.update(image_params)
				format.html { redirect_to inv_image_url(@inv,@image), notice: 'Image was successfully updated.' }
				format.json { render :show, status: :ok }
			else
				format.html { render :edit }
				format.json { render json: @image.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@image.destroy
		respond_to do |format|
			format.html { redirect_to inv_images_url(@inv), notice: 'Image was successfully destroyed.' }
			format.json { head :no_content }
		end

	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_image
		@image= Image.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def image_params
		params.require(:image).permit(:inv_id,:image )
	end

	def get_inv
		if params[:inv_id] == "0"
			@inv = Inv.find_by(inv_desc: inv_tran_params[:inv_desc])
			params[:inv_desc] = (@inv.id).to_s
		else
			@inv = Inv.find(params[:inv_id])
		end
	end
end
