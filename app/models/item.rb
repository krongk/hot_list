class Item < ActiveRecord::Base
  belongs_to :list
  #default_scope order("ID DESC")
end
