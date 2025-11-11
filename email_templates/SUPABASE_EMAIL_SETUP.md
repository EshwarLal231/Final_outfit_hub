# 📧 How to Add Custom Email Template to Supabase

## Step-by-Step Guide to Update OTP Email Design

---

## 🎨 **Your Beautiful Email Template is Ready!**

Location: `email_templates/otp_verification.html`

This template features:
- ✅ Purple gradient matching your app theme (#667eea)
- ✅ Large, clear OTP code display
- ✅ Professional branding with Outfit Hub logo
- ✅ Mobile responsive design
- ✅ Security notices and instructions
- ✅ 10-minute expiry warning
- ✅ Modern, clean UI with gradients and icons

---

## 📝 **How to Use This Template in Supabase**

### **Method 1: Via Supabase Dashboard (Recommended)**

1. **Open the HTML File**
   - Navigate to: `/Users/pervaizahmed/Development/outfit_hub/email_templates/otp_verification.html`
   - Open in your text editor
   - Copy ALL the HTML code (Ctrl+A, Ctrl+C)

2. **Go to Supabase Dashboard**
   - URL: https://supabase.com/dashboard
   - Login to your account
   - Select project: **kovojvgzlzcegidlhmek** (Outfit_hub)

3. **Navigate to Email Templates**
   ```
   Authentication → Email Templates → Confirm Signup
   ```

4. **Paste Your Template**
   - Find the "Confirm signup" template
   - Click "Edit"
   - **Replace** the entire content with your HTML template
   - Make sure `{{ .Token }}` is preserved (this is the OTP placeholder)
   - Click "Save"

5. **Test the Template**
   - Send a test email from Supabase
   - Or signup with a real email in your app
   - Check how it looks!

---

## 🔧 **Template Variables Available**

Supabase provides these variables you can use:

| Variable | Description | Example |
|----------|-------------|---------|
| `{{ .Token }}` | 6-digit OTP code | 123456 |
| `{{ .TokenHash }}` | Hashed token | abc123... |
| `{{ .SiteURL }}` | Your app URL | https://yourapp.com |
| `{{ .ConfirmationURL }}` | Full confirmation link | https://... |
| `{{ .Email }}` | User's email | user@example.com |
| `{{ .RedirectTo }}` | Redirect URL | /home |

**Currently Used:**
- `{{ .Token }}` - Displays the 6-digit verification code

---

## 🎯 **Customization Options**

### **Change Colors to Match Your App:**

Find and replace these color values in the HTML:

**Primary Purple:**
```css
/* Current: #667eea (purple) */
background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);

/* Change to your brand color if different */
```

**Accent Colors:**
```css
/* Warning Yellow */
background-color: #fff8e1; /* Change if needed */
border-left: 4px solid #ffc107;

/* Info Blue */
background-color: #e3f2fd;

/* Security Red */
background-color: #ffebee;
```

### **Change Logo:**

Replace the emoji with your logo:

```html
<!-- Current: Emoji -->
<div class="logo">👔</div>

<!-- Option 1: Your logo image -->
<div class="logo">
    <img src="https://your-cdn.com/logo.png" alt="Outfit Hub" style="width: 60px;">
</div>

<!-- Option 2: Different emoji -->
<div class="logo">🛍️</div> <!-- Shopping bag -->
<div class="logo">👗</div> <!-- Dress -->
<div class="logo">💼</div> <!-- Briefcase -->
```

### **Update Company Info:**

Change footer details:

```html
<p style="margin: 15px 0;">
    <strong>Outfit Hub</strong><br>
    Your trusted marketplace for pre-owned fashion<br>
    <!-- Add your address -->
    123 Fashion Street, Karachi, Pakistan
</p>
```

### **Add Real Social Links:**

Replace `#` with actual URLs:

```html
<div class="social-links">
    <a href="https://facebook.com/outfithub" title="Facebook">📘</a>
    <a href="https://instagram.com/outfithub" title="Instagram">📷</a>
    <a href="https://twitter.com/outfithub" title="Twitter">🐦</a>
    <a href="https://linkedin.com/company/outfithub" title="LinkedIn">💼</a>
</div>
```

---

## 📱 **Preview Before Deploying**

### **Option 1: Browser Preview**
1. Open `otp_verification.html` in Chrome/Safari
2. Replace `{{ .Token }}` with `123456` temporarily
3. See how it looks
4. Test on mobile (Chrome DevTools → Toggle device toolbar)

### **Option 2: Send Test Email**
1. In Supabase Dashboard → Email Templates
2. After pasting your template
3. Click "Send test email"
4. Enter your email
5. Check inbox!

---

## 🚀 **Different Email Templates to Customize**

Supabase has multiple email types you can customize:

### **1. Confirm Signup** (What we just created)
- Sent when user signs up
- Contains OTP code
- Template: `otp_verification.html`

### **2. Magic Link**
- Sent for passwordless login
- Contains clickable link
- Uses `{{ .ConfirmationURL }}`

### **3. Change Email**
- Sent when user changes email
- Confirms new address
- Uses `{{ .Token }}` or `{{ .ConfirmationURL }}`

### **4. Reset Password**
- Sent when user forgets password
- Contains reset link
- Uses `{{ .ConfirmationURL }}`

---

## 🎨 **Quick Copy-Paste for Supabase**

Here's the minimal version if you want something simpler:

```html
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <style>
        body { font-family: Arial, sans-serif; background: #f5f5f5; padding: 20px; }
        .container { max-width: 600px; margin: 0 auto; background: white; border-radius: 12px; overflow: hidden; }
        .header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 40px; text-align: center; color: white; }
        .content { padding: 40px; }
        .otp { font-size: 48px; font-weight: bold; color: #667eea; text-align: center; letter-spacing: 8px; margin: 30px 0; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>👔 Outfit Hub</h1>
            <p>Email Verification</p>
        </div>
        <div class="content">
            <p>Hi there!</p>
            <p>Enter this code in the app to verify your email:</p>
            <div class="otp">{{ .Token }}</div>
            <p style="color: #ff9800;"><strong>⏰ Expires in 10 minutes</strong></p>
        </div>
    </div>
</body>
</html>
```

---

## ✅ **Checklist**

Before deploying:
- [ ] Copied HTML from `otp_verification.html`
- [ ] Logged into Supabase Dashboard
- [ ] Navigated to Authentication → Email Templates
- [ ] Selected "Confirm signup" template
- [ ] Pasted HTML code
- [ ] Verified `{{ .Token }}` is present
- [ ] Customized colors/branding (optional)
- [ ] Clicked "Save"
- [ ] Sent test email to verify
- [ ] Checked email in inbox (and spam)
- [ ] Verified on mobile device

---

## 🔍 **Troubleshooting**

### **Template Not Saving?**
- Check for syntax errors in HTML
- Make sure `{{ .Token }}` syntax is correct
- Try the simpler version first

### **Email Looks Broken?**
- Test in different email clients
- Gmail, Outlook, Apple Mail all render differently
- Stick to basic CSS (no flexbox/grid in email!)

### **Variables Not Working?**
- Use exact syntax: `{{ .Token }}` (with spaces)
- Variables are case-sensitive
- Check Supabase docs for available variables

---

## 📚 **Resources**

- **Email Testing**: https://putsmail.com/
- **HTML Email Guide**: https://www.campaignmonitor.com/css/
- **Supabase Docs**: https://supabase.com/docs/guides/auth/auth-email-templates
- **Email Preview Tool**: https://litmus.com/

---

## 🎯 **Next Steps**

1. **Enable Email Confirmation** (if not done)
   - Authentication → Providers → Email → "Confirm email" ON

2. **Add Custom Templates** (follow steps above)
   - **OTP Verification**: Use `otp_verification.html` for 6-digit code emails
   - **Signup Confirmation**: Use `signup_confirmation.html` for link-based confirmation
   - Authentication → Email Templates → Confirm signup

3. **Test Signup Flow**
   - Run app: `flutter run`
   - Sign up with real email
   - Check beautiful email!
   - Enter OTP code or click confirmation link

4. **Customize Other Templates** (optional)
   - Reset password email
   - Change email confirmation
   - Magic link email

---

**Last Updated**: November 9, 2025  
**Template Version**: 1.0  
**Compatible with**: Supabase Auth v2

**🎨 Enjoy your beautiful branded emails!** 📧✨
