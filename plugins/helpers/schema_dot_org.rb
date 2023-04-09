module Helpers::SchemaDotOrg
  def wrap_jsonld_schema(data)
    data.merge("@context" => "https://schema.org/").to_json.html_safe
  end

  # https://schema.org/PodcastEpisode
  def recording_jsonld_schema(recording)
    result = {
      "@type" => "PodcastEpisode",
      "name" => recording.data.title,
      "@id" => recording.absolute_url,
      "url" => recording.absolute_url,
      "datePublished" => recording.data.date,
      "duration" => "PT#{recording.data.minutes}M",
      "inLanguage" => "uk",
      "sameAs" => recording.data.links_to_listen,
      "partOfSeries" => podcast_jsonld_schema(recording.relations.podcast),
      "actor" => recording.relations.people.map { |person| person_jsonld_schema(person) },
    }

    recording.data.number&.then do |recording_number|
      result.merge!("episodeNumber" => recording_number)
    end

    recording.relations.podcast_lists&.find { |pl| pl.data.season_number }&.then do |podcast_list|
      result.merge!("partOfSeason" => podcast_season_jsonld_schema(podcast_list))
    end

    result
  end

  # https://schema.org/PodcastSeries
  def podcast_jsonld_schema(podcast)
    {
      "@type" => "PodcastSeries",
      "name" => podcast.data.title,
      "@id" => podcast.absolute_url,
      "url" => podcast.absolute_url,
      "startDate" => podcast.relations.recordings.last&.then { |data| data.date },
      "endDate" => podcast.relations.recordings.first&.then { |data| data.date },
      "inLanguage" => "uk",
    }
  end

  # https://schema.org/PodcastSeason
  def podcast_season_jsonld_schema(podcast_list)
    {
      "@type" => "PodcastSeason",
      "@id" => podcast_list.absolute_url,
      "url" => podcast_list.absolute_url,
      "name" => podcast_list.data.title,
      "seasonNumber" => podcast_list.data.season_number,
      "numberOfEpisodes" => podcast_list.relations.recordings.size,
      "startDate" => podcast_list.relations.recordings.last&.then { |data| data.date },
      "endDate" => podcast_list.relations.recordings.first&.then { |data| data.date },
      "partOfSeries" => podcast_jsonld_schema(podcast_list.relations.podcast),
    }
  end

  # https://schema.org/Person
  def person_jsonld_schema(person)
    result = {
      "@type" => "Person",
      "@id" => person.absolute_url,
      "url" => person.absolute_url,
      "name" => person.data.name,
    }

    person.data.social_media_links&.then do |social_media_links|
      result.merge!("sameAs" => social_media_links)
    end

    result
  end
end
