#command line arguments receive from docker run cli command, defaulted to alpine-3.8
ARG ALPINE_VERSION=devopsedu/webapp

#the parent image where this new image will be built on
FROM ${ALPINE_VERSION}

#describe who owns and maintains the image
MAINTAINER Fullstack Developer , saurabh18.cs@gmail.com

#copy local files into the container
#WORKDIR /scripts
#ADD hello-world.ps1 .
#COPY hello-world-forever.ps1 .

#add environment varilables
ENV ENVIRONMENT Development

#run some commands inside the container
#reduce layers by chaining your run commands
RUN apt-get update && \
		apt-get install -y git
RUN mkdir applicationCode && \
				cd applicationCode &&	 \        
					git clone https://github.com/saurabh18cs/projCert.git && \
						cd projCert/website
RUN cp -r /applicationCode/projCert/website/* /var/www/html/ && \
		cd / && \
		rm -rf applicationCode

#expose the port used by the container
EXPOSE 80/tcp

#run scripts during build time
#WORKDIR /var/www/html
#RUN  pwsh hello-world.ps1


# run the application via CMD or ENTRYPOINT
# use CMD if the parameter can be overwritten when container runs
CMD  ["/usr/sbin/apachectl", "-D", "FOREGROUND"]

#command executed when container runs via docker run cli command
#ENTRYPOINT  ["pwsh", "hello-world-forever.ps1"]
