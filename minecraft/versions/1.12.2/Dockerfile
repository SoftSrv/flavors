FROM debian:jessie

RUN echo "deb http://http.debian.net/debian jessie-backports main" > /etc/apt/sources.list.d/jessie-backports.list
RUN apt-get -y update
RUN apt-get -y install -t jessie-backports openjdk-8-jre-headless wget > /dev/null

# download all relevant versions of minecraft server
RUN wget -P /minecraft -q https://s3.amazonaws.com/Minecraft.Download/versions/1.12.2/minecraft_server.1.12.2.jar

ADD . /minecraft

# Sets working directory
# Create mount point, and mark it as holding externally mounted volume
WORKDIR /data
VOLUME /data

# Expose the container's network port: 25565 during runtime.
EXPOSE 25565

#Automatically accept Minecraft EULA, and start Minecraft server
CMD echo eula=true > /data/eula.txt && sh /minecraft/boot.sh
