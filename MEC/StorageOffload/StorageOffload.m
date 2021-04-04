

% read file
% send it to remote node


const SendFile <- class SendFile[iStream : InStream, recv: RecieveFile]
  export op send
    var line : String <- ""

    loop
      exit when iStream.eos
      begin
        (locate self)$stdout.putstring["En itersjon\n"]
        for i : Integer <- 0 while i<10 by i <- i + 1 % send 10 lines at a time
          if !iStream.eos then
            (locate self)$stdout.putstring["reee" || i.asString ||"\n"]
            line <- line || iStream.getString % get one line
          end if
        end for
        % send line
        recv.recieve[line]
        %reset line
        line <- ""
      end
    end loop
    (locate self)$stdout.putstring["Loop is done\n"]
  end send
end SendFile

const RecieveFile <- class RecieveFile
  attached var oStream : OutStream <- nil
  export op init
    oStream <- outstream.toUnix["OUT_file.txt", "a"]
    % assert false
    (locate self)$stdout.putstring["init skjer\n"]
  end init

  export op recieve[line: String]
    (locate self)$stdout.putstring["Dette skjer: " || line || "\n"]
    %const oStream <- OutStream.toUnix["OUT_file.txt", "a"]
    % assert false
    oStream.putString[line]
    oStream.flush
    %oStream.close
  end recieve
end RecieveFile


const main <- object main
  initially
    const home <- locate self
    var there : Node
    var all : NodeList


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

    there <- all[1]$theNode

    % const aaa <- OutStream.toUnix["reee.txt", "w"]
    % aaa.putString["reeeee"]
    % aaa.flush

    const recvF <- RecieveFile.create
    refix recvF at there

    const iStr <- inStream.fromUnix["IN_file.txt", "r"]
    const sendF <- SendFile.create[iStr, recvF]

    recvF.init

    sendF.send

  end initially
end main


% fillVector


% Når vi sender, så må vi sende små chucks om gangen.
%hvordan kan vi gjøre det?

% ha en vanlig innlesingsloop som over tid looper over hele filen
% du kan anta at ikke linjene er for lange, eller at alt er på samme linje


% les inn 10 linjer
% send til remote node
% i remote node: skriv til fil med samme outstream objekt?


% skriv inn i limitation at man kan ha non-blocking fileupload som er mye raskere