
withClean: run clean

remote: compile
	emx -U -R$(ARGS) FileReader.x HashWorker.x Main.x

remoteDebug: compile
	emx -i -U -R$(ARGS) FileReader.x HashWorker.x Main.x

run: compile
	emx FileReader.x HashWorker.x Main.x

compile:
	ec FileReader.m HashWorker.m Main.m


debug: compile
	emx -i FileReader.x HashWorker.x Main.x



clean:
	rm *.x