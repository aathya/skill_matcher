require "application_system_test_case"

class WorkersTest < ApplicationSystemTestCase
  test "create and destroy worker professions" do
    sign_in user
    visit root_path

    #create profession with existing profession
    fill_in 'Enter Profession Name', with: 'Cooking'
    assert_difference 'user.worker_professions.size' do
      click_button('Add')
    end
    assert page.has_content?('Cooking')

    #remove worker profession
    assert_difference 'user.worker_professions.size', -1 do
      find("[data-profession-id=\"#{worker_profession.id}\"] [data-method='delete']").click
      page.driver.browser.switch_to.alert.accept
      sleep 2
    end
    refute page.has_content?(worker_profession.profession.name)

    #create a new profession
    profession_count = Profession.count
    fill_in 'Enter Profession Name', with: 'Pilot'
    assert_difference 'user.worker_professions.size' do
      click_button('Add')
    end
    assert_equal profession_count + 1, Profession.count
    assert page.has_content?('Pilot')
  end

  def user
    users(:elliot)
  end

  def worker_profession
    worker_professions(:two)
  end
end
