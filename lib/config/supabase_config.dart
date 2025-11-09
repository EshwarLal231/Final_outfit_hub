import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  // Supabase credentials
  static const String supabaseUrl = 'https://necvuqmmrrfmtlubateu.supabase.co';
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5lY3Z1cW1tcnJmbXRsdWJhdGV1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjI3MjYxMDEsImV4cCI6MjA3ODMwMjEwMX0.N8s-Jupm1g3HIFRya04_mtAXGFEy4kc_ZliM8sb3mCI';

  // Initialize Supabase
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
      authOptions: const FlutterAuthClientOptions(
        authFlowType: AuthFlowType.pkce,
      ),
    );
  }

  // Get Supabase client instance
  static SupabaseClient get client => Supabase.instance.client;

  // Get current user
  static User? get currentUser => client.auth.currentUser;

  // Check if user is logged in
  static bool get isLoggedIn => currentUser != null;

  // Storage bucket names
  static const String productImagesBucket = 'product-images';
  static const String profileImagesBucket = 'profile-images';

  // Table names
  static const String usersTable = 'users';
  static const String productsTable = 'products';
  static const String ordersTable = 'orders';
  static const String favoritesTable = 'favorites';
  static const String categoriesTable = 'categories';
}
