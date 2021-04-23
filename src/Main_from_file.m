const main <- object main
  initially
    (locate self)$stdout.putstring["Starting main\n"]
    const home <- locate self
    var there : Node
    var all : NodeList
    const hashWorkerArray <- Array.of[HashWorker].empty
    

    home$stdout.PutString["Starting on " || home$name || "\n"]
    all <- home.getActiveNodes
    home$stdout.PutString[(all.upperbound + 1).asString || " nodes active.\n"]
    

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


    % read config
    const fr <- FileReader.create
    % const lines <- fr.readFile["configs/MEC_Full_near_far.config"] % Array.of[String]
    % const lines <- fr.readFile["MEC_partial_near_far.config"]
    const lines <- fr.readFile["configs/balance_latency.config"]

    const config <- fr.convertConfigToIntegers[lines]
    var configLineCounter : Integer <- 0
    
    (locate self)$stdout.putstring["Lines: "|| (lines.upperbound+1).asString || "\n"] %for debug
    (locate self)$stdout.putstring["Config: "|| (config.upperbound+1).asString || "\n"] %for debug



    var limit: Integer <- nil
    var temp : HashWorker <- nil
    var input: String <- nil
    var inputAsInt: Integer <- nil
    % use config to create the needed HashWorkers and place them on nodes
    %(locate self)$stdout.putstring["Upperbound of config:" || config.upperbound.asString || "\n"]
    for i : Integer <- 0 while i<((config.upperbound+1) / 2) by i <- i + 1
      limit <- config.getElement[configLineCounter]
      temp <- HashWorker.create[limit] % create hash class instance
      configLineCounter <- configLineCounter + 1
      hashWorkerArray.addUpper[temp]

      % take input from user
      (locate self)$stdout.putstring["Where should HashWorker with limitation " || limit.asString || " be placed? (index of node):\n"]
      input <- self.readLine
      inputAsInt <- self.convertToInt[input]
      there <- all[inputAsInt]$theNode % get node for printing and refixing
      begin
        there$stdout.putString["Initilizing " || there$name || "\n"]
        refix temp at there
        unavailable
          (locate self)$stdout.putstring["A node was unavailable when placing HashWorkers\n"]
        end unavailable
      end
    end for
    % all nodes should now have a hash object placed locally

    % make the nodes start working
    var swork : SomeWork <- SomeWork.create %workload that can be moved
    for i : Integer <- 0 while i<=hashWorkerArray.upperbound by i <- i + 1
      (locate self)$stdout.putstring["Starting "|| i.asString || "\n"]
      const tmp <- hashWorkerArray.getElement[i] % get the hashing object
      % (locate tmp)$stdout.putstring[(locate tmp)$name || " is starting\n"]

      % tmp.refixWorkloadToMobileDevice[home] % for latency test
      tmp.doWork[config.getElement[configLineCounter], swork, 10] %start working with number of times given in config
      configLineCounter <- configLineCounter + 1
    end for

    
    % collect and print times
    var tempTime : Time <- nil
    var tempHashWorker : HashWorker <- nil
    for i : Integer <- 0 while i<=hashWorkerArray.upperbound by i <- i + 1
      tempHashWorker <- hashWorkerArray[i]
      tempTime <- tempHashWorker.collectTimeUsed
      (locate self)$stdout.putstring["Node " || i.asString || " used time: " || tempTime.asString ||"\n"]
    end for

    
    (locate self)$stdout.putstring["Main done!\n"]
  end initially

  % ------- Utils for reading userinput from terminal ---------------

  % from github.com/emerald examples repository
  function stripLast [ i : String ] -> [ o : String ]
    o <- i.getSlice[ 0, i.length - 1 ]
  end stripLast
  function readline -> [ o : String ] % reads one line from user input
    o <- self.stripLast [ (locate self)$stdin.getstring ]
  end readline

  % Converts string to Integer
  function convertToInt [input : String] -> [o : Integer]
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


% les inn en tesktfil som config!!
% for eksempel  MEC.conf, som inneholder hvor mange noder og generelt oppsett

% storage
