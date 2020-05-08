FROM adoptopenjdk/openjdk13-openj9:jdk-13.0.2_8_openj9-0.18.0-alpine-slim

COPY ./mvnw /app/mvnw
COPY ./pom.xml /app/pom.xml
COPY ./.mvn /app/.mvn
COPY ./src /app/src

WORKDIR /app

RUN ./mvnw clean package

RUN rm -rf /app ~/.mvn

COPY target/kintohub-is-cool-api-*.jar kintohub-is-cool-api.jar
EXPOSE 8080

CMD ["java", "-Dcom.sun.management.jmxremote", "-Xmx128m", "-XX:+IdleTuningGcOnIdle", "-Xtune:virtualized", "-jar", "kintohub-is-cool-api.jar"]
