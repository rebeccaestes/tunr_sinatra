# Tunr 1.0!

We're going to be building Tunr, the worlds #1 music catalog / player (those
Spotify haters can't keep up with us).

## Part 1 - Database / Schema

In this exercise, your goal is to build out the schema for tunr, load it with
seed data, and run some sample queries to explore the data.

### Create the database

Create a postgres database called `tunr_db`. Make sure to use that **exact**
name, or you'll have trouble later on!

### Create a schema

Inside the db folder, create a `schema.sql` file, and then load it into your
`tunr_db` database.

Here's what our data model looks like:

*Artists*

| column name  | type |
|--------------|------|
| id   | primary key (int) |
| name | text |
| photo_url | text |
| nationality | text |

*Songs*

| column name  | type |
|--------------|------|
|id | primary key (int) |
|title | text |
|album | text |
|preview_url | text |
|artist_id | foreign key (int) |

### Load the Seed Data

Use psql to load the seed data located in `db/seed.sql`

### Play with the data

Using `psql`, play with the database, come up with some interesting sample
queries, and save them in a file in the db folder called `sample_queries.sql`

## Part 2 - Create the Models Using Active Record

## Part 3 - Build a RESTful Interface using Sinatra
