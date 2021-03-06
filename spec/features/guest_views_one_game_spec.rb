require 'rails_helper'

feature "guest views one game", %{

  As a guest,
  I want to view a specific game
  and see its moves.
} do

  # Acceptance Criteria
  #
  # [x] I can visit /games/1
  # [x] I can see the games details

  let!(:game) { FactoryGirl.create(:game) }
  let!(:game2) { FactoryGirl.create(:game) }
  let!(:move) { FactoryGirl.create(:move) }
  let!(:move2) { FactoryGirl.create(:move) }

  describe "\n view game show page" do
    scenario "scenario: view game without moves" do
      visit game_path(game)

      expect(page).to have_content(game.opponent_fname)
      expect(page).to have_content(game.opponent_lname)
      expect(page).to have_css("span.white_circle")
      expect(page).to have_content(game.result)
      expect(page).to have_content("on")
      expect(page).to have_content("This game is empty.")
      # expect(page).to have_content("1.")
    end

    scenario "scenario: view game with moves" do
      game2.moves << move
      game2.moves << move2

      visit game_path(game2)

      expect(page).to have_content(game2.opponent_fname)
      expect(page).to have_content(game2.opponent_lname)
      expect(page).to have_css("span.white_circle")
      expect(page).to have_content(game2.result)
      expect(page).not_to have_content("This game is empty.")
      expect(page).to have_content("on")
      expect(page).to have_content("1.")
      expect(page).to have_content("2.")
    end
  end
end
