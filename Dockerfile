# Etapa 1: Compilación
FROM maven:3.9.12-eclipse-temurin-25 AS build
WORKDIR /app
# Copiamos el pom y descargamos dependencias (esto optimiza el cache)
COPY pom.xml .
RUN mvn dependency:go-offline -B
# Copiamos el código y compilamos
COPY src ./src
RUN mvn clean package -DskipTests

# Etapa 2: Imagen final ligera
FROM eclipse-temurin:25-jre-jammy
WORKDIR /app
# Creamos un usuario sin privilegios por seguridad (Buena práctica de arquitectura)
RUN addgroup --system spring && adduser --system spring --ingroup spring
USER spring
# Copiamos el JAR generado (asumiendo el nombre del artifact 'discovery')
COPY --from=build /app/target/discovery-*.jar app.jar
# Exponemos el puerto de Eureka
EXPOSE 8761
# Comando para arrancar usando el perfil de docker
ENTRYPOINT ["java", "-Dspring.profiles.active=docker", "-jar", "app.jar"]