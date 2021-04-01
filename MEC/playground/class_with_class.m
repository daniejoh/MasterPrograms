const A <- class A[name: String]

  const instanceOfB <- B.create

  


  const B <- monitor class B
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

  const Worker <- class Worker
    process
      const startTime <- (locate self)$timeOfDay
      for i : Integer <- 0 while i<3 by i <- i + 1

        (locate self)$stdout.putstring["this happens!" || name || "\n"]
        (locate self).delay[Time.create[0,500000]] % 
      end for
      const endTime <- (locate self)$timeOfDay
      instanceOfB.setTimeTaken[endTime - startTime]
      (locate self)$stdout.putstring["This happensssss "|| instanceOfB.getTimeTaken.asString||"\n"]
      %instanceOfB.continueSome
      instanceOfB.setyouHaveToWait[false]
     % assert false
    end process
  end Worker
  



  export op doWork
    const werk <- Worker.create
    (locate self)$stdout.putstring["Do work done: " || name || "\n"]
  end doWork

  export op collectResult -> [res: Time]
    % wait until process is done
    (locate self)$stdout.putstring[name || " starts waiting\n"]
    %instanceOfB.waitSome
    loop
      exit when !instanceOfB.getyouHaveToWait
      (locate self).delay[Time.create[0,500000]] % 
      (locate self)$stdout.putstring["yhtw: " || instanceOfB.getyouHaveToWait.asString || "\n"]
    end loop
    %assert false
    (locate self)$stdout.putstring[name || " stops waiting, and returning " || instanceOfB.gettimeTaken.asString ||"\n"]
    res <- instanceOfB.getTimeTaken
  end collectResult

% doWork bli kalt
% doWork må lage en prossess
% doWork må vente på at prossess er ferdig
% Sjekk så en felles variabel som inneholder "returnverdi"
% return denne verdien.
end A


const main <- object main
  initially
    const first <- A.create["first"]
    const second <- A.create["second"]

    first.doWork
    second.doWork

    const resultFirst <- first.collectResult
    const resultSecond <- second.collectResult
    (locate self)$stdout.putstring["Both are done!\n"]
    (locate self)$stdout.putstring["Result from first: "|| resultFirst.asString ||"\n"]
    (locate self)$stdout.putstring["Result from second: "|| resultSecond.asString ||"\n"]
  end initially

end main



const Semaphore <- monitor class Semaphore [initial : Integer]
  class export operation create -> [r : Semaphore]
    r <- Semaphore.create[1]
  end create
  var count : Integer <- initial
  var waiters : Condition <- Condition.create
  export operation acquire 
    count <- count - 1
    if count < 0 then
      wait waiters
    end if
  end acquire
  export operation release
    count <- count + 1
    if count <= 0 then
      signal waiters
    end if
  end release
end Semaphore


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