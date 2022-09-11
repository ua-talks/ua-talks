require "loofah"

module Helpers::HeadMetadata
  def head_title(resource)
    custom_title_method = "#{resource.collection.label}_head_title"
    public_send(custom_title_method, resource)
  end

  def recordings_head_title(resource)
    resource.data.title
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

  def head_description(resource)
    custom_description_method = "#{resource.collection.label}_head_description"
    public_send(custom_description_method, resource)
  end

  def recordings_head_description(resource)
    podcast = resource.relations.podcast.data.name
    if resource.data.number
      "Випуск ##{resource.data.number} подкасту «#{podcast}»"
    else
      "Окремий випуск подкасту «#{podcast}»"
    end
  end

  def podcasts_head_description(resource)
    Loofah.fragment(resource.content).text.squish
  end

  def people_head_description(resource)
    podcasts = resource.relations.recordings.reduce(Set.new) { |memo, r| memo << r.relations.podcast }
    if podcasts.size > 1
      "Учасник подкастів #{podcasts.map{ |p| "«#{p.data.name}»" }.join(", ")}"
    else
      podcast = podcasts.first
      "Учасник подкасту «#{podcast.data.name}»"
    end
  end

  def publishers_head_description(resource)
    Loofah.fragment(resource.content).text.squish
  end

  def pages_head_description(resource)
    I18n.t("#{resource.data.slug}.description")
  end
end
