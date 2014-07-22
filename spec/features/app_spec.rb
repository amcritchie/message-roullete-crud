require "rspec"
require "capybara"

feature "Messages" do
  scenario "As a user, I can submit a message" do
    visit "/"

    expect(page).to have_content("Message Roullete")

    fill_in "Message", :with => "Hello Everyone!"

    click_button "Submit"

    expect(page).to have_content("Hello Everyone!")
  end

  scenario "As a user, I see an error message if I enter a message > 140 characters" do
    visit "/"

    fill_in "Message", :with => "a" * 141

    click_button "Submit"

    expect(page).to have_content("Message must be less than 140 characters.")
  end
end
feature "Edit"do
  before(:each) do
    visit "/"

    fill_in "Message", :with => "Hello Everyone!"

    click_button "Submit"
  end

  scenario "Edit and delete messages." do
    click_link "Edit"
    expect(page).to have_content("Hello Everyone!")
  end
  scenario "Click link edit message, and see on home screen." do
    click_link "Edit"
    fill_in "Message", :with => "Bye Everyone!"
    click_button "Submit"
    expect(page).to have_content("Bye Everyone!")
  end
  scenario "Blank message, or over 140 chars." do
    click_link "Edit"
    fill_in "Message", :with => ""
    click_button "Submit"

    expect(page).to have_content("Must contain content")

    fill_in "Message", :with => "a" * 141
    click_button "Submit"
    expect(page).to have_content("Message must be less than 140 characters.")
  end
  scenario "Delete message" do
    click_link "Delete"
    expect(page).to have_no_content("Hello Everyone!")
  end
end
