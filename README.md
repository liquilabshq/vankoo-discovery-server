# Vankoo Discovery Server

Este microservicio actúa como el Service Registry de la arquitectura de **Vankoo**. Utiliza **Netflix Eureka** para permitir que todos los servicios (IAM, Invoicing, Finance, etc.) se encuentren entre sí dinámicamente sin necesidad de configurar IPs estáticas.

## Requisitos Previos

* **Java:** 25 (Temurin recomendado)
* **Maven:** 3.9+
* **Docker & Docker Compose**

## Instalación y Compilación

Para generar el artefacto ejecutable (JAR), corre el siguiente comando en la raíz de este proyecto:

```bash
mvn clean package -DskipTests
```

El archivo generado se ubicará en `target/discovery-server-0.0.1-SNAPSHOT.jar`.

## Ejecución Local

Puedes ejecutar el servicio localmente desde IntelliJ, pero su configuración está optimizada para correr dentro de Docker. Si deseas ejecutarlo localmente, asegúrate de configurar el perfil `dev` para cargar la configuración adecuada

## Uso con Docker

Este servicio está diseñado para integrarse con el repositorio `vankoo-infra`.

1. Si ya tenías contenedores de vankoo-infra, levanta solo el Discovery Server en el repositorio de infraestructura:

    ```bash
    docker compose up --build discovery-server
    ```

2. Si es la primera vez que levantas vankoo-infra, simplemente corre en vankoo-infra:

    ```bash
    docker compose up --build
    ```
   
## Endpoints de Utilidad

Una vez iniciado, puedes acceder a:

- **Dashboard de Eureka:** `http://localhost:8761/` para ver los servicios registrados.
- **Health Check:** `http://localhost:8761/actuator/health` para verificar que el servicio esté funcionando correctamente.

## Perfiles de Configuración

El proyecto utiliza perfiles para separar entornos:

- **dev:** Configuración para desarrollo local.
- **docker:** Configuración optimizada para correr dentro de Docker, con ajustes de red y puertos.

## Notas de Desarrollo

- **Self-Preservation:** En el perfil `dev/docker`, el modo de autopreservación está desactivado. Esto permite que Eureka limpie instantáneamente los servicios que se desconectan durante las pruebas. No te asustes por el mensaje en rojo en el dashboard, es normal en este modo.
- **Healthcheck:** El contenedor Docker utiliza `curl` para reportar su estado. Si el status es `unhealthy`, verifica que el servicio haya terminado de arrancar correctamente (toma ~20-30s).