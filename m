Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A532606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 20:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Kp0cE420
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL58V-0006P7-Qf; Sun, 25 Oct 2026 16:48:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cyan2254650260@gmail.com>)
 id 1xL3se-0004LB-9U
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 15:27:44 -0400
Received: from mail-dy2-x0b.google.com ([2607:f8b0:4864:36::b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cyan2254650260@gmail.com>)
 id 1xL3sY-0007km-9U
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 15:27:42 -0400
Received: by mail-dy2-x0b.google.com with SMTP id
 5a478bee46e88-369f30a96acso667394eec.0
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 12:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792956456; x=1793561256; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zBpE5I5MfFXFasiPZ2BKPNNyk+/gV/xOLWY4djr3t2I=;
 b=Kp0cE420mZRoCNb1DjWSiQI7eIZOxR67DQovb7opqv3V+H/w5pVt7j2fgi4m9vYTs5
 uwaRWg2eAeRKAjcpr6vp7cA+u8eszCovAhMZdeRHbErPqD48E2kNAitdFMD2gW9equhb
 ynwRnbQiGEY64GojAqTNcN9rzTaz55tCq/zo2wFqWFobewNg6QHmZh/OFpJOYyzHhb7i
 9/CQ38I9GdI6FCesrh32u7KLMvx1KIsE2GLAfsaD4w4xMt59JPBOVynLYLvnPth87ZU7
 5Z7QcTB+ZJD0GDEdJxY7inhcYO2xc7d8U6LVeo7bSVO8blqBtsiaYwd9ghXOw+BksdNH
 ar5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792956456; x=1793561256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zBpE5I5MfFXFasiPZ2BKPNNyk+/gV/xOLWY4djr3t2I=;
 b=dVIqPtMP9IOjQgTbGUXV0Y0TdeuOiLCVOQFYoGVBFxHdtHhECMSyx2QjgfEUAV/vUs
 MhKCzRU+QL49je0Ve1rqF8GSWNzI/Slk/ZNdQsvXcpzVtDzUobxfFH++0u7U5J2XjsuQ
 1B+9ZQ/1PQDhc5LcSt3WM/BjdyVHLOtV9xWL3KnVabHDPKfs803Ip+ItsCzGXiyhqVNq
 UtP5xxpjaxzzb2WVBiZdXo1vsn+4kunuI9E+PA/Z4a2wPqLRNZD19FLm26Z9ybf8TA2T
 I4Ftc0Zq2UUUIShnG5H2CmKk1QsuO4/JjNxuWrGit69p8YLLa68ROIuQuYxlne02sFvf
 +4Hw==
X-Gm-Message-State: AFq9FYI4TdnC9CVgivW0MxX7yP+k2u24+Gn4nzs6cyHB9dkSMPmLa0nK
 bLuMWGI9wAqO6r50yUXvnUasOevggM5ln5eJlc8z1RyTAGNPcWsdpQUxDgFFlKotNzXrJ9T5ygQ
 =
X-Gm-Gg: AYBFou0i/hkm+dLqO411IWfGlPhTu4m7zWlWbhbspWvDzgu8/yT2+1ghokyQkCAQ+Ld
 SjOoqKN+EdtvtbM/hgG3+U8MRlpd0oiCWFSK/ymXY/QT19vOII521pLWZmi0S83GYZ7S9HYgdlb
 shTb25S0PLxKpxl2PAfTHvbZ/eI+nK6tGgCVzKgduZID4Ki4eQOk9pQBuDug7I4zNMjgZvZjTcc
 MGbmSVl8/AQDayavdWBu2q9EXO8imGx3XcpJASKK75LTaEEwoCFk/MMuVg8GBaLQctlfjsNwHyR
 06FnZxaP34LZegCx/1xA/cBv+SqWq9irtbFmhzSd6DqaOlDLMpswu0yGV2th2F5rZUDbhEZRyNc
 TBn7ZazCXMqT3Tij87dkZ2bEIdfgiUmtoEtCk6R9omxBpJyXWs77CCPqjlIle/2l922WTFYtm28
 1HOkmyN6VWne+YTrBFIvCpmDjs6maSjHFbr9zok8YxjQayMkMLoLK8HO5mpIRY/q6d/lDWR1wb6
 9tPu5c8CgRHhtMrnFSGJfcaIaIzFk/9pG1kPMl3CTsfbGSd9QbzJFO+wdx6SNOnnOsGwoLD1+Pa
X-Received: by 2002:a05:693c:87d9:20b0:369:987f:d15e with SMTP id
 5a478bee46e88-369e8336389mr7631122eec.2.1792956456016; 
 Sun, 25 Oct 2026 12:27:36 -0700 (PDT)
Received: from AERO17.taila7786d.ts.net ([152.175.65.31])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8daa3a8sm23226027eec.16.2026.10.25.12.27.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 12:27:35 -0700 (PDT)
From: Pufan Jin <cyan2254650260@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH 3/3] tests/qtest: Add Xilinx AXI GPIO test
Date: Mon, 26 Oct 2026 03:27:16 +0800
Message-ID: <20261025192716.239589-4-cyan2254650260@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261025192716.239589-1-cyan2254650260@gmail.com>
References: <20261025192716.239589-1-cyan2254650260@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::b;
 envelope-from=cyan2254650260@gmail.com; helo=mail-dy2-x0b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 25 Oct 2026 16:48:04 -0400
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a QTest test suite for the Xilinx AXI GPIO IP core covering:
- Reset state verification
- GPIO 3-state direction register configuration
- GPIO data register output across both channels
- Pin input and edge-triggered interrupt assertion and W1C clearing

Signed-off-by: Pufan Jin <cyan2254650260@gmail.com>
---
 MAINTAINERS                      |   1 +
 tests/qtest/meson.build          |   3 +-
 tests/qtest/xlnx-axi-gpio-test.c | 372 +++++++++++++++++++++++++++++++
 3 files changed, 375 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/xlnx-axi-gpio-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d8b9047dd..7fe35ba8f3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1486,6 +1486,7 @@ F: include/hw/char/xilinx_uartlite.h
 F: hw/gpio/xlnx-axi-gpio.c
 F: include/hw/gpio/xlnx-axi-gpio.h
 F: tests/functional/microblaze/test_s3adsp1800.py
+F: tests/qtest/xlnx-axi-gpio-test.c
 
 petalogix_ml605
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 46685d6d46..c92db2a5ca 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -172,7 +172,8 @@ qtests_m68k = ['boot-serial-test'] + \
   qtests_filter
 
 qtests_microblaze = ['boot-serial-test'] + \
-  qtests_filter
+  qtests_filter + \
+  (config_all_devices.has_key('CONFIG_XLNX_AXI_GPIO') ? ['xlnx-axi-gpio-test'] : [])
 
 qtests_mips = \
   qtests_filter + \
diff --git a/tests/qtest/xlnx-axi-gpio-test.c b/tests/qtest/xlnx-axi-gpio-test.c
new file mode 100644
index 0000000000..166c2a4646
--- /dev/null
+++ b/tests/qtest/xlnx-axi-gpio-test.c
@@ -0,0 +1,372 @@
+/*
+ * QTest testcase for Xilinx AXI GPIO IP core
+ *
+ * Copyright (c) 2026 Pufan Jin <cyan2254650260@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qobject/qdict.h"
+#include "libqtest.h"
+
+#define GPIO_BASE           0x81400000
+
+#define R_GPIO_DATA         0x0000
+#define R_GPIO_TRI          0x0004
+#define R_GPIO2_DATA        0x0008
+#define R_GPIO2_TRI         0x000C
+#define R_GIER              0x011C
+#define R_IPISR             0x0120
+#define R_IPIER             0x0128
+
+#define GIER_GIE            0x80000000
+#define IPISR_CH1           0x00000001
+#define IPISR_CH2           0x00000002
+
+#define GPIO_QOM_PATH       "/machine/unattached/device[6]"
+
+static void test_reset_values(void)
+{
+    QTestState *qts = qtest_init("-machine petalogix-s3adsp1800");
+
+    g_assert_cmphex(qtest_readl(qts, GPIO_BASE + R_GPIO_TRI), ==, 0xFFFFFFFF);
+    g_assert_cmphex(qtest_readl(qts, GPIO_BASE + R_GPIO2_TRI), ==, 0xFFFFFFFF);
+
+    g_assert_cmphex(qtest_readl(qts, GPIO_BASE + R_GPIO_DATA), ==, 0x0);
+    g_assert_cmphex(qtest_readl(qts, GPIO_BASE + R_GPIO2_DATA), ==, 0x0);
+
+    g_assert_cmphex(qtest_readl(qts, GPIO_BASE + R_GIER), ==, 0x0);
+    g_assert_cmphex(qtest_readl(qts, GPIO_BASE + R_IPISR), ==, 0x0);
+    g_assert_cmphex(qtest_readl(qts, GPIO_BASE + R_IPIER), ==, 0x0);
+
+    qtest_quit(qts);
+}
+
+static void test_gpio_data_output(void)
+{
+    QTestState *qts = qtest_init("-machine petalogix-s3adsp1800");
+
+    qtest_writel(qts, GPIO_BASE + R_GPIO_TRI, 0x00000000);
+    g_assert_cmphex(qtest_readl(qts, GPIO_BASE + R_GPIO_TRI), ==, 0x00000000);
+
+    qtest_writel(qts, GPIO_BASE + R_GPIO_DATA, 0x12345678);
+    g_assert_cmphex(qtest_readl(qts, GPIO_BASE + R_GPIO_DATA), ==, 0x12345678);
+
+    qtest_writel(qts, GPIO_BASE + R_GPIO_DATA, 0xDEADBEEF);
+    g_assert_cmphex(qtest_readl(qts, GPIO_BASE + R_GPIO_DATA), ==, 0xDEADBEEF);
+
+    qtest_writel(qts, GPIO_BASE + R_GPIO2_TRI, 0x00000000);
+    g_assert_cmphex(qtest_readl(qts, GPIO_BASE + R_GPIO2_TRI), ==, 0x00000000);
+
+    qtest_writel(qts, GPIO_BASE + R_GPIO2_DATA, 0xCAFEBABE);
+    g_assert_cmphex(qtest_readl(qts, GPIO_BASE + R_GPIO2_DATA), ==, 0xCAFEBABE);
+
+    qtest_quit(qts);
+}
+
+static void test_gpio_direction(void)
+{
+    QTestState *qts = qtest_init("-machine petalogix-s3adsp1800");
+
+    qtest_writel(qts, GPIO_BASE + R_GPIO_TRI, 0xAAAA5555);
+    g_assert_cmphex(qtest_readl(qts, GPIO_BASE + R_GPIO_TRI), ==, 0xAAAA5555);
+
+    qtest_writel(qts, GPIO_BASE + R_GPIO2_TRI, 0x5555AAAA);
+    g_assert_cmphex(qtest_readl(qts, GPIO_BASE + R_GPIO2_TRI), ==, 0x5555AAAA);
+
+    qtest_quit(qts);
+}
+
+static void test_gpio_input_and_irq(void)
+{
+    QTestState *qts = qtest_init("-machine petalogix-s3adsp1800");
+
+    qtest_irq_intercept_out_named(qts, GPIO_QOM_PATH, "sysbus-irq");
+
+    qtest_writel(qts, GPIO_BASE + R_GIER, GIER_GIE);
+    g_assert_cmphex(qtest_readl(qts, GPIO_BASE + R_GIER), ==, GIER_GIE);
+
+    qtest_writel(qts, GPIO_BASE + R_IPIER, IPISR_CH1 | IPISR_CH2);
+    g_assert_cmphex(qtest_readl(qts, GPIO_BASE + R_IPIER), ==,
+                    IPISR_CH1 | IPISR_CH2);
+
+    g_assert_false(qtest_get_irq(qts, 0));
+    g_assert_cmphex(qtest_readl(qts, GPIO_BASE + R_IPISR), ==, 0x0);
+
+    qtest_set_irq_in(qts, GPIO_QOM_PATH, NULL, 0, 1);
+    g_assert_cmphex(qtest_readl(qts, GPIO_BASE + R_GPIO_DATA), ==, 0x1);
+    g_assert_cmphex(qtest_readl(qts, GPIO_BASE + R_IPISR), ==, IPISR_CH1);
+    g_assert_true(qtest_get_irq(qts, 0));
+
+    qtest_writel(qts, GPIO_BASE + R_IPISR, IPISR_CH1);
+    g_assert_cmphex(qtest_readl(qts, GPIO_BASE + R_IPISR), ==, 0x0);
+    g_assert_false(qtest_get_irq(qts, 0));
+
+    qtest_set_irq_in(qts, GPIO_QOM_PATH, NULL, 32 + 3, 1);
+    g_assert_cmphex(qtest_readl(qts, GPIO_BASE + R_GPIO2_DATA), ==, (1 << 3));
+    g_assert_cmphex(qtest_readl(qts, GPIO_BASE + R_IPISR), ==, IPISR_CH2);
+    g_assert_true(qtest_get_irq(qts, 0));
+
+    qtest_writel(qts, GPIO_BASE + R_IPISR, IPISR_CH2);
+    g_assert_cmphex(qtest_readl(qts, GPIO_BASE + R_IPISR), ==, 0x0);
+    g_assert_false(qtest_get_irq(qts, 0));
+
+    qtest_quit(qts);
+}
+
+static void test_gpio_boundary_registers(void)
+{
+    static const uint32_t unmapped_addrs[] = {
+        0x0010, 0x0014, 0x0018, 0x001C, 0x0020,
+        0x0100, 0x0118, 0x0124, 0x012C, 0x01FC,
+    };
+    QTestState *qts = qtest_init("-machine petalogix-s3adsp1800");
+    size_t i;
+
+    for (i = 0; i < ARRAY_SIZE(unmapped_addrs); i++) {
+        uint32_t addr = GPIO_BASE + unmapped_addrs[i];
+
+        g_assert_cmphex(qtest_readl(qts, addr), ==, 0x0);
+        qtest_writel(qts, addr, 0xDEADBEEF);
+        g_assert_cmphex(qtest_readl(qts, addr), ==, 0x0);
+    }
+
+    qtest_writel(qts, GPIO_BASE + R_GIER, 0xFFFFFFFF);
+    g_assert_cmphex(qtest_readl(qts, GPIO_BASE + R_GIER), ==, GIER_GIE);
+
+    qtest_writel(qts, GPIO_BASE + R_IPIER, 0xFFFFFFFF);
+    g_assert_cmphex(qtest_readl(qts, GPIO_BASE + R_IPIER), ==,
+                    IPISR_CH1 | IPISR_CH2);
+
+    qtest_set_irq_in(qts, GPIO_QOM_PATH, NULL, 0, 1);
+    g_assert_cmphex(qtest_readl(qts, GPIO_BASE + R_IPISR), ==, IPISR_CH1);
+    qtest_writel(qts, GPIO_BASE + R_IPISR, 0x0);
+    g_assert_cmphex(qtest_readl(qts, GPIO_BASE + R_IPISR), ==, IPISR_CH1);
+    qtest_writel(qts, GPIO_BASE + R_IPISR, IPISR_CH2);
+    g_assert_cmphex(qtest_readl(qts, GPIO_BASE + R_IPISR), ==, IPISR_CH1);
+    qtest_writel(qts, GPIO_BASE + R_IPISR, IPISR_CH1);
+    g_assert_cmphex(qtest_readl(qts, GPIO_BASE + R_IPISR), ==, 0x0);
+
+    qtest_quit(qts);
+}
+
+static void test_gpio_interrupt_modes(void)
+{
+    QTestState *qts = qtest_init("-machine petalogix-s3adsp1800");
+
+    qtest_irq_intercept_out_named(qts, GPIO_QOM_PATH, "sysbus-irq");
+
+    qtest_writel(qts, GPIO_BASE + R_GIER, GIER_GIE);
+    qtest_writel(qts, GPIO_BASE + R_IPIER, IPISR_CH1 | IPISR_CH2);
+
+    qtest_set_irq_in(qts, GPIO_QOM_PATH, NULL, 0, 1);
+    qtest_set_irq_in(qts, GPIO_QOM_PATH, NULL, 32 + 5, 1);
+    g_assert_cmphex(qtest_readl(qts, GPIO_BASE + R_IPISR), ==,
+                    IPISR_CH1 | IPISR_CH2);
+    g_assert_true(qtest_get_irq(qts, 0));
+
+    qtest_writel(qts, GPIO_BASE + R_IPISR, IPISR_CH1);
+    g_assert_cmphex(qtest_readl(qts, GPIO_BASE + R_IPISR), ==, IPISR_CH2);
+    g_assert_true(qtest_get_irq(qts, 0));
+
+    qtest_writel(qts, GPIO_BASE + R_IPISR, IPISR_CH2);
+    g_assert_cmphex(qtest_readl(qts, GPIO_BASE + R_IPISR), ==, 0x0);
+    g_assert_false(qtest_get_irq(qts, 0));
+
+    qtest_set_irq_in(qts, GPIO_QOM_PATH, NULL, 0, 0);
+    g_assert_cmphex(qtest_readl(qts, GPIO_BASE + R_IPISR), ==, IPISR_CH1);
+    g_assert_true(qtest_get_irq(qts, 0));
+    qtest_writel(qts, GPIO_BASE + R_IPISR, IPISR_CH1);
+    g_assert_false(qtest_get_irq(qts, 0));
+
+    qtest_writel(qts, GPIO_BASE + R_GPIO_TRI, 0xFFFFFFFE); /* pin 0 output */
+    qtest_set_irq_in(qts, GPIO_QOM_PATH, NULL, 0, 1);
+    g_assert_cmphex(qtest_readl(qts, GPIO_BASE + R_IPISR), ==, 0x0);
+    g_assert_false(qtest_get_irq(qts, 0));
+
+    qtest_writel(qts, GPIO_BASE + R_GPIO_TRI, 0xFFFFFFFF); /* pin 0 input */
+    qtest_writel(qts, GPIO_BASE + R_GIER, 0x0);
+    qtest_set_irq_in(qts, GPIO_QOM_PATH, NULL, 0, 0);
+    g_assert_cmphex(qtest_readl(qts, GPIO_BASE + R_IPISR), ==, IPISR_CH1);
+    g_assert_false(qtest_get_irq(qts, 0));
+
+    qtest_writel(qts, GPIO_BASE + R_GIER, GIER_GIE);
+    g_assert_true(qtest_get_irq(qts, 0));
+
+    qtest_writel(qts, GPIO_BASE + R_GIER, 0x0);
+    g_assert_false(qtest_get_irq(qts, 0));
+
+    qtest_writel(qts, GPIO_BASE + R_IPISR, IPISR_CH1);
+    qtest_quit(qts);
+}
+
+static void test_physical_outputs(void)
+{
+    QTestState *qts = qtest_init("-machine petalogix-s3adsp1800");
+    int i;
+
+    qtest_irq_intercept_out(qts, GPIO_QOM_PATH);
+
+    qtest_writel(qts, GPIO_BASE + R_GPIO_TRI, 0x00000000);
+
+    qtest_writel(qts, GPIO_BASE + R_GPIO_DATA, 0x12345678);
+    for (i = 0; i < 32; i++) {
+        bool expected = (0x12345678 >> i) & 1;
+        g_assert_cmpint(qtest_get_irq(qts, i), ==, expected);
+    }
+
+    qtest_writel(qts, GPIO_BASE + R_GPIO_DATA, 0xEDCBA987);
+    for (i = 0; i < 32; i++) {
+        bool expected = (0xEDCBA987 >> i) & 1;
+        g_assert_cmpint(qtest_get_irq(qts, i), ==, expected);
+    }
+
+    qtest_writel(qts, GPIO_BASE + R_GPIO_TRI, 0xFFFFFFFF);
+    qtest_writel(qts, GPIO_BASE + R_GPIO_DATA, 0xFFFFFFFF);
+    for (i = 0; i < 32; i++) {
+        bool expected = (0xEDCBA987 >> i) & 1;
+        g_assert_cmpint(qtest_get_irq(qts, i), ==, expected);
+    }
+
+    qtest_quit(qts);
+}
+
+static void test_physical_outputs_ch2(void)
+{
+    QTestState *qts = qtest_init("-machine petalogix-s3adsp1800");
+    int i;
+
+    qtest_irq_intercept_out_named(qts, GPIO_QOM_PATH, "gpio2-out");
+
+    qtest_writel(qts, GPIO_BASE + R_GPIO2_TRI, 0x00000000);
+
+    qtest_writel(qts, GPIO_BASE + R_GPIO2_DATA, 0xA5A5A5A5);
+    for (i = 0; i < 32; i++) {
+        bool expected = (0xA5A5A5A5 >> i) & 1;
+        g_assert_cmpint(qtest_get_irq(qts, i), ==, expected);
+    }
+
+    qtest_writel(qts, GPIO_BASE + R_GPIO2_TRI, 0xFFFFFFFF);
+    qtest_writel(qts, GPIO_BASE + R_GPIO2_DATA, 0xFFFFFFFF);
+    for (i = 0; i < 32; i++) {
+        bool expected = (0xA5A5A5A5 >> i) & 1;
+        g_assert_cmpint(qtest_get_irq(qts, i), ==, expected);
+    }
+
+    qtest_quit(qts);
+}
+
+static void test_mixed_direction_multiplexing(void)
+{
+    QTestState *qts = qtest_init("-machine petalogix-s3adsp1800");
+    int i;
+
+    qtest_writel(qts, GPIO_BASE + R_GPIO_TRI, 0xAAAAAAAA);
+
+    qtest_writel(qts, GPIO_BASE + R_GPIO_DATA, 0x55555555);
+
+    for (i = 1; i < 32; i += 2) {
+        qtest_set_irq_in(qts, GPIO_QOM_PATH, NULL, i, 1);
+    }
+
+    g_assert_cmphex(qtest_readl(qts, GPIO_BASE + R_GPIO_DATA), ==, 0xFFFFFFFF);
+
+    for (i = 1; i < 32; i += 2) {
+        qtest_set_irq_in(qts, GPIO_QOM_PATH, NULL, i, 0);
+    }
+
+    g_assert_cmphex(qtest_readl(qts, GPIO_BASE + R_GPIO_DATA), ==, 0x55555555);
+
+    qtest_quit(qts);
+}
+
+static void test_system_reset_active(void)
+{
+    QTestState *qts = qtest_init("-machine petalogix-s3adsp1800");
+
+    qtest_irq_intercept_out_named(qts, GPIO_QOM_PATH, "sysbus-irq");
+
+    qtest_writel(qts, GPIO_BASE + R_GPIO_TRI, 0xFFFFFFFD);
+    qtest_writel(qts, GPIO_BASE + R_GPIO_DATA, 0xDEADBEEF);
+    qtest_writel(qts, GPIO_BASE + R_GPIO2_TRI, 0x12345678);
+    qtest_writel(qts, GPIO_BASE + R_GPIO2_DATA, 0x87654321);
+    qtest_writel(qts, GPIO_BASE + R_GIER, GIER_GIE);
+    qtest_writel(qts, GPIO_BASE + R_IPIER, IPISR_CH1 | IPISR_CH2);
+
+    qtest_set_irq_in(qts, GPIO_QOM_PATH, NULL, 0, 1);
+    g_assert_true(qtest_get_irq(qts, 0));
+    g_assert_cmphex(qtest_readl(qts, GPIO_BASE + R_IPISR), ==, IPISR_CH1);
+    qtest_set_irq_in(qts, GPIO_QOM_PATH, NULL, 0, 0);
+    g_assert_true(qtest_get_irq(qts, 0));
+    qtest_system_reset(qts);
+
+    g_assert_cmphex(qtest_readl(qts, GPIO_BASE + R_GPIO_TRI), ==, 0xFFFFFFFF);
+    g_assert_cmphex(qtest_readl(qts, GPIO_BASE + R_GPIO_DATA), ==, 0x0);
+    g_assert_cmphex(qtest_readl(qts, GPIO_BASE + R_GPIO2_TRI), ==, 0xFFFFFFFF);
+    g_assert_cmphex(qtest_readl(qts, GPIO_BASE + R_GPIO2_DATA), ==, 0x0);
+    g_assert_cmphex(qtest_readl(qts, GPIO_BASE + R_GIER), ==, 0x0);
+    g_assert_cmphex(qtest_readl(qts, GPIO_BASE + R_IPIER), ==, 0x0);
+    g_assert_cmphex(qtest_readl(qts, GPIO_BASE + R_IPISR), ==, 0x0);
+
+    g_assert_false(qtest_get_irq(qts, 0));
+
+    qtest_quit(qts);
+}
+
+static void test_qom_introspection(void)
+{
+    QTestState *qts = qtest_init("-machine petalogix-s3adsp1800");
+    QDict *r;
+
+    r = qtest_qmp(qts, "{ 'execute': 'qom-get', 'arguments': "
+                       "{ 'path': %s, 'property': 'width1' } }",
+                       GPIO_QOM_PATH);
+    g_assert_nonnull(r);
+    g_assert_cmpuint(qdict_get_uint(r, "return"), ==, 32);
+    qobject_unref(r);
+
+    r = qtest_qmp(qts, "{ 'execute': 'qom-get', 'arguments': "
+                       "{ 'path': %s, 'property': 'width2' } }",
+                       GPIO_QOM_PATH);
+    g_assert_nonnull(r);
+    g_assert_cmpuint(qdict_get_uint(r, "return"), ==, 32);
+    qobject_unref(r);
+
+    r = qtest_qmp(qts, "{ 'execute': 'qom-get', 'arguments': "
+                       "{ 'path': %s, 'property': 'is-dual' } }",
+                       GPIO_QOM_PATH);
+    g_assert_nonnull(r);
+    g_assert_true(qdict_get_bool(r, "return"));
+    qobject_unref(r);
+
+    r = qtest_qmp(qts, "{ 'execute': 'qom-get', 'arguments': "
+                       "{ 'path': %s, 'property': 'endianness' } }",
+                       GPIO_QOM_PATH);
+    g_assert_nonnull(r);
+    g_assert_cmpstr(qdict_get_str(r, "return"), ==, "big");
+    qobject_unref(r);
+
+    qtest_quit(qts);
+}
+
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/xlnx-axi-gpio/reset_values", test_reset_values);
+    qtest_add_func("/xlnx-axi-gpio/data_output", test_gpio_data_output);
+    qtest_add_func("/xlnx-axi-gpio/direction", test_gpio_direction);
+    qtest_add_func("/xlnx-axi-gpio/input_and_irq", test_gpio_input_and_irq);
+    qtest_add_func("/xlnx-axi-gpio/boundaries", test_gpio_boundary_registers);
+    qtest_add_func("/xlnx-axi-gpio/interrupt_modes", test_gpio_interrupt_modes);
+    qtest_add_func("/xlnx-axi-gpio/physical_outputs", test_physical_outputs);
+    qtest_add_func("/xlnx-axi-gpio/physical_outputs_ch2",
+                   test_physical_outputs_ch2);
+    qtest_add_func("/xlnx-axi-gpio/mixed_multiplexing",
+                   test_mixed_direction_multiplexing);
+    qtest_add_func("/xlnx-axi-gpio/system_reset", test_system_reset_active);
+    qtest_add_func("/xlnx-axi-gpio/qom_introspection", test_qom_introspection);
+    return g_test_run();
+}
-- 
2.56.0


