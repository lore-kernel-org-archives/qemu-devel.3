Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E450AC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAgJ-0007N4-DI; Mon, 29 Jun 2026 08:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfv-00071x-U7
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:20 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfu-0007Zg-5i
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:19 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-4629051c946so1754987f8f.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734477; x=1783339277; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5J7JbcYjvYkbmupyUVBulnGG9P2cGrj8EchG/bCGUNk=;
 b=wimX1iKlOyBtTRbPQ/tdwIjQVHCiaT+YEmRn6XLydNs2iHDqZxRW9dCtHnZJNvQwjP
 EEyK0kID4RYFALR8ay7w5ckpv7wyAtEKtTbbPUfXD0Z0+ayOCPRVWo5AZgvga3GjjjST
 2IIvdcQcD3vo7kKMhcSNEMqtfx0ZFoWLBwBnNp653bcIXqAJWAC+H8UfOTHOZY/0B2Ie
 qDRrexznEQ9HcqOv+P2l/bDDEpYeKdwkcYNOLr2TX59quGq9IyNbncniKaCrhVQr5Oi7
 /u312TrMtEyu3xO/sKMzy0PeKcMEakvOivrbnxio0/pZR9v/pFhHUDEJKzmB21+hTFai
 HU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734477; x=1783339277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5J7JbcYjvYkbmupyUVBulnGG9P2cGrj8EchG/bCGUNk=;
 b=EnyyqqODZw3k30Xq1UcjzLKUeSZXO3C9UcvwGb52wXA+dUC/fYaHHFgHrrxRSo+bqJ
 nnvd8p5d0cMx4kb7byGMThdiUHi0P8D2mraS20z4JjizCacVYeOh9D1IEa0a8pu7K+Mp
 r1LxdzC53w9HQTH3raWVysYjgZjtuOgRsl+BoJj3a0k7D/5zkgLWwpmIUh4E1aLpfh9i
 PNOZtqVPvvFFy4O9BH5LOyfOFBXf2ApoOPIDw0XY+KU9lkYbXquNz6+asedirsjem8Y1
 KIxR8Vxz3iX2rnGxvlKz9P+Iib4algwELnItdmwy49owD6Lup060ut/GJ3lvMhtZs2G4
 lSdg==
X-Gm-Message-State: AOJu0YzGlmLgEh6U0YVDX9rx7aQwgWQaRvln7ovyMzfe8CNMWXNWJ/zF
 AQAPBlCb3KUCkh5gPcYtRuIO09uNWLpO38U0im3Iw77/kPvURSPJmftAa4wH8Z8IAG3GCm1uRfx
 DoEE8
X-Gm-Gg: AfdE7cmsaxukxEZBTdjz+23eNvyWdS5wD+Sl+yfpK2inNFGCG5dWbxhVQAcQcQjS0qN
 gh48gGM8b5pMXravEWhDvcqCQ3Pr4pRrAFBWfM1DyOrLsw9MDjV7/vJP2u4Jic+mZ3vRllyJCzw
 MG6YvBIdC6zDM7fCpBfEq+9TPF6vgbCs/uNs2BGlWEu506UyU5QfP6Xbdz7nf7Jv9FyfZT+2XWU
 7QzJrwxSX1xccZe7Qao/BxNcAatz2vJ/epoNX5IF4lhvDFUIsADHPXn9/mEdNZ+vMwg/DsLFJwa
 6pLKqCtQnMjU6hyPDwcQj9CCgZ1AtckKuOrdo/lgCwT69PGcKorgAcmeChCK84O0pPz02XSlwdu
 YnOgI3So0QhqPxJHYimzqqt711c6ErXK3mLgS9CkiXXNABa0Ocd02tmuPSTsvzj9ya06mkycHFm
 tI3iTYa4MmTfUeiUlGjeiXwlOpMFSZpJOXBIbqkx5FH/9JtIrQpNMJU3W/St1WIFCP6V3WmZMj4
 2D9I1tiRlv2H8BAzbpi1A==
X-Received: by 2002:a05:6000:4022:b0:473:1e79:87e6 with SMTP id
 ffacd0b85a97d-4731e798941mr6400735f8f.3.1782734468176; 
 Mon, 29 Jun 2026 05:01:08 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.01.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:01:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/54] hw/misc/imx6_ccm: Add PLL3 and CAN clock
Date: Mon, 29 Jun 2026 13:00:11 +0100
Message-ID: <20260629120032.1645265-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Matyáš Bobek <matyas.bobek@gmail.com>

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
Message-id: 95da33074f8b79842566d61e4e04448b1e622080.1782140438.git.matyas.bobek@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
2.43.0


