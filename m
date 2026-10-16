Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD3FCCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 09:09:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHdw2-0002Ia-7H; Fri, 16 Oct 2026 05:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1xHdvs-0002IC-VV
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:08:57 -0400
Received: from mail-pj2-x0b.google.com ([2607:f8b0:4864:39::b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1xHdvn-00039r-Re
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:08:53 -0400
Received: by mail-pj2-x0b.google.com with SMTP id
 d9443c01a7336-2e609985789so23289895ad.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 02:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792141729; x=1792746529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qaRD/4q9PGRUjXYuBhoz03xHv+WwWzOxZlY6uZE5R9A=;
 b=nqyJrWrGdXxv7BMJ/fJUFSxziM3HopVqxBTZq8PUc0vmtjPyucENolqx7sJtyRaVOA
 gOuGHrsJlufsep4X98VGRzzHknCXuDwzdBTeKUMn1Wz79dC3tgeVPiG3fOjl1/FBKWBu
 FIHWc6HHAFzAqIy34D4zAW+PUv7C/nxFyEdS/iMPpcG/18bNSvMm1Qb+YU+dqPtP0AqZ
 ZkYl7q+clBAC21q1jxnKuMzey8rVb3S8LC5JKuRMgyjcnm9S4/ZhYnMZyrOFrfOBmycX
 LPJhqXZbYaPbeuTaQWNOx0u2EmVFTiTu3UZ2jP2Ma0+1n0mgsgzaTr/9vrcfasuec0ml
 +9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792141729; x=1792746529;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qaRD/4q9PGRUjXYuBhoz03xHv+WwWzOxZlY6uZE5R9A=;
 b=kfJZuk09I9QNAtjQhIID3FovU1+cr8m6P0TtJeMJYQD0SMg7TeXzko6k71gPjG9boo
 JGjZ0V+lC5DHvcsMipVOBOO9Qpvs0+96SM4j1ub5fscfoWOw8mCkgv/q9l80VUsZOeJo
 hleT8i1Ihki/tczMHXKTvRoGmjAfRJwXwREZYPheWkeC/P8AaHHjV2RmU54JPsPvndh3
 AC01+PzeSHI9PnTZG4pqaMB3sIdrpbdKCpX+2SztYLvuHPLkXzRzthIumwiYQUAyEKdg
 agxN4FnpGrhK5jYmk+kYElO6eEZGlTExbEZIr1k9c9avkFk1pm5yWi0fLr8AdFIjQls1
 XC4g==
X-Gm-Message-State: AFq9FYLyfb2Hx7Ct8ullYTkIKVyas+75PyjknBRFn4B8bybljtzDmSNI
 9A7qV1cRCAlmgylJCC+YbPPMv+VmL8xXI9wOpfw0+RNNwdlmUEYcRR3L
X-Gm-Gg: AYBFou1nqhz5dro9/b15ItjpTBbTFa/CBO3mBW5wT/JkoKX4suy3WhjLgcxxT+Gtg4Z
 cExt8N7Ewx8VC6jVtEmzvZguSdskDPVuXEfi2uviFvrLsHloJA+e1EISilgGeU84Xq5d3CieFtv
 bMggfVF1s95jK13A4xUm2SufDD4hi4xSx576FDMD6BSaYMUPfayKAFHG+MF7u7HKdiBwBny4UM9
 GRFK8tso0doNDhKF5BVAUU+R6r1Iy3/edZ10tXUxbTNys/c30umeWwPzUq2APYutjBUTZlx0wO9
 MwYpWb7yo/vfwM89xQo9J3LfA6p+iRGvOEekN0C4sTIRd/B0E6ZkuzH7Y4EFNzSF5YpjyMlJhOa
 CT2AbVwWYTA5o++eKiOOR/cbB0hNAfKlkAubDfWGTw9gmc/LinHp0fLtBdp7KdZS65GNChjL/7Y
 2LYqAbQwwT0kx9eXuAJzw5STFzM7LhP8qJm9GDTKNRZF8r/Bf47NOzsjd7+o+NAER2EFhnsxnYh
 LqJcrW8UUc2sSwOjE4LGN7l+Q==
X-Received: by 2002:a17:903:40c5:b0:2df:8382:918b with SMTP id
 d9443c01a7336-2e8427156c6mr189417185ad.0.1792141728259; 
 Fri, 16 Oct 2026 02:08:48 -0700 (PDT)
Received: from Dell-WorkStation.localdomain ([152.175.67.81])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e5d51b5sm6914525ad.8.2026.10.16.02.08.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 02:08:47 -0700 (PDT)
From: Zephyr Li <fritchleybohrer@gmail.com>
To: alistair.francis@wdc.com
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com,
 daniel.barboza@oss.qualcomm.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com,
 Zephyr Li <fritchleybohrer@gmail.com>
Subject: [PATCH] hw/riscv/riscv-iommu: encode debug translation ranges
Date: Fri, 16 Oct 2026 17:08:32 +0800
Message-ID: <20261016090832.38530-1-fritchleybohrer@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::b;
 envelope-from=fritchleybohrer@gmail.com; helo=mail-pj2-x0b.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The debug translation response aligns the translated physical address to
the effective translation range, but always reports S=0. For a request
inside a superpage, the response therefore identifies the wrong 4 KiB
physical page.

For effective ranges larger than 4 KiB, set S and encode the range size
using trailing ones in the PPN field. Keep the existing response format
for 4 KiB translations.

The RISC-V IOMMU specification permits reporting a 4 KiB translation even
when the page tables use superpages. Reporting the effective range is an
implementation choice; this change does not claim that S=1 is mandatory
for every translation through a superpage mapping.

Add debug-response tests for S-stage-only 4 KiB, 64 KiB NAPOT, and 2 MiB
translations, G-stage-only 2 MiB translations, and nested S4K/G2M,
S2M/G4K, and S2M/G2M mappings. Check requests inside large ranges and at
both ends. The mixed nested cases verify that the response uses the
smaller effective translation granularity.

Fixes: a7aa525b93c3 ("hw/riscv/riscv-iommu: add DBG support")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3552
Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
---
 hw/riscv/riscv-iommu.c         |  14 ++-
 tests/qtest/iommu-riscv-test.c | 193 +++++++++++++++++++++++++++++++++
 2 files changed, 206 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 323a041b4a558136819b1cd41452e96481ba164a..67d8456b9d3ed34308ca794e8d700664ebacce0f 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2281,8 +2281,20 @@ static void riscv_iommu_process_dbg(RISCVIOMMUState *s)
         if (fault) {
             iova = RISCV_IOMMU_TR_RESPONSE_FAULT | (((uint64_t) fault) << 10);
         } else {
+            uint64_t ppn;
+
             iova = iotlb.translated_addr & ~iotlb.addr_mask;
-            iova = set_field(0, RISCV_IOMMU_TR_RESPONSE_PPN, PPN_DOWN(iova));
+            ppn = PPN_DOWN(iova);
+
+            if (iotlb.addr_mask > TARGET_PAGE_SIZE - 1) {
+                /* Encode the translation range as trailing ones in the PPN. */
+                ppn |= PPN_DOWN(iotlb.addr_mask) >> 1;
+                iova = RISCV_IOMMU_TR_RESPONSE_S;
+            } else {
+                iova = 0;
+            }
+
+            iova = set_field(iova, RISCV_IOMMU_TR_RESPONSE_PPN, ppn);
         }
         riscv_iommu_reg_set64(s, RISCV_IOMMU_REG_TR_RESPONSE, iova);
     }
diff --git a/tests/qtest/iommu-riscv-test.c b/tests/qtest/iommu-riscv-test.c
index 26380248912cc281e313e20a3daf1831be1eded3..1cd753c4f243f207dc34b7acbe41ef0d55772cba 100644
--- a/tests/qtest/iommu-riscv-test.c
+++ b/tests/qtest/iommu-riscv-test.c
@@ -19,6 +19,12 @@
 
 #define DMA_LEN           4
 
+#define DBG_PAGE_SIZE           0x1000ull
+#define DBG_NAPOT_SIZE          0x10000ull
+#define DBG_SUPERPAGE_SIZE      0x200000ull
+#define DBG_TRANSLATED_PA       0x90000000ull
+#define DBG_NESTED_GPA          0x200000ull
+
 /* RISC-V virt machine PCI configuration */
 #define RISCV_GPEX_PIO_BASE        0x3000000
 #define RISCV_BUS_PIO_LIMIT        0x10000
@@ -35,6 +41,64 @@ typedef struct RiscvIommuTestState {
     uint64_t iommu_base;
 } RiscvIommuTestState;
 
+typedef struct RiscvIommuDbgTest {
+    const char *name;
+    QRIOMMUTransMode mode;
+    uint64_t s_page_size;
+    uint64_t g_page_size;
+    uint64_t pa;
+    uint64_t expected_response;
+} RiscvIommuDbgTest;
+
+static const RiscvIommuDbgTest debug_tests[] = {
+    {
+        .name = "page-4k",
+        .mode = QRIOMMU_TM_S_STAGE_ONLY,
+        .s_page_size = DBG_PAGE_SIZE,
+        .pa = DBG_TRANSLATED_PA + DBG_PAGE_SIZE,
+        .expected_response = 0x24000400ull,
+    }, {
+        .name = "napot-64k",
+        .mode = QRIOMMU_TM_S_STAGE_ONLY,
+        .s_page_size = DBG_NAPOT_SIZE,
+        .pa = DBG_TRANSLATED_PA,
+        .expected_response = 0x24001e00ull,
+    }, {
+        .name = "superpage",
+        .mode = QRIOMMU_TM_S_STAGE_ONLY,
+        .s_page_size = DBG_SUPERPAGE_SIZE,
+        .pa = DBG_TRANSLATED_PA,
+        .expected_response = 0x2403fe00ull,
+    }, {
+        .name = "g-stage-superpage",
+        .mode = QRIOMMU_TM_G_STAGE_ONLY,
+        .g_page_size = DBG_SUPERPAGE_SIZE,
+        .pa = DBG_TRANSLATED_PA,
+        .expected_response = 0x2403fe00ull,
+    }, {
+        .name = "nested-s4k-g2m",
+        .mode = QRIOMMU_TM_NESTED,
+        .s_page_size = DBG_PAGE_SIZE,
+        .g_page_size = DBG_SUPERPAGE_SIZE,
+        .pa = DBG_TRANSLATED_PA,
+        .expected_response = 0x24001000ull,
+    }, {
+        .name = "nested-s2m-g4k",
+        .mode = QRIOMMU_TM_NESTED,
+        .s_page_size = DBG_SUPERPAGE_SIZE,
+        .g_page_size = DBG_PAGE_SIZE,
+        .pa = DBG_TRANSLATED_PA,
+        .expected_response = 0x24001000ull,
+    }, {
+        .name = "nested-s2m-g2m",
+        .mode = QRIOMMU_TM_NESTED,
+        .s_page_size = DBG_SUPERPAGE_SIZE,
+        .g_page_size = DBG_SUPERPAGE_SIZE,
+        .pa = DBG_TRANSLATED_PA,
+        .expected_response = 0x2403fe00ull,
+    },
+};
+
 static void riscv_config_qpci_bus(QGenericPCIBus *qpci)
 {
     qpci->gpex_pio_base = RISCV_GPEX_PIO_BASE;
@@ -264,6 +328,129 @@ static void test_riscv_iommu_nested(void)
     run_riscv_iommu_translation(&cfg);
 }
 
+static void riscv_iommu_dbg_map_leaf(QTestState *qts, uint64_t l1_pa,
+                                    uint64_t l2_pa, uint64_t va, uint64_t pa,
+                                    uint64_t page_size)
+{
+    uint64_t pte = ((pa >> 12) << 10) | QRIOMMU_LEAF_PTE_RW_MASK;
+    uint64_t pte_addr;
+
+    g_assert_cmphex(pa & (page_size - 1), ==, 0);
+
+    if (page_size == DBG_SUPERPAGE_SIZE) {
+        pte_addr = l1_pa + (((va >> 21) & 0x1ff) * sizeof(uint64_t));
+        qtest_writeq(qts, pte_addr, pte);
+    } else if (page_size == DBG_NAPOT_SIZE) {
+        /* A 64 KiB NAPOT PTE has N=1 and PPN[3:0]=1000. */
+        pte |= BIT_ULL(63) | (8ull << 10);
+        va &= ~(DBG_NAPOT_SIZE - 1);
+        for (unsigned i = 0; i < DBG_NAPOT_SIZE / DBG_PAGE_SIZE; i++) {
+            pte_addr = l2_pa + ((((va >> 12) + i) & 0x1ff) *
+                                sizeof(uint64_t));
+            qtest_writeq(qts, pte_addr, pte);
+        }
+    } else {
+        g_assert_cmphex(page_size, ==, DBG_PAGE_SIZE);
+        pte_addr = l2_pa + (((va >> 12) & 0x1ff) * sizeof(uint64_t));
+        qtest_writeq(qts, pte_addr, pte);
+    }
+}
+
+static uint64_t riscv_iommu_dbg_translate(RiscvIommuTestState *state,
+                                         uint64_t iova)
+{
+    uint64_t request;
+
+    qtest_writeq(state->qts,
+                 state->iommu_base + RISCV_IOMMU_REG_TR_REQ_IOVA, iova);
+    request = ((uint64_t)state->testdev->devfn << 40) |
+              RISCV_IOMMU_TR_REQ_CTL_GO_BUSY;
+    qtest_writeq(state->qts,
+                 state->iommu_base + RISCV_IOMMU_REG_TR_REQ_CTL, request);
+
+    request = qtest_readq(state->qts,
+                          state->iommu_base + RISCV_IOMMU_REG_TR_REQ_CTL);
+    g_assert_cmpuint(request & RISCV_IOMMU_TR_REQ_CTL_GO_BUSY, ==, 0);
+
+    return qtest_readq(state->qts,
+                       state->iommu_base + RISCV_IOMMU_REG_TR_RESPONSE);
+}
+
+static void test_riscv_iommu_dbg(gconstpointer data)
+{
+    const RiscvIommuDbgTest *cfg = data;
+    RiscvIommuTestState state = { 0 };
+    uint64_t iova = QRIOMMU_IOVA & ~(DBG_PAGE_SIZE - 1);
+    uint64_t s_pa = cfg->pa;
+    uint64_t page_size = cfg->mode == QRIOMMU_TM_G_STAGE_ONLY ?
+                         cfg->g_page_size : cfg->s_page_size;
+    uint64_t response;
+
+    if (!riscv_iommu_test_setup(&state)) {
+        return;
+    }
+
+    riscv_iommu_check(state.qts, state.iommu_base, cfg->mode);
+    qriommu_build_translation(state.qts, cfg->mode, state.testdev->devfn);
+
+    if (cfg->mode == QRIOMMU_TM_NESTED) {
+        uint64_t g_l1_pa = QRIOMMU_SPACE_OFFS + QRIOMMU_G_L0_PTE_VAL;
+        uint64_t g_l2_pa = QRIOMMU_SPACE_OFFS + QRIOMMU_G_L1_PTE_VAL;
+        uint64_t offset = iova & (DBG_SUPERPAGE_SIZE - 1);
+        uint64_t gpa = DBG_NESTED_GPA + offset;
+        uint64_t pte_addr;
+        uint64_t pte;
+
+        /* Map all S-stage page tables through one 2 MiB G-stage leaf. */
+        riscv_iommu_dbg_map_leaf(state.qts, g_l1_pa, g_l2_pa, 0,
+                                 QRIOMMU_SPACE_OFFS, DBG_SUPERPAGE_SIZE);
+
+        if (cfg->g_page_size == DBG_PAGE_SIZE) {
+            pte_addr = g_l1_pa + (((gpa >> 21) & 0x1ff) * sizeof(uint64_t));
+            pte = ((g_l2_pa >> 12) << 10) | QRIOMMU_NON_LEAF_PTE_MASK;
+            qtest_writeq(state.qts, pte_addr, pte);
+        }
+        riscv_iommu_dbg_map_leaf(state.qts, g_l1_pa, g_l2_pa, gpa,
+                                 cfg->pa + (offset & ~(cfg->g_page_size - 1)),
+                                 cfg->g_page_size);
+        s_pa = gpa & ~(cfg->s_page_size - 1);
+        page_size = MIN(page_size, cfg->g_page_size);
+    }
+
+    if (cfg->mode == QRIOMMU_TM_G_STAGE_ONLY) {
+        riscv_iommu_dbg_map_leaf(state.qts,
+                                 QRIOMMU_SPACE_OFFS + QRIOMMU_G_L0_PTE_VAL,
+                                 QRIOMMU_SPACE_OFFS + QRIOMMU_G_L1_PTE_VAL,
+                                 iova, cfg->pa, cfg->g_page_size);
+    } else {
+        riscv_iommu_dbg_map_leaf(state.qts,
+                                 QRIOMMU_SPACE_OFFS + QRIOMMU_L0_PTE_VAL,
+                                 QRIOMMU_SPACE_OFFS + QRIOMMU_L1_PTE_VAL,
+                                 iova, s_pa, cfg->s_page_size);
+    }
+    qriommu_program_regs(state.qts, state.iommu_base);
+
+    /*
+     * The specification permits reporting a smaller range. These tests
+     * verify QEMU's choice to report the effective translation range.
+     */
+    response = riscv_iommu_dbg_translate(&state, iova);
+    g_assert_cmphex(response, ==, cfg->expected_response);
+
+    if (page_size > DBG_PAGE_SIZE) {
+        /* Check the first and last pages, in addition to the interior. */
+        iova &= ~(page_size - 1);
+        response = riscv_iommu_dbg_translate(&state, iova);
+        g_assert_cmphex(response, ==, cfg->expected_response);
+        response = riscv_iommu_dbg_translate(&state,
+                                            iova + page_size - DBG_PAGE_SIZE);
+        g_assert_cmphex(response, ==, cfg->expected_response);
+    }
+
+    riscv_iommu_test_teardown(&state);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -275,5 +462,11 @@ int main(int argc, char **argv)
                    test_riscv_iommu_g_stage_only);
     qtest_add_func("/iommu-testdev/translation/ns-nested",
                    test_riscv_iommu_nested);
+    for (unsigned i = 0; i < G_N_ELEMENTS(debug_tests); i++) {
+        g_autofree char *path = g_strdup_printf("/iommu-testdev/debug/%s",
+                                               debug_tests[i].name);
+
+        qtest_add_data_func(path, &debug_tests[i], test_riscv_iommu_dbg);
+    }
     return g_test_run();
 }
-- 
2.43.0


