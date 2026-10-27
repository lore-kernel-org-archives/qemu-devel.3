Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8450C606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 06:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FoOyU8IQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLaiA-0005DY-8F; Tue, 27 Oct 2026 02:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLahA-0003hR-CN
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:30:07 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLah2-0008F9-Oc
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:30:00 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3adac5b29ebso2145750a91.2
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 23:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793082587; x=1793687387; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iJc2AfA/PK6QvLxArG3qJYjX0wm1vNTTOEZW0/mo0ys=;
 b=FoOyU8IQyfh/XwCcTLB0R8iwlYV2ZQ6F3el2mD8GbAIy0MStFznDYCsY4QBX0fqD4+
 Yy5BmSZ+rN+z6v6dMnb4X/K6k1SM4y1GbZL9Z1yCJ6ebwuhaUNntYlwyDE7LZ6yaQart
 5NwZnJ8R+B5kcsLZDMUtXFZYRoJ7sGeBMV+ZUb7ASmdASWpdI9wylCo4UhGasn2bH+Ln
 U2T/mXhGGTjAkLynPZLfRv1P5d0AogtHuxwqIt7EX1VrZwPiQNEWHFwvqrwT1OiNmjGs
 DnHwPXXZV3q3bPa/+9+Ely9aCr/zXDH706hYsiQzxSsv/m+B88MMehZgFWS1ABpDJWXI
 aEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793082587; x=1793687387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iJc2AfA/PK6QvLxArG3qJYjX0wm1vNTTOEZW0/mo0ys=;
 b=wpjhf31b3zMaUT14RGCES5EUi779y9zsDV395LXtYyj8p+x84S4s3I4PFd31kJSZSA
 ZPa3tZv35XoUn8r8QYAawqUrjAuoMrjpxNJoyFEhPZmVW6YiLPfzN6+M/63erYtUu7st
 zlRhTzJ2M0Af19MVOZ56zZxQuzTr8cb1bUHzRDZ7COKjBcH9R5ycwcZlM830v9XVnZ4q
 MMPaazMRmNfHYWFXFKJApI6mNKF4/uSt61Mo6quS/9JF/cgXVEXdkpHQXekax6IL3HIW
 B3CN7eRKoh8lV7k9v2+HLWLXSixwPZpXijSIgANMoOt/+Pzlch//oY7wwBo9/rx6bhCt
 c9sQ==
X-Gm-Message-State: AFq9FYK8Mt0/MFNcB5IGdpn8g5MxZwjVBuN2fad0Ww8DN72zOVpL+dPa
 P81OzATFlvZAxEUjFRPseRKE3FLLaZ4FIYNkImtj00EtAQlOSgwbwRvOqBMJyg==
X-Gm-Gg: AYBFou38b4WjScb1SU8hA6j+rQmQ5o6pUMtzIhDa6+H4obGYmq619jJQ9MbBCnJh4yL
 LQOU/aUttAMdCwCSzwArM09EPQ8DhnjbXO7Gq3lvxVEVG82xC6EGltuZbt4zcqzdyt9dYf59oEM
 KDmKXS613n1SQxXsq5TRmmABT6e/V3rgIMjUPwyHzTotqsx+2htvWCwA5o5Z/8iJL4b4c3t+h+G
 b1hJ74DyRqRYxjd8wsx4wVxmsdG6ELRMrHQndomkplmnkkRt5LZ+JVWPd0rYrdkUPodKQo881Pm
 g43oLPQ1eVegOMsZ9LvQKhD5IdhWA26ZQqsVbMJOJjxBepO8bZgrUsQmuh7CgDaMWWoSPk4vA9u
 nHzRduAPYbyoLf7RYz60Xw41obTcNPqxxDVUwnRKS1Ixugkwo8NQKnzJKjvxWRuYXeSWwzE1f48
 KKGhHQO8aCr82LvfASjuuqfUkr8zintE1PQW4pZ/tL3L/V99/XHX6QknHgmZkA564SykoTMIF0N
 B2QsOwn4+L+VJyDOYbuLaje1S1bFFIxpwJnnv4qJf/s9qol5+e81SA2S1J7UzK9tYyuaGxm8uMo
 lV/IbUEqQ5lk54z93msKeXREglCjNJPqZx4NOKKZqHaWmyE=
X-Received: by 2002:a17:90b:280c:b0:3ad:870d:1bfa with SMTP id
 98e67ed59e1d1-3adead57cbfmr6904736a91.23.1793082587046; 
 Mon, 26 Oct 2026 23:29:47 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae401bf352sm2358541a91.0.2026.10.26.23.29.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 23:29:46 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Zephyr Li <fritchleybohrer@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 26/29] hw/riscv/riscv-iommu: encode debug translation ranges
Date: Tue, 27 Oct 2026 16:28:05 +1000
Message-ID: <20261027062808.1995205-27-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027062808.1995205-1-alistair.francis@wdc.com>
References: <20261027062808.1995205-1-alistair.francis@wdc.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Zephyr Li <fritchleybohrer@gmail.com>

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
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20261022065647.67150-1-fritchleybohrer@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu.c         |  14 ++-
 tests/qtest/iommu-riscv-test.c | 193 +++++++++++++++++++++++++++++++++
 2 files changed, 206 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 77b93fab5fb8..0e6970773a69 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2274,8 +2274,20 @@ static void riscv_iommu_process_dbg(RISCVIOMMUState *s)
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
index 26380248912c..1cd753c4f243 100644
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
2.55.0


