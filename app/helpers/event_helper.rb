module EventHelper
  def extract_time
    time_str = params[:time]
    hours, minutes = time_str.split /\s*[\.\:\-]\s*/
    Date.today.to_time + 3600 * hours.to_i + 60 * minutes.to_i
  end
end
