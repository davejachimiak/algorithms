require './collection'

# Data Structure
# ==============
# Each index entry's id is a reference to its parent index.
# Entries with the same root id are connected.
class QuickUnion < Struct.new(:collection)
  # The tree here can get too tall, which means that the find operation
  # (QuickUnion#root) can get too expensive. How expensive? The operation
  # grows linearly with the size of the collection.
  def union n1, n2
    collection[n1] = root(n2)
  end

  def connection? n1, n2
    root(n1) == root(n2)
  end

  private

  def root n
    until collection[n] == n
      n = collection[n]
    end

    n
  end
end

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
