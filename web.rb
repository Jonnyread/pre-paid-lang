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
      r.Play 'https://s3.amazonaws.com/pre-paid-language/01+Wolf+%26+I.mp3'
    end
  elsif params['Digits'] == '2'
    response = Twilio::TwiML::Response.new do |r|
      r.Say 'Welcome to course 2 how to negotiate a job'
      r.Say 'This is where you would hear the course content.'
      r.Play 'https://s3.amazonaws.com/pre-paid-language/01+Wolf+%26+I.mp3'
    end
  elsif params['Digits'] == '3'
    response = Twilio::TwiML::Response.new do |r|
      r.Say 'Welcome to course 3 how to ask questions about your job'
      r.Play 'https://s3.amazonaws.com/pre-paid-language/01+Wolf+%26+I.mp3'
    end
  elsif params['Digits'] == '4'
    redirect '/course/selected/4'
  end
  response.text
end

get '/course/selected/4' do
  Twilio::TwiML::Response.new do |r|
    r.Say "Welcome to course 4 how to ask questions about your job"
    r.Say 'Listen to the song and repeat the words. That is how you will learn english.'
    r.Play 'https://s3.amazonaws.com/pre-paid-language/01+Wolf+%26+I.mp3'
    r.Say 'Great job! What do you want to do next?'
    r.Gather :numDigits => '1', :action => '/course/selected/4/done', :method => 'get' do |g|
      g.Say 'Press 1 to start the course over'
      g.Say 'Press 2 to take a quiz on this course'
      g.Say 'Press 3 to go back to the main menu'
    end
  end.text
end

get '/course/selected/4/done' do
  if params['Digits'] == '1'
    redirect '/course/selected/4'
  elsif params['Digits'] == '2'
    redirect '/course/selected/4'
  elsif params['Digits'] == '3'
    redirect '/course/selected'
  end.text
end