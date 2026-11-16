Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1658606A323
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 07:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yZE2twhQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSrWA-0002XT-ET; Mon, 16 Nov 2026 02:52:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1xSrW8-0002Wi-VU
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 02:52:45 -0500
Received: from mail-pj2-x05.google.com ([2607:f8b0:4864:39::5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1xSrW6-0006PT-1M
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 02:52:44 -0500
Received: by mail-pj2-x05.google.com with SMTP id
 98e67ed59e1d1-3aec0b1d816so1689970a91.0
 for <qemu-devel@nongnu.org>; Sun, 15 Nov 2026 23:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794815561; x=1795420361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4yaVM/4Ndz0g7rHFZsC1PhMy0pfcgoOnC4kFkKQPDt4=;
 b=yZE2twhQrQtKdGXZ7PqONdZwxivxy037SRBGMm0OOb/FXB8AXluoym3ywuBDUoX1JQ
 x+UFv9UuFNfEhJsO645aBEnCUQap6oWq6wsF9pq4M+sZghpLZzGD/LzbgpFKoONbOeoW
 VMc2ZsSI67myVL+ySB+Woj53CHiYOY/5M9Lgo/VZzP05syrBg9CU8H41oUUC1cOmz5F9
 feKGEO0mieehs6KLrTVHMWKOsRcCs1JMqM0Jqo/nwt3ubojeGE/R0Y473JXadT6fUqXn
 0Q2cxZq41VCELB+/zhQR/LbOU6VaVc8DhGJ4RMTiIa4iA4lUa1CJ5+UIRXBw3vDsyUY9
 j42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794815561; x=1795420361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4yaVM/4Ndz0g7rHFZsC1PhMy0pfcgoOnC4kFkKQPDt4=;
 b=sBTN5NDwBAsxMoNw0vL+XWlLh+0JabzO4Nyy8Z7FyLx6TEqxpNqeeQgTMXAm635yE1
 RLRnRtci/dUMVX+6ChHkBPPjDaJ51xEZLWENPf9km9ViFew39OjRG/CRAxXPeLWIS8qV
 5HQMN6EOdCwY73fyZBNBG40F0H1xsIwXwTLNt4iyckG3tZj5uz+5xjLTm5rwZT+Z1n/n
 IEqiFSHMXrKIA+LTtYWmDLKE9bZcHPGvVQ6MAsTdLOEkXC/zB+I6GGJEYPiC/5g8V4Fd
 4yVblzDrE6dcR0VM6q89Q5RW493EsB9+bUE/tnvWOTWHNhBDe9r2VfDahpbQm/53Z50B
 7o6Q==
X-Gm-Message-State: APuU4Z8f/fixH9ko49j54D7w8/zpX9tm7jfgXbp7uCsTdtOfsVJ1wbAW
 vTNJaMBE4yByBqf8wF5V2GrvU1nMhP0nOGS1Anzr0cg4l38XRwogvwuyaXQrqRGzUiILN/XN63s
 =
X-Gm-Gg: AZFdTZfJ2IHmJsBXUyISboJugjKve+hAm0WJHHsHkij4HFvsfjzThS4Gwjad8R+RVW0
 IQJHzf+QM1dPxc6CC+qRh1HAjLuVTjo/VvVPmqVgbLiAwKZlps4u/HULUUD+iYGvkKCQSKjLzt3
 aLn6G2vJteTefO7n+zMLKXfGBSTS6cMd95ObF3h0e+EAqyPcSwmZqSpBdcC+LNF8hIUKLYp/4kD
 cSEQ6hCXP5X1Dj1ik4f4afLKfgQ8ItACpvQPe86wBTzsyFcgD4Nv4DIgg/BH/6+lRX7r5Apz0YC
 t0Lq0vS4jBh0LjdUFnXc9CMfhajhODo1QruubNEDTnqHBZW/+3NGzEIkSmS6rcdW15bv1Ybi3AD
 7OfuyDpOGWAN/JJUvlLSGhmVdXae9ONr1OPvCSpUmM23i4KQimJglJxIuBBPMecA4gTy5wSRQpB
 P97APWx7PehWwivZsIqnpgND68mDX9yahICy8WqPs9uoK7dopSytryDBJOlcbOAOJfca/8rknvy
 qsJM4OCF0D6rjTclT7HQl0G5Gfv9ubz2gPK0T1/J+1pVrEARE4sjZ5+T4ExgT6uQKsdnpVZih/a
 8eInQZNKEVDPSrIJli2JH1ZweUJ7sTQrdWRMsdncvN6RC3St06OLbOqc
X-Received: by 2002:a17:90b:2250:b0:3ac:7556:8ee6 with SMTP id
 98e67ed59e1d1-3b1b0b668c7mr9870592a91.16.1794815560139; 
 Sun, 15 Nov 2026 23:52:40 -0800 (PST)
Received: from Dell-WorkStation.localdomain ([152.175.67.81])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b197d0f6e0sm20745622a91.9.2026.11.15.23.52.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 23:52:39 -0800 (PST)
From: Zephyr Li <fritchleybohrer@gmail.com>
To: qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, qemu-riscv@nongnu.org, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com
Subject: [PATCH 1/3] hw/riscv/riscv-iommu: Preserve IOVA in MSI fault records
Date: Mon, 16 Nov 2026 15:51:39 +0800
Message-ID: <20261116075141.167317-2-fritchleybohrer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116075141.167317-1-fritchleybohrer@gmail.com>
References: <20261116075141.167317-1-fritchleybohrer@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::5;
 envelope-from=fritchleybohrer@gmail.com; helo=mail-pj2-x05.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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

MSI translation errors currently report zero for both fault address
fields. The MSI write handler receives the GPA used to select the MSI
PTE, but an inbound transaction's iotval must identify its original
IOVA. These addresses need not match when first-stage translation is
enabled.

Keep trapped translations in IOVA space when returning them to the
memory subsystem. In the trap callback, walk the same device/process
context again to recover the GPA and pass both addresses to the MSI
write handler. This retains the per-transaction IOVA without shared
last-address state and leaves internal translation/debug results intact.

Report a rewalk fault with the original IOVA. If a changed mapping no
longer selects MSI translation, complete the write as ordinary DMA
instead. Preserve the request's process context and little-endian data
in these paths. MSI fault reports continue to leave iotval2 unchanged.

Exclude the internal GPA-recovery replay from the modeled S/G-stage HPM
walk events, so this fault-reporting change preserves the existing
counter behavior. Ordinary translation walks retain their existing
accounting.

Add firmware-independent qtests using device-generated MSIs and
nonidentity first-stage mappings. Check fault addresses, Bare
first-stage operation, successful MSI writes, and the modeled HPM
counter deltas.

This still adds a page-table walk to intercepted MSI writes when
first-stage translation is enabled; the Bare first-stage path uses its
existing early MSI check.

Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3562
Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
---
 hw/riscv/riscv-iommu.c         |  60 ++++++++++---
 tests/qtest/iommu-riscv-test.c | 153 ++++++++++++++++++++++++++++++---
 2 files changed, 189 insertions(+), 24 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 0e6970773a..016e95fce7 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -276,10 +276,11 @@ static hwaddr riscv_iommu_napot_page_mask(hwaddr ppn, hwaddr addr, hwaddr *out)
  * @s        : IOMMU Device State
  * @ctx      : Translation context for device id and process address space id.
  * @iotlb    : translation data: physical address and access mode.
+ * @update_hpm : account for modeled page-table walk events.
  * @return   : success or fault cause code.
  */
 static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
-    IOMMUTLBEntry *iotlb)
+    IOMMUTLBEntry *iotlb, bool update_hpm)
 {
     IOMMUAccessFlags trans_perm = IOMMU_NONE;
     dma_addr_t addr, base;
@@ -456,10 +457,14 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
         }
 
 
-        if (pass == S_STAGE) {
-            riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_S_VS_WALKS);
-        } else {
-            riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_G_WALKS);
+        if (update_hpm) {
+            if (pass == S_STAGE) {
+                riscv_iommu_hpm_incr_ctr(s, ctx,
+                                       RISCV_IOMMU_HPMEVENT_S_VS_WALKS);
+            } else {
+                riscv_iommu_hpm_incr_ctr(s, ctx,
+                                       RISCV_IOMMU_HPMEVENT_G_WALKS);
+            }
         }
 
         /* Read page table entry */
@@ -641,9 +646,9 @@ static void riscv_iommu_report_fault(RISCVIOMMUState *s,
     riscv_iommu_fault(s, &ev);
 }
 
-/* Redirect MSI write for given GPA. */
+/* Redirect an MSI write, retaining the original IOVA for fault reporting. */
 static MemTxResult riscv_iommu_msi_write(RISCVIOMMUState *s,
-    RISCVIOMMUContext *ctx, uint64_t gpa, uint64_t data,
+    RISCVIOMMUContext *ctx, uint64_t iova, uint64_t gpa, uint64_t data,
     unsigned size, MemTxAttrs attrs)
 {
     MemTxResult res;
@@ -826,7 +831,7 @@ static MemTxResult riscv_iommu_msi_write(RISCVIOMMUState *s,
 
 err:
     riscv_iommu_report_fault(s, ctx, fault_type, cause,
-                             !!ctx->process_id, 0, 0);
+                             !!ctx->process_id, iova, 0);
     return res;
 }
 
@@ -1776,7 +1781,7 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
     riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_TLB_MISS);
 
     /* Translate using device directory / page table information. */
-    fault = riscv_iommu_spa_fetch(s, ctx, iotlb);
+    fault = riscv_iommu_spa_fetch(s, ctx, iotlb, true);
 
     if (!fault && iotlb->target_as == &s->trap_as) {
         /* Do not cache trapped MSI translations */
@@ -2609,6 +2614,13 @@ static MemTxResult riscv_iommu_trap_write(void *opaque, hwaddr addr,
     MemTxResult res;
     void *ref;
     uint32_t devid = attrs.requester_id;
+    IOMMUTLBEntry iotlb = {
+        .iova = addr,
+        .target_as = s->target_as,
+        .addr_mask = ~0ULL,
+        .perm = IOMMU_WO,
+    };
+    int cause;
 
     if (attrs.unspecified) {
         return MEMTX_ACCESS_ERROR;
@@ -2617,11 +2629,32 @@ static MemTxResult riscv_iommu_trap_write(void *opaque, hwaddr addr,
     /* FIXME: PCIe bus remapping for attached endpoints. */
     devid |= s->bus << 8;
 
-    ctx = riscv_iommu_ctx(s, devid, 0, IOMMU_RW, addr, &ref);
+    ctx = riscv_iommu_ctx(s, devid, attrs.pid, IOMMU_WO, addr, &ref);
     if (ctx == NULL) {
         res = MEMTX_ACCESS_ERROR;
     } else {
-        res = riscv_iommu_msi_write(s, ctx, addr, data, size, attrs);
+        /*
+         * The trap address is the original IOVA. Resolve the MSI GPA
+         * without consulting or updating the translation cache.
+         * Exclude this internal replay from the modeled HPM events.
+         */
+        cause = riscv_iommu_spa_fetch(s, ctx, &iotlb, false);
+        if (cause) {
+            riscv_iommu_report_fault(s, ctx,
+                RISCV_IOMMU_FQ_TTYPE_UADDR_WR, cause,
+                !!(ctx->tc & RISCV_IOMMU_DC_TC_PDTV),
+                addr, iotlb.translated_addr);
+            res = MEMTX_ACCESS_ERROR;
+        } else if (iotlb.target_as == &s->trap_as) {
+            res = riscv_iommu_msi_write(s, ctx, addr,
+                                       iotlb.translated_addr, data,
+                                       size, attrs);
+        } else {
+            /* The mapping may have changed since the original walk. */
+            data = cpu_to_le64(data);
+            res = dma_memory_write(iotlb.target_as, iotlb.translated_addr,
+                                   &data, size, attrs);
+        }
     }
     riscv_iommu_ctx_put(s, ref);
     return res;
@@ -2943,6 +2976,11 @@ static IOMMUTLBEntry riscv_iommu_memory_region_translate(
                           IOMMU_FLAG_STR[flag & IOMMU_RW], iotlb.iova,
                           iotlb.translated_addr);
 
+    if (iotlb.target_as == &as->iommu->trap_as) {
+        /* Preserve the transaction IOVA through the MSI write callback. */
+        iotlb.translated_addr = iotlb.iova;
+    }
+
     riscv_iommu_ctx_put(as->iommu, ref);
 
     return iotlb;
diff --git a/tests/qtest/iommu-riscv-test.c b/tests/qtest/iommu-riscv-test.c
index 1cd753c4f2..3678d8a0d4 100644
--- a/tests/qtest/iommu-riscv-test.c
+++ b/tests/qtest/iommu-riscv-test.c
@@ -25,6 +25,12 @@
 #define DBG_TRANSLATED_PA       0x90000000ull
 #define DBG_NESTED_GPA          0x200000ull
 
+#define MSI_TABLE_PA            0x80030000ull
+#define MSI_TARGET_PA           0x80040000ull
+#define MSI_DATA                0x37
+#define EDU_DEVICE_ID           0x11e8
+#define EDU_IRQ_RAISE           0x60
+
 /* RISC-V virt machine PCI configuration */
 #define RISCV_GPEX_PIO_BASE        0x3000000
 #define RISCV_BUS_PIO_LIMIT        0x10000
@@ -50,6 +56,21 @@ typedef struct RiscvIommuDbgTest {
     uint64_t expected_response;
 } RiscvIommuDbgTest;
 
+typedef struct RiscvIommuMsiTest {
+    const char *name;
+    QRIOMMUTransMode mode;
+    bool valid_pte;
+    uint64_t s_walks;
+    uint64_t g_walks;
+} RiscvIommuMsiTest;
+
+static const RiscvIommuMsiTest msi_tests[] = {
+    { "first-stage-bare-fault", QRIOMMU_TM_G_STAGE_ONLY, false, 0, 0 },
+    { "nested-fault", QRIOMMU_TM_NESTED, false, 3, 9 },
+    { "first-stage-bare-basic", QRIOMMU_TM_G_STAGE_ONLY, true, 0, 0 },
+    { "nested-basic", QRIOMMU_TM_NESTED, true, 3, 9 },
+};
+
 static const RiscvIommuDbgTest debug_tests[] = {
     {
         .name = "page-4k",
@@ -157,15 +178,16 @@ static QPCIDevice *find_riscv_iommu_pci(QGenericPCIBus *gbus,
     return iommu_dev;
 }
 
-static QPCIDevice *find_iommu_testdev(QGenericPCIBus *gbus, QPCIBar *bar)
+static QPCIDevice *find_testdev(QGenericPCIBus *gbus, QPCIBar *bar, bool msi)
 {
     QPCIDevice *dev = NULL;
+    uint16_t vendor = msi ? PCI_VENDOR_ID_QEMU : IOMMU_TESTDEV_VENDOR_ID;
+    uint16_t device = msi ? EDU_DEVICE_ID : IOMMU_TESTDEV_DEVICE_ID;
 
-    g_test_message("Searching for iommu-testdev (vendor=0x%04x, device=0x%04x)",
-                   IOMMU_TESTDEV_VENDOR_ID, IOMMU_TESTDEV_DEVICE_ID);
+    g_test_message("Searching for %s (vendor=0x%04x, device=0x%04x)",
+                   msi ? "edu" : "iommu-testdev", vendor, device);
 
-    qpci_device_foreach(&gbus->bus, IOMMU_TESTDEV_VENDOR_ID,
-                        IOMMU_TESTDEV_DEVICE_ID, save_fn, &dev);
+    qpci_device_foreach(&gbus->bus, vendor, device, save_fn, &dev);
     g_assert(dev);
 
     qpci_device_enable(dev);
@@ -175,17 +197,21 @@ static QPCIDevice *find_iommu_testdev(QGenericPCIBus *gbus, QPCIBar *bar)
     return dev;
 }
 
-static bool riscv_iommu_test_setup(RiscvIommuTestState *state)
+static bool riscv_iommu_test_setup(RiscvIommuTestState *state, bool msi)
 {
     if (!qtest_has_machine("virt")) {
         g_test_skip("virt machine not available");
         return false;
     }
+    if (msi && !qtest_has_device("edu")) {
+        g_test_skip("edu device not available");
+        return false;
+    }
 
-    state->qts = qtest_init("-machine virt,acpi=off "
-                            "-cpu max -smp 1 -m 512 -net none "
-                            "-device riscv-iommu-pci "
-                            "-device iommu-testdev");
+    state->qts = qtest_initf("-machine virt,acpi=off "
+                             "-cpu max -smp 1 -m 512 -bios none -net none "
+                             "-device riscv-iommu-pci "
+                             "-device %s", msi ? "edu" : "iommu-testdev");
 
     qpci_init_generic(&state->gbus, state->qts, NULL, false);
     riscv_config_qpci_bus(&state->gbus);
@@ -193,7 +219,7 @@ static bool riscv_iommu_test_setup(RiscvIommuTestState *state)
     state->iommu_dev = find_riscv_iommu_pci(&state->gbus, &state->iommu_base);
     g_assert(state->iommu_dev);
 
-    state->testdev = find_iommu_testdev(&state->gbus, &state->testdev_bar);
+    state->testdev = find_testdev(&state->gbus, &state->testdev_bar, msi);
     g_assert(state->testdev);
 
     return true;
@@ -267,7 +293,7 @@ static void run_riscv_iommu_translation(const QRIOMMUTestConfig *cfg)
 {
     RiscvIommuTestState state = { 0 };
 
-    if (!riscv_iommu_test_setup(&state)) {
+    if (!riscv_iommu_test_setup(&state, false)) {
         return;
     }
 
@@ -328,6 +354,101 @@ static void test_riscv_iommu_nested(void)
     run_riscv_iommu_translation(&cfg);
 }
 
+static void test_riscv_iommu_msi(gconstpointer data)
+{
+    static const unsigned events[] = {
+        RISCV_IOMMU_HPMEVENT_URQ,
+        RISCV_IOMMU_HPMEVENT_TLB_MISS,
+        RISCV_IOMMU_HPMEVENT_S_VS_WALKS,
+        RISCV_IOMMU_HPMEVENT_G_WALKS,
+    };
+    const RiscvIommuMsiTest *cfg = data;
+    const uint64_t expected[] = { 1, 1, cfg->s_walks, cfg->g_walks };
+    RiscvIommuTestState state = { 0 };
+    uint64_t iova = (QRIOMMU_IOVA & ~0xfffull) +
+                    (cfg->valid_pte ? 0 : 0x40);
+    uint64_t gpa = iova;
+    uint64_t dc_addr, pte = 0, hdr, cap;
+    uint64_t fq_addr = QRIOMMU_SPACE_OFFS + QRIOMMU_FQ_BASE_ADDR;
+    uint8_t msi_cap;
+    uint16_t flags;
+
+    if (!riscv_iommu_test_setup(&state, true)) {
+        return;
+    }
+
+    cap = riscv_iommu_check(state.qts, state.iommu_base, cfg->mode);
+    g_assert_cmphex(cap & RISCV_IOMMU_CAP_MSI_FLAT, !=, 0);
+    g_assert_cmphex(cap & RISCV_IOMMU_CAP_HPM, !=, 0);
+    qriommu_build_translation(state.qts, cfg->mode, state.testdev->devfn);
+    if (cfg->mode == QRIOMMU_TM_NESTED) {
+        gpa = QRIOMMU_L2_PTE_VAL + (iova & 0xfff);
+        g_assert_cmphex(iova, !=, gpa);
+    }
+
+    /* Match one GPA page; interrupt-file number zero selects the first PTE. */
+    dc_addr = QRIOMMU_SPACE_OFFS + QRIOMMU_DC_BASE +
+              state.testdev->devfn * sizeof(struct riscv_iommu_dc);
+    qtest_writeq(state.qts, dc_addr + 32,
+                 (MSI_TABLE_PA >> 12) | (1ull << 60));
+    qtest_writeq(state.qts, dc_addr + 40, 0);
+    qtest_writeq(state.qts, dc_addr + 48, gpa >> 12);
+    qtest_memset(state.qts, MSI_TABLE_PA, 0, 0x1000);
+    qtest_writel(state.qts, MSI_TARGET_PA, 0);
+    if (cfg->valid_pte) {
+        pte = ((MSI_TARGET_PA >> 12) << 10) |
+              (RISCV_IOMMU_MSI_PTE_M_BASIC << 1) | RISCV_IOMMU_MSI_PTE_V;
+    }
+    qtest_writeq(state.qts, MSI_TABLE_PA, pte);
+    qriommu_program_regs(state.qts, state.iommu_base);
+
+    for (unsigned i = 0; i < G_N_ELEMENTS(events); i++) {
+        qtest_writeq(state.qts, state.iommu_base + RISCV_IOMMU_REG_IOHPMEVT(i),
+                     events[i]);
+        qtest_writeq(state.qts, state.iommu_base + RISCV_IOMMU_REG_IOHPMCTR(i),
+                     0);
+        g_assert_cmpuint(qtest_readq(state.qts,
+            state.iommu_base + RISCV_IOMMU_REG_IOHPMCTR(i)), ==, 0);
+    }
+    qtest_writel(state.qts, state.iommu_base + RISCV_IOMMU_REG_IOCOUNTINH,
+                 RISCV_IOMMU_IOCOUNTINH_CY);
+
+    /* EDU sends a real PCI MSI, including the transaction requester ID. */
+    msi_cap = qpci_find_capability(state.testdev, PCI_CAP_ID_MSI, 0);
+    g_assert_cmpuint(msi_cap, !=, 0);
+    flags = qpci_config_readw(state.testdev, msi_cap + PCI_MSI_FLAGS);
+    g_assert_cmpuint(flags & PCI_MSI_FLAGS_64BIT, !=, 0);
+    qpci_config_writel(state.testdev, msi_cap + PCI_MSI_ADDRESS_LO, iova);
+    qpci_config_writel(state.testdev, msi_cap + PCI_MSI_ADDRESS_HI, iova >> 32);
+    qpci_config_writew(state.testdev, msi_cap + PCI_MSI_DATA_64, MSI_DATA);
+    qpci_config_writew(state.testdev, msi_cap + PCI_MSI_FLAGS,
+                       flags | PCI_MSI_FLAGS_ENABLE);
+    qpci_io_writel(state.testdev, state.testdev_bar, EDU_IRQ_RAISE, 1);
+
+    g_assert_cmpuint(qtest_readl(state.qts,
+        state.iommu_base + RISCV_IOMMU_REG_FQT), ==, !cfg->valid_pte);
+    if (cfg->valid_pte) {
+        g_assert_cmphex(qtest_readl(state.qts, MSI_TARGET_PA), ==, MSI_DATA);
+    } else {
+        hdr = qtest_readq(state.qts, fq_addr);
+        g_assert_cmpuint(hdr & RISCV_IOMMU_FQ_HDR_CAUSE, ==,
+                         RISCV_IOMMU_FQ_CAUSE_MSI_INVALID);
+        g_assert_cmpuint((hdr & RISCV_IOMMU_FQ_HDR_TTYPE) >> 34, ==,
+                         RISCV_IOMMU_FQ_TTYPE_UADDR_WR);
+        g_assert_cmpuint((hdr & RISCV_IOMMU_FQ_HDR_DID) >> 40, ==,
+                         state.testdev->devfn);
+        g_assert_cmphex(qtest_readq(state.qts, fq_addr + 16), ==, iova);
+        g_assert_cmphex(qtest_readq(state.qts, fq_addr + 24), ==, 0);
+    }
+
+    /* Count the original translation, excluding the GPA recovery walk. */
+    for (unsigned i = 0; i < G_N_ELEMENTS(events); i++) {
+        g_assert_cmpuint(qtest_readq(state.qts,
+            state.iommu_base + RISCV_IOMMU_REG_IOHPMCTR(i)), ==, expected[i]);
+    }
+    riscv_iommu_test_teardown(&state);
+}
+
 static void riscv_iommu_dbg_map_leaf(QTestState *qts, uint64_t l1_pa,
                                     uint64_t l2_pa, uint64_t va, uint64_t pa,
                                     uint64_t page_size)
@@ -386,7 +507,7 @@ static void test_riscv_iommu_dbg(gconstpointer data)
                          cfg->g_page_size : cfg->s_page_size;
     uint64_t response;
 
-    if (!riscv_iommu_test_setup(&state)) {
+    if (!riscv_iommu_test_setup(&state, false)) {
         return;
     }
 
@@ -462,6 +583,12 @@ int main(int argc, char **argv)
                    test_riscv_iommu_g_stage_only);
     qtest_add_func("/iommu-testdev/translation/ns-nested",
                    test_riscv_iommu_nested);
+    for (unsigned i = 0; i < G_N_ELEMENTS(msi_tests); i++) {
+        g_autofree char *path = g_strdup_printf("/riscv-iommu/msi/%s",
+                                               msi_tests[i].name);
+
+        qtest_add_data_func(path, &msi_tests[i], test_riscv_iommu_msi);
+    }
     for (unsigned i = 0; i < G_N_ELEMENTS(debug_tests); i++) {
         g_autofree char *path = g_strdup_printf("/iommu-testdev/debug/%s",
                                                debug_tests[i].name);
-- 
2.43.0


