class PicturesController < ApplicationController

  def index
    @pictures = Picture.all
  end

  def new
    @picture = Picture.new
  end

  def create
    @picture = Picture.new(picture_params)
    @picture = current_user.pictures.build(picture_params)
    # if params[:back]
    #   render :new
    # else
    if @picture.save
      redirect_to pictures_path, notice: '画像を投稿しました'
    else
      render :new
    end
    # end
  end

  def show
    set_picture
    @picture = Picture.find(params[:id])
    # @favorite = current_user.favorites.find_by(picture_id: @picture.id)
  end

  def edit
    set_picture
    @picture = Picture.find(params[:id])
  end

  def update
    set_picture
    @picture = Picture.find(params[:id])
    if @picture.update(picture_params)
      redirect_to pictures_path, notice: '投稿を編集しました'
    else
      render :edit
    end
  end

  def destroy
    set_picture
    @picture.destroy
    redirect_to pictures_path, notice: '投稿を削除しました'
  end

  # def confirm
  #   @picture = Picture.new(bpicture_params)
  #   render :new if @post.invalid?
  # end

  private

  def picture_params
    params.require(:picture).permit(:image, :image_cache)
  end

  def set_picture
    @picture = Picture.find(params[:id])
  end
end
