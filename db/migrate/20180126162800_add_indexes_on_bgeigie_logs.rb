class AddIndexesOnBgeigieLogs < ActiveRecord::Migration
  def change
    add_index :bgeigie_logs, :bgeigie_import_id
    add_index :bgeigie_logs, :device_serial_id
    add_index :measurements, [:captured_at, :unit, :device_id], where: 'device_id IS NOT NULL'
    add_index :measurements, [:value, :device_id], where: 'device_id IS NOT NULL'
  end
end
