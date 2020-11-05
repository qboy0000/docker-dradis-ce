# docker-dradis-ce
docker-dradis-ce

build dradis-ce docker image

# build
docker build -t dradis-ce .

#run
docker run --rm -it -p3000:3000 dradis-ce