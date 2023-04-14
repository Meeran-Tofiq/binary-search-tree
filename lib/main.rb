class Node
    include Comparable

    attr_accessor :data, :left, :right
    def initialize(data)
        @data = data
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
        @dataset = arr.sort.uniq
        @root = build_tree(@dataset)
    end

    def build_tree(arr)
        return nil if arr.empty?

        mid = (arr.size - 1)/2
        
        current_root = Node.new(arr[mid])
        current_root.left = build_tree(arr[0...mid])
        current_root.right = build_tree(arr[(mid+1)..-1])

        current_root
    end

    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end
end

array = [0, 9, 8, 3, 4, 3, 2, 1, 5]

tree = Tree.new(array)

puts array.sort.uniq

tree.pretty_print