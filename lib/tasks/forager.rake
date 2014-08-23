
namespace :forager do
  desc "Forager top news from People.com.cn"
  task people_com: :environment do
    TestMech.new.process
  end

end

class TestMech < Mechanize
  def process
    get 'http://news.people.com.cn/GB/28053/'

    page.links_with(:href => %r{/n/\d+} ).each do |link|
      next if link.href =~ %r{/projects/support/}

      puts 'Loading %-30s %s' % [link.href, link.text]
      begin
        transact do
          click link
          # Do stuff, maybe click more links.
        end
        # Now we're back at the original page.

      rescue => e
        $stderr.puts "#{e.class}: #{e.message}"
      end
    end
  end
end