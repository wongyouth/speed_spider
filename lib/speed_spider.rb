require "speed_spider/version"
require 'speed_spider/cli'
require 'speed_spider/crawler'
require 'debugger'

module SpeedSpider
  def self.crawl
    cli = Cli.new.parse!

    start_url = ARGV[0]
    (puts cli.option_parser.help; exit 1) if start_url.nil?

    crawler = Crawler.new start_url, cli.options
    crawler.crawl
  end

end
