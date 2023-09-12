FROM openjdk:8-jdk-alpine
WORKDIR /var/local/app
COPY ./target/*.jar /var/local/app/app.jar
CMD ["java", "-jar", "app.jar"]