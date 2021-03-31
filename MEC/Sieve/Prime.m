%eratosthenes sieve

export sieve

const sieve <- class sieve[myPrime: Integer] %object som tar inn et tall
  var nextSieve: sieve <- nil

  export op myFunc[stdout: OutStream, n: Integer]
    %stdout.putstring["Starter myfunc, n:" || n.asString || ", my prime:" || myPrime.asString ||"\n"]
    if nextSieve == nil then
      if n # myPrime != 0 then
        %stdout.putstring["lager ny sieve med n: " || n.asString || ", my prime:" || myPrime.asString || "\n"]
        nextSieve <- sieve.create[n]
      end if
    elseif n # myPrime != 0 then
      %stdout.putstring["kaller paa nextSieve med n: " || n.asString || ", my prime:" || myPrime.asString || "\n"]
      nextSieve.myFunc[stdout, n]
    end if
  end myFunc

  export op printAndNext[stdout: OutStream]
    stdout.putstring[myPrime.asString[] || "\n"]
    if nextSieve !== nil then
      nextSieve.printAndNext[stdout]
    end if
  end printAndNext 
end sieve


const SeqSieve <- class SeqSieve
  const listOfPrimes <- Array.of[Integer].empty
  var primes: Array.of[Boolean] % index 0 represent the number 3, index 1 represent 5 etc


  export op getPrimes[t: integer] -> [res: Array.of[Integer]]%from, to
    % init prime array by looping and setting all to true
    primes <- Array.of[Boolean].empty
    for i : Integer <- 0 while i<=t by i <- i + 1
      primes.addUpper[true]
    end for

    for p : Integer <- 2 while p*p <= t by p <- p + 1
      if primes.getElement[p] = true then
        for x : Integer <- p*p while x<=t by x <- x + p
          primes.setElement[x,false]
        end for
      end if
    end for

    const home <- (locate self)
    for y : Integer <- 2 while y<t by y <- y + 1
      if primes.getElement[y] = true then
        %home$stdout.putString[y.asString || "\n"]

        listOfPrimes.addUpper[y]
      end if
    end for

    res <- listOfPrimes
  end getPrimes
end SeqSieve



const main <- object main
  initially
    const s <- SeqSieve.create
    const r <- s.getPrimes[1000000]
    (locate self)$stdout.putString["Number of primes: " ||r.upperbound.asString || "\n"]
  end initially
end main