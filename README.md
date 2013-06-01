# SpeedSpider

A simple and speedy web spider for pages downloading.

SpeedSpider is based on ruby spider framework [Anemone][1], it's easy to use and very fast since it uses threads for page fetching.

## What kind of files will be downloaded

### links in html pages

* link,        xpath: `//a[@href]`
* stylesheet,  xpath: `//link[@src]`
* javascript,  xpath: `//script[@src]`
* iframe file, xpath: `//iframe[@src]`
* image file,  xpath: `//img[@src]`

### urls in stylesheet files

* urls with parttern url\((.*)\)

## Installation

install it with rubygem:

    gem install 'speed_spider'

## Usage
    Usage: speed_spider [options] start_url

    options:
        -S, --slient                     slient output
        -D, --dir String                 directory for download files to save to. "download" by default
        -b, --base_url String            any url not starts with base_url will not be saved
        -t, --threads Integer            threads to run for fetching pages, 4 by default
        -u, --user_agent String          words for request header USER_AGENT
        -d, --delay Integer              delay between requests
        -o, --obey_robots_text           obey robots exclustion protocol
        -l, --depth_limit                limit the depth of the crawl
        -r, --redirect_limit Integer     number of times HTTP redirects will be followed
        -a, --accept_cookies             accept cookies from the server and send them back?
        -s, --skip_query_strings         skip any link with a query string? e.g. http://foo.com/?u=user
        -H, --proxy_host String          proxy server hostname
        -P, --proxy_port Integer         proxy server port number
        -T, --read_timeout Integer       HTTP read timeout in seconds
        -V, --version                    Show version

## Example

    speed_spider http://twitter.github.io/bootstrap/

It will download all files within the same domain  as `twitter.github.io`, and save to `download/twitter.github.io/`.

    speed_spider -b http://ruby-doc.org/core-2.0/ http://ruby-doc.org/core-2.0/

It will only download urls start with http://ruby-doc.org/core-2.0/, notice `assets` files like image, css, js, font will not obey `base_url` rule.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

[1]: http://anemone.rubyforge.org/
