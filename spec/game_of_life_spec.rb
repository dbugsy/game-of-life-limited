require 'game_of_life'

describe Game do
  let(:game){Game.new(100,100)}
  
  it 'can be initialized with an array with empty strings' do
    expect(game.board.flatten[0]).to eq ''
    expect(game.board.flatten.count).to eq 10000 
  end

  it 'can create a living cell on the array' do
    game.populate([1,1])
    expect(game.board.flatten.include? 'X').to be_true
  end

  it 'can kill a living cell on the array' do
    game.populate([1,1])
    game.kill([1,1])
    expect(game.board.flatten.include? 'X').to be_false
  end

  it 'can return a cells neighbours' do
    expect(game.neighbours_of([1,1])).to eq([[0,0], [0,1],[0,2], [1,0] ,[1,2] ,[2,0], [2,1], [2,2]])
  end

  it 'board wraps around east/west and north/south' do
    expect(game.neighbours_of([0,0])).to eq([[-1,-1],[-1,0],[-1,1],[0,-1],[0,1],[1,-1],[1,0],[1,1]])
  end

  it 'should not have any entries in the death list' do 
    game.generate_death_list
    expect(game.death_list).not_to be nil
    expect(game.death_list.count).to be 0
  end
  
  it 'should generate the list of all the current living cells' do
   
    game.populate([1,1])
    game.populate([0,1])
    game.populate([1,2])
    game.populate([1,0])
    game.populate([2,1])
     game.generate_life_list
    expect(game.life_list.count).to eq 5
  end

  xit 'adds a crowded cell to the death list' do
    game.populate([1,1])
    game.populate([0,1])
    game.populate([1,2])
    game.populate([1,0])
    game.populate([2,1])
    game.generate_death_list
    expect(game.death_list.include?([1,1])).to be_true
    expect(game.death_list.include?([0,1])).not_to be_true
  end

end