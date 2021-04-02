
withClean: run clean

remote: compile
	emx -U -R$(ARGS) Hashworker.x Main.x

run: compile
	emx Hashworker.x Main.x
	
compile:
	ec Hashworker.m Main.m


debug: compile
	emx -i Hashworker.x Main.x



clean:
	rm *.x