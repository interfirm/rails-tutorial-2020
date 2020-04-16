module DatetimeHelper
  def message_datetime(datetime:)
    logger.debug(datetime)
    today = DateTime.now.beginning_of_day

    if today <= datetime
      datetime.strftime('%R')
    elsif today.yesterday <= datetime
      datetime.strftime('昨日 %R')
    elsif today.beginning_of_year <= datetime
      datetime.strftime('%m月 %d日')
    else
      datetime.strftime('%Y年 %m月 %d日')
    end
  end
end