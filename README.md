# docker-dradis-ce
docker-dradis-ce

build dradis-ce docker image

# build
docker build -t dradis-ce .

# run docker
docker run --rm -it -p3000:3000 dradis-ce

# view
http://127.0.0.1:3000 use browser