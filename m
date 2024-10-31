Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8CE2E68951
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 03:59:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MI7-0005ep-Tk; Wed, 30 Oct 2024 23:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MHt-0004Oa-9p
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:55:57 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MHr-0004Gu-G4
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:55:57 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-20e576dbc42so5440575ad.0
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 20:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730346954; x=1730951754; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vJ1IiZrJejTlgovkYIVxxs39LKTE5q0GSYZgBZj4gG4=;
 b=kNjvMA9eI+DJmY+HzA/9Rs4JZgSZSGOo2dt66dT7y/3aC0aIEw/J9yiNB/bTSwutFM
 o2LuAZC5YQk6rbqhWJQh+kD/J1J9YDccR/Np1rg4wL4yRXl+SjKdmMppJ7qS8nvMuwJQ
 EbhpTjNlGmQ7JbHCwaaKt3tjD/xG5Hjt8SQhnKyyxp+oVQLYR/tZEgfBqqXy8HzjX3pT
 UaGX+9WHgfWbf/ZuT+czqwBbrY7dwU/SVd3Nw5gvZ0ocgPo+YiSBbXm3lJaZTTxxjwxO
 yUwELui0l+AUVvBteo3xMB4u5mJvPpnbp+OINgpSIoHK42U4yDyXOPJqPrFMS4MP38Vw
 IcTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730346954; x=1730951754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vJ1IiZrJejTlgovkYIVxxs39LKTE5q0GSYZgBZj4gG4=;
 b=fQu88As9Gm3uXk2mHeU5QCYz3L2Yn87Rtz4CoE5ed5492F7dGaoBoqHiRC50yrVVnm
 zSZHoCzQy5GVXcXs51rpA63k+pKIPefMzOlR9Kh5moIjeCY2s3mlXOiV3Y+OA15tBU0X
 L5EHtP0DdxCrieG8M3G0FSUYMXUcfC3nkyRvPk0DB0Yzy8Z8ie0Uv7nbdApGEyezLikQ
 YY3nRArmJqY4ZD7XPcYY8E8t5ueDAaNS1cxGxFysZ3B5gzjs23T7tRSzEN1KSVfsoETX
 s4s7CBp5Biff+K09nzGrSiNI85usE6IZDGkVGdec+NRUByuItiUGOOmFlMgWMg1HXd1i
 EH5A==
X-Gm-Message-State: AOJu0Ywq01ZZa8ChcpeBRz1ICTdaUybsp4g5qDMX0EzDmHDCbVA0/l/R
 mqrDBnqWu/SDROJBrt/HCpqdRE6yEXNyd0tNybfip2HPt+wS/8sfbgzXTzdM
X-Google-Smtp-Source: AGHT+IEpvGdWwRnD8Yq6Yo+TKBIicuDkYdAVtaZSYRIFD/GmBC/B/NlLYlCD/XvyhS62YUVN8Rf9Wg==
X-Received: by 2002:a17:903:22c9:b0:20b:8109:2c90 with SMTP id
 d9443c01a7336-21103cd5ddemr20722815ad.61.1730346953972; 
 Wed, 30 Oct 2024 20:55:53 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21105707064sm3022795ad.70.2024.10.30.20.55.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 20:55:53 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 46/50] qtest/riscv-iommu-test: add init queues test
Date: Thu, 31 Oct 2024 13:53:14 +1000
Message-ID: <20241031035319.731906-47-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031035319.731906-1-alistair.francis@wdc.com>
References: <20241031035319.731906-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Add an additional test to further exercise the IOMMU where we attempt to
initialize the command, fault and page-request queues.

These steps are taken from chapter 6.2 of the RISC-V IOMMU spec,
"Guidelines for initialization". It emulates what we expect from the
software/OS when initializing the IOMMU.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241016204038.649340-12-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
2.47.0


