module Helpers::PrettyHostName
  def pretty_host_name(link)
    link[%r{https?://(?:www.)?([^/]+)}, 1]
  end
end
