# Set up for the application and database. DO NOT CHANGE. #############################
require "sequel"                                                                      #
connection_string = ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/development.sqlite3"  #
DB = Sequel.connect(connection_string)                                                #
#######################################################################################

# Database schema - this should reflect your domain model
DB.create_table! :houses do
  primary_key :id
  String :address
  String :city_state_zip
  String :description, text: true
end

DB.create_table! :reviews do
  primary_key :id
  foreign_key :house_id
  foreign_key :user_id
  Boolean :recommend
  String :candy
  Integer :decorations
  String :name
  Boolean :candy_gone
end

DB.create_table! :users do
  primary_key :id
  String :name
  String :email
  String :password
end

# Insert initial (seed) data
houses_table = DB.from(:houses)

houses_table.insert(address: "1917 Greenwood Ave",
                    city_state_zip: "Wilmette, IL 60091",
                    description: "White colonial house with blue shutters")

houses_table.insert(address: "2022 Thornwood Ave",
                    city_state_zip: "Wilmette, IL 60091",
                    description: "Red brick house with green shutters")
