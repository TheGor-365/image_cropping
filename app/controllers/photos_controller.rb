class PhotosController < ApplicationController
  before_action :set_photo, only: %i[ show edit update destroy croppable ]

  def index
    @photos = Photo.all
  end

  def show; end
  def edit; end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    respond_to do |format|
      if @photo.save
        format.html { redirect_to photo_url(@photo) }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to photo_url(@photo) }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_url }
    end
  end

  def croppable
    @photo.cropped_image.attach(
      io: StringIO.new(Base64.decode64(photo_params[:cropped_image].split(',')[1])),
      filename: "cropped_image.jpg",
      content_type: "image/jpg"
    )
  end

  private
  def set_photo
    @photo = Photo.find(params[:id])
  end

  def photo_params
    params.require(:photo).permit(:name, :image, :cropped_image)
  end
end
