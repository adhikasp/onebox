module Onebox
  class Matcher
    def initialize(link)
      @url = link
    end

    def ordered_engines
      @ordered_engines ||= Engine.engines.sort_by do |e|
        e.respond_to?(:priority) ? e.priority : 100
      end
    end

    def oneboxed
      uri = URI(@url)

      # A onebox needs a path, query or fragment string to be considered
      return if (uri.query.nil? || uri.query.size == 0) &&
                (uri.fragment.nil? || uri.fragment.size == 0) &&
                (uri.path.size == 0 || uri.path == "/")

      ordered_engines.find { |engine| engine === uri }
    rescue URI::InvalidURIError
      # If it's not a valid URL, don't even match
      nil
    end
  end
end
