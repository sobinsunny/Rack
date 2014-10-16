class User< ActiveRecord::Migration
  def up
     create_table :users, force: true do |t|
      t.string :username
      t.string :password
    end
  end
end