require 'support/active_record/connection_adapters/abstract_mysql_adapter'

ActiveRecord::Base.establish_connection({
  adapter: 'mysql2',
  database: ENV.fetch('MYSQL_DATABASE', 'seeder_test'),
  host: ENV.fetch('MYSQL_HOST', 'localhost'),
  password: ENV.fetch('MYSQL_PASSWORD', ''),
  username: ENV.fetch('MYSQL_USER', 'seeder')
})

tables_method = ActiveRecord::VERSION::MAJOR >= 5 ? :data_sources : :tables

ActiveRecord::Base.connection.public_send(tables_method).each do |table|
  ActiveRecord::Base.connection.drop_table table
end

ActiveRecord::Schema.define do
  create_table :grades do |t|
    t.integer :student_id
    t.integer :course_id
    t.integer :grade
  end
end

class Grade < ActiveRecord::Base
end
