FROM aussielunix/fpm-cook:ubuntu_14.04 
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install ruby ruby-dev
RUN mkdir -p ~/.ssh
RUN ssh-keyscan github.com >> ~/.ssh/known_hosts
ENTRYPOINT fpm-cook package -t deb -p ubuntu recipe.rb
