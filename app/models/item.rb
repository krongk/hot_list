class Item < ActiveRecord::Base
  belongs_to :list
  default_scope order("updated_at DESC")
end
