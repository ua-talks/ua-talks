class Builders::Helpers < SiteBuilder
  def build
    helper :link_to_listen_host_name
    helper :recording_title
    helper :recording_full_title
    helper :next_recording
    helper :prev_recording
  end

  def link_to_listen_host_name(link)
    link[%r{https?://(?:www.)?([^/]+)}, 1]
  end

  def recording_title(recording)
    if recording.data.number
      "##{recording.data.number} #{recording.data.title}"
    else
      recording.data.title
    end
  end

  def recording_full_title(recording)
    "#{recording.relations.podcast.data.name} – #{recording_title(recording)}"
  end

  # Can't use `resource.previous`, it returns a recording regardless of podcast
  def prev_recording(recording)
    all_recordings = recording.relations.podcast.relations.recordings
    idx = all_recordings.index(recording)
    all_recordings[idx + 1] # recordings are sorted descending
  end

  # Can't use `resource.next`, it returns a recording regardless of podcast
  def next_recording(recording)
    all_recordings = recording.relations.podcast.relations.recordings
    idx = all_recordings.index(recording)
    if idx > 0
      all_recordings[idx - 1] # recordings are sorted descending
    end
  end
end
