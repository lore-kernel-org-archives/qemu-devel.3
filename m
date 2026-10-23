Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA4D606A323
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 14:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=CLk6zyv2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKG3O-0003RP-Mv; Fri, 23 Oct 2026 10:15:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKG3J-0003JM-Bu
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:15:26 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKG3H-0006kp-7b
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:15:25 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso9016065e9.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792764922; x=1793369722; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vIPAWhnr0+lGaTMJ9xgSJEJA9iGSsaokwMHbLhgWRQA=;
 b=CLk6zyv2hwmFzbY6tsUzQyW8nJbhegSgjPYKP8sMrnOwrNypwzeQqnGD/r5dt8AOyD
 8nYBIGrPvrfpglPF5lGZ0I2JsQUKLE4cZ/2btJt+bMLJRx13wHRjkahSo8BwdmoYw7nh
 dYl1AxKI3mNNB/mbEHhs5neVTEFFoKP7aUn4CQvkyTCDkowyFsPVfmvP0+fzShYFFDTj
 PEqG+2xSBgmGxYwMQQYLx3WWILWXwrvQ5qklE/m7UtDM+0ZayiiQWI4lsE9zHL/A6LMM
 zooAyaTiXLWd+SV9LmMDWJSbxNmQ+Tn/dY0nwBilqBYDFi3kSSrV5xVHt6J85+BcGkTe
 Ms7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792764922; x=1793369722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vIPAWhnr0+lGaTMJ9xgSJEJA9iGSsaokwMHbLhgWRQA=;
 b=vj2GvdlxYDYOJI2yTzMZ3EjQfnHnQY3aqr5n/S6XspP4/XZUQVkpfE9IYtrSxf/cfJ
 +aOfWiY5qqcd5ntVgAhECZ3EmFz72ke4GIQJHv5sejZBZcSpkKfeWK+AfsYwM1jwk2ve
 TAA3WzvNqHCU5/9m7DSoXSckzKV9RxwjytBwjkFR3lHNznhFL+DKl5lXdy/+/sceQR7q
 /Jz+vwgt27ngCXjpLyf+9gskfqpcA7HT/Og4yWjlRuMH8po5kFjwVwmcBW1cDtKQDH77
 ymj7LY0+cFT5EZXDee8Z48k/0+D5qtOG9FK1lz0Zxh8hTIqX0qibQD5mL9O+fT7pmTef
 9XGA==
X-Gm-Message-State: AFq9FYKJMjjQM1riaMH0tSX9AdhNdlPwo/nu4bY6gX1bc9ZjK7ZBC99R
 78SpcagsERBOX7JCYIRM1FA3ZFOL1AIg0v7LVeGXPMavPQXcHMROY51PQFW9/y9cbu0N+Qul/fr
 wuBgkSas=
X-Gm-Gg: AYBFou1GHAuRDEayIMNjdP48v+690xaeniE1vi4ksCA8/CUVQehgvKh4hoSWZjZa51R
 RDWHcZX8C/zjqa1iiJTwW8VX4TNmkEHdL0BYgDz3/V8QYxTzQUwvrwKud/JNb7mNBPTC8zeYmuw
 z2mjBNEcdhDbkcMMr2khdP2LXFNC+cNhnBcuoZkxlUW+QtdJHXrEXy1ii7GalyiXnKwnF91yzFX
 DcSX7nIksMxcowsaoI8UiY08wmolW895+hSOeV3MTFvLhdoZn1eZQLOKAYZYhT+THeMLNlJOu4A
 iPb3nG8x00OintqDL6YhWreUVil3ugym9rivIRRubTEy71WB+noGFZ+AiOCUVSgn78XRALcW1Xu
 ++nQJBz/42HNHkvZKeZNH+NzquqXBM9xdminKwWz1oaR8T+i/YvBxJ+WFbcxUHTk6QD6c6ccKZz
 sdAg2CMSUFL4H77bXgXkdo3erFh5DfkI236JJYxqHdxbPl12c3vpGgxORLyZqxT5NvnaiNO8q3T
 2NTIq3puMEoazPR01KNWaNWhNOjsXm6ida5ltcTw/eYr0ag/MPNd2Mde6LwXIFqp48gvurhm5LE
 VaTQI0Swtn74XPEPXh5b8cYBENyhVkZyrsrFmovAy1AxawIQPigoZeavwzyZ
X-Received: by 2002:a05:600c:1c05:b0:4a1:83f0:7c8a with SMTP id
 5b1f17b1804b1-4a211c45f89mr47937495e9.1.1792764921596; 
 Fri, 23 Oct 2026 07:15:21 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a2fe31a7a4sm1310675e9.0.2026.10.23.07.15.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 07:15:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/16] tests: arm/virt: add GWDT tests
Date: Fri, 23 Oct 2026 15:14:57 +0100
Message-ID: <20261023141503.1397009-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023141503.1397009-1-peter.maydell@linaro.org>
References: <20261023141503.1397009-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-id: 20261019130713.4127060-1-imammedo@redhat.com
[PMM: Added new file to same MAINTAINERS section as the
 gwdt implementation]

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS                  |   1 +
 tests/qtest/sbsa-gwdt-test.c | 227 +++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build      |   1 +
 3 files changed, 229 insertions(+)
 create mode 100644 tests/qtest/sbsa-gwdt-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d9209f043f0..c61980ba13d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1075,6 +1075,7 @@ F: hw/arm/sbsa-ref.c
 F: hw/misc/sbsa_ec.c
 F: hw/watchdog/sbsa_gwdt.c
 F: include/hw/watchdog/sbsa_gwdt.h
+F: tests/qtest/sbsa-gwdt-test.c
 F: docs/system/arm/sbsa.rst
 F: tests/functional/aarch64/test_*sbsaref*.py
 
diff --git a/tests/qtest/sbsa-gwdt-test.c b/tests/qtest/sbsa-gwdt-test.c
new file mode 100644
index 00000000000..ae166778f74
--- /dev/null
+++ b/tests/qtest/sbsa-gwdt-test.c
@@ -0,0 +1,227 @@
+/*
+ * SBSA Generic Watchdog Timer (GWDT) testcase
+ *
+ * Copyright (C) 2026 Red Hat
+ *
+ * Authors:
+ *  Igor Mammedov <imammedo@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bitops.h"
+#include "qemu/timer.h"
+#include "libqtest-single.h"
+#include "qobject/qdict.h"
+
+#define GWDT_REFRESH_BASE   0x0f000000
+#define GWDT_CONTROL_BASE   0x0f001000
+#define GWDT_WRR            0x000
+#define GWDT_WCS            0x000
+#define GWDT_WORL           0x008
+#define GWDT_WORH           0x00C
+#define GWDT_WCVL           0x010
+#define GWDT_WCVH           0x014
+#define GWDT_W_IIDR         0xFCC
+
+#define GWDT_WCS_EN         BIT(0)
+#define GWDT_WCS_WS0        BIT(1)
+#define GWDT_WCS_WS1        BIT(2)
+
+#define GWDT_ID_VALUE       0x1043B
+
+static uint32_t ctrl_read(uint32_t offset)
+{
+    return readl(GWDT_CONTROL_BASE + offset);
+}
+
+static void ctrl_write(uint32_t offset, uint32_t value)
+{
+    writel(GWDT_CONTROL_BASE + offset, value);
+}
+
+static void refresh_write(uint32_t offset, uint32_t value)
+{
+    writel(GWDT_REFRESH_BASE + offset, value);
+}
+
+static void reset(void)
+{
+    qtest_system_reset(global_qtest);
+}
+
+/* Convert watchdog ticks to nanoseconds */
+static int64_t gwdt_ticks(uint32_t ticks)
+{
+    QDict *resp = qmp("{ 'execute': 'qom-get', 'arguments':"
+                      "{ 'path': '/machine/peripheral/gwdt',"
+                      "'property': 'clock-frequency' }}");
+    uint64_t freq = qdict_get_uint(resp, "return");
+    qobject_unref(resp);
+    return muldiv64(ticks, NANOSECONDS_PER_SECOND, freq);
+}
+
+static void test_identification(void)
+{
+    g_assert_cmphex(ctrl_read(GWDT_W_IIDR), ==, GWDT_ID_VALUE);
+    g_assert_cmphex(readl(GWDT_REFRESH_BASE + GWDT_W_IIDR), ==, GWDT_ID_VALUE);
+}
+
+static void test_enable_disable(void)
+{
+    uint32_t wcs;
+
+    reset();
+
+    ctrl_write(GWDT_WORL, 0);
+    ctrl_write(GWDT_WORH, 0xF0000000);
+
+    ctrl_write(GWDT_WCS, GWDT_WCS_EN);
+    wcs = ctrl_read(GWDT_WCS);
+    g_assert_cmphex(wcs & GWDT_WCS_EN, ==, GWDT_WCS_EN);
+
+    ctrl_write(GWDT_WCS, 0);
+    wcs = ctrl_read(GWDT_WCS);
+    g_assert_cmphex(wcs & GWDT_WCS_EN, ==, 0);
+
+    /* make sure no timer is armed after disable */
+    clock_step_next();
+    wcs = ctrl_read(GWDT_WCS);
+    g_assert_cmphex(wcs & GWDT_WCS_WS0, ==, 0);
+}
+
+static void test_refresh(void)
+{
+    uint32_t wcs;
+    const uint32_t wor = 100000;
+    const int64_t timeout = gwdt_ticks(wor);
+
+    reset();
+
+    ctrl_write(GWDT_WORL, wor);
+    ctrl_write(GWDT_WORH, 0);
+    ctrl_write(GWDT_WCS, GWDT_WCS_EN);
+
+    /* advance to before the deadline */
+    clock_step(timeout - 1);
+    wcs = ctrl_read(GWDT_WCS);
+    g_assert_cmphex(wcs & GWDT_WCS_WS0, ==, 0);
+
+    /* extend deadline and advance now to deadline - 1 */
+    refresh_write(GWDT_WRR, 0);
+    clock_step(timeout - 1);
+    wcs = ctrl_read(GWDT_WCS);
+    g_assert_cmphex(wcs & GWDT_WCS_WS0, ==, 0);
+
+    /* make sure that gwdt triggers on refresh deadline */
+    clock_step(1);
+    wcs = ctrl_read(GWDT_WCS);
+    g_assert_cmphex(wcs & GWDT_WCS_WS0, ==, GWDT_WCS_WS0);
+}
+
+static void test_wcv_load(void)
+{
+    uint32_t wcs;
+    const uint32_t wor = 10000;
+    const int64_t timeout = gwdt_ticks(wor);
+    int64_t now, deadline;
+
+    reset();
+
+    ctrl_write(GWDT_WORL, wor);
+    ctrl_write(GWDT_WORH, 0);
+    ctrl_write(GWDT_WCS, GWDT_WCS_EN);
+
+    /* explicit WCV refresh */
+    now = clock_step(1);
+    deadline = now + 2 * timeout;
+    ctrl_write(GWDT_WCVH, deadline >> 32);
+    ctrl_write(GWDT_WCVL, deadline);
+    wcs = ctrl_read(GWDT_WCS);
+    g_assert_cmphex(wcs & GWDT_WCS_WS0, ==, 0);
+
+    /* initial WOR deadline, no WS0 yet as WCV load pushed it further */
+    clock_step(timeout);
+    wcs = ctrl_read(GWDT_WCS);
+    g_assert_cmphex(wcs & GWDT_WCS_WS0, ==, 0);
+
+    /* right before WCV deadline, no WS0 */
+    clock_step(timeout - 1);
+    wcs = ctrl_read(GWDT_WCS);
+    g_assert_cmphex(wcs & GWDT_WCS_WS0, ==, 0);
+
+    /* advance to WCV deadline, WS0 is triggered */
+    clock_step(1);
+    wcs = ctrl_read(GWDT_WCS);
+    g_assert_cmphex(wcs & GWDT_WCS_WS0, ==, GWDT_WCS_WS0);
+}
+
+static void test_ws0_timeout(void)
+{
+    uint32_t wcs;
+
+    reset();
+
+    ctrl_write(GWDT_WORL, 10000);
+    ctrl_write(GWDT_WORH, 0);
+
+    ctrl_write(GWDT_WCS, GWDT_WCS_EN);
+    wcs = ctrl_read(GWDT_WCS);
+    g_assert_cmphex(wcs & GWDT_WCS_WS0, ==, 0);
+
+    /* advance clock to WS0 deadline */
+    clock_step_next();
+    wcs = ctrl_read(GWDT_WCS);
+    g_assert_cmphex(wcs & GWDT_WCS_WS0, ==, GWDT_WCS_WS0);
+}
+
+static void test_ws1_timeout(void)
+{
+    uint32_t wcs;
+
+    reset();
+
+    ctrl_write(GWDT_WORL, 10000);
+    ctrl_write(GWDT_WORH, 0);
+    ctrl_write(GWDT_WCS, GWDT_WCS_EN);
+
+    /* WS0 deadline test */
+    clock_step_next();
+    wcs = ctrl_read(GWDT_WCS);
+    g_assert_cmphex(wcs & GWDT_WCS_WS0, ==, GWDT_WCS_WS0);
+    g_assert_cmphex(wcs & GWDT_WCS_WS1, ==, 0);
+
+    /* WS1 deadline test */
+    clock_step_next();
+    wcs = ctrl_read(GWDT_WCS);
+    g_assert_cmphex(wcs & GWDT_WCS_WS0, ==, GWDT_WCS_WS0);
+    g_assert_cmphex(wcs & GWDT_WCS_WS1, ==, GWDT_WCS_WS1);
+}
+
+int main(int argc, char **argv)
+{
+    int ret;
+    const char *arch = qtest_get_arch();
+
+    g_test_init(&argc, &argv, NULL);
+
+    if (strcmp(arch, "aarch64") || !qtest_has_machine("virt")) {
+        g_test_skip("'aarch64/virt' machine is not available");
+        return 0;
+    }
+
+    qtest_add_func("/sbsa-gwdt/identification", test_identification);
+    qtest_add_func("/sbsa-gwdt/enable-disable", test_enable_disable);
+    qtest_add_func("/sbsa-gwdt/refresh", test_refresh);
+    qtest_add_func("/sbsa-gwdt/wcv-load", test_wcv_load);
+    qtest_add_func("/sbsa-gwdt/ws0-timeout", test_ws0_timeout);
+    qtest_add_func("/sbsa-gwdt/ws1-timeout", test_ws1_timeout);
+
+    qtest_start("-M virt -cpu max -device sbsa-gwdt,id=gwdt "
+                "-watchdog-action none");
+    ret = g_test_run();
+    qtest_end();
+
+    return ret;
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 2d01837ff29..46685d6d46f 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -292,6 +292,7 @@ qtests_aarch64 = \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_ARM_VIRT') ?
    ['iommu-smmuv3-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_WDT_SBSA') ? ['sbsa-gwdt-test'] : []) + \
   qtests_cxl +                                                                                  \
   ['arm-cpu-features',
    'numa-test',
-- 
2.43.0


