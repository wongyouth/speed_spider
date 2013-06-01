module Anemone
  class Core
    #
    # Returns +true+ if *link* should not be visited because
    # its URL matches a skip_link pattern.
    #
    def skip_link_with_hack?(link)
      skip_link_without_hack?(link) or !link.path.to_s.start_with? @opts[:base_url]
    end

    alias_method :skip_link_without_hack?, :skip_link?
    alias_method :skip_link?, :skip_link_with_hack?
  end
end
