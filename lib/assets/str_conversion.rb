# coding: utf-8
module StrConversion

  def to_katakana
    self.tr('ぁ-ん', 'ァ-ン')
  end

  def to_hiragana
    self.tr('ァ-ン', 'ぁ-ん')
  end

end
