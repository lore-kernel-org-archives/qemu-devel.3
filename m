Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F2B0C2D0D1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 20:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLqAF-0005HK-UZ; Mon, 24 Jun 2024 16:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sLqAD-0005FS-Vr
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 16:19:46 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sLqAA-0003kU-Hj
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 16:19:44 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7065a2f4573so2238916b3a.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 13:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1719260381; x=1719865181; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jnKN6sLVVkmJBmqU5qo9+R/nDLWgu5fHlhyvLTQH7/Q=;
 b=meylzZ9NEAnhcQBMwwR7nQnl3K3yLQHKlUVgS4QS3CbqAXf4+6TxLvQT6yBtG/kKwe
 pwpfQiN0n4zKep1OnqBfAMJBEV55+wZyhlWgJDJkYBJHiZwl7m58HZZuBE/scJyXmYJl
 YXJmOcnGElEhJ4goc2OcRbI8goOqFQjOj4VIwI1w0rTb4uTfO8hQPniBEgh6QLCytjuJ
 uSsddEwYWW6NyrcB9ZETbEirN8sNgJbXb0/vbLOmbDB7nldaHLJOnCAL1XQ8yo9IWVBi
 Z0LuWdQAmvOEFcFr+kNHPzZyPJVPbOXhE8HZGzRj9DbeFFXngBvsepI+6bkCWWyHYys9
 g1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719260381; x=1719865181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jnKN6sLVVkmJBmqU5qo9+R/nDLWgu5fHlhyvLTQH7/Q=;
 b=iPzGDwZdfB0rKdOzk81NwMYh1cybGsme8hZ74hMzZxb2gCL5+876FWksXjqgl1LQce
 7gwEFQ4jpSqXS3msYgowtJ4vf2QOYIPi9+w2SAiDHeueIm5nKEpYa6gIWRwmG2OpB8Wl
 +Eu3LNo6Olv2MGbQxOoMZUOWHnm/FvfPO55UhyuWCxiw3BtsCHKXbcq72e+Yd67G1v2e
 Ms0Ks75FWO+8Im5pjJ5bnBUkIZ8sn8Nf00lHmH//Y/XT4DmaF9E5YCH1VDT/GAP2lU6r
 8A9RlqpUao6JeP9ZsiA9tiQMxh4xJjsWBQxA5isKJe7LIGGPVhl1ucj+CIh8RnNUpjmJ
 YgCg==
X-Gm-Message-State: AOJu0YyhhhTS7rsjtmi2cOqy2/D8GAR564GAWY9sRiXBEITRpdb68PRN
 AMC4XZ1gxb89DmUbfmOicb71O+57uL1rAEWIIINKHLU/ndhbwXKvvvzR6MR1GKUQGq52Epxg8dy
 Y
X-Google-Smtp-Source: AGHT+IELpCdW7n0bbXjX+SMTzHt4V3z2mM82aTRWoBzjqc3mZVM01d7Z+8yGl4otBFkJEiRDgtmruw==
X-Received: by 2002:a05:6a00:2e09:b0:705:98e7:ce6b with SMTP id
 d2e1a72fcca58-706745d2c0cmr5379865b3a.20.1719260380788; 
 Mon, 24 Jun 2024 13:19:40 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 ([2804:7f0:bcc0:1aea:63a7:288e:eb77:fe54])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70688f2d76bsm1927091b3a.41.2024.06.24.13.19.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 13:19:40 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, tjeznach@rivosinc.com, frank.chang@sifive.com,
 jason.chien@sifive.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 13/14] qtest/riscv-iommu-test: add init queues test
Date: Mon, 24 Jun 2024 17:18:23 -0300
Message-ID: <20240624201825.1054980-14-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240624201825.1054980-1-dbarboza@ventanamicro.com>
References: <20240624201825.1054980-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x436.google.com
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
---
 tests/qtest/libqos/riscv-iommu.h |  29 +++++++
 tests/qtest/riscv-iommu-test.c   | 141 +++++++++++++++++++++++++++++++
 2 files changed, 170 insertions(+)

diff --git a/tests/qtest/libqos/riscv-iommu.h b/tests/qtest/libqos/riscv-iommu.h
index d123efb41f..c62ddedbac 100644
--- a/tests/qtest/libqos/riscv-iommu.h
+++ b/tests/qtest/libqos/riscv-iommu.h
@@ -62,6 +62,35 @@
 
 #define RISCV_IOMMU_REG_IPSR            0x0054
 
+#define RISCV_IOMMU_REG_IVEC            0x02F8
+#define RISCV_IOMMU_REG_IVEC_CIV        GENMASK_ULL(3, 0)
+#define RISCV_IOMMU_REG_IVEC_FIV        GENMASK_ULL(7, 4)
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
index 7f0dbd0211..9e2afcb4b9 100644
--- a/tests/qtest/riscv-iommu-test.c
+++ b/tests/qtest/riscv-iommu-test.c
@@ -33,6 +33,20 @@ static uint64_t riscv_iommu_read_reg64(QRISCVIOMMU *r_iommu, int reg_offset)
     return reg;
 }
 
+static void riscv_iommu_write_reg32(QRISCVIOMMU *r_iommu, int reg_offset,
+                                    uint32_t val)
+{
+    qpci_memwrite(&r_iommu->dev, r_iommu->reg_bar, reg_offset,
+                  &val, sizeof(val));
+}
+
+static void riscv_iommu_write_reg64(QRISCVIOMMU *r_iommu, int reg_offset,
+                                    uint64_t val)
+{
+    qpci_memwrite(&r_iommu->dev, r_iommu->reg_bar, reg_offset,
+                  &val, sizeof(val));
+}
+
 static void test_pci_config(void *obj, void *data, QGuestAllocator *t_alloc)
 {
     QRISCVIOMMU *r_iommu = obj;
@@ -84,10 +98,137 @@ static void test_reg_reset(void *obj, void *data, QGuestAllocator *t_alloc)
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
+    int k;
+
+    reg64 = riscv_iommu_read_reg64(r_iommu, RISCV_IOMMU_REG_CAP);
+    g_assert_cmpuint(reg64 & RISCV_IOMMU_CAP_VERSION, ==, 0x10);
+
+    /*
+     * Program the command queue. Write 0xF to civ, assert that
+     * we have 4 writable bits (k = 4). The amount of entries N in the
+     * command queue is 2^4 = 16. We need to alloc a N*16 bytes
+     * buffer and use it to set cqb.
+     */
+    riscv_iommu_write_reg32(r_iommu, RISCV_IOMMU_REG_IVEC,
+                            0xFFFF & RISCV_IOMMU_REG_IVEC_CIV);
+    reg = riscv_iommu_read_reg32(r_iommu, RISCV_IOMMU_REG_IVEC);
+    g_assert_cmpuint(reg & RISCV_IOMMU_REG_IVEC_CIV, ==, 0xF);
+
+    q_addr = guest_alloc(t_alloc, 16 * 16);
+    reg64 = 0;
+    k = 4;
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
+     * Program the fault queue. Similar to the above:
+     * - Write 0xF to fiv, assert that we have 4 writable bits (k = 4)
+     * - Alloc a 16*32 bytes (instead of 16*16) buffer and use it to set
+     * fqb
+     */
+    riscv_iommu_write_reg32(r_iommu, RISCV_IOMMU_REG_IVEC,
+                            0xFFFF & RISCV_IOMMU_REG_IVEC_FIV);
+    reg = riscv_iommu_read_reg32(r_iommu, RISCV_IOMMU_REG_IVEC);
+    g_assert_cmpuint(reg & RISCV_IOMMU_REG_IVEC_FIV, ==, 0xF0);
+
+    q_addr = guest_alloc(t_alloc, 16 * 32);
+    reg64 = 0;
+    k = 4;
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
+     * Program the page-request queue:
+     - Write 0xF to piv, assert that we have 4 writable bits (k = 4)
+     - Alloc a 16*16 bytes buffer and use it to set pqb.
+     */
+    riscv_iommu_write_reg32(r_iommu, RISCV_IOMMU_REG_IVEC,
+                            0xFFFF & RISCV_IOMMU_REG_IVEC_PIV);
+    reg = riscv_iommu_read_reg32(r_iommu, RISCV_IOMMU_REG_IVEC);
+    g_assert_cmpuint(reg & RISCV_IOMMU_REG_IVEC_PIV, ==, 0xF000);
+
+    q_addr = guest_alloc(t_alloc, 16 * 16);
+    reg64 = 0;
+    k = 4;
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


