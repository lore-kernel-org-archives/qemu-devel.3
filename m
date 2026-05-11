Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA774CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 19:07:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMVy4-0002LT-67; Mon, 11 May 2026 15:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wMVxj-0002JY-US
 for qemu-devel@nongnu.org; Mon, 11 May 2026 15:06:45 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wMVxh-00086R-PQ
 for qemu-devel@nongnu.org; Mon, 11 May 2026 15:06:43 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-47cacb4ed99so3025634b6e.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 12:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778526401; x=1779131201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JNeU90ONlcyG7CR2NzocXsDCE+v8Zb8u7b70G8mFHiM=;
 b=R3l9p9DtVREZluK738PuCOk0k6cJy/Q1V/Mkm1xozNbSKQsKYjcLuksMuR08bsrBGV
 Vr8G5aD8WrBCYoX4JbfMlRaEwS2llcuCynf0vBTMR1N719xDn8iCSr7ICZ9/ZcUZ0u2A
 LXNV5onDLFSEDJgVxrI2uepzdz0q0H6TYlLJs2OjHHc5NrBmriz7EyhyciGYNLEk6Ym1
 uK0Pm3/BlPcEP8gZw5Sljyim4AmTM8i7WIAK1jZ+JJUXMtSqX2xky7XMZvFltShThW3H
 oZAKHSXtc8tA5eYst8P0wFBGExhv+shNbriQbOhYV4V/9WZfppOwwFhpyvj4SZyZEn/9
 3Fvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778526401; x=1779131201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JNeU90ONlcyG7CR2NzocXsDCE+v8Zb8u7b70G8mFHiM=;
 b=SfjdA5pYgRd8ngzv639Ahjg2KFq9KdRwLIKFQcT+iqYDnG9YZZtq1P9WkJAdA0kQY/
 Y9auethKdmq9uKn8SZq6Uwfu2BeJLvzoiGg/qFoMfjgVv/V5hn7eaefTt5KhTd9dnB6G
 MqjCSFgPG9K+5rIAF1FjagB2uaSVa2IS09Tzy126rzq+2kZEj7szGPiAwi1rv8+Z+QLG
 5z/fhS65FQd7f+PptAPc7SZqhbSZ7YCQ5bH1PBEMgMV6wqQ45BXuY7m5RsDJLdPQb9fG
 FtvnDXJyWJY2E81j010YCiDxLn41DqQjmhd2KWwxpQbaiBAGEbJcpcTkm1tacR9D22cU
 Wm1Q==
X-Gm-Message-State: AOJu0Yx1dCYhx1EGatl0rCQMvUg+fh/rknzjmtiOSpLxmucswcVEAXT/
 MXLes7F9/RI/CdqAf6RCh/udkdGmgsTOcCGv8GHnUgs0evjDFvIm03iRKwvRq+eZrJiYLJrrdwb
 Mcnhb
X-Gm-Gg: Acq92OHrnaPbyg4m4C0NXCHSykhffB5IAd6f1FwAfjwORzCbAPe6NtGLFh0SrJNyk1e
 rTo9VgC6CLyEGRKV6/SsRubj1GhjtWcCV/HkB9+v7Ru/b9Hz96mMZxnS67T3c5hjghZW5LXBS3C
 mlpNXxB7g7dg8giexkNuczdAbBwPq5UffhmgepD8Ps0el1HnwAx1etCheI/ZMyWBDTxc85ww21M
 kx2GYny0NT8phz+phwalXbLq+leZxfOffcNkeatJZAlswUOnMv2fm/tZ/bze01mozPSHby2wALE
 JYeewE4wCqXKufsoFntRcbXoXedUTS2Y+H8F9OUfK4R9NSH2N5aEfsP9Z0edkjNSe8pTYvUFJEV
 g+GUodiJSxCyhRl1eCMO4CIRSF0T57t1XgGVHhUPH40D8xjSKdB0q4njO+alhPMNLiIKkNpN2WS
 pE5dAyFZp5t8SdVp7KUN2U5nkoJeLdluXxw9fQVBd+yVQsVw==
X-Received: by 2002:a05:6808:1a27:b0:479:ffcf:52d7 with SMTP id
 5614622812f47-4824ab6b061mr6252420b6e.46.1778526400490; 
 Mon, 11 May 2026 12:06:40 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:e3e5:757d:3cef:3491])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d8feb1sm7157011a34.23.2026.05.11.12.06.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 12:06:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@oss.qualcomm.com,
	philmd@linaro.org
Subject: [PATCH 3/5] target-info: Merge target-info-impl.h into target-info.h
Date: Mon, 11 May 2026 14:06:32 -0500
Message-ID: <20260511190634.472174-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511190634.472174-1-richard.henderson@linaro.org>
References: <20260511190634.472174-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/target-info-impl.h   | 43 -------------------------------
 include/qemu/target-info-qom.h    |  2 +-
 include/qemu/target-info.h        | 31 ++++++++++++++++++++++
 configs/targets/aarch64-softmmu.c |  2 +-
 configs/targets/arm-softmmu.c     |  2 +-
 page-vary-common.c                |  2 +-
 page-vary-system.c                |  2 +-
 target-info-qom.c                 |  2 +-
 target-info-stub.c                |  1 -
 target-info.c                     |  1 -
 10 files changed, 37 insertions(+), 51 deletions(-)
 delete mode 100644 include/qemu/target-info-impl.h

diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-info-impl.h
deleted file mode 100644
index df94af4ef3..0000000000
--- a/include/qemu/target-info-impl.h
+++ /dev/null
@@ -1,43 +0,0 @@
-/*
- * QEMU TargetInfo structure definition
- *
- *  Copyright (c) Linaro
- *
- * SPDX-License-Identifier: GPL-2.0-or-later
- */
-
-#ifndef QEMU_TARGET_INFO_IMPL_H
-#define QEMU_TARGET_INFO_IMPL_H
-
-#include "qapi/qapi-types-common.h"
-#include "qapi/qapi-types-machine.h"
-
-typedef struct TargetInfo {
-    /* runtime equivalent of TARGET_NAME definition */
-    const char *target_name;
-    /* related to TARGET_ARCH definition */
-    SysEmuTarget target_arch;
-    /* runtime equivalent of TARGET_LONG_BITS definition */
-    unsigned long_bits;
-    /* runtime equivalent of CPU_RESOLVING_TYPE definition */
-    const char *cpu_type;
-    /* QOM typename machines for this binary must implement */
-    const char *machine_typename;
-    /* related to TARGET_BIG_ENDIAN definition */
-    EndianMode endianness;
-    /*
-     * runtime equivalent of
-     *   TARGET_PAGE_BITS_VARY ? TARGET_PAGE_BITS_LEGACY : TARGET_PAGE_BITS
-     */
-    unsigned page_bits_init;
-    /* runtime equivalent of TARGET_PAGE_BITS_VARY definition */
-    bool page_bits_vary;
-} TargetInfo;
-
-extern
-#ifndef NONCONST_TARGET_INFO
-const
-#endif
-TargetInfo target_info;
-
-#endif
diff --git a/include/qemu/target-info-qom.h b/include/qemu/target-info-qom.h
index 91be415ed3..fedb1a2914 100644
--- a/include/qemu/target-info-qom.h
+++ b/include/qemu/target-info-qom.h
@@ -9,7 +9,7 @@
 #ifndef QEMU_TARGET_INFO_QOM_H
 #define QEMU_TARGET_INFO_QOM_H
 
-#include "qemu/target-info-impl.h"
+#include "qemu/target-info.h"
 #include "qom/object.h"
 
 #define TYPE_TARGET_INFO "target-info"
diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 23c997de54..c9f7f2aa26 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -9,6 +9,37 @@
 #ifndef QEMU_TARGET_INFO_H
 #define QEMU_TARGET_INFO_H
 
+#include "qapi/qapi-types-common.h"
+#include "qapi/qapi-types-machine.h"
+
+typedef struct TargetInfo {
+    /* runtime equivalent of TARGET_NAME definition */
+    const char *target_name;
+    /* related to TARGET_ARCH definition */
+    SysEmuTarget target_arch;
+    /* runtime equivalent of TARGET_LONG_BITS definition */
+    unsigned long_bits;
+    /* runtime equivalent of CPU_RESOLVING_TYPE definition */
+    const char *cpu_type;
+    /* QOM typename machines for this binary must implement */
+    const char *machine_typename;
+    /* related to TARGET_BIG_ENDIAN definition */
+    EndianMode endianness;
+    /*
+     * runtime equivalent of
+     *   TARGET_PAGE_BITS_VARY ? TARGET_PAGE_BITS_LEGACY : TARGET_PAGE_BITS
+     */
+    unsigned page_bits_init;
+    /* runtime equivalent of TARGET_PAGE_BITS_VARY definition */
+    bool page_bits_vary;
+} TargetInfo;
+
+extern
+#ifndef NONCONST_TARGET_INFO
+const
+#endif
+TargetInfo target_info;
+
 /**
  * target_name:
  *
diff --git a/configs/targets/aarch64-softmmu.c b/configs/targets/aarch64-softmmu.c
index 4f43f3e89a..f0631353ee 100644
--- a/configs/targets/aarch64-softmmu.c
+++ b/configs/targets/aarch64-softmmu.c
@@ -10,7 +10,7 @@
 #include "hw/arm/machines-qom.h"
 #include "target/arm/cpu-qom.h"
 #include "target/arm/cpu-param.h"
-#include "qemu/target-info-impl.h"
+#include "qemu/target-info.h"
 #include "qemu/target-info-init.h"
 
 DEF_TARGET_INFO(target_info_aarch64_system,
diff --git a/configs/targets/arm-softmmu.c b/configs/targets/arm-softmmu.c
index 8272ce58fd..606b42befa 100644
--- a/configs/targets/arm-softmmu.c
+++ b/configs/targets/arm-softmmu.c
@@ -10,7 +10,7 @@
 #include "hw/arm/machines-qom.h"
 #include "target/arm/cpu-qom.h"
 #include "target/arm/cpu-param.h"
-#include "qemu/target-info-impl.h"
+#include "qemu/target-info.h"
 #include "qemu/target-info-init.h"
 
 DEF_TARGET_INFO(target_info_arm_system,
diff --git a/page-vary-common.c b/page-vary-common.c
index b4e8cdf405..ec07b91d96 100644
--- a/page-vary-common.c
+++ b/page-vary-common.c
@@ -20,7 +20,7 @@
 #define IN_PAGE_VARY 1
 
 #include "qemu/osdep.h"
-#include "qemu/target-info-impl.h"
+#include "qemu/target-info.h"
 #include "exec/page-vary.h"
 
 /* WARNING: This file must *not* be complied with -flto. */
diff --git a/page-vary-system.c b/page-vary-system.c
index b2a1c45deb..ccc242b498 100644
--- a/page-vary-system.c
+++ b/page-vary-system.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "exec/page-vary.h"
 #include "exec/tlb-flags.h"
-#include "qemu/target-info-impl.h"
+#include "qemu/target-info.h"
 
 QEMU_BUILD_BUG_ON(TLB_FLAGS_MASK & ((1u < TARGET_PAGE_BITS_MIN) - 1));
 
diff --git a/target-info-qom.c b/target-info-qom.c
index abaf7507a0..f7a03d78d4 100644
--- a/target-info-qom.c
+++ b/target-info-qom.c
@@ -11,7 +11,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qom/object.h"
-#include "qemu/target-info-impl.h"
+#include "qemu/target-info.h"
 #include "qemu/target-info-init.h"
 #include "qemu/target-info-qom.h"
 #include "hw/arm/machines-qom.h"
diff --git a/target-info-stub.c b/target-info-stub.c
index 813d562058..edd4b78aa2 100644
--- a/target-info-stub.c
+++ b/target-info-stub.c
@@ -12,7 +12,6 @@
 #include "exec/cpu-defs.h"
 #include "exec/page-vary.h"
 #include "qemu/target-info.h"
-#include "qemu/target-info-impl.h"
 #include "qemu/target-info-init.h"
 
 /* Validate correct placement of CPUArchState. */
diff --git a/target-info.c b/target-info.c
index 6bd3f9485f..3679e3ddd6 100644
--- a/target-info.c
+++ b/target-info.c
@@ -9,7 +9,6 @@
 #include "qemu/osdep.h"
 #include "qemu/target-info.h"
 #include "qemu/target-info-qapi.h"
-#include "qemu/target-info-impl.h"
 #include "qapi/error.h"
 
 const char *target_name(void)
-- 
2.43.0


