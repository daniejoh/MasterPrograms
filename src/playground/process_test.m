const testclass <- class testclass
  process
    (locate self)$stdout.putstring["process happened" || "\n"]
  end process
end testclass


const main <- object main
  initially
    %const t <- testclass.create

    (locate self)$stdout.putstring["initially happened" || "\n"]
  end initially
end main