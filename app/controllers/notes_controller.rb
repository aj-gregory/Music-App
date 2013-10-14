class NotesController < ApplicationController

  def create
    params[:note][:track_id] = params[:track_id]
    params[:note][:user_id] = current_user.id
    @note = Note.new(params[:note])

    if @note.save
      redirect_to track_url(@note.track)
    else
      flash[:errors] = @track.errors.full_messages
      redirect_to track_url(@note.track)
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @track = @note.track

    Note.destroy(@note)
    redirect_to track_url(@track)
  end

end
