service_name="jenkins-workshop"
image_name = "hboaventura/jenkins-workshop"
image_id = $(shell docker images -q $(image_name):latest)
git_commit = $(shell git log --pretty=format:'%h' -n 1)

docker-build:
	docker build -t $(image_name) .

docker-push:
	docker tag $(image_id) hboaventura/jenkins-workshop:$(git_commit)
	docker push $(image_name)

docker-run: docker-build
	docker run --rm -it \
	-e java.util.logging.config.file=/var/jenkins_home/log.properties \
	-p 8180:8080 \
	-p 50000:50000 \
	-v `pwd`/data:/var/jenkins_home \
	--name $(service_name) $(image_name)
