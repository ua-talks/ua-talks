module Helpers::RecordingTitle
  def recording_numbered_title(recording)
    if recording.data.number
      "##{recording.data.number} #{recording.data.title}"
    else
      recording.data.title
    end
  end

  def recording_full_title(recording)
    "#{recording.relations.podcast.data.name} – #{recording_numbered_title(recording)}"
  end
end
