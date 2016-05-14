FROM centos:7

USER root
EXPOSE 3000
# Change mirrors
RUN yum install wget -y
# RUN mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
# RUN wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo

# Install required software
RUN yum install curl git python tree gcc gcc-c++ make openssl-devel -y

ENV HOME /root
# alinode v1.5.5 (node 4.4.4)
ENV ALINODE_VERSION 1.5.5
ENV TNVM_DIR /root/.tnvm
RUN mkdir /tmp/node_log

RUN wget -qO- https://raw.githubusercontent.com/aliyun-node/tnvm/master/install.sh | bash 
RUN source $HOME/.bashrc && \
        tnvm install "alinode-v$ALINODE_VERSION" && \
        tnvm use "alinode-v$ALINODE_VERSION" 
RUN source $HOME/.bashrc && npm install -g agentx
RUN git clone https://github.com/aliyun-node/commands.git /usr/local/src/alinode_commands

COPY docker-entrypoint.sh /
RUN mkdir /web
COPY time.js /web
ENTRYPOINT ["/docker-entrypoint.sh"]
