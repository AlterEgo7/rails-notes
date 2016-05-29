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

      it { is_expected.to respond_with 200 }
    end

    context "when the credentials are incorrect" do
      before(:each) do
        credentials = { username: @user.username, email: @user.email, password: "invalid_password" }
        post :create, params: { session: credentials }
      end

      it "should return a json with an error" do
        expect(json_response[:errors]).to eq 'Invalid username or password'
      end

      it { is_expected.to respond_with 422 }
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @user = FactoryGirl.create :user
      sign_in @user
      delete :destroy, params: { id: @user.auth_token }
    end

    it "should reset the user token" do
      token = @user.auth_token
      @user.reload
      expect(token).not_to eq @user.auth_token
    end

    it { is_expected.to respond_with 204 }
  end
end
