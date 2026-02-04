Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B829E83EE4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 07:19:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnX8s-0005xa-EQ; Wed, 04 Feb 2026 02:17:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <15fengyuan@gmail.com>)
 id 1vnTET-0000N3-Oq
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 22:07:09 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <15fengyuan@gmail.com>)
 id 1vnTER-0000wh-VA
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 22:07:09 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2a0d67f1877so42115595ad.2
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 19:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770174426; x=1770779226; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pgWVKWuKjKbhhWlhFAE8UoE4KtV18RVcuaGoClDDvqI=;
 b=e04GKbRHMy8RzUkvcG2Rb6NYzPRahMohXWP3jx5dVSf9toFFGIn+DdFtde80EyTxYD
 /ERHKC/n8AEQr7kw+JPRyZpcU75uCTXJ+x5QBn8PH3mVrT/hIpdGhehBZDXZZrMBLLlE
 nIPj4maeb5SZR9ZQfDygYrtanju9yzP6tCa8AA1+avY4Nn2QDNuCj1fNs/ZWIqKT44Rq
 S3eQz7MrqtUWUnklNxw5iTdmRFim3OX9ZoGFg0FP2+T8bvhkvo5fCW2JbCLp6IxVhfV8
 OB28745ae1OR8+MBp3LNC+Bqwj9fGNPqdLatCcha/cinK5Pue/mKLR082aDESpBMXEIp
 fIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770174426; x=1770779226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pgWVKWuKjKbhhWlhFAE8UoE4KtV18RVcuaGoClDDvqI=;
 b=VeONhpMAVVqJxuyySMNyc4ERdaVVuf2IUu8cGQnq7vgP/YnHeo80w1V5o6ua+QJWpn
 3vyv4sQXxPBgmpKQut+zr90uOxHXQuJf1/NDMkuiWlZtms64P6563jN2uQI9NLM+mWzk
 Ml10AfxUR4VPEIx/In2l0fSFg9A2fjo9kW23SDW++bPx7YC6odxDiPf9yyOiY6hXvo1c
 1NaXWH+FOD8OeMH7Hfg2GbDuPfWjd3wI71IY2XIG/S5Cl5TdrcVEdZd3b1ZIfH97L9EV
 wtFDVr2A92wtb/GiAzv22rqKTqWxryAMMjiAa1jnB8o2+3PNysDZHEU//esVQBmnuIth
 vxKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoebBxIUYJzhPmhjxy5GcNpi6ddkOJEVze3Z2siXK0eBZ0eEGDfby0USfaBxenyLBTmJtpTAC6vxQ3@nongnu.org
X-Gm-Message-State: AOJu0Yw55lnbYxq39UzQUDBPWauAtpiuM5GwQsoyc+02pDMke2Fqn0k1
 1dvjUBSP/9ttTpoRL/yM1q7u938Cd9wdy08Iz9GOatXqsMr7advEvR+BCw3Oe5sEix7qnhQp
X-Gm-Gg: AZuq6aLpnZRMGnzcGwtqjzP6K4hcD/wcG+s+9WcHBgXXEjSOkELJCJvYct0Kao57+GC
 7lsAxKVhgqQfrqcRVmKYSshiITPWzXCc0TqEGNMKDhIYoR7+qW7QKwPqVA/oqB02bzOSjnnY8N7
 IkCkfQxLUNIIvHdVqhBE4Zqs6noWbk9kKVfmCCFN4U2hsQSE2woTWJ8s+YLqMyxCPgw+9WwZP9I
 O8icSf/LnQLi6Q1bCOHB4zonUXA4crXINW6X+P1feAh1As2/3xjEycy3phqkOcaX3svctb8qBo+
 czelGDnZbn95l5H6uU0VTLCWmvLlGlzM8ih86FhTNK7xDU6fLmdcnPUyRAIssvST/IcS1DhMEkZ
 gQjmcptaC9gBbkko+XqnZ2R1DmtDdqpnO0jMp9QMfQlpHGSBjARqucrYpXg6i+kCaf57TdlhH3c
 N3ewRAyCIsyK1H/AH+5o6y3g==
X-Received: by 2002:a17:902:db0a:b0:2a1:e19:ff4 with SMTP id
 d9443c01a7336-2a933fa5640mr16756995ad.29.1770174426307; 
 Tue, 03 Feb 2026 19:07:06 -0800 (PST)
Received: from orion-o6.tail020997.ts.net ([113.247.230.250])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a93388c7c8sm9156735ad.30.2026.02.03.19.07.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 19:07:05 -0800 (PST)
From: Fengyuan Yu <15fengyuan@gmail.com>
To: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Tao Tang <tangtao1634@phytium.com.cn>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, qemu-devel@nongnu.org,
 Fengyuan Yu <15fengyuan@gmail.com>
Subject: [PATCH RFC v1 2/2] tests/qtest: Add Intel IOMMU bare-metal test
Date: Wed,  4 Feb 2026 11:06:20 +0800
Message-Id: <89909ddad9c2b887056344bb93e5407e3639980d.1770172615.git.15fengyuan@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1770172615.git.15fengyuan@gmail.com>
References: <cover.1770172615.git.15fengyuan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=15fengyuan@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 04 Feb 2026 02:17:23 -0500
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
The test exercises pass-through and translated translation modes using
iommu-testdev and the qos-intel-iommu helpers.

The test validates:
- Root Entry Table and Context Entry Table configuration
- 4-level page table walks for 48-bit address translation
- Pass-through mode (identity mapping)
- Translated mode with complete IOVA-to-PA translation
- DMA transaction execution with memory content verification

Signed-off-by: Fengyuan Yu <15fengyuan@gmail.com>
---
 tests/qtest/iommu-intel-test.c | 137 +++++++++++++++++++++++++++++++++
 tests/qtest/meson.build        |   2 +
 2 files changed, 139 insertions(+)
 create mode 100644 tests/qtest/iommu-intel-test.c

diff --git a/tests/qtest/iommu-intel-test.c b/tests/qtest/iommu-intel-test.c
new file mode 100644
index 0000000000..9f631be2c5
--- /dev/null
+++ b/tests/qtest/iommu-intel-test.c
@@ -0,0 +1,137 @@
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
+#include "hw/pci/pci_regs.h"
+#include "hw/misc/iommu-testdev.h"
+#include "libqos/qos-intel-iommu.h"
+
+#define DMA_LEN           4
+
+/* Test configurations for different Intel IOMMU modes */
+static const QVTDTestConfig base_test_configs[] = {
+    {
+        .trans_mode = QVTD_TM_LEGACY_PT,
+        .dma_iova = 0x10100000,  /* Use address in guest RAM range (inside 512MB) */
+        .dma_pa = 0x10100000,
+        .dma_len = DMA_LEN,
+        .expected_result = 0,
+        .domain_id = 1,
+    },
+    {
+        .trans_mode = QVTD_TM_LEGACY_TRANS,
+        .dma_iova = QVTD_TEST_IOVA,
+        .dma_pa = QVTD_TEST_PA,
+        .dma_len = DMA_LEN,
+        .expected_result = 0,
+        .domain_id = 1,
+    },
+};
+
+static QPCIDevice *setup_qtest_pci_device(QTestState *qts, QPCIBus **pcibus,
+                                          QPCIBar *bar)
+{
+    uint16_t vid, did;
+    QPCIDevice *dev = NULL;
+    int device_count = 0;
+
+    *pcibus = qpci_new_pc(qts, NULL);
+    g_assert(*pcibus != NULL);
+
+    g_test_message("Scanning PCI bus for iommu-testdev (vendor:device = 0x%04x:0x%04x)...",
+                   IOMMU_TESTDEV_VENDOR_ID, IOMMU_TESTDEV_DEVICE_ID);
+
+    /* Find device by vendor/device ID to avoid slot surprises. */
+    for (int s = 0; s < 32 && !dev; s++) {
+        for (int fn = 0; fn < 8 && !dev; fn++) {
+            QPCIDevice *cand = qpci_device_find(*pcibus, QPCI_DEVFN(s, fn));
+            if (!cand) {
+                continue;
+            }
+            vid = qpci_config_readw(cand, PCI_VENDOR_ID);
+            did = qpci_config_readw(cand, PCI_DEVICE_ID);
+
+            device_count++;
+            g_test_message("  Found PCI device at %02x:%x - vendor:device = 0x%04x:0x%04x",
+                           s, fn, vid, did);
+
+            if (vid == IOMMU_TESTDEV_VENDOR_ID &&
+                did == IOMMU_TESTDEV_DEVICE_ID) {
+                dev = cand;
+                g_test_message("Found iommu-testdev! devfn: 0x%x", cand->devfn);
+            } else {
+                g_free(cand);
+            }
+        }
+    }
+
+    if (!dev) {
+        g_test_message("ERROR: iommu-testdev not found after scanning %d PCI devices", device_count);
+        g_test_message("Expected vendor:device = 0x%04x:0x%04x (PCI_VENDOR_ID_REDHAT:PCI_DEVICE_ID_REDHAT_TEST)",
+                       IOMMU_TESTDEV_VENDOR_ID, IOMMU_TESTDEV_DEVICE_ID);
+        qpci_free_pc(*pcibus);
+        *pcibus = NULL;
+        g_test_skip("iommu-testdev not found on PCI bus - device may not be compiled or registered");
+        return NULL;
+    }
+
+    /* Enable device - iommu-testdev only uses MMIO, not I/O ports */
+    uint16_t cmd = qpci_config_readw(dev, PCI_COMMAND);
+    cmd |= PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER;
+    qpci_config_writew(dev, PCI_COMMAND, cmd);
+
+    *bar = qpci_iomap(dev, 0, NULL);
+    g_assert_false(bar->is_io);
+
+    return dev;
+}
+
+static void test_intel_iommu_translation(void)
+{
+    QTestState *qts;
+    QPCIBus *pcibus;
+    QPCIDevice *dev;
+    QPCIBar bar;
+
+    /* Initialize QEMU environment for Intel IOMMU testing */
+    qts = qtest_init("-machine q35,kernel-irqchip=split "
+                     "-accel tcg "
+                     "-device intel-iommu,pt=on,aw-bits=48 "
+                     "-device iommu-testdev,bus=pcie.0,addr=0x4 "
+                     "-m 512");
+
+    /* Setup and configure PCI device */
+    dev = setup_qtest_pci_device(qts, &pcibus, &bar);
+    if (!dev) {
+        qtest_quit(qts);
+        return;
+    }
+
+    /* Run the translation tests */
+    g_test_message("### Starting Intel IOMMU translation tests...###");
+    qvtd_translation_batch(base_test_configs, ARRAY_SIZE(base_test_configs),
+                           qts, dev, bar, Q35_IOMMU_BASE);
+    g_test_message("### Intel IOMMU translation tests completed successfully! ###");
+
+    g_free(dev);
+    qpci_free_pc(pcibus);
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    qtest_add_func("/iommu-testdev/intel-translation", test_intel_iommu_translation);
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index e2d2e68092..344e836300 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -95,6 +95,8 @@ qtests_i386 = \
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


