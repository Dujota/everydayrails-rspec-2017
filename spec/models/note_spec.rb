require 'rails_helper'
# belongs to user and project, must have a project and a user in order to be valid
RSpec.describe Note, type: :model do

  before(:each) do
    # Set up test data for all tests in file
  end

  ## Validation tests
  describe 'Validates the Notes Model' do

    before(:each) do
      # set up test data for all tests in the file
    end

    context 'Create a valid object' do
      it "is valid with User and a Message" do
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
          message: "This Note should be valid",
          user: user
        )

        expect(note1).to be_valid
      end
    end

    context "create invalid object" do
      it "Is NOT valid without a User" do
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
          message: "This Note should be valid",
        )

        expect(note1).to_not be_valid
      end

      it "is NOT valid without a message" do
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
          user: user
        )

        expect(note1).to_not be_valid
      end
    end
  end

  describe 'search message for a term' do
    before do
      # setup extra test data for all tests related to search
    end

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
