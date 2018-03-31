require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test 'search scope' do
    #search for cook count should be one
    users = User.search_by_profession(cook.id)
    assert users.pluck(:first_name).include?('Darlene')
    refute users.pluck(:first_name).include?('Elliot')
    #search for a hacker
    users = User.search_by_profession(hacker.id)
    assert users.pluck(:first_name).include?('Elliot')
    refute users.pluck(:first_name).include?('Darlene')
    #search for a developer and a cook
    users = User.search_by_profession([hacker.id, cook.id])
    assert users.pluck(:first_name).include?('Elliot')
    assert users.pluck(:first_name).include?('Darlene')
    assert_equal 2, users.size
  end

  def cook
    professions(:cook)
  end

  def developer
    professions(:developer)
  end

  def hacker
    professions(:hacker)
  end

end
