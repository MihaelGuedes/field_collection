require "rails_helper"

RSpec.describe FormulariesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/formularies").to route_to("formularies#index")
    end

    it "routes to #show" do
      expect(get: "/formularies/1").to route_to("formularies#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/formularies").to route_to("formularies#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/formularies/1").to route_to("formularies#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/formularies/1").to route_to("formularies#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/formularies/1").to route_to("formularies#destroy", id: "1")
    end
  end
end
