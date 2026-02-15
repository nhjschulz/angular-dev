FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

# Optional: choose Node major and Angular CLI version via build-args
ARG NODE_MAJOR=24

# Install runtime deps
RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
	   ca-certificates \
	   curl \
	   build-essential \
	   git \
	   python3 \
	   sudo \
	   adduser \
	   gnupg \
	   dos2unix \
	   lsb-release

# Install Node.js LTS and Angular CLI
run curl -fsSL https://deb.nodesource.com/setup_${NODE_MAJOR}.x | bash - \
	&& apt-get install -y --no-install-recommends nodejs \
	&& npm install -g @angular/cli \
	&& npm cache clean --force

# Cleanup build dependencies and apt cache to reduce image size
run apt-get remove --purge -y gnupg lsb-release \
	&& apt-get autoremove -y \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Prepare workspace and entrypoint for runtime user creation
RUN mkdir -p /workspace
WORKDIR /workspace

# Copy entrypoint which will create the developer user at container start
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN dos2unix /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Expose default Angular dev server port
EXPOSE 4200

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["bash"]

