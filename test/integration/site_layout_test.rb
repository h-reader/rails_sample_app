require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "layout links not login" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", signup_path
    
    get contact_path
    assert_select "title", full_title("Contact")
    
    get about_path
    assert_select "title", full_title("About")
    
    get help_path
    assert_select "title", full_title("Help")
    
    get login_path
    assert_template 'sessions/new' 
    
    get users_path
    assert_redirected_to login_url
    
    get user_path(@user)
    assert_template 'users/show'

    get edit_user_path(@user)
    assert_redirected_to login_url
    
  end
  
  test "layout links login" do
    log_in_as(@user)
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", signup_path
    
    get contact_path
    assert_select "title", full_title("Contact")
    
    get about_path
    assert_select "title", full_title("About")
    
    get help_path
    assert_select "title", full_title("Help")
    
    get login_path
    assert_template 'sessions/new' 
    
    get users_path
    assert_template 'users/index'
    
    get user_path(@user)
    assert_template 'users/show'

    get edit_user_path(@user)
    assert_template 'users/edit'
    
  end

end
