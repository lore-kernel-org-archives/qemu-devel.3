Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBECDFEA817
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 07:10:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5INA-0005EN-E0; Wed, 25 Mar 2026 03:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <15fengyuan@gmail.com>)
 id 1w5IN9-0005ED-BC
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 03:09:47 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <15fengyuan@gmail.com>)
 id 1w5IN7-0001MP-7J
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 03:09:47 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-35c05d7e0e9so1303087a91.1
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 00:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774422584; x=1775027384; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/NYQMO/wLuGmsvFvoRe4026atOOoo2S8nwbhA7znUx8=;
 b=al5bt+UWB/C9z1CrYJomEIaC8FjhQRzb2JUJkKVPap3Sd9fvTxp11Y4SxOObp39dx9
 OsThk/RaZOsnPtbJoV4lZ6V4S4CItUf0fHTX4dRi36mLVMUbp8SIl0fu4IhnOs6JZKAj
 qpVtxjI5F3BfXiEICOArGQBBMArFaKO3uTxaWlr25E6GWOp/0prx4ThioA+/mvFr2V1R
 VF83YcrYmduxZ+c5Uj523miEpz1vBzSNsvt91r60txPUAznknt1KBHbB8g0jEDXJ5FsV
 gkmhiknB0NaYUlRK/hy8hwl2lEoIlQTJISKo6p8uxmXnuM5wul1zC8gN7VoBdQUXYJoP
 uqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774422584; x=1775027384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/NYQMO/wLuGmsvFvoRe4026atOOoo2S8nwbhA7znUx8=;
 b=Z2ANCdTiiTbihXJ2hh+xTTOim11wv3LdIi+QmPDGzl1/Sgk7PyKO9WhGhFltHb7poI
 h+ifH4SE7xjlf6ItXc9onkyyYkKkq7iejHv74UuqwjJZ4+UMEp5kfNE6uM4220ZK+2WT
 uWvchdWftLdhQKs/EGcgcBDg6khhRbZ7nMars1k0a8AfFYLEcEAMqPaa8j9rs7dqqNBJ
 /b87dVOlvNji8XEJKgWn/3+1EtXjb84VGXMcHDK3Dy6FwgSHERoaUfEtFWX5s8HIDJvd
 weyr7vsKFCZHd6LvagD1/AZFMkLqwOZhzvV8zKLWx8RsxGT2WriofTC7XKtZWZ12KOVf
 LaBA==
X-Gm-Message-State: AOJu0Yytr43TaB2DhwSHgygRpcgvMP33BWvY9DjDpqlKuniGbLMEdQAk
 Za/n5CmWE2yBg2Ex9kBtvioyLKLQw7NKL3MBl8RPhGJCuaZbNkeD3h6o
X-Gm-Gg: ATEYQzzVbYKFft0PSrWD0CssTCemWpZXhoEUFIn2kWasDMqHW1l7M0nO3YRdnxUsU5h
 urTxhAthcDYxlYf2gB+7B43H3n5+dbYnveo1pKCTOHz9+ZKkTygdqcuOHeWIaUX/lCi9sosAdAl
 o7cTvR3NQk/cZDGsfA9CRGqtK+0AspwvPQoFvr71RCK2VaWl2nmNgQFgqN1vIEawSA6taOhBRW3
 nNkv+GFWPoOgxkyWyWjQzpxr2rqYIBY0m/PePJayiCxigmrx5/1oHU8DLUWK5YJN5vr8V9PLl7j
 sxAfd6z4wLwocD9aDOqE5y+y1p82DkzUfAAaF902Fp1KL+BXjU1iJq1Yp/lgI5xrIDPDBUgFhUj
 Z66U6snb1etkohuIpwVLWgoPIdGN6DVl2byMsU9aQZanWZYJJbEZUXZ/4sUlc+yaIe/LZNzRrlb
 F6fxc0xwcllMcG/Rv89E57T14iuZk=
X-Received: by 2002:a17:90b:3a92:b0:343:7714:4ca8 with SMTP id
 98e67ed59e1d1-35c0dcacb27mr2149544a91.15.1774422583603; 
 Wed, 25 Mar 2026 00:09:43 -0700 (PDT)
Received: from orion-o6.tail020997.ts.net ([2408:8352:441:f661::1002])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c031354f3sm5328074a91.6.2026.03.25.00.09.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 00:09:43 -0700 (PDT)
From: Fengyuan Yu <15fengyuan@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@bull.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Tao Tang <tangtao1634@phytium.com.cn>
Cc: qemu-devel@nongnu.org, Chao Liu <chao.liu.zevorn@gmail.com>,
 Fengyuan Yu <15fengyuan@gmail.com>
Subject: [PATCH v3 2/2] tests/qtest: Add Intel IOMMU bare-metal test
Date: Wed, 25 Mar 2026 15:09:06 +0800
Message-Id: <ce3c44f3b07734a4f0ee43f55b21c856034af1b1.1774421649.git.15fengyuan@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1774421649.git.15fengyuan@gmail.com>
References: <cover.1774421649.git.15fengyuan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=15fengyuan@gmail.com; helo=mail-pj1-x102e.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add a qtest suite for the Intel IOMMU (VT-d) device on the Q35 machine.
The test exercises both Legacy and Scalable translation modes using
iommu-testdev and the qos-intel-iommu helpers, without requiring any
guest kernel or firmware.

The test validates:
- Legacy-mode Root Entry Table and Context Entry Table configuration
- Scalable-mode Context Entry, PASID Directory, and PASID Table setup
- Legacy-mode 4-level page table walks for 48-bit address translation
- Scalable-mode second-level and first-level 4-level page table walks
- Pass-through mode in both Legacy and Scalable modes
- DMA transaction execution with memory content verification

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Fengyuan Yu <15fengyuan@gmail.com>
---
 MAINTAINERS                    |   1 +
 tests/qtest/iommu-intel-test.c | 216 +++++++++++++++++++++++++++++++++
 tests/qtest/meson.build        |   2 +
 3 files changed, 219 insertions(+)
 create mode 100644 tests/qtest/iommu-intel-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ba0901bf4f..420f7ab6cf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4016,6 +4016,7 @@ F: hw/i386/intel_iommu_accel.*
 F: include/hw/i386/intel_iommu.h
 F: tests/functional/x86_64/test_intel_iommu.py
 F: tests/qtest/intel-iommu-test.c
+F: tests/qtest/iommu-intel-test.c
 
 AMD-Vi Emulation
 M: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
diff --git a/tests/qtest/iommu-intel-test.c b/tests/qtest/iommu-intel-test.c
new file mode 100644
index 0000000000..a52c45e298
--- /dev/null
+++ b/tests/qtest/iommu-intel-test.c
@@ -0,0 +1,216 @@
+/*
+ * QTest for Intel IOMMU (VT-d) with iommu-testdev
+ *
+ * This QTest file is used to test the Intel IOMMU with iommu-testdev so that
+ * we can test VT-d without any guest kernel or firmware.
+ *
+ * Copyright (c) 2026 Fengyuan Yu <15fengyuan@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "libqos/pci.h"
+#include "libqos/pci-pc.h"
+#include "hw/i386/intel_iommu_internal.h"
+#include "hw/misc/iommu-testdev.h"
+#include "libqos/qos-intel-iommu.h"
+
+#define DMA_LEN           4
+
+static uint64_t intel_iommu_expected_gpa(uint64_t iova)
+{
+    return (QVTD_PT_VAL & VTD_PAGE_MASK_4K) + (iova & 0xfff);
+}
+
+static void save_fn(QPCIDevice *dev, int devfn, void *data)
+{
+    QPCIDevice **pdev = (QPCIDevice **) data;
+
+    *pdev = dev;
+}
+
+static QPCIDevice *setup_qtest_pci_device(QTestState *qts, QPCIBus **pcibus,
+                                          QPCIBar *bar)
+{
+    QPCIDevice *dev = NULL;
+
+    *pcibus = qpci_new_pc(qts, NULL);
+    g_assert(*pcibus != NULL);
+
+    qpci_device_foreach(*pcibus, IOMMU_TESTDEV_VENDOR_ID,
+                        IOMMU_TESTDEV_DEVICE_ID, save_fn, &dev);
+
+    g_assert(dev);
+    qpci_device_enable(dev);
+    *bar = qpci_iomap(dev, 0, NULL);
+    g_assert_false(bar->is_io);
+
+    return dev;
+}
+
+static const char *qvtd_iommu_args(QVTDTransMode mode)
+{
+    switch (mode) {
+    case QVTD_TM_SCALABLE_FLT:
+        return "-device intel-iommu,x-scalable-mode=on,x-flts=on ";
+    case QVTD_TM_SCALABLE_PT:
+    case QVTD_TM_SCALABLE_SLT:
+        return "-device intel-iommu,x-scalable-mode=on ";
+    default:
+        return "-device intel-iommu ";
+    }
+}
+
+static bool qvtd_check_caps(QTestState *qts, QVTDTransMode mode)
+{
+    uint64_t ecap = qtest_readq(qts,
+                                Q35_HOST_BRIDGE_IOMMU_ADDR + DMAR_ECAP_REG);
+
+    /* All scalable modes require SMTS */
+    if (qvtd_is_scalable(mode) && !(ecap & VTD_ECAP_SMTS)) {
+        g_test_skip("ECAP.SMTS not supported");
+        return false;
+    }
+
+    switch (mode) {
+    case QVTD_TM_SCALABLE_PT:
+        if (!(ecap & VTD_ECAP_PT)) {
+            g_test_skip("ECAP.PT not supported");
+            return false;
+        }
+        break;
+    case QVTD_TM_SCALABLE_SLT:
+        if (!(ecap & VTD_ECAP_SSTS)) {
+            g_test_skip("ECAP.SSTS not supported");
+            return false;
+        }
+        break;
+    case QVTD_TM_SCALABLE_FLT:
+        if (!(ecap & VTD_ECAP_FSTS)) {
+            g_test_skip("ECAP.FSTS not supported");
+            return false;
+        }
+        break;
+    default:
+        break;
+    }
+
+    return true;
+}
+
+static void run_intel_iommu_translation(const QVTDTestConfig *cfg)
+{
+    QTestState *qts;
+    QPCIBus *pcibus;
+    QPCIDevice *dev;
+    QPCIBar bar;
+
+    if (!qtest_has_machine("q35")) {
+        g_test_skip("q35 machine not available");
+        return;
+    }
+
+    /* Initialize QEMU environment for Intel IOMMU testing */
+    qts = qtest_initf("-machine q35 -smp 1 -m 512 -net none "
+                      "%s -device iommu-testdev",
+                      qvtd_iommu_args(cfg->trans_mode));
+
+    /* Check CAP/ECAP capabilities for required translation mode */
+    if (!qvtd_check_caps(qts, cfg->trans_mode)) {
+        qtest_quit(qts);
+        return;
+    }
+
+    /* Setup and configure IOMMU-testdev PCI device */
+    dev = setup_qtest_pci_device(qts, &pcibus, &bar);
+    g_assert(dev);
+
+    g_test_message("### Intel IOMMU translation mode=%d ###", cfg->trans_mode);
+    qvtd_run_translation_case(qts, dev, bar, Q35_HOST_BRIDGE_IOMMU_ADDR, cfg);
+    g_free(dev);
+    qpci_free_pc(pcibus);
+    qtest_quit(qts);
+}
+
+static void test_intel_iommu_legacy_pt(void)
+{
+    QVTDTestConfig cfg = {
+        .trans_mode = QVTD_TM_LEGACY_PT,
+        .dma_gpa = QVTD_IOVA,  /* pass-through: GPA == IOVA */
+        .dma_len = DMA_LEN,
+        .expected_result = 0,
+    };
+
+    run_intel_iommu_translation(&cfg);
+}
+
+static void test_intel_iommu_legacy_trans(void)
+{
+    QVTDTestConfig cfg = {
+        .trans_mode = QVTD_TM_LEGACY_TRANS,
+        .dma_gpa = intel_iommu_expected_gpa(QVTD_IOVA),
+        .dma_len = DMA_LEN,
+        .expected_result = 0,
+    };
+
+    run_intel_iommu_translation(&cfg);
+}
+
+static void test_intel_iommu_scalable_pt(void)
+{
+    QVTDTestConfig cfg = {
+        .trans_mode = QVTD_TM_SCALABLE_PT,
+        .dma_gpa = QVTD_IOVA,  /* pass-through: GPA == IOVA */
+        .dma_len = DMA_LEN,
+        .expected_result = 0,
+    };
+
+    run_intel_iommu_translation(&cfg);
+}
+
+static void test_intel_iommu_scalable_slt(void)
+{
+    QVTDTestConfig cfg = {
+        .trans_mode = QVTD_TM_SCALABLE_SLT,
+        .dma_gpa = intel_iommu_expected_gpa(QVTD_IOVA),
+        .dma_len = DMA_LEN,
+        .expected_result = 0,
+    };
+
+    run_intel_iommu_translation(&cfg);
+}
+
+static void test_intel_iommu_scalable_flt(void)
+{
+    QVTDTestConfig cfg = {
+        .trans_mode = QVTD_TM_SCALABLE_FLT,
+        .dma_gpa = intel_iommu_expected_gpa(QVTD_IOVA),
+        .dma_len = DMA_LEN,
+        .expected_result = 0,
+    };
+
+    run_intel_iommu_translation(&cfg);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    /* Legacy mode tests */
+    qtest_add_func("/iommu-testdev/intel/legacy-pt",
+                   test_intel_iommu_legacy_pt);
+    qtest_add_func("/iommu-testdev/intel/legacy-trans",
+                   test_intel_iommu_legacy_trans);
+
+    /* Scalable mode tests */
+    qtest_add_func("/iommu-testdev/intel/scalable-pt",
+                   test_intel_iommu_scalable_pt);
+    qtest_add_func("/iommu-testdev/intel/scalable-slt",
+                   test_intel_iommu_scalable_slt);
+    qtest_add_func("/iommu-testdev/intel/scalable-flt",
+                   test_intel_iommu_scalable_flt);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index be4fa627b5..264bce9f81 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -96,6 +96,8 @@ qtests_i386 = \
   (config_all_devices.has_key('CONFIG_SDHCI_PCI') ? ['fuzz-sdcard-test'] : []) +            \
   (config_all_devices.has_key('CONFIG_ESP_PCI') ? ['am53c974-test'] : []) +                 \
   (config_all_devices.has_key('CONFIG_VTD') ? ['intel-iommu-test'] : []) +                 \
+  (config_all_devices.has_key('CONFIG_VTD') and
+   config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') ? ['iommu-intel-test'] : []) +      \
   (host_os != 'windows' and                                                                \
    config_all_devices.has_key('CONFIG_ACPI_ERST') ? ['erst-test'] : []) +                   \
   (config_all_devices.has_key('CONFIG_PCIE_PORT') and                                       \
-- 
2.39.5


