require 'rails_helper'

RSpec.describe Post, type: :model do
  current_user = User.first_or_create!(name: 'dean', email: 'dean@example.com', password: 'password', password_confirmation: 'password')
  
  it 'has a content' do
    post = Post.new(
      content: '',
      user: current_user,
    )
    expect(post).to_not be_valid

    post.content = 'Has a content'
    expect(post).to be_valid
  end
end
