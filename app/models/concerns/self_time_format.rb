# coding: utf-8
module SelfTimeFormat

  #
  # 現在時刻を返す
  #
  def time_now(type = '')
    now = DateTime.now
    case type
    when :year
      return now.year
    when :month
      return now.month
    when :day
      return now.day
    else
      return now
    end
  end

  #
  # 年月日をDateTime型に変換
  #
  def obj_datetime(obj = {})
    str = ""
    # 解釈できないと、DateTime.parseで勝手変換されるのを回避
    if (obj[:year] =~ /^[0-9]{4,4}$/) &&
       (obj[:month] =~ /^[0-9]{1,2}$/) &&
       (obj[:day] =~ /^[0-9]{1,2}$/) &&
       (obj[:hour] =~ /^[0-9]{1,2}$/) &&
       (obj[:min] =~ /^[0-9]{1,2}$/)
      str = "#{obj[:year]}-#{obj[:month]}-#{obj[:day]} #{obj[:hour]}:#{obj[:min]} JST"
    end
    begin
      return datetime = DateTime.parse(str)
    rescue ArgumentError
      return datetime = '不正な日付'
    end
  end

end
