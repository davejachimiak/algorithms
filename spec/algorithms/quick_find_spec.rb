require_relative '../../lib/algorithms/quick_find'
require_relative '../../lib/collections/collection'
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
