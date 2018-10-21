class NewsController < ApplicationController

	def index
		# byebug
		@news = YAML.load_file('config/data/news.yml').with_indifferent_access[:items]
		@users = YAML.load_file('config/data/users.yml').with_indifferent_access[:items]
	end	

	def sync
		HTTParty.post(@urlstring_to_post.to_str, 
    :body => { :subject => 'This is the screen name', 
               :issue_type => 'Application Problem', 
               :status => 'Open', 
               :priority => 'Normal', 
               :description => 'This is the description for the problem'
             }.to_json,
    :headers => { 'Content-Type' => 'application/json' } )
	end	

end
