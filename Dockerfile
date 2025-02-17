FROM openjdk:21-jdk-slim
VOLUME /tmp
ARG JAR_FILE=target/*.jar
COPY ./demo-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
