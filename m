Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB7CC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:30:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSFh-0001DK-0Z; Mon, 14 Jul 2025 19:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSFf-00019r-LC
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:06:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSFd-0005Jh-GJ
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:06:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CR+LZ2cu5WxczbRij8l03U22ueM2EikDrXwY3SzEt+o=;
 b=Qk0deEzNa4BehX9Jdevv+R1a+LMlhjDpyd7gecHaCXfCYqUOy9esSOKubRQl2yML+j6S0P
 aYQBGKKKuqBvQo99l5QsLmw4WisuaovMOSBuJNTIpgv0ZoaUpbYWFY/bv5/kKJukgMHJPT
 qGHOs/zDLaNJClnTpfPJ1VDRLl4ZNRc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-NQQP7ZONPP69qsMiZXbsbw-1; Mon, 14 Jul 2025 19:06:22 -0400
X-MC-Unique: NQQP7ZONPP69qsMiZXbsbw-1
X-Mimecast-MFC-AGG-ID: NQQP7ZONPP69qsMiZXbsbw_1752534381
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-456013b59c1so14804755e9.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:06:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534381; x=1753139181;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CR+LZ2cu5WxczbRij8l03U22ueM2EikDrXwY3SzEt+o=;
 b=J2mtowmAz+EFdNcVkyXi6p4NbuREEI+a2QPj9d/6QcVdAkNyBG19cNsSRp+EM/+M6w
 7VnNk47+Qo2RnE/WunXtH7HFCM0RIQsUHWIP4maA/31XQgiep5Yc3xz27HzLYZlx11j6
 pZxSsIqBgV6rI073o7XYn5Wwg20EucQZAZSmwcNi/phVr9xYHwQW5kW+SCZCktDYtxu2
 yvhrbBGlDvOaLL+ySvAI5hU32h7UhWztQx70FlXL123S+1Q71f2ozqwJyvFOP2hgGRo1
 PSw2lOBYZ4jeSyTTtFslsyrZEpJTYgHJ7Na1TvkOpfk6OwYpZuBAG1LVHLwzo8f7l10a
 lwjg==
X-Gm-Message-State: AOJu0YwXzhSIcDMugDIHk5jPPUh3FZ0KHh1gFzDGfEA+kuXh0WNMmzrT
 ttfS0V//YBANZVC2ovqswttgkTQS40rxgmVyIJy37ZJvXqcH9hUYdTu1LqoXYy6NCyMcf20uOwq
 X1wR8WGX3HkVeajLt8u6P/cRwEJs6gGeTdb8btQP1D20Bv1Z1U+3ngTW40zh7vwwCg5S63uUMWI
 vtj7IhvJzp05ayM/u1issrhMtphs4enykzog==
X-Gm-Gg: ASbGncvNNCg/YvBCJLObZ5wsByNuDskN/WAuxkAzQniv+ej2tNYn6Y4CsG3zl+6kdhj
 c3rTKCTftk5rXozapEVtgD1B595lJOy8/FiSDiMig33WJSsOLuW+NPprBDX2hVf4ccjs9EUiAGF
 ZHxlD7bPCSXW0sSb/TotX88WkEzgraZl3LkUN8xqqAFwuksaGIL0LWtH3OK2P4xCQFvZXDHea7R
 IFn0lUPzCRHnMRNNkTGo16dst5G1/R6YCNQ7TDelHVbqgtS3ajtDx2Y48PbLHLaUEvtqzqyk4yr
 83zzhFLJCjegPkscX6EWnJQt++IUw/hJ
X-Received: by 2002:a05:600c:8483:b0:453:81a:2f3f with SMTP id
 5b1f17b1804b1-455bd87a108mr136442285e9.30.1752534381013; 
 Mon, 14 Jul 2025 16:06:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDM8xIgkr9/SQ8IxgGKOql5dG0h7EsQpTSFbK08Ggbo4q5phKuP4Fa9lX6/de3GyJWICW/LQ==
X-Received: by 2002:a05:600c:8483:b0:453:81a:2f3f with SMTP id
 5b1f17b1804b1-455bd87a108mr136442045e9.30.1752534380547; 
 Mon, 14 Jul 2025 16:06:20 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc1f70sm13405779f8f.27.2025.07.14.16.06.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:06:20 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:06:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 01/97] qdev-properties: Add DEFINE_PROP_ON_OFF_AUTO_BIT64()
Message-ID: <52f45faa4f843617ae09e7965aec963fab3fb564.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

DEFINE_PROP_ON_OFF_AUTO_BIT64() corresponds to DEFINE_PROP_ON_OFF_AUTO()
as DEFINE_PROP_BIT64() corresponds to DEFINE_PROP_BOOL(). The difference
is that DEFINE_PROP_ON_OFF_AUTO_BIT64() exposes OnOffAuto instead of
bool.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20250530-vdpa-v1-1-5af4109b1c19@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/qdev-properties.h | 18 ++++++++++
 hw/core/qdev-properties.c    | 67 +++++++++++++++++++++++++++++++++++-
 2 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 2c99856caa..0197aa4995 100644
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
@@ -100,6 +111,13 @@ extern const PropertyInfo qdev_prop_link;
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
index 147b3ffd16..b7e8a89ba5 100644
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
MST


