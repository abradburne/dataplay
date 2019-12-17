class Dataset < ApplicationRecord
  has_one_attached :datafile

  def db_tables
    db = open_db
    stm = db.prepare "SELECT name FROM sqlite_master WHERE type='table';"
    rs = stm.execute
    rs.map { |row| row.join "\s" }
  end

  def db_table_name
    db_tables.first
  end

  def db_rows_count
    db = open_db
    stm = db.prepare "SELECT count(*) FROM #{db_table_name};"
    rs = stm.execute
    rs.next.first
  end

  def db_columns
    db = open_db
    stm = db.prepare "PRAGMA table_info('#{db_table_name}') "
    rs = stm.execute
    rs.collect {|r| r }
  end

  def first_five
    db = open_db
    stm = db.prepare "SELECT * FROM #{db_table_name} LIMIT 5;"
    rs = stm.execute
    rs.map { |row| row.join "\s" }
  end

  def open_db
    SQLite3::Database.open datafile_on_disk
    # db.results_as_hash = true
  end

  def datafile_on_disk
    ActiveStorage::Blob.service.send(:path_for, datafile.key)
  end
end
