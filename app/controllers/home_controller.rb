class HomeController < ApplicationController

  def index
    @items = Item.limit(5)
    session[:offset] = @items.last.id
  end

  def next_items
    items = Item.offset(session[:offset]).limit(1)
    session[:offset] = session[:offset].to_i + 1

    html = [%{<div class="swiper-slide <%= random_color %>-slide">}]
    items.each do |item|
      html << %{<div class="title" data-length="#{item.title_length}">}
      html << %{<a href="#{item.url}">#{item.title}</a>}
      html << %{</div>}
    end
    html << %{</div>}
    sleep(1)
    render text: html.join
  end
end
