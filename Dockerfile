FROM maven:3-ibm-semeru-21-jammy as BUILDER
ARG VERSION=0.0.1-SNAPSHOT
WORKDIR /build/
COPY pom.xml /build/
COPY src /build/src/

RUN mvn clean package
COPY target/springboot-web-${VERSION}.jar target/application.jar

FROM mcr.microsoft.com/openjdk/jdk:21-ubuntu
WORKDIR /app/

COPY --from=BUILDER /build/target/application.jar /app/
CMD java -jar /app/application.jar