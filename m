Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12EBACED24D
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 01:24:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxyuo-0007qZ-D3; Mon, 07 Oct 2024 21:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3q4gEZwUKCg47o9w3u22uzs.q204s08-rs9sz121u18.25u@flex--tavip.bounces.google.com>)
 id 1sxyt6-0000c9-Ax
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 21:19:44 -0400
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3q4gEZwUKCg47o9w3u22uzs.q204s08-rs9sz121u18.25u@flex--tavip.bounces.google.com>)
 id 1sxyt3-0000HA-R1
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 21:19:44 -0400
Received: by mail-pf1-x44a.google.com with SMTP id
 d2e1a72fcca58-71e11abb22aso518153b3a.1
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 18:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1728350380; x=1728955180; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=49FquaWPsQCXDvZ+9iOGQgsSq0aM4lH+3lh+RTdFI2o=;
 b=ZbGg8t+qbV8sonNVz0B5vAy1Q0OrO5tMy1xHL4d5DTHJstdZK0I3leAavZ7yUwJ5/K
 HzzcIG0Emk/za25DfQrPu4xxJWzP9b5d8Apai9CO3wWRVSCIG8/rv2QWPVH0csLuYVcm
 GMh2PhjyZ1COo381ynQF4BUECvcjCRnXXiQCR33b4NvfKLEPB8h2qZ10uDfkUG0o1IKH
 hUFSpHWyeuCGAEyfwZA8w5r8JBMFwesiVKsC9vGt0ByRTH1sx88VE+OIZA9uC3061nx/
 jBeEqqvcyqYy1S9CQEi/lp0TNLawL8sa0N6AJsf7O0qu9ccT1m5CUfliHJ7j6/Qshbqd
 nHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728350380; x=1728955180;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=49FquaWPsQCXDvZ+9iOGQgsSq0aM4lH+3lh+RTdFI2o=;
 b=kN7aUTSKEOpU4Gf12JSfxUUo4KvXdTkpD1YnXJrcZIgtKaFYrnqRnCLTz3m/EMPatc
 M87MVvbvq4GyxhvvM56bNu/8/BiK5PFeSjUT7IORxyPRVT7y2F/P6A/mHKzpn+tRc4cS
 Okj8kIzsbHhjGCKA9gWHR4oDz3CALEq2ZX8NCW94UjzqgagO1c4IXbQHav0+VLmuytBl
 ix4c2NON2PyFSJkSD56hMW6ngpk7X101z00MZm9qxh/8Wt9SmG7yB+QtBXNcHY9fohCs
 /9/J5XAjyVEna5cc5I/7OzVpQycaQyJnTRYKF3kejTFjezvBUP++EeJ+YTiZ9mt9ILUF
 pTKQ==
X-Gm-Message-State: AOJu0Yz7/DheuOcfHVxyQ9dpJkLQMcS+MIAIWKnEK9rRn2Z/gDcoLE6C
 9kcr/Kve4s3A7jtzeULvdr1gRMjnLIjvKX62h8SsN7wa72QzlULbTHKjS1zqY6YS0j3v7Z/4VcH
 69kYiezcxHmtTzUuPS78mJSysypWfB+tbeCY+TVHGgy4CXfohyVvlj7VGGGbRWEAbnIxDRdoCjm
 1KEOQb3tCgXPa1sWYNyxmyYTfyNQ==
X-Google-Smtp-Source: AGHT+IHJH7MDeTk7Nh7rloj7vbrxdaiHNNx6zsfSUnM9QveGoJqzgfjpJEuaUwn1zp3dxVmynOyZGpE3ag==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a05:6a00:324b:b0:71d:eb98:7341
 with SMTP id
 d2e1a72fcca58-71deb987431mr22279b3a.2.1728350379687; Mon, 07 Oct 2024
 18:19:39 -0700 (PDT)
Date: Mon,  7 Oct 2024 18:18:51 -0700
In-Reply-To: <20241008011852.1439154-1-tavip@google.com>
Mime-Version: 1.0
References: <20241008011852.1439154-1-tavip@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241008011852.1439154-26-tavip@google.com>
Subject: [PATCH v2 25/25] tests/qtest: add tests for RT500's clock controller
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr, 
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org, jsnow@redhat.com, 
 crosa@redhat.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::44a;
 envelope-from=3q4gEZwUKCg47o9w3u22uzs.q204s08-rs9sz121u18.25u@flex--tavip.bounces.google.com;
 helo=mail-pf1-x44a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.024,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

Add test to exercise clocks set and clear, system PLL initialization,
audio PLL initialization, systick and ostimer clock source selection.

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 tests/qtest/rt500-clkctl-test.c | 195 ++++++++++++++++++++++++++++++++
 tests/qtest/meson.build         |   1 +
 2 files changed, 196 insertions(+)
 create mode 100644 tests/qtest/rt500-clkctl-test.c

diff --git a/tests/qtest/rt500-clkctl-test.c b/tests/qtest/rt500-clkctl-test.c
new file mode 100644
index 0000000000..d5b83d81da
--- /dev/null
+++ b/tests/qtest/rt500-clkctl-test.c
@@ -0,0 +1,195 @@
+/*
+ * Copyright (c) 2024 Google LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/main-loop.h"
+#include "exec/memory.h"
+#include "hw/clock.h"
+#include "hw/irq.h"
+#include "hw/qdev-clock.h"
+#include "hw/qdev-properties.h"
+
+#include "hw/misc/rt500_clkctl0.h"
+#include "hw/misc/rt500_clkctl1.h"
+#include "hw/misc/rt500_clk_freqs.h"
+#include "hw/arm/svd/rt500.h"
+#include "reg-utils.h"
+
+#define SYSCLK_HZ 200000000
+#define CLKCTL0_NAME "/machine/soc/clkctl0"
+#define CLKCTL1_NAME "/machine/soc/clkctl1"
+
+static void pscctl_test(gconstpointer user_data)
+{
+    /* rom controller clock should be enabled at reset */
+    g_assert(REG32_READ_FIELD(RT500_CLKCTL0, PSCCTL0, ROM_CTRLR_CLK) == 1);
+
+    /* DSP clk is disabled at reset */
+    g_assert(REG32_READ_FIELD(RT500_CLKCTL0, PSCCTL0, DSP_CLK) == 0);
+
+    /* check PSCTL_SET functionality */
+    REG32_WRITE_FIELD_NOUPDATE(RT500_CLKCTL0, PSCCTL0_SET, DSP_CLK, 1);
+    g_assert(REG32_READ_FIELD(RT500_CLKCTL0, PSCCTL0, DSP_CLK) == 1);
+
+    /* check PSCTL_CLR functionality */
+    REG32_WRITE_FIELD_NOUPDATE(RT500_CLKCTL0, PSCCTL0_CLR, DSP_CLK, 1);
+    g_assert(REG32_READ_FIELD(RT500_CLKCTL0, PSCCTL0, DSP_CLK) == 0);
+
+    /* FLEXIO clk is disabled at reset */
+    g_assert(REG32_READ_FIELD(RT500_CLKCTL1, PSCCTL0, FlexIO) == 0);
+
+    /* check PSCTL_SET functionality */
+    REG32_WRITE_FIELD_NOUPDATE(RT500_CLKCTL1, PSCCTL0_SET, FlexIO, 1);
+    g_assert(REG32_READ_FIELD(RT500_CLKCTL1, PSCCTL0, FlexIO) == 1);
+
+    /* check PSCTL_CLR functionality */
+    REG32_WRITE_FIELD_NOUPDATE(RT500_CLKCTL1, PSCCTL0_CLR, FlexIO, 1);
+    g_assert(REG32_READ_FIELD(RT500_CLKCTL1, PSCCTL0, FlexIO) == 0);
+}
+
+static void audiopll0pfd_test(gconstpointer user_data)
+{
+    /*  audio plls are gated at boot */
+    g_assert(REG32_READ_FIELD(RT500_CLKCTL1, AUDIOPLL0PFD, PFD3_CLKGATE) == 1);
+    g_assert(REG32_READ_FIELD(RT500_CLKCTL1, AUDIOPLL0PFD, PFD2_CLKGATE) == 1);
+    g_assert(REG32_READ_FIELD(RT500_CLKCTL1, AUDIOPLL0PFD, PFD1_CLKGATE) == 1);
+    g_assert(REG32_READ_FIELD(RT500_CLKCTL1, AUDIOPLL0PFD, PFD0_CLKGATE) == 1);
+
+    /*  ,,, and clocks are not ready */
+    g_assert(REG32_READ_FIELD(RT500_CLKCTL1, AUDIOPLL0PFD, PFD3_CLKRDY) == 0);
+    g_assert(REG32_READ_FIELD(RT500_CLKCTL1, AUDIOPLL0PFD, PFD2_CLKRDY) == 0);
+    g_assert(REG32_READ_FIELD(RT500_CLKCTL1, AUDIOPLL0PFD, PFD1_CLKRDY) == 0);
+    g_assert(REG32_READ_FIELD(RT500_CLKCTL1, AUDIOPLL0PFD, PFD0_CLKRDY) == 0);
+
+    /* ungate all plls and check that clocks are ready */
+    REG32_WRITE_FIELD(RT500_CLKCTL1, AUDIOPLL0PFD, PFD3_CLKGATE, 0);
+    REG32_WRITE_FIELD(RT500_CLKCTL1, AUDIOPLL0PFD, PFD2_CLKGATE, 0);
+    REG32_WRITE_FIELD(RT500_CLKCTL1, AUDIOPLL0PFD, PFD1_CLKGATE, 0);
+    REG32_WRITE_FIELD(RT500_CLKCTL1, AUDIOPLL0PFD, PFD0_CLKGATE, 0);
+
+    g_assert(REG32_READ_FIELD(RT500_CLKCTL1, AUDIOPLL0PFD, PFD3_CLKRDY) == 1);
+    g_assert(REG32_READ_FIELD(RT500_CLKCTL1, AUDIOPLL0PFD, PFD2_CLKRDY) == 1);
+    g_assert(REG32_READ_FIELD(RT500_CLKCTL1, AUDIOPLL0PFD, PFD1_CLKRDY) == 1);
+    g_assert(REG32_READ_FIELD(RT500_CLKCTL1, AUDIOPLL0PFD, PFD0_CLKRDY) == 1);
+}
+
+static void syspll0pfd_test(gconstpointer user_data)
+{
+    /*  system plls are gated at boot */
+    g_assert(REG32_READ_FIELD(RT500_CLKCTL0, SYSPLL0PFD, PFD3_CLKGATE) == 1);
+    g_assert(REG32_READ_FIELD(RT500_CLKCTL0, SYSPLL0PFD, PFD2_CLKGATE) == 1);
+    g_assert(REG32_READ_FIELD(RT500_CLKCTL0, SYSPLL0PFD, PFD1_CLKGATE) == 1);
+    g_assert(REG32_READ_FIELD(RT500_CLKCTL0, SYSPLL0PFD, PFD0_CLKGATE) == 1);
+
+    /*  ,,, and clocks are not ready */
+    g_assert(REG32_READ_FIELD(RT500_CLKCTL0, SYSPLL0PFD, PFD3_CLKRDY) == 0);
+    g_assert(REG32_READ_FIELD(RT500_CLKCTL0, SYSPLL0PFD, PFD2_CLKRDY) == 0);
+    g_assert(REG32_READ_FIELD(RT500_CLKCTL0, SYSPLL0PFD, PFD1_CLKRDY) == 0);
+    g_assert(REG32_READ_FIELD(RT500_CLKCTL0, SYSPLL0PFD, PFD0_CLKRDY) == 0);
+
+    /* ungate all plls and check that clocks are ready */
+    REG32_WRITE_FIELD(RT500_CLKCTL0, SYSPLL0PFD, PFD3_CLKGATE, 0);
+    REG32_WRITE_FIELD(RT500_CLKCTL0, SYSPLL0PFD, PFD2_CLKGATE, 0);
+    REG32_WRITE_FIELD(RT500_CLKCTL0, SYSPLL0PFD, PFD1_CLKGATE, 0);
+    REG32_WRITE_FIELD(RT500_CLKCTL0, SYSPLL0PFD, PFD0_CLKGATE, 0);
+
+    g_assert(REG32_READ_FIELD(RT500_CLKCTL0, SYSPLL0PFD, PFD3_CLKRDY) == 1);
+    g_assert(REG32_READ_FIELD(RT500_CLKCTL0, SYSPLL0PFD, PFD2_CLKRDY) == 1);
+    g_assert(REG32_READ_FIELD(RT500_CLKCTL0, SYSPLL0PFD, PFD1_CLKRDY) == 1);
+    g_assert(REG32_READ_FIELD(RT500_CLKCTL0, SYSPLL0PFD, PFD0_CLKRDY) == 1);
+}
+
+static void systick_clk_test(gconstpointer user_data)
+{
+    /* systick is not running at reset */
+    g_assert_cmpuint(dev_clock_out_get_hz(CLKCTL0_NAME, "systick_clk"), ==, 0);
+
+    /* select divout no divisor */
+    REG32_WRITE_FIELD(RT500_CLKCTL0, SYSTICKFCLKSEL, SEL,
+                      SYSTICKFCLKSEL_DIVOUT);
+    g_assert_cmpuint(dev_clock_out_get_hz(CLKCTL0_NAME, "systick_clk"),
+                     ==, SYSCLK_HZ);
+
+    /* change divisor to 2 */
+    REG32_WRITE_FIELD(RT500_CLKCTL0, SYSTICKFCLKDIV, DIV, 1);
+    g_assert_cmpuint(dev_clock_out_get_hz(CLKCTL0_NAME, "systick_clk"),
+                     ==, SYSCLK_HZ / 2);
+
+    /* select lpsoc */
+    REG32_WRITE_FIELD(RT500_CLKCTL0, SYSTICKFCLKSEL, SEL,
+                      SYSTICKFCLKSEL_LPOSC);
+    g_assert_cmpuint(dev_clock_out_get_hz(CLKCTL0_NAME, "systick_clk"),
+                     ==, LPOSC_CLK_HZ);
+
+    /* select lpsoc */
+    REG32_WRITE_FIELD(RT500_CLKCTL0, SYSTICKFCLKSEL, SEL,
+                      SYSTICKFCLKSEL_32KHZRTC);
+    g_assert_cmpuint(dev_clock_out_get_hz(CLKCTL0_NAME, "systick_clk"),
+                     ==, RTC32KHZ_CLK_HZ);
+
+    /* disable clock */
+    REG32_WRITE_FIELD(RT500_CLKCTL0, SYSTICKFCLKSEL, SEL,
+                      SYSTICKFCLKSEL_NONE);
+    g_assert_cmpuint(dev_clock_out_get_hz(CLKCTL0_NAME, "systick_clk"),
+                     ==, 0);
+}
+
+static void ostimer_clk_test(gconstpointer user_data)
+{
+    /* systick is not running at reset */
+    g_assert_cmpuint(dev_clock_out_get_hz(CLKCTL1_NAME, "ostimer_clk"), ==, 0);
+
+    /* select lpsoc */
+    REG32_WRITE_FIELD(RT500_CLKCTL1, OSEVENTTFCLKSEL, SEL,
+                      OSEVENTTFCLKSEL_LPOSC);
+    g_assert_cmpuint(dev_clock_out_get_hz(CLKCTL1_NAME, "ostimer_clk"), ==,
+                     LPOSC_CLK_HZ);
+
+    /* select 32khz RTC */
+    REG32_WRITE_FIELD(RT500_CLKCTL1, OSEVENTTFCLKSEL, SEL,
+                      OSEVENTTFCLKSEL_32KHZRTC);
+    g_assert_cmpuint(dev_clock_out_get_hz(CLKCTL1_NAME, "ostimer_clk"), ==,
+                     RTC32KHZ_CLK_HZ);
+
+    /* select hclk */
+    REG32_WRITE_FIELD(RT500_CLKCTL1, OSEVENTTFCLKSEL, SEL,
+                      OSEVENTTFCLKSEL_HCLK);
+    g_assert_cmpuint(dev_clock_out_get_hz(CLKCTL1_NAME, "ostimer_clk"), ==,
+                     SYSCLK_HZ);
+
+    /* disable clock */
+    REG32_WRITE_FIELD(RT500_CLKCTL1, OSEVENTTFCLKSEL, SEL,
+                      OSEVENTTFCLKSEL_NONE);
+    g_assert_cmpuint(dev_clock_out_get_hz(CLKCTL1_NAME, "ostimer_clk"), ==, 0);
+}
+
+int main(int argc, char **argv)
+{
+    int ret;
+
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_data_func("/rt500-clkctl/pscctl-test", NULL, pscctl_test);
+    qtest_add_data_func("/rt500-clkctl/syspll0pfd-test", NULL,
+                        syspll0pfd_test);
+    qtest_add_data_func("/rt500-clkctl/audiopll0pfd-test", NULL,
+                        audiopll0pfd_test);
+    g_test_add_data_func("/rt500-clkctl/systick-test", NULL,
+                         systick_clk_test);
+    g_test_add_data_func("/rt500-clkctl/ostimer-clk-test", NULL,
+                         ostimer_clk_test);
+
+    qtest_start("-M rt595-evk");
+    ret = g_test_run();
+    qtest_end();
+
+    return ret;
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index d3bf33b855..1a2d2ca3e1 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -234,6 +234,7 @@ qtests_arm = \
   (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') and
    config_all_devices.has_key('CONFIG_DM163')? ['dm163-test'] : []) + \
   (config_all_devices.has_key('CONFIG_FLEXCOMM') ? ['flexcomm-test', 'flexcomm-usart-test', 'flexcomm-i2c-test', 'flexcomm-spi-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_RT500_CLKCTL') ? ['rt500-clkctl-test'] : []) + \
   ['arm-cpu-features',
    'boot-serial-test']
 
-- 
2.47.0.rc0.187.ge670bccf7e-goog


