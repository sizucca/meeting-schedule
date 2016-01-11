# coding: utf-8
require "uri"
include StrConversion

module ApplicationHelper

  #
  # 改行コードをbrに変換
  #
   def hbr(str)
    h(str).gsub(/(\r\n?)|(\n)/, "<br>").html_safe
  end

  #
  # 文字列の中のURLをリンクに変換
  #
  def url_to_link(str)

    URI.extract(str, ['http']).uniq.each do |url|
      sub_str = link_to(url, url, target: "_blank")
      str.gsub!(url, sub_str)
    end
    return str
  end

end
