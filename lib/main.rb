require 'pry-byebug'

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
        self.data < (other.is_a?(Node) ? other.data : other)
    end

    def >(other)
        self.data > (other.is_a?(Node) ? other.data : other)
    end

    def <=(other)
        self.data <= (other.is_a?(Node) ? other.data : other)
    end

    def >=(other)
        self.data >= (other.is_a?(Node) ? other.data : other)
    end

    def ==(other)
        return false if other == nil
        self.data == (other.is_a?(Node) ? other.data : other)
    end

    def to_s
        str = "\nNode: \n\tdata = #{data}"
        str.concat("\tleft = #{left.data}") unless left.nil?
        str.concat("\tright = #{right.data}") unless right.nil?
        str
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

        until temp == val
            parent = temp
            temp = (temp > val ? temp.left : temp.right)
            return if temp == nil
        end

        if temp.has_children?
            replace_with_next_biggest(temp)
        else
            if parent.left == temp
                parent.left = nil
            else
                parent.right = nil
            end
        end
    end

    def find(val, node = root)
        return nil if node.nil?

        if node == val
            return node
        elsif node < val
            return find(val, node.right)
        else
            return find(val node.left)
        end
    end

    def replace_with_next_biggest(node)
        next_biggest = node.right

        until next_biggest.left.nil?
            next_biggest = next_biggest.left
            puts next_biggest.data
        end

        data = next_biggest.data
        delete(next_biggest.data)
        node.data = data
    end

    def level_order
        arr = []

        if block_given?
            while true
                current_node = arr.shift
                yield current_node
                arr << current_node.left unless current_node.left.nil?
                arr << current_node.right unless current_node.right.nil?

                if arr.empty?
                    break
                end
            end
        else
            arr << root
            data = []
            while true
                current_node = arr.shift
                data << current_node.data
                arr << current_node.left unless current_node.left.nil?
                arr << current_node.right unless current_node.right.nil?

                if arr.empty?
                    return data
                end
            end
        end
    end 

    def preorder(node = root, arr = [])
        arr << node.data
        preorder(node.left, arr) unless node.left.nil?
        preorder(node.right, arr) unless node.right.nil?
        
        if block_given?
            arr.each do |data|
                yield data
            end
        else
            arr
        end
    end

    def inorder(node = root, arr = [])
        inorder(node.left, arr) unless node.left.nil?
        arr << node.data
        inorder(node.right, arr) unless node.right.nil?
        
        if block_given?
            arr.each do |data|
                yield data
            end
        else
            arr
        end
    end

    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end
end

array = [0, 9, 8, 3, 4, 3, 2, 1, 5, 20, 14, 13, 6, 19]

tree = Tree.new(array)

tree.pretty_print
tree.delete 6
puts "The node of the value wanted is - #{tree.find(19)}"
tree.pretty_print

puts "\n\n\n"
p tree.level_order
arr = []
tree.inorder { |data| arr << data }
p tree.inorder
p arr