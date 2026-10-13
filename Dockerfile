FROM alpine:latest

# Install necessary dependencies
RUN apk add --no-cache ca-certificates unzip libstdc++

# Download latest PocketBase binary
ADD https://github.com/pocketbase/pocketbase/releases/download/v0.22.20/pocketbase_0.22.20_linux_amd64.zip /tmp/pb.zip
RUN unzip /tmp/pb.zip -d /pb/ && rm /tmp/pb.zip

# Create a dedicated non-root user
RUN adduser -D pbuser
RUN mkdir -p /pb_data && chown -R pbuser:pbuser /pb_data /pb

# Switch to the non-root user
USER pbuser

EXPOSE 8080
CMD ["/pb/pocketbase", "serve", "--http=0.0.0.0:8080", "--dir=/pb_data"]