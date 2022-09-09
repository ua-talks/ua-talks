# Can't use `resource.previous/next`, it returns a recording regardless of podcast
module Helpers::PrevNextRecording
  def prev_recording(recording)
    all_recordings = recording.relations.podcast.relations.recordings
    idx = all_recordings.index(recording)
    all_recordings[idx + 1] # recordings are sorted descending
  end

  def next_recording(recording)
    all_recordings = recording.relations.podcast.relations.recordings
    idx = all_recordings.index(recording)
    if idx > 0
      all_recordings[idx - 1] # recordings are sorted descending
    end
  end
end
