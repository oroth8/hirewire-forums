require 'test_helper'
class EditDiscussionsTest < ActionDispatch::IntegrationTest
  setup do
    get new_user_session_path
    sign_in users(:user_001)
    post user_session_url
    Current.user = users(:user_001)
    Discussion.new({ name: 'test discussion 1' }).save
    @discussion = Discussion.find(980_190_963)
  end

  test 'valid discussion edit' do
    get discussions_path
    # binding.pry
    assert_select 'a[href=?]', '/discussions/980190963-test-discussion-1'
    get edit_discussion_path(@discussion)
    assert_template 'discussions/edit'
    assert_changes 'Discussion.find(980_190_963).name' do
      patch discussion_path(@discussion),
            params: { discussion: { name: 'valid discussion' } }
    end
    assert_redirected_to 'http://www.example.com/discussions/980190963-valid-discussion'
  end

  test 'valid discussion destroy' do
    get discussions_path
    assert_select 'a[href=?]', '/discussions/980190963-test-discussion-1'
    assert_difference 'Discussion.count', -1 do
      delete discussion_path(@discussion)
    end
    assert_redirected_to discussions_path
  end
end
