import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static Future<void> init() async {
    await Supabase.initialize(
      url: 'https://iatqfwzgonkiyuqjyycq.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlhdHFmd3pnb25raXl1cWp5eWNxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjA1MjMzNzMsImV4cCI6MjA3NjA5OTM3M30.tgOLbJYfpVP9iqaD4obSOp4Kv_b2Zrv7ys9TbxiDaRI',
    );
  }

  static SupabaseClient get client => Supabase.instance.client;
}
