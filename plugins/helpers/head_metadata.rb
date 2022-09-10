module Helpers::HeadMetadata
  def head_title(resource)
    custom_title_method = "#{resource.collection.label}_head_title"
    public_send(custom_title_method, resource)
  end

  def recordings_head_title(resource)
    "«#{resource.data.title}» з подкасту «#{resource.relations.podcast.data.name}»"
  end

  def podcasts_head_title(resource)
    "Подкаст «#{resource.data.name}»"
  end

  def people_head_title(resource)
    resource.data.name
  end

  def publishers_head_title(resource)
    resource.data.name
  end

  def pages_head_title(resource)
    I18n.t("#{resource.data.slug}.title")
  end
end
