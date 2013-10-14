class TracksController < ApplicationController

  def new
    render :new
  end

  def create
    params[:track][:album_id] = params[:album_id]
    @track = Track.new(params[:track])

    if @track.save
      redirect_to album_url(@track.album)
    else
      flash[:errors] = @track.errors.full_messages
      redirect_to new_album_track_url(params[:album_id])
    end
  end

  def show
    @track = Track.find(params[:id])
    render :show
  end

  def destroy
    @track = Track.find(params[:id])
    @album = @track.album

    Track.destroy(@track)

    redirect_to album_url(@album)
  end

end
