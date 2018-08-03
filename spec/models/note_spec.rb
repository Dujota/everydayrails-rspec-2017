require 'rails_helper'
# belongs to user and project, must have a project and a user in order to be valid
RSpec.describe Note, type: :model do

  before do

  end

  ## Validation tests

  describe 'search message for a term' do
    context "when a match is found" do
      it 'returns notes that match the search term' do
        user = User.create(
          first_name: "Joe",
          last_name: "Doe",
          email: "test@example.com",
          password: "secret"
        )

        project = user.projects.create(
          name: "Test Project"
        )

        note1 = project.notes.create(
          message: "This is the first note.",
          user: user
        )

        note2 = project.notes.create(
          message: "This is the second note",
          user: user
          )

        note3 = project.notes.create(
          message: "First, preheat the over",
          user: user
          )

        expect(Note.search("first")).to include(note1, note3)
        expect(Note.search("first")).to_not include(note2)
      end
    end


    context "when a blank search term is passed" do
      it "returns all items if an empty search is passed" do
        user = User.create(
          first_name: "Joe",
          last_name: "Doe",
          email: "test@example.com",
          password: "secret"
        )

        project = user.projects.create(
          name: "Test Project"
        )

        note1 = project.notes.create(
          message: "This is the first note.",
          user: user
        )

        note2 = project.notes.create(
          message: "This is the second note",
          user: user
          )

        note3 = project.notes.create(
          message: "First, preheat the over",
          user: user
          )
        expect(Note.search('')).to include(note1, note2, note3)
      end
    end

    context "when no match is found" do
      it "returns an empty collection when no results are found" do
        user = User.create(
          first_name: "Joe",
          last_name: "Doe",
          email: "test@example.com",
          password: "secret"
        )

        project = user.projects.create(
          name: "Test Project"
        )

        note1 = project.notes.create(
          message: "This is the first note.",
          user: user
        )

        note2 = project.notes.create(
          message: "This is the second note",
          user: user
          )

        note3 = project.notes.create(
          message: "First, preheat the over",
          user: user
          )

        expect(Note.search('something')).to be_empty
      end
    end
  end
end
