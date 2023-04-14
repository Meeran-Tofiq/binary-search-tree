class Node
    include Comparable

    attr_accessor :data, :left, :right
    def initialize
        @data = nil
        @left = nil
        @right = nil
    end

    def <(other)
        self.data < other.data
    end

    def >(other)
        self.data > other.data
    end

    def <=(other)
        self.data <= other.data
    end

    def >=(other)
        self.data >= other.data
    end
end

class Tree
    attr_reader :root
    def initialize(arr)
        @root = build_tree(arr)
    end
end