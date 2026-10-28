Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70344606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 03:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RcOAvfdv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLu4a-0007b3-LG; Tue, 27 Oct 2026 23:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1xLu4V-0007aG-6F
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 23:11:27 -0400
Received: from mail-dl2-x04.google.com ([2607:f8b0:4864:38::4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1xLu4P-00031q-6B
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 23:11:24 -0400
Received: by mail-dl2-x04.google.com with SMTP id
 a92af1059eb24-1922a6f0d23so77709c88.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 20:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793157076; x=1793761876; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WU0QDEyOlS0xwFk4RVIpaGryci0JQ1HOBRvPf188a7M=;
 b=RcOAvfdva7Kdtecn9UWakT2C231GXRBAjyL1xzbYj30BDGwhDRtzDYTMDWGjq6g3vA
 n8sHsULyPqbVWAh2w0+VrFMien9G9a4aJeFkmbcjfhILxWrhuvPRGhVTyCgzw9ibbfvZ
 aC4DxkPjyn4LVhwQwRLtHkhaCr3YUs3hsj7O/pOALleDvyJJrZurAafECEHsPtdJ083/
 PiUgFTGfbflRH+qxp/z2+nOzNrjFzcORmuhptB4YqvKKVi5Ws1otD9cLtoKsweKosyR8
 MQiXUMSEFGVqG/S/G/KRsB5O1If2AuqCdNz/17fu2QK4zJgkbeerA6YnDPmR6gx8u5Eh
 9+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793157076; x=1793761876;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WU0QDEyOlS0xwFk4RVIpaGryci0JQ1HOBRvPf188a7M=;
 b=vSsktvow1yYIcsSKNwpLIEbdvBr9+G3pqdlcSrko8SChg6+y7NC6I5u/ymEOMbTXbw
 OT2JBmuD7LodUXGc7JqjZsYOCAb5d5/iI3Ta/0EZe1HJfbsfJ0m0R8V7b0q997cOPHrv
 jyO8aH+SjeXu//wHebQdQAUj0BIIbmuyN0ZArcsYk8qhrfSUvuJKDVdb+fY+NEAYMQ00
 JG7KVDiMLnw97c0tOBO1bh2UhkLCGGnP4V1iWomFCjbl3/+NTnA/kYe3N2xHfiujTAot
 4LcBVBZr5bpcDTG9GERW+AsMmVescFR2LRkJDDYb9VkOZ10RDSfJIOAr96x/2Qo/uQeH
 S2OA==
X-Gm-Message-State: AFq9FYJHBIz9epUICgodqqRB8NNHwt20LwOM3DRzZMSE1e8gy318TaKG
 rK2nHdF+HKdHbfjunDz8zVOt9HM5+AtFZXf7PPqwBdGdmHq52I5Jn/7EAGPMfuxhnaQ=
X-Gm-Gg: AYBFou3f14M0HPun/Ppm4Q1p27M2YsMvBzFxzVKNg51UkLS88jsosL0NyADLu+JOkQu
 h7K7dnPVYnL8wShE6EbdVIAShIZ4ExaFYhQde/72jYLmbWlYwne6+de/3wmDnHliPmv0IywHo8e
 E0Y1x55TQ4l6Ma0fwmSByBMaltDzClHvDB+v5VsywlbfN+BrmfdtjJ0+4b5hxZ9/HFIljHlarSq
 rJAN0nQIRj6h6GGIKQ3czGdOo9dgWx4KClv9k2Bd29aTNjy/uBAus6pDzE7cZzmKuBRUEVJXOU/
 OhimRO+ALsyz7nNMgnO/OVUjqF4kpO5+1/yeM6QidPpps8VMZCOH1HnwlHD/ZbiEr47u89sYBV8
 xFAgoFzKPly5FKGoYXwFiRIQFlXPcr2eyxH2w5aAfTOB1H24zz7EwaWr0MR5Rtc/W8gZ4phxEBZ
 /cVnUcxaXIoJKlE9QjPEqVH5XdoUMlXtHp/s0czVJ3MwHGx4l4DAU4r1NXibay4uUipuy63CvV4
 k/zSuAIVSvYZXB6pq9SAtNbBKJrN18zQlu5evHvuuqgYU2qF2767wJWOmI/r1aYjxsvSDsZ/xXO
 XNBbdF/+rPekx6jdSKtWdqqK95whofoi+pXMj/0GFUaZTKJPIFkx6bF8mw==
X-Received: by 2002:a05:7022:c89:b0:184:329d:eced with SMTP id
 a92af1059eb24-1a6ce4ea23dmr1411268c88.25.1793157075597; 
 Tue, 27 Oct 2026 20:11:15 -0700 (PDT)
Received: from Dell-WorkStation.localdomain ([141.164.58.245])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1a75e5c6d4fsm1727374c88.14.2026.10.27.20.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 20:11:14 -0700 (PDT)
From: Zephyr Li <fritchleybohrer@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com,
 Zephyr Li <fritchleybohrer@gmail.com>
Subject: [PATCH] hw/riscv/iommu-sys: honor MSI vector masks
Date: Wed, 28 Oct 2026 11:10:42 +0800
Message-ID: <20261028031042.1496-1-fritchleybohrer@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:38::4;
 envelope-from=fritchleybohrer@gmail.com; helo=mail-dl2-x04.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The system IOMMU currently sends MSIs without checking the corresponding
vector mask bit in the MSI configuration table.

Honor the mask bit and maintain one pending flag per vector. Notifications
generated while masked are deferred and coalesced. Unmasking a vector
delivers one pending MSI, if any, and reset clears all pending flags.

Do not release deferred MSIs while FCTL.WSI selects wired interrupt mode.
When switching back to MSI mode, release unmasked pending vectors and
retain masked ones until unmask.

Add qtests covering masked and unmasked delivery, vector isolation, MSI
configuration updates, wired interrupt delivery, mode transitions, and
reset.

Fixes: 01c1caa9d1b4 ("hw/riscv/virt.c, riscv-iommu-sys.c: add MSIx support")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4444
Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
---
 hw/riscv/riscv-iommu-sys.c     |  67 ++++-
 hw/riscv/riscv-iommu.c         |  12 +
 hw/riscv/riscv-iommu.h         |   3 +
 tests/qtest/iommu-riscv-test.c | 461 +++++++++++++++++++++++++++++++++
 4 files changed, 541 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/riscv-iommu-sys.c b/hw/riscv/riscv-iommu-sys.c
index 258c171efd..96d2bdff7a 100644
--- a/hw/riscv/riscv-iommu-sys.c
+++ b/hw/riscv/riscv-iommu-sys.c
@@ -52,8 +52,50 @@ struct RISCVIOMMUStateSys {
     MemoryRegion msix_pba_mmio;
     uint8_t *msix_table;
     uint8_t *msix_pba;
+    /* Platform MSI state; the reserved PBA region does not expose it. */
+    bool msi_pending[RISCV_IOMMU_PCI_MSIX_VECTORS];
 };
 
+static void riscv_iommu_sysdev_send_MSI_unmasked(RISCVIOMMUStateSys *s,
+                                                 uint32_t vector);
+
+static bool riscv_iommu_sysdev_msi_masked(RISCVIOMMUStateSys *s,
+                                          uint32_t vector)
+{
+    uint8_t *table_entry;
+
+    g_assert(vector < RISCV_IOMMU_PCI_MSIX_VECTORS);
+    table_entry = s->msix_table + vector * PCI_MSIX_ENTRY_SIZE;
+
+    return pci_get_long(table_entry + PCI_MSIX_ENTRY_VECTOR_CTRL) &
+           PCI_MSIX_ENTRY_CTRL_MASKBIT;
+}
+
+static void riscv_iommu_sysdev_release_pending(RISCVIOMMUStateSys *s,
+                                              uint32_t vector)
+{
+    /* Retain deferred MSI messages until MSI mode is restored. */
+    if (riscv_iommu_reg_get32(&s->iommu, RISCV_IOMMU_REG_FCTL) &
+        RISCV_IOMMU_FCTL_WSI) {
+        return;
+    }
+
+    if (s->msi_pending[vector] &&
+        !riscv_iommu_sysdev_msi_masked(s, vector)) {
+        s->msi_pending[vector] = false;
+        riscv_iommu_sysdev_send_MSI_unmasked(s, vector);
+    }
+}
+
+static void riscv_iommu_sysdev_msi_enabled(RISCVIOMMUState *iommu)
+{
+    RISCVIOMMUStateSys *s = container_of(iommu, RISCVIOMMUStateSys, iommu);
+
+    for (unsigned vector = 0; vector < ARRAY_SIZE(s->msi_pending); vector++) {
+        riscv_iommu_sysdev_release_pending(s, vector);
+    }
+}
+
 static uint64_t msix_table_mmio_read(void *opaque, hwaddr addr,
                                      unsigned size)
 {
@@ -67,9 +109,17 @@ static void msix_table_mmio_write(void *opaque, hwaddr addr,
                                   uint64_t val, unsigned size)
 {
     RISCVIOMMUStateSys *s = opaque;
+    uint32_t vector = addr / PCI_MSIX_ENTRY_SIZE;
+    bool was_masked;
 
     g_assert(addr + size <= RISCV_IOMMU_PCI_MSIX_VECTORS * PCI_MSIX_ENTRY_SIZE);
+
+    was_masked = riscv_iommu_sysdev_msi_masked(s, vector);
     pci_set_long(s->msix_table + addr, val);
+
+    if (was_masked && !riscv_iommu_sysdev_msi_masked(s, vector)) {
+        riscv_iommu_sysdev_release_pending(s, vector);
+    }
 }
 
 static const MemoryRegionOps msix_table_mmio_ops = {
@@ -134,8 +184,8 @@ static void riscv_iommu_sysdev_init_msi(RISCVIOMMUStateSys *s,
                                 &s->msix_pba_mmio);
 }
 
-static void riscv_iommu_sysdev_send_MSI(RISCVIOMMUStateSys *s,
-                                        uint32_t vector)
+static void riscv_iommu_sysdev_send_MSI_unmasked(RISCVIOMMUStateSys *s,
+                                                 uint32_t vector)
 {
     uint8_t *table_entry = s->msix_table + vector * PCI_MSIX_ENTRY_SIZE;
     uint64_t msi_addr = pci_get_quad(table_entry + PCI_MSIX_ENTRY_LOWER_ADDR);
@@ -160,6 +210,17 @@ static void riscv_iommu_sysdev_send_MSI(RISCVIOMMUStateSys *s,
     }
 }
 
+static void riscv_iommu_sysdev_send_MSI(RISCVIOMMUStateSys *s,
+                                        uint32_t vector)
+{
+    if (riscv_iommu_sysdev_msi_masked(s, vector)) {
+        s->msi_pending[vector] = true;
+        return;
+    }
+
+    riscv_iommu_sysdev_send_MSI_unmasked(s, vector);
+}
+
 static void riscv_iommu_sysdev_notify(RISCVIOMMUState *iommu,
                                       unsigned vector)
 {
@@ -194,6 +255,7 @@ static void riscv_iommu_sys_realize(DeviceState *dev, Error **errp)
     }
 
     s->iommu.notify = riscv_iommu_sysdev_notify;
+    s->iommu.msi_enabled = riscv_iommu_sysdev_msi_enabled;
 
     /* 4 IRQs are defined starting from s->base_irq */
     for (int i = 0; i < RISCV_IOMMU_INTR_COUNT; i++) {
@@ -255,6 +317,7 @@ static void riscv_iommu_sys_reset_hold(Object *obj, ResetType type)
     RISCVIOMMUState *iommu = &sys->iommu;
 
     riscv_iommu_reset(iommu);
+    memset(sys->msi_pending, 0, sizeof(sys->msi_pending));
 
     trace_riscv_iommu_sys_reset_hold(type);
 }
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 323a041b4a..23b6f8da86 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2419,6 +2419,7 @@ static MemTxResult riscv_iommu_mmio_write(void *opaque, hwaddr addr,
     RISCVIOMMUState *s = opaque;
     uint32_t regb = addr & ~3;
     uint32_t busy = 0;
+    uint32_t old_fctl = 0;
     uint64_t val = 0;
     bool cy_inh = false;
 
@@ -2434,6 +2435,10 @@ static MemTxResult riscv_iommu_mmio_write(void *opaque, hwaddr addr,
 
     /* Track actionable MMIO write. */
     switch (regb) {
+    case RISCV_IOMMU_REG_FCTL:
+        old_fctl = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_FCTL);
+        break;
+
     case RISCV_IOMMU_REG_DDTP:
     case RISCV_IOMMU_REG_DDTP + 4:
         process_fn = riscv_iommu_process_ddtp;
@@ -2510,6 +2515,13 @@ static MemTxResult riscv_iommu_mmio_write(void *opaque, hwaddr addr,
      */
     riscv_iommu_write_reg_val(s, &s->regs[addr], addr, size, data);
 
+    if (regb == RISCV_IOMMU_REG_FCTL && s->msi_enabled &&
+        (old_fctl & RISCV_IOMMU_FCTL_WSI) &&
+        !(riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_FCTL) &
+          RISCV_IOMMU_FCTL_WSI)) {
+        s->msi_enabled(s);
+    }
+
     /* Busy flag update, MSB 4-byte register. */
     if (busy) {
         uint32_t rw = ldl_le_p(&s->regs[regb]);
diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index 7c470ba084..ea1b53e732 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -61,6 +61,9 @@ struct RISCVIOMMUState {
     /* interrupt notifier */
     void (*notify)(RISCVIOMMUState *iommu, unsigned vector);
 
+    /* Optional platform callback when FCTL switches from WSI to MSI. */
+    void (*msi_enabled)(RISCVIOMMUState *iommu);
+
     /* IOMMU target address space */
     AddressSpace *target_as;
     MemoryRegion *target_mr;
diff --git a/tests/qtest/iommu-riscv-test.c b/tests/qtest/iommu-riscv-test.c
index 2638024891..979a976e4f 100644
--- a/tests/qtest/iommu-riscv-test.c
+++ b/tests/qtest/iommu-riscv-test.c
@@ -19,6 +19,28 @@
 
 #define DMA_LEN           4
 
+#define RISCV_IOMMU_SYS_MSI_TARGET0  (QRIOMMU_SPACE_OFFS + 0x03000000ull)
+#define RISCV_IOMMU_SYS_MSI_TARGET1  (RISCV_IOMMU_SYS_MSI_TARGET0 + 4)
+#define RISCV_IOMMU_SYS_CQ_BASE      \
+    (QRIOMMU_SPACE_OFFS + QRIOMMU_CQ_BASE_ADDR)
+#define RISCV_IOMMU_SYS_MSI_DATA0    0x12345678
+#define RISCV_IOMMU_SYS_MSI_DATA1    0xa5a55a5a
+
+/* RISC-V virt machine PLIC, hart 0 M-mode context. */
+#define RISCV_PLIC_BASE             0x0c000000
+#define RISCV_PLIC_PENDING          (RISCV_PLIC_BASE + 0x1000)
+#define RISCV_PLIC_ENABLE           (RISCV_PLIC_BASE + 0x2000)
+#define RISCV_PLIC_THRESHOLD        (RISCV_PLIC_BASE + 0x200000)
+#define RISCV_PLIC_CLAIM            (RISCV_PLIC_THRESHOLD + 4)
+#define RISCV_IOMMU_SYS_IRQ_BASE    36
+
+#define PCI_TESTDEV_TEST             0
+#define PCI_TESTDEV_WIDTH            1
+#define PCI_TESTDEV_OFFSET           4
+#define PCI_TESTDEV_DATA             8
+#define PCI_TESTDEV_COUNT            12
+#define PCI_TESTDEV_NO_EVENTFD       0
+
 /* RISC-V virt machine PCI configuration */
 #define RISCV_GPEX_PIO_BASE        0x3000000
 #define RISCV_BUS_PIO_LIMIT        0x10000
@@ -264,6 +286,425 @@ static void test_riscv_iommu_nested(void)
     run_riscv_iommu_translation(&cfg);
 }
 
+static void riscv_iommu_sys_set_wsi(QTestState *qts, bool wsi)
+{
+    uint64_t base = VIRT_RISCV_IOMMU_BASE;
+    uint32_t fctl;
+
+    /* Feature changes require Off mode and all in-memory queues disabled. */
+    g_assert_cmphex(qtest_readq(qts, base + RISCV_IOMMU_REG_DDTP) &
+                    (RISCV_IOMMU_DDTP_MODE | RISCV_IOMMU_DDTP_BUSY),
+                    ==, RISCV_IOMMU_DDTP_MODE_OFF);
+    g_assert_cmphex(qtest_readl(qts, base + RISCV_IOMMU_REG_CQCSR) &
+                    (RISCV_IOMMU_CQCSR_CQEN | RISCV_IOMMU_CQCSR_CQON |
+                     RISCV_IOMMU_CQCSR_BUSY), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, base + RISCV_IOMMU_REG_FQCSR) &
+                    (RISCV_IOMMU_FQCSR_FQEN | RISCV_IOMMU_FQCSR_FQON |
+                     RISCV_IOMMU_FQCSR_BUSY), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, base + RISCV_IOMMU_REG_PQCSR) &
+                    (RISCV_IOMMU_PQCSR_PQEN | RISCV_IOMMU_PQCSR_PQON |
+                     RISCV_IOMMU_PQCSR_BUSY), ==, 0);
+
+    fctl = qtest_readl(qts, base + RISCV_IOMMU_REG_FCTL);
+    fctl = (fctl & ~RISCV_IOMMU_FCTL_WSI) |
+           (wsi ? RISCV_IOMMU_FCTL_WSI : 0);
+    qtest_writel(qts, base + RISCV_IOMMU_REG_FCTL, fctl);
+    g_assert_cmphex(qtest_readl(qts, base + RISCV_IOMMU_REG_FCTL) &
+                    RISCV_IOMMU_FCTL_WSI, ==, fctl & RISCV_IOMMU_FCTL_WSI);
+}
+
+static QTestState *riscv_iommu_sys_test_init(const char *extra_args)
+{
+    QTestState *qts;
+    uint64_t cap;
+    uint32_t igs;
+
+    if (!qtest_has_machine("virt")) {
+        g_test_skip("virt machine not available");
+        return NULL;
+    }
+
+    qts = qtest_initf("-machine virt,aia=none,acpi=off,iommu-sys=on "
+                      "-cpu max -smp 1 -m 512 -net none -nodefaults %s",
+                      extra_args ? extra_args : "");
+
+    cap = qtest_readq(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CAP);
+    igs = (cap & RISCV_IOMMU_CAP_IGS) >> 28;
+    g_assert_cmpuint(igs, <=, RISCV_IOMMU_CAP_IGS_BOTH);
+    g_assert_cmpuint(igs, !=, RISCV_IOMMU_CAP_IGS_WSI);
+
+    riscv_iommu_sys_set_wsi(qts, false);
+
+    return qts;
+}
+
+static QPCIDevice *riscv_iommu_sys_init_msi_sink(QTestState *qts,
+                                                  QGenericPCIBus *gbus,
+                                                  QPCIBar *bar,
+                                                  uint64_t *target,
+                                                  uint32_t *data)
+{
+    QPCIDevice *dev = NULL;
+    uint32_t offset;
+
+    qpci_init_generic(gbus, qts, NULL, false);
+    riscv_config_qpci_bus(gbus);
+    qpci_device_foreach(&gbus->bus, PCI_VENDOR_ID_REDHAT,
+                        PCI_DEVICE_ID_REDHAT_TEST, save_fn, &dev);
+    g_assert(dev);
+
+    qpci_device_enable(dev);
+    *bar = qpci_iomap(dev, 0, NULL);
+    g_assert_false(bar->is_io);
+
+    qpci_io_writeb(dev, *bar, PCI_TESTDEV_TEST, PCI_TESTDEV_NO_EVENTFD);
+    g_assert_cmpuint(qpci_io_readb(dev, *bar, PCI_TESTDEV_WIDTH), ==, 1);
+    offset = qpci_io_readl(dev, *bar, PCI_TESTDEV_OFFSET);
+    *data = qpci_io_readl(dev, *bar, PCI_TESTDEV_DATA);
+    *target = bar->addr + offset;
+    g_assert_cmpuint(qpci_io_readl(dev, *bar, PCI_TESTDEV_COUNT), ==, 0);
+
+    return dev;
+}
+
+static void riscv_iommu_sys_program_msi(QTestState *qts, unsigned vector,
+                                        uint64_t target, uint32_t data,
+                                        bool masked)
+{
+    uint64_t entry = VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_MSI_CONFIG +
+                     vector * PCI_MSIX_ENTRY_SIZE;
+
+    qtest_writeq(qts, entry + PCI_MSIX_ENTRY_LOWER_ADDR, target);
+    qtest_writel(qts, entry + PCI_MSIX_ENTRY_DATA, data);
+    qtest_writel(qts, entry + PCI_MSIX_ENTRY_VECTOR_CTRL,
+                 masked ? PCI_MSIX_ENTRY_CTRL_MASKBIT : 0);
+}
+
+static void riscv_iommu_sys_set_mask(QTestState *qts, unsigned vector,
+                                     bool masked)
+{
+    uint64_t entry = VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_MSI_CONFIG +
+                     vector * PCI_MSIX_ENTRY_SIZE;
+
+    qtest_writel(qts, entry + PCI_MSIX_ENTRY_VECTOR_CTRL,
+                 masked ? PCI_MSIX_ENTRY_CTRL_MASKBIT : 0);
+}
+
+static void riscv_iommu_sys_setup_cq(QTestState *qts)
+{
+    uint64_t cqb = (RISCV_IOMMU_SYS_CQ_BASE >> 12) << 10;
+    uint32_t cqcsr;
+
+    qtest_writeq(qts, RISCV_IOMMU_SYS_CQ_BASE, UINT64_MAX);
+    qtest_writeq(qts, RISCV_IOMMU_SYS_CQ_BASE + 8, 0);
+    qtest_writeq(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CQB, cqb);
+    qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CQT, 0);
+    qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CQCSR,
+                 RISCV_IOMMU_CQCSR_CQEN | RISCV_IOMMU_CQCSR_CIE);
+
+    cqcsr = qtest_readl(qts,
+                        VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CQCSR);
+    g_assert_cmphex(cqcsr & RISCV_IOMMU_CQCSR_CQON,
+                    ==, RISCV_IOMMU_CQCSR_CQON);
+}
+
+static void riscv_iommu_sys_trigger_cq_irq(QTestState *qts)
+{
+    uint32_t cqcsr;
+
+    qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CQT, 1);
+    cqcsr = qtest_readl(qts,
+                        VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CQCSR);
+    g_assert_cmphex(cqcsr & RISCV_IOMMU_CQCSR_CMD_ILL,
+                    ==, RISCV_IOMMU_CQCSR_CMD_ILL);
+}
+
+static void riscv_iommu_sys_rearm_cq_irq(QTestState *qts)
+{
+    uint32_t cqcsr;
+
+    qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CQT, 0);
+    qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CQCSR,
+                 RISCV_IOMMU_CQCSR_CQEN | RISCV_IOMMU_CQCSR_CIE |
+                 RISCV_IOMMU_CQCSR_CMD_ILL);
+    cqcsr = qtest_readl(qts,
+                        VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CQCSR);
+    g_assert_cmphex(cqcsr & RISCV_IOMMU_CQCSR_CMD_ILL, ==, 0);
+
+    qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_IPSR,
+                 RISCV_IOMMU_IPSR_CIP);
+    g_assert_cmphex(qtest_readl(qts, VIRT_RISCV_IOMMU_BASE +
+                               RISCV_IOMMU_REG_IPSR) & RISCV_IOMMU_IPSR_CIP,
+                    ==, 0);
+}
+
+static void test_riscv_iommu_sys_msi_unmasked(void)
+{
+    QTestState *qts = riscv_iommu_sys_test_init(NULL);
+
+    if (!qts) {
+        return;
+    }
+
+    qtest_writel(qts, RISCV_IOMMU_SYS_MSI_TARGET0, 0);
+    riscv_iommu_sys_program_msi(qts, 0, RISCV_IOMMU_SYS_MSI_TARGET0,
+                                RISCV_IOMMU_SYS_MSI_DATA0, false);
+    riscv_iommu_sys_setup_cq(qts);
+    riscv_iommu_sys_trigger_cq_irq(qts);
+
+    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET0),
+                    ==, RISCV_IOMMU_SYS_MSI_DATA0);
+    qtest_quit(qts);
+}
+
+static void test_riscv_iommu_sys_msi_masked(void)
+{
+    QGenericPCIBus gbus;
+    QPCIBar sink_bar;
+    QPCIDevice *sink;
+    QTestState *qts = riscv_iommu_sys_test_init("-device pci-testdev");
+    uint64_t sink_target;
+    uint32_t sink_data;
+
+    if (!qts) {
+        return;
+    }
+
+    sink = riscv_iommu_sys_init_msi_sink(qts, &gbus, &sink_bar,
+                                         &sink_target, &sink_data);
+    riscv_iommu_sys_program_msi(qts, 0, sink_target, sink_data, true);
+    riscv_iommu_sys_setup_cq(qts);
+
+    riscv_iommu_sys_trigger_cq_irq(qts);
+    g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TESTDEV_COUNT), ==, 0);
+
+    riscv_iommu_sys_rearm_cq_irq(qts);
+    riscv_iommu_sys_trigger_cq_irq(qts);
+    g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TESTDEV_COUNT), ==, 0);
+
+    riscv_iommu_sys_set_mask(qts, 0, false);
+    g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TESTDEV_COUNT), ==, 1);
+
+    riscv_iommu_sys_set_mask(qts, 0, false);
+    g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TESTDEV_COUNT), ==, 1);
+    g_free(sink);
+    qtest_quit(qts);
+}
+
+static void test_riscv_iommu_sys_msi_config_update(void)
+{
+    QTestState *qts = riscv_iommu_sys_test_init(NULL);
+
+    if (!qts) {
+        return;
+    }
+
+    qtest_writel(qts, RISCV_IOMMU_SYS_MSI_TARGET0, 0);
+    qtest_writel(qts, RISCV_IOMMU_SYS_MSI_TARGET1, 0);
+    riscv_iommu_sys_program_msi(qts, 0, RISCV_IOMMU_SYS_MSI_TARGET0,
+                                RISCV_IOMMU_SYS_MSI_DATA0, true);
+    riscv_iommu_sys_setup_cq(qts);
+    riscv_iommu_sys_trigger_cq_irq(qts);
+
+    /* Updating a masked entry must not release the deferred message. */
+    riscv_iommu_sys_program_msi(qts, 0, RISCV_IOMMU_SYS_MSI_TARGET1,
+                                RISCV_IOMMU_SYS_MSI_DATA1, true);
+    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET0), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET1), ==, 0);
+
+    /* Release uses the current address and data, rather than a snapshot. */
+    riscv_iommu_sys_set_mask(qts, 0, false);
+    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET0), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET1),
+                    ==, RISCV_IOMMU_SYS_MSI_DATA1);
+    qtest_writel(qts, RISCV_IOMMU_SYS_MSI_TARGET1, 0);
+    riscv_iommu_sys_set_mask(qts, 0, false);
+    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET1), ==, 0);
+    qtest_quit(qts);
+}
+
+static void test_riscv_iommu_sys_msi_vector_isolation(void)
+{
+    QTestState *qts = riscv_iommu_sys_test_init(NULL);
+
+    if (!qts) {
+        return;
+    }
+
+    qtest_writel(qts, RISCV_IOMMU_SYS_MSI_TARGET0, 0);
+    qtest_writel(qts, RISCV_IOMMU_SYS_MSI_TARGET1, 0);
+    riscv_iommu_sys_program_msi(qts, 0, RISCV_IOMMU_SYS_MSI_TARGET0,
+                                RISCV_IOMMU_SYS_MSI_DATA0, true);
+    riscv_iommu_sys_program_msi(qts, 1, RISCV_IOMMU_SYS_MSI_TARGET1,
+                                RISCV_IOMMU_SYS_MSI_DATA1, false);
+    riscv_iommu_sys_setup_cq(qts);
+
+    riscv_iommu_sys_trigger_cq_irq(qts);
+    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET0), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET1), ==, 0);
+
+    riscv_iommu_sys_rearm_cq_irq(qts);
+    qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_ICVEC, 1);
+    riscv_iommu_sys_trigger_cq_irq(qts);
+    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET0), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET1),
+                    ==, RISCV_IOMMU_SYS_MSI_DATA1);
+
+    riscv_iommu_sys_set_mask(qts, 0, false);
+    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET0),
+                    ==, RISCV_IOMMU_SYS_MSI_DATA0);
+    qtest_quit(qts);
+}
+
+static void test_riscv_iommu_sys_msi_wsi_switch(const void *opaque)
+{
+    bool unmask_in_wsi = GPOINTER_TO_INT(opaque);
+    QGenericPCIBus gbus;
+    QPCIBar sink_bar;
+    QPCIDevice *sink;
+    QTestState *qts = riscv_iommu_sys_test_init("-device pci-testdev");
+    uint64_t sink_target;
+    uint32_t sink_data;
+
+    if (!qts) {
+        return;
+    }
+
+    g_assert_cmpuint((qtest_readq(qts, VIRT_RISCV_IOMMU_BASE +
+                                 RISCV_IOMMU_REG_CAP) &
+                      RISCV_IOMMU_CAP_IGS) >> 28,
+                     ==, RISCV_IOMMU_CAP_IGS_BOTH);
+    sink = riscv_iommu_sys_init_msi_sink(qts, &gbus, &sink_bar,
+                                         &sink_target, &sink_data);
+    riscv_iommu_sys_program_msi(qts, 0, sink_target, sink_data, true);
+    riscv_iommu_sys_setup_cq(qts);
+    riscv_iommu_sys_trigger_cq_irq(qts);
+    g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TESTDEV_COUNT), ==, 0);
+
+    /* Stop the CQ before changing FCTL, preserving the deferred message. */
+    qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CQCSR, 0);
+    riscv_iommu_sys_set_wsi(qts, true);
+    if (unmask_in_wsi) {
+        riscv_iommu_sys_set_mask(qts, 0, false);
+    }
+    g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TESTDEV_COUNT), ==, 0);
+
+    riscv_iommu_sys_set_wsi(qts, false);
+    g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TESTDEV_COUNT),
+                     ==, unmask_in_wsi ? 1 : 0);
+    riscv_iommu_sys_set_mask(qts, 0, false);
+    g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TESTDEV_COUNT), ==, 1);
+
+    /* Repeated mode changes and unmask writes must not replay the MSI. */
+    riscv_iommu_sys_set_wsi(qts, true);
+    riscv_iommu_sys_set_wsi(qts, false);
+    riscv_iommu_sys_set_mask(qts, 0, false);
+    g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TESTDEV_COUNT), ==, 1);
+    g_free(sink);
+    qtest_quit(qts);
+}
+
+static void test_riscv_iommu_sys_wsi_delivery(void)
+{
+    const unsigned vector = 1;
+    const unsigned irq = RISCV_IOMMU_SYS_IRQ_BASE + vector;
+    const uint32_t irq_bit = 1U << (irq % 32);
+    const unsigned irq_word = (irq / 32) * 4;
+    QGenericPCIBus gbus;
+    QPCIBar sink_bar;
+    QPCIDevice *sink;
+    QTestState *qts = riscv_iommu_sys_test_init("-device pci-testdev");
+    uint64_t sink_target;
+    uint32_t sink_data;
+
+    if (!qts) {
+        return;
+    }
+
+    sink = riscv_iommu_sys_init_msi_sink(qts, &gbus, &sink_bar,
+                                         &sink_target, &sink_data);
+    riscv_iommu_sys_set_wsi(qts, true);
+    /* The MSI vector mask must not suppress delivery through the wire. */
+    riscv_iommu_sys_program_msi(qts, vector, sink_target, sink_data, true);
+    qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_ICVEC, vector);
+
+    qtest_writel(qts, RISCV_PLIC_BASE + irq * 4, 1);
+    qtest_writel(qts, RISCV_PLIC_ENABLE + irq_word, irq_bit);
+    qtest_writel(qts, RISCV_PLIC_THRESHOLD, 0);
+    g_assert_cmphex(qtest_readl(qts, RISCV_PLIC_PENDING + irq_word), ==, 0);
+    g_assert_cmpuint(qtest_readl(qts, RISCV_PLIC_CLAIM), ==, 0);
+
+    riscv_iommu_sys_setup_cq(qts);
+    riscv_iommu_sys_trigger_cq_irq(qts);
+    /* The PLIC latches the pulse after the device's wire returns low. */
+    g_assert_cmphex(qtest_readl(qts, RISCV_PLIC_PENDING + irq_word),
+                    ==, irq_bit);
+    g_assert_cmpuint(qtest_readl(qts, RISCV_PLIC_CLAIM), ==, irq);
+    g_assert_cmphex(qtest_readl(qts, RISCV_PLIC_PENDING + irq_word), ==, 0);
+    qtest_writel(qts, RISCV_PLIC_CLAIM, irq);
+    g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TESTDEV_COUNT), ==, 0);
+
+    /* A WSI event must not become a deferred MSI after switching modes. */
+    qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CQCSR, 0);
+    riscv_iommu_sys_set_wsi(qts, false);
+    riscv_iommu_sys_set_mask(qts, vector, false);
+    g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TESTDEV_COUNT), ==, 0);
+    g_free(sink);
+    qtest_quit(qts);
+}
+
+static void test_riscv_iommu_sys_msi_wsi_reset(void)
+{
+    QTestState *qts = riscv_iommu_sys_test_init(NULL);
+
+    if (!qts) {
+        return;
+    }
+
+    qtest_writel(qts, RISCV_IOMMU_SYS_MSI_TARGET0, 0);
+    riscv_iommu_sys_program_msi(qts, 0, RISCV_IOMMU_SYS_MSI_TARGET0,
+                                RISCV_IOMMU_SYS_MSI_DATA0, true);
+    riscv_iommu_sys_setup_cq(qts);
+    riscv_iommu_sys_trigger_cq_irq(qts);
+    qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CQCSR, 0);
+    riscv_iommu_sys_set_wsi(qts, true);
+    riscv_iommu_sys_set_mask(qts, 0, false);
+    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET0), ==, 0);
+
+    qtest_system_reset(qts);
+    /* Reprogram valid MSI state without depending on table reset values. */
+    riscv_iommu_sys_set_wsi(qts, true);
+    riscv_iommu_sys_program_msi(qts, 0, RISCV_IOMMU_SYS_MSI_TARGET0,
+                                RISCV_IOMMU_SYS_MSI_DATA1, false);
+    riscv_iommu_sys_set_wsi(qts, false);
+    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET0), ==, 0);
+    riscv_iommu_sys_set_mask(qts, 0, true);
+    riscv_iommu_sys_set_mask(qts, 0, false);
+    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET0), ==, 0);
+    qtest_quit(qts);
+}
+
+static void test_riscv_iommu_sys_msi_reset(void)
+{
+    QTestState *qts = riscv_iommu_sys_test_init(NULL);
+
+    if (!qts) {
+        return;
+    }
+
+    qtest_writel(qts, RISCV_IOMMU_SYS_MSI_TARGET0, 0);
+    riscv_iommu_sys_program_msi(qts, 0, RISCV_IOMMU_SYS_MSI_TARGET0,
+                                RISCV_IOMMU_SYS_MSI_DATA0, true);
+    riscv_iommu_sys_setup_cq(qts);
+    riscv_iommu_sys_trigger_cq_irq(qts);
+    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET0), ==, 0);
+
+    qtest_system_reset(qts);
+    riscv_iommu_sys_set_mask(qts, 0, false);
+    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET0), ==, 0);
+    qtest_quit(qts);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -275,5 +716,25 @@ int main(int argc, char **argv)
                    test_riscv_iommu_g_stage_only);
     qtest_add_func("/iommu-testdev/translation/ns-nested",
                    test_riscv_iommu_nested);
+    qtest_add_func("/riscv-iommu-sys/msi/unmasked",
+                   test_riscv_iommu_sys_msi_unmasked);
+    qtest_add_func("/riscv-iommu-sys/msi/masked",
+                   test_riscv_iommu_sys_msi_masked);
+    qtest_add_func("/riscv-iommu-sys/msi/config-update",
+                   test_riscv_iommu_sys_msi_config_update);
+    qtest_add_func("/riscv-iommu-sys/msi/vector-isolation",
+                   test_riscv_iommu_sys_msi_vector_isolation);
+    qtest_add_data_func("/riscv-iommu-sys/msi/wsi-switch-unmasked",
+                        GINT_TO_POINTER(true),
+                        test_riscv_iommu_sys_msi_wsi_switch);
+    qtest_add_data_func("/riscv-iommu-sys/msi/wsi-switch-masked",
+                        GINT_TO_POINTER(false),
+                        test_riscv_iommu_sys_msi_wsi_switch);
+    qtest_add_func("/riscv-iommu-sys/wsi/delivery",
+                   test_riscv_iommu_sys_wsi_delivery);
+    qtest_add_func("/riscv-iommu-sys/msi/wsi-reset",
+                   test_riscv_iommu_sys_msi_wsi_reset);
+    qtest_add_func("/riscv-iommu-sys/msi/reset",
+                   test_riscv_iommu_sys_msi_reset);
     return g_test_run();
 }
-- 
2.43.0


