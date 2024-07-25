Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0383C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 23:57:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Jd-0002X2-6m; Thu, 25 Jul 2024 19:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8JO-00015J-2X; Thu, 25 Jul 2024 19:55:56 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8JM-00010V-05; Thu, 25 Jul 2024 19:55:53 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7a130ae7126so327920a12.0; 
 Thu, 25 Jul 2024 16:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951750; x=1722556550; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iILoxN9jM0AK+K/2E7mEbM6hgTLWrkcq/DNz7AARiDg=;
 b=mmUpFcKQsBJ7yikImvapnhrI2OJVctliPhJlrdOHMgTQKLfwmtS+SpGAPTBAgL28QN
 SXyRRzqtgrrdB81FGcl1QrlQmcVJi0WVo6jCYD0sI0V290J0irbQSH51vfvQi6S49hCq
 BswE5O4iGxNGu0X4k9W2jemLtDEDv0g+eHwSBwXgNLrDjBXgqd2uCNh4/Z728ULjVn0r
 UhIF+y/+QNoiKT77laqy5Ve3ruIhl++7vLbJJGZ4yVM49MbYgMp9sH3jVQRPZJeFzYRR
 L6D/Xuki0EEtGMPuWtKVLwo+eb8MD+xIq38RRFsPLdMZgktyFXxw2+9zkZslD8Pt6JNa
 8zWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951750; x=1722556550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iILoxN9jM0AK+K/2E7mEbM6hgTLWrkcq/DNz7AARiDg=;
 b=Y3ttrZfaTCUafEvpiznb4NZTEnajwdt+rCICKom1r8y0c4BIznAb9QmTttrvnFq8zz
 ctTCSsKsZWLkys3ceVwmjRV8CzR5/UJvcv5K19JlMtgUjXelplTbNGT+GYP2qGAfna5G
 sSqNlFv0iF52hPpMF5OuTLFoHpj5lksBV629XNSfv+pBhIgmnXSLMUfljbzPr0vLIUsi
 /um1AbWnSh7jDwXEbtRX/6oGQ2eg8fLaNLBhFaLpxLS33VIR/rFDpgnMhhq95xJ7Vzwy
 T78WVyJlxcphWNtLdL9XuZTSpYZyICzsO0BTksBLIwgew1JQ/NS9rUm51RrRpgurgUQc
 8OMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrpsS5E+1JzAiV8eroHMl+SZW4Yqs4Qwtz8txXD5VfJkzkYQXIQaHsBJeFDUoTY8X29tbWunXYlLFghN/E406A8pIk
X-Gm-Message-State: AOJu0YwCVz28xygnGdNWLdJihmyEcd53sZTWp+SuvZHY4+tAwGhVLqI3
 K30Y4DqIULkY4WyWzGxl5DX0wmDWkDSU0yWBc/5vrmEF5Np+kztfusBmEQ==
X-Google-Smtp-Source: AGHT+IHs4lDqgd5wWMFZFfe2egypie2WLd3LLXp0xBxZRB0i5ns55FTMg4VH2Gt76WdCDijSxmmF3w==
X-Received: by 2002:a17:90a:5e4e:b0:2c9:1012:b323 with SMTP id
 98e67ed59e1d1-2cf2eb6afb5mr4259678a91.27.1721951749662; 
 Thu, 25 Jul 2024 16:55:49 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.55.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:55:49 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 23/96] ppc/pnv: Extend chip_pir class method to TIR as well
Date: Fri, 26 Jul 2024 09:52:56 +1000
Message-ID: <20240725235410.451624-24-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x534.google.com
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

The chip_pir chip class method allows the platform to set the PIR
processor identification register. Extend this to a more general
ID function which also allows the TIR to be set. This is in
preparation for "big core", which is a more complicated topology
of cores and threads.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv.c              | 85 +++++++++++++++++++++++++--------------
 hw/ppc/pnv_core.c         | 10 +++--
 include/hw/ppc/pnv_chip.h |  4 +-
 3 files changed, 64 insertions(+), 35 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index a84e0e0e30..8827f729b1 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -154,7 +154,7 @@ static int pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
     char *nodename;
     int cpus_offset = get_cpus_node(fdt);
 
-    pir = pnv_cc->chip_pir(chip, pc->hwid, 0);
+    pnv_cc->get_pir_tir(chip, pc->hwid, 0, &pir, NULL);
 
     nodename = g_strdup_printf("%s@%x", dc->fw_name, pir);
     offset = fdt_add_subnode(fdt, cpus_offset, nodename);
@@ -236,7 +236,8 @@ static int pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
 
     /* Build interrupt servers properties */
     for (i = 0; i < smt_threads; i++) {
-        servers_prop[i] = cpu_to_be32(pnv_cc->chip_pir(chip, pc->hwid, i));
+        pnv_cc->get_pir_tir(chip, pc->hwid, i, &pir, NULL);
+        servers_prop[i] = cpu_to_be32(pir);
     }
     _FDT((fdt_setprop(fdt, offset, "ibm,ppc-interrupt-server#s",
                        servers_prop, sizeof(*servers_prop) * smt_threads)));
@@ -248,14 +249,17 @@ static void pnv_dt_icp(PnvChip *chip, void *fdt, uint32_t hwid,
                        uint32_t nr_threads)
 {
     PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
-    uint32_t pir = pcc->chip_pir(chip, hwid, 0);
-    uint64_t addr = PNV_ICP_BASE(chip) | (pir << 12);
+    uint32_t pir;
+    uint64_t addr;
     char *name;
     const char compat[] = "IBM,power8-icp\0IBM,ppc-xicp";
     uint32_t irange[2], i, rsize;
     uint64_t *reg;
     int offset;
 
+    pcc->get_pir_tir(chip, hwid, 0, &pir, NULL);
+    addr = PNV_ICP_BASE(chip) | (pir << 12);
+
     irange[0] = cpu_to_be32(pir);
     irange[1] = cpu_to_be32(nr_threads);
 
@@ -1106,10 +1110,16 @@ static void pnv_init(MachineState *machine)
  *   25:28  Core number
  *   29:31  Thread ID
  */
-static uint32_t pnv_chip_pir_p8(PnvChip *chip, uint32_t core_id,
-                                uint32_t thread_id)
+static void pnv_get_pir_tir_p8(PnvChip *chip,
+                                uint32_t core_id, uint32_t thread_id,
+                                uint32_t *pir, uint32_t *tir)
 {
-    return (chip->chip_id << 7) | (core_id << 3) | thread_id;
+    if (pir) {
+        *pir = (chip->chip_id << 7) | (core_id << 3) | thread_id;
+    }
+    if (tir) {
+        *tir = thread_id;
+    }
 }
 
 static void pnv_chip_power8_intc_create(PnvChip *chip, PowerPCCPU *cpu,
@@ -1161,14 +1171,20 @@ static void pnv_chip_power8_intc_print_info(PnvChip *chip, PowerPCCPU *cpu,
  *
  * We only care about the lower bits. uint32_t is fine for the moment.
  */
-static uint32_t pnv_chip_pir_p9(PnvChip *chip, uint32_t core_id,
-                                uint32_t thread_id)
-{
-    if (chip->nr_threads == 8) {
-        return (chip->chip_id << 8) | ((thread_id & 1) << 2) | (core_id << 3) |
-               (thread_id >> 1);
-    } else {
-        return (chip->chip_id << 8) | (core_id << 2) | thread_id;
+static void pnv_get_pir_tir_p9(PnvChip *chip,
+                                uint32_t core_id, uint32_t thread_id,
+                                uint32_t *pir, uint32_t *tir)
+{
+    if (pir) {
+        if (chip->nr_threads == 8) {
+            *pir = (chip->chip_id << 8) | ((thread_id & 1) << 2) |
+                   (core_id << 3) | (thread_id >> 1);
+        } else {
+            *pir = (chip->chip_id << 8) | (core_id << 2) | thread_id;
+        }
+    }
+    if (tir) {
+        *tir = thread_id;
     }
 }
 
@@ -1183,14 +1199,20 @@ static uint32_t pnv_chip_pir_p9(PnvChip *chip, uint32_t core_id,
  *
  * We only care about the lower bits. uint32_t is fine for the moment.
  */
-static uint32_t pnv_chip_pir_p10(PnvChip *chip, uint32_t core_id,
-                                 uint32_t thread_id)
-{
-    if (chip->nr_threads == 8) {
-        return (chip->chip_id << 8) | ((core_id / 4) << 4) |
-               ((core_id % 2) << 3) | thread_id;
-    } else {
-        return (chip->chip_id << 8) | (core_id << 2) | thread_id;
+static void pnv_get_pir_tir_p10(PnvChip *chip,
+                                uint32_t core_id, uint32_t thread_id,
+                                uint32_t *pir, uint32_t *tir)
+{
+    if (pir) {
+        if (chip->nr_threads == 8) {
+            *pir = (chip->chip_id << 8) | ((core_id / 4) << 4) |
+                    ((core_id % 2) << 3) | thread_id;
+        } else {
+            *pir = (chip->chip_id << 8) | (core_id << 2) | thread_id;
+        }
+    }
+    if (tir) {
+        *tir = thread_id;
     }
 }
 
@@ -1370,8 +1392,11 @@ static void pnv_chip_icp_realize(Pnv8Chip *chip8, Error **errp)
         int core_hwid = CPU_CORE(pnv_core)->core_id;
 
         for (j = 0; j < CPU_CORE(pnv_core)->nr_threads; j++) {
-            uint32_t pir = pcc->chip_pir(chip, core_hwid, j);
-            PnvICPState *icp = PNV_ICP(xics_icp_get(chip8->xics, pir));
+            uint32_t pir;
+            PnvICPState *icp;
+
+            pcc->get_pir_tir(chip, core_hwid, j, &pir, NULL);
+            icp = PNV_ICP(xics_icp_get(chip8->xics, pir));
 
             memory_region_add_subregion(&chip8->icp_mmio, pir << 12,
                                         &icp->mmio);
@@ -1483,7 +1508,7 @@ static void pnv_chip_power8e_class_init(ObjectClass *klass, void *data)
     k->chip_cfam_id = 0x221ef04980000000ull;  /* P8 Murano DD2.1 */
     k->cores_mask = POWER8E_CORE_MASK;
     k->num_phbs = 3;
-    k->chip_pir = pnv_chip_pir_p8;
+    k->get_pir_tir = pnv_get_pir_tir_p8;
     k->intc_create = pnv_chip_power8_intc_create;
     k->intc_reset = pnv_chip_power8_intc_reset;
     k->intc_destroy = pnv_chip_power8_intc_destroy;
@@ -1507,7 +1532,7 @@ static void pnv_chip_power8_class_init(ObjectClass *klass, void *data)
     k->chip_cfam_id = 0x220ea04980000000ull; /* P8 Venice DD2.0 */
     k->cores_mask = POWER8_CORE_MASK;
     k->num_phbs = 3;
-    k->chip_pir = pnv_chip_pir_p8;
+    k->get_pir_tir = pnv_get_pir_tir_p8;
     k->intc_create = pnv_chip_power8_intc_create;
     k->intc_reset = pnv_chip_power8_intc_reset;
     k->intc_destroy = pnv_chip_power8_intc_destroy;
@@ -1531,7 +1556,7 @@ static void pnv_chip_power8nvl_class_init(ObjectClass *klass, void *data)
     k->chip_cfam_id = 0x120d304980000000ull;  /* P8 Naples DD1.0 */
     k->cores_mask = POWER8_CORE_MASK;
     k->num_phbs = 4;
-    k->chip_pir = pnv_chip_pir_p8;
+    k->get_pir_tir = pnv_get_pir_tir_p8;
     k->intc_create = pnv_chip_power8_intc_create;
     k->intc_reset = pnv_chip_power8_intc_reset;
     k->intc_destroy = pnv_chip_power8_intc_destroy;
@@ -1814,7 +1839,7 @@ static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
 
     k->chip_cfam_id = 0x220d104900008000ull; /* P9 Nimbus DD2.0 */
     k->cores_mask = POWER9_CORE_MASK;
-    k->chip_pir = pnv_chip_pir_p9;
+    k->get_pir_tir = pnv_get_pir_tir_p9;
     k->intc_create = pnv_chip_power9_intc_create;
     k->intc_reset = pnv_chip_power9_intc_reset;
     k->intc_destroy = pnv_chip_power9_intc_destroy;
@@ -2136,7 +2161,7 @@ static void pnv_chip_power10_class_init(ObjectClass *klass, void *data)
 
     k->chip_cfam_id = 0x220da04980000000ull; /* P10 DD2.0 (with NX) */
     k->cores_mask = POWER10_CORE_MASK;
-    k->chip_pir = pnv_chip_pir_p10;
+    k->get_pir_tir = pnv_get_pir_tir_p10;
     k->intc_create = pnv_chip_power10_intc_create;
     k->intc_reset = pnv_chip_power10_intc_reset;
     k->intc_destroy = pnv_chip_power10_intc_destroy;
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 2da271ffb6..28ca61926d 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -227,8 +227,9 @@ static void pnv_core_cpu_realize(PnvCore *pc, PowerPCCPU *cpu, Error **errp,
 {
     CPUPPCState *env = &cpu->env;
     int core_hwid;
-    ppc_spr_t *pir = &env->spr_cb[SPR_PIR];
-    ppc_spr_t *tir = &env->spr_cb[SPR_TIR];
+    ppc_spr_t *pir_spr = &env->spr_cb[SPR_PIR];
+    ppc_spr_t *tir_spr = &env->spr_cb[SPR_TIR];
+    uint32_t pir, tir;
     Error *local_err = NULL;
     PnvChipClass *pcc = PNV_CHIP_GET_CLASS(pc->chip);
 
@@ -244,8 +245,9 @@ static void pnv_core_cpu_realize(PnvCore *pc, PowerPCCPU *cpu, Error **errp,
 
     core_hwid = object_property_get_uint(OBJECT(pc), "hwid", &error_abort);
 
-    tir->default_value = thread_index;
-    pir->default_value = pcc->chip_pir(pc->chip, core_hwid, thread_index);
+    pcc->get_pir_tir(pc->chip, core_hwid, thread_index, &pir, &tir);
+    pir_spr->default_value = pir;
+    tir_spr->default_value = tir;
 
     /* Set time-base frequency to 512 MHz */
     cpu_ppc_tb_init(env, PNV_TIMEBASE_FREQ);
diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
index 4eaa7d3999..7d5d08bcdc 100644
--- a/include/hw/ppc/pnv_chip.h
+++ b/include/hw/ppc/pnv_chip.h
@@ -150,7 +150,9 @@ struct PnvChipClass {
 
     DeviceRealize parent_realize;
 
-    uint32_t (*chip_pir)(PnvChip *chip, uint32_t core_id, uint32_t thread_id);
+    /* Get PIR and TIR values for a CPU thread identified by core/thread id */
+    void (*get_pir_tir)(PnvChip *chip, uint32_t core_id, uint32_t thread_id,
+                         uint32_t *pir, uint32_t *tir);
     void (*intc_create)(PnvChip *chip, PowerPCCPU *cpu, Error **errp);
     void (*intc_reset)(PnvChip *chip, PowerPCCPU *cpu);
     void (*intc_destroy)(PnvChip *chip, PowerPCCPU *cpu);
-- 
2.45.2


