class Graph
  def initialize
    @edges = {}
  end

  def add_edge(from, to, weight)
    @edges[from] ||= []
    @edges[from] << [to, weight]
    @edges[to] ||= []
  end

  def shortest_path(start, target)
    distances = Hash.new(Float::INFINITY)
    distances[start] = 0
    previous_nodes = {}
    queue = [[start, 0]] # Використання масиву як черги

    until queue.empty?
      current_node, current_distance = queue.min_by { |_, dist| dist }
      queue.delete([current_node, current_distance])

      break if current_node == target

      if @edges[current_node]
        @edges[current_node].each do |neighbor, weight|
          tentative_distance = distances[current_node] + weight
          if tentative_distance < distances[neighbor]
            distances[neighbor] = tentative_distance
            previous_nodes[neighbor] = current_node
            queue << [neighbor, tentative_distance]
          end
        end
      end
    end

    path = []
    current_node = target
    while current_node
      path.unshift(current_node)
      current_node = previous_nodes[current_node]
    end

    path.first == start ? path : nil
  end
end

# Приклад використання
graph = Graph.new
graph.add_edge('A', 'B', 1)
graph.add_edge('B', 'C', 2)
graph.add_edge('A', 'C', 4)
graph.add_edge('C', 'D', 1)

puts "Шлях: #{graph.shortest_path('A', 'D')}" # ["A", "B", "C", "D"]
