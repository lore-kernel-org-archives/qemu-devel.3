Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2CC606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 06:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Vaw+aNLO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJmk4-00020U-HA; Thu, 22 Oct 2026 02:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1xJmjm-0001z6-PE
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 02:57:19 -0400
Received: from mail-pj2-x0b.google.com ([2607:f8b0:4864:39::b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1xJmji-0005Uf-1f
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 02:57:16 -0400
Received: by mail-pj2-x0b.google.com with SMTP id
 98e67ed59e1d1-3ad6011ecebso394067a91.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 23:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792652231; x=1793257031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uaZ92pSw4E8Hk4k2weVirTCg0rZzmsr2yzkfmVPAnMw=;
 b=Vaw+aNLOQ7TpstZAPzIcOq3he6d/E1HMg23TUQ1UaMFNt7mCr6kDKzolaIKKGJ9AEw
 obHpMS2e+58HXeu48yH1Jvr1Pu5vJfRQp33Ce/M75zRO+4jmkZrhuZVorrYIJRH56PB9
 owBcsbVvKOHtZ58jFm5VCjrXnmB/NufBN+bC+U4E9HKzfv+toY+BK64lD83BKoReuSUB
 2zEIu11dVWHmBq+Ugu/hEYLDfsOQFnLy4dO/MnPMvBr72M5A0i8pcSjfRZ/VcvK6rHwZ
 j0pnLvGfurvNTWaI6f9iN2Wr7dZ+YQUXsftE6rtw3AA6rFuiWm23tnyftD/ADSlCrSz3
 ixog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792652231; x=1793257031;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uaZ92pSw4E8Hk4k2weVirTCg0rZzmsr2yzkfmVPAnMw=;
 b=CSJbSnyFimd8jpDJpInQ5DcEWTxYLT4UNwEgvxa0MgzfN2EVK+lFQGA72/sYGnl7T9
 mrMrN4CLQ54EUJISr5aSFZJle4z9GQhWbYjA7EO2BlG/J3/Mxy9cSH2IFyDuU42N1rzS
 5Bsjv1Xi9M/JZU8dleL9dCSUEY7ZJldaMu6l3kOU0CF7FFBWKsLZi86mUMPBm65T9gVz
 LhXtZQD2UKyIMAo9nMHyEfFOqfpCmWKGIJEWn9Hs19Oq2BEuMNhRnSOoqGOsnOOuxNfg
 qWTnaBW328bym+ay1EP2qYn0G6yVcPXsMFplBoXCp9LHCJza2Zk2+Btgow2jZ4Sjmv1S
 XuaQ==
X-Gm-Message-State: AFq9FYLx65fHX6yClPN+qgT7ESTHTrZ2wcfN9zL0U9QahFcjvYgJvc0+
 b9WKOUZbGcXHkDZX6Wrt7vyp0B8VApXhj+3me8usjenuZmv5YiEZ1b67is8t2EUZqhu3fQ==
X-Gm-Gg: AYBFou1LLYGbStWsCJcCIPbclc/10bhj7Elo75jOGirXHBupX7oL/5gVu3XLFUCjEIJ
 AQLDoHFT5IBe5YJy5yCbEwEiVONTr/W6rIRQ0gm0lNMF5hB+03Lt0U6gSU6OK5L59O20NNxaoLb
 1A8wqW0DvT47Z2KihWPJQpJEbRthNQGeemtohcjNW2UMlr0ouWkDPPrpNogszuheu8QKqs7vft5
 XFST5ptfPmvkUSc6n4mSWWGglvY0jmekjqP+4Wih17L/DoJfq69i1hDjt+bQlQCg9joI8D76jp0
 nEzqrKIkbS4LsSVHYOVnDoFJKCGzDLU49GtwRqBE9FZVVc+gLBIwmiU0M+wWLrE2Rq/ceAlJoWW
 bsCZFXphwGZ/zZVqdNvSk6iQ4A0BxZzIvIsAXk4zyT8DgW17goWUN02EjV9xtjNyevuSa6uNCDL
 P8hvyP7h2bGhDW3rGNTZ4KSn8go1ODg56lNRJYVoreFlyVDqQTadEAT9ACTSn0JbDvpko+RITpr
 nphmVrXEiYT0emtdlQg1Gmd3NBlsFIgDPzfh0E2/EXgQplFMhkzI8758WwApxcgN23CS20MkH3P
 hgy3pI5p7w==
X-Received: by 2002:a17:90b:3ec5:b0:3ab:e588:c288 with SMTP id
 98e67ed59e1d1-3ad86e9e4cdmr3907851a91.11.1792652230429; 
 Wed, 21 Oct 2026 23:57:10 -0700 (PDT)
Received: from Dell-WorkStation.localdomain ([191.96.240.159])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad85fbee3asm3065154a91.3.2026.10.21.23.57.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 23:57:09 -0700 (PDT)
From: Zephyr Li <fritchleybohrer@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, daniel.barboza@oss.qualcomm.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com, Zephyr Li <fritchleybohrer@gmail.com>
Subject: [PATCH v2] hw/riscv/riscv-iommu: encode debug translation ranges
Date: Thu, 22 Oct 2026 14:56:47 +0800
Message-ID: <20261022065647.67150-1-fritchleybohrer@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
Changes in v2:
- Regenerate the patch from the source tree to correct malformed hunk metadata.
- No functional changes.

---
 hw/riscv/riscv-iommu.c         |  14 ++-
 tests/qtest/iommu-riscv-test.c | 193 +++++++++++++++++++++++++++++++++
 2 files changed, 206 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 323a041b4a..67d8456b9d 100644
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
index 2638024891..1cd753c4f2 100644
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
+     * The spec permits reporting a smaller range. These tests check QEMU's
+     * choice to report the effective range returned by an uncached walk.
+     * No DMA precedes these requests, and debug requests do not fill the IOTLB.
+     */
+    response = riscv_iommu_dbg_translate(&state, iova);
+    g_assert_cmphex(response, ==, cfg->expected_response);
+
+    if (page_size > DBG_PAGE_SIZE) {
+        /* Check both ends as well as the interior of the reported range. */
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


