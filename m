Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2EBDC3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 16:29:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTl2V-0003hw-K1; Tue, 16 Jul 2024 12:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sTl0n-0005xw-Nb; Tue, 16 Jul 2024 12:26:48 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sTl0k-0006L6-Te; Tue, 16 Jul 2024 12:26:45 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5cce7626c87so1821139eaf.2; 
 Tue, 16 Jul 2024 09:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721147201; x=1721752001; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SyhirM3GRw4vaEFR7fdPD23qctfXv4t8r+16JQT6sG0=;
 b=P6pmAKKSNNsk4E2vvpl3Tmhggnk8Cj9Yf8HfFcHutaz5YRgoZ5Nf4RyBc6Q0+pMlMx
 cmvAFNEWDVPsy1rmEen3zKNwayoDc3ey3+BmoIzsC2bJHiurPOUlYsXjvtzXwKmO/4X8
 w39pgp193SVMVZvjlR2qkForu9R4PDpv03RI6pmWQO+WnR+nYr6fE7/KbHWa5XMJqEsL
 sNlpFrd2Pn/OO+aGK20gA64nu7NyRLhvMPi3n5iPCDLMMRgpQJZ3J90iFXEkHubAaVzM
 BRAp/Xtn1ME4f3E4xs3J8tTWE54/jSlQwTWaeF5HsUjKhgP3Y0VL7t5pkyrt0EfMNNNO
 ubLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721147201; x=1721752001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SyhirM3GRw4vaEFR7fdPD23qctfXv4t8r+16JQT6sG0=;
 b=uC0Mh4qQ+PpMgm1KhnZQwH8MdtRVfdx2A35OGOlsgL3/kIj7gSp8HYtPCAqEjj0hlX
 4EBI6vGL2I88PHg+8rLOQedNIm43X0mKa3ExpXQI9tvW8D5ZvcEB5oLTb4DTe3vjSZhi
 l+TORggVhEMeCiJWxNB202Ua0nEX9N6IXh6fJ4cOiENnzAJlKfIlRymOGH2AWgDhc2BA
 O35xjtsGuo4LBj0Mppn66whHBEHdXR7JRFezdk1un8xQpH7/tLkqkfrkAtubJUMRBwMr
 9cz0prjaSg0eeJigbPhuarJeDVTUnzu9sra+bhPvAJscv2mf87RyQh7a+UmygpowEaNr
 jzzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXneEQxVDWFexREytI0AeYXwOgFty0+xqTsDgpXW09WhS2hF6PBFYBZWLEDIo2KY4Vfh64zW3WBcUd4th0U5lXXlHQBrh8=
X-Gm-Message-State: AOJu0YyiBKrmeLtP+lpnxVDZQFSqqR0IsfLsXGJE8QGvWN8y2hJOq9SW
 ZetqA05Ofl29uPRzXYBB3E5tFzrikCzVujgiI8cxA/AydgT7LJs9LqqkFQ==
X-Google-Smtp-Source: AGHT+IEuPNCrQtiixPNowUbictzK3rNDu2r+99ZW1Y0beUXoqfG9FkBltyngmkpQ0RAokqluZ/jA9w==
X-Received: by 2002:a05:6870:b52b:b0:25e:27a4:4e51 with SMTP id
 586e51a60fabf-260bdd82c79mr2131619fac.20.1721147200653; 
 Tue, 16 Jul 2024 09:26:40 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7eca86d6sm6722161b3a.179.2024.07.16.09.26.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 09:26:40 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 04/19] target/ppc: Move SPR indirect registers into PnvCore
Date: Wed, 17 Jul 2024 02:26:00 +1000
Message-ID: <20240716162617.32161-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240716162617.32161-1-npiggin@gmail.com>
References: <20240716162617.32161-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=npiggin@gmail.com; helo=mail-oo1-xc29.google.com
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
 target/ppc/cpu_init.c     | 21 +++++++-------
 target/ppc/misc_helper.c  | 60 ++++++++++++++++++---------------------
 4 files changed, 39 insertions(+), 46 deletions(-)

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
index e38f62b08d..164bb62e63 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -5777,16 +5777,6 @@ static void register_power_common_book4_sprs(CPUPPCState *env)
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
 
@@ -5799,6 +5789,17 @@ static void register_power9_book4_sprs(CPUPPCState *env)
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
index fa47be2298..4d3c1bddd9 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -26,6 +26,7 @@
 #include "qemu/main-loop.h"
 #include "mmu-book3s-v3.h"
 #include "hw/ppc/ppc.h"
+#include "hw/ppc/pnv_core.h"
 
 #include "helper_regs.h"
 
@@ -321,11 +322,18 @@ void helper_store_sprc(CPUPPCState *env, target_ulong val)
 
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
@@ -334,41 +342,27 @@ target_ulong helper_load_sprd(CPUPPCState *env)
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
+        int nr = (sprc >> 3) & 0x7;
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
2.45.1


