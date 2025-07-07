Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C7BBC71130
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 17:22:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYpXF-0001uG-M9; Mon, 07 Jul 2025 13:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uYpW5-0000Vh-0w
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 13:20:37 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uYpVx-00051i-UD
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 13:20:28 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-454cc6e987dso1748125e9.0
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 10:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751908822; x=1752513622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YHZVDxqmNYoTl1VtUEuGuCVslQK6vMHQOasVIFp7MBk=;
 b=kewiTgaJceFTQzpXqB2vbBtgQCVcnHeSa2Vr6ebf9gWpEO6pjL46S04Ky2aSYOfM/m
 KT7MYowWPunOIzePxoKZ5TRBJQm5D3P5Hp383yrU2cYPA9x45FLthcP19MjLMB+pZ2nl
 +d2/5lZk3CQQxdo4vBI9jCz0eR5/HV/ZnB1b4J+RlDyo/NLHDcDmfQ/v2BXi8fAkZZzT
 dDZrN4Y9/ZKvANdCPxIzTFWttHc3wxFZ+Go8BSPiJcFnsg4EIelz2dBpYDabPzCHQIec
 qoi0Bc/19qx3lzXFPxNjBUjWkeGYoEdSokTifHSTzOX1mFrbq0I5adAoT1WfIzuH7ZQ2
 /w0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751908822; x=1752513622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YHZVDxqmNYoTl1VtUEuGuCVslQK6vMHQOasVIFp7MBk=;
 b=hF19i/G6dAVn/axuNj0Puo/DacbDjnK6S88CLVIQBeWyNsiP8gjmEie0vTMgw0wlDe
 WbuMvrmg5Pw4IgAK0zaWBvsnvHn35RI2OnGxEUhrveKg3GpA+lX/7UyxD5z4mKBwa4nt
 Aws3PtZbAFLQ/b+NhPMhgwO+/OWAzdsvvHVYTy1KWvBp7mddntKmsMeH+uE+7Gp7ltDO
 fgkS5V7Wy+Xu7yGL6JQkgbDZwzTUp+KW9ZnAmOXY4W+seyUrs+ybFVMYDk8hHOynHhBp
 dZ6LPmlkoQ9gdJWvSSCVEnsIXOHj2DvcP/0Svo4vL9HC/bcF3lsIufZyst6yBjpk7FPP
 t5Pg==
X-Gm-Message-State: AOJu0YzY2+BYsM+gHEHoJ+lXEjIsoSw0J3yJ8jtg3Ga96iB5dfxVoFrh
 FEKAryL19tRxmGhynfYNmoEZaeTPB3JT0Pf3h8xwofdiTBbVGlZbbCDGIKFJEEY+NzNmNv3lflj
 bVsFtWFc=
X-Gm-Gg: ASbGncv3uS+rPcgGFwazisBELYt+/+QPnIO8HoivIxc7yhx67Gg30MUCgH0AHzWDw5C
 juU/a+jpto9T5cJieunbkPLuv3gQejOettod2yx1fWNEGgodOxt6bc28hywVxBFiM0w4bt4U3Ni
 Vky8EVL0UgFNjdZ9Wo8OSV0mPg9/57X2Ei8j6T9b6Q9DB01NOTrnVpkZFm5yRKGBiZIl0Pc5Kvt
 3mk3mboW/ogkPyux/ScMjGI15KFLOSWbK7SvI6XR7mWoCwHdJnXaSJjdsmiuF2UmrVUIO+X7RdP
 ZnLrH0mJvEP8gaDF9KVfQU0WB2Ts4x9BzKSulPwfD/uHwtzqJAD4kSSXaii4Yq12FMC8XsIrSYs
 w46Odtv1b2QGiLRI+qW2C66NY0Q7/kl5au8M0
X-Google-Smtp-Source: AGHT+IGJWyLS8lgTHM5f90/ohERSYYo8nxRNDz3UptV3SZAweJlFBaD/aoNOl7V4tLgRk+G+NoreSg==
X-Received: by 2002:a05:600c:3f15:b0:43d:5264:3cf0 with SMTP id
 5b1f17b1804b1-454ccde169dmr3783675e9.11.1751908821686; 
 Mon, 07 Jul 2025 10:20:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9969f2asm153421035e9.8.2025.07.07.10.20.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 07 Jul 2025 10:20:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-block@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH-for-10.1 v6 02/14] qemu/target-info: Factor target_arch() out
Date: Mon,  7 Jul 2025 19:19:56 +0200
Message-ID: <20250707172009.3884-3-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250707172009.3884-1-philmd@linaro.org>
References: <20250707172009.3884-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

To keep "qemu/target-info.h" self-contained to native
types, declare target_arch() -- which returns a QAPI
type -- in "qemu/target-info-qapi.h".

No logical change.

Keeping native types in "qemu/target-info.h" is necessary
to keep building tests such tests/tcg/plugins/mem.c, as
per the comment added in commit ecbcc9ead2f ("tests/tcg:
add a system test to check memory instrumentation"):

/*
 * plugins should not include anything from QEMU aside from the
 * API header. However as this is a test plugin to exercise the
 * internals of QEMU and we want to avoid needless code duplication we
 * do so here. bswap.h is pretty self-contained although it needs a
 * few things provided by compiler.h.
 */

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/target-info-qapi.h | 21 +++++++++++++++++++++
 include/qemu/target-info.h      |  2 +-
 hw/core/machine-qmp-cmds.c      |  8 +++-----
 target-info.c                   |  8 ++++++++
 4 files changed, 33 insertions(+), 6 deletions(-)
 create mode 100644 include/qemu/target-info-qapi.h

diff --git a/include/qemu/target-info-qapi.h b/include/qemu/target-info-qapi.h
new file mode 100644
index 00000000000..dae92c47eb1
--- /dev/null
+++ b/include/qemu/target-info-qapi.h
@@ -0,0 +1,21 @@
+/*
+ * QEMU target info API (returning QAPI types)
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_TARGET_INFO_EXTRA_H
+#define QEMU_TARGET_INFO_EXTRA_H
+
+#include "qapi/qapi-types-machine.h"
+
+/**
+ * target_arch:
+ *
+ * Returns: QAPI SysEmuTarget enum (i.e. SYS_EMU_TARGET_X86_64).
+ */
+SysEmuTarget target_arch(void);
+
+#endif
diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 850a2958b9c..dde0e7d968a 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -1,5 +1,5 @@
 /*
- * QEMU target info API
+ * QEMU target info API (returning native types)
  *
  *  Copyright (c) Linaro
  *
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index d82043e1c68..cd98daedd18 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -19,7 +19,7 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/type-helpers.h"
 #include "qemu/uuid.h"
-#include "qemu/target-info.h"
+#include "qemu/target-info-qapi.h"
 #include "qom/qom-qobject.h"
 #include "system/hostmem.h"
 #include "system/hw_accel.h"
@@ -37,8 +37,7 @@ CpuInfoFastList *qmp_query_cpus_fast(Error **errp)
     MachineState *ms = MACHINE(qdev_get_machine());
     MachineClass *mc = MACHINE_GET_CLASS(ms);
     CpuInfoFastList *head = NULL, **tail = &head;
-    SysEmuTarget target = qapi_enum_parse(&SysEmuTarget_lookup, target_name(),
-                                          -1, &error_abort);
+    SysEmuTarget target = target_arch();
     CPUState *cpu;
 
     CPU_FOREACH(cpu) {
@@ -139,8 +138,7 @@ QemuTargetInfo *qmp_query_target(Error **errp)
 {
     QemuTargetInfo *info = g_malloc0(sizeof(*info));
 
-    info->arch = qapi_enum_parse(&SysEmuTarget_lookup, target_name(), -1,
-                                 &error_abort);
+    info->arch = target_arch();
 
     return info;
 }
diff --git a/target-info.c b/target-info.c
index 16fdca7aaaf..9ebabec988f 100644
--- a/target-info.c
+++ b/target-info.c
@@ -8,7 +8,9 @@
 
 #include "qemu/osdep.h"
 #include "qemu/target-info.h"
+#include "qemu/target-info-qapi.h"
 #include "qemu/target-info-impl.h"
+#include "qapi/error.h"
 
 const char *target_name(void)
 {
@@ -20,6 +22,12 @@ unsigned target_long_bits(void)
     return target_info()->long_bits;
 }
 
+SysEmuTarget target_arch(void)
+{
+    return qapi_enum_parse(&SysEmuTarget_lookup, target_name(), -1,
+                           &error_abort);
+}
+
 const char *target_cpu_type(void)
 {
     return target_info()->cpu_type;
-- 
2.49.0


