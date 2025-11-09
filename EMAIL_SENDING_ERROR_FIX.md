# 🔧 Email Sending Error - Quick Fix Guide

## ❌ Error Message:
```
Exception: {"code":"unexpected_failure","message":"Error sending confirmation email"}
```

---

## 🎯 **Root Cause:**
Supabase is unable to send the confirmation email. This happens because:
1. Email confirmation is enabled BUT SMTP is not configured
2. Supabase's default email service has rate limits
3. Email provider (Gmail/Outlook) is blocking the sender

---

## ✅ **SOLUTION 1: Disable Email Confirmation (Quickest Fix)**

### **This allows immediate signup without email verification**

### **Step 1: Go to Supabase Dashboard**
1. Open: https://supabase.com/dashboard
2. Login to your account
3. Select project: **kovojvgzlzcegidlhmek**

### **Step 2: Disable Email Confirmation**
```
Left Sidebar → Authentication → Providers → Email
```

**Find and TURN OFF:**
- ☐ **"Confirm email"** ← Turn this OFF

**Click "Save"**

### **Step 3: Update Your Code**

Your app will now work with regular signup (no email verification needed).

**Change in signup_screen.dart:**
```dart
// BEFORE (with email verification):
final success = await authProvider.signupWithEmailVerification(...)

// AFTER (regular signup):
final success = await authProvider.signup(...)
```

---

## ✅ **SOLUTION 2: Configure SMTP (For Production)**

### **If you want email verification, configure proper SMTP:**

### **Option A: Use Resend (Recommended - Free & Easy)**

1. **Sign up at Resend**:
   - Go to: https://resend.com
   - Free tier: 100 emails/day
   - No credit card required

2. **Get API Key**:
   - Create account → API Keys → Create
   - Copy the API key (starts with `re_`)

3. **Configure in Supabase**:
   ```
   Dashboard → Authentication → Email Settings
   
   SMTP Host: smtp.resend.com
   Port: 587
   Username: resend
   Password: [Your API Key from step 2]
   Sender Email: onboarding@resend.dev
   Sender Name: Outfit Hub
   ```

4. **Save and Test**

---

### **Option B: Use Gmail SMTP**

1. **Enable 2-Step Verification**:
   - Go to Google Account → Security
   - Turn on 2-Step Verification

2. **Create App Password**:
   - Google Account → Security → App Passwords
   - Select "Mail" and generate
   - Copy the 16-character password

3. **Configure in Supabase**:
   ```
   SMTP Host: smtp.gmail.com
   Port: 587
   Username: your-email@gmail.com
   Password: [16-character app password]
   Sender Email: your-email@gmail.com
   Sender Name: Outfit Hub
   ```

**Limitation**: 500 emails per day

---

## ✅ **SOLUTION 3: Use Regular Signup Without Email Verification**

### **Simplest solution - no SMTP needed:**

I can update your code to use regular signup (no email verification).

**Pros:**
- ✅ Works immediately
- ✅ No SMTP configuration needed
- ✅ No email sending issues
- ✅ Users can login right away

**Cons:**
- ❌ No email verification
- ❌ Less secure (users can use fake emails)

**Want me to implement this?** I can modify your signup flow to skip email verification.

---

## 🔍 **Check Current Settings:**

### **Verify in Supabase Dashboard:**

1. **Authentication → Providers → Email**
   - Email provider: ✅ Enabled
   - Confirm email: ❓ Check status
   - Secure email change: (optional)

2. **Authentication → Email Settings**
   - SMTP configured: ❓ Check if filled
   - If empty → That's your problem!

---

## 💡 **My Recommendation:**

### **For Development (Right Now):**
**→ Use SOLUTION 1: Disable email confirmation**
- Fastest way to test your app
- Can add email verification later
- Users can signup immediately

### **For Production (Before Launch):**
**→ Use SOLUTION 2: Configure SMTP with Resend**
- Professional setup
- Better deliverability
- Free tier is sufficient

---

## 🚀 **Quick Action Plan:**

### **Option 1: Skip Email Verification (5 minutes)**
1. Supabase → Authentication → Providers → Email
2. Turn OFF "Confirm email"
3. Save
4. Test signup again
5. ✅ Should work immediately!

### **Option 2: Fix Email Sending (20 minutes)**
1. Sign up at resend.com
2. Get API key
3. Configure SMTP in Supabase
4. Keep "Confirm email" ON
5. Test signup again
6. ✅ Emails will be sent!

---

## 📞 **Need Help?**

Tell me which solution you want:
1. **"Disable email verification"** - I'll update your code
2. **"Setup Resend SMTP"** - I'll guide you step-by-step
3. **"Use Gmail SMTP"** - I'll help configure it

**Which one do you prefer?** 🤔
