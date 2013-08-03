require 'sinatra'
require 'twilio-ruby'

get '/course' do
  Twilio::TwiML::Response.new do |r|
    r.Say "Welcome to pre paid language learning, the service that gets you fluent faster."
    r.Gather :numDigits => '1', :action => '/course/selected', :method => 'get' do |g|
      g.Say 'Press 1 to learn about Greeting the homeowner'
      g.Say 'Press 2 to do course 2. How to negotiate a job.'
      g.Say 'Press any other button to hear this menu again.'
    end
  end.text
end

get '/course/selected' do
  redirect '/course' unless ['1', '2'].include?(params['Digits'])
  if params['Digits'] == '1'
    response = Twilio::TwiML::Response.new do |r|
      r.Say 'Welcome to course 1'
      r.Say 'This is where you would hear the course content.'
    end
  elsif params['Digits'] == '2'
    response = Twilio::TwiML::Response.new do |r|
      r.Say 'Hi Sarah Kate, Welcome to course 2'
      r.Say 'This is where you would hear the course content.'
    end
  end
  response.text
end