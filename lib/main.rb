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