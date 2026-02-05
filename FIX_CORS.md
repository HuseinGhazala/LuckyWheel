# 🔧 حل مشكلة CORS في Google Apps Script

## المشكلة:
Google Apps Script لا يدعم `setHeaders` بهذه الطريقة.

## الحل:
Google Apps Script يدعم CORS تلقائياً عند النشر كـ Web App مع الإعدادات الصحيحة.

---

## ✅ الخطوات الصحيحة:

### 1. تأكد من إعدادات النشر:
- **Execute as**: "أنا (your-email@gmail.com)"
- **Who has access**: "أي شخص" (Anyone)

### 2. استخدم الرابط الذي حصلت عليه:
```
https://script.google.com/macros/s/AKfycbzIb8HtBlkJRdc6SPQPNTU09pWlt9cd_KsMajmZbu5AQt-4HAu-hw6usEWbDyXIBJj7/exec
```

### 3. أدخل الرابط في لوحة التحكم:
- افتح التطبيق → Settings → admin
- الصق الرابط في حقل "رابط نشر التطبيق"
- احفظ

---

## 🔍 اختبار الرابط:

افتح الرابط في المتصفح مع إضافة `?action=getSettings`:
```
https://script.google.com/macros/s/AKfycbzIb8HtBlkJRdc6SPQPNTU09pWlt9cd_KsMajmZbu5AQt-4HAu-hw6usEWbDyXIBJj7/exec?action=getSettings
```

يجب أن ترى JSON response مثل:
```json
{
  "success": true,
  "settings": {
    "segments": [...],
    "maxSpins": 1,
    ...
  }
}
```

---

## ⚠️ إذا لم يعمل:

1. تأكد من نشر التطبيق بشكل صحيح
2. تأكد من أن "Who has access" = "Anyone"
3. جرب تحديث الكود في Apps Script وحفظه ونشره مرة أخرى
