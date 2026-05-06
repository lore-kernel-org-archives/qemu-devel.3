Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71635CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:04:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcr3-0000On-Da; Wed, 06 May 2026 10:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcpC-00073E-WE
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:02:12 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcpB-0000rz-7S
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:02:06 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-67179ed133dso7331412a12.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076122; x=1778680922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=G4zI5ovDvmRWdupFowupRxfgjLmaPfxDAhIri/4i3pw=;
 b=yLVhpQNZkPlYysoiqeqePjBiuY0maedPZ96awyno0Nx/XeabJjg2r4nUxYtgCg57If
 7KHpqEFB9ubUMGqmANTjoQTYBYMd0z+U84pvlg9g2z6hVewEvNf3UDAxb7+1aQiGPpwE
 02ro8DuiBbvausfz8KOcj4nGYWnsbk1tHxjCAqfrCEKk0cpDbCRNuzWMotQiyxxRKzvl
 3Mq5byBV9g+bpsymuzOk4V3BaSMdzw7mZaa2K37Nizvo5NZtXxIbnvljkHe/Kp7jJq6G
 qhRHvmb3YYGlEXoAgbCI1E0t8HXkkXO+wyU0KL1pljTgCpDYFu56PwSZPS1MegkLEX2c
 nZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076122; x=1778680922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=G4zI5ovDvmRWdupFowupRxfgjLmaPfxDAhIri/4i3pw=;
 b=psXUWJsnnSD8WNZKWiu/OQxJjMCadounBAwJ3uu/3siJKwgtLdgGvhOfxsOoJsNZsL
 mXiU12VMs7ERJIes+gNc1B17eDT+M+WzVd1Q2etR5q+rqkNvESQRNOvludfzJAas7jOJ
 CsxkoEQiOSvy/EsHOnEYQdSVMMFbYxzrY/G88g+A0sQ/06s85KQCGQZqo9iOScQEUhIe
 9oAXQ0g83Z9fk3QsizXqexLT2qgkPr5GuvNu9DeMD+XqM2ryu9K9DikrV6B3WSvoXdDL
 Lu3ysq4ust+d5oc/kPyIqGYeaLZ6gol6mUcAWpLhS1CwPoaHqaZ1QCvkFOMr23gS8hZJ
 N3gw==
X-Gm-Message-State: AOJu0YyiHmonPyihpEET5WptOy1AWHY3mbqhWZIT2woz8I0i0mi6uMX4
 t0GPapMOJdi11yAAyCC3Co/9z+K7PDoC06QleqXHj/O3dGtPjk/3d3H0yOYkX8VT6QbUNpZg49I
 FzB3gcWw=
X-Gm-Gg: AeBDietR02Vxa3z2z+ZxL9CA34sHU7Wb7ZVht5P7nMGDJFeIPG+K0xRW53XbwvedYT4
 P1geDwbiU4NNzw97jmE78PR86ewXyfnHP0FJngJTs/0rB82gNNDyiyqsppFo4EmSSCXL4WTZVzG
 5sLaeFbzZVqEdckrxnmrfg28Qg3V1GCMUErxXTklRki2rUxIiirjVR00y1uM1m/NEB1dg24kxKn
 ajYO0WsP7XFSWMB5ppdXJMI62zoX7xEkWljALq0aqRny/wsXHEPiCGtKEWZAhfl/DpfI9+/hiGA
 SYCKI/XYTGNslOIBRZtPSLtAG6nVyvYxGHFADSlnzWK/eY65a6KMwJk1QmsLRXjw2kLJkgFak54
 eI0CU6okM9v1SsrzY71MRF/gknBMmSKf1N7CPk6V2OGnHVkviFTDMrhpWlx6Yd6vbbnn/pAClXH
 tGqCNags4gFBKiltyDRKTLBQugj1D7MVrjDo3sYEoP4Y9yAOBub3v+ZT26tXR+5Gn7Sr8b+FSah
 sFtlKai0No=
X-Received: by 2002:a05:6402:380f:b0:671:dffb:f450 with SMTP id
 4fb4d7f45d1cf-67d63d9843cmr1693929a12.11.1778076121719; 
 Wed, 06 May 2026 07:02:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45052a48f63sm12472535f8f.16.2026.05.06.07.01.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:01:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 051/110] monitor: Do not check TARGET_I386 to build 'info sgx'
 command
Date: Wed,  6 May 2026 15:54:23 +0200
Message-ID: <20260506135524.20617-52-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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

This command is filtered at build-time for i386/x86_64 binaries.
By using the recently introduced HMPCommand::arch_bitmask flag
we can filter it at runtime, making it possible to compile
hmp-commands-info.hx once.

Since the method depends on the CONFIG_SGX definition, define it
in its own stub file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260427080738.77138-16-philmd@linaro.org>
---
 MAINTAINERS            |  1 +
 hw/i386/sgx-hmp-stub.c | 16 ++++++++++++++++
 hw/i386/sgx-stub.c     |  5 -----
 hmp-commands-info.hx   |  3 +--
 hw/i386/meson.build    |  1 +
 5 files changed, 19 insertions(+), 7 deletions(-)
 create mode 100644 hw/i386/sgx-hmp-stub.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d022070a74c..7515025e09b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -514,6 +514,7 @@ L: kvm@vger.kernel.org
 S: Supported
 F: docs/system/i386/amd-memory-encryption.rst
 F: docs/system/i386/sgx.rst
+F: hw/i386/sgx*
 F: stubs/qmp-i386-sev.c
 F: stubs/qmp-i386-sgx.c
 F: target/i386/kvm/
diff --git a/hw/i386/sgx-hmp-stub.c b/hw/i386/sgx-hmp-stub.c
new file mode 100644
index 00000000000..cf1d9a6344b
--- /dev/null
+++ b/hw/i386/sgx-hmp-stub.c
@@ -0,0 +1,16 @@
+/*
+ * Human Monitor 'info sgx' stub (CONFIG_SGX)
+ *
+ * Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "monitor/hmp.h"
+#include "monitor/monitor.h"
+
+void hmp_info_sgx(Monitor *mon, const QDict *qdict)
+{
+    monitor_printf(mon, "SGX is not available in this QEMU\n");
+}
diff --git a/hw/i386/sgx-stub.c b/hw/i386/sgx-stub.c
index 1dd8d9afbfa..2b083c77bc1 100644
--- a/hw/i386/sgx-stub.c
+++ b/hw/i386/sgx-stub.c
@@ -23,11 +23,6 @@ SgxInfo *qmp_query_sgx_capabilities(Error **errp)
     return NULL;
 }
 
-void hmp_info_sgx(Monitor *mon, const QDict *qdict)
-{
-    monitor_printf(mon, "SGX is not available in this QEMU\n");
-}
-
 void pc_machine_init_sgx_epc(PCMachineState *pcms)
 {
     memset(&pcms->sgx_epc, 0, sizeof(SGXEPCState));
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 65af86278b4..576adbbf5a6 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -859,15 +859,14 @@ SRST
     Display the vcpu dirty page limit information.
 ERST
 
-#if defined(TARGET_I386)
     {
         .name       = "sgx",
         .args_type  = "",
         .params     = "",
         .help       = "show intel SGX information",
         .cmd        = hmp_info_sgx,
+        .arch_bitmask = QEMU_ARCH_I386,
     },
-#endif
 
 SRST
   ``info sgx``
diff --git a/hw/i386/meson.build b/hw/i386/meson.build
index 63ae57baa51..b611fbb5a7f 100644
--- a/hw/i386/meson.build
+++ b/hw/i386/meson.build
@@ -24,6 +24,7 @@ i386_ss.add(when: 'CONFIG_VTD', if_true: files('intel_iommu.c'))
 i386_ss.add(when: 'CONFIG_VTD_ACCEL', if_true: files('intel_iommu_accel.c'))
 i386_ss.add(when: 'CONFIG_SGX', if_true: files('sgx-epc.c','sgx.c'),
                                 if_false: files('sgx-stub.c'))
+stub_ss.add(files('sgx-hmp-stub.c'))
 
 i386_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-common.c'))
 i386_ss.add(when: 'CONFIG_PC', if_true: files(
-- 
2.53.0


