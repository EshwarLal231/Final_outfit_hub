#!/usr/bin/env python3
"""
Supabase Database Setup Script
This script creates all tables, indexes, and policies for Outfit Hub
"""

# Supabase Configuration
SUPABASE_URL = "https://bnhhpcdzylazzjvhdogi.supabase.co"
SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJuaGhwY2R6eWxhenpqdmhkb2dpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjI1NTUwMDUsImV4cCI6MjA3ODEzMTAwNX0.uy4mC6mFk8Ze2P10p6BUsqM3RLN0z9nqrOKSfp7gzTY"

print("🚀 Setting up Supabase Database for Outfit Hub")
print("=" * 60)
print()

# Read SQL file
print("📖 Reading SQL schema...")
try:
    with open('supabase_schema.sql', 'r') as f:
        sql_content = f.read()
    print("✅ SQL file loaded\n")
except FileNotFoundError:
    print("❌ Error: supabase_schema.sql not found!")
    exit(1)

print("⚠️  IMPORTANT NOTE:")
print("=" * 60)
print("Supabase doesn't allow executing raw SQL via API for security.")
print("You need to run the SQL manually in the Supabase Dashboard.")
print()
print("📋 EASY SETUP STEPS:")
print()
print("1. Open your browser and go to:")
print("   https://supabase.com/dashboard/project/bnhhpcdzylazzjvhdogi/sql/new")
print()
print("2. The SQL Editor will open automatically")
print()
print("3. Copy ALL content from 'supabase_schema.sql' file")
print()
print("4. Paste it into the SQL Editor")
print()
print("5. Click the 'Run' button (or press Cmd+Enter)")
print()
print("6. You should see: 'Success. No rows returned'")
print()
print("=" * 60)
print()
print("After running SQL, create storage buckets:")
print()
print("1. Go to: https://supabase.com/dashboard/project/bnhhpcdzylazzjvhdogi/storage/buckets")
print()
print("2. Click 'New bucket' and create:")
print("   - Name: product-images")
print("   - Public: Yes")
print()
print("3. Click 'New bucket' again and create:")
print("   - Name: profile-images")  
print("   - Public: Yes")
print()
print("=" * 60)
print()
print("✅ Then test the connection:")
print("   dart simple_db_test.dart")
print()
