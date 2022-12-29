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
    end

    def solved?(master, guess)
        master == guess
    end

    def continuePlaying()
        @@n = 1
        print "Do you want to continue playing [y/n]: "
        input = gets.chomp.downcase
        if (input == 'y')
            Game.new.play
        elsif (input == 'n')
            puts "Game over!"
            return
        else
            continuePlaying()
        end
    end

    @@n = 1
    def printAttempt()
        puts "Attempt \##{@@n}"
        @@n += 1
    end
end