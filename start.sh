#!/bin/bash

echo ""
echo "Restoring frontend npm packages"
echo ""
cd frontend
npm install
if [ 2 -ne 0 ]; then
    echo "Failed to restore frontend npm packages"
    exit 1
fi

echo ""
echo "Building frontend"
echo ""
npm run build
if [ 1 -ne 0 ]; then
    echo "Failed to build frontend"
    exit 1
fi

cd ..
. ./scripts/loadenv.sh

echo ""
echo "Starting backend"
echo ""
./.venv/bin/python -m quart run --port=50505 --host=127.0.0.1 --reload
if [ 1 -ne 0 ]; then
    echo "Failed to start backend"
    exit 1
fi
