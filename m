Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A43EC25B75
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 12:28:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBCxs-0006Pb-40; Sun, 26 May 2024 08:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sBCxn-0006Na-Pk; Sun, 26 May 2024 08:26:59 -0400
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sBCxl-0001QQ-PT; Sun, 26 May 2024 08:26:59 -0400
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-36db3304053so43676885ab.2; 
 Sun, 26 May 2024 05:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716726416; x=1717331216; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sJs8mNerfby91Jg60eM1BlVbn1gYksWnaaJHBA5aado=;
 b=eqYF71ftc9vmL0WS2SvQNZWJYy2CXb/KVhmcOTLQ78gUq5rerBCUaYzApWRhaxTio1
 vSFoTysRatYZYfvpNwc15xQbhzHxWQy3+a+QqhP8QIzhOqOP9xYHrvB7+Y4XojUSqlYk
 u1GaFthDSdlD6opBKVGuLXxyTDlXSXaFiPPsMui3Gr3SskKtjdxQx0jqVMGD/mDifzmu
 nGFov5kLsRU6SHjdIlroGx7AcEY7Fwio+GzaXlmsou8o/t7EkyP0ehVBz2nRlX7Dd8o/
 RKxUf9q9XIiFuudLep0aPKfiUX2vk6nJuUWnQzSvZ6UXyqNqB11UhtJhHLiQ7fVXBFPj
 6L6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716726416; x=1717331216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sJs8mNerfby91Jg60eM1BlVbn1gYksWnaaJHBA5aado=;
 b=DJ3wnH1Puq/09t9bgL+VgK5+huyFMXUOihmKLxTSbYojrQVhKnPLdT5qYFejeTOSAm
 LiWxefO7T5KR0ACfncHMnNYNepCOxvU0mN+5JYVLUVx9dDAk4fjompCffynJvMIsk1S2
 vxHZVrFtntTctXcMP8quF0m3WR7mT8d9nMMn1toUlwYC0wLkAEIFz+pOdUeM57oXA1f0
 OCpHAgSYzSIzWfwub3RnVzHDpT1lNje7zw0nfx0DJ8xawnzuV+31x6P7A8cOYvbGUBSt
 yoj5qjcwxZkN2llpaU2QwpUTuTX4tKllQVTQrwTG0KAS/QwpO31rcnu/q94OEWLm9TR3
 mGhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBgXaznLjimgHyBeOma3TgMpWTOvYzsKBN78i+WwH6OYRDCQV+FXod132TKrf1HyAyiJlQs0UqsS9YAgHIuq9bNYF6Rlo=
X-Gm-Message-State: AOJu0YwPqa35cpp/fCAogZKW4EL1IfGLf6C20Lbh+pTAKK3bPq61a3Z6
 S2is9VZeL8ecv35b4fHm+2/E/9JcZjkGAMRRh53uKwsIRCMh9DNhxvfeQg==
X-Google-Smtp-Source: AGHT+IG41vKOIlqozmh0U3aCQffMHMxm41VY/Wwlku25LyM0uCAfFDQyVEZ7fPBOChhGtLBy7+boPw==
X-Received: by 2002:a05:6e02:1aa3:b0:36b:2438:8805 with SMTP id
 e9e14a558f8ab-3737b2f77aamr82611255ab.12.1716726415739; 
 Sun, 26 May 2024 05:26:55 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fcfe648bsm3457182b3a.168.2024.05.26.05.26.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 05:26:55 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
Subject: [RFC PATCH 09/10] ppc/pnv: Implement POWER10 PC xscom registers for
 direct controls
Date: Sun, 26 May 2024 22:26:10 +1000
Message-ID: <20240526122612.473476-10-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240526122612.473476-1-npiggin@gmail.com>
References: <20240526122612.473476-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::131;
 envelope-from=npiggin@gmail.com; helo=mail-il1-x131.google.com
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

The PC unit in the processor core contains xscom registers that provide
low level status and control of the CPU.

This implements "direct controls" sufficient for OPAL (skiboot) firmware
use, which is to stop threads and send them non-maskable IPIs in the
form of SRESET interrupts.

POWER10 is sufficiently different (particularly QME and special wakeup)
from POWER9 that it is not trivial to implement by reusing the code.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/core/cpu.h     |  8 ++++
 include/hw/ppc/pnv.h      |  2 +
 include/hw/ppc/pnv_core.h |  3 ++
 hw/ppc/pnv.c              |  7 +++-
 hw/ppc/pnv_core.c         | 88 ++++++++++++++++++++++++++++++++++++---
 system/cpus.c             | 10 +++++
 6 files changed, 112 insertions(+), 6 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index bb398e8237..52a8fc65cb 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -974,6 +974,14 @@ void cpu_reset_interrupt(CPUState *cpu, int mask);
  */
 void cpu_exit(CPUState *cpu);
 
+/**
+ * cpu_pause:
+ * @cpu: The CPU to pause.
+ *
+ * Resumes CPU, i.e. puts CPU into stopped state.
+ */
+void cpu_pause(CPUState *cpu);
+
 /**
  * cpu_resume:
  * @cpu: The CPU to resume.
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 93ecb062b4..bec603f1a8 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -111,6 +111,8 @@ PnvChip *pnv_chip_add_phb(PnvChip *chip, PnvPHB *phb);
 #define PNV_FDT_ADDR          0x01000000
 #define PNV_TIMEBASE_FREQ     512000000ULL
 
+void pnv_cpu_do_nmi(CPUState *cs);
+
 /*
  * BMC helpers
  */
diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
index 39f8f33e6c..9599da15ea 100644
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
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 5364c55bbb..765142965f 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2700,12 +2700,17 @@ static void pnv_cpu_do_nmi_on_cpu(CPUState *cs, run_on_cpu_data arg)
     }
 }
 
+void pnv_cpu_do_nmi(CPUState *cs)
+{
+    async_run_on_cpu(cs, pnv_cpu_do_nmi_on_cpu, RUN_ON_CPU_NULL);
+}
+
 static void pnv_nmi(NMIState *n, int cpu_index, Error **errp)
 {
     CPUState *cs;
 
     CPU_FOREACH(cs) {
-        async_run_on_cpu(cs, pnv_cpu_do_nmi_on_cpu, RUN_ON_CPU_NULL);
+        pnv_cpu_do_nmi(cs);
     }
 }
 
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 10417d92ae..835c35d90b 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -184,16 +184,40 @@ static const MemoryRegionOps pnv_core_power9_xscom_ops = {
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
+                val |= PPC_BIT(0 + 8*i) | PPC_BIT(1 + 8*i);
+            }
+        }
         break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unimp read 0x%08x\n", __func__,
@@ -206,9 +230,45 @@ static uint64_t pnv_core_power10_xscom_read(void *opaque, hwaddr addr,
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
+            if (val & PPC_BIT(7 + 8*i)) { /* stop */
+                val &= ~PPC_BIT(7 + 8*i);
+                cpu_pause(cs);
+            }
+            if (val & PPC_BIT(6 + 8*i)) { /* start */
+                val &= ~PPC_BIT(6 + 8*i);
+                cpu_resume(cs);
+            }
+            if (val & PPC_BIT(4 + 8*i)) { /* sreset */
+                val &= ~PPC_BIT(4 + 8*i);
+                pnv_cpu_do_nmi(cs);
+            }
+            if (val & PPC_BIT(3 + 8*i)) { /* clear maint */
+                /*
+                 * Hardware has very particular cases for where clear maint
+                 * must be used and where start must be used to resume a
+                 * thread. These are not modelled exactly, just treat
+                 * this and start the same.
+                 */
+                val &= ~PPC_BIT(3 + 8*i);
+                cpu_resume(cs);
+            }
+        }
+        if (val) {
+            qemu_log_mask(LOG_UNIMP, "%s: unimp bits in DIRECT_CONTROLS 0x%016lx\n", __func__, val);
+        }
+        break;
+
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unimp write 0x%08x\n", __func__,
                       offset);
@@ -525,6 +585,7 @@ static const MemoryRegionOps pnv_quad_power10_xscom_ops = {
 static uint64_t pnv_qme_power10_xscom_read(void *opaque, hwaddr addr,
                                             unsigned int width)
 {
+    PnvQuad *eq = PNV_QUAD(opaque);
     uint32_t offset = addr >> 3;
     uint64_t val = -1;
 
@@ -532,10 +593,14 @@ static uint64_t pnv_qme_power10_xscom_read(void *opaque, hwaddr addr,
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
@@ -547,9 +612,22 @@ static uint64_t pnv_qme_power10_xscom_read(void *opaque, hwaddr addr,
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
diff --git a/system/cpus.c b/system/cpus.c
index 68d161d96b..1ca18ae7ea 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -602,6 +602,16 @@ void pause_all_vcpus(void)
     bql_lock();
 }
 
+void cpu_pause(CPUState *cpu)
+{
+    if (qemu_cpu_is_self(cpu)) {
+        qemu_cpu_stop(cpu, true);
+    } else {
+        cpu->stop = true;
+        qemu_cpu_kick(cpu);
+    }
+}
+
 void cpu_resume(CPUState *cpu)
 {
     cpu->stop = false;
-- 
2.43.0


