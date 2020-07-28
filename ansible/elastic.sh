#!/bin/bash

sudo su

cd /lib/systemd/system/sysinit.target.wants/; for i in ; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done

rm -rf /lib/systemd/system/multi-user.target.wants/ 
rm -rf /etc/systemd/system/.wants/ 
rm -rf /lib/systemd/system/local-fs.target.wants/ 
rm -f /lib/systemd/system/sockets.target.wants/udev 
rm -f /lib/systemd/system/sockets.target.wants/initctl 
rm -rf /lib/systemd/system/basic.target.wants/ 
rm -f /lib/systemd/system/anaconda.target.wants/*

sudo yum update -y    
sudo yum install wget -y     
sudo yum install rpm -y 
sudo yum whatprovides service -y
sudo yum -y install initscripts && yum clean all
sudo yum install curl -y 
sudo yum install net-tools -y

echo "alias vi=vim" >> ~/.bashrc
echo source ~/.bashrc
sudo yum install vim-enhanced -y


sudo yum install java-1.8.0-openjdk -y 
sudo yum install java-1.8.0-openjdk -y



yum install gcc openssl-devel bzip2-devel libffi libffi-devel -y
wget https://www.python.org/ftp/python/3.7.0/Python-3.7.0.tgz
tar xzf Python-3.7.0.tgz
yum install make -y
yum install python3-pip -y
pip3 install requests
pip3 install bs4 
pip3 install datetime 
pip3 install --user queuelib
pip3 install lxml

sudo yum install sudo -y 
sudo yum install zip -y
sudo yum install unzip -y
sudo yum install nano -y
sudo yum install firewalld -y
sudo yum install mlocate -y



workdir /home/luisfilho/bin/

wget http://downloads.typesafe.com/scala/2.11.12/scala-2.11.12.tgz 
tar xvf scala-2.11.12.tgz 
sudo mv scala-2.11.12 /usr/lib 
sudo ln -s /usr/lib/scala-2.11.12 /usr/lib/scala 
export PATH=$PATH:/usr/lib/scala/bin 
scala -version

wget https://downloads.apache.org/spark/spark-2.4.5/spark-2.4.5-bin-hadoop2.7.tgz 
tar xvf spark-2.4.5-bin-hadoop2.7.tgz 
curl https://bintray.com/sbt/rpm/rpm > bintray-sbt-rpm.repo
mv bintray-sbt-rpm.repo /etc/yum.repos.d/ 
sudo yum install sbt -y


export SPARK_HOME=$HOME/spark-2.4.5-bin-hadoop2.7 
export PATH=$PATH:$SPARK_HOME/bin 
echo 'export PATH=$PATH:/usr/lib/scala/bin' >> .bash_profile 
echo 'export SPARK_HOME=$HOME/spark-2.4.5-bin-hadoop2.7' >> .bash_profile 
echo 'export PATH=$PATH:$SPARK_HOME/bin' >> .bash_profile
  
cp /bin /home/luisfilho/elastic-terraform/ansible/bin

cp estrutura.sh /home/luisfilho/elastic-terraform/ansible/

chmod 777 /home/luisfilho/elastic-terraform/ansible/bin/init.sh

chmod 777 /home/luisfilho/elastic-terraform/ansible/bin/spark_submit.sh

chmod 777 /home/luisfilho/elastic-terraform/ansible/bin/stat.sh

chmod 777 /home/luisfilho/elastic-terraform/ansible/estrutura.sh

./home/luisfilho/elastic-terraform/ansible/estrutura.sh
   


