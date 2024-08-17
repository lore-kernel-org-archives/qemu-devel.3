Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14BBCC531DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2024 10:31:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfGeJ-000829-Ay; Sat, 17 Aug 2024 06:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <35HrAZgUKChkIzK7E5DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--tavip.bounces.google.com>)
 id 1sfGe4-0006um-Rr
 for qemu-devel@nongnu.org; Sat, 17 Aug 2024 06:26:56 -0400
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <35HrAZgUKChkIzK7E5DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--tavip.bounces.google.com>)
 id 1sfGe0-0003KW-0q
 for qemu-devel@nongnu.org; Sat, 17 Aug 2024 06:26:52 -0400
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-201f2de64ddso22990985ad.2
 for <qemu-devel@nongnu.org>; Sat, 17 Aug 2024 03:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1723890404; x=1724495204; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=mcVKhHeKnXv9oLOMcrl7o+6UIgPmeBUOImgu4ezoYKI=;
 b=B7sKmB0em2awQMxXONuIcBvBWuKzGSjU+bCIx7Ttja1NE2tLsyowlxSKK9FXHZg9F+
 KuGOGzxcIPtZmmlEcnqX8i8M3snK7MHtW/R+CZ5DYrrpo8g5Bn9xpLMDD1YZy8DvLBBG
 I9+VuI+3KAiK2vQ6yHnxPDBbtR9H62/PoTvW/hKyjuYs3olM8rLRnTm+8PhMaI73dSPA
 cJPgaH9nOOjwKVap7IB5T2t4xadX4u8QOClXhFPoib+RThikAJU5J2VhuWqea6ZCuA7J
 m4XxhdLU2vH5Nbza2MvU/9ne05r07FvgzhHOZs764vElZzA9GEnnBpbmEk+9NLJjvUsD
 LUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723890404; x=1724495204;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mcVKhHeKnXv9oLOMcrl7o+6UIgPmeBUOImgu4ezoYKI=;
 b=MeXhb2rC7OODY74eqcqtUyU3UIYbvbqeQhUcmnmwTMD8zfATUJKacfNlVe8qz/Xzid
 Z1KLl4l59edStreF49vZH1FPw0Tg8qsoa8ZZE9VRRz4bTEPrREgJJj1iFXcsTPrvJSCr
 f7tuVA2BJGYMz+W83mIFKHVaWDYMaEYDyapBGkJBqWjb/VilWn8jYnrSzuEofv5sZa5I
 5Xr/FAxqMRpILv8pH++SdYgmHR3hphvlMmt6uRsj1aBHuCin8O5GWFy+wwcKWx7zICsJ
 h8dVX/wdfvdofN/TBVLZHjMqFRTmqS8MlC53LvxI9kaub29DpKsXQuDbqE4BgLrujEE/
 Hz7g==
X-Gm-Message-State: AOJu0YyUMwBYw/6YrWHxlCFqNUTqNkLQTYN0h50RsqpsUdGD2xlvFasH
 PgL3nXh02aXKrorkWJix1qwpBjTUicXehdzz1tLmVbfizqXpfK3zGIC+yGbk53EbGsMbccMZWcI
 kTgZdVVg4oDFAIZ+Budr5pCU2zeGR1wfE4u6JBz9JnwrVXstt2WYy/+TcZmN9ueGTx44/gaPww4
 mmWZd5hb3ru62h+15up7Dok/nFAg==
X-Google-Smtp-Source: AGHT+IGJOINOxIiNVKUvoeKf0wFi2wdRJelFs+BRPnOPJ46Lh4RImprb8D8GKACX+uAwa7/5Cp+gQgok4w==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a17:903:2310:b0:1fa:d491:a4a0
 with SMTP id
 d9443c01a7336-20203e49592mr5326705ad.2.1723890404035; Sat, 17 Aug 2024
 03:26:44 -0700 (PDT)
Date: Sat, 17 Aug 2024 03:26:02 -0700
In-Reply-To: <20240817102606.3996242-1-tavip@google.com>
Mime-Version: 1.0
References: <20240817102606.3996242-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240817102606.3996242-20-tavip@google.com>
Subject: [RFC PATCH v2 19/23] test/unit: add unit tests for RT500's clock
 controller
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 thuth@redhat.com, peter.maydell@linaro.org, marcandre.lureau@redhat.com, 
 alistair@alistair23.me, berrange@redhat.com, philmd@linaro.org, 
 jsnow@redhat.com, crosa@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=35HrAZgUKChkIzK7E5DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--tavip.bounces.google.com;
 helo=mail-pl1-x649.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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
 tests/unit/test-rt500-clkctl.c | 263 +++++++++++++++++++++++++++++++++
 tests/unit/meson.build         |   7 +
 2 files changed, 270 insertions(+)
 create mode 100644 tests/unit/test-rt500-clkctl.c

diff --git a/tests/unit/test-rt500-clkctl.c b/tests/unit/test-rt500-clkctl.c
new file mode 100644
index 0000000000..c02c349e52
--- /dev/null
+++ b/tests/unit/test-rt500-clkctl.c
@@ -0,0 +1,263 @@
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
+    REG32_WRITE_FIELD_NOUPDATE(f->clk0, RT500_CLKCTL0, PSCCTL0_SET, DSP_CLK, 1);
+    g_assert(REG32_READ_FIELD(f->clk0, RT500_CLKCTL0, PSCCTL0, DSP_CLK) == 1);
+
+    /* check PSCTL_CLR functionality */
+    REG32_WRITE_FIELD_NOUPDATE(f->clk0, RT500_CLKCTL0, PSCCTL0_CLR, DSP_CLK, 1);
+    g_assert(REG32_READ_FIELD(f->clk0, RT500_CLKCTL0, PSCCTL0, DSP_CLK) == 0);
+
+    /* FLEXIO clk is disabled at reset */
+    g_assert(REG32_READ_FIELD(f->clk1, RT500_CLKCTL1, PSCCTL0, FlexIO) == 0);
+
+    /* check PSCTL_SET functionality */
+    REG32_WRITE_FIELD_NOUPDATE(f->clk1, RT500_CLKCTL1, PSCCTL0_SET, FlexIO, 1);
+    g_assert(REG32_READ_FIELD(f->clk1, RT500_CLKCTL1, PSCCTL0, FlexIO) == 1);
+
+    /* check PSCTL_CLR functionality */
+    REG32_WRITE_FIELD_NOUPDATE(f->clk1, RT500_CLKCTL1, PSCCTL0_CLR, FlexIO, 1);
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
-- 
2.46.0.184.g6999bdac58-goog


