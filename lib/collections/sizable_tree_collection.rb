require_relative './collection'

class SizableTreeCollection < Collection
  def initialize *args
    @collection = super.map { |n| { id: n, tree_size: 1 } }
  end
end
