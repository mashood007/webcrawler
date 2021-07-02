require './models/sqlite'
class Product < Sqlite
  TABLE = 'products'
  def initialize(params)
    connect
    @table_name = TABLE
    @schema = 'id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL UNIQUE, price REAL, description TEXT, more_info TEXT'
    @columns = 'name, price, description, more_info'
    @attributes = params
  end

  def self.all
    super(TABLE) 
  end

  
end