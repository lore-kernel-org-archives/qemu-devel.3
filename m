Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6585C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 06:56:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tscU1-0006QT-Um; Thu, 13 Mar 2025 02:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tscTu-0006MU-NO
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 02:55:50 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tscTs-00063k-UA
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 02:55:50 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-224019ad9edso15661825ad.1
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 23:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741848947; x=1742453747;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=edQrPumtjHJ/3YEvhVZ3l0G0XjyNZI+GIrglFTyNrrU=;
 b=Ad8g2VEku75+KTZ94JLcm8SwBeS3vFxVVHzcli3SjNyIn96vy4QCPpAc0WSgkTB5s6
 iYBGljg91DC43JdJIhRIniuVJnp4reNzcjqI/4hNOxm1RHAj+LG1Gjb+BqjIh+Lt5gOZ
 oQZJXDnS2TUaBZWUBkKwAcQ4NHQkYug5qKkJwlSthorseNngRvPcVPb0KgWz2NDAf+Cs
 MtlvS5x6BVZwJj54CpBZxbmMznMUTHHTfqwp4/MH8anNhs4tjrQmVIkGIbaYWjDnW2kJ
 Fr8nj87CIrmrpdLKVt6lT/gDojNvKoRYZg5jnaMRx1bC+Y7Lif/Iw6Ye8vd9F16xq5Oo
 ZPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741848947; x=1742453747;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=edQrPumtjHJ/3YEvhVZ3l0G0XjyNZI+GIrglFTyNrrU=;
 b=ksn68lcL9GR3J99r5dPaX1/GAgdGjgjD/x7me3gQuclgFn1rQDubNW6HlF0gitIKNb
 qQ6qquMEBDbij4hIOYqFd9MwQmV11R7gupVeWuQY9BDsPGA9tUQNUNtiiHTYCMPGPUTL
 rmUv/WyUCQ8Jc7KV50TsGd/Ktu+QFnvwwyx6fu7S8jXetvriE7IDRSHQqfCtgOYniJtc
 i1o/c2BEpde+d1t72D6jSdlb6ec19GCaJk1bc6eTWe9iRtU8zsv+IMtHial27vBlcPa+
 qUpvHA5nYCDL35O1JUUxEvoUfx7cRo7pHpb/899IITyzURGfAE5mpT8hk9Ql1rmE2n8C
 Gh7g==
X-Gm-Message-State: AOJu0YywJ3qIE4dYK3x7QMFMKpAQ89rnqD6lUmIEeD4cBzB6Z6/auOyA
 AFzh/Y35s7nWF4apgYAdVfCly8r/dQFqPZEMtTYI7+x6RhQ1xX/apxhV9qTy0+qRbxfqBnjttae
 NCGQ=
X-Gm-Gg: ASbGnct7cs4e7wcRo7UzBljS70OVPIa7TxQW/OjvurBmphmzPrlRimIzcShGqH0felD
 y7vSqcm6lm656qLa8VvSlU7UGSmMtwINJ5j2vu0LZhNxjTpLRhkNIePo7aQBk7620tYdYoN/Jqk
 kdAU4EnnTj/IuLg7aXQ4OMjgeBsvLemWXiCwTPSKiDrm9o7eRws5vaMIZgML1VAxr01HaF/3gvg
 Rl7ZWIFysQ0mkke+jRy5XiDasJDQ0MUHdsWb+C6sxOQOAv0dEtFK/2EPMLP9vjQILhHje8f58j0
 gQJEy9feemAxiPbk/2JoKfPtSgtWbJ3cERxrlPOMH5jpo9c2MHryNk97D/0=
X-Google-Smtp-Source: AGHT+IGRuGv5QCnatLYEPGLLpRsA7qJ6wbH7a83Xg0XRaDoVG7l1LOd9pZ8+k0LLAuPGowedYkH70w==
X-Received: by 2002:a17:903:19cf:b0:215:94eb:adb6 with SMTP id
 d9443c01a7336-22428ab75cdmr436416455ad.40.1741848947228; 
 Wed, 12 Mar 2025 23:55:47 -0700 (PDT)
Received: from localhost ([157.82.205.237])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-3011824b98dsm3078434a91.27.2025.03.12.23.55.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 23:55:46 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 13 Mar 2025 15:55:27 +0900
Subject: [PATCH RFC v4 01/11] qdev-properties: Add
 DEFINE_PROP_ON_OFF_AUTO_BIT64()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-hash-v4-1-c75c494b495e@daynix.com>
References: <20250313-hash-v4-0-c75c494b495e@daynix.com>
In-Reply-To: <20250313-hash-v4-0-c75c494b495e@daynix.com>
To: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 devel@daynix.com
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DEFINE_PROP_ON_OFF_AUTO_BIT64() corresponds to DEFINE_PROP_ON_OFF_AUTO()
as DEFINE_PROP_BIT64() corresponds to DEFINE_PROP_BOOL(). The difference
is that DEFINE_PROP_ON_OFF_AUTO_BIT64() exposes OnOffAuto instead of
bool.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/qdev-properties.h | 18 ++++++++++++
 hw/core/qdev-properties.c    | 67 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 15fcec5260c7..61f13aca6cf4 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -43,11 +43,22 @@ struct PropertyInfo {
     ObjectPropertyRelease *release;
 };
 
+/**
+ * struct OnOffAutoBit64 - OnOffAuto storage with 64 elements.
+ * @on_bits: Bitmap of elements with "on".
+ * @auto_bits: Bitmap of elements with "auto".
+ */
+typedef struct OnOffAutoBit64 {
+    uint64_t on_bits;
+    uint64_t auto_bits;
+} OnOffAutoBit64;
+
 
 /*** qdev-properties.c ***/
 
 extern const PropertyInfo qdev_prop_bit;
 extern const PropertyInfo qdev_prop_bit64;
+extern const PropertyInfo qdev_prop_on_off_auto_bit64;
 extern const PropertyInfo qdev_prop_bool;
 extern const PropertyInfo qdev_prop_uint8;
 extern const PropertyInfo qdev_prop_uint16;
@@ -99,6 +110,13 @@ extern const PropertyInfo qdev_prop_link;
                 .set_default = true,                              \
                 .defval.u  = (bool)_defval)
 
+#define DEFINE_PROP_ON_OFF_AUTO_BIT64(_name, _state, _field, _bit, _defval) \
+    DEFINE_PROP(_name, _state, _field, qdev_prop_on_off_auto_bit64,         \
+                OnOffAutoBit64,                                             \
+                .bitnr    = (_bit),                                         \
+                .set_default = true,                                        \
+                .defval.i = (OnOffAuto)_defval)
+
 #define DEFINE_PROP_BOOL(_name, _state, _field, _defval)     \
     DEFINE_PROP(_name, _state, _field, qdev_prop_bool, bool, \
                 .set_default = true,                         \
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index c04df3b337ae..05a627030141 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -2,6 +2,7 @@
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "qapi/qapi-types-misc.h"
+#include "qapi/qapi-visit-common.h"
 #include "qobject/qlist.h"
 #include "qemu/ctype.h"
 #include "qemu/error-report.h"
@@ -180,7 +181,8 @@ const PropertyInfo qdev_prop_bit = {
 
 static uint64_t qdev_get_prop_mask64(const Property *prop)
 {
-    assert(prop->info == &qdev_prop_bit64);
+    assert(prop->info == &qdev_prop_bit64 ||
+           prop->info == &qdev_prop_on_off_auto_bit64);
     return 0x1ull << prop->bitnr;
 }
 
@@ -225,6 +227,69 @@ const PropertyInfo qdev_prop_bit64 = {
     .set_default_value = set_default_value_bool,
 };
 
+static void prop_get_on_off_auto_bit64(Object *obj, Visitor *v,
+                                       const char *name, void *opaque,
+                                       Error **errp)
+{
+    Property *prop = opaque;
+    OnOffAutoBit64 *p = object_field_prop_ptr(obj, prop);
+    OnOffAuto value;
+    uint64_t mask = qdev_get_prop_mask64(prop);
+
+    if (p->auto_bits & mask) {
+        value = ON_OFF_AUTO_AUTO;
+    } else if (p->on_bits & mask) {
+        value = ON_OFF_AUTO_ON;
+    } else {
+        value = ON_OFF_AUTO_OFF;
+    }
+
+    visit_type_OnOffAuto(v, name, &value, errp);
+}
+
+static void prop_set_on_off_auto_bit64(Object *obj, Visitor *v,
+                                       const char *name, void *opaque,
+                                       Error **errp)
+{
+    Property *prop = opaque;
+    OnOffAutoBit64 *p = object_field_prop_ptr(obj, prop);
+    OnOffAuto value;
+    uint64_t mask = qdev_get_prop_mask64(prop);
+
+    if (!visit_type_OnOffAuto(v, name, &value, errp)) {
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
+
+    case ON_OFF_AUTO__MAX:
+        g_assert_not_reached();
+    }
+}
+
+const PropertyInfo qdev_prop_on_off_auto_bit64 = {
+    .type = "OnOffAuto",
+    .description = "on/off/auto",
+    .enum_table = &OnOffAuto_lookup,
+    .get = prop_get_on_off_auto_bit64,
+    .set = prop_set_on_off_auto_bit64,
+    .set_default_value = qdev_propinfo_set_default_value_enum,
+};
+
 /* --- bool --- */
 
 static void get_bool(Object *obj, Visitor *v, const char *name, void *opaque,

-- 
2.48.1


