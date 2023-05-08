docker build -t arbitor_image .
docker run --rm -it -e "TERM=xterm-256color" arbitor_image bash -l
