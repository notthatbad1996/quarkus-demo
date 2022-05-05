## Stage 1 : build with graalvm with native-image
FROM ghcr.io/graalvm/native-image:ol8-java17-22.1.0 AS build

## Stage 2 : add gradle
RUN mkdir -p /home/gradle/gradle-7.4.2
COPY gradle-7.4.2 /home/gradle/gradle-7.4.2

## Stage 3 : gradle environment
WORKDIR /home/gradle
ENV GRADLE_HOME=/opt/gradle
RUN mv "/home/gradle/gradle-7.4.2" "${GRADLE_HOME}/" \
    && ln --symbolic "${GRADLE_HOME}/bin/gradle" /usr/bin/gradle  \
    && echo "Testing Gradle installation"     \
    && gradle --version