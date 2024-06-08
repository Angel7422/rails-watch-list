class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end

  def search
    @movies = Movie.where("title ILIKE ?", "%#{query}%")
    render :index
  end

  def destroy
    if @movie
      @movie.destroy
      redirect_to movies_path, status: :see_other, notice: 'Le film a été supprimé avec succès.'
    else
      redirect_to movies_path, status: :not_found, alert: 'Le film n\'a pas été trouvé.'
    end
  end
end
