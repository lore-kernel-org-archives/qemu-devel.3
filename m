Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE15D26284
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 18:41:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viGeS-0000kl-5p; Tue, 20 Jan 2026 13:40:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGds-0008KC-9Y
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:39:56 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGdq-000645-2K
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:39:51 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-47f3b7ef761so33432155e9.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 10:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768934388; x=1769539188; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wGGJfg7cdndkR9NDz3LfOfgo5mhBYtHV0xGydFpvfG8=;
 b=C+PiqdzFCzMNUE7mVu8EPEKgaXdds+kjK9kK87/9UdsV+cCMzMXFVCLf10TT4IfMVJ
 P3Wfq6h372MS3VgcEGm7EuQbJDsOpyxrRgmnTcMWHCPWigwf8mR3KHb0lyvqJ3ou0Ywn
 kxNDRfTL3I5PySc8+q637dv0qMKRlES/M17bVJGgxp/0DMrKmJT30w+8z2+IMhZdilo8
 1b0FSLaZWEqnfXD8OSASV+q87DogWD8xllK7PjJPbvtb/xgK7dzeAEBpGEQeB50+vgTg
 8iI9RMlckSL0GUqfu4hu7fnX+bDxnAPl2P4IsmO19eF8G3OsUQpHTgSBfCcoksUuJrDq
 fvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768934388; x=1769539188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wGGJfg7cdndkR9NDz3LfOfgo5mhBYtHV0xGydFpvfG8=;
 b=IfNioW3PQTCzQ22ksSuyxXXwAEbCJe6718uZQwQpzba3w5EOeP9qS4RLW/zxUsy4HE
 KXlnHBNmFls5hrooJ2KaD0W1+wXQBbEe16kK7RIWlwD2t2zc7cF9qXKQ1tTHjFKgP6dq
 7i0+taqTHSZHjiADj3nRLtCEQuYo6DYZrqlujyN6XzgyNFzQvCFU07AF1ToGE+JCI3fh
 sji18fdRY3umXXg2FKzHWemREGFPZV9w/dUmmyLNhMiT8B0iat4ndZVJiDwdjTldCqB/
 7NLwpjj+4xwLsMoxgPEP+AeasMvKcSkHmiPNvuK8k1RVXD2/PYJjr2T2QD9X8CP7Mbg1
 vHBQ==
X-Gm-Message-State: AOJu0YwFc8ClIVOUjuBZIxTZd+IfJI+OzLK2dr2/sP60HD7bp0pUTweG
 cuCC8WLq8e7QFpLcy8T8HuHRz3Xr8bvlDd9bwc+7lcETQ0nLNxauv5Pkzqea81cFK/RcSViogwK
 sBQ6zhYI=
X-Gm-Gg: AY/fxX6OMb0T989Hb88E5mhsMtMz5sdslDTFLj1dndvZjJPy9dacTcMjJuxr58QNXde
 kCN03O1l9ZIdeMe5CRlu++dHrRYHOB04oeWl+guNcMwxH8bayvk4ptD+2A6lLQnqIcX8HrqlXzX
 o5i/6C7gp3OpRL1/e0FlXuJWkpVSd9t4R2Q1VMIDuzNABkgZZMgg8ba7zc0WSmrMCraWFovOdhs
 SlHIPx88VdMIDTEaIdy3x0EzIVKiCRYJB7Cyw1kYt5mcPJS1pUpy+r9flTLAfN8jLGnUMHjFlji
 xcViyF3NVpBBTRkGaQJIIk6xaDmAlCMhCv8HYiQPaCoBTzliCF3V+d/n5zi+rSK+nTY0E1F82rk
 F6cn8rniRctollEEvdV1zXIJZr11wp6G2/ni/maSleksYWFBztLOMI2g/tWANyEM2UGL3KV/poK
 ovRYxh6XecVI+vDPuUCONNSJM3746bHIFug3m+C/VvtGcg3pj28C+7fEhM23m4
X-Received: by 2002:a05:600c:4e05:b0:45d:d97c:236c with SMTP id
 5b1f17b1804b1-480416867d8mr19644505e9.21.1768934387889; 
 Tue, 20 Jan 2026 10:39:47 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e86c00esm256288795e9.2.2026.01.20.10.39.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Jan 2026 10:39:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/29] tests/qtest: Add libqos iommu-testdev helpers
Date: Tue, 20 Jan 2026 19:38:39 +0100
Message-ID: <20260120183902.73845-7-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120183902.73845-1-philmd@linaro.org>
References: <20260120183902.73845-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Introduce a libqos helper module for the iommu-testdev
device used by qtests. This module provides some common functions to
all IOMMU test cases using iommu-testdev.

Wire the new sources into tests/qtest/libqos/meson.build so
they are built as part of the qtest support library.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Message-ID: <20260119161112.3841386-7-tangtao1634@phytium.com.cn>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                            |  5 ++
 tests/qtest/libqos/qos-iommu-testdev.h | 43 ++++++++++++++
 tests/qtest/libqos/qos-iommu-testdev.c | 82 ++++++++++++++++++++++++++
 tests/qtest/libqos/meson.build         |  3 +
 4 files changed, 133 insertions(+)
 create mode 100644 tests/qtest/libqos/qos-iommu-testdev.h
 create mode 100644 tests/qtest/libqos/qos-iommu-testdev.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 63a04350fb0..cc219e39b98 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3578,6 +3578,11 @@ F: docs/devel/testing/qtest.rst
 X: tests/qtest/bios-tables-test*
 X: tests/qtest/migration-*
 
+QTest IOMMU helpers
+M: Tao Tang <tangtao1634@phytium.com.cn>
+S: Maintained
+F: tests/qtest/libqos/qos-iommu*
+
 Device Fuzzing
 M: Alexander Bulekov <alxndr@bu.edu>
 R: Paolo Bonzini <pbonzini@redhat.com>
diff --git a/tests/qtest/libqos/qos-iommu-testdev.h b/tests/qtest/libqos/qos-iommu-testdev.h
new file mode 100644
index 00000000000..3713b89ea4c
--- /dev/null
+++ b/tests/qtest/libqos/qos-iommu-testdev.h
@@ -0,0 +1,43 @@
+/*
+ * IOMMU test device helpers for libqos qtests
+ *
+ * Copyright (c) 2026 Phytium Technology
+ *
+ * Author:
+ *  Tao Tang <tangtao1634@phytium.com.cn>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QTEST_LIBQOS_IOMMU_TESTDEV_H
+#define QTEST_LIBQOS_IOMMU_TESTDEV_H
+
+#include "pci.h"
+#include "hw/misc/iommu-testdev.h"
+
+typedef uint32_t (*QOSIOMMUTestdevSetupFn)(void *opaque);
+typedef uint32_t (*QOSIOMMUTestdevAttrsFn)(void *opaque);
+typedef bool (*QOSIOMMUTestdevValidateFn)(void *opaque);
+typedef void (*QOSIOMMUTestdevReportFn)(void *opaque, uint32_t dma_result);
+
+typedef struct QOSIOMMUTestdevDmaCfg {
+    QPCIDevice *dev;
+    QPCIBar bar;
+    uint64_t iova;
+    uint64_t gpa;
+    uint32_t len;
+} QOSIOMMUTestdevDmaCfg;
+
+uint32_t qos_iommu_testdev_trigger_dma(QPCIDevice *dev, QPCIBar bar,
+                                       uint64_t iova, uint64_t gpa,
+                                       uint32_t len, uint32_t attrs);
+
+void qos_iommu_testdev_single_translation(const QOSIOMMUTestdevDmaCfg *dma,
+                                          void *opaque,
+                                          QOSIOMMUTestdevSetupFn setup_fn,
+                                          QOSIOMMUTestdevAttrsFn attrs_fn,
+                                          QOSIOMMUTestdevValidateFn validate_fn,
+                                          QOSIOMMUTestdevReportFn report_fn,
+                                          uint32_t *dma_result_out);
+
+#endif /* QTEST_LIBQOS_IOMMU_TESTDEV_H */
diff --git a/tests/qtest/libqos/qos-iommu-testdev.c b/tests/qtest/libqos/qos-iommu-testdev.c
new file mode 100644
index 00000000000..91718a56738
--- /dev/null
+++ b/tests/qtest/libqos/qos-iommu-testdev.c
@@ -0,0 +1,82 @@
+/*
+ * IOMMU test device helpers for libqos qtests
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
+#include "../libqtest.h"
+#include "pci.h"
+#include "qos-iommu-testdev.h"
+
+uint32_t qos_iommu_testdev_trigger_dma(QPCIDevice *dev, QPCIBar bar,
+                                       uint64_t iova, uint64_t gpa,
+                                       uint32_t len, uint32_t attrs)
+{
+    uint32_t result = ITD_DMA_RESULT_BUSY;
+
+    qpci_io_writel(dev, bar, ITD_REG_DMA_GVA_LO, (uint32_t)iova);
+    qpci_io_writel(dev, bar, ITD_REG_DMA_GVA_HI, (uint32_t)(iova >> 32));
+    qpci_io_writel(dev, bar, ITD_REG_DMA_GPA_LO, (uint32_t)gpa);
+    qpci_io_writel(dev, bar, ITD_REG_DMA_GPA_HI, (uint32_t)(gpa >> 32));
+    qpci_io_writel(dev, bar, ITD_REG_DMA_LEN, len);
+    qpci_io_writel(dev, bar, ITD_REG_DMA_ATTRS, attrs);
+
+    qpci_io_writel(dev, bar, ITD_REG_DMA_DBELL, ITD_DMA_DBELL_ARM);
+    qpci_io_readl(dev, bar, ITD_REG_DMA_TRIGGERING);
+
+    for (int i = 0; i < 1000; i++) {
+        result = qpci_io_readl(dev, bar, ITD_REG_DMA_RESULT);
+        if (result != ITD_DMA_RESULT_BUSY) {
+            break;
+        }
+        g_usleep(1000);
+    }
+
+    if (result == ITD_DMA_RESULT_BUSY) {
+        return ITD_DMA_ERR_TX_FAIL;
+    }
+
+    return result;
+}
+
+void qos_iommu_testdev_single_translation(const QOSIOMMUTestdevDmaCfg *dma,
+                                          void *opaque,
+                                          QOSIOMMUTestdevSetupFn setup_fn,
+                                          QOSIOMMUTestdevAttrsFn attrs_fn,
+                                          QOSIOMMUTestdevValidateFn validate_fn,
+                                          QOSIOMMUTestdevReportFn report_fn,
+                                          uint32_t *dma_result_out)
+{
+    uint32_t config_result;
+    uint32_t dma_result;
+    uint32_t attrs_val;
+
+    g_assert(dma);
+    g_assert(setup_fn);
+    g_assert(attrs_fn);
+
+    config_result = setup_fn(opaque);
+    g_assert_cmpuint(config_result, ==, 0);
+
+    attrs_val = attrs_fn(opaque);
+    dma_result = qos_iommu_testdev_trigger_dma(dma->dev, dma->bar,
+                                               dma->iova, dma->gpa,
+                                               dma->len, attrs_val);
+    if (dma_result_out) {
+        *dma_result_out = dma_result;
+    }
+
+    if (report_fn) {
+        report_fn(opaque, dma_result);
+    }
+
+    if (validate_fn) {
+        g_assert_true(validate_fn(opaque));
+    }
+}
diff --git a/tests/qtest/libqos/meson.build b/tests/qtest/libqos/meson.build
index 1ddaf7b095b..9805d63a290 100644
--- a/tests/qtest/libqos/meson.build
+++ b/tests/qtest/libqos/meson.build
@@ -60,6 +60,9 @@ libqos_srcs = files(
         'x86_64_pc-machine.c',
         'riscv-virt-machine.c',
         'loongarch-virt-machine.c',
+
+        # SMMU:
+        'qos-iommu-testdev.c',
 )
 
 if have_virtfs
-- 
2.52.0


