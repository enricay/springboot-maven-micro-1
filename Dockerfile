FROM openjdk:8
COPY target/springboot-maven-course-micro-svc-0.0.1-SNAPSHOT.jar app-V$BUILD_NUMBER:$BUILD_TIMESTAMP.jar
ENTRYPOINT ["java","-jar","/app-V$BUILD_NUMBER:$BUILD_TIMESTAMP.jar"]
