export FileReader

const FileReader <- class FileReader
  export op readFile[fileName: String] -> [res : Array.of[String]]
    res <- Array.of[String].empty
    const stream <- inStream.fromUnix[fileName, "r"]
    var line : String <- ""

    loop
      exit when stream.eos
      begin
        line <- self.stripLast[stream.getString]
        (locate self)$stdout.putstring[line || "\n"]
        res.addUpper[line]
      end
    end loop
  end readFile

  export op writeFile[fileName: String, content : String]
    const stream <- outStream.toUnix[fileName, "w"]
    stream.putString[content]
  end writeFile

  function stripLast [ i : String ] -> [ o : String ]
    o <- i.getSlice[ 0, i.length - 1 ]
  end stripLast

end FileReader

% const main <- object main
%   initially
%     const fr <- FileReader.create
%     const r <- fr.readFile["example.config"]
%   end initially
% end main
