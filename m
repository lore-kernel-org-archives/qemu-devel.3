Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D066C369D3
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7l0V-0003LN-RG; Wed, 23 Apr 2025 21:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kwz-0005Wl-5N
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:00:25 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kwt-0005XC-V2
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:00:24 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-73bf5aa95e7so372361b3a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 18:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456418; x=1746061218; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7VXEDUlPkpIMjb0Jt+mGuDdJy2bXxmmNFXU1sXIXZA4=;
 b=B5hnbVZ4rGdEq8Gqve76Rt/gtItWKv3I/e1LvIRMNZDax0AW3WI6bzFMogiMgvqAOw
 Idl8AVtIo/yT2eHxzoPezNW8w2ua12I+x11MX6EQEMusLCZ0/nwdGzO9e+FLzJ66HN9c
 Yld6AgiNEn1MnUOwsw2n9g+5suHg9IqNQAWF/X9Llzt2CxKcNng9A/FXsDyqjJ54Kkwl
 kBMmZMEjebdnL+ONrn2qkTgVIsg98c5V9LHQbtJ4NifhhRamqSvIh9e4ruDQ5oyJnFxm
 EtsEnVoUL5+xDLWlLDNpcJqzusLofpNl9Og4jxbxrY9m0I9tvAsu18N3SRCIx0ydMEpL
 efIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456418; x=1746061218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7VXEDUlPkpIMjb0Jt+mGuDdJy2bXxmmNFXU1sXIXZA4=;
 b=NkFZK3aO1DW//kSvv6RJNpp25gVDM01lmt8MTNG+wCGHNlMtbqwEFjexqBPpftkgBX
 cqUTtL8IzdTYw7GqreSjswYPBzQX1yiiVyMU/Dj/VYij7gDOqKCcchpPl3fKiR2F7zzZ
 vMBij4SSjKENkSUYs/nDR9K4MPoNjaFOE7uBOUn1yZ/3YGWOS8JL3tP9mMjychzCpfeR
 +tdzybIVhHaXrui/OjT2pTpToexscdPED4I8Nj9UawlszVIXzSTYTtS89p/YpBSunIrY
 b9IGbsZQBZ+QHnlST3t0uA9VcNw86pLK9QVAjTz00kti01ge4TdCDUl9+ocKR5sNyIyt
 YcUA==
X-Gm-Message-State: AOJu0YycQVECBjpur/a2+KayIbwTw1/SKZ6ntv1z9JrBZSFVkzwKfNzD
 7+9jL/4ui3xkxY7qdb4vblUqjgoPVKIskHYpjpUR8xkhK+wDAOw/aLbDiSVlyjHpap59GfXVWV5
 w
X-Gm-Gg: ASbGncuxvRaZ8eLCCJmAoSgaXv7Z0bOGDrc2orFg1sUf42SjReB15f3JiK2lzRV2561
 8Y1C58uidUT0Lu6b7MAvr6te3xEyDUr0GJDovnYyRbcqv1owQ/TdcJxNKB/fBh7L3t6KtrexYuu
 B5xfNCPBhcxo2QAeLg9DPRbHPyGax6QnWFPXFuZKnM+HOkXtX5+xYNCIjcRhP/UxDepQCqe/pGm
 x+pRFl2UNjM8GVGNCXuDPeRpcVCqkKFV2KrMobMPdH8QkEjIqxJhR+rKUOkSsnhaGiDPo6PMbXC
 uF8X42zazMKTQg9a2EDf5LotDojK9cSwlHohT2UcmGgO+Ukpt54pW49EBON5vqSeXNMGAZX79+g
 yH7SeW/aAog==
X-Google-Smtp-Source: AGHT+IHkOaBFQruQJSDGJ2wBueEvZS2olxBHIMXm7aAjOhUYH+VRPoNtDuyK8HZESwEsk/gc0ng/Uw==
X-Received: by 2002:a05:6a20:c70e:b0:1f5:57d0:7014 with SMTP id
 adf61e73a8af0-20444f23718mr934259637.25.1745456418182; 
 Wed, 23 Apr 2025 18:00:18 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f76f45c7sm129259a12.16.2025.04.23.18.00.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 18:00:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 140/148] tcg: Move cpu_req_mo() macro to target-agnostic
 'backend-ldst.h'
Date: Wed, 23 Apr 2025 17:49:25 -0700
Message-ID: <20250424004934.598783-141-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/backend-ldst.h    | 41 +++++++++++++++++++++++++++++++++++++
 accel/tcg/internal-target.h | 28 -------------------------
 accel/tcg/cputlb.c          |  1 +
 accel/tcg/user-exec.c       |  1 +
 4 files changed, 43 insertions(+), 28 deletions(-)
 create mode 100644 accel/tcg/backend-ldst.h

diff --git a/accel/tcg/backend-ldst.h b/accel/tcg/backend-ldst.h
new file mode 100644
index 0000000000..9c3a407a5a
--- /dev/null
+++ b/accel/tcg/backend-ldst.h
@@ -0,0 +1,41 @@
+/*
+ * Internal memory barrier helpers for QEMU (target agnostic)
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#ifndef ACCEL_TCG_BACKEND_LDST_H
+#define ACCEL_TCG_BACKEND_LDST_H
+
+#include "tcg-target-mo.h"
+
+/**
+ * tcg_req_mo:
+ * @guest_mo: Guest default memory order
+ * @type: TCGBar
+ *
+ * Filter @type to the barrier that is required for the guest
+ * memory ordering vs the host memory ordering.  A non-zero
+ * result indicates that some barrier is required.
+ */
+#define tcg_req_mo(guest_mo, type) \
+    ((type) & guest_mo & ~TCG_TARGET_DEFAULT_MO)
+
+/**
+ * cpu_req_mo:
+ * @cpu: CPUState
+ * @type: TCGBar
+ *
+ * If tcg_req_mo indicates a barrier for @type is required
+ * for the guest memory model, issue a host memory barrier.
+ */
+#define cpu_req_mo(cpu, type)     \
+    do {                          \
+        if (tcg_req_mo(cpu->cc->tcg_ops->guest_default_memory_order, type)) { \
+            smp_mb();             \
+        }                         \
+    } while (0)
+
+#endif
diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
index f5a3fd7e40..9a9cef3140 100644
--- a/accel/tcg/internal-target.h
+++ b/accel/tcg/internal-target.h
@@ -13,7 +13,6 @@
 #include "exec/exec-all.h"
 #include "exec/translation-block.h"
 #include "tb-internal.h"
-#include "tcg-target-mo.h"
 #include "exec/mmap-lock.h"
 
 /*
@@ -44,31 +43,4 @@ void page_table_config_init(void);
 G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
 #endif /* CONFIG_USER_ONLY */
 
-/**
- * tcg_req_mo:
- * @guest_mo: Guest default memory order
- * @type: TCGBar
- *
- * Filter @type to the barrier that is required for the guest
- * memory ordering vs the host memory ordering.  A non-zero
- * result indicates that some barrier is required.
- */
-#define tcg_req_mo(guest_mo, type) \
-    ((type) & guest_mo & ~TCG_TARGET_DEFAULT_MO)
-
-/**
- * cpu_req_mo:
- * @cpu: CPUState
- * @type: TCGBar
- *
- * If tcg_req_mo indicates a barrier for @type is required
- * for the guest memory model, issue a host memory barrier.
- */
-#define cpu_req_mo(cpu, type)     \
-    do {                          \
-        if (tcg_req_mo(cpu->cc->tcg_ops->guest_default_memory_order, type)) { \
-            smp_mb();             \
-        }                         \
-    } while (0)
-
 #endif /* ACCEL_TCG_INTERNAL_H */
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 35b1ff03a5..d9fb68d719 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -48,6 +48,7 @@
 #include "qemu/plugin-memory.h"
 #endif
 #include "tcg/tcg-ldst.h"
+#include "backend-ldst.h"
 
 
 /* DEBUG defines, enable DEBUG_TLB_LOG to log to the CPU_LOG_MMU target */
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 3f4d682446..5eef8e7f18 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -37,6 +37,7 @@
 #include "qemu/int128.h"
 #include "trace.h"
 #include "tcg/tcg-ldst.h"
+#include "backend-ldst.h"
 #include "internal-common.h"
 #include "internal-target.h"
 #include "tb-internal.h"
-- 
2.43.0


