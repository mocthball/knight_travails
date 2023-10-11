#class to track movements of a knight
class Knight

  MOVES = [[1, 2], [-2, -1], [-1, 2], [2, -1],
          [1, -2], [-2, 1], [-1, -2], [2, 1]].freeze

  @@history = []

  def initialize(position, parent, count)
    @position = position
    @parent = parent
    @history = position
    @move_count = count
  end

  def position
    @position
  end

  def parent
    @parent
  end

  def children
    MOVES.map { |move| [@position[0] + move[0], @position[1] + move[1]] }
            .keep_if { |element| Knight.valid?(element) }
            .reject { |e| @@history.include?(e)}
            .map { |e|  Knight.new(e, self, @move_count + 1) }
  end

  def self.valid?(movement)
    return true if movement[0].between?(1,8) && movement[1].between?(1,8)
    return false
  end

  def inspect
    "{position: #{@position},move_count: #{@move_count}}\n"
  end


  def print_moves(start_pos)
    array = []
    node = self
    array << "You made it in #{@move_count} moves!!"
    until node.position == start_pos
      array.unshift(node.inspect)
      node = node.parent
    end
    puts array
  end
end

def knight_moves(start_pos, end_pos)
  queue = []
  current_node = Knight.new(start_pos, end_pos, 0)
  until current_node.position == end_pos
    current_node.children.each { |child| queue << child }
    current_node = queue.shift unless current_node.position == end_pos
  end
  current_node.print_moves(start_pos)
end

knight_moves([1, 1], [6, 8])