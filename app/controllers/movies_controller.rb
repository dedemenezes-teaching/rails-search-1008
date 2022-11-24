class MoviesController < ApplicationController
  def index
    if params[:query].present?
      # CASE SENSITIVE -> lines 6 and 7 are EXACTLY the same thing
      # @movies = Movie.where(title: params[:query])
      # @movies = Movie.where("title LIKE ?", params[:query])

      # CASE INSENSITIVE
      # @movies = Movie.where("title ILIKE ?", "%#{params[:query]}%")

      # MULTIPLE COLUMNS
      # sql_query = "title ILIKE :query OR synopsis ILIKE :query"

      # ASSOCIATIONS -> .joins(:association_name) => eg. .joins(:director) (check line 34)
      # sql_query = <<~SQL
      #   movies.title ILIKE :query
      #   OR movies.synopsis ILIKE :query
      #   OR directors.first_name ILIKE :query
      #   OR directors.last_name ILIKE :query
      # SQL

      # FULL TEXT SEARCH
      # jump => SEQUENCE OF CHARACTERS
      # jump => jumps, jumped, jumping, ....
      # sql_query = <<~SQL
      #   movies.title @@ :query
      #   OR movies.synopsis @@ :query
      #   OR directors.first_name @@ :query
      #   OR directors.last_name @@ :query
      # SQL


      # @movies = Movie.joins(:director).where(sql_query, query: "%#{params[:query]}%")

      # PgSearch
      # @movies = Movie.search_by_title_and_synopsis(params[:query])
      @movies = Movie.global_search(params[:query])
    else
      @movies = Movie.all
    end
  end
end
