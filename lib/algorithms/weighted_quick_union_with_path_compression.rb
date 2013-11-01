require_relative './weighted_quick_union'

class WeightedQuickUnionWithPathCompression < WeightedQuickUnion
  private

  # Flattening the tree while finding the root leads to a virtually
  # linear algorithm. In theory it's not linear, but in practice it
  # is. (It's proven that, theoretically, there is no such linear-time
  # algorithm.)
  #
  # Given an empty data structure, any sequence of M union-find operations
  # on N objects makes at most N + M(lg*N) array accesses.
  #
  # lg*N is called the Iterative Log Function andrefers to the number of
  # times it would take for lgN = 1.
  def root n
    n_ = n
    examined_nodes = []

    until collection[n_][:id] == n_
      examined_nodes.push n_
      n_ = collection[n_][:id]
    end

    set_node_ids_to examined_nodes, n_

    n_
  end

  def set_node_ids_to nodes, n
    nodes.each { |node| collection[node][:id] = n }
  end
end
