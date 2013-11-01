require_relative '../../lib/collections/collection'
require_relative '../../lib/algorithms/quick_union'
require 'minitest/spec/expect'
require 'minitest/pride'

describe QuickUnion do
  let(:collection) { Collection.new }
  let(:quick_union) { QuickUnion.new collection }

  describe '#union' do
    it 'sets the parent id of the first to the root of the second' do
      # #union(4, 3) -> @collection[4] = root(3)

      quick_union.union 0, 1
      quick_union.union 1, 2
      quick_union.union 3, 0

      expect(collection[3]).to_equal 2
    end
  end

  describe '#connection?' do
    before do
      quick_union.union 0, 1
      quick_union.union 1, 2
    end

    describe 'when there is a connection' do
      it 'returns true' do
        expect(quick_union.connection? 0, 2 ).to_equal true
      end
    end

    describe 'when there is no connection' do
      it 'returns false' do
        expect(quick_union.connection? 0, 3 ).to_equal false
      end
    end
  end
end
