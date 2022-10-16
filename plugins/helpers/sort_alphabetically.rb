require "ffi-icu"

# Fix "і", "ї", "є" being sorted incorrectly with default `.sort`
module Helpers::SortAlphabetically
  def self.collator
    @instance ||= ICU::Collation::Collator.new("uk")
  end
end

Enumerable.class_eval do
  def sort_alphabetically_by(&blk)
    sort { |a, b| ::Helpers::SortAlphabetically.collator.compare(blk.call(a), blk.call(b)) }
  end
end
