########################################################################################
FROM maven:3-jdk-8-alpine AS build-environment
# Install Some tools
RUN apk add --no-cache \
  curl \
  bats \
  docker \
  git
# Build Application
WORKDIR /app/
COPY ./ /app/
RUN mvn -B verify

########################################################################################
FROM openjdk:8-jre-alpine AS run-environment

COPY --from=build-environment /app/target/demoapp.jar /app.jar

EXPOSE 8080

ENTRYPOINT ["java"]
CMD ["-jar","/app.jar"]
