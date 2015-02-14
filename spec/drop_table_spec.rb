require 'spec_helper'

describe "Drop Table" do

  let(:migration) { ActiveRecord::Migration }
  let(:connection) { ActiveRecord::Base.connection }

  before (:each) do
    migration.create_table "things"
  end

  context "deprecation" do

    before(:each) do
      migration.create_table("referer") { |t| t.integer :thing_id }
      migration.add_foreign_key "referer", "things"
      expect { migration.drop_table "things" }.to raise_error ActiveRecord::StatementInvalid, /cannot.*drop/i
    end if SchemaDev::Rspec::Helpers.postgresql?

    it "deprecates :cascade => true" do
      expect(ActiveSupport::Deprecation).to receive(:warn).with(/cascade/)
      migration.drop_table "things", cascade: true
      expect(connection.tables).not_to include "things"
    end

  end

  context "if_exists" do

    When(:drop) { migration.drop_table table, if_exists: if_exists }

    context "not specified" do

      Given(:if_exists) { false }

      context "on existing table" do
        Given(:table) { "things" }
        Then { expect(connection.tables).to be_blank }
      end

      context "on nonexistent table" do
        Given(:table) { "nonesuch" }
        Then { expect(drop).to have_failed }
      end

    end

    context "specified" do

      Given(:if_exists) { true }

      context "on existing table" do
        Given(:table) { "things" }
        Then { expect(connection.tables).to be_blank }
      end

      context "on nonexistent table" do
        Given(:table) { "nonesuch" }
        Then { expect(drop).not_to have_failed }
      end
    end

  end

end
