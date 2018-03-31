require 'test_helper'

class WorkersControllerTest < ActionDispatch::IntegrationTest

  test 'get index' do
    sign_in user
    get workers_path
    assert_response :success
  end

  test 'get index through customer' do
    sign_in users(:helen)
    get workers_path
    assert_response :redirect
    assert_equal 'You do not have sufficient privileges to view this page', flash[:error]
  end

  test 'create worker profession with existing profession' do
    sign_in user
    assert_difference 'user.worker_professions.size' do
      post workers_path(format: :js), params: {profession_name: 'Cooking'}
    end
  end

  test 'create a worker profession with new profession' do
    sign_in user
    profession_count = Profession.count
    assert_difference 'user.worker_professions.size' do
      post workers_path(format: :js), params: {profession_name: 'Plumbing'}
    end
    assert_equal profession_count + 1, Profession.count
  end

  test 'create worker profession with existing profession & with diff spelling' do
    sign_in user
    profession_count = Profession.count
    assert_difference 'user.worker_professions.size' do
      post workers_path(format: :js), params: {profession_name: 'CoOkInG'}
    end
    assert_equal profession_count, Profession.count
  end

  test 'destroy worker profession' do
    sign_in user
    worker_profession = user.worker_professions.first
    assert_difference 'user.worker_professions.size', -1 do
      delete worker_path(worker_profession, format: :js)
    end
    assert_response :success
  end

  def user
    users(:elliot)
  end

end
