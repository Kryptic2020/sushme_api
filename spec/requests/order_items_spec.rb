require 'rails_helper'

RSpec.describe "OrderItems", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/order_items/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/order_items/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/order_items/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /delete" do
    it "returns http success" do
      get "/order_items/delete"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/order_items/update"
      expect(response).to have_http_status(:success)
    end
  end

end
