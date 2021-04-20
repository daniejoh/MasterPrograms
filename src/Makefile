
withClean: run clean

remote: compile
	emx -U -R$(ARGS) FileReader.x HashWorker_fps.x Main_from_file.x

run: compile
	emx FileReader.x HashWorker_fps.x Main_from_file.x
	
compile:
	ec FileReader.m HashWorker_fps.m Main_from_file.m


debug: compile
	emx -i FileReader.x HashWorker_fps.x Main_from_file.x



clean:
	rm *.x