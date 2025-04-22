Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D329C369D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:44:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JML-0001p4-9I; Tue, 22 Apr 2025 15:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLY-0000Hq-WD
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:31:57 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLW-0006bO-BN
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:31:56 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-224191d92e4so55743625ad.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350313; x=1745955113; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rzfkd84AU4JxIk+n9aK5OlCLgNFIPk0/g2EPPFZ4xP8=;
 b=loungcGEI/fdCLUZ27oYzqRvZkD+nct9qD23EkI6XM4qpUyjIlf9DJfTWz291zJL5z
 oAnfPEC3mO+YVYOj4LbKB/nZKxEWpSon9j6yVLdQXFgx549PC380UM8f6QPNnnwYwMj7
 O2VQcnOB4FrCWs/+tnjfu84Lxmbn6ZvuT5fYhFIAOETDkgc3i+tUXLVxxqrOu28kdKnH
 jRracRdyRLdmk2qwsLPIVoGIJsEbNI1FgDsJD8sc5Yo91dr1BghO9CAadUqgZqIUUnnv
 xbq/H6FM7FA11IO+TS2z0wx4HEC82v4t6B7vOkJnCCmML/m4B9ODfzGMK08iQq2dy5d0
 AWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350313; x=1745955113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rzfkd84AU4JxIk+n9aK5OlCLgNFIPk0/g2EPPFZ4xP8=;
 b=e0Ee2pXqyURbSYNZdm8p/HPnWKnyWUmgkXb3iwIkWjxhzgzaooLJI0GkI39Rg75DsK
 B7dA6L7qAS8NFdMLfJXkPYDhyYUUNpGFuRsZqBHnkJbtaUWRO66HiMMFpRct6v+srbTZ
 fX3aEe0bNk1NqCS+Jn6iEjZ4AKimxy8FGeMBHamPnvGUrWxTr76xLjc4UYEwm5yNWYgr
 R+KQmqiqCRpxqMSpQiWpvO2ilX5Epi8dZ4xKnuz4Fp3ygcT3nbzXu6IOtJbdw7JIac7F
 qzHpTqebArcho8/jyLP+CXA3Li40oEOVcEmocP86KAECzp2U8wzwk07QHgGPCsGgetkj
 kWwA==
X-Gm-Message-State: AOJu0YwOrLUaxrz+Bkfr/tR8TgvhA8ofab/AIE/QX1IHFWwigKq1XZNp
 ju7iId/bZTpxLG3zBNkEANoBUWEBCL9p/ueYQs23peb57MqGZZRhsCmrjVFMBr7WavtsMvs2Ohi
 G
X-Gm-Gg: ASbGnctElsh+asUwjHZq2E9SFgyWgefFS88S6p/sQ1IiMfwZUtETyjzrzf4zwDmj8wo
 LmyV0xE9/ZbDtTUp+A8rgAG+3jaqbJVulk6apa0YGpBmR3Tny26UB3XExCT2GiIo7KwO5KreEuF
 TfPd6IhQmbdnpu23M/+sEV7aeiSpiJSoz14pzA0qoLZfMXBbb4/tta4EVpaIAWWZu5W5ls3vF2e
 P/SZV87ZaJfOJp5V8/DdRmZ0uRx07M3OCyLyyscNelaf8yZPngolggmqHL2ZgBerjep+svVX4dQ
 ACawy4OmLd7U2xqVCP7pda2/+QkxJ3bcMiLrALVU6ysXQa87lLHLX9gzj0l/BHkzSFroN9ltOJs
 =
X-Google-Smtp-Source: AGHT+IFMAkz9iEWA7wGPXaE/uq3sWtqofxt0sZVDADOLB4wJJDYzZ9/A96JhgZefmhOxQQFUBw3McA==
X-Received: by 2002:a17:902:e88f:b0:220:f151:b668 with SMTP id
 d9443c01a7336-22c535815admr193370365ad.20.1745350312649; 
 Tue, 22 Apr 2025 12:31:52 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bdda3bsm89312635ad.27.2025.04.22.12.31.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:31:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 048/147] include/exec: Split out watchpoint.h
Date: Tue, 22 Apr 2025 12:26:37 -0700
Message-ID: <20250422192819.302784-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Relatively few objects in qemu care about watchpoints, so split
out to a new header.  Removes an instance of CONFIG_USER_ONLY
from hw/core/cpu.h.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/watchpoint.h           | 41 +++++++++++++++++++++++++++++
 include/hw/core/cpu.h               | 30 ---------------------
 accel/tcg/tcg-accel-ops.c           |  1 +
 system/watchpoint.c                 |  1 +
 target/arm/debug_helper.c           |  1 +
 target/i386/cpu.c                   |  1 +
 target/i386/machine.c               |  2 +-
 target/i386/tcg/system/bpt_helper.c |  1 +
 target/ppc/cpu.c                    |  1 +
 target/ppc/cpu_init.c               |  2 +-
 target/riscv/debug.c                |  1 +
 target/s390x/helper.c               |  1 +
 target/s390x/tcg/excp_helper.c      |  1 +
 target/xtensa/dbg_helper.c          |  1 +
 14 files changed, 53 insertions(+), 32 deletions(-)
 create mode 100644 include/exec/watchpoint.h

diff --git a/include/exec/watchpoint.h b/include/exec/watchpoint.h
new file mode 100644
index 0000000000..4b6668826c
--- /dev/null
+++ b/include/exec/watchpoint.h
@@ -0,0 +1,41 @@
+/*
+ * CPU watchpoints
+ *
+ * Copyright (c) 2012 SUSE LINUX Products GmbH
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#ifndef EXEC_WATCHPOINT_H
+#define EXEC_WATCHPOINT_H
+
+#if defined(CONFIG_USER_ONLY)
+static inline int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
+                                        int flags, CPUWatchpoint **watchpoint)
+{
+    return -ENOSYS;
+}
+
+static inline int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
+                                        vaddr len, int flags)
+{
+    return -ENOSYS;
+}
+
+static inline void cpu_watchpoint_remove_by_ref(CPUState *cpu,
+                                                CPUWatchpoint *wp)
+{
+}
+
+static inline void cpu_watchpoint_remove_all(CPUState *cpu, int mask)
+{
+}
+#else
+int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
+                          int flags, CPUWatchpoint **watchpoint);
+int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
+                          vaddr len, int flags);
+void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *watchpoint);
+void cpu_watchpoint_remove_all(CPUState *cpu, int mask);
+#endif
+
+#endif /* EXEC_WATCHPOINT_H */
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index abd8764e83..37cb7d1531 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1109,36 +1109,6 @@ static inline bool cpu_breakpoint_test(CPUState *cpu, vaddr pc, int mask)
     return false;
 }
 
-#if defined(CONFIG_USER_ONLY)
-static inline int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
-                                        int flags, CPUWatchpoint **watchpoint)
-{
-    return -ENOSYS;
-}
-
-static inline int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
-                                        vaddr len, int flags)
-{
-    return -ENOSYS;
-}
-
-static inline void cpu_watchpoint_remove_by_ref(CPUState *cpu,
-                                                CPUWatchpoint *wp)
-{
-}
-
-static inline void cpu_watchpoint_remove_all(CPUState *cpu, int mask)
-{
-}
-#else
-int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
-                          int flags, CPUWatchpoint **watchpoint);
-int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
-                          vaddr len, int flags);
-void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *watchpoint);
-void cpu_watchpoint_remove_all(CPUState *cpu, int mask);
-#endif
-
 /**
  * cpu_get_address_space:
  * @cpu: CPU to get address space from
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index d9b662efe3..5c88056157 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -37,6 +37,7 @@
 #include "exec/hwaddr.h"
 #include "exec/tb-flush.h"
 #include "exec/translation-block.h"
+#include "exec/watchpoint.h"
 #include "gdbstub/enums.h"
 
 #include "hw/core/cpu.h"
diff --git a/system/watchpoint.c b/system/watchpoint.c
index 08dbd8483d..21d0bb36ca 100644
--- a/system/watchpoint.c
+++ b/system/watchpoint.c
@@ -21,6 +21,7 @@
 #include "qemu/error-report.h"
 #include "exec/cputlb.h"
 #include "exec/target_page.h"
+#include "exec/watchpoint.h"
 #include "hw/core/cpu.h"
 
 /* Add a watchpoint.  */
diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index a9a619ba6b..473ee2af38 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -13,6 +13,7 @@
 #include "cpregs.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
+#include "exec/watchpoint.h"
 #include "system/tcg.h"
 
 #ifdef CONFIG_TCG
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index dba1b3ffef..af46c7a392 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -35,6 +35,7 @@
 #include "standard-headers/asm-x86/kvm_para.h"
 #include "hw/qdev-properties.h"
 #include "hw/i386/topology.h"
+#include "exec/watchpoint.h"
 #ifndef CONFIG_USER_ONLY
 #include "system/reset.h"
 #include "qapi/qapi-commands-machine-target.h"
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 70f632a36f..6cb561c632 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -7,7 +7,7 @@
 #include "hw/i386/x86.h"
 #include "kvm/kvm_i386.h"
 #include "hw/xen/xen.h"
-
+#include "exec/watchpoint.h"
 #include "system/kvm.h"
 #include "system/kvm_xen.h"
 #include "system/tcg.h"
diff --git a/target/i386/tcg/system/bpt_helper.c b/target/i386/tcg/system/bpt_helper.c
index be232c1ca9..08ccd3f5e6 100644
--- a/target/i386/tcg/system/bpt_helper.c
+++ b/target/i386/tcg/system/bpt_helper.c
@@ -21,6 +21,7 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
+#include "exec/watchpoint.h"
 #include "tcg/helper-tcg.h"
 
 
diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
index bfcc695de7..4d8faaddee 100644
--- a/target/ppc/cpu.c
+++ b/target/ppc/cpu.c
@@ -22,6 +22,7 @@
 #include "cpu-models.h"
 #include "cpu-qom.h"
 #include "exec/log.h"
+#include "exec/watchpoint.h"
 #include "fpu/softfloat-helpers.h"
 #include "mmu-hash64.h"
 #include "helper_regs.h"
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index f81cb680fc..17f0f3d3ff 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -40,7 +40,7 @@
 #include "qemu/cutils.h"
 #include "disas/capstone.h"
 #include "fpu/softfloat.h"
-
+#include "exec/watchpoint.h"
 #include "helper_regs.h"
 #include "internal.h"
 #include "spr_common.h"
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 9db4048523..fea989afe9 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -30,6 +30,7 @@
 #include "trace.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
+#include "exec/watchpoint.h"
 #include "system/cpu-timers.h"
 
 /*
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index c689e11b46..e660c69f60 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -27,6 +27,7 @@
 #include "target/s390x/kvm/pv.h"
 #include "system/hw_accel.h"
 #include "system/runstate.h"
+#include "exec/watchpoint.h"
 
 void s390x_tod_timer(void *opaque)
 {
diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
index ac733f407f..1d51043e88 100644
--- a/target/s390x/tcg/excp_helper.c
+++ b/target/s390x/tcg/excp_helper.c
@@ -24,6 +24,7 @@
 #include "exec/helper-proto.h"
 #include "exec/cputlb.h"
 #include "exec/exec-all.h"
+#include "exec/watchpoint.h"
 #include "s390x-internal.h"
 #include "tcg_s390x.h"
 #ifndef CONFIG_USER_ONLY
diff --git a/target/xtensa/dbg_helper.c b/target/xtensa/dbg_helper.c
index 163a1ffc7b..c4f4298a50 100644
--- a/target/xtensa/dbg_helper.c
+++ b/target/xtensa/dbg_helper.c
@@ -31,6 +31,7 @@
 #include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
 #include "exec/exec-all.h"
+#include "exec/watchpoint.h"
 #include "system/address-spaces.h"
 
 void HELPER(wsr_ibreakenable)(CPUXtensaState *env, uint32_t v)
-- 
2.43.0


