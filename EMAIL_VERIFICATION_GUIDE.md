# Email Verification (2FA) Setup Guide

## Overview
This app now includes **Email-based Two-Factor Authentication (2FA)** during user signup. When users create an account, they receive a 6-digit verification code to their email address.

## How It Works

### 1. User Signup Flow
1. User fills out the signup form with:
   - Full Name
   - Email
   - Phone Number
   - City
   - Role (Buyer/Seller/Both)
   - Password

2. After submitting the form:
   - Account is created in Supabase Auth
   - A 6-digit verification code is sent to the user's email
   - User is redirected to the Email Verification screen

3. Email Verification:
   - User enters the 6-digit code from their email
   - Code auto-verifies when all 6 digits are entered
   - Upon successful verification, user can login

### 2. Features

#### ✅ Security Features
- **Email Verification Required**: Users must verify their email before accessing the app
- **OTP (One-Time Password)**: 6-digit code sent to email
- **Code Expiration**: Verification codes expire after 10 minutes
- **Resend Functionality**: Users can request a new code after 60 seconds
- **Auto-fill Detection**: Automatically verifies when all 6 digits are entered

#### 🎨 UI Features
- **Clean 6-Digit Input**: Individual input boxes for each digit
- **Auto-focus**: Automatically moves to next input box
- **Real-time Validation**: Immediate feedback on incorrect codes
- **Countdown Timer**: Shows when user can resend the code
- **Error Handling**: Clear error messages for invalid codes

## Supabase Configuration

### Enable Email Confirmation
1. Go to your Supabase Dashboard
2. Navigate to **Authentication** → **Providers**
3. Find **Email** provider
4. **Enable "Confirm email"** option
5. Save changes

### Email Templates (Optional)
You can customize the email template:
1. Go to **Authentication** → **Email Templates**
2. Select **Confirm signup**
3. Customize the subject and body
4. Use `{{ .Token }}` for the verification code
5. Use `{{ .SiteURL }}` for your app URL

### Default Template
```
Subject: Verify your email for Outfit Hub

Hi,

Thank you for signing up! Please use the following code to verify your email:

{{ .Token }}

This code will expire in 10 minutes.

If you didn't request this, please ignore this email.

Best regards,
Outfit Hub Team
```

## Code Structure

### New Files Added
```
lib/
├── screens/
│   └── auth/
│       └── email_verification_screen.dart  # Email OTP verification UI
└── services/
    └── auth_service.dart                   # Updated with OTP methods
```

### Key Methods in AuthService

#### 1. Signup with Email Verification
```dart
Future<Map<String, dynamic>> signupWithEmailVerification({
  required String name,
  required String email,
  required String password,
  required String phone,
  required String location,
  String role = 'buyer',
})
```

#### 2. Verify Email OTP
```dart
Future<bool> verifyEmailOTP({
  required String email,
  required String token,
})
```

#### 3. Resend Email OTP
```dart
Future<void> resendEmailOTP({
  required String email,
})
```

## Testing

### Test the Email Verification Flow

1. **Start the App**
   ```bash
   flutter run
   ```

2. **Create a Test Account**
   - Go to Signup screen
   - Fill in all required fields
   - Use a real email address (to receive the code)
   - Click "Create Account"

3. **Verify Email**
   - Check your email inbox for the verification code
   - Enter the 6-digit code in the verification screen
   - Code should auto-verify when complete

4. **Test Resend**
   - Wait 60 seconds
   - Click "Resend Code"
   - New code will be sent to email

### Test Email Providers

For development/testing, you can use:
- **Gmail**: Regular Gmail account
- **Temp Mail**: https://temp-mail.org (temporary email)
- **Mailtrap**: https://mailtrap.io (email testing service)

## Troubleshooting

### Issue: Not Receiving Verification Email

**Solutions:**
1. Check spam/junk folder
2. Verify email confirmation is enabled in Supabase
3. Check Supabase logs for email sending errors
4. Ensure email address is valid

### Issue: "Invalid verification code"

**Solutions:**
1. Ensure you're using the latest code (codes expire in 10 minutes)
2. Check for typos in the code
3. Request a new code using "Resend"

### Issue: Can't resend code

**Solutions:**
1. Wait for the countdown timer to reach 0
2. The resend button is disabled for 60 seconds to prevent spam

## Security Best Practices

### Implemented
✅ Email verification required for all signups
✅ OTP codes expire after 10 minutes
✅ Rate limiting on resend (60 second cooldown)
✅ Secure token validation via Supabase Auth
✅ No sensitive data stored in app state

### Recommended
- [ ] Implement account lockout after multiple failed attempts
- [ ] Add IP-based rate limiting
- [ ] Monitor for suspicious signup patterns
- [ ] Implement CAPTCHA for signup form

## Future Enhancements

### Planned Features
- [ ] SMS-based OTP as alternative
- [ ] Social authentication (Google, Facebook)
- [ ] Biometric authentication
- [ ] Remember device functionality
- [ ] Email change verification

## Support

For issues or questions:
1. Check Supabase Dashboard logs
2. Review this documentation
3. Contact the development team

---

**Last Updated**: November 2025
**Version**: 2.0.0
