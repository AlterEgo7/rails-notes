require 'rails_helper'

describe Api::V1::SessionsController, type: :controller do

  describe "POST #create" do
    before(:each) do
      @user = FactoryGirl.create :user
    end

    context "when the credentials are correct" do
      before(:each) do
        credentials = { username: @user.username, password: '123456' }
        post :create, params: { session: credentials }
      end

      it "should return the user record corresponding to teh given credentials" do
        @user.reload
        expect(json_response[:auth_token]).to eq @user.auth_token
      end
    end
  end
end
