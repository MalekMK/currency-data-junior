# For the documentation check http://sinatrarb.com/intro.html
class ApplicationController < Sinatra::Base
	# This configuration part will inform the app where to search for the views and from where it will serve the static files
  	configure do
    	set :views, "app/views"
    	set :public_dir, "public"
  	end
  	get '/' do
		erb(:index, :locals => {:result => -1,:amount =>0,:fromTo => ""})
	end
	get '/history' do
		history = History.all
    	erb(:history, locals: { history: history })
	end
	get '/delete-history' do
		history = History.all
		history.destroy #deleting all the data in the table
		redirect('/history')
	end
	# create a new history element after submitting the form
	post '/' do
		new_history = History.new #creating new instance of History
		new_history.fromTo = params[:fromTo] #getting the value of the input of type radio
		new_history.created_at = Time.now.strftime("%d/%m/%Y")
		new_history.amount = params[:amount] #getting the amount
		getResultValue = GetResultValue.new(new_history.fromTo,new_history.amount)
		new_history.result = getResultValue.getResult #calculating the result
		new_history.save #saving the new history element
		erb(:index, locals: { result:new_history.result ,amount:new_history.amount,fromTo:new_history.fromTo}) #sending the last conversion data
	  end

end