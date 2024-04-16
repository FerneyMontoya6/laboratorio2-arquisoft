# Use an official OpenJDK runtime as a parent image
#FROM maven:3.8.4-openjdk-17-slim

# Set the working directory in the container
#WORKDIR /app

# Copy the application JAR file into the container at /app
#COPY target/laboratorio2-0.0.1-SNAPSHOT.jar /app

# Specify the command to run your application
#CMD ["java", "-jar", "laboratorio2-0.0.1-SNAPSHOT.jar"]

# Use a base image with Java and Maven pre-installed
FROM maven:3.8.4-openjdk-17-slim AS build

# Set the working directory in the container
WORKDIR /app

# Copy the Maven project definition
COPY pom.xml .

# Resolve dependencies and cache them
RUN mvn dependency:go-offline

# Copy the application source code
COPY src ./src

# Build the application
RUN mvn package -DskipTests

# Create a new stage for running the application
FROM openjdk:17-slim AS runtime

# Set the working directory in the container
WORKDIR /app

# Copy the JAR file built in the previous stage
COPY --from=build /app/target/laboratorio2-0.0.1-SNAPSHOT.jar .

# Expose the port your application runs on
EXPOSE 8080
# Specify the command to run your application
CMD ["java", "-jar", "laboratorio2-0.0.1-SNAPSHOT.jar"]