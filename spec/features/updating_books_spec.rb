require 'rails_helper'

RSpec.feature 'Users can update books' do
  scenario 'with valid attributes' do
    book = FactoryGirl.create(:book, title: 'Money Makeover', description: 'My description')

    visit "/"
    click_link "Money Makeover"
    click_link 'Edit Book'
    fill_in "Title", with: "Sublime Text 4 beta"
    click_button "Update Book"

    expect(page).to have_content 'Book has been updated.'
    expect(page).to have_content 'Sublime Text 4 beta'
  end
end
