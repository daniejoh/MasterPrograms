const main <- object main
  initially
    (locate self)$stdout.putstring["Starting main\n"]
    const home <- locate self
    var there : Node
    var all : NodeList
    const hashArr <- Array.of[HashWorker].empty
    

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
    hashArr.addUpper[HashWorker.create[inputAsInt]]

    % create and place hash objects
    for i : Integer <- 1 while i <= all.upperbound by i <- i + 1
      % create new hash object. Refix it
      (locate self)$stdout.putstring["How much limitation on node " || i.asString || "?\n"]
      input <- self.readline
      inputAsInt <- self.convertToInt[input] % ask user how much limitation should be on server
      var temp : HashWorker <- HashWorker.create[inputAsInt] % create hash class instance
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
      % (locate tmp)$stdout.putstring[(locate tmp)$name || " is starting\n"]
      (locate self)$stdout.putstring["How much work on node " || i.asString || "?\n"]
      input <- self.readline
      inputAsInt <- self.convertToInt[input]
      (locate self)$stdout.putstring["Starting doWork with " || inputAsInt.asString ||"\n"]
      tmp.doWork[inputAsInt]
    end for

    %(locate self).delay[Time.create[10,5]] %ten seconds + 5 microseconds

    var tempTime : Time <- nil
    var tempHashWorker : HashWorker <- nil
    for i : Integer <- 0 while i<=hashArr.upperbound by i <- i + 1
      tempHashWorker <- hashArr[i]
      tempTime <- tempHashWorker.collectTimeUsed
      (locate self)$stdout.putstring["Node " || i.asString || " used time: " || tempTime.asString ||"\n"]

      
    end for

    
    (locate self)$stdout.putstring["Main done!\n"]
  end initially



  % from github.com/emerald examples repository
  export function stripLast [ i : String ] -> [ o : String ]
    o <- i.getSlice[ 0, i.length - 1 ]
  end stripLast
  export function readline -> [ o : String ] % reads one line from user input
    o <- self.stripLast [ (locate self)$stdin.getstring ]
  end readline
  



  % Converts string to Integer
  export function convertToInt [input : String] -> [o : Integer]
    %(locate self)$stdout.putstring["Input: " || input ||"\n"]
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


% les inn ett ark som config!!
% for eksempel  MEC.conf, som inneholder hvor mange noder og generelt oppsett

% storage