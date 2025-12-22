# Build stage
FROM maven:3.9-eclipse-temurin-17 AS build
LABEL authors="ajay67"
WORKDIR /app

# Copy the pom.xml and download dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the rest of the application source code
COPY src ./src

# Build the application
RUN mvn clean package -DskipTests

# Runtime stage
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app

# Copy the built jar from build stage
COPY --from=build /app/target/Ajay-0.0.1-SNAPSHOT.jar app.jar

# Expose the default Spring Boot port
EXPOSE 9090

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
