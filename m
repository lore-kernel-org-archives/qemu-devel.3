Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D5A1D26289
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 18:41:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viGeV-00010S-2a; Tue, 20 Jan 2026 13:40:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGe5-0008Q0-W4
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:40:07 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGe4-0006Ce-1R
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:40:05 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-432d28870ddso3192175f8f.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 10:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768934402; x=1769539202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=e4gxd66dOh4tOv5D7U9La3ZeijNhZLZnwQsS37ikc3o=;
 b=dwNicf36zHvi2jUwatO9z1LV89WTBQOOgQ9/eBTsGkD8cPtehR/CqFU3Vtq/NH63G/
 SLdgY614gQ4fHLYyTb5lNR0utPzpycmJKNKTTqucAlPGgE5aXX4hiA6xvybA8XjMUAah
 NKCszB2mDxfOKPQWbwuJH9bjdhmmwYB+PDWp38vLwL+dbgnF5qYbrpqKnSxxfuEaLHrP
 UnbQP6HlwGkjUErOQMLAciAt1US2bOADBVRdl1VbeuGEu44+gMbR1CSK+WF0mOdcnJqh
 DqGBKtXT6lqltZT5ebPmZ/KwJl9gdI5TeNLXzhHxKdLfjoDwRkz8rKQCQOfYhHd3RYWq
 q4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768934402; x=1769539202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=e4gxd66dOh4tOv5D7U9La3ZeijNhZLZnwQsS37ikc3o=;
 b=v3i2QiXvT331VG2TrXbZZ7FAl8UcxWDA0nvpgGuTcHDTpRxtkYEOjluSkDG+XA4vIr
 SoBtVgGzsuVALTOdtVcqKvrBSGkQnbCEXqMNxmgLkYr8wqV4gCHY5OK1DcKUtUYEuD1g
 7JRpAd48EKerIjwL+AdlpxvafIUt9jWN3fUh4eSJfW7LQNUon44bBbJUrb88Pj9O8IYn
 npOR3tBhADkyNU77mn7ZL3X23i7V6rAbbHQ/XREhCtIU0pCjGQ3aoK8jCuUYBwB4bZ5P
 bnnR8STcuT9qXkjus32xY65Ua5mavz7pwNQvpRjLEz4GpeFYB5wvlr+aRrnv5+mRl2L7
 Ah1g==
X-Gm-Message-State: AOJu0Yz+LUMOaGVNnCYNtnRTOtFPkA30SJBKyWnyElv1eAj4mny28a04
 a/KBbBRFWkXvN+9tQHL5rcYB3kpigI6ddVbQ1ltiVsSP57ESF5nK8EWn5DzA7LQmx9m1GRrRpxX
 LbW7jK6c=
X-Gm-Gg: AZuq6aI72lQSMdcRZDSE4sfW9GTFaGi/hrZZPa/rfv5C/QXF/jvqrudxJoTKT2yQj/x
 aeF1sRhcpjoEb9Z/VwVCbyA/rkB0TqaSNfZ6hng/34NZoQoD9rPcL+FnqGDoiTs3j2uC6pDxOCg
 dVW5n4pgqhO9EdHHGeUx4Phuj42+Y7PUxetZCUzAks95bECj9THMCEiwQCZFbk6uJh+bZmGesRZ
 VIQbx2cCZAKrAkQkzCkPT55ypJ+BlSFf9PcNqbIbaDIa5ncQ31iPgkVcE4OwaaKPoJ0zMGnEVGT
 56wyBDOXbjnSCXkvwbBYaMV6ZEC9o0664ydwDv4FLDIw0R+Lmcn/tjdZVtwMxRCTL2KkYjL9iMd
 wIen9R+6/CTPK9nS56UOKGvxmlQBKbtxCYn9orveJOd8VRuX2Rb4rYSE8ZibP02fQTHAWjvoaIB
 AQncW+u7R6JR7SF+m66qRb1UgVE9a2PexpDDCFsEdCJbonKlR8N0fsx35dFJVf
X-Received: by 2002:a05:6000:2910:b0:42f:b0ab:7b48 with SMTP id
 ffacd0b85a97d-43569979c52mr19861251f8f.1.1768934402016; 
 Tue, 20 Jan 2026 10:40:02 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356997e6dasm31427885f8f.32.2026.01.20.10.40.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Jan 2026 10:40:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/29] tests/qtest: Add SMMUv3 bare-metal test using
 iommu-testdev
Date: Tue, 20 Jan 2026 19:38:41 +0100
Message-ID: <20260120183902.73845-9-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120183902.73845-1-philmd@linaro.org>
References: <20260120183902.73845-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Tao Tang <tangtao1634@phytium.com.cn>

Add a qtest suite that validates ARM SMMUv3 translation without guest
firmware or OS. The tests leverage iommu-testdev to trigger DMA
operations and the qos-smmuv3 library to configure IOMMU translation
structures.

This test suite targets the virt machine and covers:
- Stage 1 only translation (VA -> PA via CD page tables)
- Stage 2 only translation (IPA -> PA via STE S2 tables)
- Nested translation (VA -> IPA -> PA, Stage 1 + Stage 2)
- Design to extended to support multiple security spaces
    (Non-Secure, Secure, Root, Realm)

Each test case follows this sequence:
1. Initialize SMMUv3 with appropriate command/event queues
2. Build translation tables (STE/CD/PTE) for the target scenario
3. Configure iommu-testdev with IOVA and DMA attributes via MMIO
4. Trigger DMA and validate successful translation
5. Verify data integrity through a deterministic write-read pattern

This bare-metal approach provides deterministic IOMMU testing with
minimal dependencies, making failures directly attributable to the SMMU
translation path.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20260119161112.3841386-9-tangtao1634@phytium.com.cn>
[PMD: Cover tests/qtest/iommu-smmuv3-test.c in MAINTAINERS]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                     |   1 +
 tests/qtest/iommu-smmuv3-test.c | 132 ++++++++++++++++++++++++++++++++
 tests/qtest/meson.build         |   3 +
 3 files changed, 136 insertions(+)
 create mode 100644 tests/qtest/iommu-smmuv3-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index dc31be033ee..1fd495ddd51 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -222,6 +222,7 @@ S: Maintained
 F: hw/arm/smmu*
 F: include/hw/arm/smmu*
 F: tests/functional/aarch64/test_smmu.py
+F: tests/qtest/iommu-smmuv3-test.c
 
 AVR TCG CPUs
 M: Michael Rolnik <mrolnik@gmail.com>
diff --git a/tests/qtest/iommu-smmuv3-test.c b/tests/qtest/iommu-smmuv3-test.c
new file mode 100644
index 00000000000..cced49a9b69
--- /dev/null
+++ b/tests/qtest/iommu-smmuv3-test.c
@@ -0,0 +1,132 @@
+/*
+ * QTest for SMMUv3 with iommu-testdev
+ *
+ * This QTest file is used to test the SMMUv3 with iommu-testdev so that we can
+ * test SMMUv3 without any guest kernel or firmware.
+ *
+ * Copyright (c) 2026 Phytium Technology
+ *
+ * Author:
+ *  Tao Tang <tangtao1634@phytium.com.cn>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "libqos/pci.h"
+#include "libqos/generic-pcihost.h"
+#include "hw/pci/pci_regs.h"
+#include "hw/misc/iommu-testdev.h"
+#include "libqos/qos-smmuv3.h"
+
+#define DMA_LEN           4
+
+static uint64_t smmuv3_expected_gpa(uint64_t iova)
+{
+    return qsmmu_space_offset(QSMMU_SPACE_NONSECURE) +
+           QSMMU_L3_PTE_VAL + (iova & 0xfff);
+}
+
+static void save_fn(QPCIDevice *dev, int devfn, void *data)
+{
+    QPCIDevice **pdev = (QPCIDevice **) data;
+
+    *pdev = dev;
+}
+
+static QPCIDevice *setup_qtest_pci_device(QTestState *qts, QGenericPCIBus *gbus,
+                                          QPCIBar *bar)
+{
+    QPCIDevice *dev = NULL;
+
+    qpci_init_generic(gbus, qts, NULL, false);
+
+    qpci_device_foreach(&gbus->bus, IOMMU_TESTDEV_VENDOR_ID,
+                        IOMMU_TESTDEV_DEVICE_ID, save_fn, &dev);
+    g_assert(dev);
+
+    qpci_device_enable(dev);
+    *bar = qpci_iomap(dev, 0, NULL);
+    g_assert_false(bar->is_io);
+
+    return dev;
+}
+
+static void run_smmuv3_translation(const QSMMUTestConfig *cfg)
+{
+    QTestState *qts;
+    QGenericPCIBus gbus;
+    QPCIDevice *dev;
+    QPCIBar bar;
+
+    if (!qtest_has_machine("virt")) {
+        g_test_skip("virt machine not available");
+        return;
+    }
+
+    /* Initialize QEMU environment for SMMU testing */
+    qts = qtest_init("-machine virt,acpi=off,gic-version=3,iommu=smmuv3 "
+                     "-smp 1 -m 512 -cpu max -net none "
+                     "-device iommu-testdev");
+
+    /* Setup and configure PCI device */
+    dev = setup_qtest_pci_device(qts, &gbus, &bar);
+    g_assert(dev);
+
+    g_test_message("### SMMUv3 translation mode=%d sec_sid=%d ###",
+                   cfg->trans_mode, cfg->sec_sid);
+    qsmmu_run_translation_case(qts, dev, bar, VIRT_SMMU_BASE, cfg);
+    qtest_quit(qts);
+}
+
+static void test_smmuv3_ns_s1_only(void)
+{
+    QSMMUTestConfig cfg = {
+        .trans_mode = QSMMU_TM_S1_ONLY,
+        .sec_sid = QSMMU_SEC_SID_NONSECURE,
+        .dma_gpa = smmuv3_expected_gpa(QSMMU_IOVA),
+        .dma_len = DMA_LEN,
+        .expected_result = 0,
+    };
+
+    run_smmuv3_translation(&cfg);
+}
+
+static void test_smmuv3_ns_s2_only(void)
+{
+    QSMMUTestConfig cfg = {
+        .trans_mode = QSMMU_TM_S2_ONLY,
+        .sec_sid = QSMMU_SEC_SID_NONSECURE,
+        .dma_gpa = smmuv3_expected_gpa(QSMMU_IOVA),
+        .dma_len = DMA_LEN,
+        .expected_result = 0,
+    };
+
+    run_smmuv3_translation(&cfg);
+}
+
+static void test_smmuv3_ns_nested(void)
+{
+    QSMMUTestConfig cfg = {
+        .trans_mode = QSMMU_TM_NESTED,
+        .sec_sid = QSMMU_SEC_SID_NONSECURE,
+        .dma_gpa = smmuv3_expected_gpa(QSMMU_IOVA),
+        .dma_len = DMA_LEN,
+        .expected_result = 0,
+    };
+
+    run_smmuv3_translation(&cfg);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    qtest_add_func("/iommu-testdev/translation/ns-s1-only",
+                   test_smmuv3_ns_s1_only);
+    qtest_add_func("/iommu-testdev/translation/ns-s2-only",
+                   test_smmuv3_ns_s2_only);
+    qtest_add_func("/iommu-testdev/translation/ns-nested",
+                   test_smmuv3_ns_nested);
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 0f053fb56de..a8b09d065f9 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -264,6 +264,9 @@ qtests_aarch64 = \
    config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
   (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed64 : []) + \
   (config_all_devices.has_key('CONFIG_NPCM8XX') ? qtests_npcm8xx : []) + \
+  (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
+   config_all_devices.has_key('CONFIG_ARM_VIRT') ?
+   ['iommu-smmuv3-test'] : []) + \
   qtests_cxl +                                                                                  \
   ['arm-cpu-features',
    'numa-test',
-- 
2.52.0


