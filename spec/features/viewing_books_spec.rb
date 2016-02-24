require 'rails_helper'

RSpec.feature 'Users can view books' do
  scenario 'all details' do
    book = FactoryGirl.create(:book, title: 'Money Makeover')

    visit '/'
    click_link 'Money Makeover'

    expect(page.current_url).to eq book_url(book)
  end
end
