
RSpec.describe "PUT /ratingQuestions/:id" do
  context "when the question exists" do
    it "returns a 200 OK" do
      post "/ratingQuestions", { title: "Hello World", tag: "greetings" }.to_json
      body = JSON.parse(last_response.body)
      put "/ratingQuestions/#{body["id"]}", { title: "Hello Mars" }.to_json
      new_body = JSON.parse(last_response.body)
      expect(last_response.status).to eq(200)
      expect(new_body.is_a?(Hash)).to eq(true)
      expect(new_body["title"]).to eq("Hello Mars")
      expect(new_body.key?("tag")).to be true
    end
  end

  context "asking to PUT a question that doesn't exist" do
    it "returns a 404 Not Found" do
      put "/ratingQuestions/i-will-never-exist",{ title: "hello"}.to_json
      expect(last_response.status).to eq(404)
    end
  end
end
