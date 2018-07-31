require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with a first name, last name,  email, and password" do
    user = User.new(
      first_name: "Aron",
      last_name: "Summer",
      email: "test@example.com",
      password: "secret"
    )
    expect(user).to be_valid
  end

  it "is invalid without a first name" do
    user = User.new(first_name: nil)
    user.valid?
    expect(user.errors[:first_name]).to_not include("can't be blank")
  end
  it "is invalid without a last name" do
    user = User.new(last_name: nil)
    user.valid?
    expect(user.errors[:last_name]).to include("can't be blank")
  end
  it "is invalid without an email address" do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end
  it "is invalid with a duplicate email address" do
    user = User.new(email: "test@example.com")
  end
  it "returns a user's full name as a string"
end
