class CreateShops < ActiveRecord::Migration[5.1]

  def up

    execute <<-SQL
      CREATE EXTENSION IF NOT EXISTS postgis;
      CREATE EXTENSION IF NOT EXISTS btree_gist;
    SQL

    create_table :shops do |t|
      t.timestamps
      t.string  :name
    end

    execute <<-SQL
      ALTER TABLE shops ADD COLUMN latitude DOUBLE PRECISION NOT NULL CHECK(latitude > -90 AND latitude <= 90);
      ALTER TABLE shops ADD COLUMN longitude DOUBLE PRECISION NOT NULL CHECK(longitude > -90 AND longitude <= 90);
      ALTER TABLE shops ADD COLUMN location GEOMETRY(POINT, 4326) NOT NULL;
      CREATE INDEX geozones_test_location_idx ON shops USING GIST(location);
    SQL

  end

  def down
    drop_table :shops
  end

end
