
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end


  get '/posts/new' do #loads new form
    erb :new
  end

  # uses ActiveRecord to a create a new record of Post
  post '/posts' do  #creates a post
    @post = Post.create(params)
    redirect to '/posts'
  end

  # uses ActiveRecord to show all posts, index page
  get '/posts' do
    @posts = Post.all
    erb :index
  end

  # uses ActiveRecord to show a post with the param id, show page
  get '/posts/:id' do  #loads show page
    @post = Post.find_by_id(params[:id])
    erb :show
  end

  # Renders edit form, for user input how to update the record
  get '/posts/:id/edit' do #loads edit form
    @post = Post.find_by_id(params[:id])
    erb :edit
  end

  # uses ActiveRecord to update a record
  patch '/posts/:id' do  #updates a post
    @post = Post.find_by_id(params[:id])
    @post.name = params[:name]
    @post.content = params[:content]
    @post.save
    erb :show
  end

  # uses ActiveRecord to delete a record
  delete '/posts/:id/delete' do #delete action
    @post = Post.find_by_id(params[:id])
    @post.delete
    erb :deleted
  end



end
