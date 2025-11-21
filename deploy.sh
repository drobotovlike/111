#!/bin/bash

# ATURE Studio Deployment Script
echo "🚀 Building ATURE Studio for production..."
npm run build

if [ $? -eq 0 ]; then
    echo "✅ Build successful!"
    echo ""
    echo "Choose deployment method:"
    echo "1. Deploy to Vercel (recommended)"
    echo "2. Deploy to Netlify"
    echo "3. Just build (no deploy)"
    echo ""
    read -p "Enter choice (1-3): " choice
    
    case $choice in
        1)
            echo "📦 Deploying to Vercel..."
            vercel --prod
            ;;
        2)
            echo "📦 Deploying to Netlify..."
            netlify deploy --prod
            ;;
        3)
            echo "✅ Build complete. Ready to deploy manually."
            ;;
        *)
            echo "Invalid choice. Build complete."
            ;;
    esac
else
    echo "❌ Build failed. Please fix errors and try again."
    exit 1
fi

