class SiteBuilder < Bridgetown::Builder
  # write builders which subclass SiteBuilder in plugins/builders
end

Bridgetown::Resource::PermalinkProcessor.register_placeholder :podcast, ->(resource) do
  resource.data.podcast
end
