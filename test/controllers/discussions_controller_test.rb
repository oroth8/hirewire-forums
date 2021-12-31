# frozen_string_literal: true

require 'test_helper'

class DiscussionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    get new_user_session_path
    sign_in users(:user_001)
    post user_session_url
    Current.user = users(:user_001)
    @discussion = Discussion.create(name: 'Test discussion').save!
  end

  test 'should get index and render discussions' do
    get discussions_path
    assert_response :success
    assert_template :index
    assert_template partial: '_discussion', count: 3
    assert_not_nil @discussion
  end

  test 'should get new and create a discussion' do
    get new_discussion_path
    assert_response :success
    assert_template :new
    assert_template partial: '_form', count: 1
  end
end
