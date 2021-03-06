# encoding: utf-8

RobbinSite.controllers :admin do

  before :except => :login do
    halt 403 unless session[:account_id]
    halt 403 unless @account = Account.find(session[:account_id])
    halt 403 unless @account.admin?
  end
  
  get :index do
    render 'admin/index'
  end

  get :new_blog, :map => '/admin/blog/new' do
    @blog = Blog.new
    render 'admin/new_blog'
  end
  
  post :blog, :map => '/admin/blog' do
    @blog = Blog.new(params[:blog])
    @blog.account = @account
    if @blog.save
      flash[:notice] = "创建成功"
      redirect url(:blog, :show, :id => @blog.id)
    else
      render 'admin/new_blog'
    end
  end
  
  get :edit_blog, :map => '/admin/blog/:id/edit' do
    @blog = Blog.find params[:id].to_i
    render 'admin/edit_blog'
  end
  
  put :blog, :map => '/admin/blog/:id' do
    @blog = Blog.find params[:id].to_i
    if @blog.update_blog(params[:blog])
      flash[:notice] = '更新成功'
      redirect url(:blog, :show, :id => @blog.id)
    else
      render 'admin/edit_blog'
    end
  end

  delete :blog, :map => '/admin/blog/:id' do
    @blog = Blog.find params[:id].to_i
    @blog.destroy
    flash[:notice] = "删除成功"
    redirect url(:blog, :index)
  end

end
