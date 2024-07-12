Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5529AC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 12:43:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSF0A-0005nn-0L; Fri, 12 Jul 2024 08:03:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sSEzZ-00046Q-Tu; Fri, 12 Jul 2024 08:03:19 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sSEzX-0005Y9-2V; Fri, 12 Jul 2024 08:03:13 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-70b4a8a5587so1574051b3a.2; 
 Fri, 12 Jul 2024 05:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720785789; x=1721390589; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JXcN7rc21Iq6Bcn9S0KBwtXpswBbDILgo+A0ACNS488=;
 b=W5O25JqMU1IU+TZ2Khh1Wp1cnNIETLV3WMbPbr7g6aFeCsatAfZ5CuvhwS+olhwKIo
 s/tRtQsCQYYC8nlxf7eHLbTZRCARnxn7Hpu1ex7+KuCRlFdOZLNVdZxxJjWDpvMkahu5
 QhSbsv189GMU7lIUbgpXdkgSMjjA9vi97sENVv4EadyGN5FLT4bPk0zB9Bdr2kkfe6N5
 uve1Ke8bGzqdHRoa7gZ1QBbESYob7liUtCuc08+G0lHgNLWpWB2flcejhGdRDhNU1+IK
 Es6+Lq3u4VncVSRhipJw5/P8MFPWbNHKmoUp6Kfq0hRnmSiQ2HYQ5A+bYpl8sN4e8aaJ
 NTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720785789; x=1721390589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JXcN7rc21Iq6Bcn9S0KBwtXpswBbDILgo+A0ACNS488=;
 b=XQaEmNZVq85jSM7OxiwYycOzqGS2uPpT5enPtrr6ORphPaik0tx9PjzI6AtxpynNOI
 SAtzVW/VQ1uNNE/ahee2jOys4zIgU7qyPyBoJPJy/dpuAfwiH6e8Ez5/NnAXZWyz1PmW
 tRBtLawVbx5LVTThuIsjZuSi35MgmsGau9R1Yx27rY9DR9gNA7vpkPipQYW6UjWIB4+D
 wVH+1gKzmaq1cSXjwL8N7tnWnUlbSCMYDJi7M173fFcmTmRBcoyXhypt1E3RvEc7sT2/
 fE16+KUyAGE3kvh3NdAY3S97JCuKdZ12qOA3VoeDhUxpkm0cBVWLnTmzjbVrPEY4pwdL
 ErTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcxGLUTc6Rr0rqi1oMQRxqXLdMNpsbQcRMsEFunmnFI9CXOc9s71OhRfBVx5BeomjkeLw9oFUnblJmX7iniUedC8KZzII=
X-Gm-Message-State: AOJu0YxYQO4Li57o+ynulR98dtogpdDgotxNPbale0n8KVDs/vmbmhto
 SloAqPH5JpwTNWtj752Tn2Aw3tUkOF/ELu6y0HOsUJsUMD1br/vnI8YK+w==
X-Google-Smtp-Source: AGHT+IGWehJXEtadVuDd7H2un85E7DLRu/dplEyRJUV/v42b5pfOfGdXZOo0Ks6mdDti/2d1boXTow==
X-Received: by 2002:a05:6a20:d493:b0:1bf:13f6:7220 with SMTP id
 adf61e73a8af0-1c2984e1289mr11664591637.56.1720785788821; 
 Fri, 12 Jul 2024 05:03:08 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b438c0a1csm7308967b3a.63.2024.07.12.05.03.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jul 2024 05:03:08 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH v2 03/19] ppc/pnv: Move timebase state into PnvCore
Date: Fri, 12 Jul 2024 22:02:30 +1000
Message-ID: <20240712120247.477133-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240712120247.477133-1-npiggin@gmail.com>
References: <20240712120247.477133-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42d.google.com
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
 include/hw/ppc/pnv_core.h    | 17 ++++++++++++
 target/ppc/cpu.h             | 21 --------------
 hw/ppc/pnv_chiptod.c         |  7 ++---
 target/ppc/timebase_helper.c | 53 ++++++++++++++++++++----------------
 4 files changed, 49 insertions(+), 49 deletions(-)

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
diff --git a/target/ppc/timebase_helper.c b/target/ppc/timebase_helper.c
index 39d397416e..52f9e6669c 100644
--- a/target/ppc/timebase_helper.c
+++ b/target/ppc/timebase_helper.c
@@ -19,6 +19,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "hw/ppc/ppc.h"
+#include "hw/ppc/pnv_core.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
 #include "qemu/log.h"
@@ -298,8 +299,17 @@ static void write_tfmr(CPUPPCState *env, target_ulong val)
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
 
@@ -307,15 +317,15 @@ static void tb_state_machine_step(CPUPPCState *env)
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
 
@@ -332,20 +342,20 @@ static void tb_state_machine_step(CPUPPCState *env)
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
 
@@ -361,6 +371,8 @@ target_ulong helper_load_tfmr(CPUPPCState *env)
 
 void helper_store_tfmr(CPUPPCState *env, target_ulong val)
 {
+    PowerPCCPU *cpu = env_archcpu(env);
+    PnvCoreTODState *tod_state = cpu_get_tbst(cpu);
     uint64_t tfmr = env->spr[SPR_TFMR];
     uint64_t clear_on_write;
     unsigned int tbst = tfmr_get_tb_state(tfmr);
@@ -384,14 +396,7 @@ void helper_store_tfmr(CPUPPCState *env, target_ulong val)
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
@@ -399,7 +404,7 @@ void helper_store_tfmr(CPUPPCState *env, target_ulong val)
                                        "MOVE_CHIP_TOD_TO_TB both set\n");
         tfmr = tfmr_new_tb_state(tfmr, TBST_TB_ERROR);
         tfmr |= TFMR_FIRMWARE_CONTROL_ERROR;
-        env->pnv_tod_tbst.tb_ready_for_tod = 0;
+        tod_state->tb_ready_for_tod = 0;
         goto out;
     }
 
@@ -413,8 +418,8 @@ void helper_store_tfmr(CPUPPCState *env, target_ulong val)
         tfmr &= ~TFMR_LOAD_TOD_MOD;
         tfmr &= ~TFMR_MOVE_CHIP_TOD_TO_TB;
         tfmr &= ~TFMR_FIRMWARE_CONTROL_ERROR; /* XXX: should this be cleared? */
-        env->pnv_tod_tbst.tb_ready_for_tod = 0;
-        env->pnv_tod_tbst.tod_sent_to_tb = 0;
+        tod_state->tb_ready_for_tod = 0;
+        tod_state->tod_sent_to_tb = 0;
         goto out;
     }
 
@@ -427,19 +432,19 @@ void helper_store_tfmr(CPUPPCState *env, target_ulong val)
 
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
2.45.1


