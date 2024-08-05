Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C7E0C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 20:19:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb49j-0005QD-PK; Mon, 05 Aug 2024 16:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3cjOxZgUKCtkO5QDKBJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--tavip.bounces.google.com>)
 id 1sb49c-0004XO-So
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 16:18:05 -0400
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3cjOxZgUKCtkO5QDKBJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--tavip.bounces.google.com>)
 id 1sb49X-0001Wt-Rr
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 16:18:04 -0400
Received: by mail-pg1-x549.google.com with SMTP id
 41be03b00d2f7-7a267d9e7b0so8383193a12.2
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 13:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1722889076; x=1723493876; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=TDXUM/DnNUUyn6pHbVPdEoD8ZybpFrPwu+WD1vFxHS8=;
 b=P0jeBNKe9VJyfd1tjbon6jVJ51NGTCE0bMyIsbeVWloxuS+i+nn3m2x6yUfNzXI+q7
 iD4UPUytwT/nzlNKXFPbk/Mi+QQzUBsUQ4HvE1qXPK2ZLTSN7apz4BSPDl1YNl5vu1LD
 4oMOgu2OsV+IxdC2NjVuRTlsBo1EWvIXjQDhuf+o6mX8lLZ6bMKnJF3VBVniicBXdR1w
 ZrbETAwTRbhNR0b91BaNWcf59vI9RvGKYDH8AKeHwRWtVhISCKgvcrVKIhPujT4KE1On
 ZZUd3KGnh2Q1mgsBduQR2AQlEr3pyX5jDrFwYMlth+0x6U+Dmmp0pOlS1jGvVvWD5KTC
 szcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722889076; x=1723493876;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TDXUM/DnNUUyn6pHbVPdEoD8ZybpFrPwu+WD1vFxHS8=;
 b=PQJV//NG4jrYcFG0fjhyy1Ma4uLWkf4UiQUUYaLVLlHInM6aSoRuM3wLTrQKHt+hQR
 Dp/FjQaZQAQZNq/IHSXcYxBeezCisTu9vG5JNOjo1d1Ss7vaCtlnNh6++sGHj1UYHKIU
 KHtVkDt1ei3EtuwOBVeqdOnvGcwNrdYXwzOaaFLN2QVzMYfGuc+KsoRSei+t308kI3i4
 EIlh2taL3U+Jlf6F8X8XsYgzOK09JMgoYjA2NDakqQrGXLrsVSRyFEpDstzAOJhbmDD4
 FlJppJbF8tM86zgDVUJoU5RaD+hjXEXOe3rEfV+acO2YMVBfK7CplfbjNW8ERApAM/+0
 XB3g==
X-Gm-Message-State: AOJu0Yza65vlPuew7f9Acgd8sxOjZkC9y4xTzyuOaBRvIX62zBTOWmZT
 VecGjRbvBhFw22GM2zMuYCPgLahC4rD3gTBFsdFh5e24zpT8QVZb402L08MMktuTDq7sh+2W0W5
 HXcn4wISeNg58bJ4UakpxpYaVzkxi3udXIc7OhgM0bKJLnWGzZUR6POF0behZlhWdoIXf8X6NSy
 8r2MZLH6wJzA6/SLTJGqXo0/N82w==
X-Google-Smtp-Source: AGHT+IFnbKW0982idR2ThGvBGZQLmLXkxC9szOhbfZs08+ppAvucuotVSSXrQPXEto+7IAj1EGypCgRzBg==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a17:90b:1b05:b0:2ca:7e66:2d90
 with SMTP id
 98e67ed59e1d1-2cff955f924mr72168a91.7.1722889074724; Mon, 05 Aug 2024
 13:17:54 -0700 (PDT)
Date: Mon,  5 Aug 2024 13:17:14 -0700
In-Reply-To: <20240805201719.2345596-1-tavip@google.com>
Mime-Version: 1.0
References: <20240805201719.2345596-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240805201719.2345596-20-tavip@google.com>
Subject: [RFC PATCH 19/23] test/unit: add unit tests for RT500's clock
 controller
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 alex.bennee@linaro.org, thuth@redhat.com, peter.maydell@linaro.org, 
 marcandre.lureau@redhat.com, alistair@alistair23.me, berrange@redhat.com, 
 philmd@linaro.org, jsnow@redhat.com, crosa@redhat.com, bleal@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::549;
 envelope-from=3cjOxZgUKCtkO5QDKBJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--tavip.bounces.google.com;
 helo=mail-pg1-x549.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
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
 tests/unit/meson.build         |   7 +
 tests/unit/test-rt500-clkctl.c | 270 +++++++++++++++++++++++++++++++++
 2 files changed, 277 insertions(+)
 create mode 100644 tests/unit/test-rt500-clkctl.c

diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index 7a28e7b521..be3062acbf 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -188,6 +188,13 @@ if have_system
       meson.project_source_root() / 'hw/ssi/ssi.c',
       'spi_tester.c',
     ],
+    'test-rt500-clkctl': [
+      hwcore,
+      meson.project_source_root() / 'hw/core/gpio.c',
+      meson.project_source_root() / 'hw/misc/rt500_clkctl0.c',
+      meson.project_source_root() / 'hw/misc/rt500_clkctl1.c',
+      meson.project_source_root() / 'tests/unit/sysbus-mock.c',
+    ],
   }
   if config_host_data.get('CONFIG_INOTIFY1')
     tests += {'test-util-filemonitor': []}
diff --git a/tests/unit/test-rt500-clkctl.c b/tests/unit/test-rt500-clkctl.c
new file mode 100644
index 0000000000..9312091c46
--- /dev/null
+++ b/tests/unit/test-rt500-clkctl.c
@@ -0,0 +1,270 @@
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
+#include "sysbus-mock.h"
+#include "reg-utils.h"
+
+typedef struct {
+    DeviceState *clk0;
+    DeviceState *clk1;
+    Clock *sysclk;
+    Clock *systick_clk;
+    Clock *ostimer_clk;
+} TestFixture;
+
+#define SYSCLK_HZ 100000000
+
+#define RT500_CLKCTL0_BASE 0x40001000UL
+#define RT500_CLKCTL1_BASE 0x40021000UL
+
+/*
+ * Test fixture initialization.
+ */
+static void set_up(TestFixture *f, gconstpointer data)
+{
+    f->clk0 = qdev_new(TYPE_RT500_CLKCTL0);
+    g_assert(f->clk0);
+
+    f->clk1 = qdev_new(TYPE_RT500_CLKCTL1);
+    g_assert(f->clk1);
+
+    f->sysclk = clock_new(OBJECT(&f->clk0->parent_obj), "SYSCLK");
+    clock_set_hz(f->sysclk, SYSCLK_HZ);
+
+    qdev_connect_clock_in(f->clk0, "sysclk", f->sysclk);
+    f->systick_clk = RT500_CLKCTL0(f->clk0)->systick_clk;
+
+    qdev_connect_clock_in(f->clk1, "sysclk", f->sysclk);
+    f->ostimer_clk = RT500_CLKCTL1(f->clk1)->ostimer_clk;
+
+    qdev_realize_and_unref(f->clk0, NULL, NULL);
+    sysbus_mmio_map(SYS_BUS_DEVICE(f->clk0), 0, RT500_CLKCTL0_BASE);
+
+    qdev_realize_and_unref(f->clk1, NULL, NULL);
+    sysbus_mmio_map(SYS_BUS_DEVICE(f->clk1), 0, RT500_CLKCTL1_BASE);
+
+    device_cold_reset(f->clk0);
+    device_cold_reset(f->clk1);
+}
+
+static void tear_down(TestFixture *f, gconstpointer user_data)
+{
+    qdev_unrealize(f->clk0);
+    qdev_unrealize(f->clk1);
+    g_free(f->clk0);
+    g_free(f->clk1);
+}
+
+#undef CLKCTL0
+#undef CLKCTL1
+
+static void pscctl_test(TestFixture *f, gconstpointer user_data)
+{
+    /* rom controller clock should be enabled at reset */
+    g_assert(REG32_READ_FIELD(f->clk0, RT500_CLKCTL0, PSCCTL0, ROM_CTRLR_CLK)
+             == 1);
+
+    /* DSP clk is disabled at reset */
+    g_assert(REG32_READ_FIELD(f->clk0, RT500_CLKCTL0, PSCCTL0, DSP_CLK) == 0);
+
+    /* check PSCTL_SET functionality */
+    REG32_WRITE(f->clk0, RT500_CLKCTL0, PSCCTL0_SET,
+                RT500_CLKCTL0_PSCCTL0_DSP_CLK_Msk);
+    g_assert(REG32_READ_FIELD(f->clk0, RT500_CLKCTL0, PSCCTL0, DSP_CLK) == 1);
+
+    /* check PSCTL_CLR functionality */
+    REG32_WRITE(f->clk0, RT500_CLKCTL0, PSCCTL0_CLR,
+                RT500_CLKCTL0_PSCCTL0_DSP_CLK_Msk);
+    g_assert(REG32_READ_FIELD(f->clk0, RT500_CLKCTL0, PSCCTL0, DSP_CLK) == 0);
+
+    /* FLEXIO clk is disabled at reset */
+    g_assert(REG32_READ_FIELD(f->clk1, RT500_CLKCTL1, PSCCTL0, FlexIO) == 0);
+
+    /* check PSCTL_SET functionality */
+    REG32_WRITE(f->clk1, RT500_CLKCTL1, PSCCTL0_SET,
+                RT500_CLKCTL1_PSCCTL0_FlexIO_Msk);
+    g_assert(REG32_READ_FIELD(f->clk1, RT500_CLKCTL1, PSCCTL0, FlexIO) == 1);
+
+    /* check PSCTL_CLR functionality */
+    REG32_WRITE(f->clk1, RT500_CLKCTL1, PSCCTL0_CLR,
+                RT500_CLKCTL1_PSCCTL0_FlexIO_Msk);
+    g_assert(REG32_READ_FIELD(f->clk1, RT500_CLKCTL1, PSCCTL0, FlexIO) == 0);
+}
+
+static void audiopll0pfd_test(TestFixture *f, gconstpointer user_data)
+{
+    /*  audio plls are gated at boot */
+    g_assert(REG32_READ_FIELD(f->clk1, RT500_CLKCTL1, AUDIOPLL0PFD,
+                              PFD3_CLKGATE) == 1);
+    g_assert(REG32_READ_FIELD(f->clk1, RT500_CLKCTL1, AUDIOPLL0PFD,
+                              PFD2_CLKGATE) == 1);
+    g_assert(REG32_READ_FIELD(f->clk1, RT500_CLKCTL1, AUDIOPLL0PFD,
+                              PFD1_CLKGATE) == 1);
+    g_assert(REG32_READ_FIELD(f->clk1, RT500_CLKCTL1, AUDIOPLL0PFD,
+                              PFD0_CLKGATE) == 1);
+
+    /*  ,,, and clocks are not ready */
+    g_assert(REG32_READ_FIELD(f->clk1, RT500_CLKCTL1, AUDIOPLL0PFD, PFD3_CLKRDY)
+             == 0);
+    g_assert(REG32_READ_FIELD(f->clk1, RT500_CLKCTL1, AUDIOPLL0PFD, PFD2_CLKRDY)
+             == 0);
+    g_assert(REG32_READ_FIELD(f->clk1, RT500_CLKCTL1, AUDIOPLL0PFD, PFD1_CLKRDY)
+             == 0);
+    g_assert(REG32_READ_FIELD(f->clk1, RT500_CLKCTL1, AUDIOPLL0PFD, PFD0_CLKRDY)
+             == 0);
+
+    /* ungate all plls and check that clocks are ready */
+    REG32_WRITE_FIELD(f->clk1, RT500_CLKCTL1, AUDIOPLL0PFD, PFD3_CLKGATE, 0);
+    REG32_WRITE_FIELD(f->clk1, RT500_CLKCTL1, AUDIOPLL0PFD, PFD2_CLKGATE, 0);
+    REG32_WRITE_FIELD(f->clk1, RT500_CLKCTL1, AUDIOPLL0PFD, PFD1_CLKGATE, 0);
+    REG32_WRITE_FIELD(f->clk1, RT500_CLKCTL1, AUDIOPLL0PFD, PFD0_CLKGATE, 0);
+
+    g_assert(REG32_READ_FIELD(f->clk1, RT500_CLKCTL1, AUDIOPLL0PFD, PFD3_CLKRDY)
+             == 1);
+    g_assert(REG32_READ_FIELD(f->clk1, RT500_CLKCTL1, AUDIOPLL0PFD, PFD2_CLKRDY)
+             == 1);
+    g_assert(REG32_READ_FIELD(f->clk1, RT500_CLKCTL1, AUDIOPLL0PFD, PFD1_CLKRDY)
+             == 1);
+    g_assert(REG32_READ_FIELD(f->clk1, RT500_CLKCTL1, AUDIOPLL0PFD, PFD0_CLKRDY)
+             == 1);
+}
+
+static void syspll0pfd_test(TestFixture *f, gconstpointer user_data)
+{
+    /*  system plls are gated at boot */
+    g_assert(REG32_READ_FIELD(f->clk0, RT500_CLKCTL0, SYSPLL0PFD, PFD3_CLKGATE)
+             == 1);
+    g_assert(REG32_READ_FIELD(f->clk0, RT500_CLKCTL0, SYSPLL0PFD, PFD2_CLKGATE)
+             == 1);
+    g_assert(REG32_READ_FIELD(f->clk0, RT500_CLKCTL0, SYSPLL0PFD, PFD1_CLKGATE)
+             == 1);
+    g_assert(REG32_READ_FIELD(f->clk0, RT500_CLKCTL0, SYSPLL0PFD, PFD0_CLKGATE)
+             == 1);
+
+    /*  ,,, and clocks are not ready */
+    g_assert(REG32_READ_FIELD(f->clk0, RT500_CLKCTL0, SYSPLL0PFD, PFD3_CLKRDY)
+             == 0);
+    g_assert(REG32_READ_FIELD(f->clk0, RT500_CLKCTL0, SYSPLL0PFD, PFD2_CLKRDY)
+             == 0);
+    g_assert(REG32_READ_FIELD(f->clk0, RT500_CLKCTL0, SYSPLL0PFD, PFD1_CLKRDY)
+             == 0);
+    g_assert(REG32_READ_FIELD(f->clk0, RT500_CLKCTL0, SYSPLL0PFD, PFD0_CLKRDY)
+             == 0);
+
+    /* ungate all plls and check that clocks are ready */
+    REG32_WRITE_FIELD(f->clk0, RT500_CLKCTL0, SYSPLL0PFD, PFD3_CLKGATE, 0);
+    REG32_WRITE_FIELD(f->clk0, RT500_CLKCTL0, SYSPLL0PFD, PFD2_CLKGATE, 0);
+    REG32_WRITE_FIELD(f->clk0, RT500_CLKCTL0, SYSPLL0PFD, PFD1_CLKGATE, 0);
+    REG32_WRITE_FIELD(f->clk0, RT500_CLKCTL0, SYSPLL0PFD, PFD0_CLKGATE, 0);
+
+    g_assert(REG32_READ_FIELD(f->clk0, RT500_CLKCTL0, SYSPLL0PFD, PFD3_CLKRDY)
+             == 1);
+    g_assert(REG32_READ_FIELD(f->clk0, RT500_CLKCTL0, SYSPLL0PFD, PFD2_CLKRDY)
+             == 1);
+    g_assert(REG32_READ_FIELD(f->clk0, RT500_CLKCTL0, SYSPLL0PFD, PFD1_CLKRDY)
+             == 1);
+    g_assert(REG32_READ_FIELD(f->clk0, RT500_CLKCTL0, SYSPLL0PFD, PFD0_CLKRDY)
+             == 1);
+}
+
+static void systick_clk_test(TestFixture *f, gconstpointer user_data)
+{
+    /* systick is not running at reset */
+    g_assert(clock_get_hz(f->systick_clk) == 0);
+
+    /* select divout no divisor */
+    REG32_WRITE_FIELD(f->clk0, RT500_CLKCTL0, SYSTICKFCLKSEL, SEL,
+                    SYSTICKFCLKSEL_DIVOUT);
+    g_assert(clock_get_hz(f->systick_clk) == SYSCLK_HZ);
+
+    /* change divisor to 2 */
+    REG32_WRITE_FIELD(f->clk0, RT500_CLKCTL0, SYSTICKFCLKDIV, DIV, 1);
+    g_assert(clock_get_hz(f->systick_clk) == SYSCLK_HZ / 2);
+
+    /* select lpsoc */
+    REG32_WRITE_FIELD(f->clk0, RT500_CLKCTL0, SYSTICKFCLKSEL, SEL,
+                    SYSTICKFCLKSEL_LPOSC);
+    g_assert(clock_get_hz(f->systick_clk) == LPOSC_CLK_HZ);
+
+    /* select lpsoc */
+    REG32_WRITE_FIELD(f->clk0, RT500_CLKCTL0, SYSTICKFCLKSEL, SEL,
+                    SYSTICKFCLKSEL_32KHZRTC);
+    g_assert(clock_get_hz(f->systick_clk) == RTC32KHZ_CLK_HZ);
+
+    /* disable clock */
+    REG32_WRITE_FIELD(f->clk0, RT500_CLKCTL0, SYSTICKFCLKSEL, SEL,
+                    SYSTICKFCLKSEL_NONE);
+    g_assert(clock_get_hz(f->systick_clk) == 0);
+}
+
+static void ostimer_clk_test(TestFixture *f, gconstpointer user_data)
+{
+    /* systick is not running at reset */
+    g_assert(clock_get_hz(f->ostimer_clk) == 0);
+
+    /* select lpsoc */
+    REG32_WRITE_FIELD(f->clk1, RT500_CLKCTL1, OSEVENTTFCLKSEL, SEL,
+                    OSEVENTTFCLKSEL_LPOSC);
+    g_assert(clock_get_hz(f->ostimer_clk) == LPOSC_CLK_HZ);
+
+
+    /* select 32khz RTC */
+    REG32_WRITE_FIELD(f->clk1, RT500_CLKCTL1, OSEVENTTFCLKSEL, SEL,
+                    OSEVENTTFCLKSEL_32KHZRTC);
+    g_assert(clock_get_hz(f->ostimer_clk) == RTC32KHZ_CLK_HZ);
+
+    /* select hclk */
+    REG32_WRITE_FIELD(f->clk1, RT500_CLKCTL1, OSEVENTTFCLKSEL, SEL,
+                    OSEVENTTFCLKSEL_HCLK);
+    g_assert(clock_get_hz(f->ostimer_clk) == SYSCLK_HZ);
+
+    /* disable clock */
+    REG32_WRITE_FIELD(f->clk1, RT500_CLKCTL1, OSEVENTTFCLKSEL, SEL,
+                    OSEVENTTFCLKSEL_NONE);
+    g_assert(clock_get_hz(f->ostimer_clk) == 0);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    /* Initialize object types. */
+    sysbus_mock_init();
+    module_call_init(MODULE_INIT_QOM);
+
+    g_test_add("/rt500-clkctl/pscctl-test", TestFixture, NULL,
+               set_up, pscctl_test, tear_down);
+
+    g_test_add("/rt500-clkctl/syspll0pfd-test", TestFixture, NULL,
+               set_up, syspll0pfd_test, tear_down);
+
+    g_test_add("/rt500-clkctl/audiopll0pfd-test", TestFixture, NULL,
+               set_up, audiopll0pfd_test, tear_down);
+
+    g_test_add("/rt500-clkctl/systick-test", TestFixture, NULL,
+               set_up, systick_clk_test, tear_down);
+
+    g_test_add("/rt500-clkctl/ostimer-clk-test", TestFixture, NULL,
+               set_up, ostimer_clk_test, tear_down);
+
+    return g_test_run();
+}
-- 
2.46.0.rc2.264.g509ed76dc8-goog


