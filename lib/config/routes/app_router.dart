import 'package:go_router/go_router.dart';
import '../../screens/splash/splash_screen.dart';
import '../../screens/auth/login_screen.dart';
import '../../screens/auth/signup_screen.dart';
import '../../screens/auth/email_verification_screen.dart';
import '../../screens/auth/mfa_setup_screen.dart';
import '../../screens/auth/mfa_verify_screen.dart';
import '../../screens/admin/admin_dashboard_screen.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/buyer/browse_screen.dart';
import '../../screens/seller/seller_dashboard_screen.dart';
import '../../screens/seller/add_product_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      // Splash Screen
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),

      // Authentication Routes
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        name: 'signup',
        builder: (context, state) => const SignupScreen(),
      ),
      
      // Email Verification Route
      GoRoute(
        path: '/email-verification',
        name: 'email-verification',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return EmailVerificationScreen(
            email: extra['email'] as String,
            password: extra['password'] as String,
            name: extra['name'] as String,
            phone: extra['phone'] as String,
            location: extra['location'] as String,
            role: extra['role'] as String,
          );
        },
      ),

      // MFA (Two-Factor Authentication) Routes
      GoRoute(
        path: '/mfa-setup',
        name: 'mfa-setup',
        builder: (context, state) => const MFASetupScreen(),
      ),
      GoRoute(
        path: '/mfa-verify',
        name: 'mfa-verify',
        builder: (context, state) {
          final factorId = state.uri.queryParameters['factorId'] ?? '';
          final challengeId = state.uri.queryParameters['challengeId'] ?? '';
          return MFAVerifyScreen(
            factorId: factorId,
            challengeId: challengeId,
          );
        },
      ),

      // User Home
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),

      // Admin Routes
      GoRoute(
        path: '/admin',
        name: 'admin',
        builder: (context, state) => const AdminDashboardScreen(),
      ),

      // Browse/Shop Routes
      GoRoute(
        path: '/browse',
        name: 'browse',
        builder: (context, state) => const BrowseScreen(),
      ),

      // Seller Routes
      GoRoute(
        path: '/seller/dashboard',
        name: 'seller-dashboard',
        builder: (context, state) => const SellerDashboardScreen(),
      ),
      GoRoute(
        path: '/seller/add-product',
        name: 'add-product',
        builder: (context, state) => const AddProductScreen(),
      ),
    ],
  );
}
