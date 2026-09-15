Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF6DC88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 17:09:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6WdK-0005Pa-7s; Tue, 15 Sep 2026 13:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6WdF-0005OR-TJ
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:07:46 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6WdD-0003UO-Tk
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:07:45 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d37b6so278775e9.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 10:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789492062; x=1790096862; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ULD2PM3N7WNC34JwQIlZJ2MFL6mWprc3t+7KMZ20CZc=;
 b=M5cDb/NQSDKXdvh06yslSzNndjinE6ZNwq9mTzlVCS5WN+zZSEEiCIQATRI/XEN03E
 ngy1S81YVmHtHbVZdRW8TiIIwIzLDWEsAYf1GRs9ro4sTNQFuXYsZ1CxnccIJyScdl7o
 bbwttFvi792q5DI+cgrgKLOFVIGDm2imYQ0A35/gH6adAMo1oCeFng48IOPoJ7LJf6KL
 q0hMOicqZGmDR024kF/eP5HzOv1DfC1JGUZWDH4PRMSoj5PfGXSi9YA6AMJR+qhdIqc6
 hSUJ+tqgvbnjREmbYfll/HvP1InHwwNxQfFkrl8FAIWe8EBNnzzwDYMJlbzZSyN108/w
 xobg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789492062; x=1790096862;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ULD2PM3N7WNC34JwQIlZJ2MFL6mWprc3t+7KMZ20CZc=;
 b=YG8zaJSaKAN9fjmgCkxfzbpt7rl+OySZbd/asLWu6FATVBV5B++suYHtYimdsTdzTC
 ZHlN9U3uAzaVdlHgdZEnlfbeg7lfgkFK+R4h8vCjaexmZasVMhGlxvsxQr7/xefWaBVZ
 cM/r+7WD3semckiFnad2sQ9APsDKfnj+67hOQUZWtbFOO2b+yjsgqWWqG3siDHW44HJs
 QfDZU8IXgidatdvJyyjHVfBt+u5Vir1TgdTg3UMzZDppam0ZG5zzQgLPe1lX5Ikj7ymr
 bQbs96AgEjZwT48EWUNoKm0g70kP7SnBi3qRtQstQktAm3HbyfjGEuLVLauLdPiE4KDW
 4FIg==
X-Gm-Message-State: AFuF++lpy+Ee3yEdEiCtMldfToE+NujZBRoo3HTXMrL1CDnT7eiM8tbz
 4mnxAJwhyky/M1ofHQQkstKIlYZIXbIcMT1UsDj98Ed9bxWhNdIKLX+A0ZQsHk0ghBy+YbJPG73
 1HB2UZuY=
X-Gm-Gg: AYBFou15iwCCh9lXFOZuYq9QvnRRiFJ/ZwP3oHUUjd3GvJS7CnmVqFK1Mm1B7BhEbOf
 trMVLF/aTn3zUeWSdFZkBWfK13YNGzRcvDDJRUc93pGDvcmvHk3JufMBkxvE0kLb9ODq4iZ0PHB
 07BUqKgUJBAsHxD8cRvle1k3qJrBcO4C+T4+CmIbq17QeSVecQAaBPr15o3Zsqc7nfvebTFWxKe
 p96/H8BQ5TdYfwYuYQvxK6EpgPJDCOREem4Zo3raSSowo1i5fuxbt9oiVHWylPS8O58KG+NAW9X
 516uUVlmuanQG4n8cWmOR5YHAiYTrGZFMxTpcYnjmHBEzdayzstPfifTeU/4tegezUZI3j3TdTh
 nRLStYR2rff9IzRGVYBclxhgj+7EBwljXPCcUANZ4UhQIGHLW01vVeQjy0VpLHAcFpDJSevlOCC
 /s6ADdzM24iyA49983r4RUI5mcrxx4eFdo4fUjogHCMi4bbPBTPFGilD+Qq6eeihxeg2GN0ZksH
 gGF71xoFr58n75+Fw0FoItUxZJaIsQBcWESC3NOzBFIV2jpJyUQC3YwTIJtmRZvtzukatUUMyTt
 EgMQ
X-Received: by 2002:a05:600c:34c1:b0:49c:e3c3:5efd with SMTP id
 5b1f17b1804b1-49e7a67e4d5mr211141035e9.9.1789492062396; 
 Tue, 15 Sep 2026 10:07:42 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf33e01sm431826f8f.23.2026.09.15.10.07.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 10:07:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/20] hw/intc/bcm2835_ic: reject out-of-range FIQ source values
Date: Tue, 15 Sep 2026 18:07:19 +0100
Message-ID: <20260915170735.425445-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915170735.425445-1-peter.maydell@linaro.org>
References: <20260915170735.425445-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm2-x10.google.com
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

From: Bin Guo <guobin@linux.alibaba.com>

The FIQ_CONTROL register accepts a 7-bit source selector, but only
sources 0..71 (64 GPU + 8 ARM IRQs) exist.  Values 96..127 cause
bcm2835_ic_update() to call extract32(arm_irq_level, start, 1) with
start >= 32, which trips the assertion in bitops.h and aborts QEMU.

Reject writes that select a non-existent source and log a guest error,
so that a malicious or buggy guest cannot kill the emulator.

Add a qtest that verifies both valid and out-of-range FIQ source
selections on raspi3b.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4368
Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260831081709.77725-1-guobin@linux.alibaba.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/bcm2835_ic.c          | 13 +++++--
 tests/qtest/bcm2835-ic-test.c | 66 +++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build       |  2 +-
 3 files changed, 78 insertions(+), 3 deletions(-)
 create mode 100644 tests/qtest/bcm2835-ic-test.c

diff --git a/hw/intc/bcm2835_ic.c b/hw/intc/bcm2835_ic.c
index 71bf671761b..262a620968f 100644
--- a/hw/intc/bcm2835_ic.c
+++ b/hw/intc/bcm2835_ic.c
@@ -139,10 +139,19 @@ static void bcm2835_ic_write(void *opaque, hwaddr offset, uint64_t val,
     BCM2835ICState *s = opaque;
 
     switch (offset) {
-    case FIQ_CONTROL:
-        s->fiq_select = extract32(val, 0, 7);
+    case FIQ_CONTROL: {
+        unsigned fiq_select = extract32(val, 0, 7);
+
+        if (fiq_select >= GPU_IRQS + ARM_IRQS) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: FIQ select %u out of range\n",
+                          __func__, fiq_select);
+            return;
+        }
+        s->fiq_select = fiq_select;
         s->fiq_enable = extract32(val, 7, 1);
         break;
+    }
     case IRQ_ENABLE_1:
         s->gpu_irq_enable |= val;
         break;
diff --git a/tests/qtest/bcm2835-ic-test.c b/tests/qtest/bcm2835-ic-test.c
new file mode 100644
index 00000000000..1e171ee0924
--- /dev/null
+++ b/tests/qtest/bcm2835-ic-test.c
@@ -0,0 +1,66 @@
+/*
+ * QTest testcase for the BCM2835 Interrupt Controller
+ *
+ * Copyright (c) 2026 Bin Guo <guobin@linux.alibaba.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest-single.h"
+
+#define IC_BASE     0x3f00b200
+#define FIQ_CONTROL (IC_BASE + 0x0c)
+
+static void test_fiq_select_out_of_range(void)
+{
+    uint32_t val;
+
+    /*
+     * Only FIQ sources 0..71 exist.  Source 96 used to trigger an assertion
+     * in bcm2835_ic_update() because extract32(arm_irq_level, 32, 1) was
+     * called with start >= 32.  Make sure the write is rejected and QEMU
+     * keeps running.
+     */
+    writel(FIQ_CONTROL, 0xe0); /* fiq_select = 96, fiq_enable = 1 */
+    val = readl(FIQ_CONTROL);
+    g_assert_cmpint(val, ==, 0);
+
+    /* The first source past the ARM IRQ range should also be rejected. */
+    writel(FIQ_CONTROL, 0xc8); /* fiq_select = 72, fiq_enable = 1 */
+    val = readl(FIQ_CONTROL);
+    g_assert_cmpint(val, ==, 0);
+}
+
+static void test_fiq_select_valid(void)
+{
+    uint32_t val;
+
+    /* Select the highest valid ARM IRQ source (64 + 7 = 71). */
+    writel(FIQ_CONTROL, 0xc7); /* fiq_select = 71, fiq_enable = 1 */
+    val = readl(FIQ_CONTROL);
+    g_assert_cmpint(val, ==, 0xc7);
+
+    /* Select the highest valid GPU IRQ source. */
+    writel(FIQ_CONTROL, 0x3f); /* fiq_select = 63, fiq_enable = 0 */
+    val = readl(FIQ_CONTROL);
+    g_assert_cmpint(val, ==, 0x3f);
+}
+
+int main(int argc, char **argv)
+{
+    int ret;
+
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/bcm2835/bcm2835-ic/fiq-select-out-of-range",
+                   test_fiq_select_out_of_range);
+    qtest_add_func("/bcm2835/bcm2835-ic/fiq-select-valid",
+                   test_fiq_select_valid);
+
+    qtest_start("-machine raspi3b");
+    ret = g_test_run();
+    qtest_end();
+
+    return ret;
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index c3593f75304..33f58b0e95c 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -277,7 +277,7 @@ qtests_aarch64 = \
     ['tpm-tis-device-test', 'tpm-tis-device-swtpm-test'] : []) +                                         \
   (config_all_devices.has_key('CONFIG_XLNX_ZYNQMP_ARM') ? ['xlnx-can-test', 'fuzz-xlnx-dp-test'] : []) + \
   (config_all_devices.has_key('CONFIG_XLNX_VERSAL') ? ['xlnx-canfd-test', 'xlnx-versal-trng-test'] : []) + \
-  (config_all_devices.has_key('CONFIG_RASPI') ? ['bcm2835-dma-test', 'bcm2835-i2c-test'] : []) +  \
+  (config_all_devices.has_key('CONFIG_RASPI') ? ['bcm2835-dma-test', 'bcm2835-i2c-test', 'bcm2835-ic-test'] : []) +  \
   (config_all_accel.has_key('CONFIG_TCG') and                                            \
    config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test', 'tpm-tis-i2c-swtpm-test'] : []) + \
   (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed64 : []) + \
-- 
2.43.0


