# this is a simple model example
# check https://datamapper.org/getting-started.html
class History
	include DataMapper::Resource
	property :id,         			  Serial     # An auto-increment integer key
	property :created_at, 	Date  	  # A Date, for any date you might like
	property :fromTo,          String 	# A varchar type string, for short strings
	property :amount,      	  Float     # A number type float
	property :result,     		  Float    # A number type float
end
class GetResultValue
	def initialize(fromTo,amount)
		@conversion = fromTo #getting the fromTo param from constructor
		@amount =amount #getting the fromTo param from constructor
	end
	def getResult
		mclb = Money::Bank::CurrencylayerBank.new #mclb means money currency layer bank
		mclb.access_key = 'ed6bcc347389bb45f3bcf1c7e89e3f21' #getting the key after creating an account in https://currencylayer.com
		mclb.update_rates #updating the rates before converting
		# Due to the access_key for a free account on https://currencylayer.com,
		#i can't make source currency switching so i chose the rate as USD source and made some arithmetic operations in the rest of the lines
		#in the other plans i just replace the other lines with :
		# return @amount*mclb.get_rate(@conversion[0,3], @conversion[4,7])
		#return Money.new(100*@amount, @conversion[0,3]).exchange_to(@conversion[4,7]).to_f
		responseUsdEur = mclb.get_rate('USD', 'EUR')
		if @conversion[0,3]=="USD"
			return @amount*responseUsdEur
		elsif @conversion[0,3]=="CHF"
			responseUsdChf = mclb.get_rate('USD', 'CHF')
			return @amount*responseUsdEur/responseUsdChf
		else
			if @conversion[4,7]=="USD"
				return @amount/responseUsdEur
			else
				responseUsdChf = mclb.get_rate('USD', 'CHF')
				return @amount*responseUsdChf/responseUsdEur
			end
		end
	end
end