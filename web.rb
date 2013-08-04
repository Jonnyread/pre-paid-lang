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
      g.Say 'Press 2 to take course 2 how to negotiate a job.'
      g.Say 'Press 3 to take course 3 how to ask a question about your job.'
      g.Say 'Press any other button to hear this menu again.'
    end
  end.text
end

get '/course/selected' do
  redirect '/course' unless ['1', '2', '3', '4'].include?(params['Digits'])
  if params['Digits'] == '1'
    response = Twilio::TwiML::Response.new do |r|
      r.Say 'Welcome to course 1 greeting the homeowner'
      r.Say 'This is where you would hear the course content.'
    end
  elsif params['Digits'] == '2'
    response = Twilio::TwiML::Response.new do |r|
      r.Say 'Welcome to course 2 how to negotiate a job'
      r.Say 'This is where you would hear the course content.'
      r.Play 'https://s3.amazonaws.com/pre-paid-language/02+Dope+Boys+(Bird+Peterson+Remix).mp3'
    end
  elsif params['Digits'] == '3'
    response = Twilio::TwiML::Response.new do |r|
      r.Say 'Welcome to course 3 how to ask questions about your job'
      r.Play 'http://demo.twilio.com/hellomonkey/monkey.mp3'
    end
  elsif params['Digits'] == '4'
    response = Twilio::TwiML::Response.new do |r|
      r.Say 'Here is course number 4'
    end
  end
  response.text
end