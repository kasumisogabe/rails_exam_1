class PicturesController < ApplicationController

  def index
    @pictures = Picture.all
  end

  def new
    if params[:back]
      @picture = Picture.new(picture_params)
    else
      @picture = Picture.new
    end
  end

  def create
    @picture = current_user.pictures.build(picture_params)
    if params[:back]
      render :new
    else
      if @picture.save
        redirect_to pictures_path, notice: '画像を投稿しました'
      else
        render :new
      end
    end
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

  def confirm
    @picture = Picture.new(picture_params)
    @picture = current_user.pictures.build(picture_params)
    render :new if @picture.invalid?
  end

  private

  def picture_params
    params.require(:picture).permit(:title, :content, :image, :image_cache)
  end

  def set_picture
    @picture = Picture.find(params[:id])
  end
end
