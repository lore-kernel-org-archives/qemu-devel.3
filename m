Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D82CCD98DE
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 12:17:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ6EU-0008PF-UV; Mon, 15 Jun 2026 08:16:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matyas.bobek@gmail.com>)
 id 1wZ6EP-0008NA-VW
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 08:15:58 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <matyas.bobek@gmail.com>)
 id 1wZ6EO-0003UD-AF
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 08:15:57 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-490b613a17bso29239065e9.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 05:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781525755; x=1782130555; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v7B7MPlm8lxhhWU0KcQHkTsOfZGkRsES1ICXN/vP+BI=;
 b=kEuwHikMiFw0dYD/98yZK560aGfBULoWjVrDK6+FGfmc6rz2NKZ1iIzWm8ZSi14Sy2
 uSLiSxzDZRY3gmpBpHxrDLgB2yzLNQZyDZo4a+GVFwgNnvN0XFh1taFUnttSgrvUJLeh
 3i8L11mgEKWCrgVaK558TknqoOuFGl2wTvpEyuKymjWeaNyhESfPPYh0y5a/4GhlKhev
 MzVZWqV0toSmlHkw/MrQrrjZgqGKkGVB/VY7/kU1miic27Hi6vgCVfj4ptG3rkuEG92e
 o+OrDV4ns96k6hiHkFlG9b8u1pF6EN8qkFM7kJAH7uvTDFid7FagbByOP3l/3o9Aa1Vy
 i3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781525755; x=1782130555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v7B7MPlm8lxhhWU0KcQHkTsOfZGkRsES1ICXN/vP+BI=;
 b=DGh5zy3ebt8IgKh8/EmRtMEVbQcITIwgxRVS72thclh/kUOggFCjq1ODt9V4mCGrKU
 YUhluMa5uOTdeIOpyANLZuS1JtKFsGAfWTGSSYwz8hHKnBQErXQBssjL3n2XXZOE9b4i
 wqB86ugUUkk15rjJHW6/rosUHTLWN+iFPG7P6mYCdgY0uw1etKyqjOS7Lbr3r/IIF4xq
 35EubhSDq8Qmq4TSi1pH5eSuRwTflbl3iC6aAtyC6BHnfxh8Dy6VFk9T9q4PP0w2MCu0
 OiBPBK+rxB/x9QYh4j0RNryUHK54gCi6q8hlTa78Lzr2bw5qgQ8s0NholM29rbsBGjG3
 hdVw==
X-Gm-Message-State: AOJu0YzcsXCWN4D7RD1u07NoWCS2QQbT5yj7LG8ND0nIOw1iFdKhwmcG
 BoVUXkWw/epUjs/pihDBQ0sCfG6b+kCHzfr5v7IixAFlGK4wjcqko/0+QOlCGW9Q
X-Gm-Gg: Acq92OHOw2YChb4AtBcIW6Gh+J3nWYAwyqKfdb6KLLvO6JGQJD1mnXPUDZpZCUOvp6T
 d2PUSS8dpbTpFY0WaFrsaGB1eDQ3BoaE1rmBR8haTG438yUn+mGHl7/QwPKpHd2P/DfE9ztFpzt
 YKD2uMJNBqZTDnr/RqTGef2LAJ2DxF9xOtMWQx42Zi5AnvXD3e9l3R9PYbBdEC6ttZsMTwfa4GG
 O5H6Tcq04W1o5kqjSSbbKDy2ht4hk+yDxCBTjcY8TwIctLqsaO6nTYzta0GIkWf3l8iSoL9etRm
 SBc0HbXKR9ZaEWJSZj1NBm2eRUe3TdQFTUiTnmHHUuBD58bzVTZqXKQ1O4OMXdqNNgpu332BkoX
 ykrSjE72nWnD59gwhjhRHUd6xveEeI2lrenoH5qO2wwRvZjVwFL1QGHVbRBIe/H7wj7APvyjohI
 tKJC+ATfuz652EYA6W9iWrq2diaBP2nGQI/98rdolfRP3z7zio/WMEew==
X-Received: by 2002:a7b:c351:0:b0:492:1e36:8c72 with SMTP id
 5b1f17b1804b1-4921e368c9fmr112270615e9.37.1781525754405; 
 Mon, 15 Jun 2026 05:15:54 -0700 (PDT)
Received: from acidburn.pod.cvut.cz (acidburn.pod.cvut.cz. [147.32.90.2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea4a128csm338491345e9.0.2026.06.15.05.15.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 05:15:53 -0700 (PDT)
From: =?UTF-8?q?Maty=C3=A1=C5=A1=20Bobek?= <matyas.bobek@gmail.com>
To: qemu-devel@nongnu.org, Matyas Bobek <bobekmat@fel.cvut.cz>,
 Pavel Pisa <pisa@fel.cvut.cz>, Bernhard Beschow <shentey@gmail.com>
Cc: qemu-arm@nongnu.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Andrey Volkov <andrey@volkov.fr>,
 =?UTF-8?q?Maty=C3=A1=C5=A1=20Bobek?= <matyas.bobek@gmail.com>
Subject: [PATCH v5 3/7] hw/misc/imx6_ccm: Add PLL3 and CAN clock
Date: Mon, 15 Jun 2026 14:15:03 +0200
Message-ID: <f91287d28f597d168bb7d5057a6009a3a9dae729.1781111270.git.matyas.bobek@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1781111270.git.matyas.bobek@gmail.com>
References: <cover.1781111270.git.matyas.bobek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=matyas.bobek@gmail.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add fixed frequency (480 MHz) PLL3, of which the FlexCAN
clock is derived, and compute FlexCAN frequency based on
the divider configuration (CCM_CSCMR2).

The clock frequency will be used for computing timestamps
in FlexCAN emulator.

Signed-off-by: Matyáš Bobek <matyas.bobek@gmail.com>
Signed-off-by: Pavel Pisa <pisa@fel.cvut.cz>
Tested-by: Pavel Pisa <pisa@fel.cvut.cz>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Pavel Pisa <pisa@fel.cvut.cz>
---
 hw/misc/imx6_ccm.c         | 24 ++++++++++++++++++++++++
 hw/misc/trace-events       |  2 ++
 include/hw/misc/imx6_ccm.h |  4 ++++
 include/hw/misc/imx_ccm.h  |  1 +
 4 files changed, 31 insertions(+)

diff --git a/hw/misc/imx6_ccm.c b/hw/misc/imx6_ccm.c
index a10b67d396..45fdd0d5a8 100644
--- a/hw/misc/imx6_ccm.c
+++ b/hw/misc/imx6_ccm.c
@@ -257,6 +257,15 @@ static uint64_t imx6_analog_get_pll2_clk(IMX6CCMState *dev)
     return freq;
 }
 
+static uint64_t imx6_analog_get_pll3_clk(IMX6CCMState *dev)
+{
+    uint64_t freq = 480000000;
+
+    trace_imx6_analog_get_pll3_clk(freq);
+
+    return freq;
+}
+
 static uint64_t imx6_analog_get_pll2_pfd0_clk(IMX6CCMState *dev)
 {
     uint64_t freq = 0;
@@ -344,6 +353,18 @@ static uint64_t imx6_ccm_get_per_clk(IMX6CCMState *dev)
     return freq;
 }
 
+static uint64_t imx6_ccm_get_can_clk(IMX6CCMState *dev)
+{
+    uint64_t freq = 0;
+
+    freq = imx6_analog_get_pll3_clk(dev) / 8;
+    freq /= (1 + EXTRACT(dev->ccm[CCM_CSCMR2], CAN_CLK_PODF));
+
+    trace_imx6_ccm_get_can_clk(freq);
+
+    return freq;
+}
+
 static uint32_t imx6_ccm_get_clock_frequency(IMXCCMState *dev, IMXClk clock)
 {
     uint32_t freq = 0;
@@ -358,6 +379,9 @@ static uint32_t imx6_ccm_get_clock_frequency(IMXCCMState *dev, IMXClk clock)
     case CLK_IPG_HIGH:
         freq = imx6_ccm_get_per_clk(s);
         break;
+    case CLK_CAN:
+        freq = imx6_ccm_get_can_clk(s);
+        break;
     case CLK_32k:
         freq = CKIL_FREQ;
         break;
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index b88accc437..99910fc068 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -242,11 +242,13 @@ imx6_analog_get_periph_clk(uint32_t freq) "freq = %u Hz"
 imx6_analog_get_pll2_clk(uint32_t freq) "freq = %u Hz"
 imx6_analog_get_pll2_pfd0_clk(uint32_t freq) "freq = %u Hz"
 imx6_analog_get_pll2_pfd2_clk(uint32_t freq) "freq = %u Hz"
+imx6_analog_get_pll3_clk(uint32_t freq) "freq = %u Hz"
 imx6_analog_read(const char *reg, uint32_t value) "reg[%s] => 0x%" PRIx32
 imx6_analog_write(const char *reg, uint32_t value) "reg[%s] <= 0x%" PRIx32
 imx6_ccm_get_ahb_clk(uint32_t freq) "freq = %u Hz"
 imx6_ccm_get_ipg_clk(uint32_t freq) "freq = %u Hz"
 imx6_ccm_get_per_clk(uint32_t freq) "freq = %u Hz"
+imx6_ccm_get_can_clk(uint32_t freq) "freq = %u Hz"
 imx6_ccm_get_clock_frequency(unsigned clock, uint32_t freq) "(Clock = %d) = %u"
 imx6_ccm_read(const char *reg, uint32_t value) "reg[%s] => 0x%" PRIx32
 imx6_ccm_reset(void) ""
diff --git a/include/hw/misc/imx6_ccm.h b/include/hw/misc/imx6_ccm.h
index ccf46d7353..a54b940686 100644
--- a/include/hw/misc/imx6_ccm.h
+++ b/include/hw/misc/imx6_ccm.h
@@ -164,6 +164,10 @@
 #define PERCLK_PODF_SHIFT        (0)
 #define PERCLK_PODF_LENGTH       (6)
 
+/* CCM_CSCMR2 */
+#define CAN_CLK_PODF_SHIFT       (2)
+#define CAN_CLK_PODF_LENGTH      (6)
+
 /* CCM_ANALOG_PFD_528 */
 #define PFD0_FRAC_SHIFT          (0)
 #define PFD0_FRAC_LENGTH         (6)
diff --git a/include/hw/misc/imx_ccm.h b/include/hw/misc/imx_ccm.h
index c4212d04ea..6839716ea3 100644
--- a/include/hw/misc/imx_ccm.h
+++ b/include/hw/misc/imx_ccm.h
@@ -46,6 +46,7 @@ typedef enum  {
     CLK_EXT,
     CLK_HIGH_DIV,
     CLK_HIGH,
+    CLK_CAN,
 } IMXClk;
 
 struct IMXCCMClass {
-- 
2.54.0


