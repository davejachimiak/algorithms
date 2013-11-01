class WeightedQuickUnion < Struct.new(:collection)
  # A scalable union operation. It sets the root id of smaller tree to that
  # root id of the larger tree. It then increments the tree size of the
  # larger tree by that of the smaller tree. It is a no-op if the indeces
  # passed in are already connected.
  #
  # Because the depth of any node x is at most lg N, this takes lg N time
  # which includes the cost of finding the roots.
  def union n1, n2
    n1_root, n2_root = [root(n1), root(n2)]

    return if n1_root == n2_root

    small_tree_root, large_tree_root = roots_by_tree_size(n1_root, n2_root)

    collection[small_tree_root][:id] = large_tree_root
    collection[large_tree_root][:tree_size] += collection[small_tree_root][:tree_size]
  end

  # takes time proportional to depth of n1 and n2 (lg N - cost of finding roots)
  def connection? n1, n2
    root(n1) == root(n2)
  end

  private

  def root n
    until collection[n][:id] == n
      n = collection[n][:id]
    end

    n
  end

  def roots_by_tree_size n1, n2
    if collection[n1][:tree_size] < collection[n2][:tree_size]
      [n1, n2]
    else
      [n2, n1]
    end
  end
end
