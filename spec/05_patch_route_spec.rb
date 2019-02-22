
RSpec.describe "PATCH /ratingQuestions/:id" do
  context "when the question exists" do
    it "returns a 200 OK" do
      post "/ratingQuestions", { title: "Hello World" }.to_json
      body = JSON.parse(last_response.body)
      patch "/ratingQuestions/#{body["id"]}", { tag: "greetings" }.to_json
      new_body = JSON.parse(last_response.body)
      expect(last_response.status).to eq(200)
      expect(new_body.is_a?(Hash)).to eq(true)
      expect(new_body["title"]).to eq("Hello World")
      expect(new_body["tag"]).to eq("greetings")
    end
  end

  context "asking to get a question that doesn't exist" do
    it "returns a 404 Not Found" do
      patch "/ratingQuestions/i-will-never-exist",  { title: "not here"}.to_json
      expect(last_response.status).to eq(404)
    end
  end
end
