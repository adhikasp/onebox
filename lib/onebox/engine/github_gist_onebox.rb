module Onebox
  module Engine
    class GithubGistOnebox
      include Engine
      include LayoutSupport
      include JSON

      matches do
        http
        with("gist.")
        domain("github")
        tld("com")
      end

      def url
        "https://api.github.com/gists/#{match[:sha]}"
      end

      private

      def match
        @match ||= @url.match(%r{gist\.github\.com/([^/]+/)?(?<sha>[0-9a-f]+)})
      end

      def data
        {
          link: link,
          domain: "http://gist.github.com",
          badge: "g",
          title: raw["description"],
          author: raw["user"]["login"],
          sha: match[:sha]
        }
      end
    end
  end
end