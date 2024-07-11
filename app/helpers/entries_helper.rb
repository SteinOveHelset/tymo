module EntriesHelper
    def formatted_minutes(total_minutes)
        hours = total_minutes / 60
        minutes = total_minutes % 60
        "#{hours.to_i}h, #{minutes.to_i}m"
    end
end
