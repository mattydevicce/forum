require 'rails_helper'
require 'capybara/rails'
require 'capybara/rspec'

RSpec.describe 'Login Feature', type: :feature do
  it "works" do
    User.create(name:'matt', username: 'matt', email:'matt',password:'matt',password_confirmation:'matt')
    visit '/'
    expect(page.title).to eq 'Forum'
    click_on 'Log In'
    fill_in 'Username', with: 'matt'
    fill_in 'Password', with: 'matt'
    find("input#sub").click
    expect(current_path).to eq '/topics'
  end
end

RSpec.describe 'Create Topic', type: :feature do

  it "posts when logged in" do
    User.create(name:'matt', username: 'matt', email:'matt',password:'matt',password_confirmation:'matt')
    visit '/'
    click_on 'Log In'
    fill_in 'Username', with: 'matt'
    fill_in 'Password', with: 'matt'
    find("input#sub").click
    expect(current_path).to eq '/topics'
    click_on 'New Topic'
    expect(current_path).to eq '/topics/new'
    fill_in 'Title', with: 'Yabba Dabba Do!'

    select('select#topic_category_id', value=2)
    find(".actions").click
    expect(current_path).to eq '/topic/1'
  end

  it "doesn't post when not logged in" do
  end

end
