class SongsController < ApplicationController
  # GET /songs
  # GET /songs.json
  def index
    @songs = Song.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @songs }
    end
  end

  # GET /songs/1
  # GET /songs/1.json
  def show
    @song = Song.find(params[:id])
    @album_name = @song.album.nil?  ?  ""  : @song.album.name
    @album_link = @song.album.nil?  ?  "#" : album_path(@song.album)

    @video_id = @song.youtube

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @song }
    end
  end

  # GET /songs/new
  # GET /songs/new.json
  def new
    @song = Song.new
    @action = "Add"

    if request.referer.is_a? String
      resource_type = request.referer.split("/")[-2]
      resource_id   = request.referer.split("/")[-1]
      @selected_artist = resource_id.to_i  if resource_type = "artists" 
      @selected_album  = resource_id.to_i  if resource_type = "albums"
      @selected_genre  = resource_id.to_i  if resource_type = "genres"
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @song }
    end
  end

  # GET /songs/1/edit
  def edit
    @song = Song.find(params[:id])
    @action = "Update"

    @selected_artist = @song.artist_id
    @selected_album  = @song.album_id
    @selected_genre  = @song.genre_id
  end

  # POST /songs
  # POST /songs.json
  def create
    @song = Song.new(params[:song])

    respond_to do |format|
      if @song.save
        format.html { redirect_to @song, notice: 'Song was successfully created.' }
        format.json { render json: @song, status: :created, location: @song }
      else
        format.html { render action: "new" }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /songs/1
  # PUT /songs/1.json
  def update
    @song = Song.find(params[:id])

    respond_to do |format|
      if @song.update_attributes(params[:song])
        format.html { redirect_to @song, notice: 'Song was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /songs/1
  # DELETE /songs/1.json
  def destroy
    @song = Song.find(params[:id])
    name = @song.name
    @song.destroy

    respond_to do |format|
      format.html { redirect_to songs_url, notice: "Song '#{name}' was successfully deleted." }
      format.json { head :no_content }
    end
  end
end
