class Game
    def play
        loop do
            puts "Press 1 to be the code BREAKER"
            puts "Press 2 to be the code MAKER"
            @input = gets.chomp
            if (@input.match(/^[1-2]$/))
                break
            end
        end
        codeBreaker() if (@input == '1')
        codeMaker() if (@input == '2')
    end

    def codeBreaker()
        player = HumanBreaker.new
        player.createCode()
    end

    def codeMaker()
        computer = ComputerBreaker.new
        computer.createCode()
    end
end