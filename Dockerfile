FROM frappe/bench:latest

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3.10 \
    python3-pip \
    mariadb-client \
    redis-tools \
    wkhtmltopdf \
    fonts-cantarell \
    xvfb \
    libfontconfig \
    libxrender1 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /home/frappe/frappe-bench

# Initialize bench with all requirements
RUN bench init --skip-redis-config-generation --skip-assets --python python3 && \
    bench setup requirements --dev

# Get and install required apps with their dependencies
RUN bench get-app --branch version-15 erpnext && \
    bench get-app --branch main helpdesk && \
    bench get-app --branch version-15 hrms && \
    bench get-app --branch master wiki && \
    bench get-app --branch version-16 payments && \
    bench get-app --branch master twilio_integration && \
    bench get-app https://github.com/ONE-F-M/One-FM.git && \
    bench setup requirements

# Install node dependencies
RUN bench setup env && \
    bench build

# Setup production config
RUN bench setup production frappe

# Create new site and install apps
COPY ./docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["bench", "start"]