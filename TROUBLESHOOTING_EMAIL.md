# 🔧 Email Verification Not Working - Troubleshooting Guide

## ❌ Problem: Email Verification Code Not Received

When you sign up, the email verification screen shows but **no email arrives** at your inbox.

---

## ✅ **SOLUTION: Enable Email Confirmation**

### **Step-by-Step Fix:**

1. **Go to Supabase Dashboard**
   - URL: https://supabase.com/dashboard
   - Login to your account
   - Select project: **kovojvgzlzcegidlhmek** (Outfit_hub)

2. **Navigate to Email Settings**
   ```
   Left Sidebar → Authentication → Providers
   ```

3. **Enable Email Confirmation**
   - Find **Email** in the providers list
   - Look for toggle: **"Confirm email"**
   - **Turn it ON** (it's currently OFF)
   - Click **Save** button

4. **Verify It's Enabled**
   - You should see a green checkmark ✅
   - Status should show "Enabled"

---

## 📋 **Checklist Before Testing**

Make sure these are configured:

### **In Supabase Dashboard:**
- [ ] Authentication → Providers → Email → **"Confirm email" = ON**
- [ ] Authentication → Email Templates → Templates exist
- [ ] Settings → API → Anon key is correct (matches your code)

### **In Your Code:**
- [x] `signupWithEmailVerification()` is being called (already implemented)
- [x] Email verification screen exists (already created)
- [x] Routes configured correctly (already done)

---

## 🧪 **Testing Steps**

1. **Clear Old Attempts**
   - Go to Supabase Dashboard → Authentication → Users
   - Delete test user: `pervaizahmef.uk@gmail.com`
   - This removes any pending verifications

2. **Run the App**
   ```bash
   cd /Users/pervaizahmed/Development/outfit_hub
   flutter run
   ```

3. **Test Signup**
   - Fill out the signup form
   - Use a **real email** you can access
   - Click "Create Account"
   - Should show: "Verification code sent to your email!"

4. **Check Email**
   - Check inbox (wait 1-2 minutes)
   - **Check SPAM/JUNK folder** (very important!)
   - Look for email from: `noreply@mail.app.supabase.io`
   - Subject: "Confirm your signup"

5. **Enter Verification Code**
   - Copy the 6-digit code from email
   - Enter it in the app
   - Click "Verify Email"
   - Should navigate to home screen

---

## 🐛 **Common Issues & Solutions**

### **1. Still No Email After Enabling?**

**Check Spam Folder:**
- Gmail: Check "Spam" and "Promotions" tabs
- Outlook: Check "Junk Email" folder
- Yahoo: Check "Spam" folder

**Wait Time:**
- Emails can take 1-3 minutes to arrive
- Be patient before clicking "Resend"

**Rate Limiting:**
- Supabase free tier: 3-4 emails per hour
- Wait 15-20 minutes between attempts
- Don't spam "Resend Code"

---

### **2. Email Goes to Spam?**

**Add to Safe Senders:**
- Add `noreply@mail.app.supabase.io` to contacts
- Mark as "Not Spam" in your email client

**For Production:**
- Set up custom SMTP (SendGrid, Mailgun)
- Use your own domain email
- Better deliverability

---

### **3. Wrong Email Sent?**

**Verify in Supabase Dashboard:**
```
Authentication → Users → Find your user → Check email address
```

**Check Your Code:**
```dart
// In signup_screen.dart line 101
email: _emailController.text.trim(), // ✅ Should be trimmed
```

---

### **4. Code Expired Error?**

**Default Expiry:**
- Verification codes expire in **10 minutes**
- Don't wait too long to enter code

**Solution:**
- Click "Resend Code" button
- Enter new code immediately
- Codes are single-use only

---

## 📧 **Email Template Preview**

You should receive an email like this:

```
From: noreply@mail.app.supabase.io
Subject: Confirm your signup

Hi,

Follow this link to confirm your user:
[Confirmation Link]

Or enter this code: 123456

This code expires in 10 minutes.
```

---

## 🔍 **Debug: Check Supabase Logs**

1. Go to Supabase Dashboard
2. Click **Logs** in left sidebar
3. Select **Auth Logs**
4. Look for:
   ```
   ✅ user.signup - Success
   ✅ email.signup - Email sent
   ❌ email.signup - Failed to send
   ```

If you see "Failed to send", there's an SMTP configuration issue.

---

## 🎯 **Quick Test Command**

Test if Supabase is working:

```bash
# In your terminal
flutter run
```

Then in the app:
1. Go to Signup screen
2. Fill form with REAL email
3. Click "Create Account"
4. Watch terminal for logs:
   ```
   ✅ Success: Email sent
   ❌ Error: AuthException - Email not confirmed
   ```

---

## 🚀 **After Email Verification Works**

Once you successfully receive and verify an email:

1. **User is created** in Supabase Auth
2. **Email is confirmed**
3. **Profile created** in users table
4. **Redirected to home screen**
5. **Can login** without verification again

---

## 📞 **Still Not Working?**

### **Check These:**

**1. Supabase Project Status**
```
Dashboard → Settings → General → Project Status
Should be: Active ✅
```

**2. Email Provider Enabled**
```
Authentication → Providers → Email
Status: Enabled ✅
Confirm email: ON ✅
```

**3. Your Internet Connection**
- App needs internet to call Supabase API
- Supabase needs internet to send emails

**4. Correct Credentials**
```dart
// lib/config/supabase_config.dart
supabaseUrl: 'https://kovojvgzlzcegidlhmek.supabase.co' ✅
supabaseAnonKey: 'eyJhbG...' ✅
```

---

## 💡 **Alternative: Use Phone OTP Instead**

If email continues to fail, you can switch to SMS OTP:

1. Supabase supports Twilio SMS
2. Change to phone verification
3. User receives SMS code instead

**Want to implement phone OTP? Let me know!**

---

## 📚 **Related Documentation**

- Supabase Email Auth: https://supabase.com/docs/guides/auth/auth-email
- Email Templates: https://supabase.com/docs/guides/auth/auth-email-templates
- SMTP Setup: https://supabase.com/docs/guides/auth/auth-smtp

---

**Last Updated**: November 9, 2025  
**Status**: Email confirmation needs to be enabled in Supabase Dashboard

**🎯 ACTION REQUIRED: Go enable "Confirm email" in Supabase NOW!**
