# frozen_string_literal: true

class AddHashCodeToUrls < ActiveRecord::Migration[6.0]
  def change
    add_column :urls, :hash_code, :string
    add_index :urls, :short_url
    add_index :urls, :hash_code
  end
end
