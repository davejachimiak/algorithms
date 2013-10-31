require './collection'
require 'forwardable'

# Data Structure
# ==============
# Each index entry contains an id that may be shared with 0 to n
# other index entries. Entries with the same id are connected.
class QuickFind
  def initialize collection
    @collection = collection
  end

  def union n1, n2
    n1_id = @collection[n1]
    n2_id = @collection[n2]

    # the union is slow here because the time it takes to cycle through each
    # index grows quadradically with the size of the collection
    @collection.each_index do |index|
      @collection[index] = n2_id if @collection[index] == n1_id
    end
  end

  def connection? n1, n2
    @collection[n1] == @collection[n2]
  end
end

require 'minitest/spec/expect'
require 'minitest/pride'

describe QuickFind do
  let(:quick_find) { QuickFind.new collection }
  let(:collection) { Collection.new }

  describe '#union' do
    let(:n0) { 0 }
    let(:n1) { 1 }
    let(:n2) { 2 }
    let(:n3) { 3 }

    it 'associates the index pair with id of second passed in' do
      quick_find.union n0, n1

      expect(collection[n0]).to_equal collection[n1]
    end

    it 'associates the all other indexes with id of first passed in with second passed in' do
      quick_find.union n0, n1
      quick_find.union n1, n2
      quick_find.union n2, n3

      expect(collection[n0]).to_equal collection[n3]
    end
  end

  describe '#connection?' do
    let(:n0) { 0 }
    let(:n1) { 1 }

    describe 'there is a connection between the two indexes' do
      before do
        quick_find.union n0, n1
      end

      it 'returns true' do
        expect(quick_find.connection? n0, n1 ).to_equal true
      end
    end

    describe 'there is no connection between the two indexes' do
      it 'returns false' do
        expect(quick_find.connection? n0, n1 ).to_equal false
      end
    end
  end
end
