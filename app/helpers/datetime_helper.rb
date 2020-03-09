module DatetimeHelper
  def message_datetime(datetime:)
    converted_datetime = datetime.in_time_zone('Tokyo')
    today = DateTime.now.beginning_of_day

    if today <= converted_datetime
      converted_datetime.strftime('%R')
    elsif today.yesterday <= converted_datetime
      converted_datetime.strftime('昨日 %R')
    elsif today.beginning_of_year <= converted_datetime
      converted_datetime.strftime('%m月 %d日')
    else
      converted_datetime.strftime('%Y年 %m月 %d日')
    end
  end
end