require_relative '../../lib/collections/sizable_tree_collection'
require_relative '../../lib/algorithms/weighted_quick_union'
require 'minitest/spec/expect'
require 'minitest/pride'

describe WeightedQuickUnion do
  let(:collection) { SizableTreeCollection.new }
  let(:weighted_quick_union) { WeightedQuickUnion.new collection }

  describe '#union' do
    it 'does nothing if the entries passed in are already connected' do
      weighted_quick_union.union 0, 1
      weighted_quick_union.union 8, 1

      weighted_quick_union.union 0, 8

      expect(collection[0][:tree_size]).to_equal 3
    end

    it 'sets the root of the entry with the least connections to that of the most' do
      collection[1][:id] = 0
      collection[2][:id] = 0
      collection[0][:tree_size] = 2

      weighted_quick_union.union 9, 2

      expect(collection[9][:id]).to_equal 0
    end
  end
end
