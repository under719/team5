FROM openjdk:21-jdk-slim
WORKDIR /app
ARG JAR_FILE=target/*.jar
COPY ./build/libs/*.jar app.jar
ENTRYPOINT ["java", "-jar", "/app.jar"]
