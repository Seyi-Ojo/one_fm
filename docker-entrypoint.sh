#!/bin/bash

cd /home/frappe/frappe-bench

# Wait for database to be ready
until mysql -h$FRAPPE_DATABASE_HOST -uroot -p$DB_ROOT_PASSWORD -e "show databases;" &> /dev/null
do
    echo "Waiting for database connection..."
    sleep 5
done

# Create new site if it doesn't exist
if [ ! -f "sites/$SITE_NAME/site_config.json" ]; then
    # Create new site
    bench new-site "$SITE_NAME" \
        --mariadb-root-password "$DB_ROOT_PASSWORD" \
        --admin-password "$ADMIN_PASSWORD" \
        --no-mariadb-socket

    # Install all apps
    bench --site "$SITE_NAME" install-app erpnext
    bench --site "$SITE_NAME" install-app helpdesk
    bench --site "$SITE_NAME" install-app hrms
    bench --site "$SITE_NAME" install-app wiki
    bench --site "$SITE_NAME" install-app payments
    bench --site "$SITE_NAME" install-app twilio_integration
    bench --site "$SITE_NAME" install-app one_fm

    # Build assets
    bench --site "$SITE_NAME" build
    
    # Set site as default
    bench use "$SITE_NAME"

    # Additional setup if needed
    bench --site "$SITE_NAME" set-config developer_mode 1
    bench --site "$SITE_NAME" clear-cache
fi

# Migrate all apps
bench --site "$SITE_NAME" migrate

# Start the application
exec "$@" 