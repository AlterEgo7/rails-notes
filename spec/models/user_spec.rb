require 'rails_helper'

describe User, type: :model do
  before { @user = FactoryGirl.build :user }

  subject { @user }

  it { should validate_presence_of :email }
  it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
end