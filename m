Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 560A9CEFD1E
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 23:21:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdGLM-0005gO-7V; Tue, 06 Jan 2026 18:20:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdGLF-0005a8-U1
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 18:19:58 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdGLB-0001PZ-0j
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 18:19:57 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-42fbad1fa90so1182912f8f.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 15:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767741591; x=1768346391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SBL1ZMxoMddvQu3XmAwycOMhL36GgLgIZLEqZeSot6o=;
 b=VLygTXBYBh4dcdLudkFriOGutoUF9fwkxRxDi1mkcfCAG56m8Qqwacu/UJtOP803m8
 Cn1XSmEX/geb/L9upTm7qhyUq38yaxSfLO8VX8Kqm9VJ+9BIdVzJndXW1zUVHyUsPA4s
 MLk5kYIhYeTI1uAxUerefNvr4RozXpTYdc7kbkHL8NAEZ29c9Ng/cARAvR5PfmV2QA4l
 yCdiPUNjV1vl5inG20vz8dj3Kywb0uXXVqoqsfnfmqI5q3K6G1AMgfLc2pHeuDHtCX3u
 lqeoe980pPlzBos9l7zalYc45IJczbTxPLBfMgsYI5gwsNwOX0Vyckn+LxJ6vf5353fA
 7DqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767741591; x=1768346391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SBL1ZMxoMddvQu3XmAwycOMhL36GgLgIZLEqZeSot6o=;
 b=Zl5NVfPMvFb3EQOUZ3lm6XUIGW/FpGmIcz1Av7TEcWOPQr2n4gCzmOzEOYmcp8IFOX
 g9b00zdwluIwip4+XrwCdcCoDIg9QF26WnMLd0R9DBmRD0d30s1GnakGpEgy+rx3gtIL
 RMxsb9rX9FC1PcEVhfHb13r5LueWQ8IRLlUzxJ1qLGocuVmFgNXNXcq6s1ScXLiyV2YC
 RLBBio1rdV/cOh22+/FfkBl7mPT4grT83835Y9TXPSKIR6qYT8BFMJ8QnVEtN9ozQ7Xv
 Y3ZDO/korsH1xHcirrqDoeAqoSJGXvAVL0dyhzQ07+70xeI5zkBesOuSfzooDyi5Rzh1
 zfMA==
X-Gm-Message-State: AOJu0YwqPugWDC0gxS5MJ0jSZ+FuSMyGlUW+vktxmPogxoV0aMlgMB+T
 0qHmGBWzDO0AtiChx6Q0WDygZX3wW49ra7aSM5Y6jO7OIxzVRze9/O8P9T89EHkoas8t2k9w8Sq
 jK/O8YqU=
X-Gm-Gg: AY/fxX4estqHxz/FWcZUv1nwMn9Bp7rdIdQtdPTD/3JqU1A4lC3cwkebIVpt+tJt1sp
 6wRk9JThrYUOWQoNq6czZraQCIuz/OBRqdKX3k6xzQj4fH4UMTpWa/cTjY/xj4pxQH+VnWW3ZF+
 XvBE32iAuHt7zsbLsi+NEoEjeI0VlzNGe/liGhJinb8mTBB9fC+lDjfNZCISZHnQNGe2bTAhZVK
 h5sSCprruxqtee/acMH5nfQrp7ucw9csiE7bcoBgX8CwmmFfoeDA3S70mv4ROi55VZYfOMP3N81
 PoWyTxn75fDWGdQb0LluEeySpv7/CMWKXq7LCphAiQbLSIKrlUN9ohXEV1fKTRPA1EvMR/i3t8a
 UX8jT1tybRU/wJK1O+J+W/U03k0U0mVXpch2GfXdxVakAOLzGM7W1rol4ztjy4N440m8B2TO0Tz
 PEratrpffwfyH9lZAqbq+E2p3h3bvyyrqxWNtXN8k1CAYg0OPHdbjrwrKmSPTY
X-Google-Smtp-Source: AGHT+IHVCxE5blTHbEC0RaoSPuxSM4nNjMnLsdTcFcYruZESuYLCh4iYd/oS7OTneHP0gEn4MkBDIg==
X-Received: by 2002:a05:6000:2dc2:b0:432:851d:217e with SMTP id
 ffacd0b85a97d-432c37d2fc4mr770069f8f.44.1767741590983; 
 Tue, 06 Jan 2026 15:19:50 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e17aasm6993698f8f.15.2026.01.06.15.19.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Jan 2026 15:19:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Thomas Huth <thuth@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 5/5] accel/tcg: Unify watchpoint API
Date: Wed,  7 Jan 2026 00:19:07 +0100
Message-ID: <20260106231908.16756-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106231908.16756-1-philmd@linaro.org>
References: <20260106231908.16756-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Currently "exec/breakpoint.h" contains both BreakPoint *and*
WatchPoint APIs, however very few files requires the former,
and more the latter:

  $ git grep -l CPUBreakpoint | wc -l
        12
  $ git grep -l CPUWatchpoint | wc -l
        25

So extracting the WatchPoint API to its own header will reduce
compilation pressure.

But more importantly, the API is scattered in two distinct headers.
Unify them ("accel/tcg/cpu-ops.h" and "exec/watchpoint.h") to the
new "accel/tcg/watchpoint.h" header, making the emphasis the API is
specific to TCG.

Have accel/tcg/watchpoint.c absorb system/watchpoint.c code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                         |   1 -
 include/accel/tcg/cpu-ops.h         |  28 +-------
 include/accel/tcg/watchpoint.h      |  57 ++++++++++++++++
 include/exec/breakpoint.h           |  10 ---
 include/exec/watchpoint.h           |  18 -----
 include/hw/core/cpu.h               |   3 +-
 target/arm/internals.h              |   2 +-
 target/ppc/internal.h               |   2 +-
 target/riscv/debug.h                |   2 +-
 accel/tcg/cputlb.c                  |   1 +
 accel/tcg/tcg-accel-ops.c           |   2 +-
 accel/tcg/user-exec-stub.c          |   3 +-
 accel/tcg/watchpoint.c              |  83 +++++++++++++++++++++-
 system/watchpoint.c                 | 102 ----------------------------
 target/arm/debug_helper.c           |   2 +-
 target/arm/tcg/mte_helper.c         |   2 +-
 target/arm/tcg/sve_helper.c         |   2 +-
 target/i386/cpu.c                   |   2 +-
 target/i386/machine.c               |   2 +-
 target/i386/tcg/system/bpt_helper.c |   2 +-
 target/ppc/cpu.c                    |   2 +-
 target/ppc/cpu_init.c               |   2 +-
 target/riscv/cpu_helper.c           |   2 +-
 target/riscv/debug.c                |   2 +-
 target/s390x/helper.c               |   2 +-
 target/s390x/tcg/debug.c            |   2 +-
 target/s390x/tcg/excp_helper.c      |   2 +-
 target/s390x/tcg/mem_helper.c       |   1 +
 target/xtensa/dbg_helper.c          |   2 +-
 system/meson.build                  |   1 -
 30 files changed, 162 insertions(+), 182 deletions(-)
 create mode 100644 include/accel/tcg/watchpoint.h
 delete mode 100644 include/exec/watchpoint.h
 delete mode 100644 system/watchpoint.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0afee64a625..7c1c0d526a0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -155,7 +155,6 @@ Overall TCG CPUs
 M: Richard Henderson <richard.henderson@linaro.org>
 R: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
-F: system/watchpoint.c
 F: page-vary-target.c
 F: page-vary-common.c
 F: accel/tcg/
diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index 5950cdcaab1..e20a79325e5 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -10,7 +10,7 @@
 #ifndef TCG_CPU_OPS_H
 #define TCG_CPU_OPS_H
 
-#include "exec/breakpoint.h"
+#include "accel/tcg/watchpoint.h"
 #include "exec/hwaddr.h"
 #include "exec/memattrs.h"
 #include "exec/memop.h"
@@ -281,32 +281,6 @@ struct TCGCPUOps {
 #endif /* !CONFIG_USER_ONLY */
 };
 
-/**
- * cpu_check_watchpoint:
- * @cpu: cpu context
- * @addr: guest virtual address
- * @len: access length
- * @attrs: memory access attributes
- * @flags: watchpoint access type
- * @ra: unwind return address
- *
- * Check for a watchpoint hit in [addr, addr+len) of the type
- * specified by @flags.  Exit via exception with a hit.
- */
-void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
-                          MemTxAttrs attrs, int flags, uintptr_t ra);
-
-/**
- * cpu_watchpoint_address_matches:
- * @cpu: cpu context
- * @addr: guest virtual address
- * @len: access length
- *
- * Return the watchpoint flags that apply to [addr, addr+len).
- * If no watchpoint is registered for the range, the result is 0.
- */
-int cpu_watchpoint_address_matches(CPUState *cpu, vaddr addr, vaddr len);
-
 /*
  * Common pointer_wrap implementations.
  */
diff --git a/include/accel/tcg/watchpoint.h b/include/accel/tcg/watchpoint.h
new file mode 100644
index 00000000000..f28be5fc67f
--- /dev/null
+++ b/include/accel/tcg/watchpoint.h
@@ -0,0 +1,57 @@
+/*
+ * CPU watchpoints
+ *
+ * Copyright (c) 2012 SUSE LINUX Products GmbH
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#ifndef ACCEL_TCG_WATCHPOINT_H
+#define ACCEL_TCG_WATCHPOINT_H
+
+#include "qemu/queue.h"
+#include "exec/vaddr.h"
+#include "exec/memattrs.h"
+
+typedef struct CPUWatchpoint {
+    vaddr vaddr;
+    vaddr len;
+    vaddr hitaddr;
+    MemTxAttrs hitattrs;
+    int flags; /* BP_* */
+    QTAILQ_ENTRY(CPUWatchpoint) entry;
+} CPUWatchpoint;
+
+int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
+                          int flags, CPUWatchpoint **watchpoint);
+int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
+                          vaddr len, int flags);
+void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *watchpoint);
+void cpu_watchpoint_remove_all(CPUState *cpu, int mask);
+
+/**
+ * cpu_check_watchpoint:
+ * @cpu: cpu context
+ * @addr: guest virtual address
+ * @len: access length
+ * @attrs: memory access attributes
+ * @flags: watchpoint access type
+ * @ra: unwind return address
+ *
+ * Check for a watchpoint hit in [addr, addr+len) of the type
+ * specified by @flags.  Exit via exception with a hit.
+ */
+void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
+                          MemTxAttrs attrs, int flags, uintptr_t ra);
+
+/**
+ * cpu_watchpoint_address_matches:
+ * @cpu: cpu context
+ * @addr: guest virtual address
+ * @len: access length
+ *
+ * Return the watchpoint flags that apply to [addr, addr+len).
+ * If no watchpoint is registered for the range, the result is 0.
+ */
+int cpu_watchpoint_address_matches(CPUState *cpu, vaddr addr, vaddr len);
+
+#endif /* ACCEL_TCG_WATCHPOINT_H */
diff --git a/include/exec/breakpoint.h b/include/exec/breakpoint.h
index 95f0482e6d0..ccc302fea0f 100644
--- a/include/exec/breakpoint.h
+++ b/include/exec/breakpoint.h
@@ -10,7 +10,6 @@
 
 #include "qemu/queue.h"
 #include "exec/vaddr.h"
-#include "exec/memattrs.h"
 
 typedef struct CPUBreakpoint {
     vaddr pc;
@@ -18,13 +17,4 @@ typedef struct CPUBreakpoint {
     QTAILQ_ENTRY(CPUBreakpoint) entry;
 } CPUBreakpoint;
 
-typedef struct CPUWatchpoint {
-    vaddr vaddr;
-    vaddr len;
-    vaddr hitaddr;
-    MemTxAttrs hitattrs;
-    int flags; /* BP_* */
-    QTAILQ_ENTRY(CPUWatchpoint) entry;
-} CPUWatchpoint;
-
 #endif
diff --git a/include/exec/watchpoint.h b/include/exec/watchpoint.h
deleted file mode 100644
index c4d069425ba..00000000000
--- a/include/exec/watchpoint.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- * CPU watchpoints
- *
- * Copyright (c) 2012 SUSE LINUX Products GmbH
- * SPDX-License-Identifier: LGPL-2.1-or-later
- */
-
-#ifndef EXEC_WATCHPOINT_H
-#define EXEC_WATCHPOINT_H
-
-int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
-                          int flags, CPUWatchpoint **watchpoint);
-int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
-                          vaddr len, int flags);
-void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *watchpoint);
-void cpu_watchpoint_remove_all(CPUState *cpu, int mask);
-
-#endif /* EXEC_WATCHPOINT_H */
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index f6f17df9e64..9648ba8f6f6 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -28,6 +28,7 @@
 #include "exec/memattrs.h"
 #include "exec/mmu-access-type.h"
 #include "exec/tlb-common.h"
+#include "accel/tcg/watchpoint.h"
 #include "qapi/qapi-types-machine.h"
 #include "qapi/qapi-types-run-state.h"
 #include "qemu/bitmap.h"
@@ -84,8 +85,6 @@ DECLARE_CLASS_CHECKERS(CPUClass, CPU,
     typedef struct ArchCPU CpuInstanceType; \
     OBJECT_DECLARE_TYPE(ArchCPU, CpuClassType, CPU_MODULE_OBJ_NAME);
 
-typedef struct CPUWatchpoint CPUWatchpoint;
-
 /* see physmem.c */
 struct CPUAddressSpace;
 
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 9cd4bf74efb..e7d83836242 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -27,7 +27,7 @@
 
 #include "exec/hwaddr.h"
 #include "exec/vaddr.h"
-#include "exec/breakpoint.h"
+#include "accel/tcg/watchpoint.h"
 #include "accel/tcg/tb-cpu-state.h"
 #include "hw/core/registerfields.h"
 #include "tcg/tcg-gvec-desc.h"
diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 58f315ffcf5..f468bcbb7fa 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -18,7 +18,7 @@
 #ifndef PPC_INTERNAL_H
 #define PPC_INTERNAL_H
 
-#include "exec/breakpoint.h"
+#include "accel/tcg/watchpoint.h"
 #include "hw/core/registerfields.h"
 #include "exec/page-protection.h"
 #include "accel/tcg/tb-cpu-state.h"
diff --git a/target/riscv/debug.h b/target/riscv/debug.h
index f76b8f944a2..7aa9dfd89f9 100644
--- a/target/riscv/debug.h
+++ b/target/riscv/debug.h
@@ -22,7 +22,7 @@
 #ifndef RISCV_DEBUG_H
 #define RISCV_DEBUG_H
 
-#include "exec/breakpoint.h"
+#include "accel/tcg/watchpoint.h"
 
 #define RV_MAX_TRIGGERS         2
 
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index c30073326a3..922fc503874 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -28,6 +28,7 @@
 #include "system/physmem.h"
 #include "accel/tcg/cpu-ldst-common.h"
 #include "accel/tcg/cpu-mmu-index.h"
+#include "accel/tcg/watchpoint.h"
 #include "exec/cputlb.h"
 #include "exec/tb-flush.h"
 #include "system/ramblock.h"
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 3bd98005042..2a6423aab8d 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -38,7 +38,7 @@
 #include "exec/hwaddr.h"
 #include "exec/tb-flush.h"
 #include "exec/translation-block.h"
-#include "exec/watchpoint.h"
+#include "accel/tcg/watchpoint.h"
 #include "gdbstub/enums.h"
 
 #include "hw/core/cpu.h"
diff --git a/accel/tcg/user-exec-stub.c b/accel/tcg/user-exec-stub.c
index 28286e11a60..a5e2534f2bf 100644
--- a/accel/tcg/user-exec-stub.c
+++ b/accel/tcg/user-exec-stub.c
@@ -1,8 +1,7 @@
 #include "qemu/osdep.h"
 #include "hw/core/cpu.h"
-#include "accel/tcg/cpu-ops.h"
 #include "exec/replay-core.h"
-#include "exec/watchpoint.h"
+#include "accel/tcg/watchpoint.h"
 #include "internal-common.h"
 
 void cpu_resume(CPUState *cpu)
diff --git a/accel/tcg/watchpoint.c b/accel/tcg/watchpoint.c
index cfb37a49e72..0d9de0fca2e 100644
--- a/accel/tcg/watchpoint.c
+++ b/accel/tcg/watchpoint.c
@@ -19,10 +19,14 @@
 
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
-#include "exec/breakpoint.h"
+#include "qemu/error-report.h"
+#include "accel/tcg/watchpoint.h"
 #include "exec/cpu-interrupt.h"
+#include "exec/cputlb.h"
 #include "exec/page-protection.h"
+#include "exec/target_page.h"
 #include "exec/translation-block.h"
+#include "accel/tcg/watchpoint.h"
 #include "system/tcg.h"
 #include "system/replay.h"
 #include "accel/tcg/cpu-ops.h"
@@ -139,3 +143,80 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
         }
     }
 }
+
+/* Add a watchpoint.  */
+int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
+                          int flags, CPUWatchpoint **watchpoint)
+{
+    CPUWatchpoint *wp;
+    vaddr in_page;
+
+    /* forbid ranges which are empty or run off the end of the address space */
+    if (len == 0 || (addr + len - 1) < addr) {
+        error_report("tried to set invalid watchpoint at %"
+                     VADDR_PRIx ", len=%" VADDR_PRIu, addr, len);
+        return -EINVAL;
+    }
+    wp = g_malloc(sizeof(*wp));
+
+    wp->vaddr = addr;
+    wp->len = len;
+    wp->flags = flags;
+
+    /* keep all GDB-injected watchpoints in front */
+    if (flags & BP_GDB) {
+        QTAILQ_INSERT_HEAD(&cpu->watchpoints, wp, entry);
+    } else {
+        QTAILQ_INSERT_TAIL(&cpu->watchpoints, wp, entry);
+    }
+
+    in_page = -(addr | TARGET_PAGE_MASK);
+    if (len <= in_page) {
+        tlb_flush_page(cpu, addr);
+    } else {
+        tlb_flush(cpu);
+    }
+
+    if (watchpoint) {
+        *watchpoint = wp;
+    }
+    return 0;
+}
+
+/* Remove a specific watchpoint.  */
+int cpu_watchpoint_remove(CPUState *cpu, vaddr addr, vaddr len,
+                          int flags)
+{
+    CPUWatchpoint *wp;
+
+    QTAILQ_FOREACH(wp, &cpu->watchpoints, entry) {
+        if (addr == wp->vaddr && len == wp->len
+                && flags == (wp->flags & ~BP_WATCHPOINT_HIT)) {
+            cpu_watchpoint_remove_by_ref(cpu, wp);
+            return 0;
+        }
+    }
+    return -ENOENT;
+}
+
+/* Remove a specific watchpoint by reference.  */
+void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *watchpoint)
+{
+    QTAILQ_REMOVE(&cpu->watchpoints, watchpoint, entry);
+
+    tlb_flush_page(cpu, watchpoint->vaddr);
+
+    g_free(watchpoint);
+}
+
+/* Remove all matching watchpoints.  */
+void cpu_watchpoint_remove_all(CPUState *cpu, int mask)
+{
+    CPUWatchpoint *wp, *next;
+
+    QTAILQ_FOREACH_SAFE(wp, &cpu->watchpoints, entry, next) {
+        if (wp->flags & mask) {
+            cpu_watchpoint_remove_by_ref(cpu, wp);
+        }
+    }
+}
diff --git a/system/watchpoint.c b/system/watchpoint.c
deleted file mode 100644
index 21d0bb36cae..00000000000
--- a/system/watchpoint.c
+++ /dev/null
@@ -1,102 +0,0 @@
-/*
- * CPU watchpoints
- *
- *  Copyright (c) 2003 Fabrice Bellard
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
- */
-
-#include "qemu/osdep.h"
-#include "qemu/error-report.h"
-#include "exec/cputlb.h"
-#include "exec/target_page.h"
-#include "exec/watchpoint.h"
-#include "hw/core/cpu.h"
-
-/* Add a watchpoint.  */
-int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
-                          int flags, CPUWatchpoint **watchpoint)
-{
-    CPUWatchpoint *wp;
-    vaddr in_page;
-
-    /* forbid ranges which are empty or run off the end of the address space */
-    if (len == 0 || (addr + len - 1) < addr) {
-        error_report("tried to set invalid watchpoint at %"
-                     VADDR_PRIx ", len=%" VADDR_PRIu, addr, len);
-        return -EINVAL;
-    }
-    wp = g_malloc(sizeof(*wp));
-
-    wp->vaddr = addr;
-    wp->len = len;
-    wp->flags = flags;
-
-    /* keep all GDB-injected watchpoints in front */
-    if (flags & BP_GDB) {
-        QTAILQ_INSERT_HEAD(&cpu->watchpoints, wp, entry);
-    } else {
-        QTAILQ_INSERT_TAIL(&cpu->watchpoints, wp, entry);
-    }
-
-    in_page = -(addr | TARGET_PAGE_MASK);
-    if (len <= in_page) {
-        tlb_flush_page(cpu, addr);
-    } else {
-        tlb_flush(cpu);
-    }
-
-    if (watchpoint) {
-        *watchpoint = wp;
-    }
-    return 0;
-}
-
-/* Remove a specific watchpoint.  */
-int cpu_watchpoint_remove(CPUState *cpu, vaddr addr, vaddr len,
-                          int flags)
-{
-    CPUWatchpoint *wp;
-
-    QTAILQ_FOREACH(wp, &cpu->watchpoints, entry) {
-        if (addr == wp->vaddr && len == wp->len
-                && flags == (wp->flags & ~BP_WATCHPOINT_HIT)) {
-            cpu_watchpoint_remove_by_ref(cpu, wp);
-            return 0;
-        }
-    }
-    return -ENOENT;
-}
-
-/* Remove a specific watchpoint by reference.  */
-void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *watchpoint)
-{
-    QTAILQ_REMOVE(&cpu->watchpoints, watchpoint, entry);
-
-    tlb_flush_page(cpu, watchpoint->vaddr);
-
-    g_free(watchpoint);
-}
-
-/* Remove all matching watchpoints.  */
-void cpu_watchpoint_remove_all(CPUState *cpu, int mask)
-{
-    CPUWatchpoint *wp, *next;
-
-    QTAILQ_FOREACH_SAFE(wp, &cpu->watchpoints, entry, next) {
-        if (wp->flags & mask) {
-            cpu_watchpoint_remove_by_ref(cpu, wp);
-        }
-    }
-}
diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index 579516e1541..9dc8d47f664 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -11,7 +11,7 @@
 #include "internals.h"
 #include "cpu-features.h"
 #include "cpregs.h"
-#include "exec/watchpoint.h"
+#include "accel/tcg/watchpoint.h"
 #include "system/tcg.h"
 
 #define HELPER_H "tcg/helper.h"
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index bb48fe359b8..f71ed4d9178 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -31,9 +31,9 @@
 #endif
 #include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/probe.h"
+#include "accel/tcg/watchpoint.h"
 #include "exec/helper-proto.h"
 #include "exec/tlb-flags.h"
-#include "accel/tcg/cpu-ops.h"
 #include "qapi/error.h"
 #include "qemu/guest-random.h"
 #include "mte_helper.h"
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index c442fcb540d..7aa88fdeea0 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -31,8 +31,8 @@
 #include "sve_ldst_internal.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/helper-retaddr.h"
-#include "accel/tcg/cpu-ops.h"
 #include "accel/tcg/probe.h"
+#include "accel/tcg/watchpoint.h"
 #ifdef CONFIG_USER_ONLY
 #include "user/page-protection.h"
 #endif
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 9831e2bc210..e7273d67369 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -36,7 +36,7 @@
 #include "standard-headers/asm-x86/kvm_para.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/i386/topology.h"
-#include "exec/watchpoint.h"
+#include "accel/tcg/watchpoint.h"
 #ifndef CONFIG_USER_ONLY
 #include "confidential-guest.h"
 #include "system/reset.h"
diff --git a/target/i386/machine.c b/target/i386/machine.c
index c9139612813..863769b9c9b 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -7,7 +7,7 @@
 #include "hw/i386/x86.h"
 #include "kvm/kvm_i386.h"
 #include "hw/xen/xen.h"
-#include "exec/watchpoint.h"
+#include "accel/tcg/watchpoint.h"
 #include "system/kvm.h"
 #include "system/kvm_xen.h"
 #include "system/tcg.h"
diff --git a/target/i386/tcg/system/bpt_helper.c b/target/i386/tcg/system/bpt_helper.c
index aebb5caac37..f722774bb91 100644
--- a/target/i386/tcg/system/bpt_helper.c
+++ b/target/i386/tcg/system/bpt_helper.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
-#include "exec/watchpoint.h"
+#include "accel/tcg/watchpoint.h"
 #include "tcg/helper-tcg.h"
 
 
diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
index 9cb3f00aa88..25d950aeedc 100644
--- a/target/ppc/cpu.c
+++ b/target/ppc/cpu.c
@@ -22,7 +22,7 @@
 #include "cpu-models.h"
 #include "cpu-qom.h"
 #include "exec/log.h"
-#include "exec/watchpoint.h"
+#include "accel/tcg/watchpoint.h"
 #include "fpu/softfloat-helpers.h"
 #include "mmu-hash64.h"
 #include "helper_regs.h"
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 929254827d6..cca2096fb57 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -40,7 +40,7 @@
 #include "qemu/cutils.h"
 #include "disas/capstone.h"
 #include "fpu/softfloat.h"
-#include "exec/watchpoint.h"
+#include "accel/tcg/watchpoint.h"
 #include "helper_regs.h"
 #include "internal.h"
 #include "spr_common.h"
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index c4fb68b5de8..1db4a6fc36f 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -29,7 +29,7 @@
 #include "system/memory.h"
 #include "instmap.h"
 #include "tcg/tcg-op.h"
-#include "accel/tcg/cpu-ops.h"
+#include "accel/tcg/watchpoint.h"
 #include "trace.h"
 #include "semihosting/common-semi.h"
 #include "exec/icount.h"
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 56644667497..f3a72dd4b7a 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -29,7 +29,7 @@
 #include "cpu.h"
 #include "trace.h"
 #include "exec/helper-proto.h"
-#include "exec/watchpoint.h"
+#include "accel/tcg/watchpoint.h"
 #include "system/cpu-timers.h"
 #include "exec/icount.h"
 
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 8d1e03f6768..7dede1e7ed3 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -28,7 +28,7 @@
 #include "system/memory.h"
 #include "system/runstate.h"
 #include "exec/target_page.h"
-#include "exec/watchpoint.h"
+#include "accel/tcg/watchpoint.h"
 
 void s390x_tod_timer(void *opaque)
 {
diff --git a/target/s390x/tcg/debug.c b/target/s390x/tcg/debug.c
index 12ae95d4fe8..74c1d5f3242 100644
--- a/target/s390x/tcg/debug.c
+++ b/target/s390x/tcg/debug.c
@@ -10,7 +10,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "exec/watchpoint.h"
+#include "accel/tcg/watchpoint.h"
 #include "target/s390x/cpu.h"
 #include "tcg_s390x.h"
 
diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
index d4a096f5998..1485dbf83be 100644
--- a/target/s390x/tcg/excp_helper.c
+++ b/target/s390x/tcg/excp_helper.c
@@ -24,7 +24,7 @@
 #include "exec/helper-proto.h"
 #include "exec/cputlb.h"
 #include "exec/target_page.h"
-#include "exec/watchpoint.h"
+#include "accel/tcg/watchpoint.h"
 #include "s390x-internal.h"
 #include "tcg_s390x.h"
 #ifndef CONFIG_USER_ONLY
diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 2972b7ddb97..b94d12ee7f8 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -33,6 +33,7 @@
 #include "exec/tlb-flags.h"
 #include "accel/tcg/cpu-ops.h"
 #include "accel/tcg/helper-retaddr.h"
+#include "accel/tcg/watchpoint.h"
 #include "qemu/int128.h"
 #include "qemu/atomic128.h"
 
diff --git a/target/xtensa/dbg_helper.c b/target/xtensa/dbg_helper.c
index 3b91f7c38ac..25341dc0a71 100644
--- a/target/xtensa/dbg_helper.c
+++ b/target/xtensa/dbg_helper.c
@@ -30,7 +30,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
-#include "exec/watchpoint.h"
+#include "accel/tcg/watchpoint.h"
 #include "system/address-spaces.h"
 
 void HELPER(wsr_ibreakenable)(CPUXtensaState *env, uint32_t v)
diff --git a/system/meson.build b/system/meson.build
index 4b69ef0f5fb..d24efbb44ba 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -29,7 +29,6 @@ system_ss.add(files(
   'runstate-hmp-cmds.c',
   'runstate.c',
   'tpm-hmp-cmds.c',
-  'watchpoint.c',
 ))
 
 if have_tpm
-- 
2.52.0


