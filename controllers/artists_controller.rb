get "/artists" do
  # binding.pry
  @all_artist = Artist.all
  erb :"artists/index"
end

# New (render form to create new artists)
get '/artists/new' do
  erb :"artists/new"
end

# Create (submit form to create new artist)
post "/artists" do
  @name = params[:name]
  @photo_url = params[:photo_url]
  @nationality = params[:nationality]
  Artist.create(name: @name, photo_url: @photo_url, nationality: @nationality)
  redirect "/artists"
end

# Show (show particular artist)
get '/artist/:id' do
  @id = params[:id]
  @artist = Artist.find(@id)
  @songs = @artist.songs
  erb :"artist"
end

# Edit (render form to edit existing artist)
get "/artists/:id/edit" do
  @id = params[:id]
  @artist = Artist.find(@id)
  @name = params[:name]
  @photo_url = params[:photo_url]
  @nationality = params[:nationality]
  erb :"artists/edit"
end

# Update (submit form to update existing artist) 
put "/artist/:id" do
  @id = params[:id]	
  @artist = Artist.find(@id)
  @name = params[:name]
  @photo_url = params[:photo_url]
  @nationality = params[:nationality]
  @artist.update(name: @name, photo_url: @photo_url, nationality: @nationality)
  @new_song = params[:new_song]
  redirect "/artist/#{@id}"
end

# Destroy (delete an existing artist) - 
delete "/artists/:id" do
 @id = params[:id]
 @artist = Artist.find(@id)
 @artist.destroy
 redirect "/artists"
end