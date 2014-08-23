#encoding: utf-8
require 'open-uri'
require 'hpricot'

namespace :forager do
  desc "Forager top news from People.com.cn"
  task people_com: :environment do
    while true
      begin
        PeopleCom.new.run
        sleep(3.hours)
      rescue Exception => e
        puts e.message
        sleep(3.hours)
        retry
      end
    end
  end
end

class PeopleCom
  def run
    puts "start at: #{Time.now.to_s}"
    index = 0

    url = 'http://news.people.com.cn/GB/28053/'
    html = open(url).read
    html.force_encoding("gbk")
    html.encode!("utf-8")
    doc = Hpricot(html)

    doc.search("//a.anavy").each do |link|
      title = link.inner_text
      the_url = link.attributes['href']
      Item.find_or_create_by(list_id: 1, title: title, url: the_url, title_length: title.length)
      index += 1
    end
    puts index
  end
end