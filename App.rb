require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require "pry"
require 'mongo'
require 'json'

require_relative "environment"

before do
  response.headers["Access-Control-Allow-Methods"] = "GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"
  response.headers["Access-Control-Allow-Headers"] = "Authorization", "Content-Type", "Accept", "X-User-Email", "X-Auth-Token"
  response.headers['Access-Control-Allow-Origin'] = "http://localhost:3000"
  content_type :json
end

options "*" do
  200
end


def serialize_question(question)
  {
    id: question.id.to_s,
    title: question.title,
    tag: question.tag
  }
end


get '/ratingQuestions' do
  RatingQuestion.all.map do |question|
    serialize_question(question)
  end.to_json
end

get '/ratingQuestions/:id' do
  question = RatingQuestion.find(params[:id])

  halt 404 unless question

  serialize_question(question).to_json
end

post '/ratingQuestions' do
  body = request.body.read
  halt 400 if body.size.zero?

  json_params = JSON.parse(body)
  question = RatingQuestion.new(json_params)

  if question.save
    status 201
    response.body = serialize_question(question).to_json
  else
    response.body = { "errors" => question.errors.messages }.to_json
    halt 422
  end
end

delete '/ratingQuestions/:id' do
  question = RatingQuestion.find(params[:id])
  halt 404 unless question

  question.destroy
  status 204
  {}
end


def update
  json_params = JSON.parse(request.body.read)
  question = RatingQuestion.find(params[:id])
  halt 404 unless question

  question.update(json_params)
  question.to_json
end

put('/ratingQuestions/:id') { update }
patch('/ratingQuestions/:id') { update }


before_action :find_question

def find_question
  question = RatingQuestion.find(params[:id])
  unless question
    head 404
    render plain: "Not found"
    return
  end
  question
end
