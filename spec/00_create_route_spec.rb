require "spec_helper"

RSpec.describe "POST /ratingQuestions" do
  let(:new_title) { "Hello World" }
  let(:new_tag) { "new tag" }

  context "when the request has a body" do
    before do
      post "/ratingQuestions", { title: new_title, tag: new_tag }.to_json
    end

    let(:question) do
      JSON.parse(last_response.body)
    end

    it "returns a 201" do
      expect(last_response.status).to eq(201)
    end

    it "returns the new document" do
      expect(question.is_a?(Hash)).to eq(true)
      expect(question.key?("id")).to eq(true)
      aggregate_failures do
        expect(question["title"]).to eq(new_title)
        expect(question["tag"]).to eq(new_tag)
      end
    end
  end

  context "when the request has no body" do
    it "returns a 400 Bad Request" do
      post "/ratingQuestions"
      expect(last_response.status).to eq(400)
    end
  end

  context "when the request has a blank title" do
    it "returns a 422 Invalid Resource" do
      post "/ratingQuestions", { title: "" }.to_json
      expect(last_response.status).to eq(422)
      error = JSON.parse(last_response.body)
      expect(error).to eq({"errors"=>{"title"=>["can't be blank"]}})
    end
  end
end
