require 'speed_spider/crawler'
require 'optparse'
require 'ostruct'

module SpeedSpider
  class Cli
    attr_reader :options, :option_parser

    def initialize
      @options = {
        # only url start with base_url will save to local
        :base_url => '',
        # directory for downloaded files to save to
        :dir => 'download',
        # run 4 Tentacle threads to fetch pages
        :threads => 4,
        # verbose output
        :verbose => true,
        # don't throw away the page response body after scanning it for links
        :discard_page_bodies => false,
        # identify self as WebCrawler/VERSION
        :user_agent => "SpeedSpider/#{SpeedSpider::VERSION}",
        # no delay between requests
        :delay => 0,
        # don't obey the robots exclusion protocol
        :obey_robots_txt => false,
        # by default, don't limit the depth of the crawl
        :depth_limit => false,
        # number of times HTTP redirects will be followed
        :redirect_limit => 5,
        # storage engine defaults to Hash in +process_options+ if none specified
        :storage => nil,
        # Hash of cookie name => value to send with HTTP requests
        :cookies => nil,
        # accept cookies from the server and send them back?
        :accept_cookies => false,
        # skip any link with a query string? e.g. http://foo.com/?u=user
        :skip_query_strings => false,
        # proxy server hostname 
        :proxy_host => nil,
        # proxy server port number
        :proxy_port => false,
        # HTTP read timeout in seconds
        :read_timeout => nil
      }
    end

    def parse!
      @option_parser = OptionParser.new do |opts|
        opts.banner = "Usage: speed_spider [options] start_url"
        opts.separator ""
        opts.separator "options:"

        opts.on('-S', '--slient', 'slient output') do
          @options[:verbose] = false
        end

        opts.on('-D', '--dir String', 'directory for download files to save to. "download" by default') do |value|
          options[:dir]  = value
        end

        opts.on('-b', '--base_url String', 'any url not starts with base_url will not be saved') do |value|
          value += '/' unless value.end_with? '/'
          options[:base_url]  = value
        end

        opts.on('-t', '--threads Integer', Integer, 'threads to run for fetching pages, 4 by default') do |value|
          @options[:threads] = value
        end

        opts.on('-u', '--user_agent String', 'words for request header USER_AGENT') do |value|
          @options[:user_agent] = value
        end

        opts.on('-d', '--delay Integer', Integer, 'delay between requests in seconds') do |value|
          @options[:delay] = value
        end

        opts.on('-o', '--obey_robots_text', 'obey robots exclustion protocol') do
          @options[:obey_robots_txt] = true
        end

        opts.on('-l', '--depth_limit', 'limit the depth of the crawl') do
          @options[:delay] = true
        end

        opts.on('-r', '--redirect_limit Integer', Integer, 'number of times HTTP redirects will be followed') do |value|
          @options[:redirect_limit] = value
        end

        opts.on('-a', '--accept_cookies', 'accept cookies from the server and send them back?') do
          @options[:accept_cookies] = true
        end

        opts.on('-s', '--skip_query_strings', 'skip any link with a query string? e.g. http://foo.com/?u=user') do
          @options[:skip_query_strings] = true
        end

        opts.on('-H', '--proxy_host String', 'proxy server hostname') do |value|
          @options[:proxy_host] = value
        end

        opts.on('-P', '--proxy_port Integer', Integer, 'proxy server port number') do |value|
          @options[:proxy_port] = value
        end

        opts.on('-T', '--read_timeout Integer', Integer, 'HTTP read timeout in seconds') do |value|
          @options[:read_timeout] = value
        end

        # print the version.
        opts.on_tail("-V", "--version", "Show version") do
          puts SpeedSpider::VERSION
          exit
        end
      end

      @option_parser.parse!

      self
    end
  end
end
