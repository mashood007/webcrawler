require 'sqlite3'
require 'json'
class Sqlite
  DATABASE = "web_crawler.db"
  attr_accessor :attributes, :table_name, :schema, :id, :columns
  def connect
    begin
      db = SQLite3::Database.new ":memory:"
      puts db.get_first_value 'SELECT SQLITE_VERSION()'  
    rescue SQLite3::Exception => e 
      puts "Exception occurred"
      puts e  
    ensure
      db.close if db
    end
  end

  def save
    begin
      db = SQLite3::Database.open DATABASE
      db.execute "CREATE TABLE IF NOT EXISTS #{table_name}(#{schema})"
      db.execute "INSERT INTO #{table_name}(#{columns}) VALUES(#{attributes})"
      @id = db.last_insert_row_id
    rescue SQLite3::Exception => e 
      puts "Exception occurred"
    ensure
      db.close if db
    end    
  end

  def self.all(table_name) 
    begin 
      db = SQLite3::Database.open DATABASE  
      stm = db.prepare "SELECT * FROM #{table_name}" 
      rs = stm.execute
      rs.each do |row|
        puts row.join " | "
      end 
    rescue SQLite3::Exception => e 
      puts "Exception occurred"
      puts e
    ensure
      stm.close if stm
      db.close if db
    end
  end

end