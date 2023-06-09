FROM openjdk:11

EXPOSE 5000

# jar present in target/docker-demo.jar will be mapped to container as docker-demo-jar
ADD target/docker-demo.jar docker-demo.jar

# entrypoint kinda says how to run the application
ENTRYPOINT ["java", "-jar", "docker-demo.jar"]