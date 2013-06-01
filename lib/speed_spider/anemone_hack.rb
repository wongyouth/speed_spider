module Anemone
  class Core
    def assets?(link)
      %w(js css jpg jpeg png bmp gif svg ttf woff eot).any? do |e|
        /#{e}/i =~ File.extname(link.path).split('.').pop
      end
    end
    #
    # Returns +true+ if *link* should not be visited because
    # its URL matches a skip_link pattern.
    #
    def skip_link_with_hack?(link)
      skip_link_without_hack?(link) or !assets?(link) and !link.to_s.start_with? @opts[:base_url]
    end

    alias_method :skip_link_without_hack?, :skip_link?
    alias_method :skip_link?, :skip_link_with_hack?
  end
end
