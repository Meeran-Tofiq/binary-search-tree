class Node
    attr_reader :left, :right
    attr_writer :left
    def initialize
        @left = nil
        @right = nil
    end
end