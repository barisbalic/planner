require 'spec_helper'

feature 'when visiting the homepage' do

  let!(:next_session) { Fabricate(:sessions) }
  let!(:next_course) { Fabricate(:course) }
  let!(:event) { Fabricate(:event) }

  before(:each) do
    visit root_path
  end

  scenario "i can view the next session" do

    expect(page).to have_content I18n.l(next_session.date_and_time, format: :month).upcase
  end

  scenario "i can view the next course" do

    expect(page).to have_content next_course.title
    expect(page).to have_content next_course.short_description
    expect(page).to have_content I18n.l(next_course.date_and_time, format: :month).upcase
  end

  scenario "i can view upcoming events" do

    expect(page).to have_content event.name
    expect(page).to have_content event.description
    expect(page).to have_content I18n.l(event.date_and_time, format: :month).upcase
  end

  scenario "i can access the code of conduct" do
    click_on "Code of conduct"

    expect(page).to have_content "Code of conduct"
    expect(page).to have_content "The Quick Version"
    expect(page).to have_content "The Long Version"
  end

  scenario "i can sign up" do
    visit root_path

    expect(find('.fa-sign-in')).to_not be nil
  end
end
