const A <- class A[name: String]

  attached const instanceOfB <- B.create

  attached const B <- monitor class B
    const c : Condition <- Condition.create

    var youHaveToWait : Boolean <- true
    field timeTaken : Time <- nil

    export op waitSome
      wait c
    end waitSome

    export op continueSome
      signal c
    end continueSome

    export op getyouHaveToWait -> [res : Boolean]
      res <- youHaveToWait
    end getyouHaveToWait

    export op setyouHaveToWait[temp : Boolean]
      youHaveToWait <- temp
    end setyouHaveToWait
  end B


  attached const Worker <- class Worker
    process
      const startTime <- (locate self)$timeOfDay
      for i : Integer <- 0 while i<3 by i <- i + 1

        (locate self)$stdout.putstring["this happens!" || name || "\n"] stdout.flush
        (locate self).delay[Time.create[0,500000]] % 
      end for
      const endTime <- (locate self)$timeOfDay
      instanceOfB.setTimeTaken[endTime - startTime]
      (locate self)$stdout.putstring["This happensssss "|| instanceOfB.getTimeTaken.asString||"\n"] stdout.flush
      %instanceOfB.continueSome
      instanceOfB.setyouHaveToWait[false]
      % assert false
    end process
  end Worker
  



  export op doWork
    const werk <- Worker.create
    (locate self)$stdout.putstring["Do work done: " || name || "\n"]stdout.flush
  end doWork

  export op collectResult -> [res: Time]
    % wait until process is done
    (locate self)$stdout.putstring[name || " starts waiting\n"]stdout.flush
    assert false
    %instanceOfB.waitSome
    loop
      exit when !instanceOfB.getyouHaveToWait
      %(locate self).delay[Time.create[0,500000]] % 
      %(locate self)$stdout.putstring["yhtw: " || instanceOfB.getyouHaveToWait.asString || "\n"]stdout.flush
    end loop
    %assert false
    (locate self)$stdout.putstring[name || " stops waiting, and returning " || instanceOfB.gettimeTaken.asString ||"\n"]stdout.flush
    res <- instanceOfB.getTimeTaken
  end collectResult

end A


const main <- object main
  initially

    const home <- locate self
    var there : Node
    var all : NodeList


    const first <- A.create["first"]
    const second <- A.create["second"]

    all <- home.getActiveNodes  
    (locate self)$stdout.putstring["Number of active nodes: " || (all.upperbound+1).asString ||"\n"]
    for i : Integer <- 1 while i <= all.upperbound by i <- i + 1
      there <- all[i]$theNode % get node for printing and refixing
      %(locate self)$stdout.putstring["This haaaaapens\n"]
      refix second at there
    end for

    first.doWork
    second.doWork

    const resultFirst <- first.collectResult
    const resultSecond <- second.collectResult
    (locate self)$stdout.putstring["Both are done!\n"]
    (locate self)$stdout.putstring["Result from first: "|| resultFirst.asString ||"\n"]stdout.flush
    (locate self)$stdout.putstring["Result from second: "|| resultSecond.asString ||"\n"]stdout.flush
  end initially

end main



% for 2 noder
% lag 2 objekter
% sett så de 2 på hver sin node
% start prosesser på hver av de, som venter på at vi skal motta en jobb
% når man mottar en jobb så gjør dem

% lag to klasser
% klassene starter hver sin prosess
% prossessen lager et objekt som venter på å bli kontaktet
% lag en funksjon som kaller på det objektet og tar tiden.


% doWork lager en prosess
% den venter på at prossesen skal bli ferdig før den 