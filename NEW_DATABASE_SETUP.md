# 🗄️ New Database Setup Guide

## ✅ Database Connection Updated!

Your Outfit Hub app is now connected to the new Supabase database.

---

## 📋 **New Database Details:**

| Setting | Value |
|---------|-------|
| **Project URL** | https://necvuqmmrrfmtlubateu.supabase.co |
| **Project Reference** | necvuqmmrrfmtlubateu |
| **Database Password** | Database@23@123 |
| **Anon API Key** | eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9... |
| **Configuration File** | `lib/config/supabase_config.dart` ✅ Updated |

---

## 🚀 **CRITICAL: Setup Required Before Running App**

### **Step 1: Create Database Tables** ⚠️ REQUIRED

You need to run the SQL schema in your new Supabase database:

1. **Go to Supabase Dashboard:**
   - https://supabase.com/dashboard/project/necvuqmmrrfmtlubateu

2. **Navigate to SQL Editor:**
   - Click **SQL Editor** in left sidebar
   - Click **New Query**

3. **Run the Schema:**
   - Open file: `/Users/pervaizahmed/Development/outfit_hub/supabase_schema.sql`
   - Copy ALL the SQL content
   - Paste into SQL Editor
   - Click **Run** (or press Cmd+Enter)

**Expected Tables Created:**
- ✅ users
- ✅ products
- ✅ orders
- ✅ favorites
- ✅ categories

---

### **Step 2: Enable Email Authentication** 📧

1. **Go to Authentication Settings:**
   ```
   Dashboard → Authentication → Providers
   ```

2. **Enable Email Provider:**
   - Find **Email** in the providers list
   - Toggle **"Enable Email provider"** to **ON**
   - Toggle **"Confirm email"** to **ON** (for OTP verification)
   - Click **Save**

3. **Configure Email Templates (Optional):**
   ```
   Authentication → Email Templates → Confirm signup
   ```
   - Paste content from `email_templates/otp_verification.html`
   - Click **Save**

---

### **Step 3: Create Storage Buckets** 📦

For product and profile images:

1. **Go to Storage:**
   ```
   Dashboard → Storage → Create a new bucket
   ```

2. **Create Product Images Bucket:**
   - Name: `product-images`
   - Public bucket: **Yes** ✅
   - Click **Create**

3. **Create Profile Images Bucket:**
   - Name: `profile-images`
   - Public bucket: **Yes** ✅
   - Click **Create**

---

### **Step 4: Configure Row Level Security (RLS)** 🔒

For each table, enable RLS and add policies:

#### **Users Table:**
```sql
-- Enable RLS
ALTER TABLE users ENABLE ROW LEVEL SECURITY;

-- Policy: Users can read their own data
CREATE POLICY "Users can view own data" ON users
  FOR SELECT
  USING (auth.uid() = id);

-- Policy: Users can update their own data
CREATE POLICY "Users can update own data" ON users
  FOR UPDATE
  USING (auth.uid() = id);

-- Policy: Public can view user profiles (for marketplace)
CREATE POLICY "Public can view user profiles" ON users
  FOR SELECT
  USING (true);
```

#### **Products Table:**
```sql
-- Enable RLS
ALTER TABLE products ENABLE ROW LEVEL SECURITY;

-- Policy: Anyone can view products
CREATE POLICY "Anyone can view products" ON products
  FOR SELECT
  USING (true);

-- Policy: Sellers can insert their own products
CREATE POLICY "Sellers can insert products" ON products
  FOR INSERT
  WITH CHECK (auth.uid() = seller_id);

-- Policy: Sellers can update their own products
CREATE POLICY "Sellers can update own products" ON products
  FOR UPDATE
  USING (auth.uid() = seller_id);

-- Policy: Sellers can delete their own products
CREATE POLICY "Sellers can delete own products" ON products
  FOR DELETE
  USING (auth.uid() = seller_id);
```

#### **Orders Table:**
```sql
-- Enable RLS
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;

-- Policy: Buyers can view their orders
CREATE POLICY "Buyers can view own orders" ON orders
  FOR SELECT
  USING (auth.uid() = buyer_id);

-- Policy: Sellers can view orders for their products
CREATE POLICY "Sellers can view orders for their products" ON orders
  FOR SELECT
  USING (auth.uid() = seller_id);

-- Policy: Buyers can create orders
CREATE POLICY "Buyers can create orders" ON orders
  FOR INSERT
  WITH CHECK (auth.uid() = buyer_id);
```

#### **Favorites Table:**
```sql
-- Enable RLS
ALTER TABLE favorites ENABLE ROW LEVEL SECURITY;

-- Policy: Users can view their favorites
CREATE POLICY "Users can view own favorites" ON favorites
  FOR SELECT
  USING (auth.uid() = user_id);

-- Policy: Users can add favorites
CREATE POLICY "Users can add favorites" ON favorites
  FOR INSERT
  WITH CHECK (auth.uid() = user_id);

-- Policy: Users can remove favorites
CREATE POLICY "Users can delete favorites" ON favorites
  FOR DELETE
  USING (auth.uid() = user_id);
```

---

### **Step 5: Storage Bucket Policies** 🖼️

#### **Product Images Bucket:**
```sql
-- Allow public read access
CREATE POLICY "Public read access" ON storage.objects
  FOR SELECT
  USING (bucket_id = 'product-images');

-- Allow authenticated users to upload
CREATE POLICY "Authenticated users can upload" ON storage.objects
  FOR INSERT
  WITH CHECK (
    bucket_id = 'product-images' 
    AND auth.role() = 'authenticated'
  );

-- Allow users to delete their own images
CREATE POLICY "Users can delete own images" ON storage.objects
  FOR DELETE
  USING (
    bucket_id = 'product-images' 
    AND auth.uid() = owner
  );
```

#### **Profile Images Bucket:**
```sql
-- Allow public read access
CREATE POLICY "Public read access" ON storage.objects
  FOR SELECT
  USING (bucket_id = 'profile-images');

-- Allow users to upload their profile images
CREATE POLICY "Users can upload profile images" ON storage.objects
  FOR INSERT
  WITH CHECK (
    bucket_id = 'profile-images' 
    AND auth.role() = 'authenticated'
  );

-- Allow users to delete their own profile images
CREATE POLICY "Users can delete own profile images" ON storage.objects
  FOR DELETE
  USING (
    bucket_id = 'profile-images' 
    AND auth.uid() = owner
  );
```

---

## 🧪 **Test the Connection**

After completing the setup:

```bash
cd /Users/pervaizahmed/Development/outfit_hub
flutter clean
flutter pub get
flutter run
```

**Test Checklist:**
- [ ] App starts without errors
- [ ] Can navigate to signup screen
- [ ] Can create account
- [ ] Email OTP arrives
- [ ] Can verify email with OTP code
- [ ] User profile created in database
- [ ] Can login with credentials
- [ ] Can view home screen

---

## 🔧 **Troubleshooting**

### **Error: "relation 'users' does not exist"**
**Solution:** Run `supabase_schema.sql` in SQL Editor

### **Error: "Email not configured"**
**Solution:** Enable Email provider in Authentication → Providers

### **Error: "Storage bucket not found"**
**Solution:** Create storage buckets as described in Step 3

### **Error: "Permission denied for table users"**
**Solution:** Add RLS policies as described in Step 4

---

## 📊 **Verify Setup**

### **Check Tables:**
```sql
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public';
```

Expected result:
```
users
products
orders
favorites
categories
```

### **Check Authentication:**
```
Dashboard → Authentication → Users
```
Should show empty list (ready to accept signups)

### **Check Storage:**
```
Dashboard → Storage
```
Should show:
- product-images (public)
- profile-images (public)

---

## 🎯 **Next Steps After Setup**

1. **Test Signup Flow:**
   - Create account with email verification
   - Verify OTP works
   - Check user appears in Authentication → Users

2. **Test Product Listing:**
   - Sellers can add products
   - Images upload to storage
   - Products appear in marketplace

3. **Test Orders:**
   - Buyers can place orders
   - Sellers receive order notifications
   - Order status updates work

---

## 📝 **Important Notes**

⚠️ **Database Password:** `Database@23@123`
- Use this for direct database connections (PostgreSQL)
- Not needed for Supabase client (uses API key)

⚠️ **API Keys:**
- **Anon Key:** Already configured in app ✅
- **Service Role Key:** Only use server-side (NEVER in app!)

⚠️ **Security:**
- RLS (Row Level Security) is **CRITICAL** for data protection
- Always test policies before going to production
- Users can only access their own data

---

## 🔗 **Quick Links**

- **Dashboard:** https://supabase.com/dashboard/project/necvuqmmrrfmtlubateu
- **SQL Editor:** https://supabase.com/dashboard/project/necvuqmmrrfmtlubateu/sql
- **Authentication:** https://supabase.com/dashboard/project/necvuqmmrrfmtlubateu/auth/users
- **Storage:** https://supabase.com/dashboard/project/necvuqmmrrfmtlubateu/storage/buckets
- **API Settings:** https://supabase.com/dashboard/project/necvuqmmrrfmtlubateu/settings/api

---

**Last Updated:** November 10, 2025  
**Status:** Database credentials updated ✅  
**Action Required:** Complete setup steps above before running app

**🎉 Your app is ready to connect to the new database!**
