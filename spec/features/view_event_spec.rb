require 'spec_helper'

feature 'viewing an event' do
  let!(:event) { Fabricate(:event) }

  before do
    visit event_path(event)
  end

  context "a non authenticated user" do
    scenario 'a user can view an event' do
      expect(page).to have_content(event.name)
      expect(page).to have_content(event.description)
      expect(page).to have_content(event.schedule)
    end

    scenario 'a student cannnot RSVP if they are not logged in', wip: true do
      click_on 'Get started with Open Source!'

      expect(page).to have_content("The page is only available to Codebar members. Create an account or sign in first.")
    end

    scenario 'a student cannnot RSVP if they are not logged in', wip: true do
      click_on 'Attend as a coach'

      expect(page).to have_content("The page is only available to Codebar members. Create an account or sign in first.")
    end
  end

  context "an authenticated user" do
    let(:member) { Fabricate(:member) }

    before do
      login(member)
    end

    context 'can RSVP to an event' do

      scenario "as a Coach" do
        click_on 'Attend as a coach'
        click_on 'I want to volunteer as a coach'

        expect(page).to have_content("You have RSVPed to #{event.name}. We will verify your attendance after you complete the questionnaire!")
      end

      scenario "as a Student" do
        click_on 'Get started with Open Source!'
        click_on 'Attend as a student'

        expect(page).to have_content("You have RSVPed to #{event.name}. We will verify your attendance after you complete the questionnaire!")
      end
    end
  end
end
