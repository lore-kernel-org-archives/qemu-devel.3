Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC894D0E6FC
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 04:52:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t36rP-00028p-Dv; Tue, 22 Oct 2024 00:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t36rF-00024J-6d
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 00:51:02 -0400
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t36rC-0008RN-PL
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 00:51:00 -0400
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-83ac4dacaf9so96716439f.2
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 21:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1729572657; x=1730177457;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=V2/uTnhQm3uWPtccTag7eHWITcu21fyM4nMyI465zyg=;
 b=20ZkUuaAIlHPV7BSQatwsnPuyyfCDiNQ2nzfEIRIx5HSuuVY0ikBCfcdcjK2Gm8Hd6
 63bUQPDXOZ0EBrHw5gx/VcwMZ1zTVHvpez+7LNU9g3vb9cXwb0WTUSkjafwhkP2uKHQK
 vd9fxsZvF3dOXVItaq9480A+rD9zGgXs5tpJpsGpd46kSXOu3B2VZ6GQ5CP3tPAaXGc4
 kGdkNhRGpBV+wzZWo3sexQ7RLHBT4v0wZHEf3SSiNfqe1fudYkt4SP6gbDXtx6qQaKAK
 17HanQW0x5Y9mnnVb2aImU/XrGkqkLxXeKQOJVr0kVqbd3259ih26dThy9n0rfEEu8DH
 JGMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729572657; x=1730177457;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V2/uTnhQm3uWPtccTag7eHWITcu21fyM4nMyI465zyg=;
 b=OpIYjHJUk/vIvMERRRqRlHXcNuIDbMMhF20zI5vlNHiAMFbTLl6STaSEw8+xm1a/HL
 THsN+ci++bQeOxv7fygw7I4FKVtEEBl2i+O+9q8QyRGOnhob0JYX75rHqyCb66u2xZFJ
 ZJLRlT/r94GTcHVPH7wd3YxoCTS5CKkvOneZwJxMcZQWKbykSBjqsXq5W5UsWEJniuNq
 dNHOfXJwmSK3/CTYB2Zp0t3yFT8yITp7KHJM2Mw3trzuwMj+UGmsO1Tw34KfOG7AwCCN
 VJ87QzUo3NPbaBCZbNm9Gy6FsuOSAfIiH2xCPOMVUQsh52oBA1iAV7O0YwGdewFoTbor
 7xdA==
X-Gm-Message-State: AOJu0YxBQURT+dYFpYc/SAh5VdNoUbSZv6VG4vdtTgBY1fQzzDsucH3U
 3urEULgwS1ai1vqc1Oc7hItRWNwtaQm4Sy8W5VU3DGOuglf8fZhvjKqYLCTsWY4=
X-Google-Smtp-Source: AGHT+IF/GnH2QgDmw59wK+MV58orwGTHjDwuVN31SvZk0So7QwH+kyVEsr3tWZ9XQOL8vTjXgvCRSQ==
X-Received: by 2002:a05:6e02:1d04:b0:3a0:926a:8d31 with SMTP id
 e9e14a558f8ab-3a4cd7ebeb1mr12712545ab.16.1729572657066; 
 Mon, 21 Oct 2024 21:50:57 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-7eaeaafbba8sm4007307a12.18.2024.10.21.21.50.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 21:50:56 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 22 Oct 2024 13:50:39 +0900
Subject: [PATCH v2 2/3] qdev-properties: Add
 DEFINE_PROP_ON_OFF_AUTO_BIT64()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241022-virtio-v2-2-b2394236e053@daynix.com>
References: <20241022-virtio-v2-0-b2394236e053@daynix.com>
In-Reply-To: <20241022-virtio-v2-0-b2394236e053@daynix.com>
To: Jason Wang <jasowang@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::d2d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-io1-xd2d.google.com
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

DEFINE_PROP_ON_OFF_AUTO_BIT64() corresponds to DEFINE_PROP_ON_OFF_AUTO()
as DEFINE_PROP_BIT64() corresponds to DEFINE_PROP_BOOL(). The difference
is that DEFINE_PROP_ON_OFF_AUTO_BIT64() exposes OnOffAuto instead of
bool.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/qdev-properties.h | 18 ++++++++++++
 hw/core/qdev-properties.c    | 66 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 09aa04ca1e27..afec53a48470 100644
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
 extern const PropertyInfo qdev_prop_enum;
 extern const PropertyInfo qdev_prop_uint8;
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
index f0a270bb4f61..cc76ff0dfae6 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -187,7 +187,8 @@ const PropertyInfo qdev_prop_bit = {
 
 static uint64_t qdev_get_prop_mask64(Property *prop)
 {
-    assert(prop->info == &qdev_prop_bit64);
+    assert(prop->info == &qdev_prop_bit64 ||
+           prop->info == &qdev_prop_on_off_auto_bit64);
     return 0x1ull << prop->bitnr;
 }
 
@@ -232,6 +233,69 @@ const PropertyInfo qdev_prop_bit64 = {
     .set_default_value = set_default_value_bool,
 };
 
+static void prop_get_on_off_auto_bit64(Object *obj, Visitor *v,
+                                       const char *name, void *opaque,
+                                       Error **errp)
+{
+    Property *prop = opaque;
+    OnOffAutoBit64 *p = object_field_prop_ptr(obj, prop);
+    int value;
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
+    visit_type_enum(v, name, &value, &OnOffAuto_lookup, errp);
+}
+
+static void prop_set_on_off_auto_bit64(Object *obj, Visitor *v,
+                                       const char *name, void *opaque,
+                                       Error **errp)
+{
+    Property *prop = opaque;
+    OnOffAutoBit64 *p = object_field_prop_ptr(obj, prop);
+    bool bool_value;
+    int value;
+    uint64_t mask = qdev_get_prop_mask64(prop);
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
+const PropertyInfo qdev_prop_on_off_auto_bit64 = {
+    .name  = "OnOffAuto",
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
2.47.0


