Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC8FFED3FC
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 19:27:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGMAH-0003Eq-2W; Fri, 24 Apr 2026 15:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGMAF-0003Ea-6W
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:26:11 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGMAC-0001OU-OI
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:26:10 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43fea39e066so6803055f8f.1
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 12:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777058767; x=1777663567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZJq2F34MQNBz6Mo/u+tAh3sHWBJqifVXBw7FR2rQkMU=;
 b=mhcCqhxn3nF9Ck0K3WyxucPCwfuVLZFxRBc8aeY3d9ZceTIwbBvsSOmNN38eSrgVEs
 BfEUQJ4dZv6fW9d12n9jcCVK8i9SaQoMprKa3WedYOjScLam5g9lXsyUQHN7Y1VkaJv1
 YF0KYcq45PZX5msLH3G+3nRmLqfUK6Mz7MIW0eDQiurdY63Kbv66S3EEkgCo+tWGI30L
 lbx+x8l8oMDqLHY9bu9CUHXUU2jOtwxneGrFgSlGJ6+G+SRhDUWtOvBEZWnAW5cTkZFU
 Y2UpNyhAQ6V30u3+MhAA81uEhEM6VDBXuH+75F3fmBYGNXmmPeZllF7hrilOGCxskaq/
 WtFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777058767; x=1777663567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZJq2F34MQNBz6Mo/u+tAh3sHWBJqifVXBw7FR2rQkMU=;
 b=RvDDd5pyPN4VGlpo0g/NUstzkELokJzCOgMhDSgHf+N49l6tnGgxbMo28NAkS7Xm0n
 HsE0KkU6A3XoOigyTSRktBF2JHZkNCW+tlAWc+t6qSv9xbV39YaLtYtAuxHX0Db59j4E
 cQM2uWC1DbYXLFMsxYUe1MPgTcZCCPcjw41/aRVMLBk2z19CTRd1Mw4BBlQjDOKdpH20
 v5xMAuXs29BanFfXCAn/RWnZ6nqlFEJ0DCug2QV99XYZkb8wZkBfUEdrMAEuYgjI7zSA
 p4/1rciV8aNDKHXrASOtBEA6eyeOD+CAebxc/nrAQMDMbw69jSNjJlOYRZjmIsg5reGY
 aIzg==
X-Gm-Message-State: AOJu0Yxyc2hW6Bku4KqD3rjaepz9wmagdYid8ssrdaMh8uW/LjHLAUyw
 si0QYJ2umcqbblYfy9E+ulo0x/OARCOFG6K/i4YBpmR9uN0fctH9+3WaETFcZOqR5MK2H+wTqqC
 itnQPsIM=
X-Gm-Gg: AeBDieuA8m24rfE++CnMCylbs/XLt5zGtnL/KovqEU5wnLHIMJaOzt2KcJma7Kyozx1
 mKUs2vjiRpkP4ubI+R4iLBICaf4nklTuz9kl1zvcfkLFV0W40ynjnO3MflG6gYBKwZHCmGlq8S1
 EvtxPakl65rXYU3BxqS+0Irebtb+g6vWF/gc5hQJFB7PDJyGq6yD6aHB9pX5qXvx01h3u7uktbt
 w9Iy+DvZHsrdWHoWXAahFOjiRAtHGBN6RA8gPI4mwdCOF3ttKWamziEQd3Ur6OxUv6KelqyYyMV
 ecN6jyiiAjwfcVw867tfRES8oaMeMMUc8y7bwCBhXEkqpAer988yTVrgO8hkqrnWSHhYE7D1B3n
 yvJHDtoHtews/IleTdCmBfaQITnJleFrht9OLh5NcZcgnUhC0BG5Vakuyq+AwQkAUy8c14n+8nM
 ETeHn9ffe/T39tir7/tlFbLOSyycPdUtBgIbjHfiOvs4MC9Mor/MDe+4IbCk6mRxtT5prHEIUU+
 hsa9VgBoU8=
X-Received: by 2002:a05:6000:601:b0:43d:613:33de with SMTP id
 ffacd0b85a97d-43fe3dd3ed3mr52441782f8f.20.1777058766490; 
 Fri, 24 Apr 2026 12:26:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4c221cdsm63339543f8f.0.2026.04.24.12.26.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Apr 2026 12:26:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v4 32/62] qom: Restrict compat properties API to system
 emulation
Date: Fri, 24 Apr 2026 21:25:35 +0200
Message-ID: <20260424192543.22614-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424192543.22614-1-philmd@linaro.org>
References: <20260424192543.22614-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Move compat properties API definitions to their own file
unit, compile it only when system emulation is configured.
Add a pair of stubs for user emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Message-Id: <20260325151728.45378-6-philmd@linaro.org>
---
 MAINTAINERS                   |  1 +
 qom/compat-properties.c       | 76 +++++++++++++++++++++++++++++++++++
 qom/object.c                  | 60 ---------------------------
 stubs/qom-compat-properties.c | 14 +++++++
 qom/meson.build               |  3 ++
 stubs/meson.build             |  1 +
 6 files changed, 95 insertions(+), 60 deletions(-)
 create mode 100644 qom/compat-properties.c
 create mode 100644 stubs/qom-compat-properties.c

diff --git a/MAINTAINERS b/MAINTAINERS
index facc4b499a9..45d258f64fc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3533,6 +3533,7 @@ F: qapi/qom.json
 F: scripts/coccinelle/qom-parent-type.cocci
 F: scripts/qom-cast-macro-clean-cocci-gen.py
 F: qom/
+F: stubs/qom-compat-properties.c
 F: tests/unit/check-qom-interface.c
 F: tests/unit/check-qom-proplist.c
 F: tests/qtest/qom-test.c
diff --git a/qom/compat-properties.c b/qom/compat-properties.c
new file mode 100644
index 00000000000..2110754155a
--- /dev/null
+++ b/qom/compat-properties.c
@@ -0,0 +1,76 @@
+/*
+ * QEMU Object Model
+ *
+ * Copyright IBM, Corp. 2011
+ *
+ * Authors:
+ *  Anthony Liguori   <aliguori@us.ibm.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qom/compat-properties.h"
+#include "qom/qom-qobject.h"
+#include "hw/core/qdev.h"
+
+/*
+ * Global property defaults
+ * Slot 0: accelerator's global property defaults
+ * Slot 1: machine's global property defaults
+ * Slot 2: global properties from legacy command line option
+ * Each is a GPtrArray of GlobalProperty.
+ * Applied in order, later entries override earlier ones.
+ */
+static GPtrArray *object_compat_props[3];
+
+/*
+ * Retrieve @GPtrArray for global property defined with options
+ * other than "-global".  These are generally used for syntactic
+ * sugar and legacy command line options.
+ */
+void object_register_sugar_prop(const char *driver, const char *prop,
+                                const char *value, bool optional)
+{
+    GlobalProperty *g;
+    if (!object_compat_props[2]) {
+        object_compat_props[2] = g_ptr_array_new();
+    }
+    g = g_new0(GlobalProperty, 1);
+    g->driver = g_strdup(driver);
+    g->property = g_strdup(prop);
+    g->value = g_strdup(value);
+    g->optional = optional;
+    g_ptr_array_add(object_compat_props[2], g);
+}
+
+/*
+ * Set machine's global property defaults to @compat_props.
+ * May be called at most once.
+ */
+void object_set_machine_compat_props(GPtrArray *compat_props)
+{
+    assert(!object_compat_props[1]);
+    object_compat_props[1] = compat_props;
+}
+
+/*
+ * Set accelerator's global property defaults to @compat_props.
+ * May be called at most once.
+ */
+void object_set_accelerator_compat_props(GPtrArray *compat_props)
+{
+    assert(!object_compat_props[0]);
+    object_compat_props[0] = compat_props;
+}
+
+void object_apply_compat_props(Object *obj)
+{
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(object_compat_props); i++) {
+        object_apply_global_props(obj, object_compat_props[i],
+                                  i == 2 ? &error_fatal : &error_abort);
+    }
+}
diff --git a/qom/object.c b/qom/object.c
index d6500bcbbf4..f981e270440 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -480,66 +480,6 @@ bool object_apply_global_props(Object *obj, const GPtrArray *props,
     return true;
 }
 
-/*
- * Global property defaults
- * Slot 0: accelerator's global property defaults
- * Slot 1: machine's global property defaults
- * Slot 2: global properties from legacy command line option
- * Each is a GPtrArray of GlobalProperty.
- * Applied in order, later entries override earlier ones.
- */
-static GPtrArray *object_compat_props[3];
-
-/*
- * Retrieve @GPtrArray for global property defined with options
- * other than "-global".  These are generally used for syntactic
- * sugar and legacy command line options.
- */
-void object_register_sugar_prop(const char *driver, const char *prop,
-                                const char *value, bool optional)
-{
-    GlobalProperty *g;
-    if (!object_compat_props[2]) {
-        object_compat_props[2] = g_ptr_array_new();
-    }
-    g = g_new0(GlobalProperty, 1);
-    g->driver = g_strdup(driver);
-    g->property = g_strdup(prop);
-    g->value = g_strdup(value);
-    g->optional = optional;
-    g_ptr_array_add(object_compat_props[2], g);
-}
-
-/*
- * Set machine's global property defaults to @compat_props.
- * May be called at most once.
- */
-void object_set_machine_compat_props(GPtrArray *compat_props)
-{
-    assert(!object_compat_props[1]);
-    object_compat_props[1] = compat_props;
-}
-
-/*
- * Set accelerator's global property defaults to @compat_props.
- * May be called at most once.
- */
-void object_set_accelerator_compat_props(GPtrArray *compat_props)
-{
-    assert(!object_compat_props[0]);
-    object_compat_props[0] = compat_props;
-}
-
-void object_apply_compat_props(Object *obj)
-{
-    int i;
-
-    for (i = 0; i < ARRAY_SIZE(object_compat_props); i++) {
-        object_apply_global_props(obj, object_compat_props[i],
-                                  i == 2 ? &error_fatal : &error_abort);
-    }
-}
-
 static void object_class_property_init_all(Object *obj)
 {
     ObjectPropertyIterator iter;
diff --git a/stubs/qom-compat-properties.c b/stubs/qom-compat-properties.c
new file mode 100644
index 00000000000..2c955677bed
--- /dev/null
+++ b/stubs/qom-compat-properties.c
@@ -0,0 +1,14 @@
+/*
+ * QEMU Object Model (compat properties stubs for user emulation)
+ *
+ * Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qom/compat-properties.h"
+
+void object_apply_compat_props(Object *obj)
+{
+}
diff --git a/qom/meson.build b/qom/meson.build
index 81922434309..bd6f4aadd78 100644
--- a/qom/meson.build
+++ b/qom/meson.build
@@ -5,6 +5,9 @@ qom_ss.add(files(
   'object_interfaces.c',
   'qom-qobject.c',
 ))
+if have_system
+  qom_ss.add(files('compat-properties.c'))
+endif
 
 qmp_ss.add(files('qom-qmp-cmds.c'))
 system_ss.add(files('qom-hmp-cmds.c'))
diff --git a/stubs/meson.build b/stubs/meson.build
index 7189ff63ed5..f33b1d2a089 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -54,6 +54,7 @@ if have_user
   # Symbols that are used by hw/core.
   stub_ss.add(files('cpu-synchronize-state.c'))
   stub_ss.add(files('cpu-destroy-address-spaces.c'))
+  stub_ss.add(files('qom-compat-properties.c'))
 
   # Stubs for QAPI events.  Those can always be included in the build, but
   # they are not built at all for --disable-system builds.
-- 
2.53.0


