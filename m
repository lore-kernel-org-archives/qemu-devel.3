Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69460C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 17:01:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk5UA-0005Ww-0z; Tue, 12 Mar 2024 13:00:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5U0-0005C4-Nk; Tue, 12 Mar 2024 13:00:10 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5Ty-0008FA-0R; Tue, 12 Mar 2024 13:00:08 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6e6aa5c5a6fso139409b3a.0; 
 Tue, 12 Mar 2024 10:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710262804; x=1710867604; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rcMR/66QO66SZZwZGEJJBpBsXptqItMqgKZ6913Z6c0=;
 b=Qmajckl+uWnhNE/bKJHU3PvCX6JdW1oe7n6wtAeltqCeA3osxrTnd7T4iPqlSM+1c0
 Z47fvG1v0M2ENoLrDye0alMBUZb3eP40jS59iIkSoxcXdA2ZTwD9fdxW6FZXgguMik4F
 2tvDHt7oQe+EPKJG02av+tuISPjWccUKv4Rh6NmYu/CyO/VOITZyMz/tc/rdUbBpRB/G
 Srrd2Nxg048sGs/tpOfPzw0WFVrvZQgYT55ZMXcxzz2FBUqWEw9bLQj8OnuVz95eq/WQ
 aj4LSpHzURSGsQHDKQyJgWudXAqE4q/RB19c2JeFJm/RnCG90pWSPzAtNqrar8T1Fbat
 qaYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710262804; x=1710867604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rcMR/66QO66SZZwZGEJJBpBsXptqItMqgKZ6913Z6c0=;
 b=pd/cD9BNCRoFT0JJGRbgYVwi78+DcW9ZhXL8yBr2p2n+WO6iIRziNyyo2BKOwaHFQc
 Ir47XakGXKr3JhLhNDLDlxTcp8DDtjzamNcmmfCAW7+Fjy5YompJ7OuicwChEUNdcwq9
 MMFbf2OmAq/xzxkUQOxl6L864HELJ6napqfA3El2CGNd4tqSgyXeTEFZUgYNLC89L9y6
 N0SDywazF1MN0/AA1vGuyEV37lm/OGhOQwiLd1Ly9caTndHLM42/RPNKpi2VBooKlRmL
 ZMb+tWPv0ptE5IPsUcYpSUVm7anBX0FilLkQ1MZrWRoj90mw2t44JYuBATW12jVUf0SJ
 ex7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJcdlvHfuBN0uXMW88ZLIIY1k7k/Kf2Us8N4jpS3p69R5XZbMVqmUBzkO494hhSP8DPSrDicy3TTSapTS1QtlbXSSc
X-Gm-Message-State: AOJu0YzM4047erazfSjovg5ZOpuVcnUBMjOc3Np0BxgBGFRyzM4Knr4o
 2Y282wX5T4L6cAv6OT0wxNUKaR1CjxZCiKMwle2By/e6yLHYm8p58Cnr7DfwwJA=
X-Google-Smtp-Source: AGHT+IGITJxxJSIevwlUtHc4qrjGU3LE1ZlINtXgTMI7D1uuU3af6iZsfAfjad9Q7RfPTSz4T0neYA==
X-Received: by 2002:a05:6a20:958c:b0:1a3:b42:a22d with SMTP id
 iu12-20020a056a20958c00b001a30b42a22dmr4794246pzb.57.1710262803697; 
 Tue, 12 Mar 2024 10:00:03 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 t34-20020a056a0013a200b006e6a684a6ddsm1362330pfg.220.2024.03.12.10.00.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 10:00:03 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 17/38] ppc/pnv: Improve pervasive topology calculation for
 big-core
Date: Wed, 13 Mar 2024 02:58:28 +1000
Message-ID: <20240312165851.2240242-18-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240312165851.2240242-1-npiggin@gmail.com>
References: <20240312165851.2240242-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42d.google.com
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

From: Caleb Schlossin <calebs@linux.vnet.ibm.com>

Big (SMT8) cores have a complicated function to map the core, thread ID
to pervasive topology (PIR). Fix this for power8, power9, and power10.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Caleb Schlossin <calebs@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv.c              | 71 ++++++++++++++++++++++++++++-----------
 hw/ppc/pnv_core.c         |  8 ++---
 include/hw/ppc/pnv_chip.h |  2 +-
 include/hw/ppc/pnv_core.h |  1 +
 target/ppc/misc_helper.c  |  3 --
 5 files changed, 57 insertions(+), 28 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 8a502dea90..6fad628d9f 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -141,8 +141,10 @@ static int pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
     int smt_threads = CPU_CORE(pc)->nr_threads;
     CPUPPCState *env = &cpu->env;
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cs);
+    PnvChipClass *pnv_cc = PNV_CHIP_GET_CLASS(chip);
     g_autofree uint32_t *servers_prop = g_new(uint32_t, smt_threads);
     int i;
+    uint32_t pir;
     uint32_t segs[] = {cpu_to_be32(28), cpu_to_be32(40),
                        0xffffffff, 0xffffffff};
     uint32_t tbfreq = PNV_TIMEBASE_FREQ;
@@ -153,15 +155,17 @@ static int pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
     char *nodename;
     int cpus_offset = get_cpus_node(fdt);
 
-    nodename = g_strdup_printf("%s@%x", dc->fw_name, pc->pir);
+    pir = pnv_cc->chip_pir(chip, pc->hwid, 0);
+
+    nodename = g_strdup_printf("%s@%x", dc->fw_name, pir);
     offset = fdt_add_subnode(fdt, cpus_offset, nodename);
     _FDT(offset);
     g_free(nodename);
 
     _FDT((fdt_setprop_cell(fdt, offset, "ibm,chip-id", chip->chip_id)));
 
-    _FDT((fdt_setprop_cell(fdt, offset, "reg", pc->pir)));
-    _FDT((fdt_setprop_cell(fdt, offset, "ibm,pir", pc->pir)));
+    _FDT((fdt_setprop_cell(fdt, offset, "reg", pir)));
+    _FDT((fdt_setprop_cell(fdt, offset, "ibm,pir", pir)));
     _FDT((fdt_setprop_string(fdt, offset, "device_type", "cpu")));
 
     _FDT((fdt_setprop_cell(fdt, offset, "cpu-version", env->spr[SPR_PVR])));
@@ -233,7 +237,7 @@ static int pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
 
     /* Build interrupt servers properties */
     for (i = 0; i < smt_threads; i++) {
-        servers_prop[i] = cpu_to_be32(pc->pir + i);
+        servers_prop[i] = cpu_to_be32(pnv_cc->chip_pir(chip, pc->hwid, i));
     }
     _FDT((fdt_setprop(fdt, offset, "ibm,ppc-interrupt-server#s",
                        servers_prop, sizeof(*servers_prop) * smt_threads)));
@@ -241,9 +245,11 @@ static int pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
     return offset;
 }
 
-static void pnv_dt_icp(PnvChip *chip, void *fdt, uint32_t pir,
+static void pnv_dt_icp(PnvChip *chip, void *fdt, uint32_t hwid,
                        uint32_t nr_threads)
 {
+    PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
+    uint32_t pir = pcc->chip_pir(chip, hwid, 0);
     uint64_t addr = PNV_ICP_BASE(chip) | (pir << 12);
     char *name;
     const char compat[] = "IBM,power8-icp\0IBM,ppc-xicp";
@@ -257,6 +263,7 @@ static void pnv_dt_icp(PnvChip *chip, void *fdt, uint32_t pir,
     rsize = sizeof(uint64_t) * 2 * nr_threads;
     reg = g_malloc(rsize);
     for (i = 0; i < nr_threads; i++) {
+        /* We know P8 PIR is linear with thread id */
         reg[i * 2] = cpu_to_be64(addr | ((pir + i) * 0x1000));
         reg[i * 2 + 1] = cpu_to_be64(0x1000);
     }
@@ -324,7 +331,7 @@ static void pnv_chip_power8_dt_populate(PnvChip *chip, void *fdt)
                            pa_features_207, sizeof(pa_features_207))));
 
         /* Interrupt Control Presenters (ICP). One per core. */
-        pnv_dt_icp(chip, fdt, pnv_core->pir, CPU_CORE(pnv_core)->nr_threads);
+        pnv_dt_icp(chip, fdt, pnv_core->hwid, CPU_CORE(pnv_core)->nr_threads);
     }
 
     if (chip->ram_size) {
@@ -1075,9 +1082,10 @@ static void pnv_init(MachineState *machine)
  *   25:28  Core number
  *   29:31  Thread ID
  */
-static uint32_t pnv_chip_core_pir_p8(PnvChip *chip, uint32_t core_id)
+static uint32_t pnv_chip_pir_p8(PnvChip *chip, uint32_t core_id,
+                                uint32_t thread_id)
 {
-    return (chip->chip_id << 7) | (core_id << 3);
+    return (chip->chip_id << 7) | (core_id << 3) | thread_id;
 }
 
 static void pnv_chip_power8_intc_create(PnvChip *chip, PowerPCCPU *cpu,
@@ -1129,14 +1137,37 @@ static void pnv_chip_power8_intc_print_info(PnvChip *chip, PowerPCCPU *cpu,
  *
  * We only care about the lower bits. uint32_t is fine for the moment.
  */
-static uint32_t pnv_chip_core_pir_p9(PnvChip *chip, uint32_t core_id)
+static uint32_t pnv_chip_pir_p9(PnvChip *chip, uint32_t core_id,
+                                uint32_t thread_id)
 {
-    return (chip->chip_id << 8) | (core_id << 2);
+    if (chip->nr_threads == 8) {
+        return (chip->chip_id << 8) | ((thread_id & 1) << 2) | (core_id << 3) |
+               (thread_id >> 1);
+    } else {
+        return (chip->chip_id << 8) | (core_id << 2) | thread_id;
+    }
 }
 
-static uint32_t pnv_chip_core_pir_p10(PnvChip *chip, uint32_t core_id)
+/*
+ *    0:48  Reserved - Read as zeroes
+ *   49:52  Node ID
+ *   53:55  Chip ID
+ *   56     Reserved - Read as zero
+ *   57:59  Quad ID
+ *   60     Core Chiplet Pair ID
+ *   61:63  Thread/Core Chiplet ID t0-t2
+ *
+ * We only care about the lower bits. uint32_t is fine for the moment.
+ */
+static uint32_t pnv_chip_pir_p10(PnvChip *chip, uint32_t core_id,
+                                 uint32_t thread_id)
 {
-    return (chip->chip_id << 8) | (core_id << 2);
+    if (chip->nr_threads == 8) {
+        return (chip->chip_id << 8) | ((core_id / 4) << 4) |
+               ((core_id % 2) << 3) | thread_id;
+    } else {
+        return (chip->chip_id << 8) | (core_id << 2) | thread_id;
+    }
 }
 
 static void pnv_chip_power9_intc_create(PnvChip *chip, PowerPCCPU *cpu,
@@ -1315,7 +1346,7 @@ static void pnv_chip_icp_realize(Pnv8Chip *chip8, Error **errp)
         int core_hwid = CPU_CORE(pnv_core)->core_id;
 
         for (j = 0; j < CPU_CORE(pnv_core)->nr_threads; j++) {
-            uint32_t pir = pcc->core_pir(chip, core_hwid) + j;
+            uint32_t pir = pcc->chip_pir(chip, core_hwid, j);
             PnvICPState *icp = PNV_ICP(xics_icp_get(chip8->xics, pir));
 
             memory_region_add_subregion(&chip8->icp_mmio, pir << 12,
@@ -1428,7 +1459,7 @@ static void pnv_chip_power8e_class_init(ObjectClass *klass, void *data)
     k->chip_cfam_id = 0x221ef04980000000ull;  /* P8 Murano DD2.1 */
     k->cores_mask = POWER8E_CORE_MASK;
     k->num_phbs = 3;
-    k->core_pir = pnv_chip_core_pir_p8;
+    k->chip_pir = pnv_chip_pir_p8;
     k->intc_create = pnv_chip_power8_intc_create;
     k->intc_reset = pnv_chip_power8_intc_reset;
     k->intc_destroy = pnv_chip_power8_intc_destroy;
@@ -1452,7 +1483,7 @@ static void pnv_chip_power8_class_init(ObjectClass *klass, void *data)
     k->chip_cfam_id = 0x220ea04980000000ull; /* P8 Venice DD2.0 */
     k->cores_mask = POWER8_CORE_MASK;
     k->num_phbs = 3;
-    k->core_pir = pnv_chip_core_pir_p8;
+    k->chip_pir = pnv_chip_pir_p8;
     k->intc_create = pnv_chip_power8_intc_create;
     k->intc_reset = pnv_chip_power8_intc_reset;
     k->intc_destroy = pnv_chip_power8_intc_destroy;
@@ -1476,7 +1507,7 @@ static void pnv_chip_power8nvl_class_init(ObjectClass *klass, void *data)
     k->chip_cfam_id = 0x120d304980000000ull;  /* P8 Naples DD1.0 */
     k->cores_mask = POWER8_CORE_MASK;
     k->num_phbs = 4;
-    k->core_pir = pnv_chip_core_pir_p8;
+    k->chip_pir = pnv_chip_pir_p8;
     k->intc_create = pnv_chip_power8_intc_create;
     k->intc_reset = pnv_chip_power8_intc_reset;
     k->intc_destroy = pnv_chip_power8_intc_destroy;
@@ -1749,7 +1780,7 @@ static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
 
     k->chip_cfam_id = 0x220d104900008000ull; /* P9 Nimbus DD2.0 */
     k->cores_mask = POWER9_CORE_MASK;
-    k->core_pir = pnv_chip_core_pir_p9;
+    k->chip_pir = pnv_chip_pir_p9;
     k->intc_create = pnv_chip_power9_intc_create;
     k->intc_reset = pnv_chip_power9_intc_reset;
     k->intc_destroy = pnv_chip_power9_intc_destroy;
@@ -2061,7 +2092,7 @@ static void pnv_chip_power10_class_init(ObjectClass *klass, void *data)
 
     k->chip_cfam_id = 0x120da04900008000ull; /* P10 DD1.0 (with NX) */
     k->cores_mask = POWER10_CORE_MASK;
-    k->core_pir = pnv_chip_core_pir_p10;
+    k->chip_pir = pnv_chip_pir_p10;
     k->intc_create = pnv_chip_power10_intc_create;
     k->intc_reset = pnv_chip_power10_intc_reset;
     k->intc_destroy = pnv_chip_power10_intc_destroy;
@@ -2151,8 +2182,8 @@ static void pnv_chip_core_realize(PnvChip *chip, Error **errp)
                                 chip->nr_threads, &error_fatal);
         object_property_set_int(OBJECT(pnv_core), CPU_CORE_PROP_CORE_ID,
                                 core_hwid, &error_fatal);
-        object_property_set_int(OBJECT(pnv_core), "pir",
-                                pcc->core_pir(chip, core_hwid), &error_fatal);
+        object_property_set_int(OBJECT(pnv_core), "hwid", core_hwid,
+                                &error_fatal);
         object_property_set_int(OBJECT(pnv_core), "hrmor", pnv->fw_load_addr,
                                 &error_fatal);
         object_property_set_link(OBJECT(pnv_core), "chip", OBJECT(chip),
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 8c7afe037f..f40ab721d6 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -226,7 +226,7 @@ static void pnv_core_cpu_realize(PnvCore *pc, PowerPCCPU *cpu, Error **errp,
                                  int thread_index)
 {
     CPUPPCState *env = &cpu->env;
-    int core_pir;
+    int core_hwid;
     ppc_spr_t *pir = &env->spr_cb[SPR_PIR];
     ppc_spr_t *tir = &env->spr_cb[SPR_TIR];
     Error *local_err = NULL;
@@ -242,10 +242,10 @@ static void pnv_core_cpu_realize(PnvCore *pc, PowerPCCPU *cpu, Error **errp,
         return;
     }
 
-    core_pir = object_property_get_uint(OBJECT(pc), "pir", &error_abort);
+    core_hwid = object_property_get_uint(OBJECT(pc), "hwid", &error_abort);
 
     tir->default_value = thread_index;
-    pir->default_value = core_pir + thread_index;
+    pir->default_value = pcc->chip_pir(pc->chip, core_hwid, thread_index);
 
     /* Set time-base frequency to 512 MHz */
     cpu_ppc_tb_init(env, PNV_TIMEBASE_FREQ);
@@ -342,7 +342,7 @@ static void pnv_core_unrealize(DeviceState *dev)
 }
 
 static Property pnv_core_properties[] = {
-    DEFINE_PROP_UINT32("pir", PnvCore, pir, 0),
+    DEFINE_PROP_UINT32("hwid", PnvCore, hwid, 0),
     DEFINE_PROP_UINT64("hrmor", PnvCore, hrmor, 0),
     DEFINE_PROP_LINK("chip", PnvCore, chip, TYPE_PNV_CHIP, PnvChip *),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
index af4cd7a8b8..8589f3291e 100644
--- a/include/hw/ppc/pnv_chip.h
+++ b/include/hw/ppc/pnv_chip.h
@@ -147,7 +147,7 @@ struct PnvChipClass {
 
     DeviceRealize parent_realize;
 
-    uint32_t (*core_pir)(PnvChip *chip, uint32_t core_id);
+    uint32_t (*chip_pir)(PnvChip *chip, uint32_t core_id, uint32_t thread_id);
     void (*intc_create)(PnvChip *chip, PowerPCCPU *cpu, Error **errp);
     void (*intc_reset)(PnvChip *chip, PowerPCCPU *cpu);
     void (*intc_destroy)(PnvChip *chip, PowerPCCPU *cpu);
diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
index 4db21229a6..c6d62fd145 100644
--- a/include/hw/ppc/pnv_core.h
+++ b/include/hw/ppc/pnv_core.h
@@ -36,6 +36,7 @@ struct PnvCore {
     /*< public >*/
     PowerPCCPU **threads;
     uint32_t pir;
+    uint32_t hwid;
     uint64_t hrmor;
     PnvChip *chip;
 
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index a9d41d2802..58e808dc96 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -49,9 +49,6 @@ void helper_spr_core_write_generic(CPUPPCState *env, uint32_t sprn,
     CPUState *cs = env_cpu(env);
     CPUState *ccs;
     uint32_t nr_threads = cs->nr_threads;
-    uint32_t core_id = env->spr[SPR_PIR] & ~(nr_threads - 1);
-
-    assert(core_id == env->spr[SPR_PIR] - env->spr[SPR_TIR]);
 
     if (nr_threads == 1) {
         env->spr[sprn] = val;
-- 
2.42.0


