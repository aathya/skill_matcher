require 'test_helper'

class CustomersControllerTest < ActionDispatch::IntegrationTest

  test 'get index' do
    sign_in user
    get customers_path, params: {search: profession_ids}
    assert_response :success
  end

  test 'get index through worker' do
    sign_in users(:elliot)
    get customers_path
    assert_response :redirect
    assert_equal 'You do not have sufficient privileges to view this page', flash[:error]
  end

  def user
    users(:helen)
  end

  def profession_ids
    [
        professions(:cook).id,
        professions(:developer).id
    ]
  end

end
