Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8444AC3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:03:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8JI-0000R9-NM; Thu, 25 Jul 2024 19:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8JE-0008CF-Il; Thu, 25 Jul 2024 19:55:44 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8JC-0000yq-0A; Thu, 25 Jul 2024 19:55:44 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2cb4b6ecb3dso296749a91.3; 
 Thu, 25 Jul 2024 16:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951740; x=1722556540; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k+axtswt3uHvq++TX88XGUFlG9QQghy5se0XFWQkqKY=;
 b=hB0zdy/CYRbp/2iK7xMjkzACwKIs5VieQRiRPxPVOHZ/QIN5esA9Mz5q8Kzbc7JsNI
 +SFfNNnAJov+zFqVvSO4MdTFmH2NSzCn0gFWpPmb5r7NlaUThMV9m227ysJJSQ3CdmMT
 9QVaAkXMI7txvOn+8tUbdcnDZuTdWDc2DN8NzHw4bmFrQS8LRmoIIlYoKsLqm9jo+YuS
 PEAKHd6zvFcBgtJf8vzV8sBb970hNzNEyifyvYZlD+ux64MH5jA0WOwHJCUDM3gLGtY9
 0zwQcET3doNhh/Z/pvF0YYHiqw8qv4y3U6oEHCIjUUQqWEEco33+ntaIPCuNxHX56gVh
 fPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951740; x=1722556540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k+axtswt3uHvq++TX88XGUFlG9QQghy5se0XFWQkqKY=;
 b=pTv7Gmq5lSGRhxjXoBT5aylQBWhIJgiXYn4txhWbLj+nnuyPuFlYmtd1rEr+vs8WD2
 ZH8kd9XgFmgi0CG6UGaeUjS85biGxsT1Wu3Te1TJf5gbrli0zeu1mkpi+hu3ezoEUQrh
 TBts36wyJRwGNxVr9/Mgnk7XgpjI/9ug41jNc4WJCRm/Mrh+2B6e869n0wKxF+MiTEt9
 btnFDeYsoFL4GQyXjhHQcuMZtCzx59wezmBFZcHyY94D/fOjsp3iHFPteIFnKJWmowrM
 qLGl7Gg3SfTwY/UvvL8ih6jAjZXgaNO8WktPrRODJvM2hDUzV7jhtWjPhV+7DKk6Qrvz
 AlFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaGjxnW0k4Ww1lyjKWsQyNbs237PgHYiapIMnwW6eaL87eHbviSaXkRPRPqaIgJ5g7+oOUvni+wvEBvCzJQeMX5WXw
X-Gm-Message-State: AOJu0YzwGoFyDSwNobOYQI6LoGehIoOAfIz6dgMYvScbIW+MRoimHKmp
 /uS6LkBx2i/ArfYFyubdyDrpEOW3i0zBb6DeCDFG+6zLmqw9NFmTzcLIGA==
X-Google-Smtp-Source: AGHT+IGY2A+GBhrHUe+4IXiLpQI0ijv7fjTbbV2cJ34mmZL9kjs1/53Zo8F/EyqULZdInNOY7okSXA==
X-Received: by 2002:a17:90a:a018:b0:2c5:10a6:e989 with SMTP id
 98e67ed59e1d1-2cf239351c6mr5144770a91.35.1721951739872; 
 Thu, 25 Jul 2024 16:55:39 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.55.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:55:39 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 20/96] ppc/pnv: Move timebase state into PnvCore
Date: Fri, 26 Jul 2024 09:52:53 +1000
Message-ID: <20240725235410.451624-21-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1033.google.com
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

The timebase state machine is per per-core state and can be driven
by any thread in the core. It is currently implemented as a hack
where the state is in a CPU structure and only thread 0's state is
accessed by the chiptod, which limits programming the timebase
side of the state machine to thread 0 of a core.

Move the state out into PnvCore and share it among all threads.

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv_chiptod.c         |  7 ++---
 include/hw/ppc/pnv_core.h    | 17 ++++++++++
 target/ppc/cpu.h             | 21 -------------
 target/ppc/timebase_helper.c | 60 +++++++++++++++++++++---------------
 4 files changed, 55 insertions(+), 50 deletions(-)

diff --git a/hw/ppc/pnv_chiptod.c b/hw/ppc/pnv_chiptod.c
index 3831a72101..1e41fe557a 100644
--- a/hw/ppc/pnv_chiptod.c
+++ b/hw/ppc/pnv_chiptod.c
@@ -364,8 +364,7 @@ static void pnv_chiptod_xscom_write(void *opaque, hwaddr addr,
             qemu_log_mask(LOG_GUEST_ERROR, "pnv_chiptod: xscom write reg"
                           " TOD_MOVE_TOD_TO_TB_REG with no slave target\n");
         } else {
-            PowerPCCPU *cpu = chiptod->slave_pc_target->threads[0];
-            CPUPPCState *env = &cpu->env;
+            PnvCore *pc = chiptod->slave_pc_target;
 
             /*
              * Moving TOD to TB will set the TB of all threads in a
@@ -377,8 +376,8 @@ static void pnv_chiptod_xscom_write(void *opaque, hwaddr addr,
              * thread 0.
              */
 
-            if (env->pnv_tod_tbst.tb_ready_for_tod) {
-                env->pnv_tod_tbst.tod_sent_to_tb = 1;
+            if (pc->tod_state.tb_ready_for_tod) {
+                pc->tod_state.tod_sent_to_tb = 1;
             } else {
                 qemu_log_mask(LOG_GUEST_ERROR, "pnv_chiptod: xscom write reg"
                               " TOD_MOVE_TOD_TO_TB_REG with TB not ready to"
diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
index 29cab9dfd9..ffec8516ae 100644
--- a/include/hw/ppc/pnv_core.h
+++ b/include/hw/ppc/pnv_core.h
@@ -25,6 +25,20 @@
 #include "hw/ppc/pnv.h"
 #include "qom/object.h"
 
+/* Per-core ChipTOD / TimeBase state */
+typedef struct PnvCoreTODState {
+    int tb_ready_for_tod; /* core TB ready to receive TOD from chiptod */
+    int tod_sent_to_tb;   /* chiptod sent TOD to the core TB */
+
+    /*
+     * "Timers" for async TBST events are simulated by mfTFAC because TFAC
+     * is polled for such events. These are just used to ensure firmware
+     * performs the polling at least a few times.
+     */
+    int tb_state_timer;
+    int tb_sync_pulse_timer;
+} PnvCoreTODState;
+
 #define TYPE_PNV_CORE "powernv-cpu-core"
 OBJECT_DECLARE_TYPE(PnvCore, PnvCoreClass,
                     PNV_CORE)
@@ -38,6 +52,9 @@ struct PnvCore {
     uint32_t pir;
     uint32_t hwid;
     uint64_t hrmor;
+
+    PnvCoreTODState tod_state;
+
     PnvChip *chip;
 
     MemoryRegion xscom_regs;
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 2015e603d4..c78d6ca91a 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1196,21 +1196,6 @@ DEXCR_ASPECT(SRAPD, 4)
 DEXCR_ASPECT(NPHIE, 5)
 DEXCR_ASPECT(PHIE, 6)
 
-/*****************************************************************************/
-/* PowerNV ChipTOD and TimeBase State Machine */
-struct pnv_tod_tbst {
-    int tb_ready_for_tod; /* core TB ready to receive TOD from chiptod */
-    int tod_sent_to_tb;   /* chiptod sent TOD to the core TB */
-
-    /*
-     * "Timers" for async TBST events are simulated by mfTFAC because TFAC
-     * is polled for such events. These are just used to ensure firmware
-     * performs the polling at least a few times.
-     */
-    int tb_state_timer;
-    int tb_sync_pulse_timer;
-};
-
 /*****************************************************************************/
 /* The whole PowerPC CPU context */
 
@@ -1291,12 +1276,6 @@ struct CPUArchState {
     uint32_t tlb_need_flush; /* Delayed flush needed */
 #define TLB_NEED_LOCAL_FLUSH   0x1
 #define TLB_NEED_GLOBAL_FLUSH  0x2
-
-#if defined(TARGET_PPC64)
-    /* PowerNV chiptod / timebase facility state. */
-    /* Would be nice to put these into PnvCore */
-    struct pnv_tod_tbst pnv_tod_tbst;
-#endif
 #endif
 
     /* Other registers */
diff --git a/target/ppc/timebase_helper.c b/target/ppc/timebase_helper.c
index 39d397416e..b02535bbd5 100644
--- a/target/ppc/timebase_helper.c
+++ b/target/ppc/timebase_helper.c
@@ -217,7 +217,13 @@ void helper_store_booke_tsr(CPUPPCState *env, target_ulong val)
     store_booke_tsr(env, val);
 }
 
-#if defined(TARGET_PPC64)
+#if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
+/*
+ * qemu-user breaks with pnv headers, so they go under ifdefs for now.
+ * A clean up may be to move powernv specific registers and helpers into
+ * target/ppc/pnv_helper.c
+ */
+#include "hw/ppc/pnv_core.h"
 /*
  * POWER processor Timebase Facility
  */
@@ -298,8 +304,17 @@ static void write_tfmr(CPUPPCState *env, target_ulong val)
     }
 }
 
+static PnvCoreTODState *cpu_get_tbst(PowerPCCPU *cpu)
+{
+    PnvCore *pc = pnv_cpu_state(cpu)->pnv_core;
+
+    return &pc->tod_state;
+}
+
 static void tb_state_machine_step(CPUPPCState *env)
 {
+    PowerPCCPU *cpu = env_archcpu(env);
+    PnvCoreTODState *tod_state = cpu_get_tbst(cpu);
     uint64_t tfmr = env->spr[SPR_TFMR];
     unsigned int tbst = tfmr_get_tb_state(tfmr);
 
@@ -307,15 +322,15 @@ static void tb_state_machine_step(CPUPPCState *env)
         return;
     }
 
-    if (env->pnv_tod_tbst.tb_sync_pulse_timer) {
-        env->pnv_tod_tbst.tb_sync_pulse_timer--;
+    if (tod_state->tb_sync_pulse_timer) {
+        tod_state->tb_sync_pulse_timer--;
     } else {
         tfmr |= TFMR_TB_SYNC_OCCURED;
         write_tfmr(env, tfmr);
     }
 
-    if (env->pnv_tod_tbst.tb_state_timer) {
-        env->pnv_tod_tbst.tb_state_timer--;
+    if (tod_state->tb_state_timer) {
+        tod_state->tb_state_timer--;
         return;
     }
 
@@ -332,20 +347,20 @@ static void tb_state_machine_step(CPUPPCState *env)
     } else if (tfmr & TFMR_MOVE_CHIP_TOD_TO_TB) {
         if (tbst == TBST_SYNC_WAIT) {
             tfmr = tfmr_new_tb_state(tfmr, TBST_GET_TOD);
-            env->pnv_tod_tbst.tb_state_timer = 3;
+            tod_state->tb_state_timer = 3;
         } else if (tbst == TBST_GET_TOD) {
-            if (env->pnv_tod_tbst.tod_sent_to_tb) {
+            if (tod_state->tod_sent_to_tb) {
                 tfmr = tfmr_new_tb_state(tfmr, TBST_TB_RUNNING);
                 tfmr &= ~TFMR_MOVE_CHIP_TOD_TO_TB;
-                env->pnv_tod_tbst.tb_ready_for_tod = 0;
-                env->pnv_tod_tbst.tod_sent_to_tb = 0;
+                tod_state->tb_ready_for_tod = 0;
+                tod_state->tod_sent_to_tb = 0;
             }
         } else {
             qemu_log_mask(LOG_GUEST_ERROR, "TFMR error: MOVE_CHIP_TOD_TO_TB "
                           "state machine in invalid state 0x%x\n", tbst);
             tfmr = tfmr_new_tb_state(tfmr, TBST_TB_ERROR);
             tfmr |= TFMR_FIRMWARE_CONTROL_ERROR;
-            env->pnv_tod_tbst.tb_ready_for_tod = 0;
+            tod_state->tb_ready_for_tod = 0;
         }
     }
 
@@ -361,6 +376,8 @@ target_ulong helper_load_tfmr(CPUPPCState *env)
 
 void helper_store_tfmr(CPUPPCState *env, target_ulong val)
 {
+    PowerPCCPU *cpu = env_archcpu(env);
+    PnvCoreTODState *tod_state = cpu_get_tbst(cpu);
     uint64_t tfmr = env->spr[SPR_TFMR];
     uint64_t clear_on_write;
     unsigned int tbst = tfmr_get_tb_state(tfmr);
@@ -384,14 +401,7 @@ void helper_store_tfmr(CPUPPCState *env, target_ulong val)
      * after the second mfspr.
      */
     tfmr &= ~TFMR_TB_SYNC_OCCURED;
-    env->pnv_tod_tbst.tb_sync_pulse_timer = 1;
-
-    if (ppc_cpu_tir(env_archcpu(env)) != 0 &&
-        (val & (TFMR_LOAD_TOD_MOD | TFMR_MOVE_CHIP_TOD_TO_TB))) {
-        qemu_log_mask(LOG_UNIMP, "TFMR timebase state machine can only be "
-                                 "driven by thread 0\n");
-        goto out;
-    }
+    tod_state->tb_sync_pulse_timer = 1;
 
     if (((tfmr | val) & (TFMR_LOAD_TOD_MOD | TFMR_MOVE_CHIP_TOD_TO_TB)) ==
                         (TFMR_LOAD_TOD_MOD | TFMR_MOVE_CHIP_TOD_TO_TB)) {
@@ -399,7 +409,7 @@ void helper_store_tfmr(CPUPPCState *env, target_ulong val)
                                        "MOVE_CHIP_TOD_TO_TB both set\n");
         tfmr = tfmr_new_tb_state(tfmr, TBST_TB_ERROR);
         tfmr |= TFMR_FIRMWARE_CONTROL_ERROR;
-        env->pnv_tod_tbst.tb_ready_for_tod = 0;
+        tod_state->tb_ready_for_tod = 0;
         goto out;
     }
 
@@ -413,8 +423,8 @@ void helper_store_tfmr(CPUPPCState *env, target_ulong val)
         tfmr &= ~TFMR_LOAD_TOD_MOD;
         tfmr &= ~TFMR_MOVE_CHIP_TOD_TO_TB;
         tfmr &= ~TFMR_FIRMWARE_CONTROL_ERROR; /* XXX: should this be cleared? */
-        env->pnv_tod_tbst.tb_ready_for_tod = 0;
-        env->pnv_tod_tbst.tod_sent_to_tb = 0;
+        tod_state->tb_ready_for_tod = 0;
+        tod_state->tod_sent_to_tb = 0;
         goto out;
     }
 
@@ -427,19 +437,19 @@ void helper_store_tfmr(CPUPPCState *env, target_ulong val)
 
     if (tfmr & TFMR_LOAD_TOD_MOD) {
         /* Wait for an arbitrary 3 mfspr until the next state transition. */
-        env->pnv_tod_tbst.tb_state_timer = 3;
+        tod_state->tb_state_timer = 3;
     } else if (tfmr & TFMR_MOVE_CHIP_TOD_TO_TB) {
         if (tbst == TBST_NOT_SET) {
             tfmr = tfmr_new_tb_state(tfmr, TBST_SYNC_WAIT);
-            env->pnv_tod_tbst.tb_ready_for_tod = 1;
-            env->pnv_tod_tbst.tb_state_timer = 3; /* arbitrary */
+            tod_state->tb_ready_for_tod = 1;
+            tod_state->tb_state_timer = 3; /* arbitrary */
         } else {
             qemu_log_mask(LOG_GUEST_ERROR, "TFMR error: MOVE_CHIP_TOD_TO_TB "
                                            "not in TB not set state 0x%x\n",
                                            tbst);
             tfmr = tfmr_new_tb_state(tfmr, TBST_TB_ERROR);
             tfmr |= TFMR_FIRMWARE_CONTROL_ERROR;
-            env->pnv_tod_tbst.tb_ready_for_tod = 0;
+            tod_state->tb_ready_for_tod = 0;
         }
     }
 
-- 
2.45.2


