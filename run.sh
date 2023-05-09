docker build -t arbitor_image .
docker run --rm -it -e "TERM=xterm-256color" --shm-size 8G arbitor_image bash -l
