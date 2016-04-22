FROM centos:6.7
#--------------JAVA----

#-------------local file
#COPY jdk1.8.0_60 /opt/jdk1.8


#--------------install base software for hadoop----------
RUN yum install -y epel-release && \
 yum makecache && \
 yum install -y man passwd sudo tar which git mlocate bzip2 net-tools\
 openssh-clients openssh-server

# Install Oracle JDK 8u60
RUN cd /tmp && \
    curl -L -O -H "Cookie: oraclelicense=accept-securebackup-cookie" -k "http://download.oracle.com/otn-pub/java/jdk/8u60-b27/jdk-8u60-linux-x64.tar.gz" && \
    mkdir -p /opt/java && tar xf jdk-8u60-linux-x64.tar.gz -C /opt/java && \
    rm -f jdk-8u60-linux-x64.tar.gz && \
    ln -s /opt/java/jdk* /opt/jdk1.8

#clean yum cache
RUN yum clean all

ENV JAVA_HOME=/opt/jdk1.8
ENV PATH=$JAVA_HOME/bin:$PATH

RUN java -version
CMD ["bash"]

WORKDIR /