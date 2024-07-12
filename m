Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F8FC41513
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 12:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSF1G-0004QV-9d; Fri, 12 Jul 2024 08:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sSF18-0003Vq-TC; Fri, 12 Jul 2024 08:04:51 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sSF16-0005ud-ME; Fri, 12 Jul 2024 08:04:50 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-70b48dfd6a2so1621319b3a.1; 
 Fri, 12 Jul 2024 05:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720785885; x=1721390685; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SXdn44hAbdq5BulP9IKwZ6DBrTC0S7IcN1mxi7E3K6g=;
 b=AlyhGtOmhgtWNYwj/fvMQO4v0S+JRwTCTmyoyApAxGAE2/FRkDIGuN4HdwwspI1IeX
 6folbOlKHX7BdgFnaJE08OAdkmEKmlBv++XF6qQuTXPdm/uFLczgV7+5iX0ZTU1QE3us
 mNNT+vXyhYGz9SWnfrabcpCVp6KFpYKdNOJ55L8tHM9eLfSb8xf87X2FCpSQHWLXH6tI
 pKNXuwNRAhQZG6c58h6/Uuk/V864R28+aBtShJHMH1R3TsEiSlyt12Vgp5AXeglbdgSZ
 QLq1wDWErpFoV0Ez5YfeXveuHrQJxeYuffNmiWO+cecZ7KaeFn4l4LHJMrjK5+i6cVd6
 KEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720785885; x=1721390685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SXdn44hAbdq5BulP9IKwZ6DBrTC0S7IcN1mxi7E3K6g=;
 b=K4FZ+LXth4zCpd0ybMVbUzKm99rfnLKAwLdBQjiDo78DvR7FksY6FTZ/qz89DFI6Pm
 SmIDSQc3mZcdE0pQbu5P6ym9Yt2BFM1tUzqLpR0VKY7njVuxLGqUGGzDNOBPMb7Zld9S
 R7evdgM7myEfgYXFQAtEOzW+iyXn3c55oUKOiuLUnCB6vXxyFTeBcWyaFpTAyhASTYSy
 n3u200025SDXgJc+isKkeXLa0JEvzzciNnAy2SS3t/Cxc3O/ZsqpjesmAk65a/f80K90
 7tLdx7LaawSuN90j8A9lBoTHXtU9Xjmd8JZNPLTJVYoJ+WJP8NqIbYmW4G7ul4y4bGtH
 8lNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwaxETHT1Za0XyOl44ZO4xvzw+d1CAtsWukr4BTpXZgRk1V+4TAnlnm8YGOuIUqVj7v4sCdsZkIsDyCiD41iVbLjgcb4I=
X-Gm-Message-State: AOJu0Yy/5UhU/FCPOm5WKal0QxzqQL3ItadBA1AaTcC5q5Qrt1ijn4Fv
 lQggrgDB8lUWJMF5v5Z2GPTLz6tfBSgc5nAJWS2oUv1wWLEKOgt7O+CWkg==
X-Google-Smtp-Source: AGHT+IHdnfp8DpkdxhiX1YTZJQ488E3ZtEerYClUb/ad4IYNbUzBpYjEDUy280v+XSkXkQh/23HIMg==
X-Received: by 2002:a05:6a20:918d:b0:1be:c5ab:7388 with SMTP id
 adf61e73a8af0-1c298220a18mr13139010637.25.1720785885280; 
 Fri, 12 Jul 2024 05:04:45 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b438c0a1csm7308967b3a.63.2024.07.12.05.04.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jul 2024 05:04:44 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH v2 19/19] ppc/pnv: Add an LPAR per core machine option
Date: Fri, 12 Jul 2024 22:02:46 +1000
Message-ID: <20240712120247.477133-20-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240712120247.477133-1-npiggin@gmail.com>
References: <20240712120247.477133-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
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
 hw/ppc/pnv.c              | 35 +++++++++++++++++++++++++++++++++++
 hw/ppc/pnv_core.c         |  7 +++++++
 target/ppc/cpu_init.c     |  3 ++-
 6 files changed, 48 insertions(+), 1 deletion(-)

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
index cd96cde6c9..be1a48d2cb 100644
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
 
@@ -2308,6 +2313,7 @@ static void pnv_chip_core_realize(PnvChip *chip, Error **errp)
     }
 
     chip->big_core = pnv->big_core;
+    chip->lpar_per_core = pnv->lpar_per_core;
 
     chip->cores = g_new0(PnvCore *, chip->nr_cores);
 
@@ -2339,6 +2345,7 @@ static void pnv_chip_core_realize(PnvChip *chip, Error **errp)
 
         pnv_core->tod_state.big_core_quirk = pmc->quirk_tb_big_core;
         pnv_core->big_core = chip->big_core;
+        pnv_core->lpar_per_core = chip->lpar_per_core;
 
         qdev_realize(DEVICE(pnv_core), NULL, &error_fatal);
 
@@ -2591,6 +2598,18 @@ static void pnv_machine_set_big_core(Object *obj, bool value, Error **errp)
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
@@ -2630,6 +2649,8 @@ static void pnv_machine_power8_class_init(ObjectClass *oc, void *data)
     pmc->compat = compat;
     pmc->compat_size = sizeof(compat);
     pmc->max_smt_threads = 8;
+    /* POWER8 is always lpar-per-core mode */
+    pmc->has_lpar_per_thread = false;
 
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PNV_PHB);
 }
@@ -2655,6 +2676,7 @@ static void pnv_machine_power9_class_init(ObjectClass *oc, void *data)
     pmc->compat = compat;
     pmc->compat_size = sizeof(compat);
     pmc->max_smt_threads = 4;
+    pmc->has_lpar_per_thread = true;
     pmc->dt_power_mgt = pnv_dt_power_mgt;
 
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PNV_PHB);
@@ -2664,6 +2686,12 @@ static void pnv_machine_power9_class_init(ObjectClass *oc, void *data)
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
@@ -2686,6 +2714,7 @@ static void pnv_machine_p10_common_class_init(ObjectClass *oc, void *data)
     pmc->compat = compat;
     pmc->compat_size = sizeof(compat);
     pmc->max_smt_threads = 4;
+    pmc->has_lpar_per_thread = true;
     pmc->quirk_tb_big_core = true;
     pmc->dt_power_mgt = pnv_dt_power_mgt;
 
@@ -2711,6 +2740,12 @@ static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
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
index b32bdb79ff..d59da16ce4 100644
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


