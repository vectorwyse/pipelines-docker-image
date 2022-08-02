# pipelines-docker-image

Barebones Alpine Linux image with php, composer, npm and chromium installed. 

Build and host on dockerhub. 
```sh
docker build -t php-composer-npm-chromium .
docker tag php-composer-npm-chromium <dockerhub_username>/php-composer-npm-chromium:<tag>
docker push <dockerhub_username>/php-composer-npm-chromium:<tag>
```
