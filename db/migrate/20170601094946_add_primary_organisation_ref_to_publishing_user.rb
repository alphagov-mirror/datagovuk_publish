class AddPrimaryOrganisationRefToPublishingUser < ActiveRecord::Migration[5.1]
  def change
    add_column :publishing_users, :primary_organisation_id, :integer
  end
end
