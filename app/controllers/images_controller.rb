class ImagesController < ApplicationController
  def index
    render :index, locals: { images: Image.all }
  end

  def show
   render :show, locals: { image: image }
  end

  def new 
    render :new, locals: { image: Image.new }
  end

  def create
    image = Image.new(image_params)
    image.user = current_user
 
    respond_to do |format|
      if image.save
        format.html { redirect_to image, notice: 'Image was successfully created.' }
        format.json { render :show, status: :created, location: image }
      else
        format.html { render :new, locals: { image: Image.new }}
        format.json { render json: image.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    render :edit, locals: { image: image }
  end

  def update

  end

  def destroy

  end

  private

  def image
    @image ||= Image.find(params[:id])
  end

  def image_params
    params.require(:image).permit(:name, :picture, :user_id)
  end
end
