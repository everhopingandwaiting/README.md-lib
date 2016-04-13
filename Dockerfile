# for jave web : lib-springMVC-mybatis
FROM buildpack-deps:sid-scm  
MAINTAINER j.yao.SUSE "351022095@qq.com"
RUN apt-get update && apt-get install -y --no-install-recommends \
				bzip2  	unzip 	xz-utils sudo  openssh-server maven   \
				&& rm -rf /var/lib/apt/lists/*
											   
RUN apt-get autoclean -y && apt-get autoremove -y							  
RUN echo 'deb http://httpredir.debian.org/debian experimental main' > /etc/apt/sources.list.d/experimental.list
RUN echo 	
# Default to UTF-8 file.encoding
ENV LANG C.UTF-8
ADD .  /home/docker
WORKDIR  /home/docker
#congig jave  env   fork from : https://github.com/everhopingandwaiting/openjdk/blob/master/9-jdk/Dockerfile
RUN { \
	echo '#!/bin/sh'; \
	echo 'set -e'; \
	echo; \
	echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; \
	}	 > /usr/local/bin/docker-java-home \
	&& chmod +x /usr/local/bin/docker-java-home
ENV JAVA_HOME /usr/lib/jvm/java-9-openjdk-amd64
ENV JAVA_VERSION 9~b112
ENV JAVA_DEBIAN_VERSION 9~b112-2
RUN set -x \
&& apt-get update \
&& apt-get install -y \
openjdk-9-jdk-headless="$JAVA_DEBIAN_VERSION" \
&& rm -rf /var/lib/apt/lists/* \
&& [ "$JAVA_HOME" = "$(docker-java-home)" ]
RUN   echo $JAVA_HOME
RUN  pwd
RUN   ls -al
RUN  java  ; java -version
# config java env end!
#start tomcat 
ENTRYPOINT apache-tomcat-9.0.0.M3/bin/startup.sh && tail -f apache-tomcat-9.0.0.M3/logs/lib/Pro_j_yao
EXPOSE 22 80 8080 3000 443 21 
