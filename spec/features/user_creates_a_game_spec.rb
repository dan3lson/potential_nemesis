require 'rails_helper'

feature "user creates a new game", %{

  As a user,
  I want to add a game
  to my collection.
} do

  # Acceptance Criteria
  #
  # [x] I can visit /games/new
  # [x] I can complete a form for game details
  # [x] I see errors on the page if fields
  #     are left blank
  # [x] Submitting the form redirects to that
  #     game's show page

  describe "\n complete new Game form" do
    let(:user) { FactoryGirl.create(:user) }

    scenario "scenario: inputs are valid" do
      log_in

      visit new_game_path

      fill_in "Opponent First Name", with: "Paul"
      fill_in "Opponent Last Name", with: "Morphy"
      fill_in "Color", with: "black"
      fill_in "Result", with: "won"
      fill_in "Day", with: "08/06/1988"

      click_on "Submit"

      expect(page).to have_content("Game created successfully.")
      expect(user.games.count).to eq(1)
    end

    scenario "scenario: inputs are invalid" do
      log_in

      visit new_game_path

      fill_in "Opponent First Name", with: ""
      fill_in "Opponent Last Name", with: ""
      fill_in "Color", with: ""
      fill_in "Result", with: ""
      fill_in "Day", with: ""

      click_on "Submit"

      expect(page).to have_content("Yikes!")
      expect(page).to have_content("errors")
      expect(page).to have_content("Please fix")
      expect(user.games.count).to eq(0)
    end
  end
end
