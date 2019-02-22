
RSpec.describe "GET /ratingQuestions" do
  context "its getting all the results" do
    it "returns a 200 OK" do
      get "/ratingQuestions" 
      expect(last_response.status).to eq(200)
      body = JSON.parse(last_response.body)
      expect(body.is_a?(Array)).to eq(true)
    end
  end
end
