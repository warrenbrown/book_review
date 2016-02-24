require 'rails_helper'

RSpec.feature 'Users can delet books' do
  scenario 'Successfully' do
    book = FactoryGirl.create(:book, title: 'Money Makeover', description: 'My description')

    visit "/"
    click_link "Money Makeover"
    click_link 'Delete Book'

    expect(page).to have_content "Book has been deleted."
    expect(page.current_url).to eq books_url
    expect(page).to have_no_content "Money Makeover"
  end
end
