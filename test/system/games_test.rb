require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  # test "visiting the index" do
  #   visit games_url
  #
  #   assert_selector "h1", text: "Game"
  # end

  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "li", count: 10
  end

  test "fill in non-english word to go to /score" do
    visit new_url
    fill_in "attempt", with: "ddddd"
    click_on "Play"

    assert_text "ddddd is not an English word!"
  end

  # test "fill in english word to go to /score" do
  #   visit new_url
  #   fill_in "attempt", with: "dad"
  #   click_on "Play"

  #   assert_text "dad is not from the grid of letters:"
  #   assert_selector "p", text: "some text"
  # end
end
