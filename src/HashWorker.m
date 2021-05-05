
export HashWorker

const HashWorker <- class HashWorker[limitation: Integer]
  

  attached const mon <- InnerMonitor.create

  attached const InnerMonitor <- monitor class InnerMonitor
    field waiting : Boolean <- true

    field timeTaken : Time <- nil
  end InnerMonitor


  attached const Worker <- class Worker[iterations: Integer, work: LocalWorkload, frequencyOfGet: Integer]
    initially
      assert iterations > 0 % cannot iterate negative amount of times
    end initially

    process
      % (locate self)$stdout.putstring["Worker is starting, iterations:" ||  iterations.asString|| "\n"] %for debugging
      var garbage : String <- work$work % is just to keep a value, the value is never used
      const location <- (locate self)
      const startTime <- location$timeOfDay

      var tempIterations : Integer <- 0

      var tempTime : Time <- location$timeOfDay %t1
      var timeFrame : Time <- nil


      var totalLatencyTime : Time <- Time.create[0,0]
      var lastLatencyTime : Time <- Time.create[0,0]

      var totalComputationTime : Time <- Time.create[0,0]
      var lastComputationTime : Time <- Time.create[0,0]

      const oneSecond <- Time.create[1,0]

      % Work loop. Hashes workload 10000 times, for iterations amount of times
      for i : Integer <- 0 while i<iterations by i <- i + 1


        lastLatencyTime <- location$timeOfDay
        % only get every frequencyOfGet from local
        if (i # frequencyOfGet) = 0 then
          garbage <- work$work
        end if
        %totalLatencyTime += time used for getting from local
        totalLatencyTime <- totalLatencyTime + (location$timeOfDay - lastLatencyTime)



        lastComputationTime <- location$timeOfDay %timing of computation, includes waiting for fps
        %if tempIterations is equal to or bigger than limit
        %  AND it has not yet passed 1 second since last limitation amount of iterations
          %tf  =    t2    -  t1
        timeFrame <- location$timeOfDay-tempTime
        if tempIterations >= limitation and timeFrame < oneSecond then
          % delay until 1 second from tempTime
          location.delay[oneSecond-timeFrame]
          tempIterations <- 0
          tempTime <- location$timeOfDay
        elseif timeFrame >= oneSecond then
          tempIterations <- 0
          tempTime <- location$timeOfDay
        end if


        for y : Integer <- 0 while y<500 by y <- y + 1
          garbage <- self.djb2Hash[garbage].asString
        end for
        %totalComputationTime += time used calulating
        totalComputationTime <- totalComputationTime + (location$timeOfDay - lastComputationTime)


        location$stdout.putstring["On iteration " ||i.asString|| "\n"] %for debugging
        tempIterations <- tempIterations + 1
        
      end for


      const endTime <- location$timeOfDay

      mon.setTimeTaken[endTime - startTime] % "return value" from process

      (locate self)$stdout.putstring["Total time used on computation: " || totalComputationTime.asString || "\n"]
      (locate self)$stdout.putstring["Total time used on waiting for get: " || totalLatencyTime.asString || "\n"]


      mon.setWaiting[false]
      (locate self)$stdout.putstring["Process is done\n"]
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
    refix limitation at (locate self) 
    % refix workload at (locate self)
    %(locate self)$stdout.putstring["I will sleep for " || (limitation*1000).asString || " microseconds\n"]
  end initially

  export op setLimitation[lim: Integer]
    limitation <- lim
  end setLimitation

  % start the Worker
  export op doWork[iterations: Integer, work: LocalWorkload, frequencyOfGet: Integer]
    (locate self)$stdout.putstring["Starting to do " ||iterations.asString||" iterations\n"]
    % refix work at (locate self)
    const w <- Worker.create[iterations, work, frequencyOfGet]
  end doWork



  % Collect time used after Worker is done
  export op collectTimeUsed -> [res: Time]
    loop
      exit when !mon.getWaiting
      (locate self).delay[Time.create[0,100000]] % To not drain resources
      %(locate self)$stdout.putstring["yhtw: " || instanceOfB.getyouHaveToWait.asString || "\n"]stdout.flush
    end loop
    res <- mon.getTimeTaken
  end collectTimeUsed
end HashWorker

export LocalWorkload
const LocalWorkload <- class LocalWorkload
  attached field work : String <- "Some random workload"
end LocalWorkload
