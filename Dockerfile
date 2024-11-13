FROM gradle:8.6.0-jdk17 as local

WORKDIR /app
RUN ./gradlew build -x test --no-daemon || return 0
RUN gradle --no-daemon --warning-mode all

COPY gradlew /app/gradlew
COPY gradle /app/gradle
COPY build.gradle /app/build.gradle
COPY settings.gradle /app/settings.gradle

COPY src /app/src
COPY entry.sh /app/entry.sh

RUN chmod 777 /app/entry.sh
RUN chmod 777 /app/gradlew

# Define the command to run the application
ENTRYPOINT ["bash","/app/entry.sh"]