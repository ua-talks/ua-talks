class Builders::OutgoingLinkAttributes < SiteBuilder
  def build
    inspect_html do |document|
      document.query_selector_all("a").each do |anchor|
        next unless anchor[:href]&.starts_with?("http")

        anchor[:target] ||= "_blank"
        anchor[:rel] ||= "nofollow noopener"
      end
    end
  end
end
