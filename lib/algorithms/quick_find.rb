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
