require 'rails_helper'

RSpec.describe "posts/index", type: :view do

  current_user = User.first_or_create!(name: 'dean', email: 'dean@example.com', password: 'password', password_confirmation: 'password')

  before(:each) do
    assign(:posts, [
      Post.create!(
        content: 'test content',
        user: current_user
      ),
      Post.create!(
        content: 'test content',
        user: current_user
      )
    ])
  end

  it "renders a list of posts" do
    render
  end
end
