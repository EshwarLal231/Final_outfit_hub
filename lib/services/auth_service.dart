import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/supabase_config.dart';
import '../models/user_model.dart';

class AuthService {
  final SupabaseClient _supabase = SupabaseConfig.client;

  // Sign up with email and password
  Future<UserModel?> signup({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String location,
    String role = 'buyer',
  }) async {
    try {
      // Sign up with Supabase Auth
      final authResponse = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'name': name,
        },
      );

      if (authResponse.user == null) {
        throw Exception('Failed to create account');
      }

      // Try to insert/upsert user profile in users table
      try {
        final userProfile = await _supabase
            .from(SupabaseConfig.usersTable)
            .upsert({
              'id': authResponse.user!.id,
              'name': name,
              'email': email,
              'phone': phone,
              'location': location,
              'role': role,
            })
            .select()
            .single();

        return UserModel.fromJson(userProfile);
      } catch (tableError) {
        // If table doesn't exist yet, return a basic user model
        print('Warning: Users table not found. User created in auth but not in database.');
        print('Please run the SQL schema in Supabase dashboard.');
        return UserModel(
          id: authResponse.user!.id,
          name: name,
          email: email,
          phone: phone,
          location: location,
          role: role,
          isActive: true,
          isVerified: false,
          createdAt: DateTime.now(),
        );
      }
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Signup failed: $e');
    }
  }

  // Login with email and password
  Future<UserModel?> login(String email, String password) async {
    try {
      // Sign in with Supabase Auth
      final authResponse = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (authResponse.user == null) {
        throw Exception('Invalid credentials');
      }

      // Get user profile
      final userProfile = await _supabase
          .from(SupabaseConfig.usersTable)
          .select()
          .eq('id', authResponse.user!.id)
          .single();

      return UserModel.fromJson(userProfile);
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      await _supabase.auth.signOut();
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }

  // Get current user
  Future<UserModel?> getCurrentUser() async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) return null;

      final userProfile = await _supabase
          .from(SupabaseConfig.usersTable)
          .select()
          .eq('id', user.id)
          .single();

      return UserModel.fromJson(userProfile);
    } catch (e) {
      print('Error getting current user: $e');
      return null;
    }
  }

  // Check if user is logged in
  bool isLoggedIn() {
    return _supabase.auth.currentUser != null;
  }

  // Update user profile
  Future<UserModel?> updateProfile({
    required String userId,
    String? name,
    String? phone,
    String? location,
    String? profilePicture,
  }) async {
    try {
      final updates = <String, dynamic>{};
      if (name != null) updates['name'] = name;
      if (phone != null) updates['phone'] = phone;
      if (location != null) updates['location'] = location;
      if (profilePicture != null) updates['profile_picture'] = profilePicture;

      final response = await _supabase
          .from(SupabaseConfig.usersTable)
          .update(updates)
          .eq('id', userId)
          .select()
          .single();

      return UserModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    try {
      await _supabase.auth.resetPasswordForEmail(email);
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Failed to send reset email: $e');
    }
  }

  // Update password
  Future<void> updatePassword(String newPassword) async {
    try {
      await _supabase.auth.updateUser(
        UserAttributes(password: newPassword),
      );
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Failed to update password: $e');
    }
  }

  // Delete account
  Future<void> deleteAccount() async {
    try {
      final user = _supabase.auth.currentUser;
      if (user != null) {
        // Delete user profile (cascade will handle related data)
        await _supabase
            .from(SupabaseConfig.usersTable)
            .delete()
            .eq('id', user.id);
        
        await _supabase.auth.signOut();
      }
    } catch (e) {
      throw Exception('Failed to delete account: $e');
    }
  }
}
