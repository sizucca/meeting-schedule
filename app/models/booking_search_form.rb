# coding: utf-8
require "concerns/self_time_format"
include SelfTimeFormat

class BookingSearchForm < ActiveModelBase
  attr_accessor :title, :user_id, :facility_id, :date_year, :date_month, :date_day

  def result_bookings
    bookings = Booking.order('start_time DESC')
    if date.kind_of?(DateTime)
      bookings = bookings.where('start_time < ? and ? <= end_time', date + 1, date)
      bookings = bookings.where('title LIKE ?', "%#{escape_like(@title)}%") if @title.present?
      bookings = bookings.where('user_id = ?', @user_id) if @user_id.present?
      bookings = bookings.where('facility_id = ?', @facility_id) if @facility_id.present?
    else
      errors.add(:date_year, :invalid)
    end
    return bookings
  end

  #
  # 年月日を生成
  #
  def date_year  ; @date_year  ||= time_now(:year)  ; end
  def date_month ; @date_month ||= time_now(:month) ; end
  def date_day   ; @date_day   ||= time_now(:day)   ; end

  private
  #
  # 年月日をDateTime型に変換
  #
  def date
    datetime = obj_datetime(
      year:  @date_year,
      month: @date_month,
      day:   @date_day,
      hour:  '00',
      min:   '00'
    )
  end

end


