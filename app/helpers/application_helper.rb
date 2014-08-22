module ApplicationHelper
  
  def random_color
    %w{red blue green orange pink}[rand(5)]
  end
end
