const imu <- immutable class imu
  export op heyho
    (locate self)$stdout.putstring["heyho!\n"]
  end heyho

end imu


const main <- object main
  initially
    const home <- locate self
    var there : Node
    var all : NodeList

    home$stdout.PutString["Starting on " || home$name || "\n"]
    all <- home.getActiveNodes
    home$stdout.PutString[(all.upperbound + 1).asString || " nodes active.\n"]
    const a <- imu.create
    const b <- imu.create
    there <- all[1]$theNode
    refix b at there

    a.heyho
    b.heyho
  end initially
end main