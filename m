Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B44E87859
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 19:41:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnMHC-0001Dl-4l; Tue, 03 Feb 2026 14:41:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vnMHA-0001D4-MM
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 14:41:28 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vnMH8-0007fr-2f
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 14:41:28 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-823081bb15fso3213308b3a.3
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 11:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770147682; x=1770752482; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tNch/NZVRM4B+c69aO2dpv1jQL7rSCqQ/27B6FOhbdw=;
 b=j/CUORUP4vBPUiTGaFTRHRwEkvd2ES96Bf2YjZ6GP88pal4obKpuSsBTenD5RRiXJB
 VM6YbYQS1NtP/85ldfCS+pfUu44ooBFjySnBBp+lGqjApDEgGKw3mJgiEMrXSDaJjTtu
 +WZidB2Z+7qEiwO86Fy94PCSa5Rs8xwQnWb2vRcnMscTQQHRbSYJSRlH3DJbY5KggdkU
 XoIeZRosaFkz4JewlZ2U8fJEOq9/rQUvaAYesPpfKP5d52ShvUgUbuRe5ZsaHFafPjNg
 VuTTPzEKA9yB7LQQZXuT0jqXULdu7lvkEVToGXtfEeXtBYzlbcK4bYzGR0Gho5up2WAZ
 LnBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770147682; x=1770752482;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tNch/NZVRM4B+c69aO2dpv1jQL7rSCqQ/27B6FOhbdw=;
 b=sYQ8do2Cg+3H/Vf0VxiIfKsX/3qjN8to5aokeYWOi6iYNWl4iV1BC1AvQw/tMtvKyq
 QQew4KAzZ93WqyeTt+/+NKUfZbwt0KUIdgnjDtonnkurD4KI94Pvxor5hnR6oybCWzgx
 JejCbazEM/FNf75dN66vR4pTow4AwTH11EsPLU6us1nSlw1kzhalb2i09Gzyqua4JuZ2
 5r0qlrbl0kYNIyjzr29d/9+x28chvmAhGvdqxHNVqqbU+bxK02j9swpDG8BBrLFQ8KSj
 vcFF29+KA6bwI3ybh2N0kgJbPLfOzayFOp/djIojklgDSI9RoKSMxDf1kBO+RDrPlLeP
 sxQQ==
X-Gm-Message-State: AOJu0YyBgJ5qAuvCcikVcsZmNKKmcryldPJD9jt8rWQ6c4D/kGEMXEYQ
 EavLp/HMGbtL7Njsq8dcpi55eRukgzQX2QjwNNOlTDGF8izWYTmMCvDvyftDoHb+ZD4r/kwArwo
 n5RkY
X-Gm-Gg: AZuq6aIFJkRSS4MnCblhqYP/elEeeYT99wcmV2ODx3WxfqN9x29oGFWp3B8VNyuHGa9
 9CnhbDJ5pqrsvzVW6tC5+wqXXnVeLKL5UmvoZ3gGBywL1jR/9EQXCGpJSAwOXVfO3bggogZFZq2
 POpkSeNz3NIndPqPnhDrQuCei83wHPy6kJf2GToZJGfJ1BJDag/LHcy/w702DixNhv6xO0BV1wB
 +4YX7mOhlIu/upubEUbHqZJ++WOe43Rtnq+qiRgxhdvwsIFIATWfpPyW2Q4bAe+piiwgkfiwhZv
 hLoKLFKTi40cMNixTgSO+gCX4qlYWGu0vG22GeyYvouDOLfHPli749qgXF4aZMMjBsjbCICiDlw
 LC8CVh3b+HicIlr5oatkVIOjqzcWJT9LbHyll+R3P9aBKCfWfUWAB1CjwYrT6VAAMSSegBN4gmZ
 jb2nOIQEvSdIkYt6j3ikVc8OYBYvUjbb7dXb+p21agm38XZhsjIWmrVx3oI7N2fsAM
X-Received: by 2002:a05:6a21:3d83:b0:393:74ed:7dca with SMTP id
 adf61e73a8af0-39374ed8228mr3561637.37.1770147681688; 
 Tue, 03 Feb 2026 11:41:21 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6c8572b4e7sm92395a12.33.2026.02.03.11.41.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 11:41:21 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 richard.henderson@linaro.org
Subject: [PATCH] target-info: set target_arch statically
Date: Tue,  3 Feb 2026 11:41:13 -0800
Message-ID: <20260203194113.3026757-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

target_arch() function will reparse target_name() every time if it was
not set to a proper SYS_EMU_TARGET_* value (when using
target-info-stub.c), which is not efficient.

Since we want to preserve the constness of TargetInfo but C doesn't give
us flexible compile time expressions, we simply set target_arch using a
static constructor once instead.

This was found when doing changes to virtio_access_is_big_endian()
function, having an overhead of 50% after switching to runtime checks.
With this, overhead left is around 3%, due to indirect function
calls.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target-info-stub.c | 11 ++++++++++-
 target-info.c      |  9 +--------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/target-info-stub.c b/target-info-stub.c
index 8392d81e8f8..ff86a02247a 100644
--- a/target-info-stub.c
+++ b/target-info-stub.c
@@ -10,13 +10,14 @@
 #include "qemu/target-info.h"
 #include "qemu/target-info-impl.h"
 #include "hw/core/boards.h"
+#include "qapi/error.h"
 #include "cpu.h"
 
 /* Validate correct placement of CPUArchState. */
 QEMU_BUILD_BUG_ON(offsetof(ArchCPU, parent_obj) != 0);
 QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));
 
-static const TargetInfo target_info_stub = {
+static TargetInfo target_info_stub = {
     .target_name = TARGET_NAME,
     .target_arch = SYS_EMU_TARGET__MAX,
     .long_bits = TARGET_LONG_BITS,
@@ -29,3 +30,11 @@ const TargetInfo *target_info(void)
 {
     return &target_info_stub;
 }
+
+__attribute__((constructor))
+static void init_target_arch(void)
+{
+    target_info_stub.target_arch = qapi_enum_parse(&SysEmuTarget_lookup,
+                                                   target_name(), -1,
+                                                   &error_abort);
+}
diff --git a/target-info.c b/target-info.c
index 24696ff4111..c3c0856d01a 100644
--- a/target-info.c
+++ b/target-info.c
@@ -10,7 +10,6 @@
 #include "qemu/target-info.h"
 #include "qemu/target-info-qapi.h"
 #include "qemu/target-info-impl.h"
-#include "qapi/error.h"
 
 const char *target_name(void)
 {
@@ -24,13 +23,7 @@ unsigned target_long_bits(void)
 
 SysEmuTarget target_arch(void)
 {
-    SysEmuTarget arch = target_info()->target_arch;
-
-    if (arch == SYS_EMU_TARGET__MAX) {
-        arch = qapi_enum_parse(&SysEmuTarget_lookup, target_name(), -1,
-                               &error_abort);
-    }
-    return arch;
+    return target_info()->target_arch;
 }
 
 const char *target_cpu_type(void)
-- 
2.47.3


