#!/bin/bash

# Script to build and deploy iOS app
# Usage: ./build_and_deploy_ios.sh

set -e  # Exit on error

echo "Cleaning Flutter build..."
flutter clean

echo "Getting Flutter dependencies..."
flutter pub get

echo "Building IPA..."
flutter build ipa --release --export-method development

echo "Deploying to device..."
ios-deploy --bundle build/ios/ipa/test_text_field.ipa

echo "Done!"

