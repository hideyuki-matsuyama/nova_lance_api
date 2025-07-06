#!/bin/bash -e

echo "Starting startup script as: $(whoami)"

# Test Docker access
echo "Testing Docker access..."
if docker version; then
  echo "Docker access OK"
else
  echo "Docker access failed"
  echo "Groups: $(groups)"
  ls -la /var/run/docker.sock
fi

# Install act
echo "Installing act..."
curl -s https://raw.githubusercontent.com/nektos/act/master/install.sh | bash

# Setup scripts
echo "Setting up scripts..."
chmod +x bin/generate_insomnia_env.sh
/rails_api/bin/generate_insomnia_env.sh

# Clean up pid file
echo "Cleaning up pid files..."
rm -f tmp/pids/server.pid

# Start Rails server
echo "Starting Rails server..."
exec bin/thrust bin/rails server -b 0.0.0.0 -p 3001
