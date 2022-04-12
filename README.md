# pipelines-docker-image

Barebones Alpine Linux image with PHP8.0, composer, npm and chromium installed. 

Build and host on dockerhub. 
```sh
docker build -t php-composer-npm-chromium .
docker tag php-composer-npm-chromium <dockerhub_username>/php-composer-npm-chromium:8.0
docker push <dockerhub_username>/php-composer-npm-chromium:8.0
```
