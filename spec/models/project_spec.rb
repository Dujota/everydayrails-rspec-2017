require 'rails_helper'

RSpec.describe Project, type: :model do
it "does not allow duplicate project names per user" do
  user = User.create(
    first_name: "Joe",
    last_name: "Tester",
    email: "test@example.com",
    password: "secret"
  )

  user.projects.create(
    name: "Test Project",
  )
  new_project = user.projects.build(
    name: "Test Project",
  )
  new_project.valid?
  expect(new_project.errors[:name]).to include("has already been taken")
end
it "allows two users to share a project name" do
  user = User.create(
    first_name: "Jane",
    last_name: "Doe",
    email: "TestJane@example.com",
    password: "secret",
  )
  user.projects.create(
    name: "Test Project",
  )

  other_user = User.create(
    first_name: "Joe",
    last_name: "Doe",
    email: "Joe@example.com",
    password: "secret",
  )

  other_project = other_user.projects.build(
    name: "Test Project",
  )
  expect(other_project).to be_valid
end


end
