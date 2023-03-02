# app/controllers/movies_controller.rb

class MoviesController < ApplicationController
  def index
    # The quesry has the user_input from the search
    if params[:query].present?
      # Searching through association - Joins
      sql_query = <<~SQL
        movies.title ILIKE :query
        OR movies.synopsis ILIKE :query
        OR directors.first_name ILIKE :query
        OR directors.last_name ILIKE :query
      SQL
      @movies = Movie.joins(:director).where(sql_query, query: "%#{params[:query]}%")
      # Searching multiple columns - Or
      # sql_query = "title ILIKE :query OR synopsis ILIKE :query"
      # @movies = Movie.where(sql_query, query: "%#{params[:query]}%")
      # @movies = Movie.where("title ILIKE ?", "%#{params[:query]}%") # > Super 🦸‍♀️
      # > I stands for case insensitive
      # @movies = Movie.where(title: params[:query]) # > Superman 🦸‍♂️
    else
      @movies = Movie.all
    end
  end
end
