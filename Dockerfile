FROM centos:7
MAINTAINER soichiro0311

RUN yum install epel-release -y && \
    yum -y update && \
    yum --enablerepo=epel install python2-pip.noarch -y && \
    yum install openssh-server -y && \
    yum install openssh-clients -y && \
    yum reinstall glibc-common -y && \
    yum install sshpass -y && \
    yum remove python27-chardet.noarch -y && \
    pip install --upgrade pip && \
    pip install ansible && \
    pip install pywinrm && \
    yum clean all

ENV LANG ja_JP.UTF-8

RUN sed -ri 's/^#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    echo 'root:password' | chpasswd && \
    mkdir -p /etc/ansible

COPY hosts /etc/ansible

COPY test.yml /etc/ansible

COPY ansible.cfg /etc/ansible

EXPOSE 22

CMD ["/bin/bash"]