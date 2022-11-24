class MoviesController < ApplicationController
  def index
    # raise
    if params[:query].present?
      # @movies = Movie.where(title: params[:query])
      # @movies = Movie.where("title LIKE ?", params[:query]) # CASE SENSITIVE
      # @movies = Movie.where("title ILIKE ?", "%#{params[:query]}%") # CASE INSENSITIVE
      # sql_query = "title ILIKE :query OR synopsis ILIKE :query"
      # sql_query = <<~SQL
      #   movies.title ILIKE :query
      #   OR movies.synopsis ILIKE :query
      #   OR directors.first_name ILIKE :query
      #   OR directors.last_name ILIKE :query
      # SQL

      # FULL TEXT SEARCH
      # jump => SEQUENCE OF CHARACTERS
      # jump => jumps, jumped, jumping, ....
      sql_query = <<~SQL
        movies.title @@ :query
        OR movies.synopsis @@ :query
        OR directors.first_name @@ :query
        OR directors.last_name @@ :query
      SQL


      @movies = Movie.joins(:director).where(sql_query, query: "%#{params[:query]}%") # MULTIPLE COLUMNS

    else
      @movies = Movie.all
    end

  end
end
