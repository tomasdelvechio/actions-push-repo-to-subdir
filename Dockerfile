FROM alpine:latest

LABEL repository="https://github.com/tomasdelvechio/actions-push-repo-to-subdir"
LABEL homepage="https://github.com/tomasdelvechio/actions-push-repo-to-subdir"
LABEL maintainer="Tomas Delvechio <tomasdelvechio17+github@gmail.com>"

LABEL com.github.actions.name="GitHub Action to Sync Repo to Another Repo like subdirectory"
LABEL com.github.actions.description="Automatically push repository content to another repo, but like sub dir in the target repository"

RUN apk add bash && \
    apk add git

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
