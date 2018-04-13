require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  it { is_expected.to validate_presence_of(:email) }
  # it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to validate_confirmation_of(:password) }
  it { is_expected.to allow_value('mgswolf@gmail.com').for(:email) }
  it { is_expected.to validate_uniqueness_of(:auth_token) }

  it { is_expected.to have_many(:tasks).dependent(:destroy) }

  describe '#info' do
    it "returns email and created_at" do
      allow(Devise).to receive(:friendly_token).and_return('abc123zyzTOKEN')
      user.save!

      expect(user.info).to eq("#{user.email} - #{user.created_at} - Token: abc123zyzTOKEN")
    end
  end

  describe "#generate_auth_token!" do
    it "generates a unique auth token" do
      allow(Devise).to receive(:friendly_token).and_return('abc123zyzTOKEN')
      user.generate_auth_token!

      expect(user.auth_token).to eq('abc123zyzTOKEN')
    end

    it "generates another auth token when the crrent auth token already has been taken" do
      allow(Devise).to receive(:friendly_token).and_return('acbtokenxyz', 'acbtokenxyz', 'abcXYZ123456789')
      existing_user = create(:user)
      user.generate_auth_token!

      expect(user.auth_token).not_to eql(existing_user.auth_token)
    end
  end
end
