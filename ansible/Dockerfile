FROM centos:7

MAINTAINER LUISFILHO <luis.filho@semantix.com.br>

ENV container docker

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in ; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done);

RUN rm -rf /lib/systemd/system/multi-user.target.wants/ \
    && rm -rf /etc/systemd/system/.wants/ \
    && rm -rf /lib/systemd/system/local-fs.target.wants/ \
    && rm -f /lib/systemd/system/sockets.target.wants/udev \
    && rm -f /lib/systemd/system/sockets.target.wants/initctl \
    && rm -rf /lib/systemd/system/basic.target.wants/ \
    && rm -f /lib/systemd/system/anaconda.target.wants/*

RUN yum update -y &&\    
    yum install wget -y && \    
    yum install rpm -y && \
    yum whatprovides service -y && \
    yum -y install initscripts && yum clean all && \
    yum install curl -y && \
    yum install net-tools -y

RUN echo "alias vi=vim" >> ~/.bashrc && \
    source ~/.bashrc && \
    yum install vim-enhanced -y

#install java
RUN yum install java-1.8.0-openjdk -y &&\
    yum install java-1.8.0-openjdk -y


# install python 3.7
RUN yum install gcc openssl-devel bzip2-devel libffi libffi-devel -y && \
    wget https://www.python.org/ftp/python/3.7.0/Python-3.7.0.tgz && \
    tar xzf Python-3.7.0.tgz && \
    yum install make -y &&\
    yum install python3-pip -y && \
    pip3 install requests && \
    pip3 install bs4 && \
    pip3 install datetime && \
    pip3 install --user queuelib &&\
    pip3 install lxml

RUN yum install sudo -y &&\
    yum install zip -y &&\
    yum install unzip -y &&\
    yum install nano -y &&\
    yum install firewalld -y &&\
    yum install mlocate -y

WORKDIR /home/luis.filho/

WORKDIR /home/luis.filho/bin/

RUN wget http://downloads.typesafe.com/scala/2.11.12/scala-2.11.12.tgz &&\
    tar xvf scala-2.11.12.tgz &&\
    sudo mv scala-2.11.12 /usr/lib &&\
    sudo ln -s /usr/lib/scala-2.11.12 /usr/lib/scala &&\
    export PATH=$PATH:/usr/lib/scala/bin &&\
    scala -version

RUN wget https://downloads.apache.org/spark/spark-2.4.5/spark-2.4.5-bin-hadoop2.7.tgz &&\
    tar xvf spark-2.4.5-bin-hadoop2.7.tgz &&\
    curl https://bintray.com/sbt/rpm/rpm > bintray-sbt-rpm.repo && \
    mv bintray-sbt-rpm.repo /etc/yum.repos.d/ && \
    yum install sbt -y


RUN export SPARK_HOME=$HOME/spark-2.4.5-bin-hadoop2.7 &&\
    export PATH=$PATH:$SPARK_HOME/bin &&\
    echo 'export PATH=$PATH:/usr/lib/scala/bin' >> .bash_profile &&\
    echo 'export SPARK_HOME=$HOME/spark-2.4.5-bin-hadoop2.7' >> .bash_profile &&\
    echo 'export PATH=$PATH:$SPARK_HOME/bin' >> .bash_profile
  
COPY bin /home/luisfilho/elastic-terraform/ansible/bin

COPY estrutura.sh /home/luisfilho/elastic-terraform/ansible/

RUN chmod 777 //home/luisfilho/elastic-terraform/ansible/bin/init.sh

RUN chmod 777 /home/luisfilho/elastic-terraform/ansible/bin/spark_submit.sh

RUN chmod 777 /h/home/luisfilho/elastic-terraform/ansible/bin/stat.sh

RUN chmod 777 /home/luisfilho/elastic-terraform/ansible/estrutura.sh

RUN /home/luisfilho/elastic-terraform/ansible/estrutura.sh
   
EXPOSE 9200 9300

CMD ["/bin/bash", "-c", "exec /sbin/init --log-target=journal 3>&1"]


