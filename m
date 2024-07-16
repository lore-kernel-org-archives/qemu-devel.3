Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 040E9C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 16:29:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTl2Q-0002pl-Oo; Tue, 16 Jul 2024 12:28:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sTl1v-0008Jm-UK; Tue, 16 Jul 2024 12:27:57 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sTl1f-0006fF-O9; Tue, 16 Jul 2024 12:27:55 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-70af8062039so3931576b3a.0; 
 Tue, 16 Jul 2024 09:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721147256; x=1721752056; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PgE2sde4R6CqNdVv3iM8qfaneuklXpZ8D0G1bOi+23U=;
 b=UrjXHsjIAQKuA4WetFKpeQdL1/tqNEdOpefYa4TEbz7FjNQ2nvZetdzFlvRWcD6g27
 pkMSFx/PPqs0Krr8wfmG9G8vP1IxBcyTtMPaLrKDi7DVAnys7Y4ckNe/vfzuGx1c6ztT
 VvsHFZenbosQK6Mpxy0H0tSBzEQNtNUKuVEO+3p6razYUJ4u3qcv2yGD781oovK6ifAW
 zMY+ht4yWIIjBIhbW6kn3uQz2gKUxT7p9M4tqmqC1MCrobFoVaw9K0hosX1tsRRnig78
 YhZDpVo4KXfopqKy7paLaj5Qi3Oz+oo8bgNlRETqnpc0pqgrCwmkiYqUapWnxuAoxQXa
 H2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721147256; x=1721752056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PgE2sde4R6CqNdVv3iM8qfaneuklXpZ8D0G1bOi+23U=;
 b=DIAnyBhaH+5S5D9Jso9k6WfPUS8aA0OuMn/nmKPlW8jR3HhmTkRF3vFxnWMp9XS6nx
 T1GVJJSj6W7fBxyii0T0yxt8XSvTxDp/j8u310iebcKcMoQFsk1n8w/vLOEPH9hcdY32
 /OjfDIzkKO/0FdthHjiJKS56V08z6SObaL8Dmk5OShrIQHEcrjb0bgo/1cABrONGI9jr
 8W6FvgE1OEP6lLEIX/AxTf+revbqfxQAOdN3v5dXgCwgiDKyhULwwJDMXj2uxxoFQ3SX
 BlF3ZGrS58RZlWevvSWZFXa0U9GkZq1H4IUU4CQ+H9PjVoXbDHWQv7nxSkIyEFpSyEKo
 Smxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSXUUj7ulFpMBVjT+egfopWUOlKLbLDPsiO+vxYTohqg3JW9BzRZNGVmGKsV0dWL6MOw6bfYKimXywav8fHw+JUu1hU9Y=
X-Gm-Message-State: AOJu0YwcCK+Nx1rQqszHkgX6N+PAHkaXVXlhQM3xl+KeR8Qx0HTJmr4J
 MiPFxX+/y5tT9bo/55+sMcuJVJwO5vkdVfnUvBedLZcx8cFClZ6GBA+1cw==
X-Google-Smtp-Source: AGHT+IG2H76ygeVa+TgOBNDxm/aehEmaW3GnLp/sYNSRhgEQfgCATSkX5vVZ3PFSuYBBUx4EZcPjZg==
X-Received: by 2002:a05:6a00:3d52:b0:706:375e:220e with SMTP id
 d2e1a72fcca58-70c1fbd4f2cmr3577352b3a.8.1721147256005; 
 Tue, 16 Jul 2024 09:27:36 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7eca86d6sm6722161b3a.179.2024.07.16.09.27.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 09:27:35 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 19/19] ppc/pnv: Add an LPAR per core machine option
Date: Wed, 17 Jul 2024 02:26:15 +1000
Message-ID: <20240716162617.32161-20-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240716162617.32161-1-npiggin@gmail.com>
References: <20240716162617.32161-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Recent POWER CPUs can operate in "LPAR per core" or "LPAR per thread"
modes. In per-core mode, some SPRs and IPI doorbells are shared between
threads in a core. In per-thread mode, supervisor and user state is
not shared between threads.

OpenPOWER systems after POWER8 use LPAR per thread mode, and it is
required for KVM. Enterprise systems use LPAR per core mode, as they
partition the machine by core.

Implement a lpar-per-core machine option for powernv machines. This
is fixed true for POWER8 machines, and defaults off for P9 and P10.

With this change, powernv8 SMT now works sufficiently to run Linux,
with a single socket. Multi-threaded KVM guests still have problems,
as does multi-socket Linux boot.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/ppc/pnv.h      |  2 ++
 include/hw/ppc/pnv_chip.h |  1 +
 include/hw/ppc/pnv_core.h |  1 +
 hw/ppc/pnv.c              | 38 ++++++++++++++++++++++++++++++++++++++
 hw/ppc/pnv_core.c         |  8 ++++++++
 target/ppc/cpu_init.c     |  3 ++-
 6 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index b7858d310d..fcb6699150 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -77,6 +77,7 @@ struct PnvMachineClass {
     const char *compat;
     int compat_size;
     int max_smt_threads;
+    bool has_lpar_per_thread;
     bool quirk_tb_big_core;
 
     void (*dt_power_mgt)(PnvMachineState *pnv, void *fdt);
@@ -104,6 +105,7 @@ struct PnvMachineState {
     hwaddr       fw_load_addr;
 
     bool         big_core;
+    bool         lpar_per_core;
 };
 
 PnvChip *pnv_get_chip(PnvMachineState *pnv, uint32_t chip_id);
diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
index 69d8273efe..ee1649babc 100644
--- a/include/hw/ppc/pnv_chip.h
+++ b/include/hw/ppc/pnv_chip.h
@@ -28,6 +28,7 @@ struct PnvChip {
     uint64_t     ram_size;
 
     bool         big_core;
+    bool         lpar_per_core;
     uint32_t     nr_cores;
     uint32_t     nr_threads;
     uint64_t     cores_mask;
diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
index 1de79a818e..d8afb4f95f 100644
--- a/include/hw/ppc/pnv_core.h
+++ b/include/hw/ppc/pnv_core.h
@@ -57,6 +57,7 @@ struct PnvCore {
     /*< public >*/
     PowerPCCPU **threads;
     bool big_core;
+    bool lpar_per_core;
     uint32_t pir;
     uint32_t hwid;
     uint64_t hrmor;
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index f7580947ed..8d24fc2a45 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1026,6 +1026,11 @@ static void pnv_init(MachineState *machine)
         exit(1);
     }
 
+    /* Set lpar-per-core mode if lpar-per-thread is not supported */
+    if (!pmc->has_lpar_per_thread) {
+        pnv->lpar_per_core = true;
+    }
+
     pnv->num_chips =
         machine->smp.max_cpus / (machine->smp.cores * machine->smp.threads);
 
@@ -1102,6 +1107,8 @@ static void pnv_init(MachineState *machine)
                                 &error_fatal);
         object_property_set_bool(chip, "big-core", pnv->big_core,
                                 &error_fatal);
+        object_property_set_bool(chip, "lpar-per-core", pnv->lpar_per_core,
+                                &error_fatal);
         /*
          * The POWER8 machine use the XICS interrupt interface.
          * Propagate the XICS fabric to the chip and its controllers.
@@ -2338,6 +2345,8 @@ static void pnv_chip_core_realize(PnvChip *chip, Error **errp)
                                 &error_fatal);
         object_property_set_bool(OBJECT(pnv_core), "quirk-tb-big-core",
                                 pmc->quirk_tb_big_core, &error_fatal);
+        object_property_set_bool(OBJECT(pnv_core), "lpar-per-core",
+                                chip->lpar_per_core, &error_fatal);
         object_property_set_link(OBJECT(pnv_core), "chip", OBJECT(chip),
                                  &error_abort);
 
@@ -2373,6 +2382,7 @@ static Property pnv_chip_properties[] = {
     DEFINE_PROP_UINT64("cores-mask", PnvChip, cores_mask, 0x0),
     DEFINE_PROP_UINT32("nr-threads", PnvChip, nr_threads, 1),
     DEFINE_PROP_BOOL("big-core", PnvChip, big_core, false),
+    DEFINE_PROP_BOOL("lpar-per-core", PnvChip, lpar_per_core, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -2593,6 +2603,18 @@ static void pnv_machine_set_big_core(Object *obj, bool value, Error **errp)
     pnv->big_core = value;
 }
 
+static bool pnv_machine_get_lpar_per_core(Object *obj, Error **errp)
+{
+    PnvMachineState *pnv = PNV_MACHINE(obj);
+    return pnv->lpar_per_core;
+}
+
+static void pnv_machine_set_lpar_per_core(Object *obj, bool value, Error **errp)
+{
+    PnvMachineState *pnv = PNV_MACHINE(obj);
+    pnv->lpar_per_core = value;
+}
+
 static bool pnv_machine_get_hb(Object *obj, Error **errp)
 {
     PnvMachineState *pnv = PNV_MACHINE(obj);
@@ -2632,6 +2654,8 @@ static void pnv_machine_power8_class_init(ObjectClass *oc, void *data)
     pmc->compat = compat;
     pmc->compat_size = sizeof(compat);
     pmc->max_smt_threads = 8;
+    /* POWER8 is always lpar-per-core mode */
+    pmc->has_lpar_per_thread = false;
 
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PNV_PHB);
 }
@@ -2657,6 +2681,7 @@ static void pnv_machine_power9_class_init(ObjectClass *oc, void *data)
     pmc->compat = compat;
     pmc->compat_size = sizeof(compat);
     pmc->max_smt_threads = 4;
+    pmc->has_lpar_per_thread = true;
     pmc->dt_power_mgt = pnv_dt_power_mgt;
 
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PNV_PHB);
@@ -2666,6 +2691,12 @@ static void pnv_machine_power9_class_init(ObjectClass *oc, void *data)
                                    pnv_machine_set_big_core);
     object_class_property_set_description(oc, "big-core",
                               "Use big-core (aka fused-core) mode");
+
+    object_class_property_add_bool(oc, "lpar-per-core",
+                                   pnv_machine_get_lpar_per_core,
+                                   pnv_machine_set_lpar_per_core);
+    object_class_property_set_description(oc, "lpar-per-core",
+                              "Use 1 LPAR per core mode");
 }
 
 static void pnv_machine_p10_common_class_init(ObjectClass *oc, void *data)
@@ -2688,6 +2719,7 @@ static void pnv_machine_p10_common_class_init(ObjectClass *oc, void *data)
     pmc->compat = compat;
     pmc->compat_size = sizeof(compat);
     pmc->max_smt_threads = 4;
+    pmc->has_lpar_per_thread = true;
     pmc->quirk_tb_big_core = true;
     pmc->dt_power_mgt = pnv_dt_power_mgt;
 
@@ -2713,6 +2745,12 @@ static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
                                    pnv_machine_set_big_core);
     object_class_property_set_description(oc, "big-core",
                               "Use big-core (aka fused-core) mode");
+
+    object_class_property_add_bool(oc, "lpar-per-core",
+                                   pnv_machine_get_lpar_per_core,
+                                   pnv_machine_set_lpar_per_core);
+    object_class_property_set_description(oc, "lpar-per-core",
+                              "Use 1 LPAR per core mode");
 }
 
 static void pnv_machine_p10_rainier_class_init(ObjectClass *oc, void *data)
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 8ed1cfe8a2..0384122054 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -208,6 +208,9 @@ static uint64_t pnv_core_power10_xscom_read(void *opaque, hwaddr addr,
                 val |= PPC_BIT(56 + i);
             }
         }
+        if (pc->lpar_per_core) {
+            val |= PPC_BIT(62);
+        }
         break;
     case PNV10_XSCOM_EC_CORE_THREAD_INFO:
         break;
@@ -321,6 +324,10 @@ static void pnv_core_cpu_realize(PnvCore *pc, PowerPCCPU *cpu, Error **errp,
         env->core_index = core_hwid;
     }
 
+    if (pc->lpar_per_core) {
+        cpu_ppc_set_1lpar(cpu);
+    }
+
     /* Set time-base frequency to 512 MHz */
     cpu_ppc_tb_init(env, PNV_TIMEBASE_FREQ);
 }
@@ -427,6 +434,7 @@ static Property pnv_core_properties[] = {
     DEFINE_PROP_BOOL("big-core", PnvCore, big_core, false),
     DEFINE_PROP_BOOL("quirk-tb-big-core", PnvCore, tod_state.big_core_quirk,
                      false),
+    DEFINE_PROP_BOOL("lpar-per-core", PnvCore, lpar_per_core, false),
     DEFINE_PROP_LINK("chip", PnvCore, chip, TYPE_PNV_CHIP, PnvChip *),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 81dd4e1a7a..4ba7f54510 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6803,7 +6803,8 @@ void cpu_ppc_set_1lpar(PowerPCCPU *cpu)
 
     /*
      * pseries SMT means "LPAR per core" mode, e.g., msgsndp is usable
-     * between threads.
+     * between threads. powernv be in either mode, and it mostly affects
+     * supervisor visible registers and instructions.
      */
     if (env->flags & POWERPC_FLAG_SMT) {
         env->flags |= POWERPC_FLAG_SMT_1LPAR;
-- 
2.45.1


