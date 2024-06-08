class BookmarksController < ApplicationController
  before_action :set_bookmark, only: [:destroy]

  def new
    @bookmark = Bookmark.new
    @list = List.find(params[:list_id])
  end

  def create

    @bookmark = Bookmark.new(bookmark_params)
    @list = List.find(params[:list_id])
    @bookmark.list = @list
    if @bookmark.save
      redirect_to lists_path(@list)
    else
      render :new
    end
  end

  def destroy
    @bookmark.destroy
    redirect_to bookmarks_path, status: :see_other
  end


private

def bookmark_params
  params.require(:bookmark).permit(:comment, :list_id, :movie_id)
end

def set_bookmark
  @bookmark = Bookmark.find(params[:id])
end
end
