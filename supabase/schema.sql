-- عجلة الحظ - جداول Supabase
-- نفّذ هذا الملف من Supabase Dashboard → SQL Editor

-- جدول الإعدادات (صف واحد فقط، id = 1)
CREATE TABLE IF NOT EXISTS public.settings (
  id integer PRIMARY KEY DEFAULT 1,
  segments jsonb DEFAULT '[]',
  max_spins integer DEFAULT 1,
  logo text DEFAULT '',
  social_links jsonb DEFAULT '{}',
  background_settings jsonb DEFAULT '{"type":"color","color":"#0f172a","desktopImage":null,"mobileImage":null}',
  win_sound text DEFAULT '',
  lose_sound text DEFAULT '',
  google_script_url text DEFAULT '',
  updated_at timestamptz DEFAULT now(),
  CONSTRAINT single_row CHECK (id = 1)
);

-- إدراج الصف الافتراضي إن لم يكن موجوداً
INSERT INTO public.settings (id, segments, max_spins)
VALUES (1, '[]', 1)
ON CONFLICT (id) DO NOTHING;

-- جدول بيانات المستخدمين (التسجيل قبل الدوران)
CREATE TABLE IF NOT EXISTS public.user_data (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  email text NOT NULL,
  phone text NOT NULL,
  created_at timestamptz DEFAULT now()
);

-- جدول الجوائز الفائزة
CREATE TABLE IF NOT EXISTS public.wins (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  email text NOT NULL,
  phone text NOT NULL,
  prize text NOT NULL,
  coupon_code text DEFAULT '',
  created_at timestamptz DEFAULT now()
);

-- تفعيل RLS
ALTER TABLE public.settings ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_data ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.wins ENABLE ROW LEVEL SECURITY;

-- السياسات: السماح للجميع (anon) بالقراءة والكتابة كما في النسخة الحالية
CREATE POLICY "السماح بقراءة الإعدادات" ON public.settings FOR SELECT USING (true);
CREATE POLICY "السماح بتحديث الإعدادات" ON public.settings FOR ALL USING (true) WITH CHECK (true);

CREATE POLICY "السماح بإدراج بيانات المستخدم" ON public.user_data FOR INSERT WITH CHECK (true);
CREATE POLICY "السماح بقراءة بيانات المستخدم" ON public.user_data FOR SELECT USING (true);

CREATE POLICY "السماح بإدراج الجوائز" ON public.wins FOR INSERT WITH CHECK (true);
CREATE POLICY "السماح بقراءة الجوائز" ON public.wins FOR SELECT USING (true);
