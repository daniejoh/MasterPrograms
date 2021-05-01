
withClean: run clean

remote: compile
	emx -U -R$(ARGS) FileReader.x HashWorker_latency.x Main_from_file.x

remoteDebug: compile
	emx -i -U -R$(ARGS) FileReader.x HashWorker_latency.x Main_from_file.x

run: compile
	emx FileReader.x HashWorker_latency.x Main_from_file.x

compile:
	ec FileReader.m HashWorker_latency.m Main_from_file.m


debug: compile
	emx -i FileReader.x HashWorker_latency.x Main_from_file.x



clean:
	rm *.x