require 'ruby-debug'
require 'pg'

class Database
  attr_accessor :db_id

  def self.find(ip_addr)
    res = execute("select * from databases where ip_addr = '#{ip_addr}'")
    if res.count == 0
      nil
    else
      new(res[0]["id"])
    end
  end

  def self.create(ip_addr)
    res = execute("INSERT INTO databases (ip_addr) VALUES ('#{ip_addr}')")
    database = find(ip_addr)
    execute("CREATE DATABASE red_dirt_#{database.db_id}")
    database
  end

  def initialize(db_id)
    @db_id = db_id
  end

  def uri
    "postgres://ryandotsmith:@localhost/red_dirt_#{@db_id}"
  end

  def self.execute(sql)
    connection.exec(sql)
  end

  def self.connection
    @@conn ||= PGconn.connect(:dbname => "red_dirt_databases")
  end

end

run Proc.new {|env|
  ip_addr = env["REMOTE_ADDR"]
  database = Database.find(ip_addr) || Database.create(ip_addr)
  [
    200,
    {'Content-Type' => 'text/plain'},
    [database.uri]
  ]
}
