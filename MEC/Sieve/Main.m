const main <- object main
  initially
    var firstSieve: sieve <- sieve.create[2]
    for i : Integer <- 3 while i <= 30 by i <- i + 1
      firstSieve.myFunc[stdout,i]
    end for
    firstSieve.printAndNext[(locate self)$stdout]
    
  end initially
end main