
withClean: run clean

remote: compile
	emx -U -R$(ARGS) HashLoad.x

run: compile
	emx HashLoad.x
	
compile:
	ec HashLoad.m


debug: compile
	emx -i HashLoad.x



clean:
	rm *.x