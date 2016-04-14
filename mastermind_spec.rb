require "./mastermind"

describe "Mastermind" do
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

  end

  describe "player" do
    it 'takes and gives a name' do
      player = Game::Player.new("matt", "guesser")
      expect(player.name).to eq("matt")      
    end

    it "takes and returns a role" do
      player = Game::Player.new("matt", "guesser")
      expect(player.role).to eq("guesser") 
    end
  end

end

