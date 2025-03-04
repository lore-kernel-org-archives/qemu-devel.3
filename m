Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D43EEC021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:34:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpanO-00027Y-Ju; Tue, 04 Mar 2025 17:31:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpam4-000898-VB
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:30:14 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpalv-0007mV-AN
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:29:59 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5e0813bd105so9789877a12.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 14:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741127392; x=1741732192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EwXIoTVaV7c7ogp6tUTthi1R1m80novWJbwMZ2E1Z9E=;
 b=flvJ0mJ1beqgWp69jYHEekT+y9GfuJjZtydzPApXBAhtFgda6cA/Lmx3jsls03OueA
 AlO21b7RPkYCIswkMd8qbsdeZReBHgG2Hml2kAs06jMX0VphpRte9YHSl2/nfoWqgSvh
 v3n3NhTuNcMCktX5CqGGgqAFT1h++oyDYkZbwV+ilDdvGXRYvG0MvHCScZcabqXj2flB
 bT0vCnTMf9JnAXoJU8oNI6sx3JSfa7MXinyEjVBJ/qu2EkWDvpDOkJ0lvnCMEi9jUNeD
 McTfBGqDz6I05PKV6Rh2hS2egmVR8QYIKgdcFJEMJBDiQNjWt/n3e41pS7GRGL7+zqNr
 TMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741127392; x=1741732192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EwXIoTVaV7c7ogp6tUTthi1R1m80novWJbwMZ2E1Z9E=;
 b=EPf+cnrTF86JcfxJGriCOQLxGI1ot+zDz8Od8IHrozx5i7r9uFX8YdP1L9vGldQNBE
 mxJKukXo8QrxyGgkojkPF8j2CHQp+LzYHkkJG+vRuK/EAnYE38GspH5Ik45xeMdI2ewB
 3ziFK1xs13U/JNShETsxgWaXFJ43WWz/C8KsrGE+qVlvKKrxjfnKOCEhcG83qAkTk+Yv
 ahI5uk9jzQzHgo4fAkq5+x2UP6VtbR70/J43Ws5yqWDrxsgRkaZ940vxSUDziGbCCbDt
 sD57zh6m0zXmFPj/CAp7Xsd/5Di+U9KH1Ukc6Gw8U0ygpeEfW2eNc2sIgZ/ibyKF2n13
 67bw==
X-Gm-Message-State: AOJu0YwwY4hFKlrJrAQtwChur6X4RyBfXaWlC/efBdB39n/yg8r0KX2L
 pBaQ77pQvjv7FCtkGkNFfLFGr1E70SMbXuaQ00qwfyVmHMkgeJtbu9ulcmdZTD4=
X-Gm-Gg: ASbGncvS8eY9yNmJDOVYmqKhNkFU6gBwmOVKbxJTXss+SrI04fafaxE3WeoJCmm54uj
 oXFm/5wXCHlVBNLToWCfKXUhdLp39/Ov827Lbel3Vslf7lPDGEXxEPWkGKpQnm9D/n9BnSSpVpf
 FAHYdmhVbxKQy50du+dYAZDNdKgFXNLB0WK+4KAx92MyHR13vHGRUezplFpw5f0lfBFGWloKnd8
 5lD4E+FIljK6oA09vtDoM0GFraB3Uw7oypvOmSZTQCS+SDCPzK8fylSAEhYXMChM6JpkDw8grfN
 I2jNBwTo+KhkgBDsbVs+WGcbCfoJFHWTADgsvu7BB5c6no4=
X-Google-Smtp-Source: AGHT+IFB6ZOjCkpyuw0+RIr033HyKj2C7iEIkHdOZLAj9Y0H+t8i/w4hrHGQQU7ssIrt1fj2N7NFuQ==
X-Received: by 2002:a05:6402:5109:b0:5e0:8c55:532 with SMTP id
 4fb4d7f45d1cf-5e59f3a2351mr781671a12.4.1741127392578; 
 Tue, 04 Mar 2025 14:29:52 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e4c3fb4885sm8699562a12.59.2025.03.04.14.29.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 14:29:50 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 269E8625DB;
 Tue,  4 Mar 2025 22:24:42 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 27/32] plugins/api: split out the vaddr/hwaddr helpers
Date: Tue,  4 Mar 2025 22:24:34 +0000
Message-Id: <20250304222439.2035603-28-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304222439.2035603-1-alex.bennee@linaro.org>
References: <20250304222439.2035603-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

These only work for system-mode and are NOPs for user-mode.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250226140343.3907080-23-alex.bennee@linaro.org>
---
 plugins/api-system.c | 58 ++++++++++++++++++++++++++++++++++++
 plugins/api-user.c   | 40 +++++++++++++++++++++++++
 plugins/api.c        | 70 --------------------------------------------
 plugins/meson.build  |  2 +-
 4 files changed, 99 insertions(+), 71 deletions(-)
 create mode 100644 plugins/api-user.c

diff --git a/plugins/api-system.c b/plugins/api-system.c
index cb0dd8f730..38560de342 100644
--- a/plugins/api-system.c
+++ b/plugins/api-system.c
@@ -12,6 +12,10 @@
 
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
+#include "qapi/error.h"
+#include "migration/blocker.h"
+#include "hw/boards.h"
+#include "qemu/plugin-memory.h"
 #include "qemu/plugin.h"
 
 /*
@@ -37,3 +41,57 @@ uint64_t qemu_plugin_entry_code(void)
 {
     return 0;
 }
+
+/*
+ * Virtual Memory queries
+ */
+
+static __thread struct qemu_plugin_hwaddr hwaddr_info;
+
+struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
+                                                  uint64_t vaddr)
+{
+    CPUState *cpu = current_cpu;
+    unsigned int mmu_idx = get_mmuidx(info);
+    enum qemu_plugin_mem_rw rw = get_plugin_meminfo_rw(info);
+    hwaddr_info.is_store = (rw & QEMU_PLUGIN_MEM_W) != 0;
+
+    assert(mmu_idx < NB_MMU_MODES);
+
+    if (!tlb_plugin_lookup(cpu, vaddr, mmu_idx,
+                           hwaddr_info.is_store, &hwaddr_info)) {
+        error_report("invalid use of qemu_plugin_get_hwaddr");
+        return NULL;
+    }
+
+    return &hwaddr_info;
+}
+
+bool qemu_plugin_hwaddr_is_io(const struct qemu_plugin_hwaddr *haddr)
+{
+    return haddr->is_io;
+}
+
+uint64_t qemu_plugin_hwaddr_phys_addr(const struct qemu_plugin_hwaddr *haddr)
+{
+    if (haddr) {
+        return haddr->phys_addr;
+    }
+    return 0;
+}
+
+const char *qemu_plugin_hwaddr_device_name(const struct qemu_plugin_hwaddr *h)
+{
+    if (h && h->is_io) {
+        MemoryRegion *mr = h->mr;
+        if (!mr->name) {
+            unsigned maddr = (uintptr_t)mr;
+            g_autofree char *temp = g_strdup_printf("anon%08x", maddr);
+            return g_intern_string(temp);
+        } else {
+            return g_intern_string(mr->name);
+        }
+    } else {
+        return g_intern_static_string("RAM");
+    }
+}
diff --git a/plugins/api-user.c b/plugins/api-user.c
new file mode 100644
index 0000000000..867b420339
--- /dev/null
+++ b/plugins/api-user.c
@@ -0,0 +1,40 @@
+/*
+ * QEMU Plugin API - user-mode only implementations
+ *
+ * This provides the APIs that have a user-mode specific
+ * implementations or are only relevant to user-mode.
+ *
+ * Copyright (C) 2017, Emilio G. Cota <cota@braap.org>
+ * Copyright (C) 2019-2025, Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/plugin.h"
+
+/*
+ * Virtual Memory queries - these are all NOPs for user-mode which
+ * only ever has visibility of virtual addresses.
+ */
+
+struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
+                                                  uint64_t vaddr)
+{
+    return NULL;
+}
+
+bool qemu_plugin_hwaddr_is_io(const struct qemu_plugin_hwaddr *haddr)
+{
+    return false;
+}
+
+uint64_t qemu_plugin_hwaddr_phys_addr(const struct qemu_plugin_hwaddr *haddr)
+{
+    return 0;
+}
+
+const char *qemu_plugin_hwaddr_device_name(const struct qemu_plugin_hwaddr *h)
+{
+    return g_intern_static_string("Invalid");
+}
diff --git a/plugins/api.c b/plugins/api.c
index ffccd71e4b..82241699a5 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -383,76 +383,6 @@ qemu_plugin_mem_value qemu_plugin_mem_get_value(qemu_plugin_meminfo_t info)
     return value;
 }
 
-/*
- * Virtual Memory queries
- */
-
-#ifdef CONFIG_SOFTMMU
-static __thread struct qemu_plugin_hwaddr hwaddr_info;
-#endif
-
-struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
-                                                  uint64_t vaddr)
-{
-#ifdef CONFIG_SOFTMMU
-    CPUState *cpu = current_cpu;
-    unsigned int mmu_idx = get_mmuidx(info);
-    enum qemu_plugin_mem_rw rw = get_plugin_meminfo_rw(info);
-    hwaddr_info.is_store = (rw & QEMU_PLUGIN_MEM_W) != 0;
-
-    assert(mmu_idx < NB_MMU_MODES);
-
-    if (!tlb_plugin_lookup(cpu, vaddr, mmu_idx,
-                           hwaddr_info.is_store, &hwaddr_info)) {
-        error_report("invalid use of qemu_plugin_get_hwaddr");
-        return NULL;
-    }
-
-    return &hwaddr_info;
-#else
-    return NULL;
-#endif
-}
-
-bool qemu_plugin_hwaddr_is_io(const struct qemu_plugin_hwaddr *haddr)
-{
-#ifdef CONFIG_SOFTMMU
-    return haddr->is_io;
-#else
-    return false;
-#endif
-}
-
-uint64_t qemu_plugin_hwaddr_phys_addr(const struct qemu_plugin_hwaddr *haddr)
-{
-#ifdef CONFIG_SOFTMMU
-    if (haddr) {
-        return haddr->phys_addr;
-    }
-#endif
-    return 0;
-}
-
-const char *qemu_plugin_hwaddr_device_name(const struct qemu_plugin_hwaddr *h)
-{
-#ifdef CONFIG_SOFTMMU
-    if (h && h->is_io) {
-        MemoryRegion *mr = h->mr;
-        if (!mr->name) {
-            unsigned maddr = (uintptr_t)mr;
-            g_autofree char *temp = g_strdup_printf("anon%08x", maddr);
-            return g_intern_string(temp);
-        } else {
-            return g_intern_string(mr->name);
-        }
-    } else {
-        return g_intern_static_string("RAM");
-    }
-#else
-    return g_intern_static_string("Invalid");
-#endif
-}
-
 int qemu_plugin_num_vcpus(void)
 {
     return plugin_num_vcpus();
diff --git a/plugins/meson.build b/plugins/meson.build
index 9c9bc9e5bb..942b59e904 100644
--- a/plugins/meson.build
+++ b/plugins/meson.build
@@ -58,7 +58,7 @@ if host_os == 'windows'
   )
 endif
 
-user_ss.add(files('user.c'))
+user_ss.add(files('user.c', 'api-user.c'))
 system_ss.add(files('system.c', 'api-system.c'))
 
 common_ss.add(files('loader.c'))
-- 
2.39.5


