require "./mastermind.rb"

describe "Mastermind" do

  describe "game" do
    it "checks when something wins" do
      game = Game.new
      expect(game.check_win?({:one => "black", :two => "black", :three => "black", :four => "black"})).to be true
    end
  end

  describe "code" do
    it 'takes a combination and keeps the colors' do
      code = Game::Code.new("blue", "green", "green", "red")

      expect(code.code[:one]).to eq("blue")
    end

    it "Should take two combinations and return correct color and places" do
      code1 = code = Game::Code.new("blue", "green", "green", "red")
      code2 = code = Game::Code.new("blue", "green", "green", "black")

      expect(code1.compare(code2)).to eq({:one => "black", :two => "black", 
                                          :three => "black"})
    end

    it "takes two combinations and indicates when the colors are the same but not in the correct spot" do
      code1 = code = Game::Code.new("blue", "green", "green", "red")
      code2 = code = Game::Code.new("green", "blue", "green", "black")

      expect(code1.compare(code2)).to eq({:one => "white", :two => "white", 
                                          :three => "black"})
    end

    it "when indicating white, it only gives as many whites as the guessed color in the master code" do
      code1 = code = Game::Code.new("blue", "green", "green", "red")
      code2 = code = Game::Code.new("green", "green", "green", "black")

      expect(code1.compare(code2)).to eq({:two => "black", 
                                          :three => "black"})
    end

  end

  describe "player" do
    it 'takes and gives a name' do
      player = Game::Player.new("matt")
      expect(player.name).to eq("matt")      
    end    
  end



end

