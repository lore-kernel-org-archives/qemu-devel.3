Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D870DCD4F21
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 17:17:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOIdP-0003pa-Pn; Sat, 16 May 2026 13:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOId8-0003bo-RM
 for qemu-devel@nongnu.org; Sat, 16 May 2026 13:16:58 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOId7-0008BX-0c
 for qemu-devel@nongnu.org; Sat, 16 May 2026 13:16:50 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488ad135063so5767005e9.0
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 10:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778951808; x=1779556608; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hV4e73UNbUO8rrTdoZ6Judcl7l+pcK6HO82RHoEBX8M=;
 b=xLVQZ1DU+4QQo02BqSLq7k1GWXdU1fll4Z7KmrtKsvkdhPOrUn0NMbKUN5lwzgvHhq
 C3frGrnLwH7/oRrQgXgKv4kMzr7IvcSLZUUGCnGhSpYG8d0VN4y6EDT7eIUNdBodRem0
 liC6unFlcRq6ZCLm6ESnCCXd2U1orrgro1j4bfGKSjrw7oSBnb2GpddGF/lYJ4YE9w8l
 io3iU84cVsinmVmWHkE7EqjY/syYdkVcC1RtY1O4Dsl2X7rV9SjZsDHQsAh8q2Ici+Ll
 9ttJh0flEbhOUPAUfAD4s0tQlkhPEJHNVY0vR7Os+CIZL+iEZOYIHZbq8qoKihSQ/nLq
 9h8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778951808; x=1779556608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hV4e73UNbUO8rrTdoZ6Judcl7l+pcK6HO82RHoEBX8M=;
 b=rnO2z78xm7crBrUxUza0bmLn9yBXwIKHPt3SMIJiEJoJEX0E8AaPVmfD5moN4s4v8g
 1JxCvClSwSaftez5AK59lyKp6Dg6pEB6bjTF9egHOVJclLYZPF93QhENvNEBqePdB1Y+
 WlwMh09by+OCI2crCfw31ompfrWn+4Wq/bPJOySfZXd1nQvn0r1jp9nzyA8bkH4A4yrK
 LPLDcZSaXysnglX8WwJYPkS9wzB1QWiR0tQfc4Wq8DH+lnhm85Vkt7DrDjNLNWrWXmq2
 DGjfsXeS0p8eOs89LCrSQiC0tvjs+ALdTgpJRTmyfV0kLDoRrL8Wi9cqcjDU0o10gYfX
 w/Yg==
X-Gm-Message-State: AOJu0YzSHGzh87n01k+xjeDXNtZ0oDCaF3f44TPlhgNTQJ+zH55WLPvT
 rSiA2X19qNJRjCun0whdBVaEHcSiPLQRoehrFDkUEMIk5YdkjGWN1unKlQrUyulxVmt2pMLAbYT
 7iRD93ps=
X-Gm-Gg: Acq92OGDWOoOZNhofRbypkJ2p1rZoHW1nyMo/a8DrNplGfYEuGnGebxtujx+jwSb3aH
 MDxY0PFUXYaP+whDUmDnm9yqgchqjcmkBFZ12dJuBsiehzKDymfZmsv3qagD1mcW9nMOvbND1pQ
 W7E8VwFebnWA1OCqPRV/NnDaLJlbMvylh8U//oPiWx88f7nI8aqeA35hE26tZz4D8d6Bpna5Mk1
 zLAnxWhukjdQMYsTJpvkHI3LeUlQPDKdEATik+xCXBXZvNUiuBm6bo5ePowtQAmb9gom/MBTRxK
 /sW9Nog7Y5gg/mP+c/x3/yitujL0dOWnNllrO2jD+9QQq8K5v6GZh1xXcMR/Ba4gBNUJs3rkcTf
 qfhjVUI7dxu9ucEsRtwF8ppu0vwQNVOFMJWpbQf4L0DhprwEK+bU2AW2dGmbukWtZW1auIaDGX4
 GyTGgaJFN+7q8J/NYlkk0Zvt1YXWb+yPIANKWh0+mn6esFrkyNSWt/5m2oh6QjW0M+Ffc/dD2K
X-Received: by 2002:a05:600c:8b45:b0:489:1ba8:5bf0 with SMTP id
 5b1f17b1804b1-48fe63253f3mr116708325e9.21.1778951807634; 
 Sat, 16 May 2026 10:16:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe5cab818sm143121975e9.14.2026.05.16.10.16.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 16 May 2026 10:16:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Steven Lee <steven_lee@aspeedtech.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Joel Stanley <joel@jms.id.au>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Troy Lee <leetroy@gmail.com>,
 qemu-arm@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v7 11/21] target/arm: Restrict IDAU interface to TCG namespace
Date: Sat, 16 May 2026 19:15:13 +0200
Message-ID: <20260516171524.19184-12-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260516171524.19184-1-philmd@linaro.org>
References: <20260516171524.19184-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Emphasize the IDAU interface is restricted to TCG by moving the
header under target/arm/tcg/. Move the definition to cpu-v7m.c
which also contains v7/v8 hardware (NVIC), keeping only CPU types
in cpu32.c.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/armv7m.h     |  2 +-
 include/hw/misc/tz-msc.h    |  2 +-
 target/arm/{ => tcg}/idau.h |  4 ++--
 hw/arm/armv7m.c             |  2 +-
 target/arm/cpu.c            |  2 +-
 target/arm/ptw.c            |  2 +-
 target/arm/tcg/cpu-v7m.c    | 11 +++++++++++
 target/arm/tcg/cpu32.c      |  8 --------
 8 files changed, 18 insertions(+), 15 deletions(-)
 rename target/arm/{ => tcg}/idau.h (97%)

diff --git a/include/hw/arm/armv7m.h b/include/hw/arm/armv7m.h
index 98ad08db036..70555962bb9 100644
--- a/include/hw/arm/armv7m.h
+++ b/include/hw/arm/armv7m.h
@@ -13,7 +13,7 @@
 #include "hw/core/sysbus.h"
 #include "hw/intc/armv7m_nvic.h"
 #include "hw/misc/armv7m_ras.h"
-#include "target/arm/idau.h"
+#include "target/arm/tcg/idau.h"
 #include "qom/object.h"
 #include "hw/core/clock.h"
 
diff --git a/include/hw/misc/tz-msc.h b/include/hw/misc/tz-msc.h
index 07112d8caa3..6cf4c6b09eb 100644
--- a/include/hw/misc/tz-msc.h
+++ b/include/hw/misc/tz-msc.h
@@ -51,7 +51,7 @@
 #define TZ_MSC_H
 
 #include "hw/core/sysbus.h"
-#include "target/arm/idau.h"
+#include "target/arm/tcg/idau.h"
 #include "qom/object.h"
 
 #define TYPE_TZ_MSC "tz-msc"
diff --git a/target/arm/idau.h b/target/arm/tcg/idau.h
similarity index 97%
rename from target/arm/idau.h
rename to target/arm/tcg/idau.h
index 0ef5251971d..e5736ad848d 100644
--- a/target/arm/idau.h
+++ b/target/arm/tcg/idau.h
@@ -25,8 +25,8 @@
  * connected to the CPU using a link property.
  */
 
-#ifndef TARGET_ARM_IDAU_H
-#define TARGET_ARM_IDAU_H
+#ifndef TARGET_ARM_TCG_IDAU_H
+#define TARGET_ARM_TCG_IDAU_H
 
 #include "qom/object.h"
 
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index a29eab6c915..68a1cbd6316 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -20,7 +20,7 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qemu/log.h"
-#include "target/arm/idau.h"
+#include "target/arm/tcg/idau.h"
 #include "target/arm/cpu.h"
 #include "target/arm/cpu-features.h"
 #include "target/arm/cpu-qom.h"
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 31e0a12a986..a4eb6a2de5e 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -24,7 +24,7 @@
 #include "qemu/log.h"
 #include "exec/page-vary.h"
 #include "system/whpx.h"
-#include "target/arm/idau.h"
+#include "target/arm/tcg/idau.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "cpu.h"
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 8706dd59dd6..a4842a4b62b 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -17,7 +17,7 @@
 #include "cpu.h"
 #include "internals.h"
 #include "cpu-features.h"
-#include "idau.h"
+#include "target/arm/tcg/idau.h"
 
 typedef struct S1Translate {
     /*
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index dc249ce1f14..02abd831e6a 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -11,6 +11,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "accel/tcg/cpu-ops.h"
+#include "target/arm/tcg/idau.h"
 #include "internals.h"
 
 #if !defined(CONFIG_USER_ONLY)
@@ -40,6 +41,16 @@ static bool arm_v7m_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     return ret;
 }
 
+static const TypeInfo arm_v8m_types[] = {
+    {
+        .name = TYPE_IDAU_INTERFACE,
+        .parent = TYPE_INTERFACE,
+        .class_size = sizeof(IDAUInterfaceClass),
+    }
+};
+
+DEFINE_TYPES(arm_v8m_types)
+
 #endif /* !CONFIG_USER_ONLY */
 
 static void cortex_m0_initfn(Object *obj)
diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index 2127d456ad6..73d21c6cf7d 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -12,7 +12,6 @@
 #include "cpu.h"
 #include "accel/tcg/cpu-ops.h"
 #include "internals.h"
-#include "target/arm/idau.h"
 #if !defined(CONFIG_USER_ONLY)
 #include "hw/core/boards.h"
 #endif
@@ -899,17 +898,10 @@ static const ARMCPUInfo arm_tcg_cpus[] = {
 #endif
 };
 
-static const TypeInfo idau_interface_type_info = {
-    .name = TYPE_IDAU_INTERFACE,
-    .parent = TYPE_INTERFACE,
-    .class_size = sizeof(IDAUInterfaceClass),
-};
-
 static void arm_tcg_cpu_register_types(void)
 {
     size_t i;
 
-    type_register_static(&idau_interface_type_info);
     for (i = 0; i < ARRAY_SIZE(arm_tcg_cpus); ++i) {
         arm_cpu_register(&arm_tcg_cpus[i]);
     }
-- 
2.53.0


