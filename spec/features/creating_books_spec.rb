require 'rails_helper'

RSpec.feature 'users can create books' do
  scenario 'with valid attributes' do
    visit '/'
    click_link 'Add Book'

    fill_in 'Title', with: 'Makeover'
    fill_in 'Description', with: 'My Description'
    fill_in 'Author', with: 'Dave Ramsey'
    click_button 'Create Book'

    expect(page).to have_content 'Book has been created.'
    expect(page).to have_content 'Makeover'
  end

  scenario 'with invalid attributes' do
    visit '/'
    click_link 'Add Book'

    fill_in 'Title', with: ''
    fill_in 'Description', with: ''
    fill_in 'Author', with: ''
    click_button 'Create Book'

    expect(page).to have_content 'Book has not been created.'
    expect(page).to have_content "Title can't be blank"
  end
end
