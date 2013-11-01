require_relative '../../lib/algorithms/weighted_quick_union_with_path_compression'
require_relative '../../lib/collections/sizable_tree_collection'

require 'minitest/spec/expect'
require 'minitest/pride'

describe WeightedQuickUnionWithPathCompression do
  let(:collection) { SizableTreeCollection.new }
  let(:qu) { WeightedQuickUnionWithPathCompression.new collection }

  describe '#union' do
    it "sets each examined node in the tree's id to its root" do
      collection[1][:id] = 0
      collection[2][:id] = 1
      collection[3][:id] = 2
      collection[4][:id] = 3
      collection[0][:tree_size] = 5

      qu.union 4, 5

      (1..5).to_a.each do |n|
        expect(collection[n][:id]).to_equal 0
      end
    end
  end
end
