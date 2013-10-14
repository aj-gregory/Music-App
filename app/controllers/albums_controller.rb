class AlbumsController < ApplicationController

  def new
    @band = Band.find(params[:band_id])
    render :new
  end

  def create
    @album = Album.new(params[:album])

    if @album.save
      redirect_to band_url(params[:band_id])
    else
      flash[:errors] = @album.errors.full_messages
      redirect_to new_band_album_url
    end
  end

  def show
    @album = Album.find(params[:id])
    render :show
  end

  def destroy
    @album = Album.find(params[:id])
    @band = @album.band

    Album.destroy(@album)
    redirect_to band_url(@band)
  end

end
