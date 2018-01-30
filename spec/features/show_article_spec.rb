require "rails_helper"
RSpec.feature "Showing an Article" do
 
 before do
@john = User.create(email: "john@example.com", password: "password")
@fred = User.create(email: "john@example.com", password: "password")
login_as(john)
@article = Article.create(title: "Title One", body: "Body of article one", user: john)
end

 scenario "to non-signed in user hide the edit and delete button" do
	visit "/"
	click_link @article.title
	expect(page).to have_content(@article.title) 
	expect(page).to have_content(@article.body) 
	expect(current_path).to eq(article_path(@article))

	expect(page).not_to have_link("Edit Article") 
	expect(page).to have_content("delete Article") 
end 
	
scenario "to non-owner hide the Edit and Delete buttons" do
    login_as(@fred)
    visit "/"
    click_link @article.title
    
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
    
    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end
end
