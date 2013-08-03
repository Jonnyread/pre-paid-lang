require 'sinatra'
require 'twilio-ruby'

get '/' do
  Twilio::TwiML::Response.new do |r|
    r.Say "Welcome to pre paid language learning, the service that gets you fluent faster."
    r.Gather :numDigits => '8', :action => '/course', :method => 'get' do |g|
      g.Say 'Please enter your 8 digit course code.'
    end
  end.text
end

get '/course' do
  Twilio::TwiML::Response.new do |r|
    r.Say "Congratulations your code has been accepted.  Please select the course you'd like to take."
    r.Gather :numDigits => '1', :action => '/course/selected', :method => 'get' do |g|
      g.Say 'Press 1 to learn about Greeting the homeowner'
      g.Say 'Press 2 to do course 2. How to negotiate a job.'
      g.Say 'Press any other button to hear this menu again.'
    end
  end.text
end

get '/course/selected' do
  redirect '/course' unless ['1', '2', '3'].include?(params['Digits'])
  if params['Digits'] == '1'
    response = Twilio::TwiML::Response.new do |r|
      r.Say 'Welcome to course 1'
      r.Say 'This is where you would hear the course content.'
    end
  elsif params['Digits'] == '2'
    response = Twilio::TwiML::Response.new do |r|
      r.Say 'Welcome to course 2'
      r.Say 'This is where you would hear the course content.'
    end
  elsif params['Digits'] == '3'
    response = Twilio::TwiML::Response.new do |r|
      r.Say 'Welcome to course 3'
      r.Say 'This is where you would hear the course content.'
      ##r.Gather :numDigits => '1', :action => '/course/test', :method => 'get' do |g|
      	##g.Say 'Would you like to try taking a pop quiz - press 1.'
    end
  end
  response.text
end

##get '/course/test' do
  ##Twilio::TwiML::Response.new do |r|
    ##r.Say "Welcome to the test"
    ##end
  ##end.text
##end