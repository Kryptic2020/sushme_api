require 'rails_helper'

RSpec.describe "Orders", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/order/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/order/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/order/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /delete" do
    it "returns http success" do
      get "/order/delete"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/order/update"
      expect(response).to have_http_status(:success)
    end
  end

end
