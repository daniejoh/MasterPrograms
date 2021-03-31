const main <- object main
  initially
    const home <- locate self
    const t0 <- home$timeOfDay
    const t1 <- home$timeOfDay
    home$stdout.PutString["Total time " || (t1-t0).asString || "\n"]
  end initially
end main


    %(locate self).delay[Time.create[1,0]] % waits one second