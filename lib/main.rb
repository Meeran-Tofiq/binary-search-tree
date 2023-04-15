class Node
    include Comparable

    attr_accessor :data, :left, :right
    def initialize(data=nil)
        @data = data
        @left = nil
        @right = nil
    end

    def has_children?
        !(left.nil? && right.nil?)
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

    def ==(other)
        return false if other == nil
        self.data == other.data
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

    def insert(val)
        new_node = Node.new(val)
        temp = root

        return if new_node==root

        while true
            if new_node > temp
                if temp.right.nil?
                    temp.right = new_node
                    break
                else
                    temp = temp.right
                end
            elsif new_node < temp
                if temp.left.nil?
                    temp.left = new_node
                    break
                else
                    temp = temp.left
                end
            else
                return
            end
        end
    end

    def delete(val)
        temp = root
        parent = nil

        until temp.data == val
            parent = temp
            temp = (temp.data > val ? temp.left : temp.right)
            return if temp == nil
        end

        if temp.has_children?
        else
            if parent.left == temp
                parent.left = nil
            else
                parent.right = nil
            end
        end
    end

    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end
end

array = [0, 9, 8, 3, 4, 3, 2, 1, 5]

tree = Tree.new(array)

tree.delete 4

tree.pretty_print