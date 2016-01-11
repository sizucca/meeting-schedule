# coding: utf-8
require "concerns/user_status"
require "concerns/facility_status"
include UserStatus
include FacilityStatus

class ScheduleController < ApplicationController

  def index
    @users        = get_users(UserStatus.all)
    @facilities   = get_facilities(FacilityStatus.all)
    @all_bookings = get_bookings

    if params[:booking_search_form]
      @search_form     = BookingSearchForm.new(params[:booking_search_form])
      @result_bookings = @search_form.result_bookings
    else
      @search_form     = BookingSearchForm.new
      @result_bookings = @all_bookings
    end
  end

  def new
    @users      = get_users(UserStatus::ACTIVE)
    @facilities = get_facilities(FacilityStatus::ACTIVE)

    @booking = Booking.new
  end

  def create
    @users      = get_users(UserStatus::ACTIVE)
    @facilities = get_facilities(FacilityStatus::ACTIVE)

    @booking = Booking.new(params[:booking])
    @booking[:start_time] = @booking.start_time
    @booking[:end_time]   = @booking.end_time

    if @booking.save
      redirect_to :root, notice: "予約の登録が完了しました。"
    else
      render "new"
    end
  end

  def destroy
    begin
      @booking = set_booking
      @booking.destroy
      render json: {booking: @booking, notice: "予約を削除しました。"}
      # redirect_to :root, notice: "予約を削除しました。"
    rescue ActiveRecord::RecordNotFound => e
      render json: {alert: "指定の予約は見つかりませんでした。"}
      # redirect_to :root, alert: "指定の予約は見つかりませんでした。"
    end
  end

  private

  def get_users(status)
    users = User.order("family_kana")
    if status.present?
      users = users.where('status = ?', status)
    end
    return users
  end

  def get_facilities(status)
    facilities = Facility.order("id")
    if status.present?
      facilities = facilities.where('status = ?', status)
    end
    return facilities
  end

  def get_bookings
    bookings = Booking.order("start_time DESC")
  end

  def set_booking
    booking = Booking.find(params[:id])
  end

end
