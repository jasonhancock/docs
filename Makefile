.PHONY: run all vendordocs swagger2markup

all: run

run:
	docker-compose up

vendordocs:
	@echo "Downloading API docs from '${SOURCE}'"
	curl -o swagger.json ${SOURCE}
	git checkout docs/reference/vendor-api.adoc
	java -cp java/swagger2markup-1.0.0.jar -jar java/swagger2markup-cli-1.0.0.jar convert -i swagger.json -f vendor-api
	@sed -e 's/^== /= /' -e 's/^=== /== /' vendor-api.adoc >> docs/reference/vendor-api.adoc
	@rm vendor-api.adoc

setup:
	mkdir java
	curl -o java/swagger2markup-cli-1.0.0.jar http://central.maven.org/maven2/io/github/swagger2markup/swagger2markup-cli/1.0.0/swagger2markup-cli-1.0.0.jar
	curl -o java/swagger2markup-1.0.0.jar http://central.maven.org/maven2/io/github/swagger2markup/swagger2markup/1.0.0/swagger2markup-1.0.0.jar
