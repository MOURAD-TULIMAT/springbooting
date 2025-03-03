FROM maven:3.9.9-eclipse-temurin-17 AS builder
ARG VERSION=0.0.1-SNAPSHOT
WORKDIR /build
COPY pom.xml .
COPY src ./src

RUN mvn clean package
COPY target/booting-web-${VERSION}.jar /app/application.jar

FROM eclipse-temurin:17-jre-jammy
WORKDIR /app
COPY --from=builder /app/application.jar /app/
CMD ["java", "-jar", "/app/application.jar"]