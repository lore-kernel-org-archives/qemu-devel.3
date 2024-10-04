Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01933CF884E
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:00:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swkh1-0007U3-Qh; Fri, 04 Oct 2024 11:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1swkgz-0007TF-PA
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 11:58:10 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1swkgy-0000tA-08
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 11:58:09 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-20ba8d92af9so17619695ad.3
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 08:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1728057486; x=1728662286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S8OV9slWCqGfaCLWfWBNZMKpoiP4jDzulY/saMCxV/s=;
 b=F+h+d90VzLL/Y2c+aci6b5G37SfOTaae8TFxykWL0xn3HdNM6EHsxaBogumgT7FD78
 gfT4DuPu4R4IWRVahL+BQZbQiswapnJJg9i5rtGeawXsL6tPgEbct3KkYYUE/QPUBt/X
 MHEZNbD7iC9PqDDMi0mMYLsseWwAptPRJXINDKJeNPS+zg0jA99iaBnrr7a2eSVJECDI
 HQKLfFPCEUpV4L+h8Ih+A/1bx+9ngbWKCNAZ4AokjxLVITlrxR/o8YHg2l4iJnLrsXh7
 aq5wo5/3Q35AHumOLKulYqBfAfX7bJTXmshVTsaWnTBJqZldmBJnUZ35o6kJrriddfUm
 5SvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728057486; x=1728662286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S8OV9slWCqGfaCLWfWBNZMKpoiP4jDzulY/saMCxV/s=;
 b=YqnodFetfNT3bFq00oolkoeaUjR6O5EFZzP8V0RRaxk10yI+v4MgDPjqiGwt1peBuS
 IZLgJyu1pQWtt/sQ8nJjXjdv1RHT+AlRbbsC7QPOZjyKJLI2bADiP75QQXLpYKPLzrvz
 5/vp5bV0UaSgfjhrKfdlr2JrZZZrJ/T3ExMXZWv5W4vziZVCy7IAzk/64CCPXTa6OkmX
 hiXb1qMa9Kz0mx7FGUdxQJ5Ht82w4K0Ay6HfJmwTZ1zwKlqUIBbnUpHYQ7LbBZNV0c2s
 nGUGAkb16vvRQUSwsQOhX4qxusXDQo5e0aeM1Svi+QGluX/cxX4+i5CXzm5GYP7en16H
 C2bA==
X-Gm-Message-State: AOJu0Yz32iMJtWQtY/vxQfXQTffmFq2NhxuAPmcrOWJXXO9kGjkdSKqw
 yBmg8BkPpQUdDfeV2uRbkVotBVB8yPT/GlEXK+eh/wM2HgwIPctOMclaT7lsPBLN2rMQntSMFsr
 g
X-Google-Smtp-Source: AGHT+IFqhN3SuDnNCRE/AfWWtJSSZSF/hvPpeMMM9oLXTuCKgmy2wDckdKsFD9mZJmUnwEnPr/vMBg==
X-Received: by 2002:a17:903:244d:b0:20b:8510:bf4d with SMTP id
 d9443c01a7336-20bfde55570mr57279255ad.6.1728057486360; 
 Fri, 04 Oct 2024 08:58:06 -0700 (PDT)
Received: from grind.. (200-206-229-93.dsl.telesp.net.br. [200.206.229.93])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c139306cfsm107635ad.170.2024.10.04.08.58.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 08:58:06 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v9 11/12] qtest/riscv-iommu-test: add init queues test
Date: Fri,  4 Oct 2024 12:57:18 -0300
Message-ID: <20241004155721.2154626-12-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241004155721.2154626-1-dbarboza@ventanamicro.com>
References: <20241004155721.2154626-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add an additional test to further exercise the IOMMU where we attempt to
initialize the command, fault and page-request queues.

These steps are taken from chapter 6.2 of the RISC-V IOMMU spec,
"Guidelines for initialization". It emulates what we expect from the
software/OS when initializing the IOMMU.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/qtest/libqos/riscv-iommu.h |  30 ++++++++
 tests/qtest/riscv-iommu-test.c   | 125 +++++++++++++++++++++++++++++++
 2 files changed, 155 insertions(+)

diff --git a/tests/qtest/libqos/riscv-iommu.h b/tests/qtest/libqos/riscv-iommu.h
index d123efb41f..318db13799 100644
--- a/tests/qtest/libqos/riscv-iommu.h
+++ b/tests/qtest/libqos/riscv-iommu.h
@@ -62,6 +62,36 @@
 
 #define RISCV_IOMMU_REG_IPSR            0x0054
 
+#define RISCV_IOMMU_REG_IVEC            0x02F8
+#define RISCV_IOMMU_REG_IVEC_CIV        GENMASK_ULL(3, 0)
+#define RISCV_IOMMU_REG_IVEC_FIV        GENMASK_ULL(7, 4)
+#define RISCV_IOMMU_REG_IVEC_PMIV       GENMASK_ULL(11, 8)
+#define RISCV_IOMMU_REG_IVEC_PIV        GENMASK_ULL(15, 12)
+
+#define RISCV_IOMMU_REG_CQB             0x0018
+#define RISCV_IOMMU_CQB_PPN_START       10
+#define RISCV_IOMMU_CQB_PPN_LEN         44
+#define RISCV_IOMMU_CQB_LOG2SZ_START    0
+#define RISCV_IOMMU_CQB_LOG2SZ_LEN      5
+
+#define RISCV_IOMMU_REG_CQT             0x0024
+
+#define RISCV_IOMMU_REG_FQB             0x0028
+#define RISCV_IOMMU_FQB_PPN_START       10
+#define RISCV_IOMMU_FQB_PPN_LEN         44
+#define RISCV_IOMMU_FQB_LOG2SZ_START    0
+#define RISCV_IOMMU_FQB_LOG2SZ_LEN      5
+
+#define RISCV_IOMMU_REG_FQT             0x0034
+
+#define RISCV_IOMMU_REG_PQB             0x0038
+#define RISCV_IOMMU_PQB_PPN_START       10
+#define RISCV_IOMMU_PQB_PPN_LEN         44
+#define RISCV_IOMMU_PQB_LOG2SZ_START    0
+#define RISCV_IOMMU_PQB_LOG2SZ_LEN      5
+
+#define RISCV_IOMMU_REG_PQT             0x0044
+
 typedef struct QRISCVIOMMU {
     QOSGraphObject obj;
     QPCIDevice dev;
diff --git a/tests/qtest/riscv-iommu-test.c b/tests/qtest/riscv-iommu-test.c
index be72cf3d74..df0c7813ec 100644
--- a/tests/qtest/riscv-iommu-test.c
+++ b/tests/qtest/riscv-iommu-test.c
@@ -25,6 +25,18 @@ static uint64_t riscv_iommu_read_reg64(QRISCVIOMMU *r_iommu, int reg_offset)
     return qpci_io_readq(&r_iommu->dev, r_iommu->reg_bar, reg_offset);
 }
 
+static void riscv_iommu_write_reg32(QRISCVIOMMU *r_iommu, int reg_offset,
+                                    uint32_t val)
+{
+    qpci_io_writel(&r_iommu->dev, r_iommu->reg_bar, reg_offset, val);
+}
+
+static void riscv_iommu_write_reg64(QRISCVIOMMU *r_iommu, int reg_offset,
+                                    uint64_t val)
+{
+    qpci_io_writeq(&r_iommu->dev, r_iommu->reg_bar, reg_offset, val);
+}
+
 static void test_pci_config(void *obj, void *data, QGuestAllocator *t_alloc)
 {
     QRISCVIOMMU *r_iommu = obj;
@@ -76,10 +88,123 @@ static void test_reg_reset(void *obj, void *data, QGuestAllocator *t_alloc)
     g_assert_cmpuint(reg, ==, 0);
 }
 
+/*
+ * Common timeout-based poll for CQCSR, FQCSR and PQCSR. All
+ * their ON bits are mapped as RISCV_IOMMU_QUEUE_ACTIVE (16),
+ */
+static void qtest_wait_for_queue_active(QRISCVIOMMU *r_iommu,
+                                        uint32_t queue_csr)
+{
+    QTestState *qts = global_qtest;
+    guint64 timeout_us = 2 * 1000 * 1000;
+    gint64 start_time = g_get_monotonic_time();
+    uint32_t reg;
+
+    for (;;) {
+        qtest_clock_step(qts, 100);
+
+        reg = riscv_iommu_read_reg32(r_iommu, queue_csr);
+        if (reg & RISCV_IOMMU_QUEUE_ACTIVE) {
+            break;
+        }
+        g_assert(g_get_monotonic_time() - start_time <= timeout_us);
+    }
+}
+
+/*
+ * Goes through the queue activation procedures of chapter 6.2,
+ * "Guidelines for initialization", of the RISCV-IOMMU spec.
+ */
+static void test_iommu_init_queues(void *obj, void *data,
+                                   QGuestAllocator *t_alloc)
+{
+    QRISCVIOMMU *r_iommu = obj;
+    uint64_t reg64, q_addr;
+    uint32_t reg;
+    int k = 2;
+
+    reg64 = riscv_iommu_read_reg64(r_iommu, RISCV_IOMMU_REG_CAP);
+    g_assert_cmpuint(reg64 & RISCV_IOMMU_CAP_VERSION, ==, 0x10);
+
+    /*
+     * Program the command queue. Write 0xF to civ, fiv, pmiv and
+     * piv. With the current PCI device impl we expect 2 writable
+     * bits for each (k = 2) since we have N = 4 total vectors (2^k).
+     */
+    riscv_iommu_write_reg32(r_iommu, RISCV_IOMMU_REG_IVEC, 0xFFFF);
+    reg = riscv_iommu_read_reg32(r_iommu, RISCV_IOMMU_REG_IVEC);
+    g_assert_cmpuint(reg & RISCV_IOMMU_REG_IVEC_CIV, ==, 0x3);
+    g_assert_cmpuint(reg & RISCV_IOMMU_REG_IVEC_FIV, ==, 0x30);
+    g_assert_cmpuint(reg & RISCV_IOMMU_REG_IVEC_PMIV, ==, 0x300);
+    g_assert_cmpuint(reg & RISCV_IOMMU_REG_IVEC_PIV, ==, 0x3000);
+
+    /* Alloc a 4*16 bytes buffer and use it to set cqb */
+    q_addr = guest_alloc(t_alloc, 4 * 16);
+    reg64 = 0;
+    deposit64(reg64, RISCV_IOMMU_CQB_PPN_START,
+              RISCV_IOMMU_CQB_PPN_LEN, q_addr);
+    deposit64(reg64, RISCV_IOMMU_CQB_LOG2SZ_START,
+              RISCV_IOMMU_CQB_LOG2SZ_LEN, k - 1);
+    riscv_iommu_write_reg64(r_iommu, RISCV_IOMMU_REG_CQB, reg64);
+
+    /* cqt = 0, cqcsr.cqen = 1, poll cqcsr.cqon until it reads 1 */
+    riscv_iommu_write_reg32(r_iommu, RISCV_IOMMU_REG_CQT, 0);
+
+    reg = riscv_iommu_read_reg32(r_iommu, RISCV_IOMMU_REG_CQCSR);
+    reg |= RISCV_IOMMU_CQCSR_CQEN;
+    riscv_iommu_write_reg32(r_iommu, RISCV_IOMMU_REG_CQCSR, reg);
+
+    qtest_wait_for_queue_active(r_iommu, RISCV_IOMMU_REG_CQCSR);
+
+    /*
+     * Program the fault queue. Alloc a 4*32 bytes (instead of 4*16)
+     * buffer and use it to set fqb.
+     */
+    q_addr = guest_alloc(t_alloc, 4 * 32);
+    reg64 = 0;
+    deposit64(reg64, RISCV_IOMMU_FQB_PPN_START,
+              RISCV_IOMMU_FQB_PPN_LEN, q_addr);
+    deposit64(reg64, RISCV_IOMMU_FQB_LOG2SZ_START,
+              RISCV_IOMMU_FQB_LOG2SZ_LEN, k - 1);
+    riscv_iommu_write_reg64(r_iommu, RISCV_IOMMU_REG_FQB, reg64);
+
+    /* fqt = 0, fqcsr.fqen = 1, poll fqcsr.fqon until it reads 1 */
+    riscv_iommu_write_reg32(r_iommu, RISCV_IOMMU_REG_FQT, 0);
+
+    reg = riscv_iommu_read_reg32(r_iommu, RISCV_IOMMU_REG_FQCSR);
+    reg |= RISCV_IOMMU_FQCSR_FQEN;
+    riscv_iommu_write_reg32(r_iommu, RISCV_IOMMU_REG_FQCSR, reg);
+
+    qtest_wait_for_queue_active(r_iommu, RISCV_IOMMU_REG_FQCSR);
+
+    /*
+     * Program the page-request queue. Alloc a 4*16 bytes buffer
+     * and use it to set pqb.
+     */
+    q_addr = guest_alloc(t_alloc, 4 * 16);
+    reg64 = 0;
+    deposit64(reg64, RISCV_IOMMU_PQB_PPN_START,
+              RISCV_IOMMU_PQB_PPN_LEN, q_addr);
+    deposit64(reg64, RISCV_IOMMU_PQB_LOG2SZ_START,
+              RISCV_IOMMU_PQB_LOG2SZ_LEN, k - 1);
+    riscv_iommu_write_reg64(r_iommu, RISCV_IOMMU_REG_PQB, reg64);
+
+    /* pqt = 0, pqcsr.pqen = 1, poll pqcsr.pqon until it reads 1 */
+    riscv_iommu_write_reg32(r_iommu, RISCV_IOMMU_REG_PQT, 0);
+
+    reg = riscv_iommu_read_reg32(r_iommu, RISCV_IOMMU_REG_PQCSR);
+    reg |= RISCV_IOMMU_PQCSR_PQEN;
+    riscv_iommu_write_reg32(r_iommu, RISCV_IOMMU_REG_PQCSR, reg);
+
+    qtest_wait_for_queue_active(r_iommu, RISCV_IOMMU_REG_PQCSR);
+}
+
 static void register_riscv_iommu_test(void)
 {
     qos_add_test("pci_config", "riscv-iommu-pci", test_pci_config, NULL);
     qos_add_test("reg_reset", "riscv-iommu-pci", test_reg_reset, NULL);
+    qos_add_test("iommu_init_queues", "riscv-iommu-pci",
+                 test_iommu_init_queues, NULL);
 }
 
 libqos_init(register_riscv_iommu_test);
-- 
2.45.2


