require 'uri'
require 'httparty'

SONGS_PER_ARTIST = 20

artists = [ {name: "Weird Al Yankovich",  nationality: "American", photo_url: "http://i.huffpost.com/gen/1952378/images/o-WEIRD-AL-facebook.jpg"},
            {name: "Kiss",                nationality: "American", photo_url: "http://www.gannett-cdn.com/-mm-/b0ad212381eab60e31d1f067f1c478cea741469a/c=0-10-3443-1963&r=x1683&c=3200x1680/local/-/media/USATODAY/GenericImages/2014/03/31//1396298223000-KISS-KISS-BAND-JY-0718-62187918.jpg"},
            {name: "Gwar",                nationality: "American", photo_url: "http://www.heavymetal.com/v2/wp-content/uploads/2014/08/gwar_promo.jpg"},
            {name: "Rammstein",           nationality: "German",   photo_url: "https://wallpaperscraft.com/image/rammstein_scream_sky_clouds_image_6830_1920x1080.jpg"},
            {name: "Enya",                nationality: "Irish",    photo_url: "https://fanart.tv/fanart/music/4967c0a1-b9f3-465e-8440-4598fd9fc33c/artistbackground/enya-5046d8e16b236.jpg"},
            {name: "Prince",              nationality: "American", photo_url: "http://www.bet.com/content/betcom/music/photos/2012/06/the-evolution-of-prince/_jcr_content/image.custom1200x675x20.dimg/060712-music-evolution-Prince.jpg"},
            {name: "yeasayer",            nationality: "American", photo_url: "http://media.virbcdn.com/cdn_images/resize_2400x1280/36/PageImage-506519-3781727-yeasayer_Myles_Pettengill__MG_4014Edit.jpg"},
            {name: "Taylor Swift",        nationality: "American", photo_url: "http://cdn.playbuzz.com/cdn/20a56b83-dcc7-4b01-833a-7c612c0bd96b/22fe4638-d675-47f8-9726-5f43e27bb084.jpg"},
            {name: "Limp Bizkit",         nationality: "American", photo_url: "https://bizzam.files.wordpress.com/2014/08/limp-bizkit.jpg"},
            {name: "Lianne La Havas",     nationality: "British",  photo_url: "http://static.guim.co.uk/sys-images/Guardian/Pix/pictures/2015/5/28/1432804569981/Lianne-La-Havas-009.jpg"},
            {name: "Kendrick Lamar",      nationality: "American", photo_url: "http://ppcorn.com/us/wp-content/uploads/sites/14/2015/04/Kendrick-Lamar-Throwing-Out-Dodgers-First-Pitch-FDRMX.jpg"},
            {name: "The Decemberists",    nationality: "American", photo_url: "http://media.npr.org/assets/img/2015/01/14/decemberists2_wide-89a5f2273ef60304bea9cae1b28e537724136e83.jpg?s=1400"},
            {name: "Chaka Khan",          nationality: "American", photo_url: "http://thereelnetwork.net/wp-content/uploads/2015/06/1370537970000-ChakaKhanNewCaneImageLR-1306061301_16_9.jpg"},
            {name: "Ryan Adams",          nationality: "American", photo_url: "http://www.trbimg.com/img-53b31cf3/turbine/la-et-ms-ryan-adams-announces-new-album-20140701"} ]

def search_songs(artist)
  artist = URI.encode(artist)
  itunes_url = "https://itunes.apple.com/search?"
  options = "term=#{artist}&media=music&entity=song&attribute=artistTerm&limit=#{SONGS_PER_ARTIST}&explicit=no"

  results = HTTParty.get(itunes_url + options)
  return JSON.parse(results)["results"]
end

def quote_string(s)
  s.gsub(/\\/, '\&\&').gsub(/'/, "\"") # ' (for ruby-mode)
end

artists.each do |artist|
  artist[:songs] = search_songs(artist[:name])
end

File.open("tunr_seed.sql","w") do |file|
  file.puts("TRUNCATE TABLE songs CASCADE;")
  file.puts("TRUNCATE TABLE artists CASCADE;")

  artists.each_with_index do |artist, index|
    file.puts("INSERT INTO artists (name, photo_url, nationality) VALUES ('#{artist[:name]}', '#{quote_string(artist[:photo_url])}', '#{artist[:nationality]}');")
    artist[:songs].each do |song|
      file.puts("INSERT INTO songs (title, album, preview_url, artist_id) VALUES ('#{quote_string(song[:trackName.to_s])}', '#{quote_string(song[:collectionName.to_s])}', '#{quote_string(song[:previewUrl.to_s])}', #{index + 1});")
    end

    file.puts("")
  end
end
