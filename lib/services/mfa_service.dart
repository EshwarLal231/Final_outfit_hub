import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/supabase_config.dart';

class MFAService {
  final SupabaseClient _supabase = SupabaseConfig.client;

  // Enroll MFA (setup 2FA)
  Future<Map<String, dynamic>> enrollMFA() async {
    try {
      // Generate QR code for TOTP (Time-based One-Time Password)
      final response = await _supabase.auth.mfa.enroll(
        issuer: 'Outfit Hub',
      );

      return {
        'success': true,
        'qrCode': response.totp?.qrCode ?? '', // QR code for authenticator apps
        'secret': response.totp?.secret ?? '', // Secret key for manual entry
        'id': response.id, // Factor ID
      };
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Failed to enroll MFA: $e');
    }
  }

  // Verify and activate MFA
  Future<bool> verifyAndActivateMFA({
    required String factorId,
    required String code,
  }) async {
    try {
      await _supabase.auth.mfa.challengeAndVerify(
        factorId: factorId,
        code: code,
      );

      return true;
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Failed to verify MFA: $e');
    }
  }

  // Get list of enrolled factors
  Future<AuthMFAListFactorsResponse> getEnrolledFactors() async {
    try {
      final factors = await _supabase.auth.mfa.listFactors();
      return factors;
    } catch (e) {
      throw Exception('Failed to get MFA factors: $e');
    }
  }

  // Unenroll MFA (remove 2FA)
  Future<bool> unenrollMFA(String factorId) async {
    try {
      await _supabase.auth.mfa.unenroll(factorId);
      return true;
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Failed to unenroll MFA: $e');
    }
  }

  // Create MFA challenge for login
  Future<String> createChallenge(String factorId) async {
    try {
      final challenge = await _supabase.auth.mfa.challenge(
        factorId: factorId,
      );
      return challenge.id;
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Failed to create MFA challenge: $e');
    }
  }

  // Verify MFA code during login
  Future<AuthMFAVerifyResponse> verifyMFACode({
    required String factorId,
    required String challengeId,
    required String code,
  }) async {
    try {
      final response = await _supabase.auth.mfa.verify(
        factorId: factorId,
        challengeId: challengeId,
        code: code,
      );
      return response;
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Failed to verify MFA code: $e');
    }
  }

  // Check if user has MFA enabled
  Future<bool> isMFAEnabled() async {
    try {
      final factors = await _supabase.auth.mfa.listFactors();
      return factors.totp.isNotEmpty &&
          factors.totp.any((factor) => factor.status == FactorStatus.verified);
    } catch (e) {
      return false;
    }
  }

  // Get assurance level
  Future<AuthMFAGetAuthenticatorAssuranceLevelResponse> getAssuranceLevel() async {
    try {
      final level = await _supabase.auth.mfa.getAuthenticatorAssuranceLevel();
      return level;
    } catch (e) {
      throw Exception('Failed to get assurance level: $e');
    }
  }
}
