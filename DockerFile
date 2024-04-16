# Use an official OpenJDK runtime as a parent image
FROM adoptopenjdk/openjdk17:alpine

# Set the working directory in the container
WORKDIR /app

# Copy the application JAR file into the container at /app
COPY target/laboratorio2-0.0.1-SNAPSHOT.jar /app

# Specify the command to run your application
CMD ["java", "-jar", "laboratorio2-0.0.1-SNAPSHOT.jar"]
