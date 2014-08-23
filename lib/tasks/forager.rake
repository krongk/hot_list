#encoding: utf-8
require 'open-uri'
require 'hpricot'

namespace :forager do
  desc "Forager top news from People.com.cn"
  task people_com: :environment do
    url = 'http://news.people.com.cn/GB/28053/'
    html = open(url).read
    html.force_encoding("gbk")
    html.encode!("utf-8")
    doc = Hpricot(html)
    doc.search("//a.anavy").each do |link|
       title = link.inner_text
       puts title
    end
  end
end

class TestMech < Mechanize

  def process
    get('http://news.people.com.cn/GB/28053/', nil,nil,{ 'Accept-Charset' => 'utf-8' })
    page.encoding = 'utf-8'

    page.links_with(:href => %r{/n/\d+} ).each do |link|
      next if link.href =~ %r{/projects/support/}
      begin
        puts 'Loading %-30s %s' % [link.href, link.text]
        txt = link.text.force_encoding('utf-8')
        txt.encode!("utf-8") 
    
        Item.find_or_create_by(list_id: 1, url: link.href, title: txt)
      rescue => ex
        puts ex.message
      end
    end
  end
end

# TestMech.new.process