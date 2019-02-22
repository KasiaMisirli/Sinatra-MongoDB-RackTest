
RSpec.describe "GET /ratingQuestions/:id" do
  context "when the question exists" do
    it "returns a 200 OK" do
      post "/ratingQuestions", { title: "Hello World" }.to_json
      body = JSON.parse(last_response.body)
      get "/ratingQuestions/#{body["id"]}"
      expect(last_response.status).to eq(200)
      expect(body.is_a?(Hash)).to eq(true)
    end
  end

  context "asking to get a question that doesn't exist" do
    it "returns a 404 Not Found" do
      get "/ratingQuestions/i-will-never-exist"
      expect(last_response.status).to eq(404)
    end
  end
end
