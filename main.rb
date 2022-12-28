module GameLogic
    attr_reader :n
    def compare(master, guess)
        @correctCount = @nearCount = 0
        masterTrack = [0,1,2,3]
        guessTrack = [0,1,2,3]
        for i in 0..3
            if (guess[i] == master[i])
                @correctCount += 1
                masterTrack.delete(i)
                guessTrack.delete(i)
            end
        end
        guessTrack.each do |i|
            masterTrack.each do |j|
                if (guess[i] == master[j])
                    @nearCount += 1
                    masterTrack.delete(j)
                    break
                end
            end
        end
    end

    def solved?(master, guess)
        master == guess
    end

    def continuePlaying()
        @@n = 1
        print "Do you want to continue playing [y/n]: "
        input = gets.chomp.downcase
        createCode() if (input == 'y')
    end

    @@n = 1
    def printAttempt()
        puts "Attempt \##{@@n}"
        @@n += 1
    end
end

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

class ComputerBreaker
    include GameLogic
    attr_reader :code, :guess, :guessesList, :correctCount, :nearCount
    def createCode()
        print "Enter a sequence: "
        @code = gets.chomp
        @code = @code.split("").map(&:to_i)
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

computer = ComputerBreaker.new
computer.createCode()