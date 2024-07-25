Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A00C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:07:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8KA-00074D-8P; Thu, 25 Jul 2024 19:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8K5-0006iF-WB; Thu, 25 Jul 2024 19:56:38 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Ju-00018H-L1; Thu, 25 Jul 2024 19:56:37 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2cb674b48ccso286022a91.2; 
 Thu, 25 Jul 2024 16:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951784; x=1722556584; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TPAo/5UsDUqdv7/0v3ddGXr9oVUdDXufbQUlg/ff5ng=;
 b=LTECS+5HnxuAuLmtlL7HguOtvNERf/rGVpgiD09X58VyxPkAuMLWzA8xg418SN/E/t
 ej3SXmeTSqzJpstYY92GRWuj2dIk6AlW3nvsnm7W2P1QTtPBwoqT9556EcEhklZ+qTyf
 0MDKjE6DCCaWyFF9YLfaU745lJf5hK8m5ehiU6eOd4D5gjb81SI1gkbYvXZUy0Q7TBYj
 zj3f+aJ6z5aeIyQB6hypgYATJZFUcWOeaj3WC0xCXnhPs98QbG1FAxo0lHM0Y58dPtut
 EuY6qx7cxn6LDzI1sQUr00p1SAOCYlR1g/ncpw7befgQTePs8Y0C34M4/uccVEdh8wph
 VXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951784; x=1722556584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TPAo/5UsDUqdv7/0v3ddGXr9oVUdDXufbQUlg/ff5ng=;
 b=PFpt8NA5Bs47jxgmrg2CV5qN0zV+esfi5L1VWRKaQBFM1zAym7yYFa8En2hk/At5eG
 5zHfZEPbwwce9Ci/2lSY21Z90drQzJMoJlI0d7ppHMVxT5PZLBeVGzS/PrLp8YE13Rum
 3DE91yKRA2iytPhvWmfh95+qdNEXKs60gm7/rBoPYrQvDsvgExqdKAiW5QtMW5OBLv4h
 +R55C5ASkUUK0fYaLhLwShapw5rONXw/sQt+7VCblkWRvZY9GTAiGUS/X5WPmGY9teCS
 I1hI6YGfuLLrDj/bySqAlSD5eQtxhluhFkB/Bucr9+cvjM7teyH2tDhZdmoHGv5F1bjT
 mtTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwb7IWi34hcMBkEaFQ1F0Tu7LXY9f/sVxjoRyui+9h+voLil4UI+jfmPyi73mD4VJLDyYBu/tuGFX9aLhz9K8UA2CF
X-Gm-Message-State: AOJu0YwLOCpbV2RQUD+MOcdjmAqfk7pbj0oTfs3N0nit+gBxd/F8EBGy
 B6eI4M5M/uf9yKviv4OSZ1/8HfcuftldAdj4lfwgp2xGkS8UMuFHC4Zjsw==
X-Google-Smtp-Source: AGHT+IFjkEE4uQGFPF59YGFRZOnqGZOI7hdVyPEgGVidRXnoFxjjqQP5utzM8XU5qNP54ibWN1Fx3g==
X-Received: by 2002:a17:90a:4dc4:b0:2c9:6f03:6fd6 with SMTP id
 98e67ed59e1d1-2cf2e9d72a7mr4135551a91.17.1721951783859; 
 Thu, 25 Jul 2024 16:56:23 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.56.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:56:23 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-ppc@nongnu.org
Subject: [PULL 34/96] ppc/pnv: Implement POWER10 PC xscom registers for direct
 controls
Date: Fri, 26 Jul 2024 09:53:07 +1000
Message-ID: <20240725235410.451624-35-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102a.google.com
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

The PC unit in the processor core contains xscom registers that provide
low level status and control of the CPU.

This implements "direct controls", sufficient for skiboot firmware,
which uses it to send NMI IPIs between CPUs.

POWER10 is sufficiently different from POWER9 (particularly with respect
to QME and special wakeup) that it is not trivial to implement POWER9
support by reusing the code.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv_core.c         | 89 ++++++++++++++++++++++++++++++++++++---
 include/hw/ppc/pnv_core.h |  3 ++
 2 files changed, 87 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 1783795b23..4484fe8c6a 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -185,16 +185,40 @@ static const MemoryRegionOps pnv_core_power9_xscom_ops = {
  */
 
 #define PNV10_XSCOM_EC_CORE_THREAD_STATE    0x412
+#define PNV10_XSCOM_EC_CORE_THREAD_INFO     0x413
+#define PNV10_XSCOM_EC_CORE_DIRECT_CONTROLS 0x449
+#define PNV10_XSCOM_EC_CORE_RAS_STATUS      0x454
 
 static uint64_t pnv_core_power10_xscom_read(void *opaque, hwaddr addr,
                                            unsigned int width)
 {
+    PnvCore *pc = PNV_CORE(opaque);
+    int nr_threads = CPU_CORE(pc)->nr_threads;
+    int i;
     uint32_t offset = addr >> 3;
     uint64_t val = 0;
 
     switch (offset) {
     case PNV10_XSCOM_EC_CORE_THREAD_STATE:
-        val = 0;
+        for (i = 0; i < nr_threads; i++) {
+            PowerPCCPU *cpu = pc->threads[i];
+            CPUState *cs = CPU(cpu);
+
+            if (cs->halted) {
+                val |= PPC_BIT(56 + i);
+            }
+        }
+        break;
+    case PNV10_XSCOM_EC_CORE_THREAD_INFO:
+        break;
+    case PNV10_XSCOM_EC_CORE_RAS_STATUS:
+        for (i = 0; i < nr_threads; i++) {
+            PowerPCCPU *cpu = pc->threads[i];
+            CPUState *cs = CPU(cpu);
+            if (cs->stopped) {
+                val |= PPC_BIT(0 + 8 * i) | PPC_BIT(1 + 8 * i);
+            }
+        }
         break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unimp read 0x%08x\n", __func__,
@@ -207,9 +231,46 @@ static uint64_t pnv_core_power10_xscom_read(void *opaque, hwaddr addr,
 static void pnv_core_power10_xscom_write(void *opaque, hwaddr addr,
                                          uint64_t val, unsigned int width)
 {
+    PnvCore *pc = PNV_CORE(opaque);
+    int nr_threads = CPU_CORE(pc)->nr_threads;
+    int i;
     uint32_t offset = addr >> 3;
 
     switch (offset) {
+    case PNV10_XSCOM_EC_CORE_DIRECT_CONTROLS:
+        for (i = 0; i < nr_threads; i++) {
+            PowerPCCPU *cpu = pc->threads[i];
+            CPUState *cs = CPU(cpu);
+
+            if (val & PPC_BIT(7 + 8 * i)) { /* stop */
+                val &= ~PPC_BIT(7 + 8 * i);
+                cpu_pause(cs);
+            }
+            if (val & PPC_BIT(6 + 8 * i)) { /* start */
+                val &= ~PPC_BIT(6 + 8 * i);
+                cpu_resume(cs);
+            }
+            if (val & PPC_BIT(4 + 8 * i)) { /* sreset */
+                val &= ~PPC_BIT(4 + 8 * i);
+                pnv_cpu_do_nmi_resume(cs);
+            }
+            if (val & PPC_BIT(3 + 8 * i)) { /* clear maint */
+                /*
+                 * Hardware has very particular cases for where clear maint
+                 * must be used and where start must be used to resume a
+                 * thread. These are not modelled exactly, just treat
+                 * this and start the same.
+                 */
+                val &= ~PPC_BIT(3 + 8 * i);
+                cpu_resume(cs);
+            }
+        }
+        if (val) {
+            qemu_log_mask(LOG_UNIMP, "%s: unimp bits in DIRECT_CONTROLS "
+                                     "0x%016" PRIx64 "\n", __func__, val);
+        }
+        break;
+
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unimp write 0x%08x\n", __func__,
                       offset);
@@ -526,6 +587,7 @@ static const MemoryRegionOps pnv_quad_power10_xscom_ops = {
 static uint64_t pnv_qme_power10_xscom_read(void *opaque, hwaddr addr,
                                             unsigned int width)
 {
+    PnvQuad *eq = PNV_QUAD(opaque);
     uint32_t offset = addr >> 3;
     uint64_t val = -1;
 
@@ -533,10 +595,14 @@ static uint64_t pnv_qme_power10_xscom_read(void *opaque, hwaddr addr,
      * Forth nibble selects the core within a quad, mask it to process read
      * for any core.
      */
-    switch (offset & ~0xf000) {
-    case P10_QME_SPWU_HYP:
+    switch (offset & ~PPC_BITMASK32(16, 19)) {
     case P10_QME_SSH_HYP:
-        return 0;
+        val = 0;
+        if (eq->special_wakeup_done) {
+            val |= PPC_BIT(1); /* SPWU DONE */
+            val |= PPC_BIT(4); /* SSH SPWU DONE */
+        }
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unimp read 0x%08x\n", __func__,
                       offset);
@@ -548,9 +614,22 @@ static uint64_t pnv_qme_power10_xscom_read(void *opaque, hwaddr addr,
 static void pnv_qme_power10_xscom_write(void *opaque, hwaddr addr,
                                          uint64_t val, unsigned int width)
 {
+    PnvQuad *eq = PNV_QUAD(opaque);
     uint32_t offset = addr >> 3;
+    bool set;
+    int i;
 
-    switch (offset) {
+    switch (offset & ~PPC_BITMASK32(16, 19)) {
+    case P10_QME_SPWU_HYP:
+        set = !!(val & PPC_BIT(0));
+        eq->special_wakeup_done = set;
+        for (i = 0; i < 4; i++) {
+            /* These bits select cores in the quad */
+            if (offset & PPC_BIT32(16 + i)) {
+                eq->special_wakeup[i] = set;
+            }
+        }
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unimp write 0x%08x\n", __func__,
                       offset);
diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
index c8784777a4..1de79a818e 100644
--- a/include/hw/ppc/pnv_core.h
+++ b/include/hw/ppc/pnv_core.h
@@ -109,6 +109,9 @@ OBJECT_DECLARE_TYPE(PnvQuad, PnvQuadClass, PNV_QUAD)
 struct PnvQuad {
     DeviceState parent_obj;
 
+    bool special_wakeup_done;
+    bool special_wakeup[4];
+
     uint32_t quad_id;
     MemoryRegion xscom_regs;
     MemoryRegion xscom_qme_regs;
-- 
2.45.2


