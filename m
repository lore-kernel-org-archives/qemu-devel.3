Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 755D7C35FE0
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2024 01:25:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spe0B-0002fn-Sr; Sat, 14 Sep 2024 21:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1spe0A-0002fI-Ho
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 21:24:34 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1spe08-0005Qz-U6
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 21:24:34 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2057c6c57b5so20035115ad.1
 for <qemu-devel@nongnu.org>; Sat, 14 Sep 2024 18:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726363471; x=1726968271;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=x8JfiA3K2oY/K7D1EGS4G8XFPBDM/W8pC6fABdWUS7w=;
 b=MKA+YygOeIxl3C7acEB84UVgJR+nsKZaSbbdwIGWKePFRiEpzPThpaboTtOt5XeJsi
 mIWiV3h/ossRatW8cJFI9WLPvQyV6CBl5BNneBuVge5Wp2MGPNrhMkdZMEXcMSwuCaWV
 ZSlgITIkJdTNvxXw+4iql/st1KRYfqJPb+8KN+xVMhw2wjmogoHjZqTiWIpM70HmKv6g
 P8pttHi44zduDxKiDLF0yibuch/Q/wlkYKmaGc+xsOr3Xv+ob1jH+lHRcqmCfCsvlF2g
 qwdcsGdOzWZIXm7h/2/fYruC6v8crZRSUntUdJ+WKfNb2RdRgEK+KdRVX1PATi7hdHGQ
 m8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726363471; x=1726968271;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x8JfiA3K2oY/K7D1EGS4G8XFPBDM/W8pC6fABdWUS7w=;
 b=MmyBhUUDH4Qe0j9QrmCADqPXRnnusroQ1XqPsmmu8MA9N+EIOode+72Et+YVVhqmdA
 E60xgR4GyvvNmXg4S1ZoGIgRANA18PBG+V74mWDs/jP6hrWZRVXFZFch3ZiAWIwuRFIV
 6o+8Y8eDy408G0U3pfDKZApgMlmNCNyjeaAEzmzM/7CktX2nAvdDjcUmexdIE/wulAT1
 En7NvCgy3G0aqsS/3VdVVRn7dKWe+1r1oRI9XVxjNWyGUafL5Eb+pwkKX04RjPgIyIp0
 DpIEBdHvknWvwwjiScnKHh9mpmRJ7bp/QRL2PpAcB+E5TDXVunwQEO3NcOWvJZzmDRyL
 Uu6g==
X-Gm-Message-State: AOJu0YzpH3qDfay6HqnG3kPa7HWpg7rjlGLh14UEDasu+vjSFHghwSJT
 OlLL/cZsc3K0c22mBa7r2RJ74oDa2EWrMqb9I9uc0lzNi3cq0HGFbEDZG73lITTq6TOeKx5o/67
 RxQ4=
X-Google-Smtp-Source: AGHT+IFY+DFDC/s7GYMQfy9lmUxtxsS5VJtq0iysOlN0P/b70Yc+gxN1J+o/stsVZYk8fjr7KsiERQ==
X-Received: by 2002:a17:902:e751:b0:205:866d:177d with SMTP id
 d9443c01a7336-2076e5f7af6mr147218985ad.21.1726363470588; 
 Sat, 14 Sep 2024 18:24:30 -0700 (PDT)
Received: from localhost ([210.160.217.68])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-207945da563sm14846865ad.60.2024.09.14.18.24.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Sep 2024 18:24:30 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 15 Sep 2024 10:23:42 +0900
Subject: [PATCH RFC v3 01/11] qdev-properties:
 DEFINE_PROP_ON_OFF_AUTO_BIT()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240915-hash-v3-1-79cb08d28647@daynix.com>
References: <20240915-hash-v3-0-79cb08d28647@daynix.com>
In-Reply-To: <20240915-hash-v3-0-79cb08d28647@daynix.com>
To: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::635;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/qdev-properties.h | 18 ++++++++++++
 hw/core/qdev-properties.c    | 66 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 09aa04ca1e27..678837569784 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -43,10 +43,21 @@ struct PropertyInfo {
     ObjectPropertyRelease *release;
 };
 
+/**
+ * struct OnOffAutoBit - OnOffAuto storage with 64 elements.
+ * @on_bits: Bitmap of elements with "on".
+ * @auto_bits: Bitmap of elements with "auto".
+ */
+typedef struct OnOffAutoBit {
+    uint32_t on_bits;
+    uint32_t auto_bits;
+} OnOffAutoBit;
+
 
 /*** qdev-properties.c ***/
 
 extern const PropertyInfo qdev_prop_bit;
+extern const PropertyInfo qdev_prop_on_off_auto_bit;
 extern const PropertyInfo qdev_prop_bit64;
 extern const PropertyInfo qdev_prop_bool;
 extern const PropertyInfo qdev_prop_enum;
@@ -86,6 +97,13 @@ extern const PropertyInfo qdev_prop_link;
                 .set_default = true,                            \
                 .defval.u    = (bool)_defval)
 
+#define DEFINE_PROP_ON_OFF_AUTO_BIT(_name, _state, _field, _bit, _defval) \
+    DEFINE_PROP(_name, _state, _field, qdev_prop_on_off_auto_bit,         \
+                OnOffAutoBit,                                             \
+                .bitnr    = (_bit),                                       \
+                .set_default = true,                                      \
+                .defval.i = (OnOffAuto)_defval)
+
 #define DEFINE_PROP_UNSIGNED(_name, _state, _field, _defval, _prop, _type) \
     DEFINE_PROP(_name, _state, _field, _prop, _type,                       \
                 .set_default = true,                                       \
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 86a583574dd0..e1ff992e7177 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -133,7 +133,8 @@ const PropertyInfo qdev_prop_enum = {
 
 static uint32_t qdev_get_prop_mask(Property *prop)
 {
-    assert(prop->info == &qdev_prop_bit);
+    assert(prop->info == &qdev_prop_bit ||
+           prop->info == &qdev_prop_on_off_auto_bit);
     return 0x1 << prop->bitnr;
 }
 
@@ -183,6 +184,69 @@ const PropertyInfo qdev_prop_bit = {
     .set_default_value = set_default_value_bool,
 };
 
+static void prop_get_on_off_auto_bit(Object *obj, Visitor *v,
+                                     const char *name, void *opaque,
+                                     Error **errp)
+{
+    Property *prop = opaque;
+    OnOffAutoBit *p = object_field_prop_ptr(obj, prop);
+    int value;
+    uint32_t mask = qdev_get_prop_mask(prop);
+
+    if (p->auto_bits & mask) {
+        value = ON_OFF_AUTO_AUTO;
+    } else if (p->on_bits & mask) {
+        value = ON_OFF_AUTO_ON;
+    } else {
+        value = ON_OFF_AUTO_OFF;
+    }
+
+    visit_type_enum(v, name, &value, &OnOffAuto_lookup, errp);
+}
+
+static void prop_set_on_off_auto_bit(Object *obj, Visitor *v,
+                                     const char *name, void *opaque,
+                                     Error **errp)
+{
+    Property *prop = opaque;
+    OnOffAutoBit *p = object_field_prop_ptr(obj, prop);
+    bool bool_value;
+    int value;
+    uint32_t mask = qdev_get_prop_mask(prop);
+
+    if (visit_type_bool(v, name, &bool_value, NULL)) {
+        value = bool_value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
+    } else if (!visit_type_enum(v, name, &value, &OnOffAuto_lookup, errp)) {
+        return;
+    }
+
+    switch (value) {
+    case ON_OFF_AUTO_AUTO:
+        p->on_bits &= ~mask;
+        p->auto_bits |= mask;
+        break;
+
+    case ON_OFF_AUTO_ON:
+        p->on_bits |= mask;
+        p->auto_bits &= ~mask;
+        break;
+
+    case ON_OFF_AUTO_OFF:
+        p->on_bits &= ~mask;
+        p->auto_bits &= ~mask;
+        break;
+    }
+}
+
+const PropertyInfo qdev_prop_on_off_auto_bit = {
+    .name  = "OnOffAuto",
+    .description = "on/off/auto",
+    .enum_table = &OnOffAuto_lookup,
+    .get = prop_get_on_off_auto_bit,
+    .set = prop_set_on_off_auto_bit,
+    .set_default_value = qdev_propinfo_set_default_value_enum,
+};
+
 /* Bit64 */
 
 static uint64_t qdev_get_prop_mask64(Property *prop)

-- 
2.46.0


