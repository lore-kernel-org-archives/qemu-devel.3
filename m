Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB92DCED24E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 01:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxytc-0002zq-JK; Mon, 07 Oct 2024 21:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3kIgEZwUKCvEmTobiZhhZeX.VhfjXfn-WXoXeghgZgn.hkZ@flex--tavip.bounces.google.com>)
 id 1sxysp-0007zm-OZ
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 21:19:29 -0400
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3kIgEZwUKCvEmTobiZhhZeX.VhfjXfn-WXoXeghgZgn.hkZ@flex--tavip.bounces.google.com>)
 id 1sxysf-0000A7-Sb
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 21:19:24 -0400
Received: by mail-pf1-x449.google.com with SMTP id
 d2e1a72fcca58-71dfa361499so2100343b3a.0
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 18:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1728350353; x=1728955153; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=h0g2XEqh5TFAysQ/4BwAuoGhpRYdqAqx4UCuVxyPc+Q=;
 b=BWB2Afny75Rb0luKXPj/Z3aE7bLX6KYxuUTSFvJ7HRHxF9UZaj+zJnI55M88rD+VUe
 dSNji5xYX+9n6ZrXv8ra0AkVbpKOu9/cSRIeyw+HCBmQ6aQlYSvXQqRJyoBLRLmgb3l+
 OdGB8X9E9uKFbXnW7s7Dja7jzj8tMDi34PQAdTOdyzefcebOtQcUVverPPoY/RP2jwAN
 8ZQYoyYRXySh/u6jLaJ3E1i+Rr61RZqAsVRlRuahGWg2DsbmaIsbQN8u2jRMsQh6Gsr6
 a4FfrYqavMp6rHv/rjawNJii7DCYa9SOh06Fmq3Uc4uIG1EB+E6hinegJDCsVsZ3dzR7
 jPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728350353; x=1728955153;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h0g2XEqh5TFAysQ/4BwAuoGhpRYdqAqx4UCuVxyPc+Q=;
 b=CjQQajGiCt2hOKja+sKAjx0lYZALqwr13oueE+EbtrR+88uV5IpMTg5n8121zlmhCQ
 Pi98GxguByRPyzIvut/8lvaDbwJf0QXc/0eIbNuCQxX8N1buJGA2/9dwEkwrkvBH1CqK
 29Bn+C5cE5/vBdTp3m96Q/75WCnqOUdnsBrgUh/B4RDISVdNY/R0qQQfzJtWaIe0w70m
 y/IuIB/jaaYyev+hCPnN22ixuMl75/qB6Hluyj1jlGuo6eFhyhfFQLGC+4DUIcoQ5vrw
 cCQ+ZvOCbxNIz0lrWZzri8R+AnNy2RIh35I8yVbaK9K6QTz+4topabosFdtYflcniiqu
 uC+g==
X-Gm-Message-State: AOJu0Yyko5ovDbanV1rLzcN2wtnzIoKT8wqdL0PSdgWutG3TWWMICMyL
 NqT7KhFwjbUhBez6jBGi0O6B7DZ1OZVM98l0PygLBl8RhVCezDv7nyMvFDNoCtpGUaNJdmbW7xV
 mLmPxIR8L5po26S8p1DAla0f/X+ulv5uI0xhheQqXxyweuN+3cee6ih45wHodizT/rj+NEPgfl6
 4eeqnWlkktE52u36BDkGYu/h5rhQ==
X-Google-Smtp-Source: AGHT+IH2ojZoS4xw100tm4xI4XQvhwctpObQyFtqT+tL5TSw0PUe+TwGlkFXiGZ6lPViV1qB2g5VhYD54w==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a05:6a00:7687:b0:71d:fb06:e79b
 with SMTP id
 d2e1a72fcca58-71dfb06ea3amr14557b3a.0.1728350352051; Mon, 07 Oct 2024
 18:19:12 -0700 (PDT)
Date: Mon,  7 Oct 2024 18:18:36 -0700
In-Reply-To: <20241008011852.1439154-1-tavip@google.com>
Mime-Version: 1.0
References: <20241008011852.1439154-1-tavip@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241008011852.1439154-11-tavip@google.com>
Subject: [PATCH v2 10/25] hw/misc: add support for RT500's clock controller
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr, 
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org, jsnow@redhat.com, 
 crosa@redhat.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::449;
 envelope-from=3kIgEZwUKCvEmTobiZhhZeX.VhfjXfn-WXoXeghgZgn.hkZ@flex--tavip.bounces.google.com;
 helo=mail-pf1-x449.google.com
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

It supports system and audio PLL initialization and SYSTICK and
OSTIMER clock source selection.

The patch includes automatically generated headers which contains the
register layout and helpers.

The headers can be regenerated with the svd-rt500-clkctl0 and
svd-rt500-clkctl1 targets when the build is configured with
--enable-mcux-soc-svd.

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 include/hw/arm/svd/rt500_clkctl0.h | 509 ++++++++++++++++++++++
 include/hw/arm/svd/rt500_clkctl1.h | 675 +++++++++++++++++++++++++++++
 include/hw/misc/rt500_clk_freqs.h  |  18 +
 include/hw/misc/rt500_clkctl0.h    |  35 ++
 include/hw/misc/rt500_clkctl1.h    |  36 ++
 hw/misc/rt500_clkctl0.c            | 253 +++++++++++
 hw/misc/rt500_clkctl1.c            | 238 ++++++++++
 hw/arm/Kconfig                     |   5 +
 hw/arm/svd/meson.build             |   8 +
 hw/misc/Kconfig                    |   3 +
 hw/misc/meson.build                |   1 +
 hw/misc/trace-events               |   8 +
 12 files changed, 1789 insertions(+)
 create mode 100644 include/hw/arm/svd/rt500_clkctl0.h
 create mode 100644 include/hw/arm/svd/rt500_clkctl1.h
 create mode 100644 include/hw/misc/rt500_clk_freqs.h
 create mode 100644 include/hw/misc/rt500_clkctl0.h
 create mode 100644 include/hw/misc/rt500_clkctl1.h
 create mode 100644 hw/misc/rt500_clkctl0.c
 create mode 100644 hw/misc/rt500_clkctl1.c

diff --git a/include/hw/arm/svd/rt500_clkctl0.h b/include/hw/arm/svd/rt500_clkctl0.h
new file mode 100644
index 0000000000..89be8ff5fb
--- /dev/null
+++ b/include/hw/arm/svd/rt500_clkctl0.h
@@ -0,0 +1,509 @@
+/*
+ * Copyright 2016-2023 NXP SPDX-License-Identifier: BSD-3-Clause
+ *
+ * Automatically generated by svd-gen-header.py from MIMXRT595S_cm33.xml
+ */
+#pragma once
+
+#include "hw/register.h"
+
+/* Clock Controller 0 */
+#define RT500_CLKCTL0_REGS_NO (490)
+
+/* Clock Control 0 */
+REG32(RT500_CLKCTL0_PSCCTL0, 0x10);
+/* DSP clock control */
+FIELD(RT500_CLKCTL0_PSCCTL0, DSP_CLK, 1, 1);
+/* 128KB ROM Controller clock control */
+FIELD(RT500_CLKCTL0_PSCCTL0, ROM_CTRLR_CLK, 2, 1);
+
+/* Clock Control 1 */
+REG32(RT500_CLKCTL0_PSCCTL1, 0x14);
+
+/* Clock Control 2 */
+REG32(RT500_CLKCTL0_PSCCTL2, 0x18);
+
+/* Clock Control 0 Set */
+REG32(RT500_CLKCTL0_PSCCTL0_SET, 0x40);
+/* DSP clock set */
+FIELD(RT500_CLKCTL0_PSCCTL0_SET, DSP_CLK, 1, 1);
+/* 128KB ROM Controller clock set */
+FIELD(RT500_CLKCTL0_PSCCTL0_SET, ROM_CTRLR_CLK, 2, 1);
+
+/* Clock Control 1 Set */
+REG32(RT500_CLKCTL0_PSCCTL1_SET, 0x44);
+
+/* Clock Control 2 Set */
+REG32(RT500_CLKCTL0_PSCCTL2_SET, 0x48);
+
+/* Clock Control 0 Clear */
+REG32(RT500_CLKCTL0_PSCCTL0_CLR, 0x70);
+/* DSP clock clear */
+FIELD(RT500_CLKCTL0_PSCCTL0_CLR, DSP_CLK, 1, 1);
+/* 128KB ROM Controller clock clear */
+FIELD(RT500_CLKCTL0_PSCCTL0_CLR, ROM_CTRLR_CLK, 2, 1);
+
+/* Clock Control 1 Clear */
+REG32(RT500_CLKCTL0_PSCCTL1_CLR, 0x74);
+
+/* Clock Control 2 Clear */
+REG32(RT500_CLKCTL0_PSCCTL2_CLR, 0x78);
+
+/* FRO Clock Status */
+REG32(RT500_CLKCTL0_FROCLKSTATUS, 0x10C);
+
+/* System PLL0 PFD */
+REG32(RT500_CLKCTL0_SYSPLL0PFD, 0x218);
+/* PLL Fractional Divider 0 */
+FIELD(RT500_CLKCTL0_SYSPLL0PFD, PFD0, 0, 6);
+/* PFD0 Clock Ready Status Flag */
+FIELD(RT500_CLKCTL0_SYSPLL0PFD, PFD0_CLKRDY, 6, 1);
+/* PFD0 Clock Gate */
+FIELD(RT500_CLKCTL0_SYSPLL0PFD, PFD0_CLKGATE, 7, 1);
+/* PLL Fractional Divider 1 */
+FIELD(RT500_CLKCTL0_SYSPLL0PFD, PFD1, 8, 6);
+/* PFD1 Clock Ready Status Flag */
+FIELD(RT500_CLKCTL0_SYSPLL0PFD, PFD1_CLKRDY, 14, 1);
+/* PFD1 Clock Gate */
+FIELD(RT500_CLKCTL0_SYSPLL0PFD, PFD1_CLKGATE, 15, 1);
+/* PLL Fractional Divider 2 */
+FIELD(RT500_CLKCTL0_SYSPLL0PFD, PFD2, 16, 6);
+/* PFD2 Clock Ready Status Flag */
+FIELD(RT500_CLKCTL0_SYSPLL0PFD, PFD2_CLKRDY, 22, 1);
+/* PFD2 Clock Gate */
+FIELD(RT500_CLKCTL0_SYSPLL0PFD, PFD2_CLKGATE, 23, 1);
+/* PLL Fractional Divider 3 */
+FIELD(RT500_CLKCTL0_SYSPLL0PFD, PFD3, 24, 6);
+/* PFD3 Clock Ready Status Flag */
+FIELD(RT500_CLKCTL0_SYSPLL0PFD, PFD3_CLKRDY, 30, 1);
+/* PFD3 Clock Gate */
+FIELD(RT500_CLKCTL0_SYSPLL0PFD, PFD3_CLKGATE, 31, 1);
+
+/* SYSTICK Functional Clock Select */
+REG32(RT500_CLKCTL0_SYSTICKFCLKSEL, 0x760);
+/* Select Clock Source */
+FIELD(RT500_CLKCTL0_SYSTICKFCLKSEL, SEL, 0, 3);
+/* Systick Divider Output Clock */
+#define RT500_CLKCTL0_SYSTICKFCLKSEL_SEL_SYSTICK_DIV_OUTPUT 0
+/* Low Power Oscillator Clock (LPOSC) */
+#define RT500_CLKCTL0_SYSTICKFCLKSEL_SEL_LPOSC 1
+/* 32 KHz RTC Clock */
+#define RT500_CLKCTL0_SYSTICKFCLKSEL_SEL_A32KHZ_RTC 2
+/* None; this may be selected to reduce power when no output is needed. */
+#define RT500_CLKCTL0_SYSTICKFCLKSEL_SEL_NONE 7
+
+/* SYSTICK Functional Clock Divider */
+REG32(RT500_CLKCTL0_SYSTICKFCLKDIV, 0x764);
+/* Clock Divider Value Selection */
+FIELD(RT500_CLKCTL0_SYSTICKFCLKDIV, DIV, 0, 8);
+/* Reset the Divider Counter */
+FIELD(RT500_CLKCTL0_SYSTICKFCLKDIV, RESET, 29, 1);
+/* Halt the Divider Counter */
+FIELD(RT500_CLKCTL0_SYSTICKFCLKDIV, HALT, 30, 1);
+/* Divider status flag */
+FIELD(RT500_CLKCTL0_SYSTICKFCLKDIV, REQFLAG, 31, 1);
+
+
+#define RT500_CLKCTL0_REGISTER_ACCESS_INFO_ARRAY(_name) \
+    struct RegisterAccessInfo _name[RT500_CLKCTL0_REGS_NO] = { \
+        [0 ... RT500_CLKCTL0_REGS_NO - 1] = { \
+            .name = "", \
+            .addr = -1, \
+        }, \
+        [0x4] = { \
+            .name = "PSCCTL0", \
+            .addr = 0x10, \
+            .ro = 0xA208E0E1, \
+            .reset = 0x5, \
+        }, \
+        [0x5] = { \
+            .name = "PSCCTL1", \
+            .addr = 0x14, \
+            .ro = 0xFEFE7FF3, \
+            .reset = 0x0, \
+        }, \
+        [0x6] = { \
+            .name = "PSCCTL2", \
+            .addr = 0x18, \
+            .ro = 0xDFFFFFFC, \
+            .reset = 0x0, \
+        }, \
+        [0x10] = { \
+            .name = "PSCCTL0_SET", \
+            .addr = 0x40, \
+            .ro = 0xA208E0E1, \
+            .reset = 0x0, \
+        }, \
+        [0x11] = { \
+            .name = "PSCCTL1_SET", \
+            .addr = 0x44, \
+            .ro = 0xFEFE7FF3, \
+            .reset = 0x0, \
+        }, \
+        [0x12] = { \
+            .name = "PSCCTL2_SET", \
+            .addr = 0x48, \
+            .ro = 0xDFFFFFFC, \
+            .reset = 0x0, \
+        }, \
+        [0x1C] = { \
+            .name = "PSCCTL0_CLR", \
+            .addr = 0x70, \
+            .ro = 0xA208E0E1, \
+            .reset = 0x0, \
+        }, \
+        [0x1D] = { \
+            .name = "PSCCTL1_CLR", \
+            .addr = 0x74, \
+            .ro = 0xFEFE7FF3, \
+            .reset = 0x0, \
+        }, \
+        [0x1E] = { \
+            .name = "PSCCTL2_CLR", \
+            .addr = 0x78, \
+            .ro = 0xDFFFFFFC, \
+            .reset = 0x0, \
+        }, \
+        [0x20] = { \
+            .name = "FRO_CONTROL", \
+            .addr = 0x80, \
+            .ro = 0x7C000000, \
+            .reset = 0x0, \
+        }, \
+        [0x21] = { \
+            .name = "FRO_CAPVAL", \
+            .addr = 0x84, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [0x23] = { \
+            .name = "FRO_RDTRIM", \
+            .addr = 0x8C, \
+            .ro = 0xFFFFF800, \
+            .reset = 0x3BF, \
+        }, \
+        [0x24] = { \
+            .name = "FRO_SCTRIM", \
+            .addr = 0x90, \
+            .ro = 0xFFFFFFC0, \
+            .reset = 0x20, \
+        }, \
+        [0x42] = { \
+            .name = "FRODIVSEL", \
+            .addr = 0x108, \
+            .ro = 0xFFFFFFFC, \
+            .reset = 0x0, \
+        }, \
+        [0x43] = { \
+            .name = "FROCLKSTATUS", \
+            .addr = 0x10C, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [0x44] = { \
+            .name = "FRODIVOEN", \
+            .addr = 0x110, \
+            .ro = 0xFFFFFFE0, \
+            .reset = 0x0, \
+        }, \
+        [0x4C] = { \
+            .name = "LOWFREQCLKDIV", \
+            .addr = 0x130, \
+            .ro = 0x1FFFFF00, \
+            .reset = 0x0, \
+        }, \
+        [0x58] = { \
+            .name = "SYSOSCCTL0", \
+            .addr = 0x160, \
+            .ro = 0xFFFFFFFC, \
+            .reset = 0x0, \
+        }, \
+        [0x5A] = { \
+            .name = "SYSOSCBYPASS", \
+            .addr = 0x168, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x0, \
+        }, \
+        [0x64] = { \
+            .name = "LPOSCCTL0", \
+            .addr = 0x190, \
+            .ro = 0x7FFFFFFF, \
+            .reset = 0x807BC4D4, \
+        }, \
+        [0x70] = { \
+            .name = "OSC32KHZCTL0", \
+            .addr = 0x1C0, \
+            .ro = 0xFFFFFFFE, \
+            .reset = 0x0, \
+        }, \
+        [0x80] = { \
+            .name = "SYSPLL0CLKSEL", \
+            .addr = 0x200, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x81] = { \
+            .name = "SYSPLL0CTL0", \
+            .addr = 0x204, \
+            .ro = 0xFF00DFFC, \
+            .reset = 0x160002, \
+        }, \
+        [0x83] = { \
+            .name = "SYSPLL0LOCKTIMEDIV2", \
+            .addr = 0x20C, \
+            .ro = 0xFFFF0000, \
+            .reset = 0xCAFE, \
+        }, \
+        [0x84] = { \
+            .name = "SYSPLL0NUM", \
+            .addr = 0x210, \
+            .ro = 0xC0000000, \
+            .reset = 0x4DD2F15, \
+        }, \
+        [0x85] = { \
+            .name = "SYSPLL0DENOM", \
+            .addr = 0x214, \
+            .ro = 0xC0000000, \
+            .reset = 0x1FFFFFDB, \
+        }, \
+        [0x86] = { \
+            .name = "SYSPLL0PFD", \
+            .addr = 0x218, \
+            .ro = 0x0, \
+            .reset = 0x80808080, \
+        }, \
+        [0x90] = { \
+            .name = "MAINPLLCLKDIV", \
+            .addr = 0x240, \
+            .ro = 0x1FFFFF00, \
+            .reset = 0x0, \
+        }, \
+        [0x91] = { \
+            .name = "DSPPLLCLKDIV", \
+            .addr = 0x244, \
+            .ro = 0x1FFFFF00, \
+            .reset = 0x0, \
+        }, \
+        [0x92] = { \
+            .name = "AUX0PLLCLKDIV", \
+            .addr = 0x248, \
+            .ro = 0x1FFFFF00, \
+            .reset = 0x0, \
+        }, \
+        [0x93] = { \
+            .name = "AUX1PLLCLKDIV", \
+            .addr = 0x24C, \
+            .ro = 0x1FFFFF00, \
+            .reset = 0x0, \
+        }, \
+        [0x100] = { \
+            .name = "SYSCPUAHBCLKDIV", \
+            .addr = 0x400, \
+            .ro = 0x7FFFFF00, \
+            .reset = 0x0, \
+        }, \
+        [0x10C] = { \
+            .name = "MAINCLKSELA", \
+            .addr = 0x430, \
+            .ro = 0xFFFFFFFC, \
+            .reset = 0x0, \
+        }, \
+        [0x10D] = { \
+            .name = "MAINCLKSELB", \
+            .addr = 0x434, \
+            .ro = 0xFFFFFFFC, \
+            .reset = 0x0, \
+        }, \
+        [0x140] = { \
+            .name = "PFC0DIV", \
+            .addr = 0x500, \
+            .ro = 0x1FFFFF00, \
+            .reset = 0x40000000, \
+        }, \
+        [0x141] = { \
+            .name = "PFC1DIV", \
+            .addr = 0x504, \
+            .ro = 0x1FFFFF00, \
+            .reset = 0x40000000, \
+        }, \
+        [0x188] = { \
+            .name = "FLEXSPI0FCLKSEL", \
+            .addr = 0x620, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x189] = { \
+            .name = "FLEXSPI0FCLKDIV", \
+            .addr = 0x624, \
+            .ro = 0x1FFFFF00, \
+            .reset = 0x40000000, \
+        }, \
+        [0x18C] = { \
+            .name = "FLEXSPI1FCLKSEL", \
+            .addr = 0x630, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x18D] = { \
+            .name = "FLEXSPI1FCLKDIV", \
+            .addr = 0x634, \
+            .ro = 0x1FFFFF00, \
+            .reset = 0x40000000, \
+        }, \
+        [0x190] = { \
+            .name = "SCTFCLKSEL", \
+            .addr = 0x640, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x191] = { \
+            .name = "SCTIN7CLKDIV", \
+            .addr = 0x644, \
+            .ro = 0x1FFFFF00, \
+            .reset = 0x40000000, \
+        }, \
+        [0x198] = { \
+            .name = "USBHSFCLKSEL", \
+            .addr = 0x660, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x199] = { \
+            .name = "USBHSFCLKDIV", \
+            .addr = 0x664, \
+            .ro = 0x1FFFFF00, \
+            .reset = 0x40000000, \
+        }, \
+        [0x1A0] = { \
+            .name = "SDIO0FCLKSEL", \
+            .addr = 0x680, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x1A1] = { \
+            .name = "SDIO0FCLKDIV", \
+            .addr = 0x684, \
+            .ro = 0x1FFFFF00, \
+            .reset = 0x40000000, \
+        }, \
+        [0x1A4] = { \
+            .name = "SDIO1FCLKSEL", \
+            .addr = 0x690, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x1A5] = { \
+            .name = "SDIO1FCLKDIV", \
+            .addr = 0x694, \
+            .ro = 0x1FFFFF00, \
+            .reset = 0x40000000, \
+        }, \
+        [0x1B4] = { \
+            .name = "ADC0FCLKSEL0", \
+            .addr = 0x6D0, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x1B5] = { \
+            .name = "ADC0FCLKSEL1", \
+            .addr = 0x6D4, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x1B6] = { \
+            .name = "ADC0FCLKDIV", \
+            .addr = 0x6D8, \
+            .ro = 0x1FFFFF00, \
+            .reset = 0x40000000, \
+        }, \
+        [0x1C0] = { \
+            .name = "UTICKFCLKSEL", \
+            .addr = 0x700, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x1C8] = { \
+            .name = "WDT0FCLKSEL", \
+            .addr = 0x720, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x0, \
+        }, \
+        [0x1CC] = { \
+            .name = "A32KHZWAKECLKSEL", \
+            .addr = 0x730, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x1, \
+        }, \
+        [0x1CD] = { \
+            .name = "A32KHZWAKECLKDIV", \
+            .addr = 0x734, \
+            .ro = 0x1FFFFF00, \
+            .reset = 0x1F, \
+        }, \
+        [0x1D8] = { \
+            .name = "SYSTICKFCLKSEL", \
+            .addr = 0x760, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x1D9] = { \
+            .name = "SYSTICKFCLKDIV", \
+            .addr = 0x764, \
+            .ro = 0x1FFFFF00, \
+            .reset = 0x40000000, \
+        }, \
+        [0x1DC] = { \
+            .name = "DPHYCLKSEL", \
+            .addr = 0x770, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x1DD] = { \
+            .name = "DPHYCLKDIV", \
+            .addr = 0x774, \
+            .ro = 0x1FFFFF00, \
+            .reset = 0x40000000, \
+        }, \
+        [0x1DE] = { \
+            .name = "DPHYESCCLKSEL", \
+            .addr = 0x778, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x1DF] = { \
+            .name = "DPHYESCRXCLKDIV", \
+            .addr = 0x77C, \
+            .ro = 0x1FFFFF00, \
+            .reset = 0x40000010, \
+        }, \
+        [0x1E0] = { \
+            .name = "DPHYESCTXCLKDIV", \
+            .addr = 0x780, \
+            .ro = 0x1FFFFF00, \
+            .reset = 0x40000011, \
+        }, \
+        [0x1E4] = { \
+            .name = "GPUCLKSEL", \
+            .addr = 0x790, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x1E5] = { \
+            .name = "GPUCLKDIV", \
+            .addr = 0x794, \
+            .ro = 0x1FFFFF00, \
+            .reset = 0x40000000, \
+        }, \
+        [0x1E8] = { \
+            .name = "DCPIXELCLKSEL", \
+            .addr = 0x7A0, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x1E9] = { \
+            .name = "DCPIXELCLKDIV", \
+            .addr = 0x7A4, \
+            .ro = 0x1FFFFF00, \
+            .reset = 0x40000000, \
+        }, \
+    }
diff --git a/include/hw/arm/svd/rt500_clkctl1.h b/include/hw/arm/svd/rt500_clkctl1.h
new file mode 100644
index 0000000000..baa24eb0fd
--- /dev/null
+++ b/include/hw/arm/svd/rt500_clkctl1.h
@@ -0,0 +1,675 @@
+/*
+ * Copyright 2016-2023 NXP SPDX-License-Identifier: BSD-3-Clause
+ *
+ * Automatically generated by svd-gen-header.py from MIMXRT595S_cm33.xml
+ */
+#pragma once
+
+#include "hw/register.h"
+
+/* Clock Controller 1 */
+#define RT500_CLKCTL1_REGS_NO (526)
+
+/* Clock Control 0 */
+REG32(RT500_CLKCTL1_PSCCTL0, 0x10);
+/* FlexIO clock control */
+FIELD(RT500_CLKCTL1_PSCCTL0, FlexIO, 29, 1);
+
+/* Clock Control 1 */
+REG32(RT500_CLKCTL1_PSCCTL1, 0x14);
+
+/* Clock Control 2 */
+REG32(RT500_CLKCTL1_PSCCTL2, 0x18);
+
+/* Clock Set 0 */
+REG32(RT500_CLKCTL1_PSCCTL0_SET, 0x40);
+/* FlexIO clock control */
+FIELD(RT500_CLKCTL1_PSCCTL0_SET, FlexIO, 29, 1);
+
+/* Clock Set 1 */
+REG32(RT500_CLKCTL1_PSCCTL1_SET, 0x44);
+
+/* Clock Set 2 */
+REG32(RT500_CLKCTL1_PSCCTL2_SET, 0x48);
+
+/* Clock Clear 0 */
+REG32(RT500_CLKCTL1_PSCCTL0_CLR, 0x70);
+/* FlexIO clock control clear */
+FIELD(RT500_CLKCTL1_PSCCTL0_CLR, FlexIO, 29, 1);
+
+/* Clock Clear 1 */
+REG32(RT500_CLKCTL1_PSCCTL1_CLR, 0x74);
+
+/* Clock Clear 2 */
+REG32(RT500_CLKCTL1_PSCCTL2_CLR, 0x78);
+
+/* Audio PLL0 PFD */
+REG32(RT500_CLKCTL1_AUDIOPLL0PFD, 0x218);
+/* PLL Fractional Divider 0 */
+FIELD(RT500_CLKCTL1_AUDIOPLL0PFD, PFD0, 0, 6);
+/* PFD0 Clock Ready Status Flag */
+FIELD(RT500_CLKCTL1_AUDIOPLL0PFD, PFD0_CLKRDY, 6, 1);
+/* PFD0 Clock Gate */
+FIELD(RT500_CLKCTL1_AUDIOPLL0PFD, PFD0_CLKGATE, 7, 1);
+/* PLL Fractional Divider 1 */
+FIELD(RT500_CLKCTL1_AUDIOPLL0PFD, PFD1, 8, 6);
+/* PFD1 Clock Ready Status Flag */
+FIELD(RT500_CLKCTL1_AUDIOPLL0PFD, PFD1_CLKRDY, 14, 1);
+/* PFD1 Clock Gate */
+FIELD(RT500_CLKCTL1_AUDIOPLL0PFD, PFD1_CLKGATE, 15, 1);
+/* PLL Fractional Divider 2 */
+FIELD(RT500_CLKCTL1_AUDIOPLL0PFD, PFD2, 16, 6);
+/* PFD2 Clock Ready Status Flag */
+FIELD(RT500_CLKCTL1_AUDIOPLL0PFD, PFD2_CLKRDY, 22, 1);
+/* PFD2 Clock Gate */
+FIELD(RT500_CLKCTL1_AUDIOPLL0PFD, PFD2_CLKGATE, 23, 1);
+/* PLL Fractional Divider 3 */
+FIELD(RT500_CLKCTL1_AUDIOPLL0PFD, PFD3, 24, 6);
+/* PFD3 Clock Ready Status Flag */
+FIELD(RT500_CLKCTL1_AUDIOPLL0PFD, PFD3_CLKRDY, 30, 1);
+/* PFD3 Clock Gate */
+FIELD(RT500_CLKCTL1_AUDIOPLL0PFD, PFD3_CLKGATE, 31, 1);
+
+/* OS Event Timer Functional Clock Select */
+REG32(RT500_CLKCTL1_OSEVENTTFCLKSEL, 0x480);
+/* OS Event Timer Functional Clock Source */
+FIELD(RT500_CLKCTL1_OSEVENTTFCLKSEL, SEL, 0, 3);
+/* Low Power Oscillator Clock (LPOSC) */
+#define RT500_CLKCTL1_OSEVENTTFCLKSEL_SEL_LPOSC 0
+/* RTC 32 KHz Clock */
+#define RT500_CLKCTL1_OSEVENTTFCLKSEL_SEL_RTC_32KHZ 1
+/* HCLK Free-Running Clock (Global Time Stamping) */
+#define RT500_CLKCTL1_OSEVENTTFCLKSEL_SEL_TEAL 2
+/* None, output gated to reduce power */
+#define RT500_CLKCTL1_OSEVENTTFCLKSEL_SEL_NONE 7
+
+
+#define RT500_CLKCTL1_REGISTER_ACCESS_INFO_ARRAY(_name) \
+    struct RegisterAccessInfo _name[RT500_CLKCTL1_REGS_NO] = { \
+        [0 ... RT500_CLKCTL1_REGS_NO - 1] = { \
+            .name = "", \
+            .addr = -1, \
+        }, \
+        [0x4] = { \
+            .name = "PSCCTL0", \
+            .addr = 0x10, \
+            .ro = 0xD40000FF, \
+            .reset = 0x0, \
+        }, \
+        [0x5] = { \
+            .name = "PSCCTL1", \
+            .addr = 0x14, \
+            .ro = 0x4E7EFF00, \
+            .reset = 0x0, \
+        }, \
+        [0x6] = { \
+            .name = "PSCCTL2", \
+            .addr = 0x18, \
+            .ro = 0x3FFCFA60, \
+            .reset = 0x0, \
+        }, \
+        [0x10] = { \
+            .name = "PSCCTL0_SET", \
+            .addr = 0x40, \
+            .ro = 0xD40000FF, \
+            .reset = 0x0, \
+        }, \
+        [0x11] = { \
+            .name = "PSCCTL1_SET", \
+            .addr = 0x44, \
+            .ro = 0x4E7EFF00, \
+            .reset = 0x0, \
+        }, \
+        [0x12] = { \
+            .name = "PSCCTL2_SET", \
+            .addr = 0x48, \
+            .ro = 0x3FFCFA60, \
+            .reset = 0x0, \
+        }, \
+        [0x1C] = { \
+            .name = "PSCCTL0_CLR", \
+            .addr = 0x70, \
+            .ro = 0xD40000FF, \
+            .reset = 0x0, \
+        }, \
+        [0x1D] = { \
+            .name = "PSCCTL1_CLR", \
+            .addr = 0x74, \
+            .ro = 0x4E7EFF00, \
+            .reset = 0x0, \
+        }, \
+        [0x1E] = { \
+            .name = "PSCCTL2_CLR", \
+            .addr = 0x78, \
+            .ro = 0x3FFCFA60, \
+            .reset = 0x0, \
+        }, \
+        [0x80] = { \
+            .name = "AUDIOPLL0CLKSEL", \
+            .addr = 0x200, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x81] = { \
+            .name = "AUDIOPLL0CTL0", \
+            .addr = 0x204, \
+            .ro = 0xFF00DFFC, \
+            .reset = 0x160002, \
+        }, \
+        [0x83] = { \
+            .name = "AUDIOPLL0LOCKTIMEDIV2", \
+            .addr = 0x20C, \
+            .ro = 0xFFFF0000, \
+            .reset = 0xCAFE, \
+        }, \
+        [0x84] = { \
+            .name = "AUDIOPLL0NUM", \
+            .addr = 0x210, \
+            .ro = 0xC0000000, \
+            .reset = 0x4DD2F15, \
+        }, \
+        [0x85] = { \
+            .name = "AUDIOPLL0DENOM", \
+            .addr = 0x214, \
+            .ro = 0xC0000000, \
+            .reset = 0x1FFFFFDB, \
+        }, \
+        [0x86] = { \
+            .name = "AUDIOPLL0PFD", \
+            .addr = 0x218, \
+            .ro = 0x0, \
+            .reset = 0x80808080, \
+        }, \
+        [0x90] = { \
+            .name = "AUDIOPLLCLKDIV", \
+            .addr = 0x240, \
+            .ro = 0x1FFFFF00, \
+            .reset = 0x40000000, \
+        }, \
+        [0x100] = { \
+            .name = "DSPCPUCLKDIV", \
+            .addr = 0x400, \
+            .ro = 0x1FFFFF00, \
+            .reset = 0x40000000, \
+        }, \
+        [0x10C] = { \
+            .name = "DSPCPUCLKSELA", \
+            .addr = 0x430, \
+            .ro = 0xFFFFFFFC, \
+            .reset = 0x0, \
+        }, \
+        [0x10D] = { \
+            .name = "DSPCPUCLKSELB", \
+            .addr = 0x434, \
+            .ro = 0xFFFFFFFC, \
+            .reset = 0x0, \
+        }, \
+        [0x120] = { \
+            .name = "OSEVENTTFCLKSEL", \
+            .addr = 0x480, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x0, \
+        }, \
+        [0x140] = { \
+            .name = "FRG0CLKSEL", \
+            .addr = 0x500, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x141] = { \
+            .name = "FRG0CTL", \
+            .addr = 0x504, \
+            .ro = 0xFFFF0000, \
+            .reset = 0xFF, \
+        }, \
+        [0x142] = { \
+            .name = "FC0FCLKSEL", \
+            .addr = 0x508, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x148] = { \
+            .name = "FRG1CLKSEL", \
+            .addr = 0x520, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x149] = { \
+            .name = "FRG1CTL", \
+            .addr = 0x524, \
+            .ro = 0xFFFF0000, \
+            .reset = 0xFF, \
+        }, \
+        [0x14A] = { \
+            .name = "FC1FCLKSEL", \
+            .addr = 0x528, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x150] = { \
+            .name = "FRG2CLKSEL", \
+            .addr = 0x540, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x151] = { \
+            .name = "FRG2CTL", \
+            .addr = 0x544, \
+            .ro = 0xFFFF0000, \
+            .reset = 0xFF, \
+        }, \
+        [0x152] = { \
+            .name = "FC2FCLKSEL", \
+            .addr = 0x548, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x158] = { \
+            .name = "FRG3CLKSEL", \
+            .addr = 0x560, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x159] = { \
+            .name = "FRG3CTL", \
+            .addr = 0x564, \
+            .ro = 0xFFFF0000, \
+            .reset = 0xFF, \
+        }, \
+        [0x15A] = { \
+            .name = "FC3FCLKSEL", \
+            .addr = 0x568, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x160] = { \
+            .name = "FRG4CLKSEL", \
+            .addr = 0x580, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x161] = { \
+            .name = "FRG4CTL", \
+            .addr = 0x584, \
+            .ro = 0xFFFF0000, \
+            .reset = 0xFF, \
+        }, \
+        [0x162] = { \
+            .name = "FC4FCLKSEL", \
+            .addr = 0x588, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x168] = { \
+            .name = "FRG5CLKSEL", \
+            .addr = 0x5A0, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x169] = { \
+            .name = "FRG5CTL", \
+            .addr = 0x5A4, \
+            .ro = 0xFFFF0000, \
+            .reset = 0xFF, \
+        }, \
+        [0x16A] = { \
+            .name = "FC5FCLKSEL", \
+            .addr = 0x5A8, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x170] = { \
+            .name = "FRG6CLKSEL", \
+            .addr = 0x5C0, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x171] = { \
+            .name = "FRG6CTL", \
+            .addr = 0x5C4, \
+            .ro = 0xFFFF0000, \
+            .reset = 0xFF, \
+        }, \
+        [0x172] = { \
+            .name = "FC6FCLKSEL", \
+            .addr = 0x5C8, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x178] = { \
+            .name = "FRG7CLKSEL", \
+            .addr = 0x5E0, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x179] = { \
+            .name = "FRG7CTL", \
+            .addr = 0x5E4, \
+            .ro = 0xFFFF0000, \
+            .reset = 0xFF, \
+        }, \
+        [0x17A] = { \
+            .name = "FC7FCLKSEL", \
+            .addr = 0x5E8, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x180] = { \
+            .name = "FRG8CLKSEL", \
+            .addr = 0x600, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x181] = { \
+            .name = "FRG8CTL", \
+            .addr = 0x604, \
+            .ro = 0xFFFF0000, \
+            .reset = 0xFF, \
+        }, \
+        [0x182] = { \
+            .name = "FC8FCLKSEL", \
+            .addr = 0x608, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x188] = { \
+            .name = "FRG9CLKSEL", \
+            .addr = 0x620, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x189] = { \
+            .name = "FRG9CTL", \
+            .addr = 0x624, \
+            .ro = 0xFFFF0000, \
+            .reset = 0xFF, \
+        }, \
+        [0x18A] = { \
+            .name = "FC9FCLKSEL", \
+            .addr = 0x628, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x190] = { \
+            .name = "FRG10CLKSEL", \
+            .addr = 0x640, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x191] = { \
+            .name = "FRG10CTL", \
+            .addr = 0x644, \
+            .ro = 0xFFFF0000, \
+            .reset = 0xFF, \
+        }, \
+        [0x192] = { \
+            .name = "FC10FCLKSEL", \
+            .addr = 0x648, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x198] = { \
+            .name = "FRG11CLKSEL", \
+            .addr = 0x660, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x199] = { \
+            .name = "FRG11CTL", \
+            .addr = 0x664, \
+            .ro = 0xFFFF0000, \
+            .reset = 0xFF, \
+        }, \
+        [0x19A] = { \
+            .name = "FC11FCLKSEL", \
+            .addr = 0x668, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x1A0] = { \
+            .name = "FRG12CLKSEL", \
+            .addr = 0x680, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x1A1] = { \
+            .name = "FRG12CTL", \
+            .addr = 0x684, \
+            .ro = 0xFFFF0000, \
+            .reset = 0xFF, \
+        }, \
+        [0x1A2] = { \
+            .name = "FC12FCLKSEL", \
+            .addr = 0x688, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x1A8] = { \
+            .name = "FRG13CLKSEL", \
+            .addr = 0x6A0, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x1A9] = { \
+            .name = "FRG13CTL", \
+            .addr = 0x6A4, \
+            .ro = 0xFFFF0000, \
+            .reset = 0xFF, \
+        }, \
+        [0x1AA] = { \
+            .name = "FC13FCLKSEL", \
+            .addr = 0x6A8, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x1B0] = { \
+            .name = "FRG14CLKSEL", \
+            .addr = 0x6C0, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x1B1] = { \
+            .name = "FRG14CTL", \
+            .addr = 0x6C4, \
+            .ro = 0xFFFF0000, \
+            .reset = 0xFF, \
+        }, \
+        [0x1B2] = { \
+            .name = "FC14FCLKSEL", \
+            .addr = 0x6C8, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x1B8] = { \
+            .name = "FRG15CLKSEL", \
+            .addr = 0x6E0, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x1B9] = { \
+            .name = "FRG15CTL", \
+            .addr = 0x6E4, \
+            .ro = 0xFFFF0000, \
+            .reset = 0xFF, \
+        }, \
+        [0x1BA] = { \
+            .name = "FC15FCLKSEL", \
+            .addr = 0x6E8, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x1C0] = { \
+            .name = "FRG16CLKSEL", \
+            .addr = 0x700, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x1C1] = { \
+            .name = "FRG16CTL", \
+            .addr = 0x704, \
+            .ro = 0xFFFF0000, \
+            .reset = 0xFF, \
+        }, \
+        [0x1C2] = { \
+            .name = "FC16FCLKSEL", \
+            .addr = 0x708, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x1C8] = { \
+            .name = "FRG17CLKSEL", \
+            .addr = 0x720, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x1C9] = { \
+            .name = "FRG17CTL", \
+            .addr = 0x724, \
+            .ro = 0xFFFF0000, \
+            .reset = 0xFF, \
+        }, \
+        [0x1CA] = { \
+            .name = "FLEXIOCLKSEL", \
+            .addr = 0x728, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x1D0] = { \
+            .name = "FLEXIOCLKDIV", \
+            .addr = 0x740, \
+            .ro = 0x1FFFFF00, \
+            .reset = 0x40000000, \
+        }, \
+        [0x1D8] = { \
+            .name = "FRGPLLCLKDIV", \
+            .addr = 0x760, \
+            .ro = 0x1FFFFF00, \
+            .reset = 0x40000000, \
+        }, \
+        [0x1E0] = { \
+            .name = "DMIC0FCLKSEL", \
+            .addr = 0x780, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x1E1] = { \
+            .name = "DMIC0FCLKDIV", \
+            .addr = 0x784, \
+            .ro = 0x1FFFFF00, \
+            .reset = 0x40000000, \
+        }, \
+        [0x1E8] = { \
+            .name = "CT32BITFCLKSEL0", \
+            .addr = 0x7A0, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x1E9] = { \
+            .name = "CT32BITFCLKSEL1", \
+            .addr = 0x7A4, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x1EA] = { \
+            .name = "CT32BITFCLKSEL2", \
+            .addr = 0x7A8, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x1EB] = { \
+            .name = "CT32BITFCLKSEL3", \
+            .addr = 0x7AC, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x1EC] = { \
+            .name = "CT32BITFCLKSEL4", \
+            .addr = 0x7B0, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x1F0] = { \
+            .name = "AUDIOMCLKSEL", \
+            .addr = 0x7C0, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x1F1] = { \
+            .name = "AUDIOMCLKDIV", \
+            .addr = 0x7C4, \
+            .ro = 0x1FFFFF00, \
+            .reset = 0x40000000, \
+        }, \
+        [0x1F8] = { \
+            .name = "CLKOUTSEL0", \
+            .addr = 0x7E0, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x1F9] = { \
+            .name = "CLKOUTSEL1", \
+            .addr = 0x7E4, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x1FA] = { \
+            .name = "CLKOUTFCLKDIV", \
+            .addr = 0x7E8, \
+            .ro = 0x1FFFFF00, \
+            .reset = 0x40000000, \
+        }, \
+        [0x200] = { \
+            .name = "I3C01FCLKSEL", \
+            .addr = 0x800, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x201] = { \
+            .name = "I3C01FCLKSTCSEL", \
+            .addr = 0x804, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x202] = { \
+            .name = "I3C01FCLKSTCDIV", \
+            .addr = 0x808, \
+            .ro = 0x1FFFFF00, \
+            .reset = 0x40000000, \
+        }, \
+        [0x203] = { \
+            .name = "I3C01FCLKSDIV", \
+            .addr = 0x80C, \
+            .ro = 0x1FFFFF00, \
+            .reset = 0x40000000, \
+        }, \
+        [0x204] = { \
+            .name = "I3C01FCLKDIV", \
+            .addr = 0x810, \
+            .ro = 0x1FFFFF00, \
+            .reset = 0x40000000, \
+        }, \
+        [0x205] = { \
+            .name = "I3C01FCLKSTSTCLKSEL", \
+            .addr = 0x814, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x0, \
+        }, \
+        [0x208] = { \
+            .name = "WDT1FCLKSEL", \
+            .addr = 0x820, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x0, \
+        }, \
+        [0x20C] = { \
+            .name = "ACMP0FCLKSEL", \
+            .addr = 0x830, \
+            .ro = 0xFFFFFFF8, \
+            .reset = 0x7, \
+        }, \
+        [0x20D] = { \
+            .name = "ACMP0FCLKDIV", \
+            .addr = 0x834, \
+            .ro = 0x1FFFFF00, \
+            .reset = 0x40000000, \
+        }, \
+    }
diff --git a/include/hw/misc/rt500_clk_freqs.h b/include/hw/misc/rt500_clk_freqs.h
new file mode 100644
index 0000000000..1e366d4967
--- /dev/null
+++ b/include/hw/misc/rt500_clk_freqs.h
@@ -0,0 +1,18 @@
+/*
+ * QEMU model for RT500 Clock Controller
+ *
+ * Copyright (c) 2024 Google LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_MISC_RT500_CLK_FREQS_H
+#define HW_MISC_RT500_CLK_FREQS_H
+
+#define RTC32KHZ_CLK_HZ 32000
+#define LPOSC_CLK_HZ 1000000
+
+#endif /* HW_MISC_RT500_CLK_FREQS_H */
diff --git a/include/hw/misc/rt500_clkctl0.h b/include/hw/misc/rt500_clkctl0.h
new file mode 100644
index 0000000000..890743a2ce
--- /dev/null
+++ b/include/hw/misc/rt500_clkctl0.h
@@ -0,0 +1,35 @@
+/*
+ * QEMU model for RT500 Clock Controller
+ *
+ * Copyright (c) 2024 Google LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_MISC_RT500_CLKCTL0_H
+#define HW_MISC_RT500_CLKCTL0_H
+
+#include "hw/arm/svd/rt500_clkctl0.h"
+#include "hw/sysbus.h"
+
+#define TYPE_RT500_CLKCTL0 "rt500-clkctl0"
+#define RT500_CLKCTL0(o) OBJECT_CHECK(RT500ClkCtl0State, o, TYPE_RT500_CLKCTL0)
+
+#define SYSTICKFCLKSEL_DIVOUT 0
+#define SYSTICKFCLKSEL_LPOSC 1
+#define SYSTICKFCLKSEL_32KHZRTC 2
+#define SYSTICKFCLKSEL_NONE 7
+
+typedef struct {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+    uint32_t regs[RT500_CLKCTL0_REGS_NO];
+    Clock *systick_clk;
+    Clock *sysclk;
+} RT500ClkCtl0State;
+
+#endif /* HW_MISC_RT500_CLKCTL0_H */
diff --git a/include/hw/misc/rt500_clkctl1.h b/include/hw/misc/rt500_clkctl1.h
new file mode 100644
index 0000000000..8b012b1357
--- /dev/null
+++ b/include/hw/misc/rt500_clkctl1.h
@@ -0,0 +1,36 @@
+/*
+ * QEMU model for RT500 Clock Controller
+ *
+ * Copyright (c) 2024 Google LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+
+#ifndef HW_MISC_RT500_CLKCTL1_H
+#define HW_MISC_RT500_CLKCTL1_H
+
+#include "hw/arm/svd/rt500_clkctl1.h"
+#include "hw/sysbus.h"
+
+#define TYPE_RT500_CLKCTL1 "rt500-clkctl1"
+#define RT500_CLKCTL1(o) OBJECT_CHECK(RT500ClkCtl1State, o, TYPE_RT500_CLKCTL1)
+
+#define OSEVENTTFCLKSEL_LPOSC 0
+#define OSEVENTTFCLKSEL_32KHZRTC 1
+#define OSEVENTTFCLKSEL_HCLK 2
+#define OSEVENTTFCLKSEL_NONE 7
+
+typedef struct {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+    uint32_t regs[RT500_CLKCTL1_REGS_NO];
+    Clock *sysclk;
+    Clock *ostimer_clk;
+} RT500ClkCtl1State;
+
+#endif /* HW_MISC_RT500_CLKCTL1_H */
diff --git a/hw/misc/rt500_clkctl0.c b/hw/misc/rt500_clkctl0.c
new file mode 100644
index 0000000000..7e7b176719
--- /dev/null
+++ b/hw/misc/rt500_clkctl0.c
@@ -0,0 +1,253 @@
+/*
+ * QEMU model for RT500 Clock Controller
+ *
+ * Copyright (c) 2024 Google LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/clock.h"
+#include "hw/irq.h"
+#include "hw/qdev-clock.h"
+#include "hw/qdev-properties.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "exec/address-spaces.h"
+#include "migration/vmstate.h"
+#include "hw/misc/rt500_clkctl0.h"
+#include "hw/misc/rt500_clk_freqs.h"
+
+#include "trace.h"
+
+#define REG(s, reg) (s->regs[R_RT500_CLKCTL0_##reg])
+#define RF_RD(s, reg, field) \
+    ARRAY_FIELD_EX32(s->regs, RT500_CLKCTL0_##reg, field)
+#define RF_WR(s, reg, field, val) \
+    ARRAY_FIELD_DP32(s->regs, RT500_CLKCTL0_##reg, field, val)
+
+static const RT500_CLKCTL0_REGISTER_ACCESS_INFO_ARRAY(reg_info);
+
+static MemTxResult rt500_clkctl0_read(void *opaque, hwaddr addr,
+                                      uint64_t *data, unsigned size,
+                                      MemTxAttrs attrs)
+{
+    RT500ClkCtl0State *s = opaque;
+    const struct RegisterAccessInfo *rai = &reg_info[addr / 4];
+
+    switch (addr) {
+    case A_RT500_CLKCTL0_PSCCTL0_SET:
+    case A_RT500_CLKCTL0_PSCCTL1_SET:
+    case A_RT500_CLKCTL0_PSCCTL2_SET:
+    case A_RT500_CLKCTL0_PSCCTL0_CLR:
+    case A_RT500_CLKCTL0_PSCCTL1_CLR:
+    case A_RT500_CLKCTL0_PSCCTL2_CLR:
+        /* write only registers */
+        return MEMTX_ERROR;
+    default:
+        *data = s->regs[addr / 4];
+        break;
+    }
+
+    trace_rt500_clkctl0_reg_read(rai->name, addr, *data);
+    return MEMTX_OK;
+}
+
+static inline void set_systick_clk_from_div(RT500ClkCtl0State *s)
+{
+    uint32_t div = RF_RD(s, SYSTICKFCLKDIV, DIV) + 1;
+    uint32_t rate = clock_get_hz(s->sysclk);
+
+    clock_set_hz(s->systick_clk, rate / div);
+}
+
+static MemTxResult rt500_clkctl0_write(void *opaque, hwaddr addr,
+                                       uint64_t value, unsigned size,
+                                       MemTxAttrs attrs)
+{
+    RT500ClkCtl0State *s = opaque;
+    const struct RegisterAccessInfo *rai = &reg_info[addr / 4];
+    struct RegisterInfo ri = {
+        .data = &s->regs[addr / 4],
+        .data_size = 4,
+        .access = rai,
+    };
+
+    trace_rt500_clkctl0_reg_write(rai->name, addr, value);
+
+    switch (addr) {
+    case A_RT500_CLKCTL0_PSCCTL0:
+    case A_RT500_CLKCTL0_PSCCTL1:
+    case A_RT500_CLKCTL0_PSCCTL2:
+    {
+        register_write(&ri, value, ~0, NULL, false);
+        break;
+    }
+    case A_RT500_CLKCTL0_PSCCTL0_SET:
+    case A_RT500_CLKCTL0_PSCCTL1_SET:
+    case A_RT500_CLKCTL0_PSCCTL2_SET:
+    {
+        uint32_t tmp;
+
+        tmp = A_RT500_CLKCTL0_PSCCTL0 + (addr - A_RT500_CLKCTL0_PSCCTL0_SET);
+        s->regs[tmp / 4] |= value;
+        break;
+    }
+    case A_RT500_CLKCTL0_PSCCTL0_CLR:
+    case A_RT500_CLKCTL0_PSCCTL1_CLR:
+    case A_RT500_CLKCTL0_PSCCTL2_CLR:
+    {
+        uint32_t tmp;
+
+        tmp = A_RT500_CLKCTL0_PSCCTL0 + (addr - A_RT500_CLKCTL0_PSCCTL0_CLR);
+        s->regs[tmp / 4] &= ~value;
+        break;
+    }
+    default:
+        register_write(&ri, value, ~0, NULL, false);
+    }
+
+    switch (addr) {
+    case A_RT500_CLKCTL0_SYSPLL0PFD:
+    {
+        if (!RF_RD(s, SYSPLL0PFD, PFD0_CLKGATE)) {
+            RF_WR(s, SYSPLL0PFD, PFD0_CLKRDY, 1);
+        } else {
+            RF_WR(s, SYSPLL0PFD, PFD0_CLKRDY, 0);
+        }
+        if (!RF_RD(s, SYSPLL0PFD, PFD1_CLKGATE)) {
+            RF_WR(s, SYSPLL0PFD, PFD1_CLKRDY, 1);
+        } else {
+            RF_WR(s, SYSPLL0PFD, PFD1_CLKRDY, 0);
+        }
+        if (!RF_RD(s, SYSPLL0PFD, PFD2_CLKGATE)) {
+            RF_WR(s, SYSPLL0PFD, PFD2_CLKRDY, 1);
+        } else {
+            RF_WR(s, SYSPLL0PFD, PFD2_CLKRDY, 0);
+        }
+        if (!RF_RD(s, SYSPLL0PFD, PFD3_CLKGATE)) {
+            RF_WR(s, SYSPLL0PFD, PFD3_CLKRDY, 1);
+        } else {
+            RF_WR(s, SYSPLL0PFD, PFD3_CLKRDY, 0);
+        }
+        break;
+    }
+    case A_RT500_CLKCTL0_SYSTICKFCLKSEL:
+    {
+        switch (RF_RD(s, SYSTICKFCLKSEL, SEL)) {
+        case SYSTICKFCLKSEL_DIVOUT:
+        {
+            set_systick_clk_from_div(s);
+            break;
+        }
+        case SYSTICKFCLKSEL_LPOSC:
+        {
+            clock_set_hz(s->systick_clk, LPOSC_CLK_HZ);
+            break;
+        }
+        case SYSTICKFCLKSEL_32KHZRTC:
+        {
+            clock_set_hz(s->systick_clk, RTC32KHZ_CLK_HZ);
+            break;
+        }
+        case SYSTICKFCLKSEL_NONE:
+        {
+            clock_set_hz(s->systick_clk, 0);
+            break;
+        }
+        }
+        clock_propagate(s->systick_clk);
+        break;
+    }
+    case A_RT500_CLKCTL0_SYSTICKFCLKDIV:
+    {
+        if (RF_RD(s, SYSTICKFCLKSEL, SEL) == SYSTICKFCLKSEL_DIVOUT) {
+            set_systick_clk_from_div(s);
+            clock_propagate(s->systick_clk);
+        }
+        break;
+    }
+    }
+
+    return MEMTX_OK;
+}
+
+static const MemoryRegionOps rt500_clkctl0_ops = {
+    .read_with_attrs = rt500_clkctl0_read,
+    .write_with_attrs = rt500_clkctl0_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static void rt500_clkctl0_reset_enter(Object *obj, ResetType type)
+{
+    RT500ClkCtl0State *s = RT500_CLKCTL0(obj);
+
+    for (int i = 0; i < RT500_CLKCTL0_REGS_NO; i++) {
+        hwaddr addr = reg_info[i].addr;
+
+        if (addr != -1) {
+            struct RegisterInfo ri = {
+                .data = &s->regs[addr / 4],
+                .data_size = 4,
+                .access = &reg_info[i],
+            };
+
+            register_reset(&ri);
+        }
+    }
+
+    /* clock OK immediately after reset */
+    REG(s, FROCLKSTATUS) = 0x00000001;
+}
+
+static void rt500_clkctl0_init(Object *obj)
+{
+    RT500ClkCtl0State *s = RT500_CLKCTL0(obj);
+
+    memory_region_init_io(&s->mmio, obj, &rt500_clkctl0_ops, s,
+                          TYPE_RT500_CLKCTL0, sizeof(s->regs));
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+    s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
+    s->systick_clk = qdev_init_clock_out(DEVICE(s), "systick_clk");
+}
+
+static const VMStateDescription vmstate_rt500_clkctl0 = {
+    .name = "rt500-clkctl0",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, RT500ClkCtl0State, RT500_CLKCTL0_REGS_NO),
+        VMSTATE_CLOCK(systick_clk, RT500ClkCtl0State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void rt500_clkctl0_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    rc->phases.enter = rt500_clkctl0_reset_enter;
+    dc->vmsd = &vmstate_rt500_clkctl0;
+}
+
+static const TypeInfo rt500_clkctl0_types[] = {
+    {
+        .name          = TYPE_RT500_CLKCTL0,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(RT500ClkCtl0State),
+        .instance_init = rt500_clkctl0_init,
+        .class_init    = rt500_clkctl0_class_init,
+    },
+};
+
+DEFINE_TYPES(rt500_clkctl0_types);
+
diff --git a/hw/misc/rt500_clkctl1.c b/hw/misc/rt500_clkctl1.c
new file mode 100644
index 0000000000..ed234ce0f6
--- /dev/null
+++ b/hw/misc/rt500_clkctl1.c
@@ -0,0 +1,238 @@
+/*
+ * QEMU model for RT500 Clock Controller
+ *
+ * Copyright (c) 2024 Google LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/clock.h"
+#include "hw/irq.h"
+#include "hw/qdev-clock.h"
+#include "hw/qdev-properties.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "exec/address-spaces.h"
+#include "migration/vmstate.h"
+#include "hw/misc/rt500_clkctl1.h"
+#include "hw/misc/rt500_clk_freqs.h"
+
+#include "trace.h"
+
+#define REG(s, reg) (s->regs[R_RT500_CLKCTL1_##reg])
+#define RF_RD(s, reg, field) \
+    ARRAY_FIELD_EX32(s->regs, RT500_CLKCTL1_##reg, field)
+#define RF_WR(s, reg, field, val) \
+    ARRAY_FIELD_DP32(s->regs, RT500_CLKCTL1_##reg, field, val)
+
+static RT500_CLKCTL1_REGISTER_ACCESS_INFO_ARRAY(reg_info);
+
+static MemTxResult rt500_clkctl1_read(void *opaque, hwaddr addr,
+                                      uint64_t *data, unsigned size,
+                                      MemTxAttrs attrs)
+{
+    RT500ClkCtl1State *s = opaque;
+    const struct RegisterAccessInfo *rai = &reg_info[addr / 4];
+    MemTxResult ret = MEMTX_OK;
+
+    switch (addr) {
+    case A_RT500_CLKCTL1_PSCCTL0_SET:
+    case A_RT500_CLKCTL1_PSCCTL1_SET:
+    case A_RT500_CLKCTL1_PSCCTL2_SET:
+    case A_RT500_CLKCTL1_PSCCTL0_CLR:
+    case A_RT500_CLKCTL1_PSCCTL1_CLR:
+    case A_RT500_CLKCTL1_PSCCTL2_CLR:
+        /* write only registers */
+        ret = MEMTX_ERROR;
+        break;
+    default:
+        *data = s->regs[addr / 4];
+        break;
+    }
+
+    trace_rt500_clkctl1_reg_read(rai->name, addr, *data);
+    return ret;
+}
+
+static MemTxResult rt500_clkctl1_write(void *opaque, hwaddr addr,
+                                       uint64_t value, unsigned size,
+                                       MemTxAttrs attrs)
+{
+    RT500ClkCtl1State *s = opaque;
+    const struct RegisterAccessInfo *rai = &reg_info[addr / 4];
+    struct RegisterInfo ri = {
+        .data = &s->regs[addr / 4],
+        .data_size = 4,
+        .access = rai,
+    };
+
+    trace_rt500_clkctl1_reg_write(rai->name, addr, value);
+
+    switch (addr) {
+    case A_RT500_CLKCTL1_PSCCTL0:
+    case A_RT500_CLKCTL1_PSCCTL1:
+    case A_RT500_CLKCTL1_PSCCTL2:
+    {
+        s->regs[addr / 4] = value | s->regs[addr / 4];
+        break;
+    }
+    case A_RT500_CLKCTL1_PSCCTL0_SET:
+    case A_RT500_CLKCTL1_PSCCTL1_SET:
+    case A_RT500_CLKCTL1_PSCCTL2_SET:
+    {
+        uint32_t tmp;
+
+        tmp = A_RT500_CLKCTL1_PSCCTL0 + (addr - A_RT500_CLKCTL1_PSCCTL0_SET);
+        s->regs[tmp / 4] |= value;
+        break;
+    }
+    case A_RT500_CLKCTL1_PSCCTL0_CLR:
+    case A_RT500_CLKCTL1_PSCCTL1_CLR:
+    case A_RT500_CLKCTL1_PSCCTL2_CLR:
+    {
+        uint32_t tmp;
+
+        tmp = A_RT500_CLKCTL1_PSCCTL0 + (addr - A_RT500_CLKCTL1_PSCCTL0_CLR);
+        s->regs[tmp / 4] &= ~value;
+        break;
+    }
+    default:
+        register_write(&ri, value, ~0, NULL, false);
+    }
+
+    switch (addr) {
+    case A_RT500_CLKCTL1_AUDIOPLL0PFD:
+    {
+        if (!RF_RD(s, AUDIOPLL0PFD, PFD0_CLKGATE)) {
+            RF_WR(s, AUDIOPLL0PFD, PFD0_CLKRDY, 1);
+        } else {
+            RF_WR(s, AUDIOPLL0PFD, PFD0_CLKRDY, 0);
+        }
+        if (!RF_RD(s, AUDIOPLL0PFD, PFD1_CLKGATE)) {
+            RF_WR(s, AUDIOPLL0PFD, PFD1_CLKRDY, 1);
+        } else {
+            RF_WR(s, AUDIOPLL0PFD, PFD1_CLKRDY, 0);
+        }
+        if (!RF_RD(s, AUDIOPLL0PFD, PFD2_CLKGATE)) {
+            RF_WR(s, AUDIOPLL0PFD, PFD2_CLKRDY, 1);
+        } else {
+            RF_WR(s, AUDIOPLL0PFD, PFD2_CLKRDY, 0);
+        }
+        if (!RF_RD(s, AUDIOPLL0PFD, PFD3_CLKGATE)) {
+            RF_WR(s, AUDIOPLL0PFD, PFD3_CLKRDY, 1);
+        } else {
+            RF_WR(s, AUDIOPLL0PFD, PFD3_CLKRDY, 0);
+        }
+        break;
+    }
+    case A_RT500_CLKCTL1_OSEVENTTFCLKSEL:
+    {
+        switch (RF_RD(s, OSEVENTTFCLKSEL, SEL)) {
+        case OSEVENTTFCLKSEL_LPOSC:
+        {
+            clock_set_hz(s->ostimer_clk, LPOSC_CLK_HZ);
+            break;
+        }
+        case OSEVENTTFCLKSEL_32KHZRTC:
+        {
+            clock_set_hz(s->ostimer_clk, RTC32KHZ_CLK_HZ);
+            break;
+        }
+        case OSEVENTTFCLKSEL_HCLK:
+        {
+            clock_set_hz(s->ostimer_clk, clock_get_hz(s->sysclk));
+            break;
+        }
+        case OSEVENTTFCLKSEL_NONE:
+        {
+            clock_set_hz(s->ostimer_clk, 0);
+            break;
+        }
+        }
+
+        clock_propagate(s->ostimer_clk);
+        break;
+    }
+    }
+
+    return MEMTX_OK;
+}
+
+
+static const MemoryRegionOps rt500_clkctl1_ops = {
+    .read_with_attrs = rt500_clkctl1_read,
+    .write_with_attrs = rt500_clkctl1_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static void rt500_clkctl1_reset(Object *obj, ResetType type)
+{
+    RT500ClkCtl1State *s = RT500_CLKCTL1(obj);
+
+    for (int i = 0; i < RT500_CLKCTL1_REGS_NO; i++) {
+        hwaddr addr = reg_info[i].addr;
+
+        if (addr != -1) {
+            struct RegisterInfo ri = {
+                .data = &s->regs[addr / 4],
+                .data_size = 4,
+                .access = &reg_info[i],
+            };
+
+            register_reset(&ri);
+        }
+    }
+}
+
+static void rt500_clkctl1_init(Object *obj)
+{
+    RT500ClkCtl1State *s = RT500_CLKCTL1(obj);
+
+    memory_region_init_io(&s->mmio, obj, &rt500_clkctl1_ops, s,
+                          TYPE_RT500_CLKCTL1, sizeof(s->regs));
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+    s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
+    s->ostimer_clk = qdev_init_clock_out(DEVICE(s), "ostimer_clk");
+}
+
+static const VMStateDescription vmstate_rt500_clkctl1 = {
+    .name = "rt500-clkctl1",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, RT500ClkCtl1State, RT500_CLKCTL1_REGS_NO),
+        VMSTATE_CLOCK(ostimer_clk, RT500ClkCtl1State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void rt500_clkctl1_class_init(ObjectClass *klass, void *data)
+{
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    rc->phases.enter = rt500_clkctl1_reset;
+    dc->vmsd = &vmstate_rt500_clkctl1;
+
+}
+
+static const TypeInfo rt500_clkctl1_types[] = {
+    {
+        .name          = TYPE_RT500_CLKCTL1,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(RT500ClkCtl1State),
+        .instance_init = rt500_clkctl1_init,
+        .class_init    = rt500_clkctl1_class_init,
+    }
+};
+
+DEFINE_TYPES(rt500_clkctl1_types);
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index eac5070514..658af0dace 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -629,3 +629,8 @@ config ARMSSE
     select UNIMP
     select SSE_COUNTER
     select SSE_TIMER
+
+config RT500
+    bool
+    select FLEXCOMM
+    select RT500_CLKCTL
diff --git a/hw/arm/svd/meson.build b/hw/arm/svd/meson.build
index e7d62a7f35..9c458b314c 100644
--- a/hw/arm/svd/meson.build
+++ b/hw/arm/svd/meson.build
@@ -16,4 +16,12 @@ if get_option('mcux-soc-svd')
     [ '-i', rt595, '-o', '@SOURCE_ROOT@/include/hw/arm/svd/flexcomm_spi.h',
       '-p', 'SPI0', '-t', 'FLEXCOMM_SPI',
       '--fields', 'CFG FIFOCFG:ENABLE*,EMPTY* FIFO*:* INT*: STAT'])
+  run_target('svd-rt500-clkctl0', command: svd_gen_header +
+    [ '-i', rt595, '-o', '@SOURCE_ROOT@/include/hw/arm/svd/rt500_clkctl0.h',
+      '-p', 'CLKCTL0', '-t', 'RT500_CLKCTL0',
+      '--fields', 'PSCCTL*:ROM_CTRLR_CLK,DSP_CLK SYSPLL0PFD SYSTICKFCLKSEL SYSTICKFCLKDIV FROCLKSTATUS:'])
+  run_target('svd-rt500-clkctl1', command: svd_gen_header +
+    [ '-i', rt595, '-o', '@SOURCE_ROOT@/include/hw/arm/svd/rt500_clkctl1.h',
+      '-p', 'CLKCTL1', '-t', 'RT500_CLKCTL1',
+      '--fields', 'PSCCTL*:FlexIO AUDIOPLL0PFD OSEVENTTFCLKSEL'])
 endif
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index b373e651e1..02feb93840 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -218,4 +218,7 @@ config FLEXCOMM
     select I2C
     select SSI
 
+config RT500_CLKCTL
+    bool
+
 source macio/Kconfig
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 0d901b9c65..15f9153be4 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -153,3 +153,4 @@ system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
 system_ss.add(when: 'CONFIG_LASI', if_true: files('lasi.c'))
 
 system_ss.add(when: 'CONFIG_FLEXCOMM', if_true: files('flexcomm.c'))
+system_ss.add(when: 'CONFIG_RT500_CLKCTL', if_true: files('rt500_clkctl0.c', 'rt500_clkctl1.c'))
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index dc245905dc..b19393dd36 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -368,3 +368,11 @@ flexcomm_irq(const char *id, uint8_t irq) "%s %d"
 flexcomm_reg_read(const char *devname, const char *regname, uint32_t addr, uint32_t val) "%s: %s[0x%04x] -> 0x%08x"
 flexcomm_reg_write(const char *dename, const char *regname, uint32_t addr, uint32_t val) "%s: %s[0x%04x] <- 0x%08x"
 flexcomm_fifostat(const char *id, uint32_t fifostat, uint32_t fifoinstat) "%s: %08x %08x"
+
+# rt500_clkctl0.c
+rt500_clkctl0_reg_read(const char *regname, uint32_t addr, uint32_t val) "%s[0x%04x] -> 0x%08x"
+rt500_clkctl0_reg_write(const char *regname, uint32_t addr, uint32_t val) "%s[0x%04x] <- 0x%08x"
+
+# rt500_clkctl1.c
+rt500_clkctl1_reg_read(const char *regname, uint32_t addr, uint32_t val) "%s[0x%04x] -> 0x%08x"
+rt500_clkctl1_reg_write(const char *regname, uint32_t addr, uint32_t val) "%s[0x%04x] <- 0x%08x"
-- 
2.47.0.rc0.187.ge670bccf7e-goog


