FROM alpine as kotlin-install

ENV KOTLIN_VERSION=1.6.10

# https://kotlinlang.org/docs/command-line.html#sdkman
RUN apk --no-cache add bash curl git zip && \
  curl -s "https://get.sdkman.io" | bash && \
  bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && sdk install kotlin $KOTLIN_VERSION"

FROM openjdk:11-jre-slim

COPY --from=kotlin-install /root/.sdkman/candidates/kotlin/current /kotlin
ENV PATH=/kotlin/bin/:$PATH
