class NewsController < ApplicationController

	def index
		# byebug
		@news = YAML.load_file('config/data/news.yml').with_indifferent_access[:items]
		@users = YAML.load_file('config/data/users.yml').with_indifferent_access[:items]
	end	

	def show
		@news = YAML.load_file('config/data/news.yml').with_indifferent_access[:items]
		@users = YAML.load_file('config/data/users.yml').with_indifferent_access[:items]
		@news.each do |new|
			@pre_new = new if new[:id] == params[:id].to_i
		end	
		@new = YAML.load_file("config/data/#{params[:id]}.yml").with_indifferent_access
	end

	def sync
		yml_file = "config/data/#{params[:id]}.yml"
		@new = YAML.load_file(yml_file).with_indifferent_access
		
		
  	url = "http://10.2.0.69:8080/transaction/sendTransaction"
  	body = {:senderPrivateKey=>"4b118339dd5134ba99bb08f0453cb22dc936f716b5be00f17b92a1eaad8f98a1", :receiverAddress=>"TCOIH2C7DKNDFP66USIYP2EJKLD2HE3IPT42W436", :amount=>0, :message=>"#{params[:content]}"} 
  	result = HTTParty.post(url, body: body.to_json,headers:  { 'Content-Type' => 'application/json' })
  	@new[:comments] <<  {id: (@new[:comments].count + 1), user_avatar: "/image/avatar/3.jpg", user_name: "周老师",created_at: "刚刚", position: "一级鉴定师", content: params[:content],like_count: 0, unlike_count: 0, hash: result.parsed_response}
		File.open(yml_file, 'w') {|f| f.write @new.to_yaml }
		redirect_to "/news/#{params[:id]}"
	end	

end
