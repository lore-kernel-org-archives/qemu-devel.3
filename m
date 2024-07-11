Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A448DC3DA45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 14:22:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRueo-0000rr-Lk; Thu, 11 Jul 2024 10:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sRuek-0000Dv-7C; Thu, 11 Jul 2024 10:20:23 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sRued-0005lV-UO; Thu, 11 Jul 2024 10:20:21 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-70af8128081so779324b3a.1; 
 Thu, 11 Jul 2024 07:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720707609; x=1721312409; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NvM5PCjcgATmFDUmIdzZ0Y+Hp3eStA1GkIR3w102lcM=;
 b=C3nVSqHaNssCktb3BR4T9iz/6B65XCatLT/v4rn+26UHfqaD6BMVlyy3GcJblX80Ku
 0ddsTJLioHvplXg7c1ELutCtB1tlTNQXhn2AoeoN07iBgbFjzbUEe/Gf0RA2pGPlAd8y
 poUEfkrMb+ds40E+KR68+3ej0IbyD+SAY00QlazidJLfE3RqjbSF5xQ8yS3oMg5PaFqy
 ZWLukY+SiEpnjbN8A3IjmHcB2I09GqiIlBRj8BFdPCx0N0fQdQPcDXbLquXhpFWvvc57
 X1Adn9vZzfdU8sqHMqXsi01ZNDZHE4buQSUYf1/pW0b0waPDGyiT5wO2RrtpkyPz0Vui
 vh6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720707609; x=1721312409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NvM5PCjcgATmFDUmIdzZ0Y+Hp3eStA1GkIR3w102lcM=;
 b=hk07JcFlVSTl7cta0eZUrgc2wzKmUFOQl124vKKx6SmhQxcdN8K9MleMi/LP0ltIR9
 1f2Q02sQPxLQmFzYBD6ueBDZ+J4YFgNTujkNTF9HgDYJZmdpPrqPE22Bpow8fmcGeZ/0
 M54Vxy1Pxdrwk2oL379+HF/XD1zY+B1UKWcFHnbUoNb16aF2FiHQOe67Sd0Fvbb2GLFU
 kh33JEI4OAcV9hVEMRJsyc+0XUF3ADakv1SzXJ4ag9TgKrzaqh9Mm7ay/wijedcfuzwe
 BTAHEc/DBH70KT/UFcosKEldASBpS74OkJIilHnc+BZd7mJlqUH/09/ziwUxVdEDFJkl
 9/8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdhoK6SvGbH+N5nJ5bq06bRuNlFXEPLPA9/GoSX4Fvnio5Om2FttvMAY67djqIPZUcrEjuAlIMpzH8TJCR4mn8LW8dOWU=
X-Gm-Message-State: AOJu0YxQOfBkUYfugmPJCRYV9RvJ4NhIXc5xQgpgJ+uUtSWT4+XlytBw
 GFjmbj4sQb2TKXzN1QHsbKOBnlb/t7hvhueb3oeNWVIs0CVrni18Zg+yPgTm
X-Google-Smtp-Source: AGHT+IEdldM24IEBTKRKSN3sY0sFO+87U4USLJzbltP3QxeKmp/M/l8hEveLq1FndLGYeiZG12ZTnw==
X-Received: by 2002:a05:6a20:729a:b0:1c0:f2a5:c8dc with SMTP id
 adf61e73a8af0-1c2984cfa6bmr9702789637.50.1720707609057; 
 Thu, 11 Jul 2024 07:20:09 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b54ec730fsm3308904b3a.173.2024.07.11.07.20.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 07:20:08 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 18/18] ppc/pnv: Add an LPAR per core machine option
Date: Fri, 12 Jul 2024 00:18:50 +1000
Message-ID: <20240711141851.406677-19-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240711141851.406677-1-npiggin@gmail.com>
References: <20240711141851.406677-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42f.google.com
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
including KVM.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/ppc/pnv.h      |  1 +
 include/hw/ppc/pnv_core.h |  1 +
 hw/ppc/pnv.c              | 29 +++++++++++++++++++++++++++++
 hw/ppc/pnv_core.c         |  8 ++++++++
 target/ppc/cpu_init.c     |  3 ++-
 5 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index b7858d310d..73f0d72f55 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -104,6 +104,7 @@ struct PnvMachineState {
     hwaddr       fw_load_addr;
 
     bool         big_core;
+    bool         lpar_per_core;
 };
 
 PnvChip *pnv_get_chip(PnvMachineState *pnv, uint32_t chip_id);
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
index 71b2b3806c..f9a05fa0ff 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1026,6 +1026,11 @@ static void pnv_init(MachineState *machine)
         exit(1);
     }
 
+    if (!object_property_find(OBJECT(pnv), "lpar-per-core")) {
+        /* POWER8 is always in lpar-per-core mode */
+        pnv->lpar_per_core = true;
+    }
+
     pnv->num_chips =
         machine->smp.max_cpus / (machine->smp.cores * machine->smp.threads);
 
@@ -2589,6 +2594,18 @@ static void pnv_machine_set_big_core(Object *obj, bool value, Error **errp)
     pnv->big_core = value;
 }
 
+static bool pnv_machine_get_1lpar(Object *obj, Error **errp)
+{
+    PnvMachineState *pnv = PNV_MACHINE(obj);
+    return pnv->lpar_per_core;
+}
+
+static void pnv_machine_set_1lpar(Object *obj, bool value, Error **errp)
+{
+    PnvMachineState *pnv = PNV_MACHINE(obj);
+    pnv->lpar_per_core = value;
+}
+
 static bool pnv_machine_get_hb(Object *obj, Error **errp)
 {
     PnvMachineState *pnv = PNV_MACHINE(obj);
@@ -2662,6 +2679,12 @@ static void pnv_machine_power9_class_init(ObjectClass *oc, void *data)
                                    pnv_machine_set_big_core);
     object_class_property_set_description(oc, "big-core",
                               "Use big-core (aka fused-core) mode");
+
+    object_class_property_add_bool(oc, "lpar-per-core",
+                                   pnv_machine_get_1lpar,
+                                   pnv_machine_set_1lpar);
+    object_class_property_set_description(oc, "lpar-per-core",
+                              "Use 1 LPAR per core mode");
 }
 
 static void pnv_machine_p10_common_class_init(ObjectClass *oc, void *data)
@@ -2709,6 +2732,12 @@ static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
                                    pnv_machine_set_big_core);
     object_class_property_set_description(oc, "big-core",
                               "Use big-core (aka fused-core) mode");
+
+    object_class_property_add_bool(oc, "lpar-per-core",
+                                   pnv_machine_get_1lpar,
+                                   pnv_machine_set_1lpar);
+    object_class_property_set_description(oc, "lpar-per-core",
+                              "Use 1 LPAR per core mode");
 }
 
 static void pnv_machine_p10_rainier_class_init(ObjectClass *oc, void *data)
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index a685a5dc1b..5a6fcb6edc 100644
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
@@ -320,6 +323,10 @@ static void pnv_core_cpu_realize(PnvCore *pc, PowerPCCPU *cpu, Error **errp,
         env->core_index = core_hwid;
     }
 
+    if (pc->lpar_per_core) {
+        cpu_ppc_set_1lpar(cpu);
+    }
+
     /* Set time-base frequency to 512 MHz */
     cpu_ppc_tb_init(env, PNV_TIMEBASE_FREQ);
 }
@@ -352,6 +359,7 @@ static void pnv_core_realize(DeviceState *dev, Error **errp)
 
     pc->big_core = pnv->big_core;
     pc->tod_state.big_core_quirk = pmc->quirk_tb_big_core;
+    pc->lpar_per_core = pc->chip->pnv_machine->lpar_per_core;
 
     pc->threads = g_new(PowerPCCPU *, cc->nr_threads);
     for (i = 0; i < cc->nr_threads; i++) {
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 9349001b76..0fc83d5cc2 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6785,7 +6785,8 @@ void cpu_ppc_set_1lpar(PowerPCCPU *cpu)
 
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


