module GameLogic
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
        showClues(correctCount, nearCount)
    end
end
class HumanBreaker
    include GameLogic
    attr_reader :randomNumbers, :correctCount, :nearCount
    def createCode()
        @randomNumbers = [rand(1..6), rand(1..6), rand(1..6), rand(1..6)]
        playerGuess()
    end
    
    def playerGuess()
        print "Enter a sequence: "
        answer = gets.chomp
        answer = answer.split("").map(&:to_i)
        compare(randomNumbers, answer)
    end
    
    def showClues(correctCount, nearCount)
        puts "Correct answer[s]: #{correctCount}"
        puts "Almost correct answer[s]: #{nearCount}"
        checkGuess(correctCount)
    end

    def checkGuess(correctCount)
        unless (correctCount == 4)
            correctCount = 0
            nearCount = 0
            playerGuess()
        else
            continuePlaying()
        end
        
    end

    def continuePlaying()
        print "Do you want to continue playing [y/n]: "
        input = gets.chomp.downcase
        createCode() if (input == 'y')
    end
end

class ComputerBreaker
    include GameLogic
    
end

player = HumanBreaker.new
player.createCode()