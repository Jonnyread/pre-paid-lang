require 'sinatra'
require 'twilio-ruby'

get '/' do
  Twilio::TwiML::Response.new do |r|
    r.Say 'Bienvenido al prepago curso de idiomas, el sitio que te ayuda dominar un idioma nueva.', :voice => "woman", :language => "es"
    r.Gather :numDigits => '8', :action => '/course', :method => 'get' do |g|
      g.Say 'Porfavor introduzca su codigo de curso de 8 digitos.', :voice => "woman", :language => "es"
    end
  end.text
end

get '/course' do
  Twilio::TwiML::Response.new do |r|
    r.Say "Felicidades, su codigo ha sido acceptada.  Porfavor escoge el curso que quieres tomar.", :voice => "woman", :language => "es"
    r.Gather :numDigits => '1', :action => '/course/selected', :method => 'get' do |g|
      g.Say 'impulse el numero 1 para aprender mas sobre como saludar el dueno', :voice => "woman", :language => "es"
      g.Say 'Press 2 to take course 2 como negociar el proyecto.', :voice => "woman", :language => "es"
      g.Say 'Press 3 to take course 3 como hacer una pregunta acerca el proyecto.', :voice => "woman", :language => "es"
      g.Say 'Press 4 to take course 4 como negociar su pagamiento.', :voice => "woman", :language => "es"
      g.Say 'Press 5 to take course 5 como buscar mas trabajo.', :voice => "woman", :language => "es"
      g.Say 'Pulsar un boton para escuchar los opciones de nuevo.', :voice => "woman", :language => "es"
    end
  end.text
end

get '/course/mainmenu' do
  Twilio::TwiML::Response.new do |r|
    r.Say "Porfavor escoge el curso que quieres tomar.", :voice => "woman", :language => "es"
    r.Gather :numDigits => '1', :action => '/course/selected', :method => 'get' do |g|
      g.Say :voice => "woman", :language => "es" 'impulse el numero 1 para aprender mas sobre saludando el dueno'
      g.Say 'Press 2 to take course 2 how to negotiate a job.'
      g.Say 'Press 3 to take course 3 how to ask a question about your job.'
      g.Say 'Press 4 to take course 4 how to negotiate your pay'
      g.Say 'Press 5 to take course 5 how to get more work.'
      g.Say 'Press any other button to hear this menu again.'
    end
  end.text
end

get '/course/selected' do
  redirect '/course' unless ['1', '2', '3', '4', '5'].include?(params['Digits'])
  if params['Digits'] == '1'
    redirect '/course/selected/1'
  elsif params['Digits'] == '2'
    redirect '/course/selected/2'
  elsif params['Digits'] == '3'
    redirect '/course/selected/3'
  elsif params['Digits'] == '4'
    redirect '/course/selected/4'
  elsif params['Digits'] == '5'
    redirect '/course/selected/5'
  end
  response.text
end

get '/course/selected/1' do
  Twilio::TwiML::Response.new do |r|
    r.Say "Welcome to course 1.  How to greet the homeowner."
    r.Say 'Listen to this conversation between the homeowner and a contractor.  Your goal is to pronounce everything just like the people speaking.'
    r.Say 'Enjoy learning english the easy way.'
    r.Play 'https://s3.amazonaws.com/pre-paid-language/01+Wolf+%26+I.mp3'
    r.Say 'Great job! What do you want to do next?'
    r.Gather :numDigits => '1', :action => '/course/selected/1/done', :method => 'get' do |g|
      g.Say 'Press 1 to start the course over'
      g.Say 'Press 2 to go back to the main menu'
    end
  end.text
end

get '/course/selected/1/done' do
  if params['Digits'] == '1'
    redirect '/course/selected/1'
  elsif params['Digits'] == '2'
    redirect '/course/mainmenu'
  end.text
end

get '/course/selected/2' do
  Twilio::TwiML::Response.new do |r|
    r.Say "Welcome to course 2.  How to negotiate a job"
    r.Say 'Listen to this conversation between the homeowner and a contractor.  Your goal is to pronounce everything just like the people speaking.'
    r.Say 'Enjoy learning english the easy way.'
    r.Say 'Course material goes here.'
    r.Say 'Great job! What do you want to do next?'
    r.Gather :numDigits => '1', :action => '/course/selected/2/done', :method => 'get' do |g|
      g.Say 'Press 1 to start the course over'
      g.Say 'Press 2 to go back to the main menu'
    end
  end.text
end

get '/course/selected/2/done' do
  if params['Digits'] == '1'
    redirect '/course/selected/2'
  elsif params['Digits'] == '2'
    redirect '/course/mainmenu'
  end.text
end

get '/course/selected/3' do
  Twilio::TwiML::Response.new do |r|
    r.Say "Welcome to course 4.  How to ask questions about your job"
    r.Say 'Listen to this conversation between the homeowner and a contractor.  Your goal is to pronounce everything just like the people speaking.'
    r.Say 'Enjoy learning english the easy way.'
    r.Play 'https://s3.amazonaws.com/pre-paid-language/01+Wolf+%26+I.mp3'
    r.Say 'Great job! What do you want to do next?'
    r.Gather :numDigits => '1', :action => '/course/selected/3/done', :method => 'get' do |g|
      g.Say 'Press 1 to start the course over'
      g.Say 'Press 2 to go back to the main menu'
    end
  end.text
end

get '/course/selected/3/done' do
  if params['Digits'] == '1'
    redirect '/course/selected/3'
  elsif params['Digits'] == '2'
    redirect '/course/mainmenu'
  end.text
end

get '/course/selected/4' do
  Twilio::TwiML::Response.new do |r|
    r.Say "Welcome to course 4.  How to negotiate your pay"
    r.Say 'Listen to this conversation between the homeowner and a contractor.  Your goal is to pronounce everything just like the people speaking.'
    r.Say 'Enjoy learning english the easy way.'
    r.Play 'https://s3.amazonaws.com/pre-paid-language/01+Wolf+%26+I.mp3'
    r.Say 'Great job! What do you want to do next?'
    r.Gather :numDigits => '1', :action => '/course/selected/4/done', :method => 'get' do |g|
      g.Say 'Press 1 to start the course over'
      g.Say 'Press 2 to go back to the main menu'
    end
  end.text
end

get '/course/selected/4/done' do
  if params['Digits'] == '1'
    redirect '/course/selected/4'
  elsif params['Digits'] == '2'
    redirect '/course/mainmenu'
  end.text
end

get '/course/selected/5' do
  Twilio::TwiML::Response.new do |r|
    r.Say "Welcome to course 5.  How to get more work"
    r.Say 'Listen to this conversation between the homeowner and a contractor.  Your goal is to pronounce everything just like the people speaking.'
    r.Say 'Enjoy learning english the easy way.'
    r.Play 'https://s3.amazonaws.com/pre-paid-language/01+Wolf+%26+I.mp3'
    r.Say 'Great job! What do you want to do next?'
    r.Gather :numDigits => '1', :action => '/course/selected/5/done', :method => 'get' do |g|
      g.Say 'Press 1 to start the course over'
      g.Say 'Press 2 to go back to the main menu'
    end
  end.text
end

get '/course/selected/5/done' do
  if params['Digits'] == '1'
    redirect '/course/selected/5'
  elsif params['Digits'] == '2'
    redirect '/course/mainmenu'
  end.text
end