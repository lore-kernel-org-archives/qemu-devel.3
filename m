Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B2EC2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVn4-0004R0-3B; Thu, 15 May 2025 06:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVn1-0004QV-SE
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:11 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVmw-00088b-6t
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:11 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a0b7fbdde7so668984f8f.2
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304764; x=1747909564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kJS0qdxrcVwU1ns/laR+ZxTJ7In/lnQUzlm7LLPC2Cw=;
 b=PHzEMzLeAuNA36W6cQ1wT8CSV9nVvXP11dRWFEhQjHRAuix2kRKX3NIWLEybWbOhK8
 jlHobTRQMJqD0JQY1rIOuZmrGQHE0Rt0T+mmWfBg3w1nFXP1VOt765A/A3fc+QPHjXEb
 s0FQX4iVtWt6zjfe8k7qOfRQtTUGpLEZF7fWdi9hTuByFEe8W0v/ZYXss1kE6LwTIYF1
 44WNS54ugc6CEIywmPEk8sJ8XFA8W3V0CerLRBTYTGGmEhtiIPNmw/92pkI9gUOj+AjX
 Sx3hRpQDsTdIkrKVeQPyT+4nPGVxWSEencdbtibTtMvq+4EYq32UHj1ljsq0oGkHD4RJ
 7f8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304764; x=1747909564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kJS0qdxrcVwU1ns/laR+ZxTJ7In/lnQUzlm7LLPC2Cw=;
 b=w268kuZHRbhNGwhVesJ2UHSd9u90CqJyLp6SQWLPonVDgf+iG19qleb9zFS8QTS3xp
 AxwnquQWGMY4akuUEJyja900H71n5Z8MOyOzVvLlqPtOQHjnQrTZJgYIyFvzMObi0Lwh
 NQhZT5z151I00nZp1M0pgV3g8IJrN0wQvOlx9jVNOuMUIJ2LrPY6fwZtnDDpc3SMnfzM
 FAwjthUbxt+L9OjUPznqHVE+oLXio4L+icbTKsqxZksmu6aELfFNcdnzyLKfF6F5CA44
 0eQlXX/oS+MA81DRv4af/oLURgNH24mjjuknG/S63tEehKg1cY5V5S7ax8QFSgZ9veKT
 oy0w==
X-Gm-Message-State: AOJu0Yyda1J4ybcPf7zLS9Og2bprGWOuc3fToCiMIVI8BdNnRFM2oqXv
 xJHP6QHwa166u0kTwm3V7mjXmq9BSjT6ivUr35vcQir8QJILpVYSa2W8s1BIx0jV5i0uM+C4sJp
 9OVA=
X-Gm-Gg: ASbGncstCCyJxjz0OAQ4wXkJkrA/jj2XKJsIjY0seXP+EqmmmAzPajLL3z1luAxrDzg
 XfLlqUYplVfBoI2jg1j6NkH2q1q2YHhWa4tlEQcCKDPziJa62S4VKQ5V65WoxvdIm60TCrLnlXb
 c+wr6f1xrK56tJALooX73MJGXRK4TMzleUHGYTPhgRu04CdN0twu+gx1Q9xi4rD2ED8nyG2wyni
 H2ihrp2qBv42TpjNLTbHmABU+MCBXJlPDf5JxFjIYVSjVj/isqup61MmrZS3C76fk2/qHBpbaG3
 YLsh3cWMkygP4/mloZpJxhsrTrIZRJ1UnzTbYEpVNt1JGGRqbUwpNkQD8A==
X-Google-Smtp-Source: AGHT+IEWxPBmFaSyRhgLmtuPIncMmun0qQVNTEeJAnOEQiOWBLc/bgSM43F8V0ui2wtl6k9cEXHW8A==
X-Received: by 2002:a05:6000:2ac:b0:3a3:5ae4:6e8e with SMTP id
 ffacd0b85a97d-3a35ae471a7mr808069f8f.11.1747304762906; 
 Thu, 15 May 2025 03:26:02 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.26.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:26:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/58] hw/arm: Replace TABs for spaces in OMAP board and device
 code
Date: Thu, 15 May 2025 11:24:57 +0100
Message-ID: <20250515102546.2149601-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Santiago Monserrat Campanello <santimonserr@gmail.com>

In hw/arm and include/hw/arm, some source files for the OMAP SoC
and the sx1 boards that are our only remaining OMAP boards still
have hard-coded tabs (almost entirely used for the indent on
inline comments, not for actual code indent).

Replace the tabs with spaces using vim :retab. I used 4 spaces
except in some defines and comments where I tried to put
everything aligned in the same column for better readability.

This commit is a purely whitespace-only change.

Signed-off-by: Santiago Monserrat Campanello <santimonserr@gmail.com>
Message-id: 20250505131130.82206-1-santimonserr@gmail.com
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/373
[PMM: expanded commit message]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/omap.h    |  534 ++++++++++----------
 include/hw/arm/sharpsl.h |    2 +-
 include/hw/arm/soc_dma.h |    4 +-
 hw/arm/omap1.c           | 1016 +++++++++++++++++++-------------------
 hw/arm/omap_sx1.c        |    2 +-
 hw/dma/omap_dma.c        |  334 ++++++-------
 hw/gpio/omap_gpio.c      |   28 +-
 hw/i2c/omap_i2c.c        |  178 +++----
 hw/intc/omap_intc.c      |  154 +++---
 hw/misc/omap_clk.c       |  470 +++++++++---------
 hw/timer/pxa2xx_timer.c  |   76 +--
 11 files changed, 1399 insertions(+), 1399 deletions(-)

diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index 6185507373d..bdb2e887e47 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -25,24 +25,24 @@
 #include "qemu/log.h"
 #include "qom/object.h"
 
-# define OMAP_EMIFS_BASE	0x00000000
-# define OMAP_CS0_BASE		0x00000000
-# define OMAP_CS1_BASE		0x04000000
-# define OMAP_CS2_BASE		0x08000000
-# define OMAP_CS3_BASE		0x0c000000
-# define OMAP_EMIFF_BASE	0x10000000
-# define OMAP_IMIF_BASE		0x20000000
-# define OMAP_LOCALBUS_BASE	0x30000000
-# define OMAP_MPUI_BASE		0xe1000000
+#define OMAP_EMIFS_BASE    0x00000000
+#define OMAP_CS0_BASE      0x00000000
+#define OMAP_CS1_BASE      0x04000000
+#define OMAP_CS2_BASE      0x08000000
+#define OMAP_CS3_BASE      0x0c000000
+#define OMAP_EMIFF_BASE    0x10000000
+#define OMAP_IMIF_BASE     0x20000000
+#define OMAP_LOCALBUS_BASE 0x30000000
+#define OMAP_MPUI_BASE     0xe1000000
 
-# define OMAP730_SRAM_SIZE	0x00032000
-# define OMAP15XX_SRAM_SIZE	0x00030000
-# define OMAP16XX_SRAM_SIZE	0x00004000
-# define OMAP1611_SRAM_SIZE	0x0003e800
-# define OMAP_CS0_SIZE		0x04000000
-# define OMAP_CS1_SIZE		0x04000000
-# define OMAP_CS2_SIZE		0x04000000
-# define OMAP_CS3_SIZE		0x04000000
+#define OMAP730_SRAM_SIZE  0x00032000
+#define OMAP15XX_SRAM_SIZE 0x00030000
+#define OMAP16XX_SRAM_SIZE 0x00004000
+#define OMAP1611_SRAM_SIZE 0x0003e800
+#define OMAP_CS0_SIZE      0x04000000
+#define OMAP_CS1_SIZE      0x04000000
+#define OMAP_CS2_SIZE      0x04000000
+#define OMAP_CS3_SIZE      0x04000000
 
 /* omap_clk.c */
 struct omap_mpu_state_s;
@@ -103,228 +103,228 @@ void omap_gpio_set_clk(Omap1GpioState *gpio, omap_clk clk);
  * Common IRQ numbers for level 1 interrupt handler
  * See /usr/include/asm-arm/arch-omap/irqs.h in Linux.
  */
-# define OMAP_INT_CAMERA		1
-# define OMAP_INT_FIQ			3
-# define OMAP_INT_RTDX			6
-# define OMAP_INT_DSP_MMU_ABORT		7
-# define OMAP_INT_HOST			8
-# define OMAP_INT_ABORT			9
-# define OMAP_INT_BRIDGE_PRIV		13
-# define OMAP_INT_GPIO_BANK1		14
-# define OMAP_INT_UART3			15
-# define OMAP_INT_TIMER3		16
-# define OMAP_INT_DMA_CH0_6		19
-# define OMAP_INT_DMA_CH1_7		20
-# define OMAP_INT_DMA_CH2_8		21
-# define OMAP_INT_DMA_CH3		22
-# define OMAP_INT_DMA_CH4		23
-# define OMAP_INT_DMA_CH5		24
-# define OMAP_INT_DMA_LCD		25
-# define OMAP_INT_TIMER1		26
-# define OMAP_INT_WD_TIMER		27
-# define OMAP_INT_BRIDGE_PUB		28
-# define OMAP_INT_TIMER2		30
-# define OMAP_INT_LCD_CTRL		31
+#define OMAP_INT_CAMERA            1
+#define OMAP_INT_FIQ               3
+#define OMAP_INT_RTDX              6
+#define OMAP_INT_DSP_MMU_ABORT     7
+#define OMAP_INT_HOST              8
+#define OMAP_INT_ABORT             9
+#define OMAP_INT_BRIDGE_PRIV       13
+#define OMAP_INT_GPIO_BANK1        14
+#define OMAP_INT_UART3             15
+#define OMAP_INT_TIMER3            16
+#define OMAP_INT_DMA_CH0_6         19
+#define OMAP_INT_DMA_CH1_7         20
+#define OMAP_INT_DMA_CH2_8         21
+#define OMAP_INT_DMA_CH3           22
+#define OMAP_INT_DMA_CH4           23
+#define OMAP_INT_DMA_CH5           24
+#define OMAP_INT_DMA_LCD           25
+#define OMAP_INT_TIMER1            26
+#define OMAP_INT_WD_TIMER          27
+#define OMAP_INT_BRIDGE_PUB        28
+#define OMAP_INT_TIMER2            30
+#define OMAP_INT_LCD_CTRL          31
 
 /*
  * Common OMAP-15xx IRQ numbers for level 1 interrupt handler
  */
-# define OMAP_INT_15XX_IH2_IRQ		0
-# define OMAP_INT_15XX_LB_MMU		17
-# define OMAP_INT_15XX_LOCAL_BUS	29
+#define OMAP_INT_15XX_IH2_IRQ      0
+#define OMAP_INT_15XX_LB_MMU       17
+#define OMAP_INT_15XX_LOCAL_BUS    29
 
 /*
  * OMAP-1510 specific IRQ numbers for level 1 interrupt handler
  */
-# define OMAP_INT_1510_SPI_TX		4
-# define OMAP_INT_1510_SPI_RX		5
-# define OMAP_INT_1510_DSP_MAILBOX1	10
-# define OMAP_INT_1510_DSP_MAILBOX2	11
+#define OMAP_INT_1510_SPI_TX       4
+#define OMAP_INT_1510_SPI_RX       5
+#define OMAP_INT_1510_DSP_MAILBOX1 10
+#define OMAP_INT_1510_DSP_MAILBOX2 11
 
 /*
  * OMAP-310 specific IRQ numbers for level 1 interrupt handler
  */
-# define OMAP_INT_310_McBSP2_TX		4
-# define OMAP_INT_310_McBSP2_RX		5
-# define OMAP_INT_310_HSB_MAILBOX1	12
-# define OMAP_INT_310_HSAB_MMU		18
+#define OMAP_INT_310_McBSP2_TX     4
+#define OMAP_INT_310_McBSP2_RX     5
+#define OMAP_INT_310_HSB_MAILBOX1  12
+#define OMAP_INT_310_HSAB_MMU      18
 
 /*
  * OMAP-1610 specific IRQ numbers for level 1 interrupt handler
  */
-# define OMAP_INT_1610_IH2_IRQ		0
-# define OMAP_INT_1610_IH2_FIQ		2
-# define OMAP_INT_1610_McBSP2_TX	4
-# define OMAP_INT_1610_McBSP2_RX	5
-# define OMAP_INT_1610_DSP_MAILBOX1	10
-# define OMAP_INT_1610_DSP_MAILBOX2	11
-# define OMAP_INT_1610_LCD_LINE		12
-# define OMAP_INT_1610_GPTIMER1		17
-# define OMAP_INT_1610_GPTIMER2		18
-# define OMAP_INT_1610_SSR_FIFO_0	29
+#define OMAP_INT_1610_IH2_IRQ      0
+#define OMAP_INT_1610_IH2_FIQ      2
+#define OMAP_INT_1610_McBSP2_TX    4
+#define OMAP_INT_1610_McBSP2_RX    5
+#define OMAP_INT_1610_DSP_MAILBOX1 10
+#define OMAP_INT_1610_DSP_MAILBOX2 11
+#define OMAP_INT_1610_LCD_LINE     12
+#define OMAP_INT_1610_GPTIMER1     17
+#define OMAP_INT_1610_GPTIMER2     18
+#define OMAP_INT_1610_SSR_FIFO_0   29
 
 /*
  * OMAP-730 specific IRQ numbers for level 1 interrupt handler
  */
-# define OMAP_INT_730_IH2_FIQ		0
-# define OMAP_INT_730_IH2_IRQ		1
-# define OMAP_INT_730_USB_NON_ISO	2
-# define OMAP_INT_730_USB_ISO		3
-# define OMAP_INT_730_ICR		4
-# define OMAP_INT_730_EAC		5
-# define OMAP_INT_730_GPIO_BANK1	6
-# define OMAP_INT_730_GPIO_BANK2	7
-# define OMAP_INT_730_GPIO_BANK3	8
-# define OMAP_INT_730_McBSP2TX		10
-# define OMAP_INT_730_McBSP2RX		11
-# define OMAP_INT_730_McBSP2RX_OVF	12
-# define OMAP_INT_730_LCD_LINE		14
-# define OMAP_INT_730_GSM_PROTECT	15
-# define OMAP_INT_730_TIMER3		16
-# define OMAP_INT_730_GPIO_BANK5	17
-# define OMAP_INT_730_GPIO_BANK6	18
-# define OMAP_INT_730_SPGIO_WR		29
+#define OMAP_INT_730_IH2_FIQ       0
+#define OMAP_INT_730_IH2_IRQ       1
+#define OMAP_INT_730_USB_NON_ISO   2
+#define OMAP_INT_730_USB_ISO       3
+#define OMAP_INT_730_ICR           4
+#define OMAP_INT_730_EAC           5
+#define OMAP_INT_730_GPIO_BANK1    6
+#define OMAP_INT_730_GPIO_BANK2    7
+#define OMAP_INT_730_GPIO_BANK3    8
+#define OMAP_INT_730_McBSP2TX      10
+#define OMAP_INT_730_McBSP2RX      11
+#define OMAP_INT_730_McBSP2RX_OVF  12
+#define OMAP_INT_730_LCD_LINE      14
+#define OMAP_INT_730_GSM_PROTECT   15
+#define OMAP_INT_730_TIMER3        16
+#define OMAP_INT_730_GPIO_BANK5    17
+#define OMAP_INT_730_GPIO_BANK6    18
+#define OMAP_INT_730_SPGIO_WR      29
 
 /*
  * Common IRQ numbers for level 2 interrupt handler
  */
-# define OMAP_INT_KEYBOARD		1
-# define OMAP_INT_uWireTX		2
-# define OMAP_INT_uWireRX		3
-# define OMAP_INT_I2C			4
-# define OMAP_INT_MPUIO			5
-# define OMAP_INT_USB_HHC_1		6
-# define OMAP_INT_McBSP3TX		10
-# define OMAP_INT_McBSP3RX		11
-# define OMAP_INT_McBSP1TX		12
-# define OMAP_INT_McBSP1RX		13
-# define OMAP_INT_UART1			14
-# define OMAP_INT_UART2			15
-# define OMAP_INT_USB_W2FC		20
-# define OMAP_INT_1WIRE			21
-# define OMAP_INT_OS_TIMER		22
-# define OMAP_INT_OQN			23
-# define OMAP_INT_GAUGE_32K		24
-# define OMAP_INT_RTC_TIMER		25
-# define OMAP_INT_RTC_ALARM		26
-# define OMAP_INT_DSP_MMU		28
+#define OMAP_INT_KEYBOARD      1
+#define OMAP_INT_uWireTX       2
+#define OMAP_INT_uWireRX       3
+#define OMAP_INT_I2C           4
+#define OMAP_INT_MPUIO         5
+#define OMAP_INT_USB_HHC_1     6
+#define OMAP_INT_McBSP3TX      10
+#define OMAP_INT_McBSP3RX      11
+#define OMAP_INT_McBSP1TX      12
+#define OMAP_INT_McBSP1RX      13
+#define OMAP_INT_UART1         14
+#define OMAP_INT_UART2         15
+#define OMAP_INT_USB_W2FC      20
+#define OMAP_INT_1WIRE         21
+#define OMAP_INT_OS_TIMER      22
+#define OMAP_INT_OQN           23
+#define OMAP_INT_GAUGE_32K     24
+#define OMAP_INT_RTC_TIMER     25
+#define OMAP_INT_RTC_ALARM     26
+#define OMAP_INT_DSP_MMU       28
 
 /*
  * OMAP-1510 specific IRQ numbers for level 2 interrupt handler
  */
-# define OMAP_INT_1510_BT_MCSI1TX	16
-# define OMAP_INT_1510_BT_MCSI1RX	17
-# define OMAP_INT_1510_SoSSI_MATCH	19
-# define OMAP_INT_1510_MEM_STICK	27
-# define OMAP_INT_1510_COM_SPI_RO	31
+#define OMAP_INT_1510_BT_MCSI1TX   16
+#define OMAP_INT_1510_BT_MCSI1RX   17
+#define OMAP_INT_1510_SoSSI_MATCH  19
+#define OMAP_INT_1510_MEM_STICK    27
+#define OMAP_INT_1510_COM_SPI_RO   31
 
 /*
  * OMAP-310 specific IRQ numbers for level 2 interrupt handler
  */
-# define OMAP_INT_310_FAC		0
-# define OMAP_INT_310_USB_HHC_2		7
-# define OMAP_INT_310_MCSI1_FE		16
-# define OMAP_INT_310_MCSI2_FE		17
-# define OMAP_INT_310_USB_W2FC_ISO	29
-# define OMAP_INT_310_USB_W2FC_NON_ISO	30
-# define OMAP_INT_310_McBSP2RX_OF	31
+#define OMAP_INT_310_FAC               0
+#define OMAP_INT_310_USB_HHC_2         7
+#define OMAP_INT_310_MCSI1_FE          16
+#define OMAP_INT_310_MCSI2_FE          17
+#define OMAP_INT_310_USB_W2FC_ISO      29
+#define OMAP_INT_310_USB_W2FC_NON_ISO  30
+#define OMAP_INT_310_McBSP2RX_OF       31
 
 /*
  * OMAP-1610 specific IRQ numbers for level 2 interrupt handler
  */
-# define OMAP_INT_1610_FAC		0
-# define OMAP_INT_1610_USB_HHC_2	7
-# define OMAP_INT_1610_USB_OTG		8
-# define OMAP_INT_1610_SoSSI		9
-# define OMAP_INT_1610_BT_MCSI1TX	16
-# define OMAP_INT_1610_BT_MCSI1RX	17
-# define OMAP_INT_1610_SoSSI_MATCH	19
-# define OMAP_INT_1610_MEM_STICK	27
-# define OMAP_INT_1610_McBSP2RX_OF	31
-# define OMAP_INT_1610_STI		32
-# define OMAP_INT_1610_STI_WAKEUP	33
-# define OMAP_INT_1610_GPTIMER3		34
-# define OMAP_INT_1610_GPTIMER4		35
-# define OMAP_INT_1610_GPTIMER5		36
-# define OMAP_INT_1610_GPTIMER6		37
-# define OMAP_INT_1610_GPTIMER7		38
-# define OMAP_INT_1610_GPTIMER8		39
-# define OMAP_INT_1610_GPIO_BANK2	40
-# define OMAP_INT_1610_GPIO_BANK3	41
-# define OMAP_INT_1610_MMC2		42
-# define OMAP_INT_1610_CF		43
-# define OMAP_INT_1610_WAKE_UP_REQ	46
-# define OMAP_INT_1610_GPIO_BANK4	48
-# define OMAP_INT_1610_SPI		49
-# define OMAP_INT_1610_DMA_CH6		53
-# define OMAP_INT_1610_DMA_CH7		54
-# define OMAP_INT_1610_DMA_CH8		55
-# define OMAP_INT_1610_DMA_CH9		56
-# define OMAP_INT_1610_DMA_CH10		57
-# define OMAP_INT_1610_DMA_CH11		58
-# define OMAP_INT_1610_DMA_CH12		59
-# define OMAP_INT_1610_DMA_CH13		60
-# define OMAP_INT_1610_DMA_CH14		61
-# define OMAP_INT_1610_DMA_CH15		62
-# define OMAP_INT_1610_NAND		63
+#define OMAP_INT_1610_FAC          0
+#define OMAP_INT_1610_USB_HHC_2    7
+#define OMAP_INT_1610_USB_OTG      8
+#define OMAP_INT_1610_SoSSI        9
+#define OMAP_INT_1610_BT_MCSI1TX   16
+#define OMAP_INT_1610_BT_MCSI1RX   17
+#define OMAP_INT_1610_SoSSI_MATCH  19
+#define OMAP_INT_1610_MEM_STICK    27
+#define OMAP_INT_1610_McBSP2RX_OF  31
+#define OMAP_INT_1610_STI          32
+#define OMAP_INT_1610_STI_WAKEUP   33
+#define OMAP_INT_1610_GPTIMER3     34
+#define OMAP_INT_1610_GPTIMER4     35
+#define OMAP_INT_1610_GPTIMER5     36
+#define OMAP_INT_1610_GPTIMER6     37
+#define OMAP_INT_1610_GPTIMER7     38
+#define OMAP_INT_1610_GPTIMER8     39
+#define OMAP_INT_1610_GPIO_BANK2   40
+#define OMAP_INT_1610_GPIO_BANK3   41
+#define OMAP_INT_1610_MMC2         42
+#define OMAP_INT_1610_CF           43
+#define OMAP_INT_1610_WAKE_UP_REQ  46
+#define OMAP_INT_1610_GPIO_BANK4   48
+#define OMAP_INT_1610_SPI          49
+#define OMAP_INT_1610_DMA_CH6      53
+#define OMAP_INT_1610_DMA_CH7      54
+#define OMAP_INT_1610_DMA_CH8      55
+#define OMAP_INT_1610_DMA_CH9      56
+#define OMAP_INT_1610_DMA_CH10     57
+#define OMAP_INT_1610_DMA_CH11     58
+#define OMAP_INT_1610_DMA_CH12     59
+#define OMAP_INT_1610_DMA_CH13     60
+#define OMAP_INT_1610_DMA_CH14     61
+#define OMAP_INT_1610_DMA_CH15     62
+#define OMAP_INT_1610_NAND         63
 
 /*
  * OMAP-730 specific IRQ numbers for level 2 interrupt handler
  */
-# define OMAP_INT_730_HW_ERRORS		0
-# define OMAP_INT_730_NFIQ_PWR_FAIL	1
-# define OMAP_INT_730_CFCD		2
-# define OMAP_INT_730_CFIREQ		3
-# define OMAP_INT_730_I2C		4
-# define OMAP_INT_730_PCC		5
-# define OMAP_INT_730_MPU_EXT_NIRQ	6
-# define OMAP_INT_730_SPI_100K_1	7
-# define OMAP_INT_730_SYREN_SPI		8
-# define OMAP_INT_730_VLYNQ		9
-# define OMAP_INT_730_GPIO_BANK4	10
-# define OMAP_INT_730_McBSP1TX		11
-# define OMAP_INT_730_McBSP1RX		12
-# define OMAP_INT_730_McBSP1RX_OF	13
-# define OMAP_INT_730_UART_MODEM_IRDA_2	14
-# define OMAP_INT_730_UART_MODEM_1	15
-# define OMAP_INT_730_MCSI		16
-# define OMAP_INT_730_uWireTX		17
-# define OMAP_INT_730_uWireRX		18
-# define OMAP_INT_730_SMC_CD		19
-# define OMAP_INT_730_SMC_IREQ		20
-# define OMAP_INT_730_HDQ_1WIRE		21
-# define OMAP_INT_730_TIMER32K		22
-# define OMAP_INT_730_MMC_SDIO		23
-# define OMAP_INT_730_UPLD		24
-# define OMAP_INT_730_USB_HHC_1		27
-# define OMAP_INT_730_USB_HHC_2		28
-# define OMAP_INT_730_USB_GENI		29
-# define OMAP_INT_730_USB_OTG		30
-# define OMAP_INT_730_CAMERA_IF		31
-# define OMAP_INT_730_RNG		32
-# define OMAP_INT_730_DUAL_MODE_TIMER	33
-# define OMAP_INT_730_DBB_RF_EN		34
-# define OMAP_INT_730_MPUIO_KEYPAD	35
-# define OMAP_INT_730_SHA1_MD5		36
-# define OMAP_INT_730_SPI_100K_2	37
-# define OMAP_INT_730_RNG_IDLE		38
-# define OMAP_INT_730_MPUIO		39
-# define OMAP_INT_730_LLPC_LCD_CTRL_OFF	40
-# define OMAP_INT_730_LLPC_OE_FALLING	41
-# define OMAP_INT_730_LLPC_OE_RISING	42
-# define OMAP_INT_730_LLPC_VSYNC	43
-# define OMAP_INT_730_WAKE_UP_REQ	46
-# define OMAP_INT_730_DMA_CH6		53
-# define OMAP_INT_730_DMA_CH7		54
-# define OMAP_INT_730_DMA_CH8		55
-# define OMAP_INT_730_DMA_CH9		56
-# define OMAP_INT_730_DMA_CH10		57
-# define OMAP_INT_730_DMA_CH11		58
-# define OMAP_INT_730_DMA_CH12		59
-# define OMAP_INT_730_DMA_CH13		60
-# define OMAP_INT_730_DMA_CH14		61
-# define OMAP_INT_730_DMA_CH15		62
-# define OMAP_INT_730_NAND		63
+#define OMAP_INT_730_HW_ERRORS         0
+#define OMAP_INT_730_NFIQ_PWR_FAIL     1
+#define OMAP_INT_730_CFCD              2
+#define OMAP_INT_730_CFIREQ            3
+#define OMAP_INT_730_I2C               4
+#define OMAP_INT_730_PCC               5
+#define OMAP_INT_730_MPU_EXT_NIRQ      6
+#define OMAP_INT_730_SPI_100K_1        7
+#define OMAP_INT_730_SYREN_SPI         8
+#define OMAP_INT_730_VLYNQ             9
+#define OMAP_INT_730_GPIO_BANK4        10
+#define OMAP_INT_730_McBSP1TX          11
+#define OMAP_INT_730_McBSP1RX          12
+#define OMAP_INT_730_McBSP1RX_OF       13
+#define OMAP_INT_730_UART_MODEM_IRDA_2 14
+#define OMAP_INT_730_UART_MODEM_1      15
+#define OMAP_INT_730_MCSI              16
+#define OMAP_INT_730_uWireTX           17
+#define OMAP_INT_730_uWireRX           18
+#define OMAP_INT_730_SMC_CD            19
+#define OMAP_INT_730_SMC_IREQ          20
+#define OMAP_INT_730_HDQ_1WIRE         21
+#define OMAP_INT_730_TIMER32K          22
+#define OMAP_INT_730_MMC_SDIO          23
+#define OMAP_INT_730_UPLD              24
+#define OMAP_INT_730_USB_HHC_1         27
+#define OMAP_INT_730_USB_HHC_2         28
+#define OMAP_INT_730_USB_GENI          29
+#define OMAP_INT_730_USB_OTG           30
+#define OMAP_INT_730_CAMERA_IF         31
+#define OMAP_INT_730_RNG               32
+#define OMAP_INT_730_DUAL_MODE_TIMER   33
+#define OMAP_INT_730_DBB_RF_EN         34
+#define OMAP_INT_730_MPUIO_KEYPAD      35
+#define OMAP_INT_730_SHA1_MD5          36
+#define OMAP_INT_730_SPI_100K_2        37
+#define OMAP_INT_730_RNG_IDLE          38
+#define OMAP_INT_730_MPUIO             39
+#define OMAP_INT_730_LLPC_LCD_CTRL_OFF 40
+#define OMAP_INT_730_LLPC_OE_FALLING   41
+#define OMAP_INT_730_LLPC_OE_RISING    42
+#define OMAP_INT_730_LLPC_VSYNC        43
+#define OMAP_INT_730_WAKE_UP_REQ       46
+#define OMAP_INT_730_DMA_CH6           53
+#define OMAP_INT_730_DMA_CH7           54
+#define OMAP_INT_730_DMA_CH8           55
+#define OMAP_INT_730_DMA_CH9           56
+#define OMAP_INT_730_DMA_CH10          57
+#define OMAP_INT_730_DMA_CH11          58
+#define OMAP_INT_730_DMA_CH12          59
+#define OMAP_INT_730_DMA_CH13          60
+#define OMAP_INT_730_DMA_CH14          61
+#define OMAP_INT_730_DMA_CH15          62
+#define OMAP_INT_730_NAND              63
 
 /* omap_dma.c */
 enum omap_dma_model {
@@ -353,9 +353,9 @@ struct dma_irq_map {
 enum omap_dma_port {
     emiff = 0,
     emifs,
-    imif,	/* omap16xx: ocp_t1 */
+    imif,   /* omap16xx: ocp_t1 */
     tipb,
-    local,	/* omap16xx: ocp_t2 */
+    local,  /* omap16xx: ocp_t2 */
     tipb_mpui,
     __omap_dma_port_last,
 };
@@ -418,65 +418,65 @@ struct omap_dma_lcd_channel_s {
  * DMA request numbers for OMAP1
  * See /usr/include/asm-arm/arch-omap/dma.h in Linux.
  */
-# define OMAP_DMA_NO_DEVICE		0
-# define OMAP_DMA_MCSI1_TX		1
-# define OMAP_DMA_MCSI1_RX		2
-# define OMAP_DMA_I2C_RX		3
-# define OMAP_DMA_I2C_TX		4
-# define OMAP_DMA_EXT_NDMA_REQ0		5
-# define OMAP_DMA_EXT_NDMA_REQ1		6
-# define OMAP_DMA_UWIRE_TX		7
-# define OMAP_DMA_MCBSP1_TX		8
-# define OMAP_DMA_MCBSP1_RX		9
-# define OMAP_DMA_MCBSP3_TX		10
-# define OMAP_DMA_MCBSP3_RX		11
-# define OMAP_DMA_UART1_TX		12
-# define OMAP_DMA_UART1_RX		13
-# define OMAP_DMA_UART2_TX		14
-# define OMAP_DMA_UART2_RX		15
-# define OMAP_DMA_MCBSP2_TX		16
-# define OMAP_DMA_MCBSP2_RX		17
-# define OMAP_DMA_UART3_TX		18
-# define OMAP_DMA_UART3_RX		19
-# define OMAP_DMA_CAMERA_IF_RX		20
-# define OMAP_DMA_MMC_TX		21
-# define OMAP_DMA_MMC_RX		22
-# define OMAP_DMA_NAND			23	/* Not in OMAP310 */
-# define OMAP_DMA_IRQ_LCD_LINE		24	/* Not in OMAP310 */
-# define OMAP_DMA_MEMORY_STICK		25	/* Not in OMAP310 */
-# define OMAP_DMA_USB_W2FC_RX0		26
-# define OMAP_DMA_USB_W2FC_RX1		27
-# define OMAP_DMA_USB_W2FC_RX2		28
-# define OMAP_DMA_USB_W2FC_TX0		29
-# define OMAP_DMA_USB_W2FC_TX1		30
-# define OMAP_DMA_USB_W2FC_TX2		31
+#define OMAP_DMA_NO_DEVICE         0
+#define OMAP_DMA_MCSI1_TX          1
+#define OMAP_DMA_MCSI1_RX          2
+#define OMAP_DMA_I2C_RX            3
+#define OMAP_DMA_I2C_TX            4
+#define OMAP_DMA_EXT_NDMA_REQ0     5
+#define OMAP_DMA_EXT_NDMA_REQ1     6
+#define OMAP_DMA_UWIRE_TX          7
+#define OMAP_DMA_MCBSP1_TX         8
+#define OMAP_DMA_MCBSP1_RX         9
+#define OMAP_DMA_MCBSP3_TX         10
+#define OMAP_DMA_MCBSP3_RX         11
+#define OMAP_DMA_UART1_TX          12
+#define OMAP_DMA_UART1_RX          13
+#define OMAP_DMA_UART2_TX          14
+#define OMAP_DMA_UART2_RX          15
+#define OMAP_DMA_MCBSP2_TX         16
+#define OMAP_DMA_MCBSP2_RX         17
+#define OMAP_DMA_UART3_TX          18
+#define OMAP_DMA_UART3_RX          19
+#define OMAP_DMA_CAMERA_IF_RX      20
+#define OMAP_DMA_MMC_TX            21
+#define OMAP_DMA_MMC_RX            22
+#define OMAP_DMA_NAND              23  /* Not in OMAP310 */
+#define OMAP_DMA_IRQ_LCD_LINE      24  /* Not in OMAP310 */
+#define OMAP_DMA_MEMORY_STICK      25  /* Not in OMAP310 */
+#define OMAP_DMA_USB_W2FC_RX0      26
+#define OMAP_DMA_USB_W2FC_RX1      27
+#define OMAP_DMA_USB_W2FC_RX2      28
+#define OMAP_DMA_USB_W2FC_TX0      29
+#define OMAP_DMA_USB_W2FC_TX1      30
+#define OMAP_DMA_USB_W2FC_TX2      31
 
 /* These are only for 1610 */
-# define OMAP_DMA_CRYPTO_DES_IN		32
-# define OMAP_DMA_SPI_TX		33
-# define OMAP_DMA_SPI_RX		34
-# define OMAP_DMA_CRYPTO_HASH		35
-# define OMAP_DMA_CCP_ATTN		36
-# define OMAP_DMA_CCP_FIFO_NOT_EMPTY	37
-# define OMAP_DMA_CMT_APE_TX_CHAN_0	38
-# define OMAP_DMA_CMT_APE_RV_CHAN_0	39
-# define OMAP_DMA_CMT_APE_TX_CHAN_1	40
-# define OMAP_DMA_CMT_APE_RV_CHAN_1	41
-# define OMAP_DMA_CMT_APE_TX_CHAN_2	42
-# define OMAP_DMA_CMT_APE_RV_CHAN_2	43
-# define OMAP_DMA_CMT_APE_TX_CHAN_3	44
-# define OMAP_DMA_CMT_APE_RV_CHAN_3	45
-# define OMAP_DMA_CMT_APE_TX_CHAN_4	46
-# define OMAP_DMA_CMT_APE_RV_CHAN_4	47
-# define OMAP_DMA_CMT_APE_TX_CHAN_5	48
-# define OMAP_DMA_CMT_APE_RV_CHAN_5	49
-# define OMAP_DMA_CMT_APE_TX_CHAN_6	50
-# define OMAP_DMA_CMT_APE_RV_CHAN_6	51
-# define OMAP_DMA_CMT_APE_TX_CHAN_7	52
-# define OMAP_DMA_CMT_APE_RV_CHAN_7	53
-# define OMAP_DMA_MMC2_TX		54
-# define OMAP_DMA_MMC2_RX		55
-# define OMAP_DMA_CRYPTO_DES_OUT	56
+#define OMAP_DMA_CRYPTO_DES_IN         32
+#define OMAP_DMA_SPI_TX                33
+#define OMAP_DMA_SPI_RX                34
+#define OMAP_DMA_CRYPTO_HASH           35
+#define OMAP_DMA_CCP_ATTN              36
+#define OMAP_DMA_CCP_FIFO_NOT_EMPTY    37
+#define OMAP_DMA_CMT_APE_TX_CHAN_0     38
+#define OMAP_DMA_CMT_APE_RV_CHAN_0     39
+#define OMAP_DMA_CMT_APE_TX_CHAN_1     40
+#define OMAP_DMA_CMT_APE_RV_CHAN_1     41
+#define OMAP_DMA_CMT_APE_TX_CHAN_2     42
+#define OMAP_DMA_CMT_APE_RV_CHAN_2     43
+#define OMAP_DMA_CMT_APE_TX_CHAN_3     44
+#define OMAP_DMA_CMT_APE_RV_CHAN_3     45
+#define OMAP_DMA_CMT_APE_TX_CHAN_4     46
+#define OMAP_DMA_CMT_APE_RV_CHAN_4     47
+#define OMAP_DMA_CMT_APE_TX_CHAN_5     48
+#define OMAP_DMA_CMT_APE_RV_CHAN_5     49
+#define OMAP_DMA_CMT_APE_TX_CHAN_6     50
+#define OMAP_DMA_CMT_APE_RV_CHAN_6     51
+#define OMAP_DMA_CMT_APE_TX_CHAN_7     52
+#define OMAP_DMA_CMT_APE_RV_CHAN_7     53
+#define OMAP_DMA_MMC2_TX               54
+#define OMAP_DMA_MMC2_RX               55
+#define OMAP_DMA_CRYPTO_DES_OUT        56
 
 struct omap_uart_s;
 struct omap_uart_s *omap_uart_init(hwaddr base,
@@ -542,14 +542,14 @@ void omap_mmc_set_clk(DeviceState *dev, omap_clk clk);
 /* omap_i2c.c */
 I2CBus *omap_i2c_bus(DeviceState *omap_i2c);
 
-# define cpu_is_omap310(cpu)		(cpu->mpu_model == omap310)
-# define cpu_is_omap1510(cpu)		(cpu->mpu_model == omap1510)
-# define cpu_is_omap1610(cpu)		(cpu->mpu_model == omap1610)
-# define cpu_is_omap1710(cpu)		(cpu->mpu_model == omap1710)
+#define cpu_is_omap310(cpu)        (cpu->mpu_model == omap310)
+#define cpu_is_omap1510(cpu)       (cpu->mpu_model == omap1510)
+#define cpu_is_omap1610(cpu)       (cpu->mpu_model == omap1610)
+#define cpu_is_omap1710(cpu)       (cpu->mpu_model == omap1710)
 
-# define cpu_is_omap15xx(cpu)		\
+#define cpu_is_omap15xx(cpu)       \
         (cpu_is_omap310(cpu) || cpu_is_omap1510(cpu))
-# define cpu_is_omap16xx(cpu)		\
+#define cpu_is_omap16xx(cpu)       \
         (cpu_is_omap1610(cpu) || cpu_is_omap1710(cpu))
 
 struct omap_mpu_state_s {
@@ -685,14 +685,14 @@ void omap_badwidth_write32(void *opaque, hwaddr addr,
 
 void omap_mpu_wakeup(void *opaque, int irq, int req);
 
-# define OMAP_BAD_REG(paddr)		\
+#define OMAP_BAD_REG(paddr)        \
         qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad register %#08"HWADDR_PRIx"\n", \
                       __func__, paddr)
-# define OMAP_RO_REG(paddr)		\
+#define OMAP_RO_REG(paddr)     \
         qemu_log_mask(LOG_GUEST_ERROR, "%s: Read-only register %#08" \
                                        HWADDR_PRIx "\n", \
                       __func__, paddr)
 
-# define OMAP_MPUI_REG_MASK		0x000007ff
+#define OMAP_MPUI_REG_MASK     0x000007ff
 
 #endif
diff --git a/include/hw/arm/sharpsl.h b/include/hw/arm/sharpsl.h
index e986b28c527..1e3992fcd00 100644
--- a/include/hw/arm/sharpsl.h
+++ b/include/hw/arm/sharpsl.h
@@ -11,7 +11,7 @@
 
 /* zaurus.c */
 
-#define SL_PXA_PARAM_BASE	0xa0000a00
+#define SL_PXA_PARAM_BASE   0xa0000a00
 void sl_bootparam_write(hwaddr ptr);
 
 #endif
diff --git a/include/hw/arm/soc_dma.h b/include/hw/arm/soc_dma.h
index e93a7499a80..bcdb91425a5 100644
--- a/include/hw/arm/soc_dma.h
+++ b/include/hw/arm/soc_dma.h
@@ -54,7 +54,7 @@ struct soc_dma_ch_s {
     int bytes;
     /* Initialised by the DMA module, call soc_dma_ch_update after writing.  */
     enum soc_dma_access_type type[2];
-    hwaddr vaddr[2];	/* Updated by .transfer_fn().  */
+    hwaddr vaddr[2];    /* Updated by .transfer_fn().  */
     /* Private */
     void *paddr[2];
     soc_dma_io_t io_fn[2];
@@ -70,7 +70,7 @@ struct soc_dma_ch_s {
 struct soc_dma_s {
     /* Following fields are set by the SoC DMA module and can be used
      * by anybody.  */
-    uint64_t drqbmp;	/* Is zeroed by soc_dma_reset() */
+    uint64_t drqbmp;    /* Is zeroed by soc_dma_reset() */
     qemu_irq *drq;
     void *opaque;
     int64_t freq;
diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index 91d7e3f04b5..74458fb7c69 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -144,7 +144,7 @@ static inline void omap_timer_update(struct omap_mpu_timer_s *timer)
     int64_t expires;
 
     if (timer->enable && timer->st && timer->rate) {
-        timer->val = timer->reset_val;	/* Should skip this on clk enable */
+        timer->val = timer->reset_val;  /* Should skip this on clk enable */
         expires = muldiv64((uint64_t) timer->val << (timer->ptv + 1),
                            NANOSECONDS_PER_SECOND, timer->rate);
 
@@ -212,13 +212,13 @@ static uint64_t omap_mpu_timer_read(void *opaque, hwaddr addr,
     }
 
     switch (addr) {
-    case 0x00:	/* CNTL_TIMER */
+    case 0x00:  /* CNTL_TIMER */
         return (s->enable << 5) | (s->ptv << 2) | (s->ar << 1) | s->st;
 
-    case 0x04:	/* LOAD_TIM */
+    case 0x04:  /* LOAD_TIM */
         break;
 
-    case 0x08:	/* READ_TIM */
+    case 0x08:  /* READ_TIM */
         return omap_timer_read(s);
     }
 
@@ -237,7 +237,7 @@ static void omap_mpu_timer_write(void *opaque, hwaddr addr,
     }
 
     switch (addr) {
-    case 0x00:	/* CNTL_TIMER */
+    case 0x00:  /* CNTL_TIMER */
         omap_timer_sync(s);
         s->enable = (value >> 5) & 1;
         s->ptv = (value >> 2) & 7;
@@ -246,11 +246,11 @@ static void omap_mpu_timer_write(void *opaque, hwaddr addr,
         omap_timer_update(s);
         return;
 
-    case 0x04:	/* LOAD_TIM */
+    case 0x04:  /* LOAD_TIM */
         s->reset_val = value;
         return;
 
-    case 0x08:	/* READ_TIM */
+    case 0x08:  /* READ_TIM */
         OMAP_RO_REG(addr);
         break;
 
@@ -318,14 +318,14 @@ static uint64_t omap_wd_timer_read(void *opaque, hwaddr addr,
     }
 
     switch (addr) {
-    case 0x00:	/* CNTL_TIMER */
+    case 0x00:  /* CNTL_TIMER */
         return (s->timer.ptv << 9) | (s->timer.ar << 8) |
                 (s->timer.st << 7) | (s->free << 1);
 
-    case 0x04:	/* READ_TIMER */
+    case 0x04:  /* READ_TIMER */
         return omap_timer_read(&s->timer);
 
-    case 0x08:	/* TIMER_MODE */
+    case 0x08:  /* TIMER_MODE */
         return s->mode << 15;
     }
 
@@ -344,7 +344,7 @@ static void omap_wd_timer_write(void *opaque, hwaddr addr,
     }
 
     switch (addr) {
-    case 0x00:	/* CNTL_TIMER */
+    case 0x00:  /* CNTL_TIMER */
         omap_timer_sync(&s->timer);
         s->timer.ptv = (value >> 9) & 7;
         s->timer.ar = (value >> 8) & 1;
@@ -353,11 +353,11 @@ static void omap_wd_timer_write(void *opaque, hwaddr addr,
         omap_timer_update(&s->timer);
         break;
 
-    case 0x04:	/* LOAD_TIMER */
+    case 0x04:  /* LOAD_TIMER */
         s->timer.reset_val = value & 0xffff;
         break;
 
-    case 0x08:	/* TIMER_MODE */
+    case 0x08:  /* TIMER_MODE */
         if (!s->mode && ((value >> 15) & 1))
             omap_clk_get(s->timer.clk);
         s->mode |= (value >> 15) & 1;
@@ -442,13 +442,13 @@ static uint64_t omap_os_timer_read(void *opaque, hwaddr addr,
     }
 
     switch (offset) {
-    case 0x00:	/* TVR */
+    case 0x00:  /* TVR */
         return s->timer.reset_val;
 
-    case 0x04:	/* TCR */
+    case 0x04:  /* TCR */
         return omap_timer_read(&s->timer);
 
-    case 0x08:	/* CR */
+    case 0x08:  /* CR */
         return (s->timer.ar << 3) | (s->timer.it_ena << 2) | s->timer.st;
 
     default:
@@ -470,15 +470,15 @@ static void omap_os_timer_write(void *opaque, hwaddr addr,
     }
 
     switch (offset) {
-    case 0x00:	/* TVR */
+    case 0x00:  /* TVR */
         s->timer.reset_val = value & 0x00ffffff;
         break;
 
-    case 0x04:	/* TCR */
+    case 0x04:  /* TCR */
         OMAP_RO_REG(addr);
         break;
 
-    case 0x08:	/* CR */
+    case 0x08:  /* CR */
         s->timer.ar = (value >> 3) & 1;
         s->timer.it_ena = (value >> 2) & 1;
         if (s->timer.st != (value & 1) || (value & 2)) {
@@ -543,34 +543,34 @@ static uint64_t omap_ulpd_pm_read(void *opaque, hwaddr addr,
     }
 
     switch (addr) {
-    case 0x14:	/* IT_STATUS */
+    case 0x14:  /* IT_STATUS */
         ret = s->ulpd_pm_regs[addr >> 2];
         s->ulpd_pm_regs[addr >> 2] = 0;
         qemu_irq_lower(qdev_get_gpio_in(s->ih[1], OMAP_INT_GAUGE_32K));
         return ret;
 
-    case 0x18:	/* Reserved */
-    case 0x1c:	/* Reserved */
-    case 0x20:	/* Reserved */
-    case 0x28:	/* Reserved */
-    case 0x2c:	/* Reserved */
+    case 0x18:  /* Reserved */
+    case 0x1c:  /* Reserved */
+    case 0x20:  /* Reserved */
+    case 0x28:  /* Reserved */
+    case 0x2c:  /* Reserved */
         OMAP_BAD_REG(addr);
         /* fall through */
-    case 0x00:	/* COUNTER_32_LSB */
-    case 0x04:	/* COUNTER_32_MSB */
-    case 0x08:	/* COUNTER_HIGH_FREQ_LSB */
-    case 0x0c:	/* COUNTER_HIGH_FREQ_MSB */
-    case 0x10:	/* GAUGING_CTRL */
-    case 0x24:	/* SETUP_ANALOG_CELL3_ULPD1 */
-    case 0x30:	/* CLOCK_CTRL */
-    case 0x34:	/* SOFT_REQ */
-    case 0x38:	/* COUNTER_32_FIQ */
-    case 0x3c:	/* DPLL_CTRL */
-    case 0x40:	/* STATUS_REQ */
+    case 0x00:  /* COUNTER_32_LSB */
+    case 0x04:  /* COUNTER_32_MSB */
+    case 0x08:  /* COUNTER_HIGH_FREQ_LSB */
+    case 0x0c:  /* COUNTER_HIGH_FREQ_MSB */
+    case 0x10:  /* GAUGING_CTRL */
+    case 0x24:  /* SETUP_ANALOG_CELL3_ULPD1 */
+    case 0x30:  /* CLOCK_CTRL */
+    case 0x34:  /* SOFT_REQ */
+    case 0x38:  /* COUNTER_32_FIQ */
+    case 0x3c:  /* DPLL_CTRL */
+    case 0x40:  /* STATUS_REQ */
         /* XXX: check clk::usecount state for every clock */
-    case 0x48:	/* LOCL_TIME */
-    case 0x4c:	/* APLL_CTRL */
-    case 0x50:	/* POWER_CTRL */
+    case 0x48:  /* LOCL_TIME */
+    case 0x4c:  /* APLL_CTRL */
+    case 0x50:  /* POWER_CTRL */
         return s->ulpd_pm_regs[addr >> 2];
     }
 
@@ -581,22 +581,22 @@ static uint64_t omap_ulpd_pm_read(void *opaque, hwaddr addr,
 static inline void omap_ulpd_clk_update(struct omap_mpu_state_s *s,
                 uint16_t diff, uint16_t value)
 {
-    if (diff & (1 << 4))				/* USB_MCLK_EN */
+    if (diff & (1 << 4))                /* USB_MCLK_EN */
         omap_clk_onoff(omap_findclk(s, "usb_clk0"), (value >> 4) & 1);
-    if (diff & (1 << 5))				/* DIS_USB_PVCI_CLK */
+    if (diff & (1 << 5))                /* DIS_USB_PVCI_CLK */
         omap_clk_onoff(omap_findclk(s, "usb_w2fc_ck"), (~value >> 5) & 1);
 }
 
 static inline void omap_ulpd_req_update(struct omap_mpu_state_s *s,
                 uint16_t diff, uint16_t value)
 {
-    if (diff & (1 << 0))				/* SOFT_DPLL_REQ */
+    if (diff & (1 << 0))                /* SOFT_DPLL_REQ */
         omap_clk_canidle(omap_findclk(s, "dpll4"), (~value >> 0) & 1);
-    if (diff & (1 << 1))				/* SOFT_COM_REQ */
+    if (diff & (1 << 1))                /* SOFT_COM_REQ */
         omap_clk_canidle(omap_findclk(s, "com_mclk_out"), (~value >> 1) & 1);
-    if (diff & (1 << 2))				/* SOFT_SDW_REQ */
+    if (diff & (1 << 2))                /* SOFT_SDW_REQ */
         omap_clk_canidle(omap_findclk(s, "bt_mclk_out"), (~value >> 2) & 1);
-    if (diff & (1 << 3))				/* SOFT_USB_REQ */
+    if (diff & (1 << 3))                /* SOFT_USB_REQ */
         omap_clk_canidle(omap_findclk(s, "usb_clk0"), (~value >> 3) & 1);
 }
 
@@ -615,16 +615,16 @@ static void omap_ulpd_pm_write(void *opaque, hwaddr addr,
     }
 
     switch (addr) {
-    case 0x00:	/* COUNTER_32_LSB */
-    case 0x04:	/* COUNTER_32_MSB */
-    case 0x08:	/* COUNTER_HIGH_FREQ_LSB */
-    case 0x0c:	/* COUNTER_HIGH_FREQ_MSB */
-    case 0x14:	/* IT_STATUS */
-    case 0x40:	/* STATUS_REQ */
+    case 0x00:  /* COUNTER_32_LSB */
+    case 0x04:  /* COUNTER_32_MSB */
+    case 0x08:  /* COUNTER_HIGH_FREQ_LSB */
+    case 0x0c:  /* COUNTER_HIGH_FREQ_MSB */
+    case 0x14:  /* IT_STATUS */
+    case 0x40:  /* STATUS_REQ */
         OMAP_RO_REG(addr);
         break;
 
-    case 0x10:	/* GAUGING_CTRL */
+    case 0x10:  /* GAUGING_CTRL */
         /* Bits 0 and 1 seem to be confused in the OMAP 310 TRM */
         if ((s->ulpd_pm_regs[addr >> 2] ^ value) & 1) {
             now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
@@ -638,50 +638,50 @@ static void omap_ulpd_pm_write(void *opaque, hwaddr addr,
                 ticks = muldiv64(now, 32768, NANOSECONDS_PER_SECOND);
                 s->ulpd_pm_regs[0x00 >> 2] = (ticks >>  0) & 0xffff;
                 s->ulpd_pm_regs[0x04 >> 2] = (ticks >> 16) & 0xffff;
-                if (ticks >> 32)	/* OVERFLOW_32K */
+                if (ticks >> 32)    /* OVERFLOW_32K */
                     s->ulpd_pm_regs[0x14 >> 2] |= 1 << 2;
 
                 /* High frequency ticks */
                 ticks = muldiv64(now, 12000000, NANOSECONDS_PER_SECOND);
                 s->ulpd_pm_regs[0x08 >> 2] = (ticks >>  0) & 0xffff;
                 s->ulpd_pm_regs[0x0c >> 2] = (ticks >> 16) & 0xffff;
-                if (ticks >> 32)	/* OVERFLOW_HI_FREQ */
+                if (ticks >> 32)    /* OVERFLOW_HI_FREQ */
                     s->ulpd_pm_regs[0x14 >> 2] |= 1 << 1;
 
-                s->ulpd_pm_regs[0x14 >> 2] |= 1 << 0;	/* IT_GAUGING */
+                s->ulpd_pm_regs[0x14 >> 2] |= 1 << 0;   /* IT_GAUGING */
                 qemu_irq_raise(qdev_get_gpio_in(s->ih[1], OMAP_INT_GAUGE_32K));
             }
         }
         s->ulpd_pm_regs[addr >> 2] = value;
         break;
 
-    case 0x18:	/* Reserved */
-    case 0x1c:	/* Reserved */
-    case 0x20:	/* Reserved */
-    case 0x28:	/* Reserved */
-    case 0x2c:	/* Reserved */
+    case 0x18:  /* Reserved */
+    case 0x1c:  /* Reserved */
+    case 0x20:  /* Reserved */
+    case 0x28:  /* Reserved */
+    case 0x2c:  /* Reserved */
         OMAP_BAD_REG(addr);
         /* fall through */
-    case 0x24:	/* SETUP_ANALOG_CELL3_ULPD1 */
-    case 0x38:	/* COUNTER_32_FIQ */
-    case 0x48:	/* LOCL_TIME */
-    case 0x50:	/* POWER_CTRL */
+    case 0x24:  /* SETUP_ANALOG_CELL3_ULPD1 */
+    case 0x38:  /* COUNTER_32_FIQ */
+    case 0x48:  /* LOCL_TIME */
+    case 0x50:  /* POWER_CTRL */
         s->ulpd_pm_regs[addr >> 2] = value;
         break;
 
-    case 0x30:	/* CLOCK_CTRL */
+    case 0x30:  /* CLOCK_CTRL */
         diff = s->ulpd_pm_regs[addr >> 2] ^ value;
         s->ulpd_pm_regs[addr >> 2] = value & 0x3f;
         omap_ulpd_clk_update(s, diff, value);
         break;
 
-    case 0x34:	/* SOFT_REQ */
+    case 0x34:  /* SOFT_REQ */
         diff = s->ulpd_pm_regs[addr >> 2] ^ value;
         s->ulpd_pm_regs[addr >> 2] = value & 0x1f;
         omap_ulpd_req_update(s, diff, value);
         break;
 
-    case 0x3c:	/* DPLL_CTRL */
+    case 0x3c:  /* DPLL_CTRL */
         /* XXX: OMAP310 TRM claims bit 3 is PLL_ENABLE, and bit 4 is
          * omitted altogether, probably a typo.  */
         /* This register has identical semantics with DPLL(1:3) control
@@ -689,11 +689,11 @@ static void omap_ulpd_pm_write(void *opaque, hwaddr addr,
         diff = s->ulpd_pm_regs[addr >> 2] & value;
         s->ulpd_pm_regs[addr >> 2] = value & 0x2fff;
         if (diff & (0x3ff << 2)) {
-            if (value & (1 << 4)) {			/* PLL_ENABLE */
-                div = ((value >> 5) & 3) + 1;		/* PLL_DIV */
-                mult = MIN((value >> 7) & 0x1f, 1);	/* PLL_MULT */
+            if (value & (1 << 4)) {         /* PLL_ENABLE */
+                div = ((value >> 5) & 3) + 1;       /* PLL_DIV */
+                mult = MIN((value >> 7) & 0x1f, 1); /* PLL_MULT */
             } else {
-                div = bypass_div[((value >> 2) & 3)];	/* BYPASS_DIV */
+                div = bypass_div[((value >> 2) & 3)];   /* BYPASS_DIV */
                 mult = 1;
             }
             omap_clk_setrate(omap_findclk(s, "dpll4"), div, mult);
@@ -708,10 +708,10 @@ static void omap_ulpd_pm_write(void *opaque, hwaddr addr,
         s->ulpd_pm_regs[addr >> 2] |= 2;
         break;
 
-    case 0x4c:	/* APLL_CTRL */
+    case 0x4c:  /* APLL_CTRL */
         diff = s->ulpd_pm_regs[addr >> 2] & value;
         s->ulpd_pm_regs[addr >> 2] = value & 0xf;
-        if (diff & (1 << 0))				/* APLL_NDPLL_SWITCH */
+        if (diff & (1 << 0))                /* APLL_NDPLL_SWITCH */
             omap_clk_reparent(omap_findclk(s, "ck_48m"), omap_findclk(s,
                                     (value & (1 << 0)) ? "apll" : "dpll4"));
         break;
@@ -775,43 +775,43 @@ static uint64_t omap_pin_cfg_read(void *opaque, hwaddr addr,
     }
 
     switch (addr) {
-    case 0x00:	/* FUNC_MUX_CTRL_0 */
-    case 0x04:	/* FUNC_MUX_CTRL_1 */
-    case 0x08:	/* FUNC_MUX_CTRL_2 */
+    case 0x00:  /* FUNC_MUX_CTRL_0 */
+    case 0x04:  /* FUNC_MUX_CTRL_1 */
+    case 0x08:  /* FUNC_MUX_CTRL_2 */
         return s->func_mux_ctrl[addr >> 2];
 
-    case 0x0c:	/* COMP_MODE_CTRL_0 */
+    case 0x0c:  /* COMP_MODE_CTRL_0 */
         return s->comp_mode_ctrl[0];
 
-    case 0x10:	/* FUNC_MUX_CTRL_3 */
-    case 0x14:	/* FUNC_MUX_CTRL_4 */
-    case 0x18:	/* FUNC_MUX_CTRL_5 */
-    case 0x1c:	/* FUNC_MUX_CTRL_6 */
-    case 0x20:	/* FUNC_MUX_CTRL_7 */
-    case 0x24:	/* FUNC_MUX_CTRL_8 */
-    case 0x28:	/* FUNC_MUX_CTRL_9 */
-    case 0x2c:	/* FUNC_MUX_CTRL_A */
-    case 0x30:	/* FUNC_MUX_CTRL_B */
-    case 0x34:	/* FUNC_MUX_CTRL_C */
-    case 0x38:	/* FUNC_MUX_CTRL_D */
+    case 0x10:  /* FUNC_MUX_CTRL_3 */
+    case 0x14:  /* FUNC_MUX_CTRL_4 */
+    case 0x18:  /* FUNC_MUX_CTRL_5 */
+    case 0x1c:  /* FUNC_MUX_CTRL_6 */
+    case 0x20:  /* FUNC_MUX_CTRL_7 */
+    case 0x24:  /* FUNC_MUX_CTRL_8 */
+    case 0x28:  /* FUNC_MUX_CTRL_9 */
+    case 0x2c:  /* FUNC_MUX_CTRL_A */
+    case 0x30:  /* FUNC_MUX_CTRL_B */
+    case 0x34:  /* FUNC_MUX_CTRL_C */
+    case 0x38:  /* FUNC_MUX_CTRL_D */
         return s->func_mux_ctrl[(addr >> 2) - 1];
 
-    case 0x40:	/* PULL_DWN_CTRL_0 */
-    case 0x44:	/* PULL_DWN_CTRL_1 */
-    case 0x48:	/* PULL_DWN_CTRL_2 */
-    case 0x4c:	/* PULL_DWN_CTRL_3 */
+    case 0x40:  /* PULL_DWN_CTRL_0 */
+    case 0x44:  /* PULL_DWN_CTRL_1 */
+    case 0x48:  /* PULL_DWN_CTRL_2 */
+    case 0x4c:  /* PULL_DWN_CTRL_3 */
         return s->pull_dwn_ctrl[(addr & 0xf) >> 2];
 
-    case 0x50:	/* GATE_INH_CTRL_0 */
+    case 0x50:  /* GATE_INH_CTRL_0 */
         return s->gate_inh_ctrl[0];
 
-    case 0x60:	/* VOLTAGE_CTRL_0 */
+    case 0x60:  /* VOLTAGE_CTRL_0 */
         return s->voltage_ctrl[0];
 
-    case 0x70:	/* TEST_DBG_CTRL_0 */
+    case 0x70:  /* TEST_DBG_CTRL_0 */
         return s->test_dbg_ctrl[0];
 
-    case 0x80:	/* MOD_CONF_CTRL_0 */
+    case 0x80:  /* MOD_CONF_CTRL_0 */
         return s->mod_conf_ctrl[0];
     }
 
@@ -823,10 +823,10 @@ static inline void omap_pin_funcmux0_update(struct omap_mpu_state_s *s,
                 uint32_t diff, uint32_t value)
 {
     if (s->compat1509) {
-        if (diff & (1 << 9))			/* BLUETOOTH */
+        if (diff & (1 << 9))            /* BLUETOOTH */
             omap_clk_onoff(omap_findclk(s, "bt_mclk_out"),
                             (~value >> 9) & 1);
-        if (diff & (1 << 7))			/* USB.CLKO */
+        if (diff & (1 << 7))            /* USB.CLKO */
             omap_clk_onoff(omap_findclk(s, "usb.clko"),
                             (value >> 7) & 1);
     }
@@ -856,23 +856,23 @@ static inline void omap_pin_modconf1_update(struct omap_mpu_state_s *s,
                           omap_findclk(s, ((value >> 31) & 1) ?
                                        "ck_48m" : "armper_ck"));
     }
-    if (diff & (1 << 30))			/* CONF_MOD_UART2_CLK_MODE_R */
+    if (diff & (1 << 30))           /* CONF_MOD_UART2_CLK_MODE_R */
          omap_clk_reparent(omap_findclk(s, "uart2_ck"),
                          omap_findclk(s, ((value >> 30) & 1) ?
                                  "ck_48m" : "armper_ck"));
-    if (diff & (1 << 29))			/* CONF_MOD_UART1_CLK_MODE_R */
+    if (diff & (1 << 29))           /* CONF_MOD_UART1_CLK_MODE_R */
          omap_clk_reparent(omap_findclk(s, "uart1_ck"),
                          omap_findclk(s, ((value >> 29) & 1) ?
                                  "ck_48m" : "armper_ck"));
-    if (diff & (1 << 23))			/* CONF_MOD_MMC_SD_CLK_REQ_R */
+    if (diff & (1 << 23))           /* CONF_MOD_MMC_SD_CLK_REQ_R */
          omap_clk_reparent(omap_findclk(s, "mmc_ck"),
                          omap_findclk(s, ((value >> 23) & 1) ?
                                  "ck_48m" : "armper_ck"));
-    if (diff & (1 << 12))			/* CONF_MOD_COM_MCLK_12_48_S */
+    if (diff & (1 << 12))           /* CONF_MOD_COM_MCLK_12_48_S */
          omap_clk_reparent(omap_findclk(s, "com_mclk_out"),
                          omap_findclk(s, ((value >> 12) & 1) ?
                                  "ck_48m" : "armper_ck"));
-    if (diff & (1 << 9))			/* CONF_MOD_USB_HOST_HHC_UHO */
+    if (diff & (1 << 9))            /* CONF_MOD_USB_HOST_HHC_UHO */
          omap_clk_onoff(omap_findclk(s, "usb_hhc_ck"), (value >> 9) & 1);
 }
 
@@ -888,63 +888,63 @@ static void omap_pin_cfg_write(void *opaque, hwaddr addr,
     }
 
     switch (addr) {
-    case 0x00:	/* FUNC_MUX_CTRL_0 */
+    case 0x00:  /* FUNC_MUX_CTRL_0 */
         diff = s->func_mux_ctrl[addr >> 2] ^ value;
         s->func_mux_ctrl[addr >> 2] = value;
         omap_pin_funcmux0_update(s, diff, value);
         return;
 
-    case 0x04:	/* FUNC_MUX_CTRL_1 */
+    case 0x04:  /* FUNC_MUX_CTRL_1 */
         diff = s->func_mux_ctrl[addr >> 2] ^ value;
         s->func_mux_ctrl[addr >> 2] = value;
         omap_pin_funcmux1_update(s, diff, value);
         return;
 
-    case 0x08:	/* FUNC_MUX_CTRL_2 */
+    case 0x08:  /* FUNC_MUX_CTRL_2 */
         s->func_mux_ctrl[addr >> 2] = value;
         return;
 
-    case 0x0c:	/* COMP_MODE_CTRL_0 */
+    case 0x0c:  /* COMP_MODE_CTRL_0 */
         s->comp_mode_ctrl[0] = value;
         s->compat1509 = (value != 0x0000eaef);
         omap_pin_funcmux0_update(s, ~0, s->func_mux_ctrl[0]);
         omap_pin_funcmux1_update(s, ~0, s->func_mux_ctrl[1]);
         return;
 
-    case 0x10:	/* FUNC_MUX_CTRL_3 */
-    case 0x14:	/* FUNC_MUX_CTRL_4 */
-    case 0x18:	/* FUNC_MUX_CTRL_5 */
-    case 0x1c:	/* FUNC_MUX_CTRL_6 */
-    case 0x20:	/* FUNC_MUX_CTRL_7 */
-    case 0x24:	/* FUNC_MUX_CTRL_8 */
-    case 0x28:	/* FUNC_MUX_CTRL_9 */
-    case 0x2c:	/* FUNC_MUX_CTRL_A */
-    case 0x30:	/* FUNC_MUX_CTRL_B */
-    case 0x34:	/* FUNC_MUX_CTRL_C */
-    case 0x38:	/* FUNC_MUX_CTRL_D */
+    case 0x10:  /* FUNC_MUX_CTRL_3 */
+    case 0x14:  /* FUNC_MUX_CTRL_4 */
+    case 0x18:  /* FUNC_MUX_CTRL_5 */
+    case 0x1c:  /* FUNC_MUX_CTRL_6 */
+    case 0x20:  /* FUNC_MUX_CTRL_7 */
+    case 0x24:  /* FUNC_MUX_CTRL_8 */
+    case 0x28:  /* FUNC_MUX_CTRL_9 */
+    case 0x2c:  /* FUNC_MUX_CTRL_A */
+    case 0x30:  /* FUNC_MUX_CTRL_B */
+    case 0x34:  /* FUNC_MUX_CTRL_C */
+    case 0x38:  /* FUNC_MUX_CTRL_D */
         s->func_mux_ctrl[(addr >> 2) - 1] = value;
         return;
 
-    case 0x40:	/* PULL_DWN_CTRL_0 */
-    case 0x44:	/* PULL_DWN_CTRL_1 */
-    case 0x48:	/* PULL_DWN_CTRL_2 */
-    case 0x4c:	/* PULL_DWN_CTRL_3 */
+    case 0x40:  /* PULL_DWN_CTRL_0 */
+    case 0x44:  /* PULL_DWN_CTRL_1 */
+    case 0x48:  /* PULL_DWN_CTRL_2 */
+    case 0x4c:  /* PULL_DWN_CTRL_3 */
         s->pull_dwn_ctrl[(addr & 0xf) >> 2] = value;
         return;
 
-    case 0x50:	/* GATE_INH_CTRL_0 */
+    case 0x50:  /* GATE_INH_CTRL_0 */
         s->gate_inh_ctrl[0] = value;
         return;
 
-    case 0x60:	/* VOLTAGE_CTRL_0 */
+    case 0x60:  /* VOLTAGE_CTRL_0 */
         s->voltage_ctrl[0] = value;
         return;
 
-    case 0x70:	/* TEST_DBG_CTRL_0 */
+    case 0x70:  /* TEST_DBG_CTRL_0 */
         s->test_dbg_ctrl[0] = value;
         return;
 
-    case 0x80:	/* MOD_CONF_CTRL_0 */
+    case 0x80:  /* MOD_CONF_CTRL_0 */
         diff = s->mod_conf_ctrl[0] ^ value;
         s->mod_conf_ctrl[0] = value;
         omap_pin_modconf1_update(s, diff, value);
@@ -998,17 +998,17 @@ static uint64_t omap_id_read(void *opaque, hwaddr addr,
     }
 
     switch (addr) {
-    case 0xfffe1800:	/* DIE_ID_LSB */
+    case 0xfffe1800:    /* DIE_ID_LSB */
         return 0xc9581f0e;
-    case 0xfffe1804:	/* DIE_ID_MSB */
+    case 0xfffe1804:    /* DIE_ID_MSB */
         return 0xa8858bfa;
 
-    case 0xfffe2000:	/* PRODUCT_ID_LSB */
+    case 0xfffe2000:    /* PRODUCT_ID_LSB */
         return 0x00aaaafc;
-    case 0xfffe2004:	/* PRODUCT_ID_MSB */
+    case 0xfffe2004:    /* PRODUCT_ID_MSB */
         return 0xcafeb574;
 
-    case 0xfffed400:	/* JTAG_ID_LSB */
+    case 0xfffed400:    /* JTAG_ID_LSB */
         switch (s->mpu_model) {
         case omap310:
             return 0x03310315;
@@ -1019,7 +1019,7 @@ static uint64_t omap_id_read(void *opaque, hwaddr addr,
         }
         break;
 
-    case 0xfffed404:	/* JTAG_ID_MSB */
+    case 0xfffed404:    /* JTAG_ID_MSB */
         switch (s->mpu_model) {
         case omap310:
             return 0xfb57402f;
@@ -1080,22 +1080,22 @@ static uint64_t omap_mpui_read(void *opaque, hwaddr addr,
     }
 
     switch (addr) {
-    case 0x00:	/* CTRL */
+    case 0x00:  /* CTRL */
         return s->mpui_ctrl;
-    case 0x04:	/* DEBUG_ADDR */
+    case 0x04:  /* DEBUG_ADDR */
         return 0x01ffffff;
-    case 0x08:	/* DEBUG_DATA */
+    case 0x08:  /* DEBUG_DATA */
         return 0xffffffff;
-    case 0x0c:	/* DEBUG_FLAG */
+    case 0x0c:  /* DEBUG_FLAG */
         return 0x00000800;
-    case 0x10:	/* STATUS */
+    case 0x10:  /* STATUS */
         return 0x00000000;
 
     /* Not in OMAP310 */
-    case 0x14:	/* DSP_STATUS */
-    case 0x18:	/* DSP_BOOT_CONFIG */
+    case 0x14:  /* DSP_STATUS */
+    case 0x18:  /* DSP_BOOT_CONFIG */
         return 0x00000000;
-    case 0x1c:	/* DSP_MPUI_CONFIG */
+    case 0x1c:  /* DSP_MPUI_CONFIG */
         return 0x0000ffff;
     }
 
@@ -1114,20 +1114,20 @@ static void omap_mpui_write(void *opaque, hwaddr addr,
     }
 
     switch (addr) {
-    case 0x00:	/* CTRL */
+    case 0x00:  /* CTRL */
         s->mpui_ctrl = value & 0x007fffff;
         break;
 
-    case 0x04:	/* DEBUG_ADDR */
-    case 0x08:	/* DEBUG_DATA */
-    case 0x0c:	/* DEBUG_FLAG */
-    case 0x10:	/* STATUS */
+    case 0x04:  /* DEBUG_ADDR */
+    case 0x08:  /* DEBUG_DATA */
+    case 0x0c:  /* DEBUG_FLAG */
+    case 0x10:  /* STATUS */
     /* Not in OMAP310 */
-    case 0x14:	/* DSP_STATUS */
+    case 0x14:  /* DSP_STATUS */
         OMAP_RO_REG(addr);
         break;
-    case 0x18:	/* DSP_BOOT_CONFIG */
-    case 0x1c:	/* DSP_MPUI_CONFIG */
+    case 0x18:  /* DSP_BOOT_CONFIG */
+    case 0x1c:  /* DSP_MPUI_CONFIG */
         break;
 
     default:
@@ -1178,19 +1178,19 @@ static uint64_t omap_tipb_bridge_read(void *opaque, hwaddr addr,
     }
 
     switch (addr) {
-    case 0x00:	/* TIPB_CNTL */
+    case 0x00:  /* TIPB_CNTL */
         return s->control;
-    case 0x04:	/* TIPB_BUS_ALLOC */
+    case 0x04:  /* TIPB_BUS_ALLOC */
         return s->alloc;
-    case 0x08:	/* MPU_TIPB_CNTL */
+    case 0x08:  /* MPU_TIPB_CNTL */
         return s->buffer;
-    case 0x0c:	/* ENHANCED_TIPB_CNTL */
+    case 0x0c:  /* ENHANCED_TIPB_CNTL */
         return s->enh_control;
-    case 0x10:	/* ADDRESS_DBG */
-    case 0x14:	/* DATA_DEBUG_LOW */
-    case 0x18:	/* DATA_DEBUG_HIGH */
+    case 0x10:  /* ADDRESS_DBG */
+    case 0x14:  /* DATA_DEBUG_LOW */
+    case 0x18:  /* DATA_DEBUG_HIGH */
         return 0xffff;
-    case 0x1c:	/* DEBUG_CNTR_SIG */
+    case 0x1c:  /* DEBUG_CNTR_SIG */
         return 0x00f8;
     }
 
@@ -1209,27 +1209,27 @@ static void omap_tipb_bridge_write(void *opaque, hwaddr addr,
     }
 
     switch (addr) {
-    case 0x00:	/* TIPB_CNTL */
+    case 0x00:  /* TIPB_CNTL */
         s->control = value & 0xffff;
         break;
 
-    case 0x04:	/* TIPB_BUS_ALLOC */
+    case 0x04:  /* TIPB_BUS_ALLOC */
         s->alloc = value & 0x003f;
         break;
 
-    case 0x08:	/* MPU_TIPB_CNTL */
+    case 0x08:  /* MPU_TIPB_CNTL */
         s->buffer = value & 0x0003;
         break;
 
-    case 0x0c:	/* ENHANCED_TIPB_CNTL */
+    case 0x0c:  /* ENHANCED_TIPB_CNTL */
         s->width_intr = !(value & 2);
         s->enh_control = value & 0x000f;
         break;
 
-    case 0x10:	/* ADDRESS_DBG */
-    case 0x14:	/* DATA_DEBUG_LOW */
-    case 0x18:	/* DATA_DEBUG_HIGH */
-    case 0x1c:	/* DEBUG_CNTR_SIG */
+    case 0x10:  /* ADDRESS_DBG */
+    case 0x14:  /* DATA_DEBUG_LOW */
+    case 0x18:  /* DATA_DEBUG_HIGH */
+    case 0x1c:  /* DEBUG_CNTR_SIG */
         OMAP_RO_REG(addr);
         break;
 
@@ -1280,23 +1280,23 @@ static uint64_t omap_tcmi_read(void *opaque, hwaddr addr,
     }
 
     switch (addr) {
-    case 0x00:	/* IMIF_PRIO */
-    case 0x04:	/* EMIFS_PRIO */
-    case 0x08:	/* EMIFF_PRIO */
-    case 0x0c:	/* EMIFS_CONFIG */
-    case 0x10:	/* EMIFS_CS0_CONFIG */
-    case 0x14:	/* EMIFS_CS1_CONFIG */
-    case 0x18:	/* EMIFS_CS2_CONFIG */
-    case 0x1c:	/* EMIFS_CS3_CONFIG */
-    case 0x24:	/* EMIFF_MRS */
-    case 0x28:	/* TIMEOUT1 */
-    case 0x2c:	/* TIMEOUT2 */
-    case 0x30:	/* TIMEOUT3 */
-    case 0x3c:	/* EMIFF_SDRAM_CONFIG_2 */
-    case 0x40:	/* EMIFS_CFG_DYN_WAIT */
+    case 0x00:  /* IMIF_PRIO */
+    case 0x04:  /* EMIFS_PRIO */
+    case 0x08:  /* EMIFF_PRIO */
+    case 0x0c:  /* EMIFS_CONFIG */
+    case 0x10:  /* EMIFS_CS0_CONFIG */
+    case 0x14:  /* EMIFS_CS1_CONFIG */
+    case 0x18:  /* EMIFS_CS2_CONFIG */
+    case 0x1c:  /* EMIFS_CS3_CONFIG */
+    case 0x24:  /* EMIFF_MRS */
+    case 0x28:  /* TIMEOUT1 */
+    case 0x2c:  /* TIMEOUT2 */
+    case 0x30:  /* TIMEOUT3 */
+    case 0x3c:  /* EMIFF_SDRAM_CONFIG_2 */
+    case 0x40:  /* EMIFS_CFG_DYN_WAIT */
         return s->tcmi_regs[addr >> 2];
 
-    case 0x20:	/* EMIFF_SDRAM_CONFIG */
+    case 0x20:  /* EMIFF_SDRAM_CONFIG */
         ret = s->tcmi_regs[addr >> 2];
         s->tcmi_regs[addr >> 2] &= ~1; /* XXX: Clear SLRF on SDRAM access */
         /* XXX: We can try using the VGA_DIRTY flag for this */
@@ -1318,23 +1318,23 @@ static void omap_tcmi_write(void *opaque, hwaddr addr,
     }
 
     switch (addr) {
-    case 0x00:	/* IMIF_PRIO */
-    case 0x04:	/* EMIFS_PRIO */
-    case 0x08:	/* EMIFF_PRIO */
-    case 0x10:	/* EMIFS_CS0_CONFIG */
-    case 0x14:	/* EMIFS_CS1_CONFIG */
-    case 0x18:	/* EMIFS_CS2_CONFIG */
-    case 0x1c:	/* EMIFS_CS3_CONFIG */
-    case 0x20:	/* EMIFF_SDRAM_CONFIG */
-    case 0x24:	/* EMIFF_MRS */
-    case 0x28:	/* TIMEOUT1 */
-    case 0x2c:	/* TIMEOUT2 */
-    case 0x30:	/* TIMEOUT3 */
-    case 0x3c:	/* EMIFF_SDRAM_CONFIG_2 */
-    case 0x40:	/* EMIFS_CFG_DYN_WAIT */
+    case 0x00:  /* IMIF_PRIO */
+    case 0x04:  /* EMIFS_PRIO */
+    case 0x08:  /* EMIFF_PRIO */
+    case 0x10:  /* EMIFS_CS0_CONFIG */
+    case 0x14:  /* EMIFS_CS1_CONFIG */
+    case 0x18:  /* EMIFS_CS2_CONFIG */
+    case 0x1c:  /* EMIFS_CS3_CONFIG */
+    case 0x20:  /* EMIFF_SDRAM_CONFIG */
+    case 0x24:  /* EMIFF_MRS */
+    case 0x28:  /* TIMEOUT1 */
+    case 0x2c:  /* TIMEOUT2 */
+    case 0x30:  /* TIMEOUT3 */
+    case 0x3c:  /* EMIFF_SDRAM_CONFIG_2 */
+    case 0x40:  /* EMIFS_CFG_DYN_WAIT */
         s->tcmi_regs[addr >> 2] = value;
         break;
-    case 0x0c:	/* EMIFS_CONFIG */
+    case 0x0c:  /* EMIFS_CONFIG */
         s->tcmi_regs[addr >> 2] = (value & 0xf) | (1 << 4);
         break;
 
@@ -1393,7 +1393,7 @@ static uint64_t omap_dpll_read(void *opaque, hwaddr addr,
         return omap_badwidth_read16(opaque, addr);
     }
 
-    if (addr == 0x00)	/* CTL_REG */
+    if (addr == 0x00)   /* CTL_REG */
         return s->mode;
 
     OMAP_BAD_REG(addr);
@@ -1413,16 +1413,16 @@ static void omap_dpll_write(void *opaque, hwaddr addr,
         return;
     }
 
-    if (addr == 0x00) {	/* CTL_REG */
+    if (addr == 0x00) { /* CTL_REG */
         /* See omap_ulpd_pm_write() too */
         diff = s->mode & value;
         s->mode = value & 0x2fff;
         if (diff & (0x3ff << 2)) {
-            if (value & (1 << 4)) {			/* PLL_ENABLE */
-                div = ((value >> 5) & 3) + 1;		/* PLL_DIV */
-                mult = MIN((value >> 7) & 0x1f, 1);	/* PLL_MULT */
+            if (value & (1 << 4)) {         /* PLL_ENABLE */
+                div = ((value >> 5) & 3) + 1;       /* PLL_DIV */
+                mult = MIN((value >> 7) & 0x1f, 1); /* PLL_MULT */
             } else {
-                div = bypass_div[((value >> 2) & 3)];	/* BYPASS_DIV */
+                div = bypass_div[((value >> 2) & 3)];   /* BYPASS_DIV */
                 mult = 1;
             }
             omap_clk_setrate(s->dpll, div, mult);
@@ -1474,31 +1474,31 @@ static uint64_t omap_clkm_read(void *opaque, hwaddr addr,
     }
 
     switch (addr) {
-    case 0x00:	/* ARM_CKCTL */
+    case 0x00:  /* ARM_CKCTL */
         return s->clkm.arm_ckctl;
 
-    case 0x04:	/* ARM_IDLECT1 */
+    case 0x04:  /* ARM_IDLECT1 */
         return s->clkm.arm_idlect1;
 
-    case 0x08:	/* ARM_IDLECT2 */
+    case 0x08:  /* ARM_IDLECT2 */
         return s->clkm.arm_idlect2;
 
-    case 0x0c:	/* ARM_EWUPCT */
+    case 0x0c:  /* ARM_EWUPCT */
         return s->clkm.arm_ewupct;
 
-    case 0x10:	/* ARM_RSTCT1 */
+    case 0x10:  /* ARM_RSTCT1 */
         return s->clkm.arm_rstct1;
 
-    case 0x14:	/* ARM_RSTCT2 */
+    case 0x14:  /* ARM_RSTCT2 */
         return s->clkm.arm_rstct2;
 
-    case 0x18:	/* ARM_SYSST */
+    case 0x18:  /* ARM_SYSST */
         return (s->clkm.clocking_scheme << 11) | s->clkm.cold_start;
 
-    case 0x1c:	/* ARM_CKOUT1 */
+    case 0x1c:  /* ARM_CKOUT1 */
         return s->clkm.arm_ckout1;
 
-    case 0x20:	/* ARM_CKOUT2 */
+    case 0x20:  /* ARM_CKOUT2 */
         break;
     }
 
@@ -1511,7 +1511,7 @@ static inline void omap_clkm_ckctl_update(struct omap_mpu_state_s *s,
 {
     omap_clk clk;
 
-    if (diff & (1 << 14)) {				/* ARM_INTHCK_SEL */
+    if (diff & (1 << 14)) {             /* ARM_INTHCK_SEL */
         if (value & (1 << 14))
             /* Reserved */;
         else {
@@ -1519,7 +1519,7 @@ static inline void omap_clkm_ckctl_update(struct omap_mpu_state_s *s,
             omap_clk_reparent(clk, omap_findclk(s, "tc_ck"));
         }
     }
-    if (diff & (1 << 12)) {				/* ARM_TIMXO */
+    if (diff & (1 << 12)) {             /* ARM_TIMXO */
         clk = omap_findclk(s, "armtim_ck");
         if (value & (1 << 12))
             omap_clk_reparent(clk, omap_findclk(s, "clkin"));
@@ -1527,27 +1527,27 @@ static inline void omap_clkm_ckctl_update(struct omap_mpu_state_s *s,
             omap_clk_reparent(clk, omap_findclk(s, "ck_gen1"));
     }
     /* XXX: en_dspck */
-    if (diff & (3 << 10)) {				/* DSPMMUDIV */
+    if (diff & (3 << 10)) {             /* DSPMMUDIV */
         clk = omap_findclk(s, "dspmmu_ck");
         omap_clk_setrate(clk, 1 << ((value >> 10) & 3), 1);
     }
-    if (diff & (3 << 8)) {				/* TCDIV */
+    if (diff & (3 << 8)) {              /* TCDIV */
         clk = omap_findclk(s, "tc_ck");
         omap_clk_setrate(clk, 1 << ((value >> 8) & 3), 1);
     }
-    if (diff & (3 << 6)) {				/* DSPDIV */
+    if (diff & (3 << 6)) {              /* DSPDIV */
         clk = omap_findclk(s, "dsp_ck");
         omap_clk_setrate(clk, 1 << ((value >> 6) & 3), 1);
     }
-    if (diff & (3 << 4)) {				/* ARMDIV */
+    if (diff & (3 << 4)) {              /* ARMDIV */
         clk = omap_findclk(s, "arm_ck");
         omap_clk_setrate(clk, 1 << ((value >> 4) & 3), 1);
     }
-    if (diff & (3 << 2)) {				/* LCDDIV */
+    if (diff & (3 << 2)) {              /* LCDDIV */
         clk = omap_findclk(s, "lcd_ck");
         omap_clk_setrate(clk, 1 << ((value >> 2) & 3), 1);
     }
-    if (diff & (3 << 0)) {				/* PERDIV */
+    if (diff & (3 << 0)) {              /* PERDIV */
         clk = omap_findclk(s, "armper_ck");
         omap_clk_setrate(clk, 1 << ((value >> 0) & 3), 1);
     }
@@ -1566,25 +1566,25 @@ static inline void omap_clkm_idlect1_update(struct omap_mpu_state_s *s,
         qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
     }
 
-#define SET_CANIDLE(clock, bit)				\
-    if (diff & (1 << bit)) {				\
-        clk = omap_findclk(s, clock);			\
-        omap_clk_canidle(clk, (value >> bit) & 1);	\
+#define SET_CANIDLE(clock, bit)                     \
+    if (diff & (1 << bit)) {                        \
+        clk = omap_findclk(s, clock);               \
+        omap_clk_canidle(clk, (value >> bit) & 1);  \
     }
-    SET_CANIDLE("mpuwd_ck", 0)				/* IDLWDT_ARM */
-    SET_CANIDLE("armxor_ck", 1)				/* IDLXORP_ARM */
-    SET_CANIDLE("mpuper_ck", 2)				/* IDLPER_ARM */
-    SET_CANIDLE("lcd_ck", 3)				/* IDLLCD_ARM */
-    SET_CANIDLE("lb_ck", 4)				/* IDLLB_ARM */
-    SET_CANIDLE("hsab_ck", 5)				/* IDLHSAB_ARM */
-    SET_CANIDLE("tipb_ck", 6)				/* IDLIF_ARM */
-    SET_CANIDLE("dma_ck", 6)				/* IDLIF_ARM */
-    SET_CANIDLE("tc_ck", 6)				/* IDLIF_ARM */
-    SET_CANIDLE("dpll1", 7)				/* IDLDPLL_ARM */
-    SET_CANIDLE("dpll2", 7)				/* IDLDPLL_ARM */
-    SET_CANIDLE("dpll3", 7)				/* IDLDPLL_ARM */
-    SET_CANIDLE("mpui_ck", 8)				/* IDLAPI_ARM */
-    SET_CANIDLE("armtim_ck", 9)				/* IDLTIM_ARM */
+    SET_CANIDLE("mpuwd_ck", 0)          /* IDLWDT_ARM */
+    SET_CANIDLE("armxor_ck", 1)         /* IDLXORP_ARM */
+    SET_CANIDLE("mpuper_ck", 2)         /* IDLPER_ARM */
+    SET_CANIDLE("lcd_ck", 3)            /* IDLLCD_ARM */
+    SET_CANIDLE("lb_ck", 4)             /* IDLLB_ARM */
+    SET_CANIDLE("hsab_ck", 5)           /* IDLHSAB_ARM */
+    SET_CANIDLE("tipb_ck", 6)           /* IDLIF_ARM */
+    SET_CANIDLE("dma_ck", 6)            /* IDLIF_ARM */
+    SET_CANIDLE("tc_ck", 6)             /* IDLIF_ARM */
+    SET_CANIDLE("dpll1", 7)             /* IDLDPLL_ARM */
+    SET_CANIDLE("dpll2", 7)             /* IDLDPLL_ARM */
+    SET_CANIDLE("dpll3", 7)             /* IDLDPLL_ARM */
+    SET_CANIDLE("mpui_ck", 8)           /* IDLAPI_ARM */
+    SET_CANIDLE("armtim_ck", 9)         /* IDLTIM_ARM */
 }
 
 static inline void omap_clkm_idlect2_update(struct omap_mpu_state_s *s,
@@ -1592,22 +1592,22 @@ static inline void omap_clkm_idlect2_update(struct omap_mpu_state_s *s,
 {
     omap_clk clk;
 
-#define SET_ONOFF(clock, bit)				\
-    if (diff & (1 << bit)) {				\
-        clk = omap_findclk(s, clock);			\
-        omap_clk_onoff(clk, (value >> bit) & 1);	\
+#define SET_ONOFF(clock, bit)                       \
+    if (diff & (1 << bit)) {                        \
+        clk = omap_findclk(s, clock);               \
+        omap_clk_onoff(clk, (value >> bit) & 1);    \
     }
-    SET_ONOFF("mpuwd_ck", 0)				/* EN_WDTCK */
-    SET_ONOFF("armxor_ck", 1)				/* EN_XORPCK */
-    SET_ONOFF("mpuper_ck", 2)				/* EN_PERCK */
-    SET_ONOFF("lcd_ck", 3)				/* EN_LCDCK */
-    SET_ONOFF("lb_ck", 4)				/* EN_LBCK */
-    SET_ONOFF("hsab_ck", 5)				/* EN_HSABCK */
-    SET_ONOFF("mpui_ck", 6)				/* EN_APICK */
-    SET_ONOFF("armtim_ck", 7)				/* EN_TIMCK */
-    SET_CANIDLE("dma_ck", 8)				/* DMACK_REQ */
-    SET_ONOFF("arm_gpio_ck", 9)				/* EN_GPIOCK */
-    SET_ONOFF("lbfree_ck", 10)				/* EN_LBFREECK */
+    SET_ONOFF("mpuwd_ck", 0)            /* EN_WDTCK */
+    SET_ONOFF("armxor_ck", 1)           /* EN_XORPCK */
+    SET_ONOFF("mpuper_ck", 2)           /* EN_PERCK */
+    SET_ONOFF("lcd_ck", 3)              /* EN_LCDCK */
+    SET_ONOFF("lb_ck", 4)               /* EN_LBCK */
+    SET_ONOFF("hsab_ck", 5)             /* EN_HSABCK */
+    SET_ONOFF("mpui_ck", 6)             /* EN_APICK */
+    SET_ONOFF("armtim_ck", 7)           /* EN_TIMCK */
+    SET_CANIDLE("dma_ck", 8)            /* DMACK_REQ */
+    SET_ONOFF("arm_gpio_ck", 9)         /* EN_GPIOCK */
+    SET_ONOFF("lbfree_ck", 10)          /* EN_LBFREECK */
 }
 
 static inline void omap_clkm_ckout1_update(struct omap_mpu_state_s *s,
@@ -1615,7 +1615,7 @@ static inline void omap_clkm_ckout1_update(struct omap_mpu_state_s *s,
 {
     omap_clk clk;
 
-    if (diff & (3 << 4)) {				/* TCLKOUT */
+    if (diff & (3 << 4)) {              /* TCLKOUT */
         clk = omap_findclk(s, "tclk_out");
         switch ((value >> 4) & 3) {
         case 1:
@@ -1630,7 +1630,7 @@ static inline void omap_clkm_ckout1_update(struct omap_mpu_state_s *s,
             omap_clk_onoff(clk, 0);
         }
     }
-    if (diff & (3 << 2)) {				/* DCLKOUT */
+    if (diff & (3 << 2)) {              /* DCLKOUT */
         clk = omap_findclk(s, "dclk_out");
         switch ((value >> 2) & 3) {
         case 0:
@@ -1647,7 +1647,7 @@ static inline void omap_clkm_ckout1_update(struct omap_mpu_state_s *s,
             break;
         }
     }
-    if (diff & (3 << 0)) {				/* ACLKOUT */
+    if (diff & (3 << 0)) {              /* ACLKOUT */
         clk = omap_findclk(s, "aclk_out");
         switch ((value >> 0) & 3) {
         case 1:
@@ -1685,51 +1685,51 @@ static void omap_clkm_write(void *opaque, hwaddr addr,
     }
 
     switch (addr) {
-    case 0x00:	/* ARM_CKCTL */
+    case 0x00:  /* ARM_CKCTL */
         diff = s->clkm.arm_ckctl ^ value;
         s->clkm.arm_ckctl = value & 0x7fff;
         omap_clkm_ckctl_update(s, diff, value);
         return;
 
-    case 0x04:	/* ARM_IDLECT1 */
+    case 0x04:  /* ARM_IDLECT1 */
         diff = s->clkm.arm_idlect1 ^ value;
         s->clkm.arm_idlect1 = value & 0x0fff;
         omap_clkm_idlect1_update(s, diff, value);
         return;
 
-    case 0x08:	/* ARM_IDLECT2 */
+    case 0x08:  /* ARM_IDLECT2 */
         diff = s->clkm.arm_idlect2 ^ value;
         s->clkm.arm_idlect2 = value & 0x07ff;
         omap_clkm_idlect2_update(s, diff, value);
         return;
 
-    case 0x0c:	/* ARM_EWUPCT */
+    case 0x0c:  /* ARM_EWUPCT */
         s->clkm.arm_ewupct = value & 0x003f;
         return;
 
-    case 0x10:	/* ARM_RSTCT1 */
+    case 0x10:  /* ARM_RSTCT1 */
         diff = s->clkm.arm_rstct1 ^ value;
         s->clkm.arm_rstct1 = value & 0x0007;
         if (value & 9) {
             qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
             s->clkm.cold_start = 0xa;
         }
-        if (diff & ~value & 4) {				/* DSP_RST */
+        if (diff & ~value & 4) {                /* DSP_RST */
             omap_mpui_reset(s);
             omap_tipb_bridge_reset(s->private_tipb);
             omap_tipb_bridge_reset(s->public_tipb);
         }
-        if (diff & 2) {						/* DSP_EN */
+        if (diff & 2) {                     /* DSP_EN */
             clk = omap_findclk(s, "dsp_ck");
             omap_clk_canidle(clk, (~value >> 1) & 1);
         }
         return;
 
-    case 0x14:	/* ARM_RSTCT2 */
+    case 0x14:  /* ARM_RSTCT2 */
         s->clkm.arm_rstct2 = value & 0x0001;
         return;
 
-    case 0x18:	/* ARM_SYSST */
+    case 0x18:  /* ARM_SYSST */
         if ((s->clkm.clocking_scheme ^ (value >> 11)) & 7) {
             s->clkm.clocking_scheme = (value >> 11) & 7;
             trace_omap1_pwl_clocking_scheme(
@@ -1738,13 +1738,13 @@ static void omap_clkm_write(void *opaque, hwaddr addr,
         s->clkm.cold_start &= value & 0x3f;
         return;
 
-    case 0x1c:	/* ARM_CKOUT1 */
+    case 0x1c:  /* ARM_CKOUT1 */
         diff = s->clkm.arm_ckout1 ^ value;
         s->clkm.arm_ckout1 = value & 0x003f;
         omap_clkm_ckout1_update(s, diff, value);
         return;
 
-    case 0x20:	/* ARM_CKOUT2 */
+    case 0x20:  /* ARM_CKOUT2 */
     default:
         OMAP_BAD_REG(addr);
     }
@@ -1767,16 +1767,16 @@ static uint64_t omap_clkdsp_read(void *opaque, hwaddr addr,
     }
 
     switch (addr) {
-    case 0x04:	/* DSP_IDLECT1 */
+    case 0x04:  /* DSP_IDLECT1 */
         return s->clkm.dsp_idlect1;
 
-    case 0x08:	/* DSP_IDLECT2 */
+    case 0x08:  /* DSP_IDLECT2 */
         return s->clkm.dsp_idlect2;
 
-    case 0x14:	/* DSP_RSTCT2 */
+    case 0x14:  /* DSP_RSTCT2 */
         return s->clkm.dsp_rstct2;
 
-    case 0x18:	/* DSP_SYSST */
+    case 0x18:  /* DSP_SYSST */
         return (s->clkm.clocking_scheme << 11) | s->clkm.cold_start |
                 (cpu->halted << 6);      /* Quite useless... */
     }
@@ -1790,7 +1790,7 @@ static inline void omap_clkdsp_idlect1_update(struct omap_mpu_state_s *s,
 {
     omap_clk clk;
 
-    SET_CANIDLE("dspxor_ck", 1);			/* IDLXORP_DSP */
+    SET_CANIDLE("dspxor_ck", 1);            /* IDLXORP_DSP */
 }
 
 static inline void omap_clkdsp_idlect2_update(struct omap_mpu_state_s *s,
@@ -1798,7 +1798,7 @@ static inline void omap_clkdsp_idlect2_update(struct omap_mpu_state_s *s,
 {
     omap_clk clk;
 
-    SET_ONOFF("dspxor_ck", 1);				/* EN_XORPCK */
+    SET_ONOFF("dspxor_ck", 1);              /* EN_XORPCK */
 }
 
 static void omap_clkdsp_write(void *opaque, hwaddr addr,
@@ -1813,23 +1813,23 @@ static void omap_clkdsp_write(void *opaque, hwaddr addr,
     }
 
     switch (addr) {
-    case 0x04:	/* DSP_IDLECT1 */
+    case 0x04:  /* DSP_IDLECT1 */
         diff = s->clkm.dsp_idlect1 ^ value;
         s->clkm.dsp_idlect1 = value & 0x01f7;
         omap_clkdsp_idlect1_update(s, diff, value);
         break;
 
-    case 0x08:	/* DSP_IDLECT2 */
+    case 0x08:  /* DSP_IDLECT2 */
         s->clkm.dsp_idlect2 = value & 0x0037;
         diff = s->clkm.dsp_idlect1 ^ value;
         omap_clkdsp_idlect2_update(s, diff, value);
         break;
 
-    case 0x14:	/* DSP_RSTCT2 */
+    case 0x14:  /* DSP_RSTCT2 */
         s->clkm.dsp_rstct2 = value & 0x0001;
         break;
 
-    case 0x18:	/* DSP_SYSST */
+    case 0x18:  /* DSP_SYSST */
         s->clkm.cold_start &= value & 0x3f;
         break;
 
@@ -1928,8 +1928,8 @@ static void omap_mpuio_set(void *opaque, int line, int level)
             qemu_irq_raise(s->irq);
             /* TODO: wakeup */
         }
-        if ((s->event & (1 << 0)) &&		/* SET_GPIO_EVENT_MODE */
-                (s->event >> 1) == line)	/* PIN_SELECT */
+        if ((s->event & (1 << 0)) &&        /* SET_GPIO_EVENT_MODE */
+                (s->event >> 1) == line)    /* PIN_SELECT */
             s->latch = s->inputs;
     }
 }
@@ -1959,47 +1959,47 @@ static uint64_t omap_mpuio_read(void *opaque, hwaddr addr,
     }
 
     switch (offset) {
-    case 0x00:	/* INPUT_LATCH */
+    case 0x00:  /* INPUT_LATCH */
         return s->inputs;
 
-    case 0x04:	/* OUTPUT_REG */
+    case 0x04:  /* OUTPUT_REG */
         return s->outputs;
 
-    case 0x08:	/* IO_CNTL */
+    case 0x08:  /* IO_CNTL */
         return s->dir;
 
-    case 0x10:	/* KBR_LATCH */
+    case 0x10:  /* KBR_LATCH */
         return s->row_latch;
 
-    case 0x14:	/* KBC_REG */
+    case 0x14:  /* KBC_REG */
         return s->cols;
 
-    case 0x18:	/* GPIO_EVENT_MODE_REG */
+    case 0x18:  /* GPIO_EVENT_MODE_REG */
         return s->event;
 
-    case 0x1c:	/* GPIO_INT_EDGE_REG */
+    case 0x1c:  /* GPIO_INT_EDGE_REG */
         return s->edge;
 
-    case 0x20:	/* KBD_INT */
+    case 0x20:  /* KBD_INT */
         return (~s->row_latch & 0x1f) && !s->kbd_mask;
 
-    case 0x24:	/* GPIO_INT */
+    case 0x24:  /* GPIO_INT */
         ret = s->ints;
         s->ints &= s->mask;
         if (ret)
             qemu_irq_lower(s->irq);
         return ret;
 
-    case 0x28:	/* KBD_MASKIT */
+    case 0x28:  /* KBD_MASKIT */
         return s->kbd_mask;
 
-    case 0x2c:	/* GPIO_MASKIT */
+    case 0x2c:  /* GPIO_MASKIT */
         return s->mask;
 
-    case 0x30:	/* GPIO_DEBOUNCING_REG */
+    case 0x30:  /* GPIO_DEBOUNCING_REG */
         return s->debounce;
 
-    case 0x34:	/* GPIO_LATCH_REG */
+    case 0x34:  /* GPIO_LATCH_REG */
         return s->latch;
     }
 
@@ -2021,7 +2021,7 @@ static void omap_mpuio_write(void *opaque, hwaddr addr,
     }
 
     switch (offset) {
-    case 0x04:	/* OUTPUT_REG */
+    case 0x04:  /* OUTPUT_REG */
         diff = (s->outputs ^ value) & ~s->dir;
         s->outputs = value;
         while ((ln = ctz32(diff)) != 32) {
@@ -2031,7 +2031,7 @@ static void omap_mpuio_write(void *opaque, hwaddr addr,
         }
         break;
 
-    case 0x08:	/* IO_CNTL */
+    case 0x08:  /* IO_CNTL */
         diff = s->outputs & (s->dir ^ value);
         s->dir = value;
 
@@ -2043,37 +2043,37 @@ static void omap_mpuio_write(void *opaque, hwaddr addr,
         }
         break;
 
-    case 0x14:	/* KBC_REG */
+    case 0x14:  /* KBC_REG */
         s->cols = value;
         omap_mpuio_kbd_update(s);
         break;
 
-    case 0x18:	/* GPIO_EVENT_MODE_REG */
+    case 0x18:  /* GPIO_EVENT_MODE_REG */
         s->event = value & 0x1f;
         break;
 
-    case 0x1c:	/* GPIO_INT_EDGE_REG */
+    case 0x1c:  /* GPIO_INT_EDGE_REG */
         s->edge = value;
         break;
 
-    case 0x28:	/* KBD_MASKIT */
+    case 0x28:  /* KBD_MASKIT */
         s->kbd_mask = value & 1;
         omap_mpuio_kbd_update(s);
         break;
 
-    case 0x2c:	/* GPIO_MASKIT */
+    case 0x2c:  /* GPIO_MASKIT */
         s->mask = value;
         break;
 
-    case 0x30:	/* GPIO_DEBOUNCING_REG */
+    case 0x30:  /* GPIO_DEBOUNCING_REG */
         s->debounce = value & 0x1ff;
         break;
 
-    case 0x00:	/* INPUT_LATCH */
-    case 0x10:	/* KBR_LATCH */
-    case 0x20:	/* KBD_INT */
-    case 0x24:	/* GPIO_INT */
-    case 0x34:	/* GPIO_LATCH_REG */
+    case 0x00:  /* INPUT_LATCH */
+    case 0x10:  /* KBR_LATCH */
+    case 0x20:  /* KBD_INT */
+    case 0x24:  /* GPIO_INT */
+    case 0x34:  /* GPIO_LATCH_REG */
         OMAP_RO_REG(addr);
         return;
 
@@ -2176,24 +2176,24 @@ struct omap_uwire_s {
 
 static void omap_uwire_transfer_start(struct omap_uwire_s *s)
 {
-    int chipselect = (s->control >> 10) & 3;		/* INDEX */
+    int chipselect = (s->control >> 10) & 3;        /* INDEX */
 
-    if ((s->control >> 5) & 0x1f) {			/* NB_BITS_WR */
+    if ((s->control >> 5) & 0x1f) {         /* NB_BITS_WR */
         if (s->control & (1 << 12)) {       /* CS_CMD */
             qemu_log_mask(LOG_UNIMP, "uWireSlave TX CS:%d data:0x%04x\n",
                           chipselect,
                           s->txbuf >> (16 - ((s->control >> 5) & 0x1f)));
         }
-        s->control &= ~(1 << 14);			/* CSRB */
+        s->control &= ~(1 << 14);           /* CSRB */
         /* TODO: depending on s->setup[4] bits [1:0] assert an IRQ or
          * a DRQ.  When is the level IRQ supposed to be reset?  */
     }
 
-    if ((s->control >> 0) & 0x1f) {			/* NB_BITS_RD */
+    if ((s->control >> 0) & 0x1f) {         /* NB_BITS_RD */
         if (s->control & (1 << 12)) {       /* CS_CMD */
             qemu_log_mask(LOG_UNIMP, "uWireSlave RX CS:%d\n", chipselect);
         }
-        s->control |= 1 << 15;				/* RDRB */
+        s->control |= 1 << 15;              /* RDRB */
         /* TODO: depending on s->setup[4] bits [1:0] assert an IRQ or
          * a DRQ.  When is the level IRQ supposed to be reset?  */
     }
@@ -2209,22 +2209,22 @@ static uint64_t omap_uwire_read(void *opaque, hwaddr addr, unsigned size)
     }
 
     switch (offset) {
-    case 0x00:	/* RDR */
-        s->control &= ~(1 << 15);			/* RDRB */
+    case 0x00:  /* RDR */
+        s->control &= ~(1 << 15);           /* RDRB */
         return s->rxbuf;
 
-    case 0x04:	/* CSR */
+    case 0x04:  /* CSR */
         return s->control;
 
-    case 0x08:	/* SR1 */
+    case 0x08:  /* SR1 */
         return s->setup[0];
-    case 0x0c:	/* SR2 */
+    case 0x0c:  /* SR2 */
         return s->setup[1];
-    case 0x10:	/* SR3 */
+    case 0x10:  /* SR3 */
         return s->setup[2];
-    case 0x14:	/* SR4 */
+    case 0x14:  /* SR4 */
         return s->setup[3];
-    case 0x18:	/* SR5 */
+    case 0x18:  /* SR5 */
         return s->setup[4];
     }
 
@@ -2244,39 +2244,39 @@ static void omap_uwire_write(void *opaque, hwaddr addr,
     }
 
     switch (offset) {
-    case 0x00:	/* TDR */
-        s->txbuf = value;				/* TD */
-        if ((s->setup[4] & (1 << 2)) &&			/* AUTO_TX_EN */
-                        ((s->setup[4] & (1 << 3)) ||	/* CS_TOGGLE_TX_EN */
-                         (s->control & (1 << 12)))) {	/* CS_CMD */
-            s->control |= 1 << 14;			/* CSRB */
+    case 0x00:  /* TDR */
+        s->txbuf = value;                               /* TD */
+        if ((s->setup[4] & (1 << 2)) &&                 /* AUTO_TX_EN */
+                        ((s->setup[4] & (1 << 3)) ||    /* CS_TOGGLE_TX_EN */
+                         (s->control & (1 << 12)))) {   /* CS_CMD */
+            s->control |= 1 << 14;                      /* CSRB */
             omap_uwire_transfer_start(s);
         }
         break;
 
-    case 0x04:	/* CSR */
+    case 0x04:  /* CSR */
         s->control = value & 0x1fff;
-        if (value & (1 << 13))				/* START */
+        if (value & (1 << 13))  /* START */
             omap_uwire_transfer_start(s);
         break;
 
-    case 0x08:	/* SR1 */
+    case 0x08:  /* SR1 */
         s->setup[0] = value & 0x003f;
         break;
 
-    case 0x0c:	/* SR2 */
+    case 0x0c:  /* SR2 */
         s->setup[1] = value & 0x0fc0;
         break;
 
-    case 0x10:	/* SR3 */
+    case 0x10:  /* SR3 */
         s->setup[2] = value & 0x0003;
         break;
 
-    case 0x14:	/* SR4 */
+    case 0x14:  /* SR4 */
         s->setup[3] = value & 0x0001;
         break;
 
-    case 0x18:	/* SR5 */
+    case 0x18:  /* SR5 */
         s->setup[4] = value & 0x000f;
         break;
 
@@ -2350,9 +2350,9 @@ static uint64_t omap_pwl_read(void *opaque, hwaddr addr, unsigned size)
     }
 
     switch (offset) {
-    case 0x00:	/* PWL_LEVEL */
+    case 0x00:  /* PWL_LEVEL */
         return s->level;
-    case 0x04:	/* PWL_CTRL */
+    case 0x04:  /* PWL_CTRL */
         return s->enable;
     }
     OMAP_BAD_REG(addr);
@@ -2371,11 +2371,11 @@ static void omap_pwl_write(void *opaque, hwaddr addr,
     }
 
     switch (offset) {
-    case 0x00:	/* PWL_LEVEL */
+    case 0x00:  /* PWL_LEVEL */
         s->level = value;
         omap_pwl_update(s);
         break;
-    case 0x04:	/* PWL_CTRL */
+    case 0x04:  /* PWL_CTRL */
         s->enable = value & 1;
         omap_pwl_update(s);
         break;
@@ -2443,11 +2443,11 @@ static uint64_t omap_pwt_read(void *opaque, hwaddr addr, unsigned size)
     }
 
     switch (offset) {
-    case 0x00:	/* FRC */
+    case 0x00:  /* FRC */
         return s->frc;
-    case 0x04:	/* VCR */
+    case 0x04:  /* VCR */
         return s->vrc;
-    case 0x08:	/* GCR */
+    case 0x08:  /* GCR */
         return s->gcr;
     }
     OMAP_BAD_REG(addr);
@@ -2466,10 +2466,10 @@ static void omap_pwt_write(void *opaque, hwaddr addr,
     }
 
     switch (offset) {
-    case 0x00:	/* FRC */
+    case 0x00:  /* FRC */
         s->frc = value & 0x3f;
         break;
-    case 0x04:	/* VRC */
+    case 0x04:  /* VRC */
         if ((value ^ s->vrc) & 1) {
             if (value & 1) {
                 trace_omap1_pwt_buzz(
@@ -2494,7 +2494,7 @@ static void omap_pwt_write(void *opaque, hwaddr addr,
         }
         s->vrc = value & 0x7f;
         break;
-    case 0x08:	/* GCR */
+    case 0x08:  /* GCR */
         s->gcr = value & 3;
         break;
     default:
@@ -2577,69 +2577,69 @@ static uint64_t omap_rtc_read(void *opaque, hwaddr addr, unsigned size)
     }
 
     switch (offset) {
-    case 0x00:	/* SECONDS_REG */
+    case 0x00:  /* SECONDS_REG */
         return to_bcd(s->current_tm.tm_sec);
 
-    case 0x04:	/* MINUTES_REG */
+    case 0x04:  /* MINUTES_REG */
         return to_bcd(s->current_tm.tm_min);
 
-    case 0x08:	/* HOURS_REG */
+    case 0x08:  /* HOURS_REG */
         if (s->pm_am)
             return ((s->current_tm.tm_hour > 11) << 7) |
                     to_bcd(((s->current_tm.tm_hour - 1) % 12) + 1);
         else
             return to_bcd(s->current_tm.tm_hour);
 
-    case 0x0c:	/* DAYS_REG */
+    case 0x0c:  /* DAYS_REG */
         return to_bcd(s->current_tm.tm_mday);
 
-    case 0x10:	/* MONTHS_REG */
+    case 0x10:  /* MONTHS_REG */
         return to_bcd(s->current_tm.tm_mon + 1);
 
-    case 0x14:	/* YEARS_REG */
+    case 0x14:  /* YEARS_REG */
         return to_bcd(s->current_tm.tm_year % 100);
 
-    case 0x18:	/* WEEK_REG */
+    case 0x18:  /* WEEK_REG */
         return s->current_tm.tm_wday;
 
-    case 0x20:	/* ALARM_SECONDS_REG */
+    case 0x20:  /* ALARM_SECONDS_REG */
         return to_bcd(s->alarm_tm.tm_sec);
 
-    case 0x24:	/* ALARM_MINUTES_REG */
+    case 0x24:  /* ALARM_MINUTES_REG */
         return to_bcd(s->alarm_tm.tm_min);
 
-    case 0x28:	/* ALARM_HOURS_REG */
+    case 0x28:  /* ALARM_HOURS_REG */
         if (s->pm_am)
             return ((s->alarm_tm.tm_hour > 11) << 7) |
                     to_bcd(((s->alarm_tm.tm_hour - 1) % 12) + 1);
         else
             return to_bcd(s->alarm_tm.tm_hour);
 
-    case 0x2c:	/* ALARM_DAYS_REG */
+    case 0x2c:  /* ALARM_DAYS_REG */
         return to_bcd(s->alarm_tm.tm_mday);
 
-    case 0x30:	/* ALARM_MONTHS_REG */
+    case 0x30:  /* ALARM_MONTHS_REG */
         return to_bcd(s->alarm_tm.tm_mon + 1);
 
-    case 0x34:	/* ALARM_YEARS_REG */
+    case 0x34:  /* ALARM_YEARS_REG */
         return to_bcd(s->alarm_tm.tm_year % 100);
 
-    case 0x40:	/* RTC_CTRL_REG */
+    case 0x40:  /* RTC_CTRL_REG */
         return (s->pm_am << 3) | (s->auto_comp << 2) |
                 (s->round << 1) | s->running;
 
-    case 0x44:	/* RTC_STATUS_REG */
+    case 0x44:  /* RTC_STATUS_REG */
         i = s->status;
         s->status &= ~0x3d;
         return i;
 
-    case 0x48:	/* RTC_INTERRUPTS_REG */
+    case 0x48:  /* RTC_INTERRUPTS_REG */
         return s->interrupts;
 
-    case 0x4c:	/* RTC_COMP_LSB_REG */
+    case 0x4c:  /* RTC_COMP_LSB_REG */
         return ((uint16_t) s->comp_reg) & 0xff;
 
-    case 0x50:	/* RTC_COMP_MSB_REG */
+    case 0x50:  /* RTC_COMP_MSB_REG */
         return ((uint16_t) s->comp_reg) >> 8;
     }
 
@@ -2661,17 +2661,17 @@ static void omap_rtc_write(void *opaque, hwaddr addr,
     }
 
     switch (offset) {
-    case 0x00:	/* SECONDS_REG */
+    case 0x00:  /* SECONDS_REG */
         s->ti -= s->current_tm.tm_sec;
         s->ti += from_bcd(value);
         return;
 
-    case 0x04:	/* MINUTES_REG */
+    case 0x04:  /* MINUTES_REG */
         s->ti -= s->current_tm.tm_min * 60;
         s->ti += from_bcd(value) * 60;
         return;
 
-    case 0x08:	/* HOURS_REG */
+    case 0x08:  /* HOURS_REG */
         s->ti -= s->current_tm.tm_hour * 3600;
         if (s->pm_am) {
             s->ti += (from_bcd(value & 0x3f) & 12) * 3600;
@@ -2680,12 +2680,12 @@ static void omap_rtc_write(void *opaque, hwaddr addr,
             s->ti += from_bcd(value & 0x3f) * 3600;
         return;
 
-    case 0x0c:	/* DAYS_REG */
+    case 0x0c:  /* DAYS_REG */
         s->ti -= s->current_tm.tm_mday * 86400;
         s->ti += from_bcd(value) * 86400;
         return;
 
-    case 0x10:	/* MONTHS_REG */
+    case 0x10:  /* MONTHS_REG */
         memcpy(&new_tm, &s->current_tm, sizeof(new_tm));
         new_tm.tm_mon = from_bcd(value);
         ti[0] = mktimegm(&s->current_tm);
@@ -2701,7 +2701,7 @@ static void omap_rtc_write(void *opaque, hwaddr addr,
         }
         return;
 
-    case 0x14:	/* YEARS_REG */
+    case 0x14:  /* YEARS_REG */
         memcpy(&new_tm, &s->current_tm, sizeof(new_tm));
         new_tm.tm_year += from_bcd(value) - (new_tm.tm_year % 100);
         ti[0] = mktimegm(&s->current_tm);
@@ -2717,20 +2717,20 @@ static void omap_rtc_write(void *opaque, hwaddr addr,
         }
         return;
 
-    case 0x18:	/* WEEK_REG */
-        return;	/* Ignored */
+    case 0x18:  /* WEEK_REG */
+        return; /* Ignored */
 
-    case 0x20:	/* ALARM_SECONDS_REG */
+    case 0x20:  /* ALARM_SECONDS_REG */
         s->alarm_tm.tm_sec = from_bcd(value);
         omap_rtc_alarm_update(s);
         return;
 
-    case 0x24:	/* ALARM_MINUTES_REG */
+    case 0x24:  /* ALARM_MINUTES_REG */
         s->alarm_tm.tm_min = from_bcd(value);
         omap_rtc_alarm_update(s);
         return;
 
-    case 0x28:	/* ALARM_HOURS_REG */
+    case 0x28:  /* ALARM_HOURS_REG */
         if (s->pm_am)
             s->alarm_tm.tm_hour =
                     ((from_bcd(value & 0x3f)) % 12) +
@@ -2740,22 +2740,22 @@ static void omap_rtc_write(void *opaque, hwaddr addr,
         omap_rtc_alarm_update(s);
         return;
 
-    case 0x2c:	/* ALARM_DAYS_REG */
+    case 0x2c:  /* ALARM_DAYS_REG */
         s->alarm_tm.tm_mday = from_bcd(value);
         omap_rtc_alarm_update(s);
         return;
 
-    case 0x30:	/* ALARM_MONTHS_REG */
+    case 0x30:  /* ALARM_MONTHS_REG */
         s->alarm_tm.tm_mon = from_bcd(value);
         omap_rtc_alarm_update(s);
         return;
 
-    case 0x34:	/* ALARM_YEARS_REG */
+    case 0x34:  /* ALARM_YEARS_REG */
         s->alarm_tm.tm_year = from_bcd(value);
         omap_rtc_alarm_update(s);
         return;
 
-    case 0x40:	/* RTC_CTRL_REG */
+    case 0x40:  /* RTC_CTRL_REG */
         s->pm_am = (value >> 3) & 1;
         s->auto_comp = (value >> 2) & 1;
         s->round = (value >> 1) & 1;
@@ -2764,21 +2764,21 @@ static void omap_rtc_write(void *opaque, hwaddr addr,
         s->status |= s->running << 1;
         return;
 
-    case 0x44:	/* RTC_STATUS_REG */
+    case 0x44:  /* RTC_STATUS_REG */
         s->status &= ~((value & 0xc0) ^ 0x80);
         omap_rtc_interrupts_update(s);
         return;
 
-    case 0x48:	/* RTC_INTERRUPTS_REG */
+    case 0x48:  /* RTC_INTERRUPTS_REG */
         s->interrupts = value;
         return;
 
-    case 0x4c:	/* RTC_COMP_LSB_REG */
+    case 0x4c:  /* RTC_COMP_LSB_REG */
         s->comp_reg &= 0xff00;
         s->comp_reg |= 0x00ff & value;
         return;
 
-    case 0x50:	/* RTC_COMP_MSB_REG */
+    case 0x50:  /* RTC_COMP_MSB_REG */
         s->comp_reg &= 0x00ff;
         s->comp_reg |= 0xff00 & (value << 8);
         return;
@@ -2929,12 +2929,12 @@ static void omap_mcbsp_intr_update(struct omap_mcbsp_s *s)
 {
     int irq;
 
-    switch ((s->spcr[0] >> 4) & 3) {			/* RINTM */
+    switch ((s->spcr[0] >> 4) & 3) {            /* RINTM */
     case 0:
-        irq = (s->spcr[0] >> 1) & 1;			/* RRDY */
+        irq = (s->spcr[0] >> 1) & 1;            /* RRDY */
         break;
     case 3:
-        irq = (s->spcr[0] >> 3) & 1;			/* RSYNCERR */
+        irq = (s->spcr[0] >> 3) & 1;            /* RSYNCERR */
         break;
     default:
         irq = 0;
@@ -2944,12 +2944,12 @@ static void omap_mcbsp_intr_update(struct omap_mcbsp_s *s)
     if (irq)
         qemu_irq_pulse(s->rxirq);
 
-    switch ((s->spcr[1] >> 4) & 3) {			/* XINTM */
+    switch ((s->spcr[1] >> 4) & 3) {            /* XINTM */
     case 0:
-        irq = (s->spcr[1] >> 1) & 1;			/* XRDY */
+        irq = (s->spcr[1] >> 1) & 1;            /* XRDY */
         break;
     case 3:
-        irq = (s->spcr[1] >> 3) & 1;			/* XSYNCERR */
+        irq = (s->spcr[1] >> 3) & 1;            /* XSYNCERR */
         break;
     default:
         irq = 0;
@@ -2962,9 +2962,9 @@ static void omap_mcbsp_intr_update(struct omap_mcbsp_s *s)
 
 static void omap_mcbsp_rx_newdata(struct omap_mcbsp_s *s)
 {
-    if ((s->spcr[0] >> 1) & 1)				/* RRDY */
-        s->spcr[0] |= 1 << 2;				/* RFULL */
-    s->spcr[0] |= 1 << 1;				/* RRDY */
+    if ((s->spcr[0] >> 1) & 1)              /* RRDY */
+        s->spcr[0] |= 1 << 2;               /* RFULL */
+    s->spcr[0] |= 1 << 1;                   /* RRDY */
     qemu_irq_raise(s->rxdrq);
     omap_mcbsp_intr_update(s);
 }
@@ -3004,14 +3004,14 @@ static void omap_mcbsp_rx_stop(struct omap_mcbsp_s *s)
 
 static void omap_mcbsp_rx_done(struct omap_mcbsp_s *s)
 {
-    s->spcr[0] &= ~(1 << 1);				/* RRDY */
+    s->spcr[0] &= ~(1 << 1);                /* RRDY */
     qemu_irq_lower(s->rxdrq);
     omap_mcbsp_intr_update(s);
 }
 
 static void omap_mcbsp_tx_newdata(struct omap_mcbsp_s *s)
 {
-    s->spcr[1] |= 1 << 1;				/* XRDY */
+    s->spcr[1] |= 1 << 1;               /* XRDY */
     qemu_irq_raise(s->txdrq);
     omap_mcbsp_intr_update(s);
 }
@@ -3046,7 +3046,7 @@ static void omap_mcbsp_tx_start(struct omap_mcbsp_s *s)
 
 static void omap_mcbsp_tx_done(struct omap_mcbsp_s *s)
 {
-    s->spcr[1] &= ~(1 << 1);				/* XRDY */
+    s->spcr[1] &= ~(1 << 1);                /* XRDY */
     qemu_irq_lower(s->txdrq);
     omap_mcbsp_intr_update(s);
     if (s->codec && s->codec->cts)
@@ -3064,27 +3064,27 @@ static void omap_mcbsp_req_update(struct omap_mcbsp_s *s)
 {
     int prev_rx_rate, prev_tx_rate;
     int rx_rate = 0, tx_rate = 0;
-    int cpu_rate = 1500000;	/* XXX */
+    int cpu_rate = 1500000; /* XXX */
 
     /* TODO: check CLKSTP bit */
-    if (s->spcr[1] & (1 << 6)) {			/* GRST */
-        if (s->spcr[0] & (1 << 0)) {			/* RRST */
-            if ((s->srgr[1] & (1 << 13)) &&		/* CLKSM */
-                            (s->pcr & (1 << 8))) {	/* CLKRM */
-                if (~s->pcr & (1 << 7))			/* SCLKME */
+    if (s->spcr[1] & (1 << 6)) {                        /* GRST */
+        if (s->spcr[0] & (1 << 0)) {                    /* RRST */
+            if ((s->srgr[1] & (1 << 13)) &&             /* CLKSM */
+                            (s->pcr & (1 << 8))) {      /* CLKRM */
+                if (~s->pcr & (1 << 7))                 /* SCLKME */
                     rx_rate = cpu_rate /
-                            ((s->srgr[0] & 0xff) + 1);	/* CLKGDV */
+                            ((s->srgr[0] & 0xff) + 1);  /* CLKGDV */
             } else
                 if (s->codec)
                     rx_rate = s->codec->rx_rate;
         }
 
-        if (s->spcr[1] & (1 << 0)) {			/* XRST */
-            if ((s->srgr[1] & (1 << 13)) &&		/* CLKSM */
-                            (s->pcr & (1 << 9))) {	/* CLKXM */
-                if (~s->pcr & (1 << 7))			/* SCLKME */
+        if (s->spcr[1] & (1 << 0)) {                    /* XRST */
+            if ((s->srgr[1] & (1 << 13)) &&             /* CLKSM */
+                            (s->pcr & (1 << 9))) {      /* CLKXM */
+                if (~s->pcr & (1 << 7))                 /* SCLKME */
                     tx_rate = cpu_rate /
-                            ((s->srgr[0] & 0xff) + 1);	/* CLKGDV */
+                            ((s->srgr[0] & 0xff) + 1);  /* CLKGDV */
             } else
                 if (s->codec)
                     tx_rate = s->codec->tx_rate;
@@ -3121,11 +3121,11 @@ static uint64_t omap_mcbsp_read(void *opaque, hwaddr addr,
     }
 
     switch (offset) {
-    case 0x00:	/* DRR2 */
-        if (((s->rcr[0] >> 5) & 7) < 3)			/* RWDLEN1 */
+    case 0x00:  /* DRR2 */
+        if (((s->rcr[0] >> 5) & 7) < 3)         /* RWDLEN1 */
             return 0x0000;
         /* Fall through.  */
-    case 0x02:	/* DRR1 */
+    case 0x02:  /* DRR1 */
         if (s->rx_req < 2) {
             qemu_log_mask(LOG_GUEST_ERROR, "%s: Rx FIFO underrun\n", __func__);
             omap_mcbsp_rx_done(s);
@@ -3143,63 +3143,63 @@ static uint64_t omap_mcbsp_read(void *opaque, hwaddr addr,
         }
         return 0x0000;
 
-    case 0x04:	/* DXR2 */
-    case 0x06:	/* DXR1 */
+    case 0x04:  /* DXR2 */
+    case 0x06:  /* DXR1 */
         return 0x0000;
 
-    case 0x08:	/* SPCR2 */
+    case 0x08:  /* SPCR2 */
         return s->spcr[1];
-    case 0x0a:	/* SPCR1 */
+    case 0x0a:  /* SPCR1 */
         return s->spcr[0];
-    case 0x0c:	/* RCR2 */
+    case 0x0c:  /* RCR2 */
         return s->rcr[1];
-    case 0x0e:	/* RCR1 */
+    case 0x0e:  /* RCR1 */
         return s->rcr[0];
-    case 0x10:	/* XCR2 */
+    case 0x10:  /* XCR2 */
         return s->xcr[1];
-    case 0x12:	/* XCR1 */
+    case 0x12:  /* XCR1 */
         return s->xcr[0];
-    case 0x14:	/* SRGR2 */
+    case 0x14:  /* SRGR2 */
         return s->srgr[1];
-    case 0x16:	/* SRGR1 */
+    case 0x16:  /* SRGR1 */
         return s->srgr[0];
-    case 0x18:	/* MCR2 */
+    case 0x18:  /* MCR2 */
         return s->mcr[1];
-    case 0x1a:	/* MCR1 */
+    case 0x1a:  /* MCR1 */
         return s->mcr[0];
-    case 0x1c:	/* RCERA */
+    case 0x1c:  /* RCERA */
         return s->rcer[0];
-    case 0x1e:	/* RCERB */
+    case 0x1e:  /* RCERB */
         return s->rcer[1];
-    case 0x20:	/* XCERA */
+    case 0x20:  /* XCERA */
         return s->xcer[0];
-    case 0x22:	/* XCERB */
+    case 0x22:  /* XCERB */
         return s->xcer[1];
-    case 0x24:	/* PCR0 */
+    case 0x24:  /* PCR0 */
         return s->pcr;
-    case 0x26:	/* RCERC */
+    case 0x26:  /* RCERC */
         return s->rcer[2];
-    case 0x28:	/* RCERD */
+    case 0x28:  /* RCERD */
         return s->rcer[3];
-    case 0x2a:	/* XCERC */
+    case 0x2a:  /* XCERC */
         return s->xcer[2];
-    case 0x2c:	/* XCERD */
+    case 0x2c:  /* XCERD */
         return s->xcer[3];
-    case 0x2e:	/* RCERE */
+    case 0x2e:  /* RCERE */
         return s->rcer[4];
-    case 0x30:	/* RCERF */
+    case 0x30:  /* RCERF */
         return s->rcer[5];
-    case 0x32:	/* XCERE */
+    case 0x32:  /* XCERE */
         return s->xcer[4];
-    case 0x34:	/* XCERF */
+    case 0x34:  /* XCERF */
         return s->xcer[5];
-    case 0x36:	/* RCERG */
+    case 0x36:  /* RCERG */
         return s->rcer[6];
-    case 0x38:	/* RCERH */
+    case 0x38:  /* RCERH */
         return s->rcer[7];
-    case 0x3a:	/* XCERG */
+    case 0x3a:  /* XCERG */
         return s->xcer[6];
-    case 0x3c:	/* XCERH */
+    case 0x3c:  /* XCERH */
         return s->xcer[7];
     }
 
@@ -3214,16 +3214,16 @@ static void omap_mcbsp_writeh(void *opaque, hwaddr addr,
     int offset = addr & OMAP_MPUI_REG_MASK;
 
     switch (offset) {
-    case 0x00:	/* DRR2 */
-    case 0x02:	/* DRR1 */
+    case 0x00:  /* DRR2 */
+    case 0x02:  /* DRR1 */
         OMAP_RO_REG(addr);
         return;
 
-    case 0x04:	/* DXR2 */
-        if (((s->xcr[0] >> 5) & 7) < 3)			/* XWDLEN1 */
+    case 0x04:  /* DXR2 */
+        if (((s->xcr[0] >> 5) & 7) < 3)         /* XWDLEN1 */
             return;
         /* Fall through.  */
-    case 0x06:	/* DXR1 */
+    case 0x06:  /* DXR1 */
         if (s->tx_req > 1) {
             s->tx_req -= 2;
             if (s->codec && s->codec->cts) {
@@ -3237,15 +3237,15 @@ static void omap_mcbsp_writeh(void *opaque, hwaddr addr,
         }
         return;
 
-    case 0x08:	/* SPCR2 */
+    case 0x08:  /* SPCR2 */
         s->spcr[1] &= 0x0002;
         s->spcr[1] |= 0x03f9 & value;
-        s->spcr[1] |= 0x0004 & (value << 2);		/* XEMPTY := XRST */
-        if (~value & 1)					/* XRST */
+        s->spcr[1] |= 0x0004 & (value << 2);        /* XEMPTY := XRST */
+        if (~value & 1)                             /* XRST */
             s->spcr[1] &= ~6;
         omap_mcbsp_req_update(s);
         return;
-    case 0x0a:	/* SPCR1 */
+    case 0x0a:  /* SPCR1 */
         s->spcr[0] &= 0x0006;
         s->spcr[0] |= 0xf8f9 & value;
         if (value & (1 << 15)) {                        /* DLB */
@@ -3253,7 +3253,7 @@ static void omap_mcbsp_writeh(void *opaque, hwaddr addr,
                           "%s: Digital Loopback mode enable attempt\n",
                           __func__);
         }
-        if (~value & 1) {				/* RRST */
+        if (~value & 1) {               /* RRST */
             s->spcr[0] &= ~6;
             s->rx_req = 0;
             omap_mcbsp_rx_done(s);
@@ -3261,27 +3261,27 @@ static void omap_mcbsp_writeh(void *opaque, hwaddr addr,
         omap_mcbsp_req_update(s);
         return;
 
-    case 0x0c:	/* RCR2 */
+    case 0x0c:  /* RCR2 */
         s->rcr[1] = value & 0xffff;
         return;
-    case 0x0e:	/* RCR1 */
+    case 0x0e:  /* RCR1 */
         s->rcr[0] = value & 0x7fe0;
         return;
-    case 0x10:	/* XCR2 */
+    case 0x10:  /* XCR2 */
         s->xcr[1] = value & 0xffff;
         return;
-    case 0x12:	/* XCR1 */
+    case 0x12:  /* XCR1 */
         s->xcr[0] = value & 0x7fe0;
         return;
-    case 0x14:	/* SRGR2 */
+    case 0x14:  /* SRGR2 */
         s->srgr[1] = value & 0xffff;
         omap_mcbsp_req_update(s);
         return;
-    case 0x16:	/* SRGR1 */
+    case 0x16:  /* SRGR1 */
         s->srgr[0] = value & 0xffff;
         omap_mcbsp_req_update(s);
         return;
-    case 0x18:	/* MCR2 */
+    case 0x18:  /* MCR2 */
         s->mcr[1] = value & 0x03e3;
         if (value & 3) {                                /* XMCM */
             qemu_log_mask(LOG_UNIMP,
@@ -3289,7 +3289,7 @@ static void omap_mcbsp_writeh(void *opaque, hwaddr addr,
                           __func__);
         }
         return;
-    case 0x1a:	/* MCR1 */
+    case 0x1a:  /* MCR1 */
         s->mcr[0] = value & 0x03e1;
         if (value & 1) {                                /* RMCM */
             qemu_log_mask(LOG_UNIMP,
@@ -3297,55 +3297,55 @@ static void omap_mcbsp_writeh(void *opaque, hwaddr addr,
                           __func__);
         }
         return;
-    case 0x1c:	/* RCERA */
+    case 0x1c:  /* RCERA */
         s->rcer[0] = value & 0xffff;
         return;
-    case 0x1e:	/* RCERB */
+    case 0x1e:  /* RCERB */
         s->rcer[1] = value & 0xffff;
         return;
-    case 0x20:	/* XCERA */
+    case 0x20:  /* XCERA */
         s->xcer[0] = value & 0xffff;
         return;
-    case 0x22:	/* XCERB */
+    case 0x22:  /* XCERB */
         s->xcer[1] = value & 0xffff;
         return;
-    case 0x24:	/* PCR0 */
+    case 0x24:  /* PCR0 */
         s->pcr = value & 0x7faf;
         return;
-    case 0x26:	/* RCERC */
+    case 0x26:  /* RCERC */
         s->rcer[2] = value & 0xffff;
         return;
-    case 0x28:	/* RCERD */
+    case 0x28:  /* RCERD */
         s->rcer[3] = value & 0xffff;
         return;
-    case 0x2a:	/* XCERC */
+    case 0x2a:  /* XCERC */
         s->xcer[2] = value & 0xffff;
         return;
-    case 0x2c:	/* XCERD */
+    case 0x2c:  /* XCERD */
         s->xcer[3] = value & 0xffff;
         return;
-    case 0x2e:	/* RCERE */
+    case 0x2e:  /* RCERE */
         s->rcer[4] = value & 0xffff;
         return;
-    case 0x30:	/* RCERF */
+    case 0x30:  /* RCERF */
         s->rcer[5] = value & 0xffff;
         return;
-    case 0x32:	/* XCERE */
+    case 0x32:  /* XCERE */
         s->xcer[4] = value & 0xffff;
         return;
-    case 0x34:	/* XCERF */
+    case 0x34:  /* XCERF */
         s->xcer[5] = value & 0xffff;
         return;
-    case 0x36:	/* RCERG */
+    case 0x36:  /* RCERG */
         s->rcer[6] = value & 0xffff;
         return;
-    case 0x38:	/* RCERH */
+    case 0x38:  /* RCERH */
         s->rcer[7] = value & 0xffff;
         return;
-    case 0x3a:	/* XCERG */
+    case 0x3a:  /* XCERG */
         s->xcer[6] = value & 0xffff;
         return;
-    case 0x3c:	/* XCERH */
+    case 0x3c:  /* XCERH */
         s->xcer[7] = value & 0xffff;
         return;
     }
@@ -3359,8 +3359,8 @@ static void omap_mcbsp_writew(void *opaque, hwaddr addr,
     struct omap_mcbsp_s *s = opaque;
     int offset = addr & OMAP_MPUI_REG_MASK;
 
-    if (offset == 0x04) {				/* DXR */
-        if (((s->xcr[0] >> 5) & 7) < 3)			/* XWDLEN1 */
+    if (offset == 0x04) {                       /* DXR */
+        if (((s->xcr[0] >> 5) & 7) < 3)         /* XWDLEN1 */
             return;
         if (s->tx_req > 3) {
             s->tx_req -= 4;
@@ -3504,15 +3504,15 @@ static void omap_lpg_update(struct omap_lpg_s *s)
     int64_t on, period = 1, ticks = 1000;
     static const int per[8] = { 1, 2, 4, 8, 12, 16, 20, 24 };
 
-    if (~s->control & (1 << 6))					/* LPGRES */
+    if (~s->control & (1 << 6))                 /* LPGRES */
         on = 0;
-    else if (s->control & (1 << 7))				/* PERM_ON */
+    else if (s->control & (1 << 7))             /* PERM_ON */
         on = period;
     else {
-        period = muldiv64(ticks, per[s->control & 7],		/* PERCTRL */
+        period = muldiv64(ticks, per[s->control & 7],       /* PERCTRL */
                         256 / 32);
         on = (s->clk && s->power) ? muldiv64(ticks,
-                        per[(s->control >> 3) & 7], 256) : 0;	/* ONCTRL */
+                        per[(s->control >> 3) & 7], 256) : 0;   /* ONCTRL */
     }
 
     timer_del(s->tm);
@@ -3550,10 +3550,10 @@ static uint64_t omap_lpg_read(void *opaque, hwaddr addr, unsigned size)
     }
 
     switch (offset) {
-    case 0x00:	/* LCR */
+    case 0x00:  /* LCR */
         return s->control;
 
-    case 0x04:	/* PMR */
+    case 0x04:  /* PMR */
         return s->power;
     }
 
@@ -3573,14 +3573,14 @@ static void omap_lpg_write(void *opaque, hwaddr addr,
     }
 
     switch (offset) {
-    case 0x00:	/* LCR */
-        if (~value & (1 << 6))					/* LPGRES */
+    case 0x00:  /* LCR */
+        if (~value & (1 << 6))                  /* LPGRES */
             omap_lpg_reset(s);
         s->control = value & 0xff;
         omap_lpg_update(s);
         return;
 
-    case 0x04:	/* PMR */
+    case 0x04:  /* PMR */
         s->power = value & 0x01;
         omap_lpg_update(s);
         return;
@@ -3630,7 +3630,7 @@ static uint64_t omap_mpui_io_read(void *opaque, hwaddr addr,
         return omap_badwidth_read16(opaque, addr);
     }
 
-    if (addr == OMAP_MPUI_BASE)	/* CMR */
+    if (addr == OMAP_MPUI_BASE) /* CMR */
         return 0xfe4d;
 
     OMAP_BAD_REG(addr);
@@ -3703,25 +3703,25 @@ static const struct omap_map_s {
     const char *name;
 } omap15xx_dsp_mm[] = {
     /* Strobe 0 */
-    { 0xe1010000, 0xfffb0000, 0x800, "UART1 BT" },		/* CS0 */
-    { 0xe1010800, 0xfffb0800, 0x800, "UART2 COM" },		/* CS1 */
-    { 0xe1011800, 0xfffb1800, 0x800, "McBSP1 audio" },		/* CS3 */
-    { 0xe1012000, 0xfffb2000, 0x800, "MCSI2 communication" },	/* CS4 */
-    { 0xe1012800, 0xfffb2800, 0x800, "MCSI1 BT u-Law" },	/* CS5 */
-    { 0xe1013000, 0xfffb3000, 0x800, "uWire" },			/* CS6 */
-    { 0xe1013800, 0xfffb3800, 0x800, "I^2C" },			/* CS7 */
-    { 0xe1014000, 0xfffb4000, 0x800, "USB W2FC" },		/* CS8 */
-    { 0xe1014800, 0xfffb4800, 0x800, "RTC" },			/* CS9 */
-    { 0xe1015000, 0xfffb5000, 0x800, "MPUIO" },			/* CS10 */
-    { 0xe1015800, 0xfffb5800, 0x800, "PWL" },			/* CS11 */
-    { 0xe1016000, 0xfffb6000, 0x800, "PWT" },			/* CS12 */
-    { 0xe1017000, 0xfffb7000, 0x800, "McBSP3" },		/* CS14 */
-    { 0xe1017800, 0xfffb7800, 0x800, "MMC" },			/* CS15 */
-    { 0xe1019000, 0xfffb9000, 0x800, "32-kHz timer" },		/* CS18 */
-    { 0xe1019800, 0xfffb9800, 0x800, "UART3" },			/* CS19 */
-    { 0xe101c800, 0xfffbc800, 0x800, "TIPB switches" },		/* CS25 */
+    { 0xe1010000, 0xfffb0000, 0x800, "UART1 BT" },              /* CS0 */
+    { 0xe1010800, 0xfffb0800, 0x800, "UART2 COM" },             /* CS1 */
+    { 0xe1011800, 0xfffb1800, 0x800, "McBSP1 audio" },          /* CS3 */
+    { 0xe1012000, 0xfffb2000, 0x800, "MCSI2 communication" },   /* CS4 */
+    { 0xe1012800, 0xfffb2800, 0x800, "MCSI1 BT u-Law" },        /* CS5 */
+    { 0xe1013000, 0xfffb3000, 0x800, "uWire" },                 /* CS6 */
+    { 0xe1013800, 0xfffb3800, 0x800, "I^2C" },                  /* CS7 */
+    { 0xe1014000, 0xfffb4000, 0x800, "USB W2FC" },              /* CS8 */
+    { 0xe1014800, 0xfffb4800, 0x800, "RTC" },                   /* CS9 */
+    { 0xe1015000, 0xfffb5000, 0x800, "MPUIO" },                 /* CS10 */
+    { 0xe1015800, 0xfffb5800, 0x800, "PWL" },                   /* CS11 */
+    { 0xe1016000, 0xfffb6000, 0x800, "PWT" },                   /* CS12 */
+    { 0xe1017000, 0xfffb7000, 0x800, "McBSP3" },                /* CS14 */
+    { 0xe1017800, 0xfffb7800, 0x800, "MMC" },                   /* CS15 */
+    { 0xe1019000, 0xfffb9000, 0x800, "32-kHz timer" },          /* CS18 */
+    { 0xe1019800, 0xfffb9800, 0x800, "UART3" },                 /* CS19 */
+    { 0xe101c800, 0xfffbc800, 0x800, "TIPB switches" },         /* CS25 */
     /* Strobe 1 */
-    { 0xe101e000, 0xfffce000, 0x800, "GPIOs" },			/* CS28 */
+    { 0xe101e000, 0xfffce000, 0x800, "GPIOs" },                 /* CS28 */
 
     { 0 }
 };
@@ -4025,18 +4025,18 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *dram,
                               0xfffbd800, omap_findclk(s, "clk32-kHz"));
 
     /* Register mappings not currently implemented:
-     * MCSI2 Comm	fffb2000 - fffb27ff (not mapped on OMAP310)
-     * MCSI1 Bluetooth	fffb2800 - fffb2fff (not mapped on OMAP310)
-     * USB W2FC		fffb4000 - fffb47ff
-     * Camera Interface	fffb6800 - fffb6fff
-     * USB Host		fffba000 - fffba7ff
-     * FAC		fffba800 - fffbafff
-     * HDQ/1-Wire	fffbc000 - fffbc7ff
-     * TIPB switches	fffbc800 - fffbcfff
-     * Mailbox		fffcf000 - fffcf7ff
-     * Local bus IF	fffec100 - fffec1ff
-     * Local bus MMU	fffec200 - fffec2ff
-     * DSP MMU		fffed200 - fffed2ff
+     * MCSI2 Comm       fffb2000 - fffb27ff (not mapped on OMAP310)
+     * MCSI1 Bluetooth  fffb2800 - fffb2fff (not mapped on OMAP310)
+     * USB W2FC         fffb4000 - fffb47ff
+     * Camera Interface fffb6800 - fffb6fff
+     * USB Host         fffba000 - fffba7ff
+     * FAC              fffba800 - fffbafff
+     * HDQ/1-Wire       fffbc000 - fffbc7ff
+     * TIPB switches    fffbc800 - fffbcfff
+     * Mailbox          fffcf000 - fffcf7ff
+     * Local bus IF     fffec100 - fffec1ff
+     * Local bus MMU    fffec200 - fffec2ff
+     * DSP MMU          fffed200 - fffed2ff
      */
 
     omap_setup_dsp_mapping(system_memory, omap15xx_dsp_mm);
diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index 1d89a202bb9..5d4a31b7aed 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -1,7 +1,7 @@
 /* omap_sx1.c Support for the Siemens SX1 smartphone emulation.
  *
  *   Copyright (C) 2008
- * 	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
+ *   Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
  *   Copyright (C) 2007 Vladimir Ananiev <vovan888@gmail.com>
  *
  *   based on PalmOne's (TM) PDAs support (palm.c)
diff --git a/hw/dma/omap_dma.c b/hw/dma/omap_dma.c
index 9a8c3c34a07..101f91f4a33 100644
--- a/hw/dma/omap_dma.c
+++ b/hw/dma/omap_dma.c
@@ -131,9 +131,9 @@ struct omap_dma_s {
 #define LAST_FRAME_INTR (1 << 4)
 #define END_BLOCK_INTR  (1 << 5)
 #define SYNC            (1 << 6)
-#define END_PKT_INTR	(1 << 7)
-#define TRANS_ERR_INTR	(1 << 8)
-#define MISALIGN_INTR	(1 << 11)
+#define END_PKT_INTR    (1 << 7)
+#define TRANS_ERR_INTR  (1 << 8)
+#define MISALIGN_INTR   (1 << 11)
 
 static inline void omap_dma_interrupts_update(struct omap_dma_s *s)
 {
@@ -526,12 +526,12 @@ static void omap_dma_transfer_setup(struct soc_dma_ch_s *dma)
 
     /* Check all the conditions that terminate the transfer starting
      * with those that can occur the soonest.  */
-#define INTR_CHECK(cond, id, nelements)	\
-    if (cond) {			\
-        elements[id] = nelements;	\
-        if (elements[id] < min_elems)	\
-            min_elems = elements[id];	\
-    } else				\
+#define INTR_CHECK(cond, id, nelements) \
+    if (cond) {         \
+        elements[id] = nelements;   \
+        if (elements[id] < min_elems)   \
+            min_elems = elements[id];   \
+    } else              \
         elements[id] = INT_MAX;
 
     /* Elements */
@@ -740,7 +740,7 @@ static int omap_dma_ch_reg_read(struct omap_dma_s *s,
                 struct omap_dma_channel_s *ch, int reg, uint16_t *value)
 {
     switch (reg) {
-    case 0x00:	/* SYS_DMA_CSDP_CH0 */
+    case 0x00:  /* SYS_DMA_CSDP_CH0 */
         *value = (ch->burst[1] << 14) |
                 (ch->pack[1] << 13) |
                 (ch->port[1] << 9) |
@@ -750,9 +750,9 @@ static int omap_dma_ch_reg_read(struct omap_dma_s *s,
                 (ch->data_type >> 1);
         break;
 
-    case 0x02:	/* SYS_DMA_CCR_CH0 */
+    case 0x02:  /* SYS_DMA_CCR_CH0 */
         if (s->model <= omap_dma_3_1)
-            *value = 0 << 10;			/* FIFO_FLUSH reads as 0 */
+            *value = 0 << 10;           /* FIFO_FLUSH reads as 0 */
         else
             *value = ch->omap_3_1_compatible_disable << 10;
         *value |= (ch->mode[1] << 14) |
@@ -765,11 +765,11 @@ static int omap_dma_ch_reg_read(struct omap_dma_s *s,
                 (ch->fs << 5) | ch->sync;
         break;
 
-    case 0x04:	/* SYS_DMA_CICR_CH0 */
+    case 0x04:  /* SYS_DMA_CICR_CH0 */
         *value = ch->interrupts;
         break;
 
-    case 0x06:	/* SYS_DMA_CSR_CH0 */
+    case 0x06:  /* SYS_DMA_CSR_CH0 */
         *value = ch->status;
         ch->status &= SYNC;
         if (!ch->omap_3_1_compatible_disable && ch->sibling) {
@@ -779,77 +779,77 @@ static int omap_dma_ch_reg_read(struct omap_dma_s *s,
         qemu_irq_lower(ch->irq);
         break;
 
-    case 0x08:	/* SYS_DMA_CSSA_L_CH0 */
+    case 0x08:  /* SYS_DMA_CSSA_L_CH0 */
         *value = ch->addr[0] & 0x0000ffff;
         break;
 
-    case 0x0a:	/* SYS_DMA_CSSA_U_CH0 */
+    case 0x0a:  /* SYS_DMA_CSSA_U_CH0 */
         *value = ch->addr[0] >> 16;
         break;
 
-    case 0x0c:	/* SYS_DMA_CDSA_L_CH0 */
+    case 0x0c:  /* SYS_DMA_CDSA_L_CH0 */
         *value = ch->addr[1] & 0x0000ffff;
         break;
 
-    case 0x0e:	/* SYS_DMA_CDSA_U_CH0 */
+    case 0x0e:  /* SYS_DMA_CDSA_U_CH0 */
         *value = ch->addr[1] >> 16;
         break;
 
-    case 0x10:	/* SYS_DMA_CEN_CH0 */
+    case 0x10:  /* SYS_DMA_CEN_CH0 */
         *value = ch->elements;
         break;
 
-    case 0x12:	/* SYS_DMA_CFN_CH0 */
+    case 0x12:  /* SYS_DMA_CFN_CH0 */
         *value = ch->frames;
         break;
 
-    case 0x14:	/* SYS_DMA_CFI_CH0 */
+    case 0x14:  /* SYS_DMA_CFI_CH0 */
         *value = ch->frame_index[0];
         break;
 
-    case 0x16:	/* SYS_DMA_CEI_CH0 */
+    case 0x16:  /* SYS_DMA_CEI_CH0 */
         *value = ch->element_index[0];
         break;
 
-    case 0x18:	/* SYS_DMA_CPC_CH0 or DMA_CSAC */
+    case 0x18:  /* SYS_DMA_CPC_CH0 or DMA_CSAC */
         if (ch->omap_3_1_compatible_disable)
-            *value = ch->active_set.src & 0xffff;	/* CSAC */
+            *value = ch->active_set.src & 0xffff;   /* CSAC */
         else
             *value = ch->cpc;
         break;
 
-    case 0x1a:	/* DMA_CDAC */
-        *value = ch->active_set.dest & 0xffff;	/* CDAC */
+    case 0x1a:  /* DMA_CDAC */
+        *value = ch->active_set.dest & 0xffff;  /* CDAC */
         break;
 
-    case 0x1c:	/* DMA_CDEI */
+    case 0x1c:  /* DMA_CDEI */
         *value = ch->element_index[1];
         break;
 
-    case 0x1e:	/* DMA_CDFI */
+    case 0x1e:  /* DMA_CDFI */
         *value = ch->frame_index[1];
         break;
 
-    case 0x20:	/* DMA_COLOR_L */
+    case 0x20:  /* DMA_COLOR_L */
         *value = ch->color & 0xffff;
         break;
 
-    case 0x22:	/* DMA_COLOR_U */
+    case 0x22:  /* DMA_COLOR_U */
         *value = ch->color >> 16;
         break;
 
-    case 0x24:	/* DMA_CCR2 */
+    case 0x24:  /* DMA_CCR2 */
         *value = (ch->bs << 2) |
                 (ch->transparent_copy << 1) |
                 ch->constant_fill;
         break;
 
-    case 0x28:	/* DMA_CLNK_CTRL */
+    case 0x28:  /* DMA_CLNK_CTRL */
         *value = (ch->link_enabled << 15) |
                 (ch->link_next_ch & 0xf);
         break;
 
-    case 0x2a:	/* DMA_LCH_CTRL */
+    case 0x2a:  /* DMA_LCH_CTRL */
         *value = (ch->interleave_disabled << 15) |
                 ch->type;
         break;
@@ -864,7 +864,7 @@ static int omap_dma_ch_reg_write(struct omap_dma_s *s,
                 struct omap_dma_channel_s *ch, int reg, uint16_t value)
 {
     switch (reg) {
-    case 0x00:	/* SYS_DMA_CSDP_CH0 */
+    case 0x00:  /* SYS_DMA_CSDP_CH0 */
         ch->burst[1] = (value & 0xc000) >> 14;
         ch->pack[1] = (value & 0x2000) >> 13;
         ch->port[1] = (enum omap_dma_port) ((value & 0x1e00) >> 9);
@@ -887,7 +887,7 @@ static int omap_dma_ch_reg_write(struct omap_dma_s *s,
         }
         break;
 
-    case 0x02:	/* SYS_DMA_CCR_CH0 */
+    case 0x02:  /* SYS_DMA_CCR_CH0 */
         ch->mode[1] = (omap_dma_addressing_t) ((value & 0xc000) >> 14);
         ch->mode[0] = (omap_dma_addressing_t) ((value & 0x3000) >> 12);
         ch->end_prog = (value & 0x0800) >> 11;
@@ -909,88 +909,88 @@ static int omap_dma_ch_reg_write(struct omap_dma_s *s,
 
         break;
 
-    case 0x04:	/* SYS_DMA_CICR_CH0 */
+    case 0x04:  /* SYS_DMA_CICR_CH0 */
         ch->interrupts = value & 0x3f;
         break;
 
-    case 0x06:	/* SYS_DMA_CSR_CH0 */
+    case 0x06:  /* SYS_DMA_CSR_CH0 */
         OMAP_RO_REG((hwaddr) reg);
         break;
 
-    case 0x08:	/* SYS_DMA_CSSA_L_CH0 */
+    case 0x08:  /* SYS_DMA_CSSA_L_CH0 */
         ch->addr[0] &= 0xffff0000;
         ch->addr[0] |= value;
         break;
 
-    case 0x0a:	/* SYS_DMA_CSSA_U_CH0 */
+    case 0x0a:  /* SYS_DMA_CSSA_U_CH0 */
         ch->addr[0] &= 0x0000ffff;
         ch->addr[0] |= (uint32_t) value << 16;
         break;
 
-    case 0x0c:	/* SYS_DMA_CDSA_L_CH0 */
+    case 0x0c:  /* SYS_DMA_CDSA_L_CH0 */
         ch->addr[1] &= 0xffff0000;
         ch->addr[1] |= value;
         break;
 
-    case 0x0e:	/* SYS_DMA_CDSA_U_CH0 */
+    case 0x0e:  /* SYS_DMA_CDSA_U_CH0 */
         ch->addr[1] &= 0x0000ffff;
         ch->addr[1] |= (uint32_t) value << 16;
         break;
 
-    case 0x10:	/* SYS_DMA_CEN_CH0 */
+    case 0x10:  /* SYS_DMA_CEN_CH0 */
         ch->elements = value;
         break;
 
-    case 0x12:	/* SYS_DMA_CFN_CH0 */
+    case 0x12:  /* SYS_DMA_CFN_CH0 */
         ch->frames = value;
         break;
 
-    case 0x14:	/* SYS_DMA_CFI_CH0 */
+    case 0x14:  /* SYS_DMA_CFI_CH0 */
         ch->frame_index[0] = (int16_t) value;
         break;
 
-    case 0x16:	/* SYS_DMA_CEI_CH0 */
+    case 0x16:  /* SYS_DMA_CEI_CH0 */
         ch->element_index[0] = (int16_t) value;
         break;
 
-    case 0x18:	/* SYS_DMA_CPC_CH0 or DMA_CSAC */
+    case 0x18:  /* SYS_DMA_CPC_CH0 or DMA_CSAC */
         OMAP_RO_REG((hwaddr) reg);
         break;
 
-    case 0x1c:	/* DMA_CDEI */
+    case 0x1c:  /* DMA_CDEI */
         ch->element_index[1] = (int16_t) value;
         break;
 
-    case 0x1e:	/* DMA_CDFI */
+    case 0x1e:  /* DMA_CDFI */
         ch->frame_index[1] = (int16_t) value;
         break;
 
-    case 0x20:	/* DMA_COLOR_L */
+    case 0x20:  /* DMA_COLOR_L */
         ch->color &= 0xffff0000;
         ch->color |= value;
         break;
 
-    case 0x22:	/* DMA_COLOR_U */
+    case 0x22:  /* DMA_COLOR_U */
         ch->color &= 0xffff;
         ch->color |= (uint32_t)value << 16;
         break;
 
-    case 0x24:	/* DMA_CCR2 */
+    case 0x24:  /* DMA_CCR2 */
         ch->bs = (value >> 2) & 0x1;
         ch->transparent_copy = (value >> 1) & 0x1;
         ch->constant_fill = value & 0x1;
         break;
 
-    case 0x28:	/* DMA_CLNK_CTRL */
+    case 0x28:  /* DMA_CLNK_CTRL */
         ch->link_enabled = (value >> 15) & 0x1;
-        if (value & (1 << 14)) {			/* Stop_Lnk */
+        if (value & (1 << 14)) {            /* Stop_Lnk */
             ch->link_enabled = 0;
             omap_dma_disable_channel(s, ch);
         }
         ch->link_next_ch = value & 0x1f;
         break;
 
-    case 0x2a:	/* DMA_LCH_CTRL */
+    case 0x2a:  /* DMA_LCH_CTRL */
         ch->interleave_disabled = (value >> 15) & 0x1;
         ch->type = value & 0xf;
         break;
@@ -1005,7 +1005,7 @@ static int omap_dma_3_2_lcd_write(struct omap_dma_lcd_channel_s *s, int offset,
                 uint16_t value)
 {
     switch (offset) {
-    case 0xbc0:	/* DMA_LCD_CSDP */
+    case 0xbc0: /* DMA_LCD_CSDP */
         s->brust_f2 = (value >> 14) & 0x3;
         s->pack_f2 = (value >> 13) & 0x1;
         s->data_type_f2 = (1 << ((value >> 11) & 0x3));
@@ -1014,7 +1014,7 @@ static int omap_dma_3_2_lcd_write(struct omap_dma_lcd_channel_s *s, int offset,
         s->data_type_f1 = (1 << ((value >> 0) & 0x3));
         break;
 
-    case 0xbc2:	/* DMA_LCD_CCR */
+    case 0xbc2: /* DMA_LCD_CCR */
         s->mode_f2 = (value >> 14) & 0x3;
         s->mode_f1 = (value >> 12) & 0x3;
         s->end_prog = (value >> 11) & 0x1;
@@ -1026,7 +1026,7 @@ static int omap_dma_3_2_lcd_write(struct omap_dma_lcd_channel_s *s, int offset,
         s->bs = (value >> 4) & 0x1;
         break;
 
-    case 0xbc4:	/* DMA_LCD_CTRL */
+    case 0xbc4: /* DMA_LCD_CTRL */
         s->dst = (value >> 8) & 0x1;
         s->src = ((value >> 6) & 0x3) << 1;
         s->condition = 0;
@@ -1035,91 +1035,91 @@ static int omap_dma_3_2_lcd_write(struct omap_dma_lcd_channel_s *s, int offset,
         s->dual = value & 1;
         break;
 
-    case 0xbc8:	/* TOP_B1_L */
+    case 0xbc8: /* TOP_B1_L */
         s->src_f1_top &= 0xffff0000;
         s->src_f1_top |= 0x0000ffff & value;
         break;
 
-    case 0xbca:	/* TOP_B1_U */
+    case 0xbca: /* TOP_B1_U */
         s->src_f1_top &= 0x0000ffff;
         s->src_f1_top |= (uint32_t)value << 16;
         break;
 
-    case 0xbcc:	/* BOT_B1_L */
+    case 0xbcc: /* BOT_B1_L */
         s->src_f1_bottom &= 0xffff0000;
         s->src_f1_bottom |= 0x0000ffff & value;
         break;
 
-    case 0xbce:	/* BOT_B1_U */
+    case 0xbce: /* BOT_B1_U */
         s->src_f1_bottom &= 0x0000ffff;
         s->src_f1_bottom |= (uint32_t) value << 16;
         break;
 
-    case 0xbd0:	/* TOP_B2_L */
+    case 0xbd0: /* TOP_B2_L */
         s->src_f2_top &= 0xffff0000;
         s->src_f2_top |= 0x0000ffff & value;
         break;
 
-    case 0xbd2:	/* TOP_B2_U */
+    case 0xbd2: /* TOP_B2_U */
         s->src_f2_top &= 0x0000ffff;
         s->src_f2_top |= (uint32_t) value << 16;
         break;
 
-    case 0xbd4:	/* BOT_B2_L */
+    case 0xbd4: /* BOT_B2_L */
         s->src_f2_bottom &= 0xffff0000;
         s->src_f2_bottom |= 0x0000ffff & value;
         break;
 
-    case 0xbd6:	/* BOT_B2_U */
+    case 0xbd6: /* BOT_B2_U */
         s->src_f2_bottom &= 0x0000ffff;
         s->src_f2_bottom |= (uint32_t) value << 16;
         break;
 
-    case 0xbd8:	/* DMA_LCD_SRC_EI_B1 */
+    case 0xbd8: /* DMA_LCD_SRC_EI_B1 */
         s->element_index_f1 = value;
         break;
 
-    case 0xbda:	/* DMA_LCD_SRC_FI_B1_L */
+    case 0xbda: /* DMA_LCD_SRC_FI_B1_L */
         s->frame_index_f1 &= 0xffff0000;
         s->frame_index_f1 |= 0x0000ffff & value;
         break;
 
-    case 0xbf4:	/* DMA_LCD_SRC_FI_B1_U */
+    case 0xbf4: /* DMA_LCD_SRC_FI_B1_U */
         s->frame_index_f1 &= 0x0000ffff;
         s->frame_index_f1 |= (uint32_t) value << 16;
         break;
 
-    case 0xbdc:	/* DMA_LCD_SRC_EI_B2 */
+    case 0xbdc: /* DMA_LCD_SRC_EI_B2 */
         s->element_index_f2 = value;
         break;
 
-    case 0xbde:	/* DMA_LCD_SRC_FI_B2_L */
+    case 0xbde: /* DMA_LCD_SRC_FI_B2_L */
         s->frame_index_f2 &= 0xffff0000;
         s->frame_index_f2 |= 0x0000ffff & value;
         break;
 
-    case 0xbf6:	/* DMA_LCD_SRC_FI_B2_U */
+    case 0xbf6: /* DMA_LCD_SRC_FI_B2_U */
         s->frame_index_f2 &= 0x0000ffff;
         s->frame_index_f2 |= (uint32_t) value << 16;
         break;
 
-    case 0xbe0:	/* DMA_LCD_SRC_EN_B1 */
+    case 0xbe0: /* DMA_LCD_SRC_EN_B1 */
         s->elements_f1 = value;
         break;
 
-    case 0xbe4:	/* DMA_LCD_SRC_FN_B1 */
+    case 0xbe4: /* DMA_LCD_SRC_FN_B1 */
         s->frames_f1 = value;
         break;
 
-    case 0xbe2:	/* DMA_LCD_SRC_EN_B2 */
+    case 0xbe2: /* DMA_LCD_SRC_EN_B2 */
         s->elements_f2 = value;
         break;
 
-    case 0xbe6:	/* DMA_LCD_SRC_FN_B2 */
+    case 0xbe6: /* DMA_LCD_SRC_FN_B2 */
         s->frames_f2 = value;
         break;
 
-    case 0xbea:	/* DMA_LCD_LCH_CTRL */
+    case 0xbea: /* DMA_LCD_LCH_CTRL */
         s->lch_type = value & 0xf;
         break;
 
@@ -1133,7 +1133,7 @@ static int omap_dma_3_2_lcd_read(struct omap_dma_lcd_channel_s *s, int offset,
                 uint16_t *ret)
 {
     switch (offset) {
-    case 0xbc0:	/* DMA_LCD_CSDP */
+    case 0xbc0: /* DMA_LCD_CSDP */
         *ret = (s->brust_f2 << 14) |
             (s->pack_f2 << 13) |
             ((s->data_type_f2 >> 1) << 11) |
@@ -1142,7 +1142,7 @@ static int omap_dma_3_2_lcd_read(struct omap_dma_lcd_channel_s *s, int offset,
             ((s->data_type_f1 >> 1) << 0);
         break;
 
-    case 0xbc2:	/* DMA_LCD_CCR */
+    case 0xbc2: /* DMA_LCD_CCR */
         *ret = (s->mode_f2 << 14) |
             (s->mode_f1 << 12) |
             (s->end_prog << 11) |
@@ -1154,7 +1154,7 @@ static int omap_dma_3_2_lcd_read(struct omap_dma_lcd_channel_s *s, int offset,
             (s->bs << 4);
         break;
 
-    case 0xbc4:	/* DMA_LCD_CTRL */
+    case 0xbc4: /* DMA_LCD_CTRL */
         qemu_irq_lower(s->irq);
         *ret = (s->dst << 8) |
             ((s->src & 0x6) << 5) |
@@ -1163,79 +1163,79 @@ static int omap_dma_3_2_lcd_read(struct omap_dma_lcd_channel_s *s, int offset,
             s->dual;
         break;
 
-    case 0xbc8:	/* TOP_B1_L */
+    case 0xbc8: /* TOP_B1_L */
         *ret = s->src_f1_top & 0xffff;
         break;
 
-    case 0xbca:	/* TOP_B1_U */
+    case 0xbca: /* TOP_B1_U */
         *ret = s->src_f1_top >> 16;
         break;
 
-    case 0xbcc:	/* BOT_B1_L */
+    case 0xbcc: /* BOT_B1_L */
         *ret = s->src_f1_bottom & 0xffff;
         break;
 
-    case 0xbce:	/* BOT_B1_U */
+    case 0xbce: /* BOT_B1_U */
         *ret = s->src_f1_bottom >> 16;
         break;
 
-    case 0xbd0:	/* TOP_B2_L */
+    case 0xbd0: /* TOP_B2_L */
         *ret = s->src_f2_top & 0xffff;
         break;
 
-    case 0xbd2:	/* TOP_B2_U */
+    case 0xbd2: /* TOP_B2_U */
         *ret = s->src_f2_top >> 16;
         break;
 
-    case 0xbd4:	/* BOT_B2_L */
+    case 0xbd4: /* BOT_B2_L */
         *ret = s->src_f2_bottom & 0xffff;
         break;
 
-    case 0xbd6:	/* BOT_B2_U */
+    case 0xbd6: /* BOT_B2_U */
         *ret = s->src_f2_bottom >> 16;
         break;
 
-    case 0xbd8:	/* DMA_LCD_SRC_EI_B1 */
+    case 0xbd8: /* DMA_LCD_SRC_EI_B1 */
         *ret = s->element_index_f1;
         break;
 
-    case 0xbda:	/* DMA_LCD_SRC_FI_B1_L */
+    case 0xbda: /* DMA_LCD_SRC_FI_B1_L */
         *ret = s->frame_index_f1 & 0xffff;
         break;
 
-    case 0xbf4:	/* DMA_LCD_SRC_FI_B1_U */
+    case 0xbf4: /* DMA_LCD_SRC_FI_B1_U */
         *ret = s->frame_index_f1 >> 16;
         break;
 
-    case 0xbdc:	/* DMA_LCD_SRC_EI_B2 */
+    case 0xbdc: /* DMA_LCD_SRC_EI_B2 */
         *ret = s->element_index_f2;
         break;
 
-    case 0xbde:	/* DMA_LCD_SRC_FI_B2_L */
+    case 0xbde: /* DMA_LCD_SRC_FI_B2_L */
         *ret = s->frame_index_f2 & 0xffff;
         break;
 
-    case 0xbf6:	/* DMA_LCD_SRC_FI_B2_U */
+    case 0xbf6: /* DMA_LCD_SRC_FI_B2_U */
         *ret = s->frame_index_f2 >> 16;
         break;
 
-    case 0xbe0:	/* DMA_LCD_SRC_EN_B1 */
+    case 0xbe0: /* DMA_LCD_SRC_EN_B1 */
         *ret = s->elements_f1;
         break;
 
-    case 0xbe4:	/* DMA_LCD_SRC_FN_B1 */
+    case 0xbe4: /* DMA_LCD_SRC_FN_B1 */
         *ret = s->frames_f1;
         break;
 
-    case 0xbe2:	/* DMA_LCD_SRC_EN_B2 */
+    case 0xbe2: /* DMA_LCD_SRC_EN_B2 */
         *ret = s->elements_f2;
         break;
 
-    case 0xbe6:	/* DMA_LCD_SRC_FN_B2 */
+    case 0xbe6: /* DMA_LCD_SRC_FN_B2 */
         *ret = s->frames_f2;
         break;
 
-    case 0xbea:	/* DMA_LCD_LCH_CTRL */
+    case 0xbea: /* DMA_LCD_LCH_CTRL */
         *ret = s->lch_type;
         break;
 
@@ -1249,7 +1249,7 @@ static int omap_dma_3_1_lcd_write(struct omap_dma_lcd_channel_s *s, int offset,
                 uint16_t value)
 {
     switch (offset) {
-    case 0x300:	/* SYS_DMA_LCD_CTRL */
+    case 0x300: /* SYS_DMA_LCD_CTRL */
         s->src = (value & 0x40) ? imif : emiff;
         s->condition = 0;
         /* Assume no bus errors and thus no BUS_ERROR irq bits.  */
@@ -1257,42 +1257,42 @@ static int omap_dma_3_1_lcd_write(struct omap_dma_lcd_channel_s *s, int offset,
         s->dual = value & 1;
         break;
 
-    case 0x302:	/* SYS_DMA_LCD_TOP_F1_L */
+    case 0x302: /* SYS_DMA_LCD_TOP_F1_L */
         s->src_f1_top &= 0xffff0000;
         s->src_f1_top |= 0x0000ffff & value;
         break;
 
-    case 0x304:	/* SYS_DMA_LCD_TOP_F1_U */
+    case 0x304: /* SYS_DMA_LCD_TOP_F1_U */
         s->src_f1_top &= 0x0000ffff;
         s->src_f1_top |= (uint32_t)value << 16;
         break;
 
-    case 0x306:	/* SYS_DMA_LCD_BOT_F1_L */
+    case 0x306: /* SYS_DMA_LCD_BOT_F1_L */
         s->src_f1_bottom &= 0xffff0000;
         s->src_f1_bottom |= 0x0000ffff & value;
         break;
 
-    case 0x308:	/* SYS_DMA_LCD_BOT_F1_U */
+    case 0x308: /* SYS_DMA_LCD_BOT_F1_U */
         s->src_f1_bottom &= 0x0000ffff;
         s->src_f1_bottom |= (uint32_t)value << 16;
         break;
 
-    case 0x30a:	/* SYS_DMA_LCD_TOP_F2_L */
+    case 0x30a: /* SYS_DMA_LCD_TOP_F2_L */
         s->src_f2_top &= 0xffff0000;
         s->src_f2_top |= 0x0000ffff & value;
         break;
 
-    case 0x30c:	/* SYS_DMA_LCD_TOP_F2_U */
+    case 0x30c: /* SYS_DMA_LCD_TOP_F2_U */
         s->src_f2_top &= 0x0000ffff;
         s->src_f2_top |= (uint32_t)value << 16;
         break;
 
-    case 0x30e:	/* SYS_DMA_LCD_BOT_F2_L */
+    case 0x30e: /* SYS_DMA_LCD_BOT_F2_L */
         s->src_f2_bottom &= 0xffff0000;
         s->src_f2_bottom |= 0x0000ffff & value;
         break;
 
-    case 0x310:	/* SYS_DMA_LCD_BOT_F2_U */
+    case 0x310: /* SYS_DMA_LCD_BOT_F2_U */
         s->src_f2_bottom &= 0x0000ffff;
         s->src_f2_bottom |= (uint32_t)value << 16;
         break;
@@ -1309,7 +1309,7 @@ static int omap_dma_3_1_lcd_read(struct omap_dma_lcd_channel_s *s, int offset,
     int i;
 
     switch (offset) {
-    case 0x300:	/* SYS_DMA_LCD_CTRL */
+    case 0x300: /* SYS_DMA_LCD_CTRL */
         i = s->condition;
         s->condition = 0;
         qemu_irq_lower(s->irq);
@@ -1317,35 +1317,35 @@ static int omap_dma_3_1_lcd_read(struct omap_dma_lcd_channel_s *s, int offset,
                 (s->interrupts << 1) | s->dual;
         break;
 
-    case 0x302:	/* SYS_DMA_LCD_TOP_F1_L */
+    case 0x302: /* SYS_DMA_LCD_TOP_F1_L */
         *ret = s->src_f1_top & 0xffff;
         break;
 
-    case 0x304:	/* SYS_DMA_LCD_TOP_F1_U */
+    case 0x304: /* SYS_DMA_LCD_TOP_F1_U */
         *ret = s->src_f1_top >> 16;
         break;
 
-    case 0x306:	/* SYS_DMA_LCD_BOT_F1_L */
+    case 0x306: /* SYS_DMA_LCD_BOT_F1_L */
         *ret = s->src_f1_bottom & 0xffff;
         break;
 
-    case 0x308:	/* SYS_DMA_LCD_BOT_F1_U */
+    case 0x308: /* SYS_DMA_LCD_BOT_F1_U */
         *ret = s->src_f1_bottom >> 16;
         break;
 
-    case 0x30a:	/* SYS_DMA_LCD_TOP_F2_L */
+    case 0x30a: /* SYS_DMA_LCD_TOP_F2_L */
         *ret = s->src_f2_top & 0xffff;
         break;
 
-    case 0x30c:	/* SYS_DMA_LCD_TOP_F2_U */
+    case 0x30c: /* SYS_DMA_LCD_TOP_F2_U */
         *ret = s->src_f2_top >> 16;
         break;
 
-    case 0x30e:	/* SYS_DMA_LCD_BOT_F2_L */
+    case 0x30e: /* SYS_DMA_LCD_BOT_F2_L */
         *ret = s->src_f2_bottom & 0xffff;
         break;
 
-    case 0x310:	/* SYS_DMA_LCD_BOT_F2_U */
+    case 0x310: /* SYS_DMA_LCD_BOT_F2_U */
         *ret = s->src_f2_bottom >> 16;
         break;
 
@@ -1358,18 +1358,18 @@ static int omap_dma_3_1_lcd_read(struct omap_dma_lcd_channel_s *s, int offset,
 static int omap_dma_sys_write(struct omap_dma_s *s, int offset, uint16_t value)
 {
     switch (offset) {
-    case 0x400:	/* SYS_DMA_GCR */
+    case 0x400: /* SYS_DMA_GCR */
         s->gcr = value;
         break;
 
-    case 0x404:	/* DMA_GSCR */
+    case 0x404: /* DMA_GSCR */
         if (value & 0x8)
             omap_dma_disable_3_1_mapping(s);
         else
             omap_dma_enable_3_1_mapping(s);
         break;
 
-    case 0x408:	/* DMA_GRST */
+    case 0x408: /* DMA_GRST */
         if (value & 0x1)
             omap_dma_reset(s->dma);
         break;
@@ -1384,57 +1384,57 @@ static int omap_dma_sys_read(struct omap_dma_s *s, int offset,
                 uint16_t *ret)
 {
     switch (offset) {
-    case 0x400:	/* SYS_DMA_GCR */
+    case 0x400: /* SYS_DMA_GCR */
         *ret = s->gcr;
         break;
 
-    case 0x404:	/* DMA_GSCR */
+    case 0x404: /* DMA_GSCR */
         *ret = s->omap_3_1_mapping_disabled << 3;
         break;
 
-    case 0x408:	/* DMA_GRST */
+    case 0x408: /* DMA_GRST */
         *ret = 0;
         break;
 
-    case 0x442:	/* DMA_HW_ID */
-    case 0x444:	/* DMA_PCh2_ID */
-    case 0x446:	/* DMA_PCh0_ID */
-    case 0x448:	/* DMA_PCh1_ID */
-    case 0x44a:	/* DMA_PChG_ID */
-    case 0x44c:	/* DMA_PChD_ID */
+    case 0x442: /* DMA_HW_ID */
+    case 0x444: /* DMA_PCh2_ID */
+    case 0x446: /* DMA_PCh0_ID */
+    case 0x448: /* DMA_PCh1_ID */
+    case 0x44a: /* DMA_PChG_ID */
+    case 0x44c: /* DMA_PChD_ID */
         *ret = 1;
         break;
 
-    case 0x44e:	/* DMA_CAPS_0_U */
+    case 0x44e: /* DMA_CAPS_0_U */
         *ret = (s->caps[0] >> 16) & 0xffff;
         break;
-    case 0x450:	/* DMA_CAPS_0_L */
+    case 0x450: /* DMA_CAPS_0_L */
         *ret = (s->caps[0] >>  0) & 0xffff;
         break;
 
-    case 0x452:	/* DMA_CAPS_1_U */
+    case 0x452: /* DMA_CAPS_1_U */
         *ret = (s->caps[1] >> 16) & 0xffff;
         break;
-    case 0x454:	/* DMA_CAPS_1_L */
+    case 0x454: /* DMA_CAPS_1_L */
         *ret = (s->caps[1] >>  0) & 0xffff;
         break;
 
-    case 0x456:	/* DMA_CAPS_2 */
+    case 0x456: /* DMA_CAPS_2 */
         *ret = s->caps[2];
         break;
 
-    case 0x458:	/* DMA_CAPS_3 */
+    case 0x458: /* DMA_CAPS_3 */
         *ret = s->caps[3];
         break;
 
-    case 0x45a:	/* DMA_CAPS_4 */
+    case 0x45a: /* DMA_CAPS_4 */
         *ret = s->caps[4];
         break;
 
-    case 0x460:	/* DMA_PCh2_SR */
-    case 0x480:	/* DMA_PCh0_SR */
-    case 0x482:	/* DMA_PCh1_SR */
-    case 0x4c0:	/* DMA_PChD_SR_0 */
+    case 0x460: /* DMA_PCh2_SR */
+    case 0x480: /* DMA_PCh0_SR */
+    case 0x482: /* DMA_PCh1_SR */
+    case 0x4c0: /* DMA_PChD_SR_0 */
         qemu_log_mask(LOG_UNIMP,
                       "%s: Physical Channel Status Registers not implemented\n",
                       __func__);
@@ -1582,38 +1582,38 @@ static void omap_dma_setcaps(struct omap_dma_s *s)
     case omap_dma_3_2:
         /* XXX Only available for sDMA */
         s->caps[0] =
-                (1 << 19) |	/* Constant Fill Capability */
-                (1 << 18);	/* Transparent BLT Capability */
+                (1 << 19) | /* Constant Fill Capability */
+                (1 << 18);  /* Transparent BLT Capability */
         s->caps[1] =
-                (1 << 1);	/* 1-bit palettized capability (DMA 3.2 only) */
+                (1 << 1);   /* 1-bit palettized capability (DMA 3.2 only) */
         s->caps[2] =
-                (1 << 8) |	/* SEPARATE_SRC_AND_DST_INDEX_CPBLTY */
-                (1 << 7) |	/* DST_DOUBLE_INDEX_ADRS_CPBLTY */
-                (1 << 6) |	/* DST_SINGLE_INDEX_ADRS_CPBLTY */
-                (1 << 5) |	/* DST_POST_INCRMNT_ADRS_CPBLTY */
-                (1 << 4) |	/* DST_CONST_ADRS_CPBLTY */
-                (1 << 3) |	/* SRC_DOUBLE_INDEX_ADRS_CPBLTY */
-                (1 << 2) |	/* SRC_SINGLE_INDEX_ADRS_CPBLTY */
-                (1 << 1) |	/* SRC_POST_INCRMNT_ADRS_CPBLTY */
-                (1 << 0);	/* SRC_CONST_ADRS_CPBLTY */
+                (1 << 8) |  /* SEPARATE_SRC_AND_DST_INDEX_CPBLTY */
+                (1 << 7) |  /* DST_DOUBLE_INDEX_ADRS_CPBLTY */
+                (1 << 6) |  /* DST_SINGLE_INDEX_ADRS_CPBLTY */
+                (1 << 5) |  /* DST_POST_INCRMNT_ADRS_CPBLTY */
+                (1 << 4) |  /* DST_CONST_ADRS_CPBLTY */
+                (1 << 3) |  /* SRC_DOUBLE_INDEX_ADRS_CPBLTY */
+                (1 << 2) |  /* SRC_SINGLE_INDEX_ADRS_CPBLTY */
+                (1 << 1) |  /* SRC_POST_INCRMNT_ADRS_CPBLTY */
+                (1 << 0);   /* SRC_CONST_ADRS_CPBLTY */
         s->caps[3] =
-                (1 << 6) |	/* BLOCK_SYNCHR_CPBLTY (DMA 4 only) */
-                (1 << 7) |	/* PKT_SYNCHR_CPBLTY (DMA 4 only) */
-                (1 << 5) |	/* CHANNEL_CHAINING_CPBLTY */
-                (1 << 4) |	/* LCh_INTERLEAVE_CPBLTY */
-                (1 << 3) |	/* AUTOINIT_REPEAT_CPBLTY (DMA 3.2 only) */
-                (1 << 2) |	/* AUTOINIT_ENDPROG_CPBLTY (DMA 3.2 only) */
-                (1 << 1) |	/* FRAME_SYNCHR_CPBLTY */
-                (1 << 0);	/* ELMNT_SYNCHR_CPBLTY */
+                (1 << 6) |  /* BLOCK_SYNCHR_CPBLTY (DMA 4 only) */
+                (1 << 7) |  /* PKT_SYNCHR_CPBLTY (DMA 4 only) */
+                (1 << 5) |  /* CHANNEL_CHAINING_CPBLTY */
+                (1 << 4) |  /* LCh_INTERLEAVE_CPBLTY */
+                (1 << 3) |  /* AUTOINIT_REPEAT_CPBLTY (DMA 3.2 only) */
+                (1 << 2) |  /* AUTOINIT_ENDPROG_CPBLTY (DMA 3.2 only) */
+                (1 << 1) |  /* FRAME_SYNCHR_CPBLTY */
+                (1 << 0);   /* ELMNT_SYNCHR_CPBLTY */
         s->caps[4] =
-                (1 << 7) |	/* PKT_INTERRUPT_CPBLTY (DMA 4 only) */
-                (1 << 6) |	/* SYNC_STATUS_CPBLTY */
-                (1 << 5) |	/* BLOCK_INTERRUPT_CPBLTY */
-                (1 << 4) |	/* LAST_FRAME_INTERRUPT_CPBLTY */
-                (1 << 3) |	/* FRAME_INTERRUPT_CPBLTY */
-                (1 << 2) |	/* HALF_FRAME_INTERRUPT_CPBLTY */
-                (1 << 1) |	/* EVENT_DROP_INTERRUPT_CPBLTY */
-                (1 << 0);	/* TIMEOUT_INTERRUPT_CPBLTY (DMA 3.2 only) */
+                (1 << 7) |  /* PKT_INTERRUPT_CPBLTY (DMA 4 only) */
+                (1 << 6) |  /* SYNC_STATUS_CPBLTY */
+                (1 << 5) |  /* BLOCK_INTERRUPT_CPBLTY */
+                (1 << 4) |  /* LAST_FRAME_INTERRUPT_CPBLTY */
+                (1 << 3) |  /* FRAME_INTERRUPT_CPBLTY */
+                (1 << 2) |  /* HALF_FRAME_INTERRUPT_CPBLTY */
+                (1 << 1) |  /* EVENT_DROP_INTERRUPT_CPBLTY */
+                (1 << 0);   /* TIMEOUT_INTERRUPT_CPBLTY (DMA 3.2 only) */
         break;
     }
 }
diff --git a/hw/gpio/omap_gpio.c b/hw/gpio/omap_gpio.c
index 61ea7862afe..f27806b774a 100644
--- a/hw/gpio/omap_gpio.c
+++ b/hw/gpio/omap_gpio.c
@@ -80,25 +80,25 @@ static uint64_t omap_gpio_read(void *opaque, hwaddr addr,
     }
 
     switch (offset) {
-    case 0x00:	/* DATA_INPUT */
+    case 0x00:  /* DATA_INPUT */
         return s->inputs & s->pins;
 
-    case 0x04:	/* DATA_OUTPUT */
+    case 0x04:  /* DATA_OUTPUT */
         return s->outputs;
 
-    case 0x08:	/* DIRECTION_CONTROL */
+    case 0x08:  /* DIRECTION_CONTROL */
         return s->dir;
 
-    case 0x0c:	/* INTERRUPT_CONTROL */
+    case 0x0c:  /* INTERRUPT_CONTROL */
         return s->edge;
 
-    case 0x10:	/* INTERRUPT_MASK */
+    case 0x10:  /* INTERRUPT_MASK */
         return s->mask;
 
-    case 0x14:	/* INTERRUPT_STATUS */
+    case 0x14:  /* INTERRUPT_STATUS */
         return s->ints;
 
-    case 0x18:	/* PIN_CONTROL (not in OMAP310) */
+    case 0x18:  /* PIN_CONTROL (not in OMAP310) */
         OMAP_BAD_REG(addr);
         return s->pins;
     }
@@ -121,11 +121,11 @@ static void omap_gpio_write(void *opaque, hwaddr addr,
     }
 
     switch (offset) {
-    case 0x00:	/* DATA_INPUT */
+    case 0x00:  /* DATA_INPUT */
         OMAP_RO_REG(addr);
         return;
 
-    case 0x04:	/* DATA_OUTPUT */
+    case 0x04:  /* DATA_OUTPUT */
         diff = (s->outputs ^ value) & ~s->dir;
         s->outputs = value;
         while ((ln = ctz32(diff)) != 32) {
@@ -135,7 +135,7 @@ static void omap_gpio_write(void *opaque, hwaddr addr,
         }
         break;
 
-    case 0x08:	/* DIRECTION_CONTROL */
+    case 0x08:  /* DIRECTION_CONTROL */
         diff = s->outputs & (s->dir ^ value);
         s->dir = value;
 
@@ -147,21 +147,21 @@ static void omap_gpio_write(void *opaque, hwaddr addr,
         }
         break;
 
-    case 0x0c:	/* INTERRUPT_CONTROL */
+    case 0x0c:  /* INTERRUPT_CONTROL */
         s->edge = value;
         break;
 
-    case 0x10:	/* INTERRUPT_MASK */
+    case 0x10:  /* INTERRUPT_MASK */
         s->mask = value;
         break;
 
-    case 0x14:	/* INTERRUPT_STATUS */
+    case 0x14:  /* INTERRUPT_STATUS */
         s->ints &= ~value;
         if (!s->ints)
             qemu_irq_lower(s->irq);
         break;
 
-    case 0x18:	/* PIN_CONTROL (not in OMAP310 TRM) */
+    case 0x18:  /* PIN_CONTROL (not in OMAP310 TRM) */
         OMAP_BAD_REG(addr);
         s->pins = value;
         break;
diff --git a/hw/i2c/omap_i2c.c b/hw/i2c/omap_i2c.c
index 2e45266e74b..751bf748fd9 100644
--- a/hw/i2c/omap_i2c.c
+++ b/hw/i2c/omap_i2c.c
@@ -55,16 +55,16 @@ struct OMAPI2CState {
     uint16_t test;
 };
 
-#define OMAP2_INTR_REV	0x34
-#define OMAP2_GC_REV	0x34
+#define OMAP2_INTR_REV  0x34
+#define OMAP2_GC_REV    0x34
 
 static void omap_i2c_interrupts_update(OMAPI2CState *s)
 {
     qemu_set_irq(s->irq, s->stat & s->mask);
-    if ((s->dma >> 15) & 1)					/* RDMA_EN */
-        qemu_set_irq(s->drq[0], (s->stat >> 3) & 1);		/* RRDY */
-    if ((s->dma >> 7) & 1)					/* XDMA_EN */
-        qemu_set_irq(s->drq[1], (s->stat >> 4) & 1);		/* XRDY */
+    if ((s->dma >> 15) & 1)                             /* RDMA_EN */
+        qemu_set_irq(s->drq[0], (s->stat >> 3) & 1);    /* RRDY */
+    if ((s->dma >> 7) & 1)                              /* XDMA_EN */
+        qemu_set_irq(s->drq[1], (s->stat >> 4) & 1);    /* XRDY */
 }
 
 static void omap_i2c_fifo_run(OMAPI2CState *s)
@@ -74,25 +74,25 @@ static void omap_i2c_fifo_run(OMAPI2CState *s)
     if (!i2c_bus_busy(s->bus))
         return;
 
-    if ((s->control >> 2) & 1) {				/* RM */
-        if ((s->control >> 1) & 1) {				/* STP */
+    if ((s->control >> 2) & 1) {                /* RM */
+        if ((s->control >> 1) & 1) {            /* STP */
             i2c_end_transfer(s->bus);
-            s->control &= ~(1 << 1);				/* STP */
+            s->control &= ~(1 << 1);            /* STP */
             s->count_cur = s->count;
             s->txlen = 0;
-        } else if ((s->control >> 9) & 1) {			/* TRX */
+        } else if ((s->control >> 9) & 1) {     /* TRX */
             while (ack && s->txlen)
                 ack = (i2c_send(s->bus,
                                         (s->fifo >> ((-- s->txlen) << 3)) &
                                         0xff) >= 0);
-            s->stat |= 1 << 4;					/* XRDY */
+            s->stat |= 1 << 4;                  /* XRDY */
         } else {
             while (s->rxlen < 4)
                 s->fifo |= i2c_recv(s->bus) << ((s->rxlen ++) << 3);
-            s->stat |= 1 << 3;					/* RRDY */
+            s->stat |= 1 << 3;                  /* RRDY */
         }
     } else {
-        if ((s->control >> 9) & 1) {				/* TRX */
+        if ((s->control >> 9) & 1) {            /* TRX */
             while (ack && s->count_cur && s->txlen) {
                 ack = (i2c_send(s->bus,
                                         (s->fifo >> ((-- s->txlen) << 3)) &
@@ -100,12 +100,12 @@ static void omap_i2c_fifo_run(OMAPI2CState *s)
                 s->count_cur --;
             }
             if (ack && s->count_cur)
-                s->stat |= 1 << 4;				/* XRDY */
+                s->stat |= 1 << 4;              /* XRDY */
             else
-                s->stat &= ~(1 << 4);				/* XRDY */
+                s->stat &= ~(1 << 4);           /* XRDY */
             if (!s->count_cur) {
-                s->stat |= 1 << 2;				/* ARDY */
-                s->control &= ~(1 << 10);			/* MST */
+                s->stat |= 1 << 2;              /* ARDY */
+                s->control &= ~(1 << 10);       /* MST */
             }
         } else {
             while (s->count_cur && s->rxlen < 4) {
@@ -113,26 +113,26 @@ static void omap_i2c_fifo_run(OMAPI2CState *s)
                 s->count_cur --;
             }
             if (s->rxlen)
-                s->stat |= 1 << 3;				/* RRDY */
+                s->stat |= 1 << 3;              /* RRDY */
             else
-                s->stat &= ~(1 << 3);				/* RRDY */
+                s->stat &= ~(1 << 3);           /* RRDY */
         }
         if (!s->count_cur) {
-            if ((s->control >> 1) & 1) {			/* STP */
+            if ((s->control >> 1) & 1) {        /* STP */
                 i2c_end_transfer(s->bus);
-                s->control &= ~(1 << 1);			/* STP */
+                s->control &= ~(1 << 1);        /* STP */
                 s->count_cur = s->count;
                 s->txlen = 0;
             } else {
-                s->stat |= 1 << 2;				/* ARDY */
-                s->control &= ~(1 << 10);			/* MST */
+                s->stat |= 1 << 2;              /* ARDY */
+                s->control &= ~(1 << 10);       /* MST */
             }
         }
     }
 
-    s->stat |= (!ack) << 1;					/* NACK */
+    s->stat |= (!ack) << 1;                     /* NACK */
     if (!ack)
-        s->control &= ~(1 << 1);				/* STP */
+        s->control &= ~(1 << 1);                /* STP */
 }
 
 static void omap_i2c_reset(DeviceState *dev)
@@ -163,16 +163,16 @@ static uint32_t omap_i2c_read(void *opaque, hwaddr addr)
     uint16_t ret;
 
     switch (offset) {
-    case 0x00:	/* I2C_REV */
-        return s->revision;					/* REV */
+    case 0x00:  /* I2C_REV */
+        return s->revision;                     /* REV */
 
-    case 0x04:	/* I2C_IE */
+    case 0x04:  /* I2C_IE */
         return s->mask;
 
-    case 0x08:	/* I2C_STAT */
+    case 0x08:  /* I2C_STAT */
         return s->stat | (i2c_bus_busy(s->bus) << 12);
 
-    case 0x0c:	/* I2C_IV */
+    case 0x0c:  /* I2C_IV */
         if (s->revision >= OMAP2_INTR_REV)
             break;
         ret = ctz32(s->stat & s->mask);
@@ -185,18 +185,18 @@ static uint32_t omap_i2c_read(void *opaque, hwaddr addr)
         omap_i2c_interrupts_update(s);
         return ret;
 
-    case 0x10:	/* I2C_SYSS */
-        return (s->control >> 15) & 1;				/* I2C_EN */
+    case 0x10:  /* I2C_SYSS */
+        return (s->control >> 15) & 1;  /* I2C_EN */
 
-    case 0x14:	/* I2C_BUF */
+    case 0x14:  /* I2C_BUF */
         return s->dma;
 
-    case 0x18:	/* I2C_CNT */
-        return s->count_cur;					/* DCOUNT */
+    case 0x18:  /* I2C_CNT */
+        return s->count_cur;    /* DCOUNT */
 
-    case 0x1c:	/* I2C_DATA */
+    case 0x1c:  /* I2C_DATA */
         ret = 0;
-        if (s->control & (1 << 14)) {				/* BE */
+        if (s->control & (1 << 14)) {   /* BE */
             ret |= ((s->fifo >> 0) & 0xff) << 8;
             ret |= ((s->fifo >> 8) & 0xff) << 0;
         } else {
@@ -204,7 +204,7 @@ static uint32_t omap_i2c_read(void *opaque, hwaddr addr)
             ret |= ((s->fifo >> 0) & 0xff) << 0;
         }
         if (s->rxlen == 1) {
-            s->stat |= 1 << 15;					/* SBD */
+            s->stat |= 1 << 15;                 /* SBD */
             s->rxlen = 0;
         } else if (s->rxlen > 1) {
             if (s->rxlen > 2)
@@ -214,41 +214,41 @@ static uint32_t omap_i2c_read(void *opaque, hwaddr addr)
             /* XXX: remote access (qualifier) error - what's that?  */
         }
         if (!s->rxlen) {
-            s->stat &= ~(1 << 3);				/* RRDY */
-            if (((s->control >> 10) & 1) &&			/* MST */
-                            ((~s->control >> 9) & 1)) {		/* TRX */
-                s->stat |= 1 << 2;				/* ARDY */
-                s->control &= ~(1 << 10);			/* MST */
+            s->stat &= ~(1 << 3);                           /* RRDY */
+            if (((s->control >> 10) & 1) &&                 /* MST */
+                            ((~s->control >> 9) & 1)) {     /* TRX */
+                s->stat |= 1 << 2;                          /* ARDY */
+                s->control &= ~(1 << 10);                   /* MST */
             }
         }
-        s->stat &= ~(1 << 11);					/* ROVR */
+        s->stat &= ~(1 << 11);                              /* ROVR */
         omap_i2c_fifo_run(s);
         omap_i2c_interrupts_update(s);
         return ret;
 
-    case 0x20:	/* I2C_SYSC */
+    case 0x20:  /* I2C_SYSC */
         return 0;
 
-    case 0x24:	/* I2C_CON */
+    case 0x24:  /* I2C_CON */
         return s->control;
 
-    case 0x28:	/* I2C_OA */
+    case 0x28:  /* I2C_OA */
         return s->addr[0];
 
-    case 0x2c:	/* I2C_SA */
+    case 0x2c:  /* I2C_SA */
         return s->addr[1];
 
-    case 0x30:	/* I2C_PSC */
+    case 0x30:  /* I2C_PSC */
         return s->divider;
 
-    case 0x34:	/* I2C_SCLL */
+    case 0x34:  /* I2C_SCLL */
         return s->times[0];
 
-    case 0x38:	/* I2C_SCLH */
+    case 0x38:  /* I2C_SCLH */
         return s->times[1];
 
-    case 0x3c:	/* I2C_SYSTEST */
-        if (s->test & (1 << 15)) {				/* ST_EN */
+    case 0x3c:  /* I2C_SYSTEST */
+        if (s->test & (1 << 15)) {              /* ST_EN */
             s->test ^= 0xa;
             return s->test;
         } else
@@ -267,17 +267,17 @@ static void omap_i2c_write(void *opaque, hwaddr addr,
     int nack;
 
     switch (offset) {
-    case 0x00:	/* I2C_REV */
-    case 0x0c:	/* I2C_IV */
-    case 0x10:	/* I2C_SYSS */
+    case 0x00:  /* I2C_REV */
+    case 0x0c:  /* I2C_IV */
+    case 0x10:  /* I2C_SYSS */
         OMAP_RO_REG(addr);
         return;
 
-    case 0x04:	/* I2C_IE */
+    case 0x04:  /* I2C_IE */
         s->mask = value & (s->revision < OMAP2_GC_REV ? 0x1f : 0x3f);
         break;
 
-    case 0x08:	/* I2C_STAT */
+    case 0x08:  /* I2C_STAT */
         if (s->revision < OMAP2_INTR_REV) {
             OMAP_RO_REG(addr);
             return;
@@ -288,40 +288,40 @@ static void omap_i2c_write(void *opaque, hwaddr addr,
         omap_i2c_interrupts_update(s);
         break;
 
-    case 0x14:	/* I2C_BUF */
+    case 0x14:  /* I2C_BUF */
         s->dma = value & 0x8080;
-        if (value & (1 << 15))					/* RDMA_EN */
-            s->mask &= ~(1 << 3);				/* RRDY_IE */
-        if (value & (1 << 7))					/* XDMA_EN */
-            s->mask &= ~(1 << 4);				/* XRDY_IE */
+        if (value & (1 << 15))                  /* RDMA_EN */
+            s->mask &= ~(1 << 3);               /* RRDY_IE */
+        if (value & (1 << 7))                   /* XDMA_EN */
+            s->mask &= ~(1 << 4);               /* XRDY_IE */
         break;
 
-    case 0x18:	/* I2C_CNT */
-        s->count = value;					/* DCOUNT */
+    case 0x18:  /* I2C_CNT */
+        s->count = value;                   /* DCOUNT */
         break;
 
-    case 0x1c:	/* I2C_DATA */
+    case 0x1c:  /* I2C_DATA */
         if (s->txlen > 2) {
             /* XXX: remote access (qualifier) error - what's that?  */
             break;
         }
         s->fifo <<= 16;
         s->txlen += 2;
-        if (s->control & (1 << 14)) {				/* BE */
+        if (s->control & (1 << 14)) {           /* BE */
             s->fifo |= ((value >> 8) & 0xff) << 8;
             s->fifo |= ((value >> 0) & 0xff) << 0;
         } else {
             s->fifo |= ((value >> 0) & 0xff) << 8;
             s->fifo |= ((value >> 8) & 0xff) << 0;
         }
-        s->stat &= ~(1 << 10);					/* XUDF */
+        s->stat &= ~(1 << 10);                  /* XUDF */
         if (s->txlen > 2)
-            s->stat &= ~(1 << 4);				/* XRDY */
+            s->stat &= ~(1 << 4);               /* XRDY */
         omap_i2c_fifo_run(s);
         omap_i2c_interrupts_update(s);
         break;
 
-    case 0x20:	/* I2C_SYSC */
+    case 0x20:  /* I2C_SYSC */
         if (s->revision < OMAP2_INTR_REV) {
             OMAP_BAD_REG(addr);
             return;
@@ -332,9 +332,9 @@ static void omap_i2c_write(void *opaque, hwaddr addr,
         }
         break;
 
-    case 0x24:	/* I2C_CON */
+    case 0x24:  /* I2C_CON */
         s->control = value & 0xcf87;
-        if (~value & (1 << 15)) {				/* I2C_EN */
+        if (~value & (1 << 15)) {               /* I2C_EN */
             if (s->revision < OMAP2_INTR_REV) {
                 omap_i2c_reset(DEVICE(s));
             }
@@ -351,14 +351,14 @@ static void omap_i2c_write(void *opaque, hwaddr addr,
                           __func__);
             break;
         }
-        if ((value & (1 << 15)) && value & (1 << 0)) {		/* STT */
-            nack = !!i2c_start_transfer(s->bus, s->addr[1],	/* SA */
-                            (~value >> 9) & 1);			/* TRX */
-            s->stat |= nack << 1;				/* NACK */
-            s->control &= ~(1 << 0);				/* STT */
+        if ((value & (1 << 15)) && value & (1 << 0)) {      /* STT */
+            nack = !!i2c_start_transfer(s->bus, s->addr[1], /* SA */
+                            (~value >> 9) & 1);             /* TRX */
+            s->stat |= nack << 1;                           /* NACK */
+            s->control &= ~(1 << 0);                        /* STT */
             s->fifo = 0;
             if (nack)
-                s->control &= ~(1 << 1);			/* STP */
+                s->control &= ~(1 << 1);                    /* STP */
             else {
                 s->count_cur = s->count;
                 omap_i2c_fifo_run(s);
@@ -367,34 +367,34 @@ static void omap_i2c_write(void *opaque, hwaddr addr,
         }
         break;
 
-    case 0x28:	/* I2C_OA */
+    case 0x28:  /* I2C_OA */
         s->addr[0] = value & 0x3ff;
         break;
 
-    case 0x2c:	/* I2C_SA */
+    case 0x2c:  /* I2C_SA */
         s->addr[1] = value & 0x3ff;
         break;
 
-    case 0x30:	/* I2C_PSC */
+    case 0x30:  /* I2C_PSC */
         s->divider = value;
         break;
 
-    case 0x34:	/* I2C_SCLL */
+    case 0x34:  /* I2C_SCLL */
         s->times[0] = value;
         break;
 
-    case 0x38:	/* I2C_SCLH */
+    case 0x38:  /* I2C_SCLH */
         s->times[1] = value;
         break;
 
-    case 0x3c:	/* I2C_SYSTEST */
+    case 0x3c:  /* I2C_SYSTEST */
         s->test = value & 0xf80f;
-        if (value & (1 << 11))					/* SBB */
+        if (value & (1 << 11))                  /* SBB */
             if (s->revision >= OMAP2_INTR_REV) {
                 s->stat |= 0x3f;
                 omap_i2c_interrupts_update(s);
             }
-        if (value & (1 << 15)) {                    /* ST_EN */
+        if (value & (1 << 15)) {                /* ST_EN */
             qemu_log_mask(LOG_UNIMP,
                           "%s: System Test not supported\n", __func__);
         }
@@ -413,7 +413,7 @@ static void omap_i2c_writeb(void *opaque, hwaddr addr,
     int offset = addr & OMAP_MPUI_REG_MASK;
 
     switch (offset) {
-    case 0x1c:	/* I2C_DATA */
+    case 0x1c:  /* I2C_DATA */
         if (s->txlen > 2) {
             /* XXX: remote access (qualifier) error - what's that?  */
             break;
@@ -421,9 +421,9 @@ static void omap_i2c_writeb(void *opaque, hwaddr addr,
         s->fifo <<= 8;
         s->txlen += 1;
         s->fifo |= value & 0xff;
-        s->stat &= ~(1 << 10);					/* XUDF */
+        s->stat &= ~(1 << 10);                  /* XUDF */
         if (s->txlen > 2)
-            s->stat &= ~(1 << 4);				/* XRDY */
+            s->stat &= ~(1 << 4);               /* XRDY */
         omap_i2c_fifo_run(s);
         omap_i2c_interrupts_update(s);
         break;
diff --git a/hw/intc/omap_intc.c b/hw/intc/omap_intc.c
index 9e8737be338..c61158bddd3 100644
--- a/hw/intc/omap_intc.c
+++ b/hw/intc/omap_intc.c
@@ -102,8 +102,8 @@ static inline void omap_inth_update(OMAPIntcState *s, int is_fiq)
     }
 }
 
-#define INT_FALLING_EDGE	0
-#define INT_LOW_LEVEL		1
+#define INT_FALLING_EDGE    0
+#define INT_LOW_LEVEL       1
 
 static void omap_set_intr(void *opaque, int irq, int req)
 {
@@ -142,13 +142,13 @@ static uint64_t omap_inth_read(void *opaque, hwaddr addr,
     offset &= 0xff;
 
     switch (offset) {
-    case 0x00:	/* ITR */
+    case 0x00:  /* ITR */
         return bank->irqs;
 
-    case 0x04:	/* MIR */
+    case 0x04:  /* MIR */
         return bank->mask;
 
-    case 0x10:	/* SIR_IRQ_CODE */
+    case 0x10:  /* SIR_IRQ_CODE */
     case 0x14:  /* SIR_FIQ_CODE */
         if (bank_no != 0)
             break;
@@ -159,49 +159,49 @@ static uint64_t omap_inth_read(void *opaque, hwaddr addr,
             bank->irqs &= ~(1 << i);
         return line_no;
 
-    case 0x18:	/* CONTROL_REG */
+    case 0x18:  /* CONTROL_REG */
         if (bank_no != 0)
             break;
         return 0;
 
-    case 0x1c:	/* ILR0 */
-    case 0x20:	/* ILR1 */
-    case 0x24:	/* ILR2 */
-    case 0x28:	/* ILR3 */
-    case 0x2c:	/* ILR4 */
-    case 0x30:	/* ILR5 */
-    case 0x34:	/* ILR6 */
-    case 0x38:	/* ILR7 */
-    case 0x3c:	/* ILR8 */
-    case 0x40:	/* ILR9 */
-    case 0x44:	/* ILR10 */
-    case 0x48:	/* ILR11 */
-    case 0x4c:	/* ILR12 */
-    case 0x50:	/* ILR13 */
-    case 0x54:	/* ILR14 */
-    case 0x58:	/* ILR15 */
-    case 0x5c:	/* ILR16 */
-    case 0x60:	/* ILR17 */
-    case 0x64:	/* ILR18 */
-    case 0x68:	/* ILR19 */
-    case 0x6c:	/* ILR20 */
-    case 0x70:	/* ILR21 */
-    case 0x74:	/* ILR22 */
-    case 0x78:	/* ILR23 */
-    case 0x7c:	/* ILR24 */
-    case 0x80:	/* ILR25 */
-    case 0x84:	/* ILR26 */
-    case 0x88:	/* ILR27 */
-    case 0x8c:	/* ILR28 */
-    case 0x90:	/* ILR29 */
-    case 0x94:	/* ILR30 */
-    case 0x98:	/* ILR31 */
+    case 0x1c:  /* ILR0 */
+    case 0x20:  /* ILR1 */
+    case 0x24:  /* ILR2 */
+    case 0x28:  /* ILR3 */
+    case 0x2c:  /* ILR4 */
+    case 0x30:  /* ILR5 */
+    case 0x34:  /* ILR6 */
+    case 0x38:  /* ILR7 */
+    case 0x3c:  /* ILR8 */
+    case 0x40:  /* ILR9 */
+    case 0x44:  /* ILR10 */
+    case 0x48:  /* ILR11 */
+    case 0x4c:  /* ILR12 */
+    case 0x50:  /* ILR13 */
+    case 0x54:  /* ILR14 */
+    case 0x58:  /* ILR15 */
+    case 0x5c:  /* ILR16 */
+    case 0x60:  /* ILR17 */
+    case 0x64:  /* ILR18 */
+    case 0x68:  /* ILR19 */
+    case 0x6c:  /* ILR20 */
+    case 0x70:  /* ILR21 */
+    case 0x74:  /* ILR22 */
+    case 0x78:  /* ILR23 */
+    case 0x7c:  /* ILR24 */
+    case 0x80:  /* ILR25 */
+    case 0x84:  /* ILR26 */
+    case 0x88:  /* ILR27 */
+    case 0x8c:  /* ILR28 */
+    case 0x90:  /* ILR29 */
+    case 0x94:  /* ILR30 */
+    case 0x98:  /* ILR31 */
         i = (offset - 0x1c) >> 2;
         return (bank->priority[i] << 2) |
                 (((bank->sens_edge >> i) & 1) << 1) |
                 ((bank->fiq >> i) & 1);
 
-    case 0x9c:	/* ISR */
+    case 0x9c:  /* ISR */
         return 0x00000000;
 
     }
@@ -219,24 +219,24 @@ static void omap_inth_write(void *opaque, hwaddr addr,
     offset &= 0xff;
 
     switch (offset) {
-    case 0x00:	/* ITR */
+    case 0x00:  /* ITR */
         /* Important: ignore the clearing if the IRQ is level-triggered and
            the input bit is 1 */
         bank->irqs &= value | (bank->inputs & bank->sens_edge);
         return;
 
-    case 0x04:	/* MIR */
+    case 0x04:  /* MIR */
         bank->mask = value;
         omap_inth_update(s, 0);
         omap_inth_update(s, 1);
         return;
 
-    case 0x10:	/* SIR_IRQ_CODE */
-    case 0x14:	/* SIR_FIQ_CODE */
+    case 0x10:  /* SIR_IRQ_CODE */
+    case 0x14:  /* SIR_FIQ_CODE */
         OMAP_RO_REG(addr);
         break;
 
-    case 0x18:	/* CONTROL_REG */
+    case 0x18:  /* CONTROL_REG */
         if (bank_no != 0)
             break;
         if (value & 2) {
@@ -251,38 +251,38 @@ static void omap_inth_write(void *opaque, hwaddr addr,
         }
         return;
 
-    case 0x1c:	/* ILR0 */
-    case 0x20:	/* ILR1 */
-    case 0x24:	/* ILR2 */
-    case 0x28:	/* ILR3 */
-    case 0x2c:	/* ILR4 */
-    case 0x30:	/* ILR5 */
-    case 0x34:	/* ILR6 */
-    case 0x38:	/* ILR7 */
-    case 0x3c:	/* ILR8 */
-    case 0x40:	/* ILR9 */
-    case 0x44:	/* ILR10 */
-    case 0x48:	/* ILR11 */
-    case 0x4c:	/* ILR12 */
-    case 0x50:	/* ILR13 */
-    case 0x54:	/* ILR14 */
-    case 0x58:	/* ILR15 */
-    case 0x5c:	/* ILR16 */
-    case 0x60:	/* ILR17 */
-    case 0x64:	/* ILR18 */
-    case 0x68:	/* ILR19 */
-    case 0x6c:	/* ILR20 */
-    case 0x70:	/* ILR21 */
-    case 0x74:	/* ILR22 */
-    case 0x78:	/* ILR23 */
-    case 0x7c:	/* ILR24 */
-    case 0x80:	/* ILR25 */
-    case 0x84:	/* ILR26 */
-    case 0x88:	/* ILR27 */
-    case 0x8c:	/* ILR28 */
-    case 0x90:	/* ILR29 */
-    case 0x94:	/* ILR30 */
-    case 0x98:	/* ILR31 */
+    case 0x1c:  /* ILR0 */
+    case 0x20:  /* ILR1 */
+    case 0x24:  /* ILR2 */
+    case 0x28:  /* ILR3 */
+    case 0x2c:  /* ILR4 */
+    case 0x30:  /* ILR5 */
+    case 0x34:  /* ILR6 */
+    case 0x38:  /* ILR7 */
+    case 0x3c:  /* ILR8 */
+    case 0x40:  /* ILR9 */
+    case 0x44:  /* ILR10 */
+    case 0x48:  /* ILR11 */
+    case 0x4c:  /* ILR12 */
+    case 0x50:  /* ILR13 */
+    case 0x54:  /* ILR14 */
+    case 0x58:  /* ILR15 */
+    case 0x5c:  /* ILR16 */
+    case 0x60:  /* ILR17 */
+    case 0x64:  /* ILR18 */
+    case 0x68:  /* ILR19 */
+    case 0x6c:  /* ILR20 */
+    case 0x70:  /* ILR21 */
+    case 0x74:  /* ILR22 */
+    case 0x78:  /* ILR23 */
+    case 0x7c:  /* ILR24 */
+    case 0x80:  /* ILR25 */
+    case 0x84:  /* ILR26 */
+    case 0x88:  /* ILR27 */
+    case 0x8c:  /* ILR28 */
+    case 0x90:  /* ILR29 */
+    case 0x94:  /* ILR30 */
+    case 0x98:  /* ILR31 */
         i = (offset - 0x1c) >> 2;
         bank->priority[i] = (value >> 2) & 0x1f;
         bank->sens_edge &= ~(1 << i);
@@ -291,7 +291,7 @@ static void omap_inth_write(void *opaque, hwaddr addr,
         bank->fiq |= (value & 1) << i;
         return;
 
-    case 0x9c:	/* ISR */
+    case 0x9c:  /* ISR */
         for (i = 0; i < 32; i ++)
             if (value & (1 << i)) {
                 omap_set_intr(s, 32 * bank_no + i, 1);
diff --git a/hw/misc/omap_clk.c b/hw/misc/omap_clk.c
index 0157c9be759..da95c4ace58 100644
--- a/hw/misc/omap_clk.c
+++ b/hw/misc/omap_clk.c
@@ -30,170 +30,170 @@ struct clk {
     struct clk *parent;
     struct clk *child1;
     struct clk *sibling;
-#define ALWAYS_ENABLED		(1 << 0)
-#define CLOCK_IN_OMAP310	(1 << 10)
-#define CLOCK_IN_OMAP730	(1 << 11)
-#define CLOCK_IN_OMAP1510	(1 << 12)
-#define CLOCK_IN_OMAP16XX	(1 << 13)
+#define ALWAYS_ENABLED      (1 << 0)
+#define CLOCK_IN_OMAP310    (1 << 10)
+#define CLOCK_IN_OMAP730    (1 << 11)
+#define CLOCK_IN_OMAP1510   (1 << 12)
+#define CLOCK_IN_OMAP16XX   (1 << 13)
     uint32_t flags;
     int id;
 
-    int running;		/* Is currently ticking */
-    int enabled;		/* Is enabled, regardless of its input clk */
-    unsigned long rate;		/* Current rate (if .running) */
-    unsigned int divisor;	/* Rate relative to input (if .enabled) */
-    unsigned int multiplier;	/* Rate relative to input (if .enabled) */
-    qemu_irq users[16];		/* Who to notify on change */
-    int usecount;		/* Automatically idle when unused */
+    int running;             /* Is currently ticking                    */
+    int enabled;             /* Is enabled, regardless of its input clk */
+    unsigned long rate;      /* Current rate (if .running)              */
+    unsigned int divisor;    /* Rate relative to input (if .enabled)    */
+    unsigned int multiplier; /* Rate relative to input (if .enabled)    */
+    qemu_irq users[16];      /* Who to notify on change                 */
+    int usecount;            /* Automatically idle when unused          */
 };
 
 static struct clk xtal_osc12m = {
-    .name	= "xtal_osc_12m",
-    .rate	= 12000000,
-    .flags	= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,
+    .name   = "xtal_osc_12m",
+    .rate   = 12000000,
+    .flags  = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,
 };
 
 static struct clk xtal_osc32k = {
-    .name	= "xtal_osc_32k",
-    .rate	= 32768,
-    .flags	= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,
+    .name   = "xtal_osc_32k",
+    .rate   = 32768,
+    .flags  = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,
 };
 
 static struct clk ck_ref = {
-    .name	= "ck_ref",
-    .alias	= "clkin",
-    .parent	= &xtal_osc12m,
-    .flags	= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310 |
+    .name   = "ck_ref",
+    .alias  = "clkin",
+    .parent = &xtal_osc12m,
+    .flags  = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310 |
             ALWAYS_ENABLED,
 };
 
 /* If a dpll is disabled it becomes a bypass, child clocks don't stop */
 static struct clk dpll1 = {
-    .name	= "dpll1",
-    .parent	= &ck_ref,
-    .flags	= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310 |
+    .name   = "dpll1",
+    .parent = &ck_ref,
+    .flags  = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310 |
             ALWAYS_ENABLED,
 };
 
 static struct clk dpll2 = {
-    .name	= "dpll2",
-    .parent	= &ck_ref,
-    .flags	= CLOCK_IN_OMAP310 | ALWAYS_ENABLED,
+    .name   = "dpll2",
+    .parent = &ck_ref,
+    .flags  = CLOCK_IN_OMAP310 | ALWAYS_ENABLED,
 };
 
 static struct clk dpll3 = {
-    .name	= "dpll3",
-    .parent	= &ck_ref,
-    .flags	= CLOCK_IN_OMAP310 | ALWAYS_ENABLED,
+    .name   = "dpll3",
+    .parent = &ck_ref,
+    .flags  = CLOCK_IN_OMAP310 | ALWAYS_ENABLED,
 };
 
 static struct clk dpll4 = {
-    .name	= "dpll4",
-    .parent	= &ck_ref,
-    .multiplier	= 4,
-    .flags	= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,
+    .name   = "dpll4",
+    .parent = &ck_ref,
+    .multiplier = 4,
+    .flags  = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,
 };
 
 static struct clk apll = {
-    .name	= "apll",
-    .parent	= &ck_ref,
-    .multiplier	= 48,
-    .divisor	= 12,
-    .flags	= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,
+    .name   = "apll",
+    .parent = &ck_ref,
+    .multiplier = 48,
+    .divisor    = 12,
+    .flags  = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,
 };
 
 static struct clk ck_48m = {
-    .name	= "ck_48m",
-    .parent	= &dpll4,	/* either dpll4 or apll */
-    .flags	= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,
+    .name   = "ck_48m",
+    .parent = &dpll4,   /* either dpll4 or apll */
+    .flags  = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,
 };
 
 static struct clk ck_dpll1out = {
-    .name	= "ck_dpll1out",
-    .parent	= &dpll1,
-    .flags	= CLOCK_IN_OMAP16XX,
+    .name   = "ck_dpll1out",
+    .parent = &dpll1,
+    .flags  = CLOCK_IN_OMAP16XX,
 };
 
 static struct clk sossi_ck = {
-    .name	= "ck_sossi",
-    .parent	= &ck_dpll1out,
-    .flags	= CLOCK_IN_OMAP16XX,
+    .name   = "ck_sossi",
+    .parent = &ck_dpll1out,
+    .flags  = CLOCK_IN_OMAP16XX,
 };
 
 static struct clk clkm1 = {
-    .name	= "clkm1",
-    .alias	= "ck_gen1",
-    .parent	= &dpll1,
-    .flags	= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310 |
+    .name   = "clkm1",
+    .alias  = "ck_gen1",
+    .parent = &dpll1,
+    .flags  = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310 |
             ALWAYS_ENABLED,
 };
 
 static struct clk clkm2 = {
-    .name	= "clkm2",
-    .alias	= "ck_gen2",
-    .parent	= &dpll1,
-    .flags	= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310 |
+    .name   = "clkm2",
+    .alias  = "ck_gen2",
+    .parent = &dpll1,
+    .flags  = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310 |
             ALWAYS_ENABLED,
 };
 
 static struct clk clkm3 = {
-    .name	= "clkm3",
-    .alias	= "ck_gen3",
-    .parent	= &dpll1,	/* either dpll1 or ck_ref */
-    .flags	= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310 |
+    .name   = "clkm3",
+    .alias  = "ck_gen3",
+    .parent = &dpll1,   /* either dpll1 or ck_ref */
+    .flags  = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310 |
             ALWAYS_ENABLED,
 };
 
 static struct clk arm_ck = {
-    .name	= "arm_ck",
-    .alias	= "mpu_ck",
-    .parent	= &clkm1,
-    .flags	= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310 |
+    .name   = "arm_ck",
+    .alias  = "mpu_ck",
+    .parent = &clkm1,
+    .flags  = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310 |
             ALWAYS_ENABLED,
 };
 
 static struct clk armper_ck = {
-    .name	= "armper_ck",
-    .alias	= "mpuper_ck",
-    .parent	= &clkm1,
-    .flags	= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,
+    .name   = "armper_ck",
+    .alias  = "mpuper_ck",
+    .parent = &clkm1,
+    .flags  = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,
 };
 
 static struct clk arm_gpio_ck = {
-    .name	= "arm_gpio_ck",
-    .alias	= "mpu_gpio_ck",
-    .parent	= &clkm1,
-    .divisor	= 1,
-    .flags	= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310,
+    .name   = "arm_gpio_ck",
+    .alias  = "mpu_gpio_ck",
+    .parent = &clkm1,
+    .divisor    = 1,
+    .flags  = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310,
 };
 
 static struct clk armxor_ck = {
-    .name	= "armxor_ck",
-    .alias	= "mpuxor_ck",
-    .parent	= &ck_ref,
-    .flags	= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,
+    .name   = "armxor_ck",
+    .alias  = "mpuxor_ck",
+    .parent = &ck_ref,
+    .flags  = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,
 };
 
 static struct clk armtim_ck = {
-    .name	= "armtim_ck",
-    .alias	= "mputim_ck",
-    .parent	= &ck_ref,	/* either CLKIN or DPLL1 */
-    .flags	= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,
+    .name   = "armtim_ck",
+    .alias  = "mputim_ck",
+    .parent = &ck_ref,  /* either CLKIN or DPLL1 */
+    .flags  = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,
 };
 
 static struct clk armwdt_ck = {
-    .name	= "armwdt_ck",
-    .alias	= "mpuwd_ck",
-    .parent	= &clkm1,
-    .divisor	= 14,
-    .flags	= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310 |
+    .name   = "armwdt_ck",
+    .alias  = "mpuwd_ck",
+    .parent = &clkm1,
+    .divisor    = 14,
+    .flags  = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310 |
             ALWAYS_ENABLED,
 };
 
 static struct clk arminth_ck16xx = {
-    .name	= "arminth_ck",
-    .parent	= &arm_ck,
-    .flags	= CLOCK_IN_OMAP16XX | ALWAYS_ENABLED,
+    .name   = "arminth_ck",
+    .parent = &arm_ck,
+    .flags  = CLOCK_IN_OMAP16XX | ALWAYS_ENABLED,
     /* Note: On 16xx the frequency can be divided by 2 by programming
      * ARM_CKCTL:ARM_INTHCK_SEL(14) to 1
      *
@@ -202,48 +202,48 @@ static struct clk arminth_ck16xx = {
 };
 
 static struct clk dsp_ck = {
-    .name	= "dsp_ck",
-    .parent	= &clkm2,
-    .flags	= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX,
+    .name   = "dsp_ck",
+    .parent = &clkm2,
+    .flags  = CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX,
 };
 
 static struct clk dspmmu_ck = {
-    .name	= "dspmmu_ck",
-    .parent	= &clkm2,
-    .flags	= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
+    .name   = "dspmmu_ck",
+    .parent = &clkm2,
+    .flags  = CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
             ALWAYS_ENABLED,
 };
 
 static struct clk dspper_ck = {
-    .name	= "dspper_ck",
-    .parent	= &clkm2,
-    .flags	= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX,
+    .name   = "dspper_ck",
+    .parent = &clkm2,
+    .flags  = CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX,
 };
 
 static struct clk dspxor_ck = {
-    .name	= "dspxor_ck",
-    .parent	= &ck_ref,
-    .flags	= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX,
+    .name   = "dspxor_ck",
+    .parent = &ck_ref,
+    .flags  = CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX,
 };
 
 static struct clk dsptim_ck = {
-    .name	= "dsptim_ck",
-    .parent	= &ck_ref,
-    .flags	= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX,
+    .name   = "dsptim_ck",
+    .parent = &ck_ref,
+    .flags  = CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX,
 };
 
 static struct clk tc_ck = {
-    .name	= "tc_ck",
-    .parent	= &clkm3,
-    .flags	= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
+    .name   = "tc_ck",
+    .parent = &clkm3,
+    .flags  = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
             CLOCK_IN_OMAP730 | CLOCK_IN_OMAP310 |
             ALWAYS_ENABLED,
 };
 
 static struct clk arminth_ck15xx = {
-    .name	= "arminth_ck",
-    .parent	= &tc_ck,
-    .flags	= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 | ALWAYS_ENABLED,
+    .name   = "arminth_ck",
+    .parent = &tc_ck,
+    .flags  = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 | ALWAYS_ENABLED,
     /* Note: On 1510 the frequency follows TC_CK
      *
      * 16xx version is in MPU clocks.
@@ -252,259 +252,259 @@ static struct clk arminth_ck15xx = {
 
 static struct clk tipb_ck = {
     /* No-idle controlled by "tc_ck" */
-    .name	= "tipb_ck",
-    .parent	= &tc_ck,
-    .flags	= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 | ALWAYS_ENABLED,
+    .name   = "tipb_ck",
+    .parent = &tc_ck,
+    .flags  = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 | ALWAYS_ENABLED,
 };
 
 static struct clk l3_ocpi_ck = {
     /* No-idle controlled by "tc_ck" */
-    .name	= "l3_ocpi_ck",
-    .parent	= &tc_ck,
-    .flags	= CLOCK_IN_OMAP16XX,
+    .name   = "l3_ocpi_ck",
+    .parent = &tc_ck,
+    .flags  = CLOCK_IN_OMAP16XX,
 };
 
 static struct clk tc1_ck = {
-    .name	= "tc1_ck",
-    .parent	= &tc_ck,
-    .flags	= CLOCK_IN_OMAP16XX,
+    .name   = "tc1_ck",
+    .parent = &tc_ck,
+    .flags  = CLOCK_IN_OMAP16XX,
 };
 
 static struct clk tc2_ck = {
-    .name	= "tc2_ck",
-    .parent	= &tc_ck,
-    .flags	= CLOCK_IN_OMAP16XX,
+    .name   = "tc2_ck",
+    .parent = &tc_ck,
+    .flags  = CLOCK_IN_OMAP16XX,
 };
 
 static struct clk dma_ck = {
     /* No-idle controlled by "tc_ck" */
-    .name	= "dma_ck",
-    .parent	= &tc_ck,
-    .flags	= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310 |
+    .name   = "dma_ck",
+    .parent = &tc_ck,
+    .flags  = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310 |
             ALWAYS_ENABLED,
 };
 
 static struct clk dma_lcdfree_ck = {
-    .name	= "dma_lcdfree_ck",
-    .parent	= &tc_ck,
-    .flags	= CLOCK_IN_OMAP16XX | ALWAYS_ENABLED,
+    .name   = "dma_lcdfree_ck",
+    .parent = &tc_ck,
+    .flags  = CLOCK_IN_OMAP16XX | ALWAYS_ENABLED,
 };
 
 static struct clk api_ck = {
-    .name	= "api_ck",
-    .alias	= "mpui_ck",
-    .parent	= &tc_ck,
-    .flags	= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,
+    .name   = "api_ck",
+    .alias  = "mpui_ck",
+    .parent = &tc_ck,
+    .flags  = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,
 };
 
 static struct clk lb_ck = {
-    .name	= "lb_ck",
-    .parent	= &tc_ck,
-    .flags	= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310,
+    .name   = "lb_ck",
+    .parent = &tc_ck,
+    .flags  = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310,
 };
 
 static struct clk lbfree_ck = {
-    .name	= "lbfree_ck",
-    .parent	= &tc_ck,
-    .flags	= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310,
+    .name   = "lbfree_ck",
+    .parent = &tc_ck,
+    .flags  = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310,
 };
 
 static struct clk hsab_ck = {
-    .name	= "hsab_ck",
-    .parent	= &tc_ck,
-    .flags	= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310,
+    .name   = "hsab_ck",
+    .parent = &tc_ck,
+    .flags  = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310,
 };
 
 static struct clk rhea1_ck = {
-    .name	= "rhea1_ck",
-    .parent	= &tc_ck,
-    .flags	= CLOCK_IN_OMAP16XX | ALWAYS_ENABLED,
+    .name   = "rhea1_ck",
+    .parent = &tc_ck,
+    .flags  = CLOCK_IN_OMAP16XX | ALWAYS_ENABLED,
 };
 
 static struct clk rhea2_ck = {
-    .name	= "rhea2_ck",
-    .parent	= &tc_ck,
-    .flags	= CLOCK_IN_OMAP16XX | ALWAYS_ENABLED,
+    .name   = "rhea2_ck",
+    .parent = &tc_ck,
+    .flags  = CLOCK_IN_OMAP16XX | ALWAYS_ENABLED,
 };
 
 static struct clk lcd_ck_16xx = {
-    .name	= "lcd_ck",
-    .parent	= &clkm3,
-    .flags	= CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP730,
+    .name   = "lcd_ck",
+    .parent = &clkm3,
+    .flags  = CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP730,
 };
 
 static struct clk lcd_ck_1510 = {
-    .name	= "lcd_ck",
-    .parent	= &clkm3,
-    .flags	= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310,
+    .name   = "lcd_ck",
+    .parent = &clkm3,
+    .flags  = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310,
 };
 
 static struct clk uart1_1510 = {
-    .name	= "uart1_ck",
+    .name   = "uart1_ck",
     /* Direct from ULPD, no real parent */
-    .parent	= &armper_ck,	/* either armper_ck or dpll4 */
-    .rate	= 12000000,
-    .flags	= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 | ALWAYS_ENABLED,
+    .parent = &armper_ck,   /* either armper_ck or dpll4 */
+    .rate   = 12000000,
+    .flags  = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 | ALWAYS_ENABLED,
 };
 
 static struct clk uart1_16xx = {
-    .name	= "uart1_ck",
+    .name   = "uart1_ck",
     /* Direct from ULPD, no real parent */
-    .parent	= &armper_ck,
-    .rate	= 48000000,
-    .flags	= CLOCK_IN_OMAP16XX,
+    .parent = &armper_ck,
+    .rate   = 48000000,
+    .flags  = CLOCK_IN_OMAP16XX,
 };
 
 static struct clk uart2_ck = {
-    .name	= "uart2_ck",
+    .name   = "uart2_ck",
     /* Direct from ULPD, no real parent */
-    .parent	= &armper_ck,	/* either armper_ck or dpll4 */
-    .rate	= 12000000,
-    .flags	= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310 |
+    .parent = &armper_ck,   /* either armper_ck or dpll4 */
+    .rate   = 12000000,
+    .flags  = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310 |
             ALWAYS_ENABLED,
 };
 
 static struct clk uart3_1510 = {
-    .name	= "uart3_ck",
+    .name   = "uart3_ck",
     /* Direct from ULPD, no real parent */
-    .parent	= &armper_ck,	/* either armper_ck or dpll4 */
-    .rate	= 12000000,
-    .flags	= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 | ALWAYS_ENABLED,
+    .parent = &armper_ck,   /* either armper_ck or dpll4 */
+    .rate   = 12000000,
+    .flags  = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 | ALWAYS_ENABLED,
 };
 
 static struct clk uart3_16xx = {
-    .name	= "uart3_ck",
+    .name   = "uart3_ck",
     /* Direct from ULPD, no real parent */
-    .parent	= &armper_ck,
-    .rate	= 48000000,
-    .flags	= CLOCK_IN_OMAP16XX,
+    .parent = &armper_ck,
+    .rate   = 48000000,
+    .flags  = CLOCK_IN_OMAP16XX,
 };
 
-static struct clk usb_clk0 = {	/* 6 MHz output on W4_USB_CLK0 */
-    .name	= "usb_clk0",
-    .alias	= "usb.clko",
+static struct clk usb_clk0 = {  /* 6 MHz output on W4_USB_CLK0 */
+    .name   = "usb_clk0",
+    .alias  = "usb.clko",
     /* Direct from ULPD, no parent */
-    .rate	= 6000000,
-    .flags	= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,
+    .rate   = 6000000,
+    .flags  = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,
 };
 
 static struct clk usb_hhc_ck1510 = {
-    .name	= "usb_hhc_ck",
+    .name   = "usb_hhc_ck",
     /* Direct from ULPD, no parent */
-    .rate	= 48000000, /* Actually 2 clocks, 12MHz and 48MHz */
-    .flags	= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310,
+    .rate   = 48000000, /* Actually 2 clocks, 12MHz and 48MHz */
+    .flags  = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310,
 };
 
 static struct clk usb_hhc_ck16xx = {
-    .name	= "usb_hhc_ck",
+    .name   = "usb_hhc_ck",
     /* Direct from ULPD, no parent */
-    .rate	= 48000000,
+    .rate   = 48000000,
     /* OTG_SYSCON_2.OTG_PADEN == 0 (not 1510-compatible) */
-    .flags	= CLOCK_IN_OMAP16XX,
+    .flags  = CLOCK_IN_OMAP16XX,
 };
 
 static struct clk usb_w2fc_mclk = {
-    .name	= "usb_w2fc_mclk",
-    .alias	= "usb_w2fc_ck",
-    .parent	= &ck_48m,
-    .rate	= 48000000,
-    .flags	= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX,
+    .name   = "usb_w2fc_mclk",
+    .alias  = "usb_w2fc_ck",
+    .parent = &ck_48m,
+    .rate   = 48000000,
+    .flags  = CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX,
 };
 
 static struct clk mclk_1510 = {
-    .name	= "mclk",
+    .name   = "mclk",
     /* Direct from ULPD, no parent. May be enabled by ext hardware. */
-    .rate	= 12000000,
-    .flags	= CLOCK_IN_OMAP1510,
+    .rate   = 12000000,
+    .flags  = CLOCK_IN_OMAP1510,
 };
 
 static struct clk bclk_310 = {
-    .name	= "bt_mclk_out",	/* Alias midi_mclk_out? */
-    .parent	= &armper_ck,
-    .flags	= CLOCK_IN_OMAP310,
+    .name   = "bt_mclk_out",    /* Alias midi_mclk_out? */
+    .parent = &armper_ck,
+    .flags  = CLOCK_IN_OMAP310,
 };
 
 static struct clk mclk_310 = {
-    .name	= "com_mclk_out",
-    .parent	= &armper_ck,
-    .flags	= CLOCK_IN_OMAP310,
+    .name   = "com_mclk_out",
+    .parent = &armper_ck,
+    .flags  = CLOCK_IN_OMAP310,
 };
 
 static struct clk mclk_16xx = {
-    .name	= "mclk",
+    .name   = "mclk",
     /* Direct from ULPD, no parent. May be enabled by ext hardware. */
-    .flags	= CLOCK_IN_OMAP16XX,
+    .flags  = CLOCK_IN_OMAP16XX,
 };
 
 static struct clk bclk_1510 = {
-    .name	= "bclk",
+    .name   = "bclk",
     /* Direct from ULPD, no parent. May be enabled by ext hardware. */
-    .rate	= 12000000,
-    .flags	= CLOCK_IN_OMAP1510,
+    .rate   = 12000000,
+    .flags  = CLOCK_IN_OMAP1510,
 };
 
 static struct clk bclk_16xx = {
-    .name	= "bclk",
+    .name   = "bclk",
     /* Direct from ULPD, no parent. May be enabled by ext hardware. */
-    .flags	= CLOCK_IN_OMAP16XX,
+    .flags  = CLOCK_IN_OMAP16XX,
 };
 
 static struct clk mmc1_ck = {
-    .name	= "mmc_ck",
-    .id		= 1,
+    .name   = "mmc_ck",
+    .id     = 1,
     /* Functional clock is direct from ULPD, interface clock is ARMPER */
-    .parent	= &armper_ck,	/* either armper_ck or dpll4 */
-    .rate	= 48000000,
-    .flags	= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,
+    .parent = &armper_ck,   /* either armper_ck or dpll4 */
+    .rate   = 48000000,
+    .flags  = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,
 };
 
 static struct clk mmc2_ck = {
-    .name	= "mmc_ck",
-    .id		= 2,
+    .name   = "mmc_ck",
+    .id     = 2,
     /* Functional clock is direct from ULPD, interface clock is ARMPER */
-    .parent	= &armper_ck,
-    .rate	= 48000000,
-    .flags	= CLOCK_IN_OMAP16XX,
+    .parent = &armper_ck,
+    .rate   = 48000000,
+    .flags  = CLOCK_IN_OMAP16XX,
 };
 
 static struct clk cam_mclk = {
-    .name	= "cam.mclk",
-    .flags	= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX,
-    .rate	= 12000000,
+    .name   = "cam.mclk",
+    .flags  = CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX,
+    .rate   = 12000000,
 };
 
 static struct clk cam_exclk = {
-    .name	= "cam.exclk",
-    .flags	= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX,
+    .name   = "cam.exclk",
+    .flags  = CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX,
     /* Either 12M from cam.mclk or 48M from dpll4 */
-    .parent	= &cam_mclk,
+    .parent = &cam_mclk,
 };
 
 static struct clk cam_lclk = {
-    .name	= "cam.lclk",
-    .flags	= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX,
+    .name   = "cam.lclk",
+    .flags  = CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX,
 };
 
 static struct clk i2c_fck = {
-    .name	= "i2c_fck",
-    .id		= 1,
-    .flags	= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
+    .name   = "i2c_fck",
+    .id     = 1,
+    .flags  = CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
             ALWAYS_ENABLED,
-    .parent	= &armxor_ck,
+    .parent = &armxor_ck,
 };
 
 static struct clk i2c_ick = {
-    .name	= "i2c_ick",
-    .id		= 1,
-    .flags	= CLOCK_IN_OMAP16XX | ALWAYS_ENABLED,
-    .parent	= &armper_ck,
+    .name   = "i2c_ick",
+    .id     = 1,
+    .flags  = CLOCK_IN_OMAP16XX | ALWAYS_ENABLED,
+    .parent = &armper_ck,
 };
 
 static struct clk clk32k = {
-    .name	= "clk32-kHz",
-    .flags	= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
+    .name   = "clk32-kHz",
+    .flags  = CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
             ALWAYS_ENABLED,
-    .parent	= &xtal_osc32k,
+    .parent = &xtal_osc32k,
 };
 
 static struct clk *onchip_clks[] = {
diff --git a/hw/timer/pxa2xx_timer.c b/hw/timer/pxa2xx_timer.c
index 7a94366b0f8..6d4ac31574e 100644
--- a/hw/timer/pxa2xx_timer.c
+++ b/hw/timer/pxa2xx_timer.c
@@ -19,41 +19,41 @@
 #include "qom/object.h"
 #include "system/watchdog.h"
 
-#define OSMR0	0x00
-#define OSMR1	0x04
-#define OSMR2	0x08
-#define OSMR3	0x0c
-#define OSMR4	0x80
-#define OSMR5	0x84
-#define OSMR6	0x88
-#define OSMR7	0x8c
-#define OSMR8	0x90
-#define OSMR9	0x94
-#define OSMR10	0x98
-#define OSMR11	0x9c
-#define OSCR	0x10	/* OS Timer Count */
-#define OSCR4	0x40
-#define OSCR5	0x44
-#define OSCR6	0x48
-#define OSCR7	0x4c
-#define OSCR8	0x50
-#define OSCR9	0x54
-#define OSCR10	0x58
-#define OSCR11	0x5c
-#define OSSR	0x14	/* Timer status register */
-#define OWER	0x18
-#define OIER	0x1c	/* Interrupt enable register  3-0 to E3-E0 */
-#define OMCR4	0xc0	/* OS Match Control registers */
-#define OMCR5	0xc4
-#define OMCR6	0xc8
-#define OMCR7	0xcc
-#define OMCR8	0xd0
-#define OMCR9	0xd4
-#define OMCR10	0xd8
-#define OMCR11	0xdc
-#define OSNR	0x20
+#define OSMR0   0x00
+#define OSMR1   0x04
+#define OSMR2   0x08
+#define OSMR3   0x0c
+#define OSMR4   0x80
+#define OSMR5   0x84
+#define OSMR6   0x88
+#define OSMR7   0x8c
+#define OSMR8   0x90
+#define OSMR9   0x94
+#define OSMR10  0x98
+#define OSMR11  0x9c
+#define OSCR    0x10    /* OS Timer Count */
+#define OSCR4   0x40
+#define OSCR5   0x44
+#define OSCR6   0x48
+#define OSCR7   0x4c
+#define OSCR8   0x50
+#define OSCR9   0x54
+#define OSCR10  0x58
+#define OSCR11  0x5c
+#define OSSR    0x14    /* Timer status register */
+#define OWER    0x18
+#define OIER    0x1c    /* Interrupt enable register  3-0 to E3-E0 */
+#define OMCR4   0xc0    /* OS Match Control registers */
+#define OMCR5   0xc4
+#define OMCR6   0xc8
+#define OMCR7   0xcc
+#define OMCR8   0xd0
+#define OMCR9   0xd4
+#define OMCR10  0xd8
+#define OMCR11  0xdc
+#define OSNR    0x20
 
-#define PXA25X_FREQ	3686400	/* 3.6864 MHz */
+#define PXA25X_FREQ 3686400 /* 3.6864 MHz */
 
 static int pxa2xx_timer4_freq[8] = {
     [0] = 0,
@@ -106,7 +106,7 @@ struct PXA2xxTimerInfo {
     PXA2xxTimer4 tm4[8];
 };
 
-#define PXA2XX_TIMER_HAVE_TM4	0
+#define PXA2XX_TIMER_HAVE_TM4   0
 
 static inline int pxa2xx_timer_has_tm4(PXA2xxTimerInfo *s)
 {
@@ -230,7 +230,7 @@ static uint64_t pxa2xx_timer_read(void *opaque, hwaddr offset,
                      NANOSECONDS_PER_SECOND);
     case OIER:
         return s->irq_enabled;
-    case OSSR:	/* Status register */
+    case OSSR:  /* Status register */
         return s->events;
     case OWER:
         return s->reset3;
@@ -336,7 +336,7 @@ static void pxa2xx_timer_write(void *opaque, hwaddr offset,
     case OIER:
         s->irq_enabled = value & 0xfff;
         break;
-    case OSSR:	/* Status register */
+    case OSSR:  /* Status register */
         value &= s->events;
         s->events &= ~value;
         for (i = 0; i < 4; i ++, value >>= 1)
@@ -345,7 +345,7 @@ static void pxa2xx_timer_write(void *opaque, hwaddr offset,
         if (pxa2xx_timer_has_tm4(s) && !(s->events & 0xff0) && value)
             qemu_irq_lower(s->irq4);
         break;
-    case OWER:	/* XXX: Reset on OSMR3 match? */
+    case OWER:  /* XXX: Reset on OSMR3 match? */
         s->reset3 = value;
         break;
     case OMCR7:  tm ++;
-- 
2.43.0


