FROM consol/centos-xfce-vnc:1.2.1

## Use root to install additional software
USER 0

# add the chrome and gecko drivers
#COPY chromedriver geckodriver /headless/

#COPY firefox /headless/firefox

# replace the existing vnc_startup script and add the new one
COPY vnc_startup.sh /dockerstartup/

ENV SBCL_VERSION=1.3.5 
ENV PATH="/sbcl:${PATH}"

## Install 7zip, gedit, wget, OpenJDK8
RUN yum -y install gedit wget curl tar bzip2 \
    && yum clean all \
    && mkdir /sbcl \
    && curl -sL https://sourceforge.net/projects/sbcl/files/sbcl/${SBCL_VERSION}/sbcl-${SBCL_VERSION}-x86-64-linux-binary.tar.bz2 \
    | bzip2 -d \
    | tar -xf - -C / \
    && cd /sbcl-${SBCL_VERSION}-x86-64-linux \
    && rmdir /sbcl \
    && ln -s /sbcl-${SBCL_VERSION}-x86-64-linux /sbcl

## switch back to default user
USER 1984
