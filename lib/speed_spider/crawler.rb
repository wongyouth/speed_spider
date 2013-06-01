require 'anemone'
require 'speed_spider/anemone_hack'
require 'fileutils'
require 'uri'

module SpeedSpider
  class Crawler
    def initialize(start_url, options)
      @start_url = start_url
      @base_url = options[:base_url]
      @options = options
    end

    # return urls from css file contents
    def get_urls_from_css data, pos = 0
      if m = data.match(/url\((.*?)\)/i, pos)
        [ m[1] ] + get_urls_from_css(data, m.end(1) + 1)
      else
        []
      end
    end

    def focus_crawl
      lambda { |page|
        links = []
        if page.doc
          # include javascripts and img files as target links
          page.doc.search('//script[@src]', '//img[@src]', '//iframe[@src]').each do |s|
            u = s['src']
            next if u.nil? or u.empty?
            abs = page.to_absolute u rescue next
            links << abs if page.in_domain? abs
          end

          # include css files as target links
          page.doc.search('//link[@href]').each do |s|
            u = s['href']
            next if u.nil? or u.empty?
            abs = page.to_absolute u rescue next
            links << abs if page.in_domain? abs

          end
        elsif page.url.to_s.end_with? '.css'
          get_urls_from_css(page.body).each do |s|
            u = s.gsub('"', '').gsub("'", '')
            next if u.nil? or u.empty?
            abs = page.to_absolute u rescue next
            links << abs if page.in_domain? abs
          end
        end

        page.links + links.uniq
      }
    end

    def after_crawl
      lambda { |pages|
        pages.each do |url, page|
          path = page.url.path
          path += 'index.html' if path.end_with? '/' or path.empty?

          path = "#{@options[:dir]}/#{page.url.host}#{path}"
          dir = File.dirname path

          FileUtils.mkdir_p dir unless dir.empty?
          File.open path, 'w' do |f|
            f.write page.body
          end

          puts "save file #{path}" if @options[:verbose]
        end
      }
    end

    def crawl
      Anemone.crawl @start_url, @options do |spider|
        spider.focus_crawl &focus_crawl
        spider.after_crawl &after_crawl
      end
    end
  end
end
