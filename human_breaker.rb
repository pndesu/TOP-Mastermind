class HumanBreaker
    include GameLogic
    attr_reader :randomNumbers, :correctCount, :nearCount, :answer
    def createCode()
        @randomNumbers = [rand(1..6), rand(1..6), rand(1..6), rand(1..6)]
        playerGuess()
    end
    
    def playerGuess()
        printAttempt()
        print "Enter a sequence: "
        @answer = gets.chomp
        @answer = @answer.split("").map(&:to_i)
        compare(randomNumbers, @answer)
        showClues(correctCount, nearCount)
    end
    
    def showClues(correctCount, nearCount)
        puts "Correct answer[s]: #{correctCount}"
        puts "Almost correct answer[s]: #{nearCount}"
        if solved?(randomNumbers, answer)
            continuePlaying()
        else
            playerGuess()
        end
    end

end