Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E67BBC25B75
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 12:27:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBCxh-0006KO-Tu; Sun, 26 May 2024 08:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sBCxf-0006JR-Fl; Sun, 26 May 2024 08:26:51 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sBCxd-0001Nt-Hn; Sun, 26 May 2024 08:26:51 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-681907af4e7so1712509a12.1; 
 Sun, 26 May 2024 05:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716726407; x=1717331207; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KxtsOOjIQD+5fdn20u7+8eRQWnzhtvstNVtvMn8QGkc=;
 b=jmpFeL9fyXA8YIaXmf551CL2fn5t4wvzJ8su/kGHSln1nuzmtgBU0JZ2ak3n44XQ4A
 WABmctLi54bdrs6dvIs1u4CMzwLqv84qBBRH/2V2mmCNygk+GsYGDE44mGnD6q9EaPPj
 mHt/iasCynd/fD6C2a3LDUhXl6H8TYxwU/iJkb3qH3gcz1own7wHZPFy6dNXfeVVaFTn
 gu7zkK10H+OZesOgdX0botIF+JOpy65Udmev9oD+p1RrlojflHwgBLIPq0gEuiWF1zRW
 Sp9sxqfhm934n6MHBcvclRzKD2S/uQnNrwMRjVG1MM9QyFDynfqCfy95BVVLUpDESmQL
 EGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716726407; x=1717331207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KxtsOOjIQD+5fdn20u7+8eRQWnzhtvstNVtvMn8QGkc=;
 b=tul5QuSZbCbRKGUtphYW3r6sWemjG0dVEPrxR4sr2tNsSXOti1m2PDqEbSwCo1s4GR
 c4skTUxZVxkjgiNaf38XVqN2I31GBAuIdnHxrRgNM+AMFe/9xtrgpSZU9KNYHft6z10g
 ItkhX7jL17SpmxkouN29hLbCUXf4UoWmBqh8eU0exNAax6uIFkIBixh3Nclj76TQSIWf
 FR8JSDFtfIzOJJNd43fdUlO1uGueXad1m0QAJUtstMsmT/PM3QdUlHPSSh8nkokvE8JF
 XP1/RNOWkOWJ+ZAga2wkuGT6wsOEZfiwNwcHH9zBrcd8uwy7ZzjI8AlEiOWg1aW2G9Ey
 wqZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvtLWRwKC/w86Xnx0y8oKuOxS0W5+8fYHlsgpHkiPUXRfcQMDrVaEzvj+ZcAE+lQ98B9WSjusCDmbMPAEqV31q6Czkk0k=
X-Gm-Message-State: AOJu0YyP4s1HFJ8Ij7QcplcaMha0lT3SiQDNVlJ15iI4D3sbda+5IZF9
 CHIg3GKRbTtzJBxDE2PNgQIouSoMoORdUpL84KSwExf+DHP+FAVqiP7bFQ==
X-Google-Smtp-Source: AGHT+IHFjBjLzfw+yubnSNh/oHL6cKhmHOVf8i706brp/H6k9T82RdeAN8DJv+fnFdpQVQNOWDYLlg==
X-Received: by 2002:a05:6a21:1518:b0:1b1:d591:d24 with SMTP id
 adf61e73a8af0-1b212d2a8f5mr7664391637.16.1716726407375; 
 Sun, 26 May 2024 05:26:47 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fcfe648bsm3457182b3a.168.2024.05.26.05.26.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 05:26:47 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
Subject: [RFC PATCH 07/10] target/ppc: Add helpers to check for SMT sibling
 threads
Date: Sun, 26 May 2024 22:26:08 +1000
Message-ID: <20240526122612.473476-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240526122612.473476-1-npiggin@gmail.com>
References: <20240526122612.473476-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add helpers for TCG code to determine if there are SMT siblings
sharing per-core and per-lpar registers. This simplifies the
callers and makes SMT register topology simpler to modify with
later changes.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.h             |  7 +++++++
 target/ppc/cpu_init.c        |  2 +-
 target/ppc/excp_helper.c     | 16 +++++++---------
 target/ppc/misc_helper.c     | 27 ++++++---------------------
 target/ppc/timebase_helper.c | 20 +++++++-------------
 5 files changed, 28 insertions(+), 44 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 9a89083932..8fd6ade471 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1406,6 +1406,13 @@ struct CPUArchState {
     uint64_t pmu_base_time;
 };
 
+#define PPC_CPU_HAS_CORE_SIBLINGS(cs)                           \
+    (cs->nr_threads > 1)
+
+#define PPC_CPU_HAS_LPAR_SIBLINGS(cs)                           \
+    ((POWERPC_CPU(cs)->env.flags & POWERPC_FLAG_SMT_1LPAR) &&   \
+     PPC_CPU_HAS_CORE_SIBLINGS(cs))
+
 #define _CORE_ID(cs)                                            \
     (POWERPC_CPU(cs)->env.core_index)
 
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index ae483e20c4..e71ee008ed 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6975,7 +6975,7 @@ static void ppc_cpu_realize(DeviceState *dev, Error **errp)
 
     pcc->parent_realize(dev, errp);
 
-    if (env_cpu(env)->nr_threads > 1) {
+    if (PPC_CPU_HAS_CORE_SIBLINGS(cs)) {
         env->flags |= POWERPC_FLAG_SMT;
     }
 
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 0cd542675f..fd45da0f2b 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -3029,7 +3029,7 @@ void helper_book3s_msgsnd(CPUPPCState *env, target_ulong rb)
         brdcast = true;
     }
 
-    if (cs->nr_threads == 1 || !brdcast) {
+    if (!PPC_CPU_HAS_CORE_SIBLINGS(cs) || !brdcast) {
         ppc_set_irq(cpu, PPC_INTERRUPT_HDOORBELL, 1);
         return;
     }
@@ -3067,21 +3067,19 @@ void helper_book3s_msgsndp(CPUPPCState *env, target_ulong rb)
     CPUState *cs = env_cpu(env);
     PowerPCCPU *cpu = env_archcpu(env);
     CPUState *ccs;
-    uint32_t nr_threads = cs->nr_threads;
     int ttir = rb & PPC_BITMASK(57, 63);
 
     helper_hfscr_facility_check(env, HFSCR_MSGP, "msgsndp", HFSCR_IC_MSGP);
 
-    if (!(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
-        nr_threads = 1; /* msgsndp behaves as 1-thread in LPAR-per-thread mode*/
-    }
-
-    if (!dbell_type_server(rb) || ttir >= nr_threads) {
+    if (!dbell_type_server(rb)) {
         return;
     }
 
-    if (nr_threads == 1) {
-        ppc_set_irq(cpu, PPC_INTERRUPT_DOORBELL, 1);
+    /* msgsndp behaves as 1-thread in LPAR-per-thread mode*/
+    if (!PPC_CPU_HAS_LPAR_SIBLINGS(cs)) {
+        if (ttir == 0) {
+            ppc_set_irq(cpu, PPC_INTERRUPT_DOORBELL, 1);
+        }
         return;
     }
 
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index 46ba3a5584..598c956cdd 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -49,9 +49,8 @@ void helper_spr_core_write_generic(CPUPPCState *env, uint32_t sprn,
 {
     CPUState *cs = env_cpu(env);
     CPUState *ccs;
-    uint32_t nr_threads = cs->nr_threads;
 
-    if (nr_threads == 1) {
+    if (!PPC_CPU_HAS_CORE_SIBLINGS(cs)) {
         env->spr[sprn] = val;
         return;
     }
@@ -196,7 +195,7 @@ void helper_store_ptcr(CPUPPCState *env, target_ulong val)
             return;
         }
 
-        if (cs->nr_threads == 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
+        if (!PPC_CPU_HAS_LPAR_SIBLINGS(cs)) {
             env->spr[SPR_PTCR] = val;
             tlb_flush(cs);
         } else {
@@ -243,16 +242,12 @@ target_ulong helper_load_dpdes(CPUPPCState *env)
 {
     CPUState *cs = env_cpu(env);
     CPUState *ccs;
-    uint32_t nr_threads = cs->nr_threads;
     target_ulong dpdes = 0;
 
     helper_hfscr_facility_check(env, HFSCR_MSGP, "load DPDES", HFSCR_IC_MSGP);
 
-    if (!(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
-        nr_threads = 1; /* DPDES behaves as 1-thread in LPAR-per-thread mode */
-    }
-
-    if (nr_threads == 1) {
+    /* DPDES behaves as 1-thread in LPAR-per-thread mode */
+    if (!PPC_CPU_HAS_LPAR_SIBLINGS(cs)) {
         if (env->pending_interrupts & PPC_INTERRUPT_DOORBELL) {
             dpdes = 1;
         }
@@ -279,21 +274,11 @@ void helper_store_dpdes(CPUPPCState *env, target_ulong val)
     PowerPCCPU *cpu = env_archcpu(env);
     CPUState *cs = env_cpu(env);
     CPUState *ccs;
-    uint32_t nr_threads = cs->nr_threads;
 
     helper_hfscr_facility_check(env, HFSCR_MSGP, "store DPDES", HFSCR_IC_MSGP);
 
-    if (!(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
-        nr_threads = 1; /* DPDES behaves as 1-thread in LPAR-per-thread mode */
-    }
-
-    if (val & ~(nr_threads - 1)) {
-        qemu_log_mask(LOG_GUEST_ERROR, "Invalid DPDES register value "
-                      TARGET_FMT_lx"\n", val);
-        val &= (nr_threads - 1); /* Ignore the invalid bits */
-    }
-
-    if (nr_threads == 1) {
+    /* DPDES behaves as 1-thread in LPAR-per-thread mode */
+    if (!PPC_CPU_HAS_LPAR_SIBLINGS(cs)) {
         ppc_set_irq(cpu, PPC_INTERRUPT_DOORBELL, val & 0x1);
         return;
     }
diff --git a/target/ppc/timebase_helper.c b/target/ppc/timebase_helper.c
index 788c498d63..abe7b95696 100644
--- a/target/ppc/timebase_helper.c
+++ b/target/ppc/timebase_helper.c
@@ -63,9 +63,8 @@ void helper_store_purr(CPUPPCState *env, target_ulong val)
 {
     CPUState *cs = env_cpu(env);
     CPUState *ccs;
-    uint32_t nr_threads = cs->nr_threads;
 
-    if (nr_threads == 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
+    if (!PPC_CPU_HAS_LPAR_SIBLINGS(cs)) {
         cpu_ppc_store_purr(env, val);
         return;
     }
@@ -82,9 +81,8 @@ void helper_store_tbl(CPUPPCState *env, target_ulong val)
 {
     CPUState *cs = env_cpu(env);
     CPUState *ccs;
-    uint32_t nr_threads = cs->nr_threads;
 
-    if (nr_threads == 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
+    if (!PPC_CPU_HAS_LPAR_SIBLINGS(cs)) {
         cpu_ppc_store_tbl(env, val);
         return;
     }
@@ -99,9 +97,8 @@ void helper_store_tbu(CPUPPCState *env, target_ulong val)
 {
     CPUState *cs = env_cpu(env);
     CPUState *ccs;
-    uint32_t nr_threads = cs->nr_threads;
 
-    if (nr_threads == 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
+    if (!PPC_CPU_HAS_LPAR_SIBLINGS(cs)) {
         cpu_ppc_store_tbu(env, val);
         return;
     }
@@ -141,9 +138,8 @@ void helper_store_hdecr(CPUPPCState *env, target_ulong val)
 {
     CPUState *cs = env_cpu(env);
     CPUState *ccs;
-    uint32_t nr_threads = cs->nr_threads;
 
-    if (nr_threads == 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
+    if (!PPC_CPU_HAS_LPAR_SIBLINGS(cs)) {
         cpu_ppc_store_hdecr(env, val);
         return;
     }
@@ -158,9 +154,8 @@ void helper_store_vtb(CPUPPCState *env, target_ulong val)
 {
     CPUState *cs = env_cpu(env);
     CPUState *ccs;
-    uint32_t nr_threads = cs->nr_threads;
 
-    if (nr_threads == 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
+    if (!PPC_CPU_HAS_LPAR_SIBLINGS(cs)) {
         cpu_ppc_store_vtb(env, val);
         return;
     }
@@ -175,9 +170,8 @@ void helper_store_tbu40(CPUPPCState *env, target_ulong val)
 {
     CPUState *cs = env_cpu(env);
     CPUState *ccs;
-    uint32_t nr_threads = cs->nr_threads;
 
-    if (nr_threads == 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
+    if (!PPC_CPU_HAS_LPAR_SIBLINGS(cs)) {
         cpu_ppc_store_tbu40(env, val);
         return;
     }
@@ -288,7 +282,7 @@ static void write_tfmr(CPUPPCState *env, target_ulong val)
 {
     CPUState *cs = env_cpu(env);
 
-    if (cs->nr_threads == 1) {
+    if (!PPC_CPU_HAS_CORE_SIBLINGS(cs)) {
         env->spr[SPR_TFMR] = val;
     } else {
         CPUState *ccs;
-- 
2.43.0


