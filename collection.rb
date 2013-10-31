require 'forwardable'

class Collection
  extend Forwardable

  def_delegators :@collection, :[], :[]=, :each_index

  def initialize max_range=9
    @collection = (0..max_range).to_a
  end
end
