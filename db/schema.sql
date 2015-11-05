DROP TABLE IF EXISTS artists;
DROP TABLE IF EXISTS songs;

CREATE TABLE artists (
	id SERIAL PRIMARY KEY,
	name TEXT,
	photo_url TEXT,
	nationality TEXT
);

CREATE TABLE songs (
	id SERIAL PRIMARY KEY,
	title TEXT,
	album TEXT,
	preview_url TEXT, 
	artist_id INT
);

