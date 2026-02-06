# ربط عجلة الحظ بـ Supabase

يمكن تخزين إعدادات العجلة وبيانات المستخدمين والجوائز في **Supabase** بدل Google Sheets (بدون مشاكل CORS).

## الخطوات

### 1) إنشاء مشروع Supabase

1. ادخل إلى [supabase.com](https://supabase.com) وسجّل الدخول.
2. أنشئ مشروع جديد (New project).
3. من **Settings → API** انسخ:
   - **Project URL** (مثل `https://xxxxx.supabase.co`)
   - **anon public** key (مفتاح عام للواجهة الأمامية).

### 2) إنشاء الجداول

1. من المشروع اختر **SQL Editor**.
2. انسخ محتوى الملف **`supabase/schema.sql`** والصقه في المحرر.
3. اضغط **Run** لتنفيذ الـ SQL (إنشاء جداول `settings`, `user_data`, `wins` والصلاحيات).

### 3) إعداد المتغيرات في المشروع

1. في مجلد المشروع انسخ `.env.example` إلى ملف باسم **`.env`**.
2. افتح `.env` واملأ القيم:
   ```
   VITE_SUPABASE_URL=https://xxxxx.supabase.co
   VITE_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIs...
   ```
3. أعد تشغيل أو بناء المشروع (`npm run dev` أو `npm run build`).

بعد ذلك سيستخدم التطبيق Supabase تلقائياً لـ:
- تحميل الإعدادات (بدون CORS).
- حفظ الإعدادات من لوحة التحكم.
- حفظ بيانات التسجيل (user_data).
- حفظ الجوائز الفائزة (wins).

يمكنك عرض البيانات من **Table Editor** في لوحة Supabase.

## ملاحظة

- إذا لم تضبط `VITE_SUPABASE_URL` و `VITE_SUPABASE_ANON_KEY` يبقى التطبيق يعمل مع Google Sheets كما هو.
- لا ترفع ملف `.env` إلى Git (موجود في `.gitignore`).
