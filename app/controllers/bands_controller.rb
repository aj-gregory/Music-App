class BandsController < ApplicationController


  def index
    @bands = Band.all
    render :index
  end

  def new
    render :new
  end

  def create
    @band = Band.new(params[:band])

    if @band.save
      redirect_to bands_url
    else
      flash[:errors] = @band.errors.full_messages
      redirect_to new_band_url
    end
  end

  def show
    @band = Band.find(params[:id])
    render :show
  end

  def destroy
    @band = Band.find(params[:id])
    Band.destroy(@band)
    redirect_to bands_url
  end

end
