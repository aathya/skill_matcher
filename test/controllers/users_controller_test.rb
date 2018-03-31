require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  test "create a new user" do
    assert_difference 'User.count' do
      post user_registration_path, params: { user: {
          first_name: 'E',
          last_name: 'Corp',
          email: 'e.corp@ecorp.in',
          profile_type: 'worker'
      }, commit: 'Sign up'}
    end
  end

end
