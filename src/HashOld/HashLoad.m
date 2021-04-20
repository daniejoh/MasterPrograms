
% @param limitation, how many microseconds you want to delay for each iteration.
% it is multiplied by 1000, so input of 1000 will make it sleep 1 second (1 000 000 microseconds) each iteration
const MyHash <- class MyHash[limitation: Integer]
  attached var work : Boolean <- false % false to stop, true to start
  attached var counter : Integer <- 0 % how many iterations this node has done
  const workload <- "This is the workload that is hashed!"

  initially
    (locate self)$stdout.putstring["I will sleep for " || (limitation*1000).asString || "microseconds\n"]
  end initially

  export op startWorking
    work <- true
  end startWorking

  export op stopWorking
    work <- false
  end stopWorking

  export op getCounter -> [res: Integer]
    res <- counter
  end getCounter

  export op setLimitation[lim: Integer]
    limitation <- lim
  end setLimitation


  % converted from C version found here: http://www.cse.yorku.ca/~oz/hash.html
  function djb2Hash[str: String] -> [res: Integer]
    res <- 5381
    for i : Integer <- 0 while i < str.length by i <- i + 1
      res <- res * 33 * str[i].ord % .ord gets the ordinal number
    end for
  end djb2Hash



  
  process
    var garbage : Integer <- 0
    
    loop
      exit when work % wait to start work
    end loop

    const home <- (locate self) % for printing and sleeping

    const timeStart <-  home$timeOfDay

    loop % main loop
      exit when !work % work until stopworking is called

      % just hash the string 10000 times
      for i : Integer <- 0 while i<10000 by i <- i + 1
        garbage <- self.djb2Hash[workload] 
      end for

      % Sleeping to simulate weaker hardware
      % There is 1 000 000 microseconds in a second.
      (locate self).delay[Time.create[0,limitation*1000]] %

      counter <- counter + 1 % count up

      home$stdout.putstring["Did one iteration "]
      home$stdout.putstring[counter.asString || "\n"]
      home$stdout.flush
    end loop % end main loop

    const timeEnd <- home$timeOfDay

    const total <- timeEnd - timeStart % total time used for calculating

    home$stdout.putString["I used time " || total.asString || " to do " || counter.asString || " iterations\n"]

    home$stdout.putstring[home$name || " Done!\n"]
  end process
end MyHash


const main <- object main
  initially
    (locate self)$stdout.putstring["Starting...\n"]
    const home <- locate self
    var there : Node
    var all : NodeList
    const hashArr <- Array.of[MyHash].empty
    

    home$stdout.PutString["Starting on " || home$name || "\n"]
    all <- home.getActiveNodes
    home$stdout.PutString[(all.upperbound + 1).asString || " nodes active.\n"]
    % take user input place out nodes, so that we can create correct limitations for the correct nodes?
    % for example, "choose 1 for this node"

    % visit each node, print index and id
    for i : Integer <- 0 while i <= all.upperbound by i <- i + 1
      there <- all[i]$theNode 
      refix self at there
      there$stdout.putstring["I am node with index "]
      there$stdout.putstring[i.asString]
      there$stdout.putstring[" and id "]
      there$stdout.putstring[there$name || "\n"]
    end for
    refix self at home

    % prompt: "how much limit on index 0" then 1 and so on

    (locate self)$stdout.putstring["How much limitation on 0?\n"]
    var input : String <- self.readline
    var inputAsInt : Integer <- self.convertToInt[input]
    %(locate self)$stdout.putstring["Inputen var: " || inputAsInt.asString || "\n"]
    hashArr.addUpper[MyHash.create[inputAsInt]]

    % create and place hash objects
    for i : Integer <- 1 while i <= all.upperbound by i <- i + 1
      % create new hash object. Refix it
      (locate self)$stdout.putstring["How much limitation on node " || i.asString || "?\n"]
      input <- self.readline
      inputAsInt <- self.convertToInt[input] % ask user how much limitation should be on server
      var temp : MyHash <- MyHash.create[inputAsInt] % create hash class instance
      hashArr.addUpper[temp] % add instance to array
      there <- all[i]$theNode % get node for printing and refixing
      there$stdout.putString["Initilizing " || there$name || "\n"]
      refix temp at there
    end for

    % all nodes should now have a hash object placed locally
    % when conducting the expirements, use mac as a watchdog and servers as actual nodes(mac can ofc be the local object, but throttle it)
    for i : Integer <- 0 while i<=hashArr.upperbound by i <- i + 1
      (locate self)$stdout.putstring["Starting "|| i.asString || "\n"]
      const tmp <- hashArr.getElement[i] % get the hashing object
      (locate tmp)$stdout.putstring[(locate tmp)$name || " has starting\n"]
      tmp.startWorking % make the remote hashing object start working
    end for

    (locate self).delay[Time.create[10,5]] %ten seconds + 5 microseconds

    % stop all working nodes
    for i : Integer <- 0 while i<=hashArr.upperbound by i <- i + 1
      hashArr.getElement[i].stopWorking
    end for
    (locate self)$stdout.putstring["Done!\n"]
  end initially

  % from github.com/emerald examples repository
  export function stripLast [ i : String ] -> [ o : String ]
    o <- i.getSlice[ 0, i.length - 1 ]
  end stripLast
  export function readline -> [ o : String ] % reads one line from user input
    o <- self.stripLast [ (locate self)$stdin.getstring ]
  end readline
  

  export function convertToInt [input : String] -> [ o : Integer]
    (locate self)$stdout.putstring["Input: " || input ||"\n"]
    o <- 0
    var actual : Integer
    for i : Integer <- 0 while i<=input.upperbound by i <- i + 1
      actual <- (input.getElement[i].ord - 48) % convert from character value to int
      %(locate self)$stdout.putstring["Actual uten minus 48: " || input.getElement[i].ord.asString || "\n"]
      %(locate self)$stdout.putstring["Actual: "|| actual.asString ||"\n"]
      o <- o * 10 % For each extra number we have to multiply by ten
      o <- o + actual 
    end for
  end convertToInt

end main


% master that runs around gathering metrics and changes limitations?