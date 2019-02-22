
RSpec.describe "DELETE /ratingQuestions/:id" do
  context "with an existing question" do
    it "actually deletes the question" do
      post "/ratingQuestions",{ title: "Hello World" }.to_json
      body = JSON.parse(last_response.body)
      delete "ratingQuestions/#{body["id"]}"
      get "/ratingQuestions/#{body["id"]}"
      expect(last_response.status).to eq(404)
    end
  end
end
