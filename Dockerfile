# Use an official Maven image to build the application
FROM maven:3.8.4-openjdk-11-slim AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the source code into the container
COPY . .

# Run Maven build
RUN mvn clean install

# Use an official OpenJDK runtime as a base image
FROM openjdk:11-jre-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the JAR file from the Maven build stage
COPY --from=build /app/target/insure-me-1.0.jar app.jar

# Set the entry point to run the JAR file
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
