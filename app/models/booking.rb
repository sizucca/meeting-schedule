# coding: utf-8
require "concerns/self_time_format"
include SelfTimeFormat

class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :facility

  attr_protected :id, :created_at, :updated_at

  attr_accessor :start_year, :start_month, :start_day, :start_hour, :start_min,
                :end_year,   :end_month,   :end_day,   :end_hour,   :end_min

  validates :start_time, :end_time, presence: true
  validates :title,       length: {maximum: 50}
  validates :user_id,     presence: true
  validates :facility_id, presence: true
  validates :memo,        length: {maximum: 100}

  validate :check_datetime, :check_user_id, :check_facility_id

  #
  # 日時を生成
  #
  def start_year  ; @start_year  ||= time_now(:year)  ; end
  def start_month ; @start_month ||= time_now(:month) ; end
  def start_day   ; @start_day   ||= time_now(:day)   ; end
  def start_hour  ; @start_hour  ||= "10" ; end
  def start_min   ; @start_min   ||= "00" ; end

  def end_year  ; @end_year  ||= time_now(:year)  ; end
  def end_month ; @end_month ||= time_now(:month) ; end
  def end_day   ; @end_day   ||= time_now(:day)   ; end
  def end_hour  ; @end_hour  ||= "11" ; end
  def end_min   ; @end_min   ||= "00" ; end

  #
  # 年月日をDateTime型に変換して start_timeに設定
  #
  def start_time
    datetime = obj_datetime(
      year:  @start_year,
      month: @start_month,
      day:   @start_day,
      hour:  @start_hour,
      min:   @start_min
    )
  end

  #
  # 年月日をDateTime型に変換して end_timeに設定
  #
  def end_time
    datetime = obj_datetime(
      year:  @end_year,
      month: @end_month,
      day:   @end_day,
      hour:  @end_hour,
      min:   @end_min
    )
  end

  private
  #
  # DateTimeのバリデーション
  #
  def check_datetime

    # 日付型の場合は内容に矛盾が無いかチェック
    if start_time.kind_of?(DateTime) && end_time.kind_of?(DateTime)

      if start_time >= end_time
        errors.add(:end_time, "は開始日時以降に設定してください。")
      end

      if start_time < (time_now - 1)
        errors.add(:start_time, "は本日以降に設定してください。")
      end

      if facility_id.present?
        bookings = Booking.where('facility_id = ?', facility_id)
        unless bookings.empty?
          booking_flag = false
          bookings.each do |booking|
            if booking[:start_time] <= start_time
              if booking[:end_time] > start_time
                booking_flag = true
              end
            else
              if booking[:start_time] < end_time
                booking_flag = true
              end
            end
          end
          if booking_flag
            errors.add(:facility_id, "の指定の日時は、別の会議が予約されています。")
          end
        end
      end

    # 日付型じゃ無い場合はエラー
    else
      unless start_time.kind_of?(DateTime)
        errors.add(:start_time, :invalid)
      end
      unless end_time.kind_of?(DateTime)
        errors.add(:end_time, :invalid)
      end
    end
  end

  #
  # UserIDのバリデーション
  #
  def check_user_id
    user = User.where('status = ?', UserStatus::ACTIVE).where('id = ?', user_id) if user_id.present?
    if user && user.empty?
      errors.add(:user_id, :invalid)
    end
  end

  #
  # FacilityIDのバリデーション
  #
  def check_facility_id
    facility = Facility.where('status = ?', FacilityStatus::ACTIVE).where('id = ?', facility_id) if facility_id.present?
    if facility && facility.empty?
      errors.add(:facility_id, :invalid)
    end
  end

end
