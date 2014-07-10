class Game

  attr_reader :board, :death_list, :life_list
  
  def initialize(rowsize, colsize)
    board = Array.new(rowsize*colsize, {}).each_slice(rowsize).to_a
    @board = board.map.with_index do |row, i|
      row.map.with_index do |element, j|
        {x:i,y:j}
      end
    end
  end

  def populate(coordinate)
    x,y=coordinate
    @board[x][y]='X'
  end

  def kill(coordinate)
    x,y=coordinate
    @board[x][y]=''
  end

  def neighbours_of(coordinate)
    xrange = (coordinate[0]-1..coordinate[0]+1).to_a
    yrange = (coordinate[1]-1..coordinate[1]+1).to_a
    neighbour_cells=[]
    xrange.each do |x_coord|
      yrange.each do |y_coord|
        neighbour_cells<<[x_coord,y_coord]
      end
    end
    neighbour_cells.reject { |cell| cell==coordinate}
  end

  def generate_life_list
    @life_list = []

  end

  def generate_death_list 
    @death_list = []
    board = @board.flatten
    board.each_with_index do |element, i|
      if element=='X'
        row_no, col_no = i.divmod(@rowsize)
        neighbours=neighbours_of([row_no, col_no])
        
        live_cells=neighbours.select do |coord| 
        
          puts "#{@board[coord[0]][coord[1]]}"
          @board[coord[0]][coord[1]]=='X'

        end
        @death_list<< [row_no, col_no] if live_cells.count>3|| live_cells.count<2
      end
    end
  end

end