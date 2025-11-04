#!/bin/bash
set -e  # Exit on any error

echo "Starting blog generation process..."

# Clone or update repo
if [ -d "blog" ]; then
    echo "Blog directory exists, updating repository..."
    cd blog
    git pull
    cd ..
else
    echo "Cloning blog repository..."
    git clone https://github.com/jgasteiz/blog.git
fi

cd blog

# Create venv if it doesn't exist
if [ ! -d "env" ]; then
    echo "Creating Python virtual environment..."
    python -m venv env
fi

echo "Activating virtual environment..."
source ./env/bin/activate

echo "Installing Python dependencies..."
pip install -r requirements.txt

echo "Installing Node.js dependencies..."
yarn install

echo "Building site with yarn..."
yarn build

echo "Generating blog content..."
make generate

echo "Blog generation complete!"

echo "Copying generated files to output directory..."
cp -r public/* /output/
echo "Files copied to /output successfully!"
