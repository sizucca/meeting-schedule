# coding: utf-8
module ScheduleHelper

  #
  # selectのoptions：年
  #
  def select_year_options(options = {})
    select_year_options = []

    time_now = Time.zone.now
    start_year = time_now.year.to_i
    end_year   = start_year + (options[:over_year] ||= 10).to_i

    (start_year).upto(end_year) do |year|
      select_year_options << ["#{year} #{options[:unit]}", year]
    end
    return select_year_options
  end

  #
  # selectのoptions：月
  #
  def select_month_options(options = {})
    select_month_options = []
    (1).upto(12) do |month|
      select_month_options << ["#{month} #{options[:unit]}", month]
    end
    return select_month_options
  end

  #
  # selectのoptions：日
  #
  def select_day_options(options = {})
    select_day_options = []
    (1).upto(31) do |day|
      select_day_options << ["#{day} #{options[:unit]}", day]
    end
    return select_day_options
  end

  #
  # selectのoptions：時
  #
  def select_hour_options(options = {})
    select_hour_options = []
    (0).upto(23) do |hour|
      select_hour_options << ["#{hour} #{options[:unit]}", hour]
    end
    return select_hour_options
  end

  #
  # selectのoptions：分
  #
  def select_min_options(options = {})
    select_min_options = []
    step = options[:step] ? options[:step].to_i : 1
    (0).step(59, step) do |min|
      min = "%02d" % min
      select_min_options << ["#{min} #{options[:unit]}", min]
    end
    return select_min_options
  end

  #
  # selectのoptions：登録者
  #
  def select_user_options(users = {})
    select_user_options = []

    if users.present? && users.size > 0
      users.each do |u|
        user_name  = ""
        user_name += u[:family_name]
        user_name += " #{u[:first_name]}"
        if(u[:family_kana].present? || u[:first_kana].present?)
          user_name += "（"
          user_name += "#{u[:family_kana].to_hiragana}"
          user_name += " #{u[:first_kana].to_hiragana}"
          user_name += "）"
        end
        select_user_options << [user_name, u.id]
      end
    end
    return select_user_options
  end

  #
  # selectのoptions：会議室
  #
  def select_facility_options(facilities = {})
    select_facility_options = []

    if facilities.present? && facilities.size > 0
      facilities.each do |f|
        facility_name = f[:name]
        if f[:sub_name].present?
          facility_name += "：#{f[:sub_name]}"
        end
        select_facility_options << [facility_name, f.id]
      end
    end
    return select_facility_options
  end

  #
  # 会議室名の成型
  #
  def facility_name(facility = {})
    facility_name = facility[:name]
    if facility[:sub_name].present?
      facility_name += "：#{facility[:sub_name]}"
    end
    return facility_name
  end

end
