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
