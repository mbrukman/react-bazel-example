FROM ubuntu:16.04

WORKDIR /usr

RUN apt update

RUN apt -y install gnupg
RUN apt -y install git
RUN apt -y install nano
RUN apt -y install curl

RUN echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" | tee tee /etc/apt/sources.list.d/bazel.list
RUN curl https://bazel.build/bazel-release.pub.gpg | apt-key add -
RUN apt update -y && apt install bazel -y

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -

RUN apt update && apt install nodejs -y

RUN npm i

RUN npm i @bazel/ibazel -g

COPY package.json /usr
COPY WORKSPACE /usr
COPY BUILD.bazel /usr
COPY tsconfig.json /usr
COPY .bazelrc /usr
COPY yarn.lock /usr

EXPOSE 7001
EXPOSE 9999

WORKDIR /usr

ENTRYPOINT []