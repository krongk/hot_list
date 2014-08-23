#encoding: utf-8
namespace :forager do
  desc "Forager top news from People.com.cn"
  task people_com: :environment do
    TestMech.new.process
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
        Item.find_or_create_by(list_id: 1, url: link.href, title: txt)
      rescue => ex
        puts ex.message
      end
    end
  end
end