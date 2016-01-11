# coding: utf-8
class User < ActiveRecord::Base
  has_many :booking

  attr_protected :id, :created_at, :updated_at

end
