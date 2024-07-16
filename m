Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6541CC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 16:31:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTl2Q-0002mY-H5; Tue, 16 Jul 2024 12:28:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sTl1F-0006V6-KT; Tue, 16 Jul 2024 12:27:17 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sTl1A-0006TI-0N; Tue, 16 Jul 2024 12:27:10 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-70b0d0fefe3so3801992b3a.2; 
 Tue, 16 Jul 2024 09:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721147216; x=1721752016; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P/jaJY+EjT/k2aXL1glM+yk4w079Fmr/WkbzC5YoxgU=;
 b=RYVIg9MBTk8JoppeoCyfz8yyNctBqeVy2ikaQLcm3RxjOTZ4BvxILMlbFyPIimUytP
 fPazvoOly+Ljb7xzdYDk0RknEdwODFdGbv4ZBqGLKFIkaACjeEI63w/dVm0swi9SXy5X
 pmlATUQDGkxl0hW44iT+VORSBkw0CNlDaW1Bpc35yWgwTg9EGbKczEK9lLX2wzNdXOdX
 p4EGd/fZVKSM9Zyj4Ro1tgROgzDT7SB1p/xkizEvYGbnaRRHRauadaAity12OHqEYz0P
 ydn9mfMHTIT+7RCi3caVEuP1xuYrVon974k3aU5f6NLWJDrKYMUS/n+leDXs6PVKKFfF
 fEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721147216; x=1721752016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P/jaJY+EjT/k2aXL1glM+yk4w079Fmr/WkbzC5YoxgU=;
 b=V/EtW/Vrf1bIPMvQ3HxEk4DDpOz6k4loImwAB+RIqvmzpFrR2P2E+8cdvh6Re5rQ9Y
 pxKpTaVxFe9taFpdxxB6oN9MG7N9IEVKuoYNJAuIeZRg6b3oIUtg9n9UX6v5rjIbNSQa
 rJhwxIX5mUqs5+/r4NXDewUhg00iUT96I2HSk6lSeYSl0xjp0lZQrY4gsEZzt6a9nn24
 Y+GSZBI6kfFrDzfba97a4EA8MafO9qUvBSwpU1Tbaq5vmvM08g8WFpTFId/RZGZyXqw4
 O7wC7dQnzTkYRsBa3FW+3RhifPacZcLe3DKebd6H0Nj/3kpyh0U2m2iPE9XzdqndBUEl
 oLhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/iGw8bkiuUaAlqPZ9sQmwfFOCBaS4NfZjCFdTZgCVVauXLa/fDrjoVF/HRbtQ2O0YfYC0XUPRiAvXBmLREoF6IWsEIag=
X-Gm-Message-State: AOJu0YxigkXMVa6hAfw3xsVQaXhVnXvPu66+KZfZa+29qLelF/jCmxgr
 BtcBKEhiY+0FOuk26FXCos4HasDKI1DPNEyztkhZqRcX+uidpGACxAU++Q==
X-Google-Smtp-Source: AGHT+IFiEEZ1j7C3/LhPSE88tX/K0zT0Bl2AVFxe4IpKxW8/Ty5QAFI2Jt8T8VBlf19/hKHlNPXVpQ==
X-Received: by 2002:a05:6a21:3384:b0:1c2:8f4b:503b with SMTP id
 adf61e73a8af0-1c3f11eb825mr3369001637.11.1721147215765; 
 Tue, 16 Jul 2024 09:26:55 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7eca86d6sm6722161b3a.179.2024.07.16.09.26.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 09:26:55 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 08/19] target/ppc: Add helpers to check for SMT sibling
 threads
Date: Wed, 17 Jul 2024 02:26:04 +1000
Message-ID: <20240716162617.32161-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240716162617.32161-1-npiggin@gmail.com>
References: <20240716162617.32161-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
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

Add helpers for TCG code to determine if there are SMT siblings
sharing per-core and per-lpar registers. This simplifies the
callers and makes SMT register topology simpler to modify with
later changes.

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.h             | 11 +++++++++++
 target/ppc/cpu_init.c        |  2 +-
 target/ppc/excp_helper.c     | 17 +++++------------
 target/ppc/misc_helper.c     | 27 ++++++---------------------
 target/ppc/timebase_helper.c | 20 +++++++-------------
 5 files changed, 30 insertions(+), 47 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 7b52a9bb18..417b284318 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1512,6 +1512,17 @@ struct PowerPCCPUClass {
     int  (*check_attn)(CPUPPCState *env);
 };
 
+static inline bool ppc_cpu_core_single_threaded(CPUState *cs)
+{
+    return cs->nr_threads == 1;
+}
+
+static inline bool ppc_cpu_lpar_single_threaded(CPUState *cs)
+{
+    return !(POWERPC_CPU(cs)->env.flags & POWERPC_FLAG_SMT_1LPAR) ||
+           ppc_cpu_core_single_threaded(cs);
+}
+
 ObjectClass *ppc_cpu_class_by_name(const char *name);
 PowerPCCPUClass *ppc_cpu_class_by_pvr(uint32_t pvr);
 PowerPCCPUClass *ppc_cpu_class_by_pvr_mask(uint32_t pvr);
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 164bb62e63..81dd4e1a7a 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6993,7 +6993,7 @@ static void ppc_cpu_realize(DeviceState *dev, Error **errp)
 
     pcc->parent_realize(dev, errp);
 
-    if (env_cpu(env)->nr_threads > 1) {
+    if (!ppc_cpu_core_single_threaded(cs)) {
         env->flags |= POWERPC_FLAG_SMT;
     }
 
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 5368bf2ff3..5ecd662f9e 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -3014,18 +3014,11 @@ static void msgsnd_core_tir(CPUPPCState *env, uint32_t target_tir, int irq)
 {
     PowerPCCPU *cpu = env_archcpu(env);
     CPUState *cs = env_cpu(env);
-    uint32_t nr_threads = cs->nr_threads;
 
-    if (!(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
-        nr_threads = 1; /* msgsndp behaves as 1-thread in LPAR-per-thread mode*/
-    }
-
-    if (target_tir >= nr_threads) {
-        return;
-    }
-
-    if (nr_threads == 1) {
-        ppc_set_irq(cpu, irq, 1);
+    if (ppc_cpu_lpar_single_threaded(cs)) {
+        if (target_tir == 0) {
+            ppc_set_irq(cpu, irq, 1);
+        }
     } else {
         CPUState *ccs;
 
@@ -3080,7 +3073,7 @@ void helper_book3s_msgsnd(CPUPPCState *env, target_ulong rb)
         brdcast = true;
     }
 
-    if (cs->nr_threads == 1 || !brdcast) {
+    if (ppc_cpu_core_single_threaded(cs) || !brdcast) {
         ppc_set_irq(cpu, PPC_INTERRUPT_HDOORBELL, 1);
         return;
     }
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index 4d3c1bddd9..692e48e6bc 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -49,9 +49,8 @@ void helper_spr_core_write_generic(CPUPPCState *env, uint32_t sprn,
 {
     CPUState *cs = env_cpu(env);
     CPUState *ccs;
-    uint32_t nr_threads = cs->nr_threads;
 
-    if (nr_threads == 1) {
+    if (ppc_cpu_core_single_threaded(cs)) {
         env->spr[sprn] = val;
         return;
     }
@@ -196,7 +195,7 @@ void helper_store_ptcr(CPUPPCState *env, target_ulong val)
             return;
         }
 
-        if (cs->nr_threads == 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
+        if (ppc_cpu_lpar_single_threaded(cs)) {
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
+    if (ppc_cpu_lpar_single_threaded(cs)) {
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
+    if (ppc_cpu_lpar_single_threaded(cs)) {
         ppc_set_irq(cpu, PPC_INTERRUPT_DOORBELL, val & 0x1);
         return;
     }
diff --git a/target/ppc/timebase_helper.c b/target/ppc/timebase_helper.c
index 52f9e6669c..44cacf065e 100644
--- a/target/ppc/timebase_helper.c
+++ b/target/ppc/timebase_helper.c
@@ -63,9 +63,8 @@ void helper_store_purr(CPUPPCState *env, target_ulong val)
 {
     CPUState *cs = env_cpu(env);
     CPUState *ccs;
-    uint32_t nr_threads = cs->nr_threads;
 
-    if (nr_threads == 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
+    if (ppc_cpu_lpar_single_threaded(cs)) {
         cpu_ppc_store_purr(env, val);
         return;
     }
@@ -82,9 +81,8 @@ void helper_store_tbl(CPUPPCState *env, target_ulong val)
 {
     CPUState *cs = env_cpu(env);
     CPUState *ccs;
-    uint32_t nr_threads = cs->nr_threads;
 
-    if (nr_threads == 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
+    if (ppc_cpu_lpar_single_threaded(cs)) {
         cpu_ppc_store_tbl(env, val);
         return;
     }
@@ -99,9 +97,8 @@ void helper_store_tbu(CPUPPCState *env, target_ulong val)
 {
     CPUState *cs = env_cpu(env);
     CPUState *ccs;
-    uint32_t nr_threads = cs->nr_threads;
 
-    if (nr_threads == 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
+    if (ppc_cpu_lpar_single_threaded(cs)) {
         cpu_ppc_store_tbu(env, val);
         return;
     }
@@ -141,9 +138,8 @@ void helper_store_hdecr(CPUPPCState *env, target_ulong val)
 {
     CPUState *cs = env_cpu(env);
     CPUState *ccs;
-    uint32_t nr_threads = cs->nr_threads;
 
-    if (nr_threads == 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
+    if (ppc_cpu_lpar_single_threaded(cs)) {
         cpu_ppc_store_hdecr(env, val);
         return;
     }
@@ -158,9 +154,8 @@ void helper_store_vtb(CPUPPCState *env, target_ulong val)
 {
     CPUState *cs = env_cpu(env);
     CPUState *ccs;
-    uint32_t nr_threads = cs->nr_threads;
 
-    if (nr_threads == 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
+    if (ppc_cpu_lpar_single_threaded(cs)) {
         cpu_ppc_store_vtb(env, val);
         return;
     }
@@ -175,9 +170,8 @@ void helper_store_tbu40(CPUPPCState *env, target_ulong val)
 {
     CPUState *cs = env_cpu(env);
     CPUState *ccs;
-    uint32_t nr_threads = cs->nr_threads;
 
-    if (nr_threads == 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
+    if (ppc_cpu_lpar_single_threaded(cs)) {
         cpu_ppc_store_tbu40(env, val);
         return;
     }
@@ -288,7 +282,7 @@ static void write_tfmr(CPUPPCState *env, target_ulong val)
 {
     CPUState *cs = env_cpu(env);
 
-    if (cs->nr_threads == 1) {
+    if (ppc_cpu_core_single_threaded(cs)) {
         env->spr[SPR_TFMR] = val;
     } else {
         CPUState *ccs;
-- 
2.45.1


