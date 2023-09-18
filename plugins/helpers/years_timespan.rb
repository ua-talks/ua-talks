module Helpers::YearsTimespan
  def years_timespan(years)
    if years.size == 1
      years.first
    else
      "#{years.first} – #{years.last}"
    end
  end

  def years_timespans(years)
    years \
      .sort
      .chunk_while { |prev, current| prev + 1 == current }
      .map { |years| years_timespan(years) }
      .join(", ")
  end
end
