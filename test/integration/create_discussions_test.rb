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
    assert_no_difference 'Discussion.count' do
      post discussions_path, params: { discussion: { name: '' } }
    end
    assert_template :new
    assert_select 'div#error_explanation'
  end

  test 'valid discussion creation' do
    get new_discussion_path
    assert_difference 'Discussion.count', +1 do
      post discussions_path, params: { discussion: { name: 'valid discussion', closed: true, pinned: false } }
    end
    assert_redirected_to 'http://www.example.com/discussions/980190963-valid-discussion'
  end
end
