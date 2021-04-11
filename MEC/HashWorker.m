
export HashWorker
% @param limitation, how many microseconds you want to delay for each iteration.
% it is multiplied by 1000, so input of 1000 will make it sleep 1 second (1 000 000 microseconds) each iteration
const HashWorker <- class HashWorker[limitation: Integer]
  
  attached const workload <- "This is the workload that is hashed!"

  attached const mon <- InnerMonitor.create

  attached const InnerMonitor <- monitor class InnerMonitor
    field waiting : Boolean <- true

    field timeTaken : Time <- nil
  end InnerMonitor


  attached const Worker <- class Worker[iterations: Integer]
    initially
      assert iterations > 0 % cannot iterate negative amount of times
    end initially

    process
      % (locate self)$stdout.putstring["Worker is starting, iterations:" ||  iterations.asString|| "\n"] %for debugging
      var garbage : String <- workload % is just to keep a value, the value is never used

      const startTime <- (locate self)$timeOfDay

      % Work loop. Hashes workload 10000 times, for iterations amount of times
      for i : Integer <- 0 while i<iterations by i <- i + 1
        for y : Integer <- 0 while y<10000 by y <- y + 1
          garbage <- self.djb2Hash[garbage].asString
        end for
        (locate self)$stdout.putstring["On iteration " ||i.asString|| "\n"] %for debugging
        (locate self).delay[Time.create[0,limitation*1000]] % Sleep to simulate worse hardware
      end for

      const endTime <- (locate self)$timeOfDay

      mon.setTimeTaken[endTime - startTime] % "return value" from process

      mon.setWaiting[false]
      % assert false
    end process

    % converted from C version found here: http://www.cse.yorku.ca/~oz/hash.html
    function djb2Hash[str: String] -> [res: Integer]
      res <- 5381
      for i : Integer <- 0 while i < str.length by i <- i + 1
        res <- res * 33 * str[i].ord % .ord gets the ordinal number
      end for
    end djb2Hash
  end Worker

  initially
    assert limitation >= 0 % limitation must be 0 or higher
    (locate self)$stdout.putstring["I will sleep for " || (limitation*1000).asString || " microseconds\n"]
  end initially

  export op setLimitation[lim: Integer]
    limitation <- lim
  end setLimitation


  export op doWork[iterations: Integer]
    const w <- Worker.create[iterations]
  end doWork

  export op collectTimeUsed -> [res: Time]
    loop
      exit when !mon.getWaiting
      (locate self).delay[Time.create[0,100000]] % To not drain resources
      %(locate self)$stdout.putstring["yhtw: " || instanceOfB.getyouHaveToWait.asString || "\n"]stdout.flush
    end loop
    res <- mon.getTimeTaken
  end collectTimeUsed
end HashWorker
