module ApplicationHelper
  COLORS = ['gray','red','orange','cyan2','blue','grass','green', 'light-green','cyan','purple','pink','yellow']
  
  def random_color
    colors_dup = COLORS.dup
    colors_dup.delete(session[:color])
    session[:color] = colors_dup.sample
  end
end
