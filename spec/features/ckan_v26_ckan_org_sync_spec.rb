require 'rails_helper'

describe 'ckan organisation sync' do
  subject { CKAN::V26::CKANOrgSyncWorker.new }

  let(:list_organization) { JSON.parse(file_fixture("ckan/v26/list_organization.json").read) }
  let(:show_organization_create) { JSON.parse(file_fixture("ckan/v26/show_organization_create.json").read) }
  let(:show_organization_update) { JSON.parse(file_fixture("ckan/v26/show_organization_update.json").read) }

  let(:organisation_to_create_id) { list_organization["result"][0] }
  let(:organisation_to_update_id) { list_organization["result"][1] }

  let!(:organisation_to_delete) { create :organisation, name: "organisation_to_delete", govuk_content_id: nil }
  let!(:organisation_to_ignore) { create :organisation, name: "organisation_to_ignore" }
  let!(:organisation_to_update) { create :organisation, name: organisation_to_update_id }

  before do
    stub_request(:get, "http://ckan/api/3/action/organization_list")
      .to_return(body: list_organization.to_json)

    stub_request(:get, "http://ckan/api/3/action/organization_show")
      .with(query: { id: organisation_to_create_id })
      .to_return(body: show_organization_create.to_json)

    stub_request(:get, "http://ckan/api/3/action/organization_show")
      .with(query: { id: organisation_to_update_id })
      .to_return(body: show_organization_update.to_json)
  end

  it 'creates new organisations when they appear in ckan' do
    subject.perform
    expect(Organisation.pluck(:name)).to include organisation_to_create_id
  end

  it 'updates existing organisations when they change in ckan' do
    expect { subject.perform }
      .to(change { organisation_to_update.reload.updated_at })
  end

  it 'deletes organisations when they disappear from ckan' do
    subject.perform
    expect(Organisation.all).to_not include organisation_to_delete
  end

  it 'does not delete organisations with a govuk_content_id' do
    subject.perform
    expect(Organisation.all).to include organisation_to_ignore
  end
end
