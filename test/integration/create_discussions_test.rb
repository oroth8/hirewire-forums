require 'test_helper'
class CreatDiscussionsTest < ActionDispatch::IntegrationTest
  setup do
    get new_user_session_path
    sign_in users(:user_001)
    post user_session_url
    Current.user = users(:user_001)
  end

  test 'invalid discussion creation' do
    get new_discussion_path
    assert_no_difference 'User.count' do
      post discussions_path, params: { discussion: { name: '' } }
    end
    assert_template :new
    assert_select 'div#error_explanation'
  end
end
