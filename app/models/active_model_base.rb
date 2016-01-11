# coding: utf-8
class ActiveModelBase
  include ActiveModel::Validations
  include ActiveModel::Conversion

  def persisted? ; false ; end

  def initialize(attributes = {})
    if attributes && attributes.size > 0
      attributes.each do |name, value|
        strip_with_space_only!(value) if value.kind_of?(String)
        send("#{name}=", value) rescue nil
      end
    end
  end

  #
  # 以下のエスケープ処理
  # `\` -> `\\`
  # `%` -> `\%`
  # `_` -> `\_`
  #
  def escape_like(str)
    str.gsub(/[\\%_]/) {|m| "\\#{m}"}
  end

  #
  # 文字列が全角半角空白だけの場合削除
  #
  def strip_with_space_only!(str)
    tmp = str.gsub(/[　\s]/, '')
    if tmp == ''
      str = str.gsub!(/[　\s]/, '')
    end
    return str
  end

end
