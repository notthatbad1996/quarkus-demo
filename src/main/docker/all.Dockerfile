## Stage 1 : build with gradle builder image with native capabilities
FROM notthatbad/graalvm-gradle:20220419 AS build
COPY build.gradle /code/
COPY settings.gradle /code/
COPY gradle.properties /code/
WORKDIR /code
COPY src /code/src
RUN gradle build -Dquarkus.package.type=native

## Stage 2 : create the docker final image
FROM registry.access.redhat.com/ubi8/ubi-minimal:8.5
WORKDIR /work/
COPY --from=build /code/build/*-runner /work/application
RUN chmod 775 /work
EXPOSE 8080
CMD ["./application", "-Dquarkus.http.host=0.0.0.0"]