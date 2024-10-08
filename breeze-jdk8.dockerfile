FROM centos:centos7

MAINTAINER gaoweixuan

# 添加 JDK
ADD ./jdk/jdk-8u202-linux-x64.tar.gz /usr/local/java

# 设置时区
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# 设置区域信息
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8

# 创建字体目录（如果不存在）
RUN mkdir -p /usr/local/java/jdk1.8.0_202/jre/lib/fonts/

# 复制字体文件到目标目录
COPY ./fonts/* /usr/share/fonts/
COPY ./fonts/* /usr/local/java/jdk1.8.0_202/jre/lib/fonts/

# 设置环境变量
ENV JAVA_HOME /usr/local/java/jdk1.8.0_202
ENV JRE_HOME /usr/local/java/jdk1.8.0_202/jre
ENV PATH $JAVA_HOME/bin:$PATH

# 清理缓存（如果有安装软件包的情况）
RUN yum clean all
