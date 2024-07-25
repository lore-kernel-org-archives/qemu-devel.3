Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC11C3DA70
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:00:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8JI-0000TB-Q8; Thu, 25 Jul 2024 19:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8JG-00009A-Vh; Thu, 25 Jul 2024 19:55:47 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8JF-0000za-0C; Thu, 25 Jul 2024 19:55:46 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2cb5b783c15so304996a91.2; 
 Thu, 25 Jul 2024 16:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951743; x=1722556543; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mlve1baNgtnPcHs8Nr18CJBq5Pg2Z6rLLjzWJG525kQ=;
 b=QtTyXEHGsS+J4wTRp9RBLHxG02b/Cd4WRIPpEq/fTDZU+MvJpfZkp/yl+7cBWL3rEA
 fubtuoqrMxbqsYDvMf/0ZuZd5/B20fmiWc+akTMf1HiMqJZEN+z0PCAV326FzrgS26ZE
 2bNtdhrMP2UA3fWqHke8WbYYt37HKT3RmbisDGKOU8tRQ2MrcIW0XCOFd6lkNi+TT5hT
 7fSG95fXNpMisJjQtVv9MP8Y6ECHzhi5bOd8WmHJyjHTq2U/YPyQkJHozU3iXPdJfVE7
 x5iM1efCG7qcThd/LUmccu3qP+lvdM5CWw7GAICoOLpj7OzZVpgleay1waQnAKOPonyc
 3bDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951743; x=1722556543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mlve1baNgtnPcHs8Nr18CJBq5Pg2Z6rLLjzWJG525kQ=;
 b=Vjz4dUMlGUgQQ27OFr35gbHe7eoOKPXa+JbYHzFC7FLZFwFC4coBJOo3WtfEDTlhxl
 1w4h63QQqrCRtFclyXYbZ6we+ISrY36N4bl5j7ZAf9xrWDpWwcbtX73K4aBoauFPpF9C
 hCt6dA/xBOsP+3VKCDD+/BZ8nGOUfUo/aSSSSRWY6Z298o3zr/46MdH023OpvQgYihq1
 KpPZUpWLDe1aywF0gJ/fVTf1nUcuHo06+K8dkEuC3YT+6TOQW2ck6++IIaGMRQ2c/v5J
 bHfimk0dVTt2PWTwQmh5GN1DgDfwToZJNlt9ECHtP0Zj8a95e7UCPTK5XkIGz1KKER2m
 SubA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeIJrJqyvP0KOqUZIWHi/4VNpnHndbxwHwVAlrS0uBjMc3C+xBykXq2NnxFb214mpaGEVjx1I4swbjkem3/jUNFTDZ
X-Gm-Message-State: AOJu0YwBKdoQnwmqCICRrva46ynT3Fqom+zyk9iL5rn/dGW8GXpv55yx
 rIo0+C8o5sdy2yBgNs55VAzW2AQXcSxc+87liEN2bIK3YI0X8bm3Obu4wg==
X-Google-Smtp-Source: AGHT+IG4H0FaAq01su1PZJ1zglttZPYUmcXVNYEQLI2ZT06SgG3GzHWusT0udAFSCWf+u9RzxlXAzw==
X-Received: by 2002:a17:90b:3810:b0:2c9:6d07:18f4 with SMTP id
 98e67ed59e1d1-2cf239063c4mr5290035a91.35.1721951742867; 
 Thu, 25 Jul 2024 16:55:42 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.55.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:55:42 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-ppc@nongnu.org
Subject: [PULL 21/96] target/ppc: Move SPR indirect registers into PnvCore
Date: Fri, 26 Jul 2024 09:52:54 +1000
Message-ID: <20240725235410.451624-22-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

SPRC/SPRD were recently added to all BookS CPUs supported, but
they are only tested on POWER9 and POWER10, so restrict them to
those CPUs.

SPR indirect scratch registers presently replicated per-CPU like
SMT SPRs, but the PnvCore is a better place for them since they
are restricted to P9/P10.

Also add SPR indirect read access to core thread state for POWER9
since skiboot accesses that when booting to check for big-core
mode.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/ppc/pnv_core.h |  1 +
 target/ppc/cpu.h          |  3 --
 target/ppc/cpu_init.c     | 21 ++++++------
 target/ppc/misc_helper.c  | 67 ++++++++++++++++++++-------------------
 4 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
index ffec8516ae..693acb189b 100644
--- a/include/hw/ppc/pnv_core.h
+++ b/include/hw/ppc/pnv_core.h
@@ -53,6 +53,7 @@ struct PnvCore {
     uint32_t hwid;
     uint64_t hrmor;
 
+    target_ulong scratch[8]; /* SPRC/SPRD indirect SCRATCH registers */
     PnvCoreTODState tod_state;
 
     PnvChip *chip;
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index c78d6ca91a..95ba9e7590 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1253,9 +1253,6 @@ struct CPUArchState {
     ppc_slb_t slb[MAX_SLB_ENTRIES]; /* PowerPC 64 SLB area */
     struct CPUBreakpoint *ciabr_breakpoint;
     struct CPUWatchpoint *dawr0_watchpoint;
-
-    /* POWER CPU regs/state */
-    target_ulong scratch[8]; /* SCRATCH registers (shared across core) */
 #endif
     target_ulong sr[32];   /* segment registers */
     uint32_t nb_BATs;      /* number of BATs */
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 2e652f498e..42bb047b54 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -5760,16 +5760,6 @@ static void register_power_common_book4_sprs(CPUPPCState *env)
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_generic, &spr_core_write_generic,
                  0x00000000);
-    spr_register_hv(env, SPR_POWER_SPRC, "SPRC",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_sprc,
-                 0x00000000);
-    spr_register_hv(env, SPR_POWER_SPRD, "SPRD",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_sprd, &spr_write_sprd,
-                 0x00000000);
 #endif
 }
 
@@ -5803,6 +5793,17 @@ static void register_power8_book4_sprs(CPUPPCState *env)
                      SPR_NOACCESS, SPR_NOACCESS,
                      &spr_read_generic, &spr_write_generic,
                      KVM_REG_PPC_WORT, 0);
+    /* SPRC/SPRD exist in earlier CPUs but only tested on POWER9/10 */
+    spr_register_hv(env, SPR_POWER_SPRC, "SPRC",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_generic, &spr_write_sprc,
+                 0x00000000);
+    spr_register_hv(env, SPR_POWER_SPRD, "SPRD",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_sprd, &spr_write_sprd,
+                 0x00000000);
 #endif
 }
 
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index fa47be2298..de7c8813ec 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -308,6 +308,13 @@ void helper_store_dpdes(CPUPPCState *env, target_ulong val)
     bql_unlock();
 }
 
+/*
+ * qemu-user breaks with pnv headers, so they go under ifdefs for now.
+ * A clean up may be to move powernv specific registers and helpers into
+ * target/ppc/pnv_helper.c
+ */
+#include "hw/ppc/pnv_core.h"
+
 /* Indirect SCOM (SPRC/SPRD) access to SCRATCH0-7 are implemented. */
 void helper_store_sprc(CPUPPCState *env, target_ulong val)
 {
@@ -321,11 +328,18 @@ void helper_store_sprc(CPUPPCState *env, target_ulong val)
 
 target_ulong helper_load_sprd(CPUPPCState *env)
 {
+    /*
+     * SPRD is a HV-only register for Power CPUs, so this will only be
+     * accessed by powernv machines.
+     */
+    PowerPCCPU *cpu = env_archcpu(env);
+    PnvCore *pc = pnv_cpu_state(cpu)->pnv_core;
     target_ulong sprc = env->spr[SPR_POWER_SPRC];
 
-    switch (sprc & 0x3c0) {
-    case 0: /* SCRATCH0-7 */
-        return env->scratch[(sprc >> 3) & 0x7];
+    switch (sprc & 0x3e0) {
+    case 0: /* SCRATCH0-3 */
+    case 1: /* SCRATCH4-7 */
+        return pc->scratch[(sprc >> 3) & 0x7];
     default:
         qemu_log_mask(LOG_UNIMP, "mfSPRD: Unimplemented SPRC:0x"
                                   TARGET_FMT_lx"\n", sprc);
@@ -334,41 +348,28 @@ target_ulong helper_load_sprd(CPUPPCState *env)
     return 0;
 }
 
-static void do_store_scratch(CPUPPCState *env, int nr, target_ulong val)
-{
-    CPUState *cs = env_cpu(env);
-    CPUState *ccs;
-    uint32_t nr_threads = cs->nr_threads;
-
-    /*
-     * Log stores to SCRATCH, because some firmware uses these for debugging
-     * and logging, but they would normally be read by the BMC, which is
-     * not implemented in QEMU yet. This gives a way to get at the information.
-     * Could also dump these upon checkstop.
-     */
-    qemu_log("SPRD write 0x" TARGET_FMT_lx " to SCRATCH%d\n", val, nr);
-
-    if (nr_threads == 1) {
-        env->scratch[nr] = val;
-        return;
-    }
-
-    THREAD_SIBLING_FOREACH(cs, ccs) {
-        CPUPPCState *cenv = &POWERPC_CPU(ccs)->env;
-        cenv->scratch[nr] = val;
-    }
-}
-
 void helper_store_sprd(CPUPPCState *env, target_ulong val)
 {
     target_ulong sprc = env->spr[SPR_POWER_SPRC];
-
-    switch (sprc & 0x3c0) {
-    case 0: /* SCRATCH0-7 */
-        do_store_scratch(env, (sprc >> 3) & 0x7, val);
+    PowerPCCPU *cpu = env_archcpu(env);
+    PnvCore *pc = pnv_cpu_state(cpu)->pnv_core;
+    int nr;
+
+    switch (sprc & 0x3e0) {
+    case 0: /* SCRATCH0-3 */
+    case 1: /* SCRATCH4-7 */
+        /*
+         * Log stores to SCRATCH, because some firmware uses these for
+         * debugging and logging, but they would normally be read by the BMC,
+         * which is not implemented in QEMU yet. This gives a way to get at the
+         * information. Could also dump these upon checkstop.
+         */
+        nr = (sprc >> 3) & 0x7;
+        qemu_log("SPRD write 0x" TARGET_FMT_lx " to SCRATCH%d\n", val, nr);
+        pc->scratch[nr] = val;
         break;
     default:
-        qemu_log_mask(LOG_UNIMP, "mfSPRD: Unimplemented SPRC:0x"
+        qemu_log_mask(LOG_UNIMP, "mtSPRD: Unimplemented SPRC:0x"
                                   TARGET_FMT_lx"\n", sprc);
         break;
     }
-- 
2.45.2


