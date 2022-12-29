class ComputerBreaker
    include GameLogic
    attr_reader :code, :guess, :guessesList, :correctCount, :nearCount
    def createCode()
        @code = playerInput().split("").map(&:to_i)
        createGuessesList()
        computerGuess()
    end

    def createGuessesList()
        @guessesList = []
        (1..6).each do |a|
            (1..6).each do |b|
                (1..6).each do |c|
                    (1..6).each do |d|
                        @guessesList << [a, b, c, d]
                    end
                end
            end
        end
        @guessesList = @guessesList.shuffle()
    end
    
    def computerGuess()
        printAttempt()
        p @guess = guessesList[0]
        if solved?(code, @guess)
            continuePlaying()
        else
            comparePreviousGuess(@guess)
            computerGuess()
        end
    end

    def comparePreviousGuess(guess)
        compare(code, guess)
        puts "Correct answer[s]: #{correctCount}"
        puts "Almost correct answer[s]: #{nearCount}"
        initialCorrectCount = correctCount
        initialNearCount = nearCount
        guessesList.each do |number|
            compare(guess, number)
            guessesList.delete(number) if (correctCount != initialCorrectCount || nearCount != initialNearCount)
        end
    end
end