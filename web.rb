require 'sinatra'
require 'twilio-ruby'

get '/course' do
  Twilio::TwiML::Response.new do |r|
    r.Say "Welcome to pre paid language learning, the service that gets you fluent faster."
    r.Gather :numDigits => '8', :action => '/course/confirm', :method => 'get' do |g|
      g.Say 'Please enter your 8 digit course code.'
    end
  end.text
end
 
get '/course/confirm' do
  response = Twilio::TwiML::Response.new do |r|
    r.Say 'Great. Your course code was accepted.  You have 5 credits.'
    r.Gather :numDigits => '1', :action => '/course/confirm/selected', :method => 'get' do |g|
      g.Say 'Press 1 to learn about Greeting the homeowner'
      g.Say 'Press 2 to do course 2. How to negotiate a job.'
      g.Say 'Press 3 to do course 3.'
      g.Say 'Press 4 to learn something useful.'
      g.Say 'Press 5 to learn how to ask for more money.'
      g.Say 'Press 0 to listen to this menu again'
    end
  end
  response.text
end

get '/course/confirm/selected' do
  redirect '/course/confirm' unless ['1', '2', '3', '4', '5'].include?(params['Digits'])
  if params['Digits'] == '1'
    redirect '/course/confirm/selected/1'
  end
  elsif params['Digits'] == '2'
    redirect '/course/confirm/selected/2'
  end
  elsif params['Digits'] == '3'
    redirect '/course/confirm/selected/3'
  end
  elsif params['Digits'] == '4'
    redirect '/course/confirm/selected/4'
  end
  elsif params['Digits'] == '5'
    redirect '/course/confirm/selected/5'
  end
  end.text
end
 
get '/course/confirm/selected/1' do
  Twilio::TwiML::Response.new do |r|
    r.Say 'Welcome to course 1'
    r.Say 'This is where you would hear the course content.'
     r.Gather :numDigits => '1', :action => '/course/confirm/selected/1/done', :method => 'get' do |g|
      g.Say 'Press 1 to try the course again.'
      g.Say 'Press 2 to take a quiz on what you learned.'
      g.Say 'Press 0 to return to the main menu.'
    end
  end.text
end

get '/course/confirm/selected/1/done' do
  if params['Digits'] == '1'
    redirect '/course/confirm/selected/1'
  end
  elsif params['Digits'] == '2'
      response = Twilio::TwiML::Response.new do |r|
        r.Say 'This is the quiz for course 1.  You will be asked a question and your answer will be recorded for you to listen to. Record your answer at the tone. Here we go.'
        r.Say 'How would you say. Nice to meet you. in english?'
        r.Record :maxLength => '30', :action => '/course/confirm/selected/1/quiz/answer', :method => 'get'
    end
  end
  elsif params['Digits'] == '0'
    redirect '/course/confirm'
  end
  end.text
end

get '/course/confirm/selected/1/quiz/answer' do
  Twilio::TwiML::Response.new do |r|
    r.Say 'You Said'
    r.Play params['RecordingUrl']
    r.Say 'The correct answer is.'
    r.Say 'Play correct answer'
  end.text
end