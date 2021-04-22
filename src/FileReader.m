export FileReader

const FileReader <- immutable class FileReader
  % returns each line as a separete index in the array. First line is index 0
  export op readFile[fileName: String] -> [res: Array.of[String]]
    res <- Array.of[String].empty
    var stream : InStream <- nil
    begin
      stream <-  InStream.fromUnix[fileName, "r"]
      failure
        (locate self)$stdout.putstring["Something went wrong when reading file\n"]
      end failure
    end

    var line : String <- ""

    loop
      exit when stream.eos
      begin
        line <- self.stripLast[stream.getString]
        % (locate self)$stdout.putstring[line || "\n"] % for DEBUG
        res.addUpper[line]
      end 
    end loop
  end readFile


  export function convertConfigToIntegers[input: Array.of[String]] -> [res: Array.of[Integer]]
    %convert string lines to int, and put them in "config"
    res <- Array.of[Integer].empty
    for i : Integer <- 0 while i<=input.upperbound by i <- i + 1 
      res.addUpper[self.convertToInt[input.getElement[i]]]
    end for
  end convertConfigToIntegers

  export op writeFile[fileName: String, content: String]
    var stream : OutStream <- nil
    begin
      stream<- OutStream.toUnix[fileName, "w"]
      stream.putString[content]
      failure
        (locate self)$stdout.putstring["Something went wrong when writing to file\n"]
      end failure
    end
  end writeFile

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

  function stripLast [i: String ] -> [o: String ]
    o <- i.getSlice[ 0, i.length - 1 ]
  end stripLast

end FileReader

% const main <- object main
%   initially
%     const fr <- FileReader.create
%     const r <- fr.readFile["MEC_simple.config"]
%     (locate self)$stdout.putstring[r.upperbound.asString || "\n"]
%   end initially
% end main
