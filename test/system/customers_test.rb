require "application_system_test_case"

class CustomersTest < ApplicationSystemTestCase

  test 'search workers' do
    sign_in user
    visit root_path
    chosen_select('Hacker')
    click_button('Find Workers')
    assert page.has_content?("Elliot Alderson")
    chosen_select('Cooking')
    click_button('Find Workers')
    assert page.has_content?("Darlene Alderson")
    remove_chosen_select
    click_button('Find Workers')
    assert page.has_content?("Darlene Alderson")
    refute page.has_content?("Elliot Alderson")
    visit root_path
    chosen_select('Cooking')
    click_button('Find Workers')
    assert page.has_content?("Darlene Alderson")
  end

  def chosen_select(text)
    find('#search_chosen .chosen-choices').click
    find('.chosen-results .active-result', text: text).click
  end

  def remove_chosen_select
    first('.chosen-container .chosen-choices .search-choice a').click
  end

  def user
    users(:helen)
  end


end
