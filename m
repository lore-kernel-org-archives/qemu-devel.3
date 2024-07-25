Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46557C3DA70
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:01:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Jd-0002Tz-2Y; Thu, 25 Jul 2024 19:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8JU-0001cn-0Z; Thu, 25 Jul 2024 19:56:00 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8JS-00011g-0n; Thu, 25 Jul 2024 19:55:59 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2cb4b7fef4aso320669a91.0; 
 Thu, 25 Jul 2024 16:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951756; x=1722556556; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cTyd+lKtpgPwgOkqrwFrFLMEIc8tBrnno+nfiO8IXQY=;
 b=HJ+KmPH9oA4omgWyQCm9kxojE/1WAjbr2IU8dSEJY7JnnPOzP90gOmM7YPEYndlC4L
 uObGZmHDdAgO6KNr9ElEkG4u9C8OGtlGxPMWMvi19Ra9RUmZZG4y3Yn5OQyaPH5fYol4
 WQHd2GjhhP6cBtsF92IQ3rR/ue6jRLaykSkQEonNKqcIckEqC2h9Sam5gOF03bELNHx9
 iPdq5ELYb2K4lnrvsVpQuX0QpUhw/+gys3ZnQoBc2zGgEXU/jxujjeGKriWpL87/ekmA
 o34PJti1O3hXZhIw/gxAxlaWCoE7cJbdKrjb6nTqJ7CeQ45CQq6W+qbJuyYvKGvziRYJ
 NS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951756; x=1722556556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cTyd+lKtpgPwgOkqrwFrFLMEIc8tBrnno+nfiO8IXQY=;
 b=N2THrMSSUxyi8HGIMaw9C4YsQCkkk/DSF4/WTlYOQmPQhE//bJnIe6l+qmfZcPahFh
 uTucnWKQECIxJaZ83Ze4i9XkUcRtDW9HYdr5MMOJSbrb+JXdTpZOMsvIA7NQ/dZGNQjF
 21VpXcd0kPrXi/Ipd5UzDdggXHDuarngUxu8f4MqlXJMWP61azpC5cpatQRjVxZWB85w
 rDwNblevYaZi+q/ptLjEnM7ZZoQE0O+H05ppv0PJFQbcWgfj2PhWWRsGvUxYGKSSOUJ6
 0IvCDKa3aVBRTE1Gi97EaSNrqL9Z5v7ajHEcPoLRczGRWQ0yY9inoldvrbiMjqjS+Asr
 HKiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJCXcEfD3uFCWim3yBE9TSKl/7yFa3V6YU/JwmBCBchAz5oDcEpRafflW42zUMNiZiuZhILPcBHLA02J2maeETUs1r
X-Gm-Message-State: AOJu0Yy71E8V/wEoHKVleKV0PoiZNqRhRjQxkvQNEEXrUBGfuibZkc/I
 qMNhMW3WDcwnnL0KnG07Q/5OxPPYd4ZUS6wAhGSxuYjq50KckE/xEkYSpw==
X-Google-Smtp-Source: AGHT+IFtqo/1uDqI0QFM69yQrpOcbMKcH4vbyg2PdtobV0IhuH7V4egrkpZSJumgpYQfbFwGu4uUjA==
X-Received: by 2002:a17:90a:6c8f:b0:2ca:ffa0:6cee with SMTP id
 98e67ed59e1d1-2cf2eb84487mr3802836a91.31.1721951756113; 
 Thu, 25 Jul 2024 16:55:56 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.55.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:55:55 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 25/96] target/ppc: Add helpers to check for SMT sibling threads
Date: Fri, 26 Jul 2024 09:52:58 +1000
Message-ID: <20240725235410.451624-26-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1029.google.com
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
index 42bb047b54..5ec87c56e4 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6976,7 +6976,7 @@ static void ppc_cpu_realize(DeviceState *dev, Error **errp)
 
     pcc->parent_realize(dev, errp);
 
-    if (env_cpu(env)->nr_threads > 1) {
+    if (!ppc_cpu_core_single_threaded(cs)) {
         env->flags |= POWERPC_FLAG_SMT;
     }
 
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index c0120c8a88..f33fc36db2 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -3005,18 +3005,11 @@ static void msgsnd_core_tir(CPUPPCState *env, uint32_t target_tir, int irq)
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
 
@@ -3071,7 +3064,7 @@ void helper_book3s_msgsnd(CPUPPCState *env, target_ulong rb)
         brdcast = true;
     }
 
-    if (cs->nr_threads == 1 || !brdcast) {
+    if (ppc_cpu_core_single_threaded(cs) || !brdcast) {
         ppc_set_irq(cpu, PPC_INTERRUPT_HDOORBELL, 1);
         return;
     }
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index de7c8813ec..9789d69664 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -48,9 +48,8 @@ void helper_spr_core_write_generic(CPUPPCState *env, uint32_t sprn,
 {
     CPUState *cs = env_cpu(env);
     CPUState *ccs;
-    uint32_t nr_threads = cs->nr_threads;
 
-    if (nr_threads == 1) {
+    if (ppc_cpu_core_single_threaded(cs)) {
         env->spr[sprn] = val;
         return;
     }
@@ -195,7 +194,7 @@ void helper_store_ptcr(CPUPPCState *env, target_ulong val)
             return;
         }
 
-        if (cs->nr_threads == 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
+        if (ppc_cpu_lpar_single_threaded(cs)) {
             env->spr[SPR_PTCR] = val;
             tlb_flush(cs);
         } else {
@@ -242,16 +241,12 @@ target_ulong helper_load_dpdes(CPUPPCState *env)
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
@@ -278,21 +273,11 @@ void helper_store_dpdes(CPUPPCState *env, target_ulong val)
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
index b02535bbd5..d86112d60a 100644
--- a/target/ppc/timebase_helper.c
+++ b/target/ppc/timebase_helper.c
@@ -62,9 +62,8 @@ void helper_store_purr(CPUPPCState *env, target_ulong val)
 {
     CPUState *cs = env_cpu(env);
     CPUState *ccs;
-    uint32_t nr_threads = cs->nr_threads;
 
-    if (nr_threads == 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
+    if (ppc_cpu_lpar_single_threaded(cs)) {
         cpu_ppc_store_purr(env, val);
         return;
     }
@@ -81,9 +80,8 @@ void helper_store_tbl(CPUPPCState *env, target_ulong val)
 {
     CPUState *cs = env_cpu(env);
     CPUState *ccs;
-    uint32_t nr_threads = cs->nr_threads;
 
-    if (nr_threads == 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
+    if (ppc_cpu_lpar_single_threaded(cs)) {
         cpu_ppc_store_tbl(env, val);
         return;
     }
@@ -98,9 +96,8 @@ void helper_store_tbu(CPUPPCState *env, target_ulong val)
 {
     CPUState *cs = env_cpu(env);
     CPUState *ccs;
-    uint32_t nr_threads = cs->nr_threads;
 
-    if (nr_threads == 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
+    if (ppc_cpu_lpar_single_threaded(cs)) {
         cpu_ppc_store_tbu(env, val);
         return;
     }
@@ -140,9 +137,8 @@ void helper_store_hdecr(CPUPPCState *env, target_ulong val)
 {
     CPUState *cs = env_cpu(env);
     CPUState *ccs;
-    uint32_t nr_threads = cs->nr_threads;
 
-    if (nr_threads == 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
+    if (ppc_cpu_lpar_single_threaded(cs)) {
         cpu_ppc_store_hdecr(env, val);
         return;
     }
@@ -157,9 +153,8 @@ void helper_store_vtb(CPUPPCState *env, target_ulong val)
 {
     CPUState *cs = env_cpu(env);
     CPUState *ccs;
-    uint32_t nr_threads = cs->nr_threads;
 
-    if (nr_threads == 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
+    if (ppc_cpu_lpar_single_threaded(cs)) {
         cpu_ppc_store_vtb(env, val);
         return;
     }
@@ -174,9 +169,8 @@ void helper_store_tbu40(CPUPPCState *env, target_ulong val)
 {
     CPUState *cs = env_cpu(env);
     CPUState *ccs;
-    uint32_t nr_threads = cs->nr_threads;
 
-    if (nr_threads == 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
+    if (ppc_cpu_lpar_single_threaded(cs)) {
         cpu_ppc_store_tbu40(env, val);
         return;
     }
@@ -293,7 +287,7 @@ static void write_tfmr(CPUPPCState *env, target_ulong val)
 {
     CPUState *cs = env_cpu(env);
 
-    if (cs->nr_threads == 1) {
+    if (ppc_cpu_core_single_threaded(cs)) {
         env->spr[SPR_TFMR] = val;
     } else {
         CPUState *ccs;
-- 
2.45.2


