Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB63C52D7F
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2024 10:31:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfGeP-00005V-K8; Sat, 17 Aug 2024 06:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <34nrAZgUKChcGxI5C3BB381.zB9D19H-01I18ABA3AH.BE3@flex--tavip.bounces.google.com>)
 id 1sfGeA-0007Kf-Rj
 for qemu-devel@nongnu.org; Sat, 17 Aug 2024 06:26:59 -0400
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <34nrAZgUKChcGxI5C3BB381.zB9D19H-01I18ABA3AH.BE3@flex--tavip.bounces.google.com>)
 id 1sfGdz-0003Jx-BS
 for qemu-devel@nongnu.org; Sat, 17 Aug 2024 06:26:54 -0400
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-6b4270bdea3so16928227b3.3
 for <qemu-devel@nongnu.org>; Sat, 17 Aug 2024 03:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1723890402; x=1724495202; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=6StJku6Hbf8+9rWMJrTuC5Sf7iZIOKT/7boQb0Msbho=;
 b=u+1ZFdoHBLjig+HF/0JrnABraVNMiEeBZOz69ao+Ux/Zqe0YZWlBxzXWLLuaxUVcB7
 mwXkueVDtZKJBzMI7oDD4H76PJU/nd50C04A7HP4BjL/pS873tHkkDvpBQujiY5kwDIq
 VETfU4OG/trUmisk1C12C9DlUSgu1GdJRW7089MpXa9QysWpqFCGQx9DkIwFBKsHuBol
 X6VWwKK3R1MIwltTqtKY6j4bkD51nnoPDead0+l72f4J/U/s1XIHFJdMrTrRcbsOcfIV
 Jd118veHULWSlE/R3PX5gdhKEhyeFpIadi28UR9wXy/ggfTVYDdlCYG7mqGTnHNOUBQb
 HgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723890402; x=1724495202;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6StJku6Hbf8+9rWMJrTuC5Sf7iZIOKT/7boQb0Msbho=;
 b=vdfL44MpyP4GCV4ct8WQQX0E034vzup7tbp6jhQC+8nU21X0cWo+TL7w6SfSFPkZNf
 mHVdxz3V43kUJoUVUv2agTBZSQ4Z28NDWR9NSFyR4zzMu92iglgJg/9a3Zbk0awVmZ0c
 PsVm9Xg+1nKrKPtI6jkdE5d5iYRYcYF53RHGSxuxBc3RHImMiEvYEreIzeblWCd0Q6qB
 X+eAVfuGBJxIjAv3An0y7rU+F7web2JeuKt4GQ4/MkHzGy8+ZyGnPapoz5D34LivX2A9
 qcBP6ECrGRXVVrLufl7K7kfy/BUiWL48EfbSEUbOPuv3zWq+bQElpB5KxermrmRlB+Sd
 qSmg==
X-Gm-Message-State: AOJu0Ywguffy56YytP9+84cVmOGuz6Wcrf8UZT/lyVyU9dePmuf+Lliq
 RUYr668mL/6vMzCd3l0fRw98njxFVsBpZzCRgjNGkE02k/QhZdySlAOgv9lCWPiw4pgvBdznWku
 XBEdseuKvqRBIdgieucGJCiR1hxh4HDgoJECq5y9B/QVknPicFRQBvon4G73DaEoiqTVOHb2OwB
 UdJwekAYXi5R1LIiQ2BEUxfXPPNw==
X-Google-Smtp-Source: AGHT+IGxIzdPN93DLnckAk1EL6tvC/RkSdXIGasRcOauXf1K3SaadUqP7gXj+RWlqDUptlgvLA2ealrkRQ==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a05:690c:2f0d:b0:6b2:6cd4:7f96
 with SMTP id
 00721157ae682-6b26cd48157mr1345837b3.9.1723890402290; Sat, 17 Aug 2024
 03:26:42 -0700 (PDT)
Date: Sat, 17 Aug 2024 03:26:01 -0700
In-Reply-To: <20240817102606.3996242-1-tavip@google.com>
Mime-Version: 1.0
References: <20240817102606.3996242-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240817102606.3996242-19-tavip@google.com>
Subject: [RFC PATCH v2 18/23] hw/misc: add support for RT500's clock controller
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 thuth@redhat.com, peter.maydell@linaro.org, marcandre.lureau@redhat.com, 
 alistair@alistair23.me, berrange@redhat.com, philmd@linaro.org, 
 jsnow@redhat.com, crosa@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=34nrAZgUKChcGxI5C3BB381.zB9D19H-01I18ABA3AH.BE3@flex--tavip.bounces.google.com;
 helo=mail-yw1-x1149.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, UPPERCASE_50_75=0.008,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=no autolearn_force=no
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
 include/hw/arm/svd/rt500_clkctl0.h | 2287 ++++++++++++++++++++
 include/hw/arm/svd/rt500_clkctl1.h | 3109 ++++++++++++++++++++++++++++
 include/hw/misc/rt500_clk_freqs.h  |   18 +
 include/hw/misc/rt500_clkctl0.h    |   37 +
 include/hw/misc/rt500_clkctl1.h    |   36 +
 hw/misc/rt500_clkctl0.c            |  226 ++
 hw/misc/rt500_clkctl1.c            |  207 ++
 hw/arm/svd/meson.build             |    6 +
 hw/misc/Kconfig                    |    6 +
 hw/misc/meson.build                |    2 +
 hw/misc/trace-events               |    8 +
 11 files changed, 5942 insertions(+)
 create mode 100644 include/hw/arm/svd/rt500_clkctl0.h
 create mode 100644 include/hw/arm/svd/rt500_clkctl1.h
 create mode 100644 include/hw/misc/rt500_clk_freqs.h
 create mode 100644 include/hw/misc/rt500_clkctl0.h
 create mode 100644 include/hw/misc/rt500_clkctl1.h
 create mode 100644 hw/misc/rt500_clkctl0.c
 create mode 100644 hw/misc/rt500_clkctl1.c

diff --git a/include/hw/arm/svd/rt500_clkctl0.h b/include/hw/arm/svd/rt500_clkctl0.h
new file mode 100644
index 0000000000..736c89434e
--- /dev/null
+++ b/include/hw/arm/svd/rt500_clkctl0.h
@@ -0,0 +1,2287 @@
+/*
+ * Copyright 2016-2023 NXP SPDX-License-Identifier: BSD-3-Clause
+ *
+ * Automatically generated by svd-gen-header.py from MIMXRT595S_cm33.xml
+ */
+#pragma once
+
+#include "hw/registerfields.h"
+
+/* Clock Controller 0 */
+#define RT500_CLKCTL0_REGS_NO (490)
+
+/* Clock Control 0 */
+REG32(RT500_CLKCTL0_PSCCTL0, 16);
+/* DSP clock control */
+FIELD(RT500_CLKCTL0_PSCCTL0, DSP_CLK, 1, 1);
+/* 128KB ROM Controller clock control */
+FIELD(RT500_CLKCTL0_PSCCTL0, ROM_CTRLR_CLK, 2, 1);
+/* AXI Switch clock control */
+FIELD(RT500_CLKCTL0_PSCCTL0, AXI_SWITCH_CLK, 3, 1);
+/* AXI Controller clock control */
+FIELD(RT500_CLKCTL0_PSCCTL0, AXI_CTLR_CLK, 4, 1);
+/* POWERQUAD clock control */
+FIELD(RT500_CLKCTL0_PSCCTL0, POWERQUAD_CLK, 8, 1);
+/* CASPER clock control */
+FIELD(RT500_CLKCTL0_PSCCTL0, CASPER_CLK, 9, 1);
+/* HASHCRYPT clock control */
+FIELD(RT500_CLKCTL0_PSCCTL0, HASHCRYPT_CLK, 10, 1);
+/* PUF clock control */
+FIELD(RT500_CLKCTL0_PSCCTL0, PUF_CLK, 11, 1);
+/* Random Number Generator (RNG) clock control */
+FIELD(RT500_CLKCTL0_PSCCTL0, RNG_CLK, 12, 1);
+/* FLEXSPI0 / OTFAD clock control */
+FIELD(RT500_CLKCTL0_PSCCTL0, FLEXSPI0_OTFAD_CLK, 16, 1);
+/* OTP Controller clock control */
+FIELD(RT500_CLKCTL0_PSCCTL0, OTP_CTLR_CLK, 17, 1);
+/* FLEXSPI1 clock control */
+FIELD(RT500_CLKCTL0_PSCCTL0, FLEXSPI1_CLK, 18, 1);
+/* USB HS PHY clock control */
+FIELD(RT500_CLKCTL0_PSCCTL0, USBHS_PHY_CLK, 20, 1);
+/* USB HS Device clock control */
+FIELD(RT500_CLKCTL0_PSCCTL0, USBHS_DEVICE_CLK, 21, 1);
+/* USB HS Host clock control */
+FIELD(RT500_CLKCTL0_PSCCTL0, USBHS_HOST_CLK, 22, 1);
+/* USB HS SRAM clock control */
+FIELD(RT500_CLKCTL0_PSCCTL0, USBHS_SRAM_CLK, 23, 1);
+/* SCT clock control */
+FIELD(RT500_CLKCTL0_PSCCTL0, SCT_CLK, 24, 1);
+/* GPU clock control */
+FIELD(RT500_CLKCTL0_PSCCTL0, GPU_CLK, 26, 1);
+/* Display Controller clock control */
+FIELD(RT500_CLKCTL0_PSCCTL0, DISPLAY_CTLR_CLK, 27, 1);
+/* MIPI-DSI Controller clock control */
+FIELD(RT500_CLKCTL0_PSCCTL0, MIPI_DSI_CTLR_CLK, 28, 1);
+/* Smart DMA clock control */
+FIELD(RT500_CLKCTL0_PSCCTL0, SMARTDMA_CLK, 30, 1);
+
+/* Clock Control 1 */
+REG32(RT500_CLKCTL0_PSCCTL1, 20);
+/* SDIO0 clock control */
+FIELD(RT500_CLKCTL0_PSCCTL1, SDIO0_CLK, 2, 1);
+/* SDIO1 clock control */
+FIELD(RT500_CLKCTL0_PSCCTL1, SDIO1_CLK, 3, 1);
+/* ACMP0 clock control */
+FIELD(RT500_CLKCTL0_PSCCTL1, ACMP0_CLK, 15, 1);
+/* ADC0 clock control */
+FIELD(RT500_CLKCTL0_PSCCTL1, ADC0_CLK, 16, 1);
+/* SHSGPIO0 clock control */
+FIELD(RT500_CLKCTL0_PSCCTL1, SHSGPIO0_CLK, 24, 1);
+
+/* Clock Control 2 */
+REG32(RT500_CLKCTL0_PSCCTL2, 24);
+/* Micro-Tick Timer 0 clock control */
+FIELD(RT500_CLKCTL0_PSCCTL2, UTICK0_CLK, 0, 1);
+/* Watchdog Timer 0 clock control */
+FIELD(RT500_CLKCTL0_PSCCTL2, WWDT0_CLK, 1, 1);
+/* Power Management Controller clock control */
+FIELD(RT500_CLKCTL0_PSCCTL2, PMC_CLK, 29, 1);
+
+/* Clock Control 0 Set */
+REG32(RT500_CLKCTL0_PSCCTL0_SET, 64);
+/* DSP clock set */
+FIELD(RT500_CLKCTL0_PSCCTL0_SET, DSP_CLK, 1, 1);
+/* 128KB ROM Controller clock set */
+FIELD(RT500_CLKCTL0_PSCCTL0_SET, ROM_CTRLR_CLK, 2, 1);
+/* AXI Switch clock set */
+FIELD(RT500_CLKCTL0_PSCCTL0_SET, AXI_SWITCH_CLK, 3, 1);
+/* AXI Controller clock set */
+FIELD(RT500_CLKCTL0_PSCCTL0_SET, AXI_CTLR_CLK, 4, 1);
+/* POWERQUAD clock set */
+FIELD(RT500_CLKCTL0_PSCCTL0_SET, POWERQUAD_CLK, 8, 1);
+/* CASPER clock set */
+FIELD(RT500_CLKCTL0_PSCCTL0_SET, CASPER_CLK, 9, 1);
+/* HASHCRYPT clock set */
+FIELD(RT500_CLKCTL0_PSCCTL0_SET, HASHCRYPT_CLK, 10, 1);
+/* PUF clock set */
+FIELD(RT500_CLKCTL0_PSCCTL0_SET, PUF_CLK, 11, 1);
+/* Random Number Generator (RNG) clock set */
+FIELD(RT500_CLKCTL0_PSCCTL0_SET, RNG_CLK, 12, 1);
+/* FLEXSPI0 / OTFAD clock set */
+FIELD(RT500_CLKCTL0_PSCCTL0_SET, FLEXSPI0_OTFAD_CLK, 16, 1);
+/* OTP Controller clock set */
+FIELD(RT500_CLKCTL0_PSCCTL0_SET, OTP_CTLR_CLK, 17, 1);
+/* FLEXSPI1 clock set */
+FIELD(RT500_CLKCTL0_PSCCTL0_SET, FLEXSPI1_CLK, 18, 1);
+/* USB HS PHY clock set */
+FIELD(RT500_CLKCTL0_PSCCTL0_SET, USBHS_PHY_CLK, 20, 1);
+/* USB HS Device clock set */
+FIELD(RT500_CLKCTL0_PSCCTL0_SET, USBHS_DEVICE_CLK, 21, 1);
+/* USB HS Host clock set */
+FIELD(RT500_CLKCTL0_PSCCTL0_SET, USBHS_HOST_CLK, 22, 1);
+/* USB HS SRAM clock set */
+FIELD(RT500_CLKCTL0_PSCCTL0_SET, USBHS_SRAM_CLK, 23, 1);
+/* SCT clock set */
+FIELD(RT500_CLKCTL0_PSCCTL0_SET, SCT_CLK, 24, 1);
+/* GPU clock set */
+FIELD(RT500_CLKCTL0_PSCCTL0_SET, GPU_CLK, 26, 1);
+/* Display Controller clock set */
+FIELD(RT500_CLKCTL0_PSCCTL0_SET, DISPLAY_CTLR_CLK, 27, 1);
+/* MIPI-DSI Controller clock set */
+FIELD(RT500_CLKCTL0_PSCCTL0_SET, MIPI_DSI_CTLR_CLK, 28, 1);
+/* Smart DMA clock set */
+FIELD(RT500_CLKCTL0_PSCCTL0_SET, SMARTDMA_CLK, 30, 1);
+
+/* Clock Control 1 Set */
+REG32(RT500_CLKCTL0_PSCCTL1_SET, 68);
+/* SDIO0 clock set */
+FIELD(RT500_CLKCTL0_PSCCTL1_SET, SDIO0_CLK, 2, 1);
+/* SDIO1 clock set */
+FIELD(RT500_CLKCTL0_PSCCTL1_SET, SDIO1_CLK, 3, 1);
+/* ACMP0 clock set */
+FIELD(RT500_CLKCTL0_PSCCTL1_SET, ACMP0_CLK, 15, 1);
+/* ADC0 clock set */
+FIELD(RT500_CLKCTL0_PSCCTL1_SET, ADC0_CLK, 16, 1);
+/* SHSGPIO0 clock set */
+FIELD(RT500_CLKCTL0_PSCCTL1_SET, SHSGPIO0_CLK, 24, 1);
+
+/* Clock Control 2 Set */
+REG32(RT500_CLKCTL0_PSCCTL2_SET, 72);
+/* Micro-Tick Timer 0 clock set */
+FIELD(RT500_CLKCTL0_PSCCTL2_SET, UTICK0_CLK, 0, 1);
+/* Watchdog Timer 0 clock set */
+FIELD(RT500_CLKCTL0_PSCCTL2_SET, WWDT0_CLK, 1, 1);
+/* Power Management Controller clock set */
+FIELD(RT500_CLKCTL0_PSCCTL2_SET, PMC, 29, 1);
+
+/* Clock Control 0 Clear */
+REG32(RT500_CLKCTL0_PSCCTL0_CLR, 112);
+/* DSP clock clear */
+FIELD(RT500_CLKCTL0_PSCCTL0_CLR, DSP_CLK, 1, 1);
+/* 128KB ROM Controller clock clear */
+FIELD(RT500_CLKCTL0_PSCCTL0_CLR, ROM_CTRLR_CLK, 2, 1);
+/* AXI Switch clock clear */
+FIELD(RT500_CLKCTL0_PSCCTL0_CLR, AXI_SWITCH_CLK, 3, 1);
+/* AXI Controller clock clear */
+FIELD(RT500_CLKCTL0_PSCCTL0_CLR, AXI_CTLR_CLK, 4, 1);
+/* POWERQUAD clock clear */
+FIELD(RT500_CLKCTL0_PSCCTL0_CLR, POWERQUAD_CLK, 8, 1);
+/* CASPER clock clear */
+FIELD(RT500_CLKCTL0_PSCCTL0_CLR, CASPER_CLK, 9, 1);
+/* HASHCRYPT clock clear */
+FIELD(RT500_CLKCTL0_PSCCTL0_CLR, HASHCRYPT_CLK, 10, 1);
+/* PUF clock clear */
+FIELD(RT500_CLKCTL0_PSCCTL0_CLR, PUF_CLK, 11, 1);
+/* RNG clock clear */
+FIELD(RT500_CLKCTL0_PSCCTL0_CLR, RNG_CLK, 12, 1);
+/* FLEXSPI0 / OTFAD clock clear */
+FIELD(RT500_CLKCTL0_PSCCTL0_CLR, FLEXSPI0_OTFAD_CLK, 16, 1);
+/* OTP Controller clock clear */
+FIELD(RT500_CLKCTL0_PSCCTL0_CLR, OTP_CTLR_CLK, 17, 1);
+/* FLEXSPI1 clock clear */
+FIELD(RT500_CLKCTL0_PSCCTL0_CLR, FLEXSPI1_CLK, 18, 1);
+/* USB HS PHY clock clear */
+FIELD(RT500_CLKCTL0_PSCCTL0_CLR, USBHS_PHY_CLK, 20, 1);
+/* USB HS Device clock clear */
+FIELD(RT500_CLKCTL0_PSCCTL0_CLR, USBHS_DEVICE_CLK, 21, 1);
+/* USB HS Host clock clear */
+FIELD(RT500_CLKCTL0_PSCCTL0_CLR, USBHS_HOST_CLK, 22, 1);
+/* USB HS SRAM clock clear */
+FIELD(RT500_CLKCTL0_PSCCTL0_CLR, USBHS_SRAM_CLK, 23, 1);
+/* SCT clock clear */
+FIELD(RT500_CLKCTL0_PSCCTL0_CLR, SCT_CLK, 24, 1);
+/* GPU clock clear */
+FIELD(RT500_CLKCTL0_PSCCTL0_CLR, GPU_CLK, 26, 1);
+/* Display Controller clock clear */
+FIELD(RT500_CLKCTL0_PSCCTL0_CLR, DISPLAY_CTLR_CLK, 27, 1);
+/* MIPI-DSI Controller clock clear */
+FIELD(RT500_CLKCTL0_PSCCTL0_CLR, MIPI_DSI_CTLR_CLK, 28, 1);
+/* Smart DMA clock set */
+FIELD(RT500_CLKCTL0_PSCCTL0_CLR, SMARTDMA_CLK, 30, 1);
+
+/* Clock Control 1 Clear */
+REG32(RT500_CLKCTL0_PSCCTL1_CLR, 116);
+/* SDIO0 clock clear */
+FIELD(RT500_CLKCTL0_PSCCTL1_CLR, SDIO0_CLK, 2, 1);
+/* SDIO1 clock clear */
+FIELD(RT500_CLKCTL0_PSCCTL1_CLR, SDIO1_CLK, 3, 1);
+/* ACMP0 clock clear */
+FIELD(RT500_CLKCTL0_PSCCTL1_CLR, ACMP0_CLK, 15, 1);
+/* ADC0 clock clear */
+FIELD(RT500_CLKCTL0_PSCCTL1_CLR, ADC0_CLK, 16, 1);
+/* SHSGPIO0 clock clear */
+FIELD(RT500_CLKCTL0_PSCCTL1_CLR, SHSGPIO0_CLK, 24, 1);
+
+/* Clock Control 2 Clear */
+REG32(RT500_CLKCTL0_PSCCTL2_CLR, 120);
+/* Micro-Tick Timer 0 clock clear */
+FIELD(RT500_CLKCTL0_PSCCTL2_CLR, UTICK0_CLK, 0, 1);
+/* Watchdog Timer 0 clock clear */
+FIELD(RT500_CLKCTL0_PSCCTL2_CLR, WWDT0_CLK, 1, 1);
+/* Power Management Controller clock clear */
+FIELD(RT500_CLKCTL0_PSCCTL2_CLR, PMC_CLK, 29, 1);
+
+/* Free Running Oscillator Control */
+REG32(RT500_CLKCTL0_FRO_CONTROL, 128);
+/* Expected Count */
+FIELD(RT500_CLKCTL0_FRO_CONTROL, EXP_COUNT, 0, 16);
+/* Threshold Range Upper Limit */
+FIELD(RT500_CLKCTL0_FRO_CONTROL, THRESH_RANGE_UP, 16, 5);
+/* Threshold Range Lower Limit */
+FIELD(RT500_CLKCTL0_FRO_CONTROL, THRESH_RANGE_LOW, 21, 5);
+/* Enable Tuning */
+FIELD(RT500_CLKCTL0_FRO_CONTROL, ENA_TUNE, 31, 1);
+
+/* Free Running Oscillator Captured Value */
+REG32(RT500_CLKCTL0_FRO_CAPVAL, 132);
+/* Captured Value */
+FIELD(RT500_CLKCTL0_FRO_CAPVAL, CAPVAL, 0, 16);
+/* Data Valid */
+FIELD(RT500_CLKCTL0_FRO_CAPVAL, DATA_VALID, 31, 1);
+
+/* Free Running Oscillator Trim */
+REG32(RT500_CLKCTL0_FRO_RDTRIM, 140);
+/* It is the trim value supplied to the oscillator */
+FIELD(RT500_CLKCTL0_FRO_RDTRIM, TRIM, 0, 11);
+
+/* Free Running OscillatorSC Trim */
+REG32(RT500_CLKCTL0_FRO_SCTRIM, 144);
+/* sc_trim value for the oscillator. */
+FIELD(RT500_CLKCTL0_FRO_SCTRIM, TRIM, 0, 6);
+
+/* FRO Clock Divider */
+REG32(RT500_CLKCTL0_FRODIVSEL, 264);
+/* Select clock */
+FIELD(RT500_CLKCTL0_FRODIVSEL, SEL, 0, 2);
+
+/* FRO Clock Status */
+REG32(RT500_CLKCTL0_FROCLKSTATUS, 268);
+/* FRO Clock OK */
+FIELD(RT500_CLKCTL0_FROCLKSTATUS, CLK_OK, 0, 1);
+
+/* FRO Enable Register */
+REG32(RT500_CLKCTL0_FRODIVOEN, 272);
+/* FRO Divided-by-1 Clock Enable */
+FIELD(RT500_CLKCTL0_FRODIVOEN, FRO_DIV1_O_EN, 0, 1);
+/* FRO Divided-by-2 Clock Enable */
+FIELD(RT500_CLKCTL0_FRODIVOEN, FRO_DIV2_O_EN, 1, 1);
+/* FRO Divided-by-4 Clock Enable */
+FIELD(RT500_CLKCTL0_FRODIVOEN, FRO_DIV4_O_EN, 2, 1);
+/* FRO Divided-by-8 Clock Enable */
+FIELD(RT500_CLKCTL0_FRODIVOEN, FRO_DIV8_O_EN, 3, 1);
+/* FRO Divided-by-16 Clock Enable */
+FIELD(RT500_CLKCTL0_FRODIVOEN, FRO_DIV16_O_EN, 4, 1);
+
+/* Low Frequency Clock Divider */
+REG32(RT500_CLKCTL0_LOWFREQCLKDIV, 304);
+/* Low Frequency Clock Divider Value */
+FIELD(RT500_CLKCTL0_LOWFREQCLKDIV, DIV, 0, 8);
+/* Reset the Divider Counter */
+FIELD(RT500_CLKCTL0_LOWFREQCLKDIV, RESET, 29, 1);
+/* Halt the Divider Counter */
+FIELD(RT500_CLKCTL0_LOWFREQCLKDIV, HALT, 30, 1);
+/* Divider Status Flag */
+FIELD(RT500_CLKCTL0_LOWFREQCLKDIV, REQFLAG, 31, 1);
+
+/* System Oscillator Control 0 */
+REG32(RT500_CLKCTL0_SYSOSCCTL0, 352);
+/* Low Power Mode Enable */
+FIELD(RT500_CLKCTL0_SYSOSCCTL0, LP_ENABLE, 0, 1);
+/* Bypass Enable */
+FIELD(RT500_CLKCTL0_SYSOSCCTL0, BYPASS_ENABLE, 1, 1);
+
+/* OSC Clock Source Select */
+REG32(RT500_CLKCTL0_SYSOSCBYPASS, 360);
+/* Select SYSOSC Bypass */
+FIELD(RT500_CLKCTL0_SYSOSCBYPASS, SEL, 0, 3);
+
+/* Low Power Oscillator Control 0 */
+REG32(RT500_CLKCTL0_LPOSCCTL0, 400);
+/* LPOSC Clock Ready */
+FIELD(RT500_CLKCTL0_LPOSCCTL0, CLKRDY, 31, 1);
+
+/* 32 KHz Oscillator Control 0 */
+REG32(RT500_CLKCTL0_OSC32KHZCTL0, 448);
+/* 32 KHz Oscillator Enable */
+FIELD(RT500_CLKCTL0_OSC32KHZCTL0, ENA32KHZ, 0, 1);
+
+/* System PLL 0 Clock Select */
+REG32(RT500_CLKCTL0_SYSPLL0CLKSEL, 512);
+/* System PLL0 Reference Input Clock Source */
+FIELD(RT500_CLKCTL0_SYSPLL0CLKSEL, SEL, 0, 3);
+
+/* System PLL0 Control 0 */
+REG32(RT500_CLKCTL0_SYSPLL0CTL0, 516);
+/* SYSPLL0 BYPASS Mode */
+FIELD(RT500_CLKCTL0_SYSPLL0CTL0, BYPASS, 0, 1);
+/* SYSPLL0 Reset */
+FIELD(RT500_CLKCTL0_SYSPLL0CTL0, RESET, 1, 1);
+/* Hold Ring Off Control */
+FIELD(RT500_CLKCTL0_SYSPLL0CTL0, HOLDRINGOFF_ENA, 13, 1);
+/* Multiplication Factor */
+FIELD(RT500_CLKCTL0_SYSPLL0CTL0, MULT, 16, 8);
+
+/* System PLL0 Lock Time Div2 */
+REG32(RT500_CLKCTL0_SYSPLL0LOCKTIMEDIV2, 524);
+/* SYSPLL0 Lock Time Divide-by-2 */
+FIELD(RT500_CLKCTL0_SYSPLL0LOCKTIMEDIV2, LOCKTIMEDIV2, 0, 16);
+
+/* System PLL0 Numerator */
+REG32(RT500_CLKCTL0_SYSPLL0NUM, 528);
+/* Numerator of the SYSPLL0 fractional loop divider */
+FIELD(RT500_CLKCTL0_SYSPLL0NUM, NUM, 0, 30);
+
+/* System PLL0 Denominator */
+REG32(RT500_CLKCTL0_SYSPLL0DENOM, 532);
+/* Denominator of the SYSPLL0 fractional loop divider */
+FIELD(RT500_CLKCTL0_SYSPLL0DENOM, DENOM, 0, 30);
+
+/* System PLL0 PFD */
+REG32(RT500_CLKCTL0_SYSPLL0PFD, 536);
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
+/* Main PLL Clock Divider */
+REG32(RT500_CLKCTL0_MAINPLLCLKDIV, 576);
+/* Low Frequency Clock Divider Value */
+FIELD(RT500_CLKCTL0_MAINPLLCLKDIV, DIV, 0, 8);
+/* Resets the divider counter */
+FIELD(RT500_CLKCTL0_MAINPLLCLKDIV, RESET, 29, 1);
+/* Halts the divider counter */
+FIELD(RT500_CLKCTL0_MAINPLLCLKDIV, HALT, 30, 1);
+/* Divider status flag */
+FIELD(RT500_CLKCTL0_MAINPLLCLKDIV, REQFLAG, 31, 1);
+
+/* DSP PLL Clock Divider */
+REG32(RT500_CLKCTL0_DSPPLLCLKDIV, 580);
+/* Low Frequency Clock Divider Value */
+FIELD(RT500_CLKCTL0_DSPPLLCLKDIV, DIV, 0, 8);
+/* Resets the divider counter */
+FIELD(RT500_CLKCTL0_DSPPLLCLKDIV, RESET, 29, 1);
+/* Halts the divider counter */
+FIELD(RT500_CLKCTL0_DSPPLLCLKDIV, HALT, 30, 1);
+/* Divider status flag */
+FIELD(RT500_CLKCTL0_DSPPLLCLKDIV, REQFLAG, 31, 1);
+
+/* AUX0 PLL Clock Divider */
+REG32(RT500_CLKCTL0_AUX0PLLCLKDIV, 584);
+/* Low Frequency Clock Divider Value */
+FIELD(RT500_CLKCTL0_AUX0PLLCLKDIV, DIV, 0, 8);
+/* Resets the divider counter */
+FIELD(RT500_CLKCTL0_AUX0PLLCLKDIV, RESET, 29, 1);
+/* Halts the divider counter */
+FIELD(RT500_CLKCTL0_AUX0PLLCLKDIV, HALT, 30, 1);
+/* Divider status flag */
+FIELD(RT500_CLKCTL0_AUX0PLLCLKDIV, REQFLAG, 31, 1);
+
+/* AUX1 PLL Clock Divider */
+REG32(RT500_CLKCTL0_AUX1PLLCLKDIV, 588);
+/* Low Frequency Clock Divider Value */
+FIELD(RT500_CLKCTL0_AUX1PLLCLKDIV, DIV, 0, 8);
+/* Resets the divider counter */
+FIELD(RT500_CLKCTL0_AUX1PLLCLKDIV, RESET, 29, 1);
+/* Halts the divider counter */
+FIELD(RT500_CLKCTL0_AUX1PLLCLKDIV, HALT, 30, 1);
+/* Divider status flag */
+FIELD(RT500_CLKCTL0_AUX1PLLCLKDIV, REQFLAG, 31, 1);
+
+/* System CPU AHB Clock Divider */
+REG32(RT500_CLKCTL0_SYSCPUAHBCLKDIV, 1024);
+/* Clock Divider Value Selection */
+FIELD(RT500_CLKCTL0_SYSCPUAHBCLKDIV, DIV, 0, 8);
+/* Divider status flag */
+FIELD(RT500_CLKCTL0_SYSCPUAHBCLKDIV, REQFLAG, 31, 1);
+
+/* Main Clock Select A */
+REG32(RT500_CLKCTL0_MAINCLKSELA, 1072);
+/* Control Main 1st Stage Control Clock Source */
+FIELD(RT500_CLKCTL0_MAINCLKSELA, SEL, 0, 2);
+
+/* Main Clock Select B */
+REG32(RT500_CLKCTL0_MAINCLKSELB, 1076);
+/* Main Clock Source Selection */
+FIELD(RT500_CLKCTL0_MAINCLKSELB, SEL, 0, 2);
+
+/* PFC divider 0 (trace clock) */
+REG32(RT500_CLKCTL0_PFC0DIV, 1280);
+/* Clock Divider Value Selection */
+FIELD(RT500_CLKCTL0_PFC0DIV, DIV, 0, 8);
+/* Reset the Divider Counter */
+FIELD(RT500_CLKCTL0_PFC0DIV, RESET, 29, 1);
+/* Halt the Divider Counter */
+FIELD(RT500_CLKCTL0_PFC0DIV, HALT, 30, 1);
+/* Divider status flag */
+FIELD(RT500_CLKCTL0_PFC0DIV, REQFLAG, 31, 1);
+
+/* PFC divider 1 (USB HS PHY bus clock) */
+REG32(RT500_CLKCTL0_PFC1DIV, 1284);
+/* Clock Divider Value Selection */
+FIELD(RT500_CLKCTL0_PFC1DIV, DIV, 0, 8);
+/* Reset the Divider Counter */
+FIELD(RT500_CLKCTL0_PFC1DIV, RESET, 29, 1);
+/* Halt the Divider Counter */
+FIELD(RT500_CLKCTL0_PFC1DIV, HALT, 30, 1);
+/* Divider status flag */
+FIELD(RT500_CLKCTL0_PFC1DIV, REQFLAG, 31, 1);
+
+/* FlexSPI0 Functional Clock Select */
+REG32(RT500_CLKCTL0_FLEXSPI0FCLKSEL, 1568);
+/* Select Clock Source */
+FIELD(RT500_CLKCTL0_FLEXSPI0FCLKSEL, SEL, 0, 3);
+
+/* FlexSPI0 Functional Clock Divider */
+REG32(RT500_CLKCTL0_FLEXSPI0FCLKDIV, 1572);
+/* Clock Divider Value Selection */
+FIELD(RT500_CLKCTL0_FLEXSPI0FCLKDIV, DIV, 0, 8);
+/* Reset the Divider Counter */
+FIELD(RT500_CLKCTL0_FLEXSPI0FCLKDIV, RESET, 29, 1);
+/* Halt the Divider Counter */
+FIELD(RT500_CLKCTL0_FLEXSPI0FCLKDIV, HALT, 30, 1);
+/* Divider status flag */
+FIELD(RT500_CLKCTL0_FLEXSPI0FCLKDIV, REQFLAG, 31, 1);
+
+/* FlexSPI1 Functional Clock Select */
+REG32(RT500_CLKCTL0_FLEXSPI1FCLKSEL, 1584);
+/* Select Clock Source */
+FIELD(RT500_CLKCTL0_FLEXSPI1FCLKSEL, SEL, 0, 3);
+
+/* FlexSPI1 Functional Clock Divider */
+REG32(RT500_CLKCTL0_FLEXSPI1FCLKDIV, 1588);
+/* Clock Divider Value Selection */
+FIELD(RT500_CLKCTL0_FLEXSPI1FCLKDIV, DIV, 0, 8);
+/* Reset the Divider Counter */
+FIELD(RT500_CLKCTL0_FLEXSPI1FCLKDIV, RESET, 29, 1);
+/* Halt the Divider Counter */
+FIELD(RT500_CLKCTL0_FLEXSPI1FCLKDIV, HALT, 30, 1);
+/* Divider status flag */
+FIELD(RT500_CLKCTL0_FLEXSPI1FCLKDIV, REQFLAG, 31, 1);
+
+/* SCT Functional Clock Select */
+REG32(RT500_CLKCTL0_SCTFCLKSEL, 1600);
+/* Select Clock Source */
+FIELD(RT500_CLKCTL0_SCTFCLKSEL, SEL, 0, 3);
+
+/* SCT Functional Clock Divider */
+REG32(RT500_CLKCTL0_SCTIN7CLKDIV, 1604);
+/* Clock Divider Value Selection */
+FIELD(RT500_CLKCTL0_SCTIN7CLKDIV, DIV, 0, 8);
+/* Reset the Divider Counter */
+FIELD(RT500_CLKCTL0_SCTIN7CLKDIV, RESET, 29, 1);
+/* Halt the Divider Counter */
+FIELD(RT500_CLKCTL0_SCTIN7CLKDIV, HALT, 30, 1);
+/* Divider status flag */
+FIELD(RT500_CLKCTL0_SCTIN7CLKDIV, REQFLAG, 31, 1);
+
+/* High Speed USB Functional Clock Select */
+REG32(RT500_CLKCTL0_USBHSFCLKSEL, 1632);
+/* Select Clock Source */
+FIELD(RT500_CLKCTL0_USBHSFCLKSEL, SEL, 0, 3);
+
+/* High Speed USB Functional Clock Divider */
+REG32(RT500_CLKCTL0_USBHSFCLKDIV, 1636);
+/* Clock Divider Value Selection */
+FIELD(RT500_CLKCTL0_USBHSFCLKDIV, DIV, 0, 8);
+/* Reset the Divider Counter */
+FIELD(RT500_CLKCTL0_USBHSFCLKDIV, RESET, 29, 1);
+/* Halt the Divider Counter */
+FIELD(RT500_CLKCTL0_USBHSFCLKDIV, HALT, 30, 1);
+/* Divider status flag */
+FIELD(RT500_CLKCTL0_USBHSFCLKDIV, REQFLAG, 31, 1);
+
+/* SDIO0 Functional Clock Select */
+REG32(RT500_CLKCTL0_SDIO0FCLKSEL, 1664);
+/* Select Clock Source */
+FIELD(RT500_CLKCTL0_SDIO0FCLKSEL, SEL, 0, 3);
+
+/* SDIO0 Functional Clock Divider */
+REG32(RT500_CLKCTL0_SDIO0FCLKDIV, 1668);
+/* Clock Divider Value Selection */
+FIELD(RT500_CLKCTL0_SDIO0FCLKDIV, DIV, 0, 8);
+/* Reset the Divider Counter */
+FIELD(RT500_CLKCTL0_SDIO0FCLKDIV, RESET, 29, 1);
+/* Halt the Divider Counter */
+FIELD(RT500_CLKCTL0_SDIO0FCLKDIV, HALT, 30, 1);
+/* Divider status flag */
+FIELD(RT500_CLKCTL0_SDIO0FCLKDIV, REQFLAG, 31, 1);
+
+/* SDIO1 Functional Clock Select */
+REG32(RT500_CLKCTL0_SDIO1FCLKSEL, 1680);
+/* Select Clock Source */
+FIELD(RT500_CLKCTL0_SDIO1FCLKSEL, SEL, 0, 3);
+
+/* SDIO1 Functional Clock Divider */
+REG32(RT500_CLKCTL0_SDIO1FCLKDIV, 1684);
+/* Clock Divider Value Selection */
+FIELD(RT500_CLKCTL0_SDIO1FCLKDIV, DIV, 0, 8);
+/* Reset the Divider Counter */
+FIELD(RT500_CLKCTL0_SDIO1FCLKDIV, RESET, 29, 1);
+/* Halt the Divider Counter */
+FIELD(RT500_CLKCTL0_SDIO1FCLKDIV, HALT, 30, 1);
+/* Divider status flag */
+FIELD(RT500_CLKCTL0_SDIO1FCLKDIV, REQFLAG, 31, 1);
+
+/* ADC0 Functional Clock Select 0 */
+REG32(RT500_CLKCTL0_ADC0FCLKSEL0, 1744);
+/* Select Clock Source */
+FIELD(RT500_CLKCTL0_ADC0FCLKSEL0, SEL, 0, 3);
+
+/* ADC0 Functional Clock Select 1 */
+REG32(RT500_CLKCTL0_ADC0FCLKSEL1, 1748);
+/* Select Clock Source */
+FIELD(RT500_CLKCTL0_ADC0FCLKSEL1, SEL, 0, 3);
+
+/* ADC0 Functional Clock Divider */
+REG32(RT500_CLKCTL0_ADC0FCLKDIV, 1752);
+/* Clock Divider Value Selection */
+FIELD(RT500_CLKCTL0_ADC0FCLKDIV, DIV, 0, 8);
+/* Reset the Divider Counter */
+FIELD(RT500_CLKCTL0_ADC0FCLKDIV, RESET, 29, 1);
+/* Halt the Divider Counter */
+FIELD(RT500_CLKCTL0_ADC0FCLKDIV, HALT, 30, 1);
+/* Divider status flag */
+FIELD(RT500_CLKCTL0_ADC0FCLKDIV, REQFLAG, 31, 1);
+
+/* UTICK Functional Clock Select */
+REG32(RT500_CLKCTL0_UTICKFCLKSEL, 1792);
+/* Select Clock Source */
+FIELD(RT500_CLKCTL0_UTICKFCLKSEL, SEL, 0, 3);
+
+/* WDT0 Functional Clock Select */
+REG32(RT500_CLKCTL0_WDT0FCLKSEL, 1824);
+/* Select Clock Source */
+FIELD(RT500_CLKCTL0_WDT0FCLKSEL, SEL, 0, 3);
+
+/* 32 KHz Wake Clock Source Select */
+REG32(RT500_CLKCTL0_A32KHZWAKECLKSEL, 1840);
+/* Select Clock Source */
+FIELD(RT500_CLKCTL0_A32KHZWAKECLKSEL, SEL, 0, 3);
+
+/* 32 KHz Wake Clock Divider */
+REG32(RT500_CLKCTL0_A32KHZWAKECLKDIV, 1844);
+/* Clock Divider Value Selection */
+FIELD(RT500_CLKCTL0_A32KHZWAKECLKDIV, DIV, 0, 8);
+/* Reset the Divider Counter */
+FIELD(RT500_CLKCTL0_A32KHZWAKECLKDIV, RESET, 29, 1);
+/* Halt the Divider Counter */
+FIELD(RT500_CLKCTL0_A32KHZWAKECLKDIV, HALT, 30, 1);
+/* Divider status flag */
+FIELD(RT500_CLKCTL0_A32KHZWAKECLKDIV, REQFLAG, 31, 1);
+
+/* SYSTICK Functional Clock Select */
+REG32(RT500_CLKCTL0_SYSTICKFCLKSEL, 1888);
+/* Select Clock Source */
+FIELD(RT500_CLKCTL0_SYSTICKFCLKSEL, SEL, 0, 3);
+
+/* SYSTICK Functional Clock Divider */
+REG32(RT500_CLKCTL0_SYSTICKFCLKDIV, 1892);
+/* Clock Divider Value Selection */
+FIELD(RT500_CLKCTL0_SYSTICKFCLKDIV, DIV, 0, 8);
+/* Reset the Divider Counter */
+FIELD(RT500_CLKCTL0_SYSTICKFCLKDIV, RESET, 29, 1);
+/* Halt the Divider Counter */
+FIELD(RT500_CLKCTL0_SYSTICKFCLKDIV, HALT, 30, 1);
+/* Divider status flag */
+FIELD(RT500_CLKCTL0_SYSTICKFCLKDIV, REQFLAG, 31, 1);
+
+/* MIPI-DSI PHY Clock Select */
+REG32(RT500_CLKCTL0_DPHYCLKSEL, 1904);
+/* Select Clock Source */
+FIELD(RT500_CLKCTL0_DPHYCLKSEL, SEL, 0, 3);
+
+/* MIPI-DSI PHY Clock Divider */
+REG32(RT500_CLKCTL0_DPHYCLKDIV, 1908);
+/* Clock Divider Value Selection */
+FIELD(RT500_CLKCTL0_DPHYCLKDIV, DIV, 0, 8);
+/* Reset the Divider Counter */
+FIELD(RT500_CLKCTL0_DPHYCLKDIV, RESET, 29, 1);
+/* Halt the Divider Counter */
+FIELD(RT500_CLKCTL0_DPHYCLKDIV, HALT, 30, 1);
+/* Divider status flag */
+FIELD(RT500_CLKCTL0_DPHYCLKDIV, REQFLAG, 31, 1);
+
+/* MIPI-DSI DPHY Escape Mode Clock Select */
+REG32(RT500_CLKCTL0_DPHYESCCLKSEL, 1912);
+/* Select Clock Source */
+FIELD(RT500_CLKCTL0_DPHYESCCLKSEL, SEL, 0, 3);
+
+/* MIPI-DSI DPHY Escape Mode Receive Clock Divider */
+REG32(RT500_CLKCTL0_DPHYESCRXCLKDIV, 1916);
+/* Clock Divider Value Selection */
+FIELD(RT500_CLKCTL0_DPHYESCRXCLKDIV, DIV, 0, 8);
+/* Reset the Divider Counter */
+FIELD(RT500_CLKCTL0_DPHYESCRXCLKDIV, RESET, 29, 1);
+/* Halt the Divider Counter */
+FIELD(RT500_CLKCTL0_DPHYESCRXCLKDIV, HALT, 30, 1);
+/* Divider status flag */
+FIELD(RT500_CLKCTL0_DPHYESCRXCLKDIV, REQFLAG, 31, 1);
+
+/* MIPI-DSI DPHY Escape Mode Tramsmit Clock Divider */
+REG32(RT500_CLKCTL0_DPHYESCTXCLKDIV, 1920);
+/* Clock Divider Value Selection */
+FIELD(RT500_CLKCTL0_DPHYESCTXCLKDIV, DIV, 0, 8);
+/* Reset the Divider Counter */
+FIELD(RT500_CLKCTL0_DPHYESCTXCLKDIV, RESET, 29, 1);
+/* Halt the Divider Counter */
+FIELD(RT500_CLKCTL0_DPHYESCTXCLKDIV, HALT, 30, 1);
+/* Divider status flag */
+FIELD(RT500_CLKCTL0_DPHYESCTXCLKDIV, REQFLAG, 31, 1);
+
+/* GPU Clock Select */
+REG32(RT500_CLKCTL0_GPUCLKSEL, 1936);
+/* Select Clock Source */
+FIELD(RT500_CLKCTL0_GPUCLKSEL, SEL, 0, 3);
+
+/* GPU Clock Divider */
+REG32(RT500_CLKCTL0_GPUCLKDIV, 1940);
+/* Clock Divider Value Selection */
+FIELD(RT500_CLKCTL0_GPUCLKDIV, DIV, 0, 8);
+/* Reset the Divider Counter */
+FIELD(RT500_CLKCTL0_GPUCLKDIV, RESET, 29, 1);
+/* Halt the Divider Counter */
+FIELD(RT500_CLKCTL0_GPUCLKDIV, HALT, 30, 1);
+/* Divider status flag */
+FIELD(RT500_CLKCTL0_GPUCLKDIV, REQFLAG, 31, 1);
+
+/* LCDIF Pixel Clock Select */
+REG32(RT500_CLKCTL0_DCPIXELCLKSEL, 1952);
+/* Select Clock Source */
+FIELD(RT500_CLKCTL0_DCPIXELCLKSEL, SEL, 0, 3);
+
+/* LCDIF Pixel Clock Divider */
+REG32(RT500_CLKCTL0_DCPIXELCLKDIV, 1956);
+/* Clock Divider Value Selection */
+FIELD(RT500_CLKCTL0_DCPIXELCLKDIV, DIV, 0, 8);
+/* Reset the Divider Counter */
+FIELD(RT500_CLKCTL0_DCPIXELCLKDIV, RESET, 29, 1);
+/* Halt the Divider Counter */
+FIELD(RT500_CLKCTL0_DCPIXELCLKDIV, HALT, 30, 1);
+/* Divider status flag */
+FIELD(RT500_CLKCTL0_DCPIXELCLKDIV, REQFLAG, 31, 1);
+
+
+typedef enum {
+    /* Disable clock */
+    RT500_CLKCTL0_PSCCTL0_DSP_CLK_CLK_DISABLE = 0,
+    /* Enable clock */
+    RT500_CLKCTL0_PSCCTL0_DSP_CLK_CLK_ENABLE = 1,
+} RT500_CLKCTL0_PSCCTL0_DSP_CLK_Enum;
+
+typedef enum {
+    /* Disable clock */
+    RT500_CLKCTL0_PSCCTL0_ROM_CTRLR_CLK_CLK_DISABLE = 0,
+    /* Enable clock */
+    RT500_CLKCTL0_PSCCTL0_ROM_CTRLR_CLK_CLK_ENABLE = 1,
+} RT500_CLKCTL0_PSCCTL0_ROM_CTRLR_CLK_Enum;
+
+typedef enum {
+    /* Disable clock */
+    RT500_CLKCTL0_PSCCTL0_AXI_SWITCH_CLK_CLK_DISABLE = 0,
+    /* Enable clock */
+    RT500_CLKCTL0_PSCCTL0_AXI_SWITCH_CLK_CLK_ENABLE = 1,
+} RT500_CLKCTL0_PSCCTL0_AXI_SWITCH_CLK_Enum;
+
+typedef enum {
+    /* Disable clock */
+    RT500_CLKCTL0_PSCCTL0_AXI_CTLR_CLK_CLK_DISABLE = 0,
+    /* Enable clock */
+    RT500_CLKCTL0_PSCCTL0_AXI_CTLR_CLK_CLK_ENABLE = 1,
+} RT500_CLKCTL0_PSCCTL0_AXI_CTLR_CLK_Enum;
+
+typedef enum {
+    /* Disable clock */
+    RT500_CLKCTL0_PSCCTL0_POWERQUAD_CLK_CLK_DISABLE = 0,
+    /* Enable clock */
+    RT500_CLKCTL0_PSCCTL0_POWERQUAD_CLK_CLK_ENABLE = 1,
+} RT500_CLKCTL0_PSCCTL0_POWERQUAD_CLK_Enum;
+
+typedef enum {
+    /* Disable clock */
+    RT500_CLKCTL0_PSCCTL0_CASPER_CLK_CLK_DISABLE = 0,
+    /* Enable clock */
+    RT500_CLKCTL0_PSCCTL0_CASPER_CLK_CLK_ENABLE = 1,
+} RT500_CLKCTL0_PSCCTL0_CASPER_CLK_Enum;
+
+typedef enum {
+    /* Disable clock */
+    RT500_CLKCTL0_PSCCTL0_HASHCRYPT_CLK_CLK_DISABLE = 0,
+    /* Enable clock */
+    RT500_CLKCTL0_PSCCTL0_HASHCRYPT_CLK_CLK_ENABLE = 1,
+} RT500_CLKCTL0_PSCCTL0_HASHCRYPT_CLK_Enum;
+
+typedef enum {
+    /* Disable clock */
+    RT500_CLKCTL0_PSCCTL0_PUF_CLK_CLK_DISABLE = 0,
+    /* Enable clock */
+    RT500_CLKCTL0_PSCCTL0_PUF_CLK_CLK_ENABLE = 1,
+} RT500_CLKCTL0_PSCCTL0_PUF_CLK_Enum;
+
+typedef enum {
+    /* Disable clock */
+    RT500_CLKCTL0_PSCCTL0_RNG_CLK_CLK_DISABLE = 0,
+    /* Enable clock */
+    RT500_CLKCTL0_PSCCTL0_RNG_CLK_CLK_ENABLE = 1,
+} RT500_CLKCTL0_PSCCTL0_RNG_CLK_Enum;
+
+typedef enum {
+    /* Disable clock */
+    RT500_CLKCTL0_PSCCTL0_FLEXSPI0_OTFAD_CLK_CLK_DISABLE = 0,
+    /* Enable clock */
+    RT500_CLKCTL0_PSCCTL0_FLEXSPI0_OTFAD_CLK_CLK_ENABLE = 1,
+} RT500_CLKCTL0_PSCCTL0_FLEXSPI0_OTFAD_CLK_Enum;
+
+typedef enum {
+    /* Disable clock */
+    RT500_CLKCTL0_PSCCTL0_OTP_CTLR_CLK_CLK_DISABLE = 0,
+    /* Enable clock */
+    RT500_CLKCTL0_PSCCTL0_OTP_CTLR_CLK_CLK_ENABLE = 1,
+} RT500_CLKCTL0_PSCCTL0_OTP_CTLR_CLK_Enum;
+
+typedef enum {
+    /* Disable clock */
+    RT500_CLKCTL0_PSCCTL0_FLEXSPI1_CLK_CLK_DISABLE = 0,
+    /* Enable clock */
+    RT500_CLKCTL0_PSCCTL0_FLEXSPI1_CLK_CLK_ENABLE = 1,
+} RT500_CLKCTL0_PSCCTL0_FLEXSPI1_CLK_Enum;
+
+typedef enum {
+    /* Disable clock */
+    RT500_CLKCTL0_PSCCTL0_USBHS_PHY_CLK_CLK_DISABLE = 0,
+    /* Enable clock */
+    RT500_CLKCTL0_PSCCTL0_USBHS_PHY_CLK_CLK_ENABLE = 1,
+} RT500_CLKCTL0_PSCCTL0_USBHS_PHY_CLK_Enum;
+
+typedef enum {
+    /* Disable clock */
+    RT500_CLKCTL0_PSCCTL0_USBHS_DEVICE_CLK_CLK_DISABLE = 0,
+    /* Enable clock */
+    RT500_CLKCTL0_PSCCTL0_USBHS_DEVICE_CLK_CLK_ENABLE = 1,
+} RT500_CLKCTL0_PSCCTL0_USBHS_DEVICE_CLK_Enum;
+
+typedef enum {
+    /* Disable clock */
+    RT500_CLKCTL0_PSCCTL0_USBHS_HOST_CLK_CLK_DISABLE = 0,
+    /* Enable clock */
+    RT500_CLKCTL0_PSCCTL0_USBHS_HOST_CLK_CLK_ENABLE = 1,
+} RT500_CLKCTL0_PSCCTL0_USBHS_HOST_CLK_Enum;
+
+typedef enum {
+    /* Disable clock */
+    RT500_CLKCTL0_PSCCTL0_USBHS_SRAM_CLK_CLK_DISABLE = 0,
+    /* Enable clock */
+    RT500_CLKCTL0_PSCCTL0_USBHS_SRAM_CLK_CLK_ENABLE = 1,
+} RT500_CLKCTL0_PSCCTL0_USBHS_SRAM_CLK_Enum;
+
+typedef enum {
+    /* Disable clock */
+    RT500_CLKCTL0_PSCCTL0_SCT_CLK_CLK_DISABLE = 0,
+    /* Enable clock */
+    RT500_CLKCTL0_PSCCTL0_SCT_CLK_CLK_ENABLE = 1,
+} RT500_CLKCTL0_PSCCTL0_SCT_CLK_Enum;
+
+typedef enum {
+    /* Disable clock */
+    RT500_CLKCTL0_PSCCTL0_GPU_CLK_CLK_DISABLE = 0,
+    /* Enable clock */
+    RT500_CLKCTL0_PSCCTL0_GPU_CLK_CLK_ENABLE = 1,
+} RT500_CLKCTL0_PSCCTL0_GPU_CLK_Enum;
+
+typedef enum {
+    /* Disable clock */
+    RT500_CLKCTL0_PSCCTL0_DISPLAY_CTLR_CLK_CLK_DISABLE = 0,
+    /* Enable clock */
+    RT500_CLKCTL0_PSCCTL0_DISPLAY_CTLR_CLK_CLK_ENABLE = 1,
+} RT500_CLKCTL0_PSCCTL0_DISPLAY_CTLR_CLK_Enum;
+
+typedef enum {
+    /* Disable clock */
+    RT500_CLKCTL0_PSCCTL0_MIPI_DSI_CTLR_CLK_CLK_DISABLE = 0,
+    /* Enable clock */
+    RT500_CLKCTL0_PSCCTL0_MIPI_DSI_CTLR_CLK_CLK_ENABLE = 1,
+} RT500_CLKCTL0_PSCCTL0_MIPI_DSI_CTLR_CLK_Enum;
+
+typedef enum {
+    /* Disable clock */
+    RT500_CLKCTL0_PSCCTL0_SMARTDMA_CLK_CLK_DISABLE = 0,
+    /* Enable clock */
+    RT500_CLKCTL0_PSCCTL0_SMARTDMA_CLK_CLK_ENABLE = 1,
+} RT500_CLKCTL0_PSCCTL0_SMARTDMA_CLK_Enum;
+
+typedef enum {
+    /* Disable clock */
+    RT500_CLKCTL0_PSCCTL1_SDIO0_CLK_CLK_DISABLE = 0,
+    /* Enable clock */
+    RT500_CLKCTL0_PSCCTL1_SDIO0_CLK_CLK_ENABLE = 1,
+} RT500_CLKCTL0_PSCCTL1_SDIO0_CLK_Enum;
+
+typedef enum {
+    /* Disable clock */
+    RT500_CLKCTL0_PSCCTL1_SDIO1_CLK_CLK_DISABLE = 0,
+    /* Enable clock */
+    RT500_CLKCTL0_PSCCTL1_SDIO1_CLK_CLK_ENABLE = 1,
+} RT500_CLKCTL0_PSCCTL1_SDIO1_CLK_Enum;
+
+typedef enum {
+    /* Disable clock */
+    RT500_CLKCTL0_PSCCTL1_ACMP0_CLK_CLK_DISABLE = 0,
+    /* Enable clock */
+    RT500_CLKCTL0_PSCCTL1_ACMP0_CLK_CLK_ENABLE = 1,
+} RT500_CLKCTL0_PSCCTL1_ACMP0_CLK_Enum;
+
+typedef enum {
+    /* Disable clock */
+    RT500_CLKCTL0_PSCCTL1_ADC0_CLK_CLK_DISABLE = 0,
+    /* Enable clock */
+    RT500_CLKCTL0_PSCCTL1_ADC0_CLK_CLK_ENABLE = 1,
+} RT500_CLKCTL0_PSCCTL1_ADC0_CLK_Enum;
+
+typedef enum {
+    /* Disable clock */
+    RT500_CLKCTL0_PSCCTL1_SHSGPIO0_CLK_CLK_DISABLE = 0,
+    /* Enable clock */
+    RT500_CLKCTL0_PSCCTL1_SHSGPIO0_CLK_CLK_ENABLE = 1,
+} RT500_CLKCTL0_PSCCTL1_SHSGPIO0_CLK_Enum;
+
+typedef enum {
+    /* Disable clock */
+    RT500_CLKCTL0_PSCCTL2_UTICK0_CLK_CLK_DISABLE = 0,
+    /* Enable clock */
+    RT500_CLKCTL0_PSCCTL2_UTICK0_CLK_CLK_ENABLE = 1,
+} RT500_CLKCTL0_PSCCTL2_UTICK0_CLK_Enum;
+
+typedef enum {
+    /* Disable clock */
+    RT500_CLKCTL0_PSCCTL2_WWDT0_CLK_CLK_DISABLE = 0,
+    /* Enable clock */
+    RT500_CLKCTL0_PSCCTL2_WWDT0_CLK_CLK_ENABLE = 1,
+} RT500_CLKCTL0_PSCCTL2_WWDT0_CLK_Enum;
+
+typedef enum {
+    /* Disable clock */
+    RT500_CLKCTL0_PSCCTL2_PMC_CLK_CLK_DISABLE = 0,
+    /* Enable clock */
+    RT500_CLKCTL0_PSCCTL2_PMC_CLK_CLK_ENABLE = 1,
+} RT500_CLKCTL0_PSCCTL2_PMC_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL0_SET_DSP_CLK_NO_EFFECT = 0,
+    /* Sets the corresponding bit in PSCCTL0 register */
+    RT500_CLKCTL0_PSCCTL0_SET_DSP_CLK_CLK_ENABLE_SET = 1,
+} RT500_CLKCTL0_PSCCTL0_SET_DSP_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL0_SET_ROM_CTRLR_CLK_NO_EFFECT = 0,
+    /* Sets the corresponding bit in PSCCTL0 register */
+    RT500_CLKCTL0_PSCCTL0_SET_ROM_CTRLR_CLK_CLK_ENABLE_SET = 1,
+} RT500_CLKCTL0_PSCCTL0_SET_ROM_CTRLR_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL0_SET_AXI_SWITCH_CLK_NO_EFFECT = 0,
+    /* Sets the corresponding bit in PSCCTL0 register */
+    RT500_CLKCTL0_PSCCTL0_SET_AXI_SWITCH_CLK_CLK_ENABLE_SET = 1,
+} RT500_CLKCTL0_PSCCTL0_SET_AXI_SWITCH_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL0_SET_AXI_CTLR_CLK_NO_EFFECT = 0,
+    /* Sets the corresponding bit in PSCCTL0 register */
+    RT500_CLKCTL0_PSCCTL0_SET_AXI_CTLR_CLK_CLK_ENABLE_SET = 1,
+} RT500_CLKCTL0_PSCCTL0_SET_AXI_CTLR_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL0_SET_POWERQUAD_CLK_NO_EFFECT = 0,
+    /* Sets the corresponding bit in PSCCTL0 register */
+    RT500_CLKCTL0_PSCCTL0_SET_POWERQUAD_CLK_CLK_ENABLE_SET = 1,
+} RT500_CLKCTL0_PSCCTL0_SET_POWERQUAD_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL0_SET_CASPER_CLK_NO_EFFECT = 0,
+    /* Sets the corresponding bit in PSCCTL0 register */
+    RT500_CLKCTL0_PSCCTL0_SET_CASPER_CLK_CLK_ENABLE_SET = 1,
+} RT500_CLKCTL0_PSCCTL0_SET_CASPER_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL0_SET_HASHCRYPT_CLK_NO_EFFECT = 0,
+    /* Sets the corresponding bit in PSCCTL0 register */
+    RT500_CLKCTL0_PSCCTL0_SET_HASHCRYPT_CLK_CLK_ENABLE_SET = 1,
+} RT500_CLKCTL0_PSCCTL0_SET_HASHCRYPT_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL0_SET_PUF_CLK_NO_EFFECT = 0,
+    /* Sets the corresponding bit in PSCCTL0 register */
+    RT500_CLKCTL0_PSCCTL0_SET_PUF_CLK_CLK_ENABLE_SET = 1,
+} RT500_CLKCTL0_PSCCTL0_SET_PUF_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL0_SET_RNG_CLK_NO_EFFECT = 0,
+    /* Sets the corresponding bit in PSCCTL0 register */
+    RT500_CLKCTL0_PSCCTL0_SET_RNG_CLK_CLK_ENABLE_SET = 1,
+} RT500_CLKCTL0_PSCCTL0_SET_RNG_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL0_SET_FLEXSPI0_OTFAD_CLK_NO_EFFECT = 0,
+    /* Sets the corresponding bit in PSCCTL0 register */
+    RT500_CLKCTL0_PSCCTL0_SET_FLEXSPI0_OTFAD_CLK_CLK_ENABLE_SET = 1,
+} RT500_CLKCTL0_PSCCTL0_SET_FLEXSPI0_OTFAD_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL0_SET_OTP_CTLR_CLK_NO_EFFECT = 0,
+    /* Sets the corresponding bit in PSCCTL0 register */
+    RT500_CLKCTL0_PSCCTL0_SET_OTP_CTLR_CLK_CLK_ENABLE_SET = 1,
+} RT500_CLKCTL0_PSCCTL0_SET_OTP_CTLR_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL0_SET_FLEXSPI1_CLK_NO_EFFECT = 0,
+    /* Sets the corresponding bit in PSCCTL0 register */
+    RT500_CLKCTL0_PSCCTL0_SET_FLEXSPI1_CLK_CLK_ENABLE_SET = 1,
+} RT500_CLKCTL0_PSCCTL0_SET_FLEXSPI1_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL0_SET_USBHS_PHY_CLK_NO_EFFECT = 0,
+    /* Sets the corresponding bit in PSCCTL0 register */
+    RT500_CLKCTL0_PSCCTL0_SET_USBHS_PHY_CLK_CLK_ENABLE_SET = 1,
+} RT500_CLKCTL0_PSCCTL0_SET_USBHS_PHY_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL0_SET_USBHS_DEVICE_CLK_NO_EFFECT = 0,
+    /* Sets the corresponding bit in PSCCTL0 register */
+    RT500_CLKCTL0_PSCCTL0_SET_USBHS_DEVICE_CLK_CLK_ENABLE_SET = 1,
+} RT500_CLKCTL0_PSCCTL0_SET_USBHS_DEVICE_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL0_SET_USBHS_HOST_CLK_NO_EFFECT = 0,
+    /* Sets the corresponding bit in PSCCTL0 register */
+    RT500_CLKCTL0_PSCCTL0_SET_USBHS_HOST_CLK_CLK_ENABLE_SET = 1,
+} RT500_CLKCTL0_PSCCTL0_SET_USBHS_HOST_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL0_SET_USBHS_SRAM_CLK_NO_EFFECT = 0,
+    /* Sets the corresponding bit in PSCCTL0 register */
+    RT500_CLKCTL0_PSCCTL0_SET_USBHS_SRAM_CLK_CLK_ENABLE_SET = 1,
+} RT500_CLKCTL0_PSCCTL0_SET_USBHS_SRAM_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL0_SET_SCT_CLK_NO_EFFECT = 0,
+    /* Sets the corresponding bit in PSCCTL0 register */
+    RT500_CLKCTL0_PSCCTL0_SET_SCT_CLK_CLK_ENABLE_SET = 1,
+} RT500_CLKCTL0_PSCCTL0_SET_SCT_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL0_SET_GPU_CLK_NO_EFFECT = 0,
+    /* Sets the corresponding bit in PSCCTL0 register */
+    RT500_CLKCTL0_PSCCTL0_SET_GPU_CLK_CLK_ENABLE_SET = 1,
+} RT500_CLKCTL0_PSCCTL0_SET_GPU_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL0_SET_DISPLAY_CTLR_CLK_NO_EFFECT = 0,
+    /* Sets the corresponding bit in PSCCTL0 register */
+    RT500_CLKCTL0_PSCCTL0_SET_DISPLAY_CTLR_CLK_CLK_ENABLE_SET = 1,
+} RT500_CLKCTL0_PSCCTL0_SET_DISPLAY_CTLR_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL0_SET_MIPI_DSI_CTLR_CLK_NO_EFFECT = 0,
+    /* Sets the corresponding bit in PSCCTL0 register */
+    RT500_CLKCTL0_PSCCTL0_SET_MIPI_DSI_CTLR_CLK_CLK_ENABLE_SET = 1,
+} RT500_CLKCTL0_PSCCTL0_SET_MIPI_DSI_CTLR_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL0_SET_SMARTDMA_CLK_NO_EFFECT = 0,
+    /* Sets the corresponding bit in PSCCTL0 register */
+    RT500_CLKCTL0_PSCCTL0_SET_SMARTDMA_CLK_CLK_ENABLE_SET = 1,
+} RT500_CLKCTL0_PSCCTL0_SET_SMARTDMA_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL1_SET_SDIO0_CLK_NO_EFFECT = 0,
+    /* Sets the corresponding bit in PSCCTL1 register */
+    RT500_CLKCTL0_PSCCTL1_SET_SDIO0_CLK_CLK_ENABLE_SET = 1,
+} RT500_CLKCTL0_PSCCTL1_SET_SDIO0_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL1_SET_SDIO1_CLK_NO_EFFECT = 0,
+    /* Sets the corresponding bit in PSCCTL1 register */
+    RT500_CLKCTL0_PSCCTL1_SET_SDIO1_CLK_CLK_ENABLE_SET = 1,
+} RT500_CLKCTL0_PSCCTL1_SET_SDIO1_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL1_SET_ACMP0_CLK_NO_EFFECT = 0,
+    /* Sets the corresponding bit in PSCCTL1 register */
+    RT500_CLKCTL0_PSCCTL1_SET_ACMP0_CLK_CLK_ENABLE_SET = 1,
+} RT500_CLKCTL0_PSCCTL1_SET_ACMP0_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL1_SET_ADC0_CLK_NO_EFFECT = 0,
+    /* Sets the corresponding bit in PSCCTL1 register */
+    RT500_CLKCTL0_PSCCTL1_SET_ADC0_CLK_CLK_ENABLE_SET = 1,
+} RT500_CLKCTL0_PSCCTL1_SET_ADC0_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL1_SET_SHSGPIO0_CLK_NO_EFFECT = 0,
+    /* Sets the corresponding bit in PSCCTL1 register */
+    RT500_CLKCTL0_PSCCTL1_SET_SHSGPIO0_CLK_CLK_ENABLE_SET = 1,
+} RT500_CLKCTL0_PSCCTL1_SET_SHSGPIO0_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL2_SET_UTICK0_CLK_NO_EFFECT = 0,
+    /* Sets the corresponding bit in PSCCTL2 register */
+    RT500_CLKCTL0_PSCCTL2_SET_UTICK0_CLK_CLK_ENABLE_SET = 1,
+} RT500_CLKCTL0_PSCCTL2_SET_UTICK0_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL2_SET_WWDT0_CLK_NO_EFFECT = 0,
+    /* Sets the corresponding bit in PSCCTL2 register */
+    RT500_CLKCTL0_PSCCTL2_SET_WWDT0_CLK_CLK_ENABLE_SET = 1,
+} RT500_CLKCTL0_PSCCTL2_SET_WWDT0_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL2_SET_PMC_NO_EFFECT = 0,
+    /* Sets the corresponding bit in PSCCTL2 register */
+    RT500_CLKCTL0_PSCCTL2_SET_PMC_CLK_ENABLE_SET = 1,
+} RT500_CLKCTL0_PSCCTL2_SET_PMC_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL0_CLR_DSP_CLK_NO_EFFECT = 0,
+    /* Clears the corresponding bit in PSCCTL0 register */
+    RT500_CLKCTL0_PSCCTL0_CLR_DSP_CLK_CLK_ENABLE_CLEAR = 1,
+} RT500_CLKCTL0_PSCCTL0_CLR_DSP_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL0_CLR_ROM_CTRLR_CLK_NO_EFFECT = 0,
+    /* Clears the corresponding bit in PSCCTL0 register */
+    RT500_CLKCTL0_PSCCTL0_CLR_ROM_CTRLR_CLK_CLK_ENABLE_CLEAR = 1,
+} RT500_CLKCTL0_PSCCTL0_CLR_ROM_CTRLR_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL0_CLR_AXI_SWITCH_CLK_NO_EFFECT = 0,
+    /* Clears the corresponding bit in PSCCTL0 register */
+    RT500_CLKCTL0_PSCCTL0_CLR_AXI_SWITCH_CLK_CLK_ENABLE_CLEAR = 1,
+} RT500_CLKCTL0_PSCCTL0_CLR_AXI_SWITCH_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL0_CLR_AXI_CTLR_CLK_NO_EFFECT = 0,
+    /* Clears the corresponding bit in PSCCTL0 register */
+    RT500_CLKCTL0_PSCCTL0_CLR_AXI_CTLR_CLK_CLK_ENABLE_CLEAR = 1,
+} RT500_CLKCTL0_PSCCTL0_CLR_AXI_CTLR_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL0_CLR_POWERQUAD_CLK_NO_EFFECT = 0,
+    /* Clears the corresponding bit in PSCCTL0 register */
+    RT500_CLKCTL0_PSCCTL0_CLR_POWERQUAD_CLK_CLK_ENABLE_CLEAR = 1,
+} RT500_CLKCTL0_PSCCTL0_CLR_POWERQUAD_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL0_CLR_CASPER_CLK_NO_EFFECT = 0,
+    /* Clears the corresponding bit in PSCCTL0 register */
+    RT500_CLKCTL0_PSCCTL0_CLR_CASPER_CLK_CLK_ENABLE_CLEAR = 1,
+} RT500_CLKCTL0_PSCCTL0_CLR_CASPER_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL0_CLR_HASHCRYPT_CLK_NO_EFFECT = 0,
+    /* Clears the corresponding bit in PSCCTL0 register */
+    RT500_CLKCTL0_PSCCTL0_CLR_HASHCRYPT_CLK_CLK_ENABLE_CLEAR = 1,
+} RT500_CLKCTL0_PSCCTL0_CLR_HASHCRYPT_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL0_CLR_PUF_CLK_NO_EFFECT = 0,
+    /* Clears the corresponding bit in PSCCTL0 register */
+    RT500_CLKCTL0_PSCCTL0_CLR_PUF_CLK_CLK_ENABLE_CLEAR = 1,
+} RT500_CLKCTL0_PSCCTL0_CLR_PUF_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL0_CLR_RNG_CLK_NO_EFFECT = 0,
+    /* Clears the corresponding bit in PSCCTL0 register */
+    RT500_CLKCTL0_PSCCTL0_CLR_RNG_CLK_CLK_ENABLE_CLEAR = 1,
+} RT500_CLKCTL0_PSCCTL0_CLR_RNG_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL0_CLR_FLEXSPI0_OTFAD_CLK_NO_EFFECT = 0,
+    /* Clears the corresponding bit in PSCCTL0 register */
+    RT500_CLKCTL0_PSCCTL0_CLR_FLEXSPI0_OTFAD_CLK_CLK_ENABLE_CLEAR = 1,
+} RT500_CLKCTL0_PSCCTL0_CLR_FLEXSPI0_OTFAD_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL0_CLR_OTP_CTLR_CLK_NO_EFFECT = 0,
+    /* Clears the corresponding bit in PSCCTL0 register */
+    RT500_CLKCTL0_PSCCTL0_CLR_OTP_CTLR_CLK_CLK_ENABLE_CLEAR = 1,
+} RT500_CLKCTL0_PSCCTL0_CLR_OTP_CTLR_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL0_CLR_FLEXSPI1_CLK_NO_EFFECT = 0,
+    /* Clears the corresponding bit in PSCCTL0 register */
+    RT500_CLKCTL0_PSCCTL0_CLR_FLEXSPI1_CLK_CLK_ENABLE_CLEAR = 1,
+} RT500_CLKCTL0_PSCCTL0_CLR_FLEXSPI1_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL0_CLR_USBHS_PHY_CLK_NO_EFFECT = 0,
+    /* Clears the corresponding bit in PSCCTL0 register */
+    RT500_CLKCTL0_PSCCTL0_CLR_USBHS_PHY_CLK_CLK_ENABLE_CLEAR = 1,
+} RT500_CLKCTL0_PSCCTL0_CLR_USBHS_PHY_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL0_CLR_USBHS_DEVICE_CLK_NO_EFFECT = 0,
+    /* Clears the corresponding bit in PSCCTL0 register */
+    RT500_CLKCTL0_PSCCTL0_CLR_USBHS_DEVICE_CLK_CLK_ENABLE_CLEAR = 1,
+} RT500_CLKCTL0_PSCCTL0_CLR_USBHS_DEVICE_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL0_CLR_USBHS_HOST_CLK_NO_EFFECT = 0,
+    /* Clears the corresponding bit in PSCCTL0 register */
+    RT500_CLKCTL0_PSCCTL0_CLR_USBHS_HOST_CLK_CLK_ENABLE_CLEAR = 1,
+} RT500_CLKCTL0_PSCCTL0_CLR_USBHS_HOST_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL0_CLR_USBHS_SRAM_CLK_NO_EFFECT = 0,
+    /* Clears the corresponding bit in PSCCTL0 register */
+    RT500_CLKCTL0_PSCCTL0_CLR_USBHS_SRAM_CLK_CLK_ENABLE_CLEAR = 1,
+} RT500_CLKCTL0_PSCCTL0_CLR_USBHS_SRAM_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL0_CLR_SCT_CLK_NO_EFFECT = 0,
+    /* Clears the corresponding bit in PSCCTL0 register */
+    RT500_CLKCTL0_PSCCTL0_CLR_SCT_CLK_CLK_ENABLE_CLEAR = 1,
+} RT500_CLKCTL0_PSCCTL0_CLR_SCT_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL0_CLR_GPU_CLK_NO_EFFECT = 0,
+    /* Clears the corresponding bit in PSCCTL0 register */
+    RT500_CLKCTL0_PSCCTL0_CLR_GPU_CLK_CLK_ENABLE_CLEAR = 1,
+} RT500_CLKCTL0_PSCCTL0_CLR_GPU_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL0_CLR_DISPLAY_CTLR_CLK_NO_EFFECT = 0,
+    /* Clears the corresponding bit in PSCCTL0 register */
+    RT500_CLKCTL0_PSCCTL0_CLR_DISPLAY_CTLR_CLK_CLK_ENABLE_CLEAR = 1,
+} RT500_CLKCTL0_PSCCTL0_CLR_DISPLAY_CTLR_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL0_CLR_MIPI_DSI_CTLR_CLK_NO_EFFECT = 0,
+    /* Clears the corresponding bit in PSCCTL0 register */
+    RT500_CLKCTL0_PSCCTL0_CLR_MIPI_DSI_CTLR_CLK_CLK_ENABLE_CLEAR = 1,
+} RT500_CLKCTL0_PSCCTL0_CLR_MIPI_DSI_CTLR_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL0_CLR_SMARTDMA_CLK_NO_EFFECT = 0,
+    /* Clears the corresponding bit in PSCCTL0 register */
+    RT500_CLKCTL0_PSCCTL0_CLR_SMARTDMA_CLK_CLK_ENABLE_CLEAR = 1,
+} RT500_CLKCTL0_PSCCTL0_CLR_SMARTDMA_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL1_CLR_SDIO0_CLK_NO_EFFECT = 0,
+    /* Clears the corresponding bit in PSCCTL1 register */
+    RT500_CLKCTL0_PSCCTL1_CLR_SDIO0_CLK_CLK_ENABLE_CLEAR = 1,
+} RT500_CLKCTL0_PSCCTL1_CLR_SDIO0_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL1_CLR_SDIO1_CLK_NO_EFFECT = 0,
+    /* Clears the corresponding bit in PSCCTL1 register */
+    RT500_CLKCTL0_PSCCTL1_CLR_SDIO1_CLK_CLK_ENABLE_CLEAR = 1,
+} RT500_CLKCTL0_PSCCTL1_CLR_SDIO1_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL1_CLR_ACMP0_CLK_NO_EFFECT = 0,
+    /* Clears the corresponding bit in PSCCTL1 register */
+    RT500_CLKCTL0_PSCCTL1_CLR_ACMP0_CLK_CLK_ENABLE_CLEAR = 1,
+} RT500_CLKCTL0_PSCCTL1_CLR_ACMP0_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL1_CLR_ADC0_CLK_NO_EFFECT = 0,
+    /* Clears the corresponding bit in PSCCTL1 register */
+    RT500_CLKCTL0_PSCCTL1_CLR_ADC0_CLK_CLK_ENABLE_CLEAR = 1,
+} RT500_CLKCTL0_PSCCTL1_CLR_ADC0_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL1_CLR_SHSGPIO0_CLK_NO_EFFECT = 0,
+    /* Clears the corresponding bit in PSCCTL1 register */
+    RT500_CLKCTL0_PSCCTL1_CLR_SHSGPIO0_CLK_CLK_ENABLE_CLEAR = 1,
+} RT500_CLKCTL0_PSCCTL1_CLR_SHSGPIO0_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL2_CLR_UTICK0_CLK_NO_EFFECT = 0,
+    /* Clears the corresponding bit in PSCCTL2 register */
+    RT500_CLKCTL0_PSCCTL2_CLR_UTICK0_CLK_CLK_ENABLE_CLEAR = 1,
+} RT500_CLKCTL0_PSCCTL2_CLR_UTICK0_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL2_CLR_WWDT0_CLK_NO_EFFECT = 0,
+    /* Clears the corresponding bit in PSCCTL2 register */
+    RT500_CLKCTL0_PSCCTL2_CLR_WWDT0_CLK_CLK_ENABLE_CLEAR = 1,
+} RT500_CLKCTL0_PSCCTL2_CLR_WWDT0_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PSCCTL2_CLR_PMC_CLK_NO_EFFECT = 0,
+    /* Clears the corresponding bit in PSCCTL2 register */
+    RT500_CLKCTL0_PSCCTL2_CLR_PMC_CLK_CLK_ENABLE_CLEAR = 1,
+} RT500_CLKCTL0_PSCCTL2_CLR_PMC_CLK_Enum;
+
+typedef enum {
+    /* Stop tuning */
+    RT500_CLKCTL0_FRO_CONTROL_ENA_TUNE_ENA_TUNE_CLEAR = 0,
+    /* Start tuning */
+    RT500_CLKCTL0_FRO_CONTROL_ENA_TUNE_ENA_TUNE_START = 1,
+} RT500_CLKCTL0_FRO_CONTROL_ENA_TUNE_Enum;
+
+typedef enum {
+    /* CAPVAL data is not valid */
+    RT500_CLKCTL0_FRO_CAPVAL_DATA_VALID_DATA_NOT_VALID = 0,
+    /* CAPVAL data is valid */
+    RT500_CLKCTL0_FRO_CAPVAL_DATA_VALID_DATA_VALID = 1,
+} RT500_CLKCTL0_FRO_CAPVAL_DATA_VALID_Enum;
+
+typedef enum {
+    /* FRO_DIV2 */
+    RT500_CLKCTL0_FRODIVSEL_SEL_DIVIDEBY2 = 0,
+    /* FRO_DIV4 */
+    RT500_CLKCTL0_FRODIVSEL_SEL_DIVIDEBY4 = 1,
+    /* FRO_DIV8 */
+    RT500_CLKCTL0_FRODIVSEL_SEL_DIVIDEBY8 = 2,
+    /* FRO_DIV16 */
+    RT500_CLKCTL0_FRODIVSEL_SEL_DIVIDEBY16 = 3,
+} RT500_CLKCTL0_FRODIVSEL_SEL_Enum;
+
+typedef enum {
+    /* FRO clock has not yet reached 10% frequency accuracy */
+    RT500_CLKCTL0_FROCLKSTATUS_CLK_OK_CLK_NOT_OK = 0,
+    /* FRO clock has reached 10% frequency accuracy */
+    RT500_CLKCTL0_FROCLKSTATUS_CLK_OK_CLK_OK = 1,
+} RT500_CLKCTL0_FROCLKSTATUS_CLK_OK_Enum;
+
+typedef enum {
+    /* Disable clock */
+    RT500_CLKCTL0_FRODIVOEN_FRO_DIV1_O_EN_CLK_DISABLE = 0,
+    /* Enable clock */
+    RT500_CLKCTL0_FRODIVOEN_FRO_DIV1_O_EN_CLK_ENABLE = 1,
+} RT500_CLKCTL0_FRODIVOEN_FRO_DIV1_O_EN_Enum;
+
+typedef enum {
+    /* Disable clock */
+    RT500_CLKCTL0_FRODIVOEN_FRO_DIV2_O_EN_CLK_DISABLE = 0,
+    /* Enable clock */
+    RT500_CLKCTL0_FRODIVOEN_FRO_DIV2_O_EN_CLK_ENABLE = 1,
+} RT500_CLKCTL0_FRODIVOEN_FRO_DIV2_O_EN_Enum;
+
+typedef enum {
+    /* Disable clock */
+    RT500_CLKCTL0_FRODIVOEN_FRO_DIV4_O_EN_CLK_DISABLE = 0,
+    /* Enable clock */
+    RT500_CLKCTL0_FRODIVOEN_FRO_DIV4_O_EN_CLK_ENABLE = 1,
+} RT500_CLKCTL0_FRODIVOEN_FRO_DIV4_O_EN_Enum;
+
+typedef enum {
+    /* Disable clock */
+    RT500_CLKCTL0_FRODIVOEN_FRO_DIV8_O_EN_CLK_DISABLE = 0,
+    /* Enable clock */
+    RT500_CLKCTL0_FRODIVOEN_FRO_DIV8_O_EN_CLK_ENABLE = 1,
+} RT500_CLKCTL0_FRODIVOEN_FRO_DIV8_O_EN_Enum;
+
+typedef enum {
+    /* Disable clock */
+    RT500_CLKCTL0_FRODIVOEN_FRO_DIV16_O_EN_CLK_DISABLE = 0,
+    /* Enable clock */
+    RT500_CLKCTL0_FRODIVOEN_FRO_DIV16_O_EN_CLK_ENABLE = 1,
+} RT500_CLKCTL0_FRODIVOEN_FRO_DIV16_O_EN_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_LOWFREQCLKDIV_RESET_DIVIDER_COUNTER_NOT_RESET = 0,
+    /* Reset the Divider Counter */
+    RT500_CLKCTL0_LOWFREQCLKDIV_RESET_DIVIDER_COUNTER_RESET = 1,
+} RT500_CLKCTL0_LOWFREQCLKDIV_RESET_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_LOWFREQCLKDIV_HALT_DIVIDER_COUNTER_NOT_HALT = 0,
+    /* Halt (stop) the Divider Counter */
+    RT500_CLKCTL0_LOWFREQCLKDIV_HALT_DIVIDER_COUNTER_HALT = 1,
+} RT500_CLKCTL0_LOWFREQCLKDIV_HALT_Enum;
+
+typedef enum {
+    /* The Divider change has finished */
+    RT500_CLKCTL0_LOWFREQCLKDIV_REQFLAG_REQFLAG_CHANGE_FINISHED = 0,
+    /* The Divider value has changed */
+    RT500_CLKCTL0_LOWFREQCLKDIV_REQFLAG_REQFLAG_CHANGED = 1,
+} RT500_CLKCTL0_LOWFREQCLKDIV_REQFLAG_Enum;
+
+typedef enum {
+    /* Enable High Gain Mode (HP) */
+    RT500_CLKCTL0_SYSOSCCTL0_LP_ENABLE_HIGH_GAIN_ENABLE = 0,
+    /* Enable Low Power mode (LP) */
+    RT500_CLKCTL0_SYSOSCCTL0_LP_ENABLE_LOW_POWER_ENABLE = 1,
+} RT500_CLKCTL0_SYSOSCCTL0_LP_ENABLE_Enum;
+
+typedef enum {
+    /* Enable Normal mode. Oscillation with crystal connected. */
+    RT500_CLKCTL0_SYSOSCCTL0_BYPASS_ENABLE_NORMAL_ENABLE = 0,
+    /*
+     * Enable Bypass mode. In this mode a clock can be directly input into the
+     * XTALIN pin.
+     */
+    RT500_CLKCTL0_SYSOSCCTL0_BYPASS_ENABLE_BYPASS_ENABLE = 1,
+} RT500_CLKCTL0_SYSOSCCTL0_BYPASS_ENABLE_Enum;
+
+typedef enum {
+    /* Select OSC Clock */
+    RT500_CLKCTL0_SYSOSCBYPASS_SEL_SYOSC_CLOCK = 0,
+    /* Select Clock IN clock */
+    RT500_CLKCTL0_SYSOSCBYPASS_SEL_CLOCK_IN = 1,
+    /* None; this may be selected to reduce power when no output is needed */
+    RT500_CLKCTL0_SYSOSCBYPASS_SEL_NONE = 7,
+} RT500_CLKCTL0_SYSOSCBYPASS_SEL_Enum;
+
+typedef enum {
+    /* LPOSC clock is not ready */
+    RT500_CLKCTL0_LPOSCCTL0_CLKRDY_CLK_NOT_READY = 0,
+    /* LPOSC clock is ready */
+    RT500_CLKCTL0_LPOSCCTL0_CLKRDY_CLK_READY = 1,
+} RT500_CLKCTL0_LPOSCCTL0_CLKRDY_Enum;
+
+typedef enum {
+    /* Disable oscillator */
+    RT500_CLKCTL0_OSC32KHZCTL0_ENA32KHZ_ENA32KHZ_DISABLE = 0,
+    /* Enable oscillator */
+    RT500_CLKCTL0_OSC32KHZCTL0_ENA32KHZ_ENA32KHZ_ENABLE = 1,
+} RT500_CLKCTL0_OSC32KHZCTL0_ENA32KHZ_Enum;
+
+typedef enum {
+    /* FRO_DIV8 Clock */
+    RT500_CLKCTL0_SYSPLL0CLKSEL_SEL_FRRO_DIV8 = 0,
+    /* OSC_CLK clock */
+    RT500_CLKCTL0_SYSPLL0CLKSEL_SEL_OSC_CLK = 1,
+    /* None, output gated to reduce power */
+    RT500_CLKCTL0_SYSPLL0CLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL0_SYSPLL0CLKSEL_SEL_Enum;
+
+typedef enum {
+    /* PFD outputs are PFD-programmed clocks */
+    RT500_CLKCTL0_SYSPLL0CTL0_BYPASS_PFD = 0,
+    /*
+     * Bypass Mode: PFD outputs are sourced directly from rhe reference input
+     * clock
+     */
+    RT500_CLKCTL0_SYSPLL0CTL0_BYPASS_BYPASS = 1,
+} RT500_CLKCTL0_SYSPLL0CTL0_BYPASS_Enum;
+
+typedef enum {
+    /* SYSPLL0 reset is removed */
+    RT500_CLKCTL0_SYSPLL0CTL0_RESET_NO_RESET = 0,
+    /* SYSPLL0 is placed into reset */
+    RT500_CLKCTL0_SYSPLL0CTL0_RESET_RESET = 1,
+} RT500_CLKCTL0_SYSPLL0CTL0_RESET_Enum;
+
+typedef enum {
+    /* Disable */
+    RT500_CLKCTL0_SYSPLL0CTL0_HOLDRINGOFF_ENA_DISABLE = 0,
+    /* Enable */
+    RT500_CLKCTL0_SYSPLL0CTL0_HOLDRINGOFF_ENA_ENABLE = 1,
+} RT500_CLKCTL0_SYSPLL0CTL0_HOLDRINGOFF_ENA_Enum;
+
+typedef enum {
+    /* Multiply by 16 */
+    RT500_CLKCTL0_SYSPLL0CTL0_MULT_DIV16 = 16,
+    /* Multiply by 17 */
+    RT500_CLKCTL0_SYSPLL0CTL0_MULT_DIV17 = 17,
+    /* Multiply by 18 */
+    RT500_CLKCTL0_SYSPLL0CTL0_MULT_DIV18 = 18,
+    /* Multiply by 19 */
+    RT500_CLKCTL0_SYSPLL0CTL0_MULT_DIV19 = 19,
+    /* Multiply by 20 */
+    RT500_CLKCTL0_SYSPLL0CTL0_MULT_DIV20 = 20,
+    /* Multiply by 21 */
+    RT500_CLKCTL0_SYSPLL0CTL0_MULT_DIV21 = 21,
+    /* Multiply by 22 */
+    RT500_CLKCTL0_SYSPLL0CTL0_MULT_DIV22 = 22,
+} RT500_CLKCTL0_SYSPLL0CTL0_MULT_Enum;
+
+typedef enum {
+    /* PFD0 clock is not ready */
+    RT500_CLKCTL0_SYSPLL0PFD_PFD0_CLKRDY_NOTREADY = 0,
+    /* PFD0 clock is ready */
+    RT500_CLKCTL0_SYSPLL0PFD_PFD0_CLKRDY_READY = 1,
+} RT500_CLKCTL0_SYSPLL0PFD_PFD0_CLKRDY_Enum;
+
+typedef enum {
+    /* PFD0 clock is not gated */
+    RT500_CLKCTL0_SYSPLL0PFD_PFD0_CLKGATE_NOTGATED = 0,
+    /* PFD0 clock is gated */
+    RT500_CLKCTL0_SYSPLL0PFD_PFD0_CLKGATE_GATED = 1,
+} RT500_CLKCTL0_SYSPLL0PFD_PFD0_CLKGATE_Enum;
+
+typedef enum {
+    /* PFD1 clock is not ready */
+    RT500_CLKCTL0_SYSPLL0PFD_PFD1_CLKRDY_NOTREADY = 0,
+    /* PFD1 clock is ready */
+    RT500_CLKCTL0_SYSPLL0PFD_PFD1_CLKRDY_READY = 1,
+} RT500_CLKCTL0_SYSPLL0PFD_PFD1_CLKRDY_Enum;
+
+typedef enum {
+    /* PFD1 clock is not gated */
+    RT500_CLKCTL0_SYSPLL0PFD_PFD1_CLKGATE_NOTGATED = 0,
+    /* PFD1 clock is gated */
+    RT500_CLKCTL0_SYSPLL0PFD_PFD1_CLKGATE_GATED = 1,
+} RT500_CLKCTL0_SYSPLL0PFD_PFD1_CLKGATE_Enum;
+
+typedef enum {
+    /* PFD2 clock is not ready */
+    RT500_CLKCTL0_SYSPLL0PFD_PFD2_CLKRDY_NOTREADY = 0,
+    /* PFD2 clock is ready */
+    RT500_CLKCTL0_SYSPLL0PFD_PFD2_CLKRDY_READY = 1,
+} RT500_CLKCTL0_SYSPLL0PFD_PFD2_CLKRDY_Enum;
+
+typedef enum {
+    /* PFD2 clock is not gated */
+    RT500_CLKCTL0_SYSPLL0PFD_PFD2_CLKGATE_NOTGATED = 0,
+    /* PFD2 clock is gated */
+    RT500_CLKCTL0_SYSPLL0PFD_PFD2_CLKGATE_GATED = 1,
+} RT500_CLKCTL0_SYSPLL0PFD_PFD2_CLKGATE_Enum;
+
+typedef enum {
+    /* PFD3 clock is not ready */
+    RT500_CLKCTL0_SYSPLL0PFD_PFD3_CLKRDY_NOTREADY = 0,
+    /* PFD3 clock is ready */
+    RT500_CLKCTL0_SYSPLL0PFD_PFD3_CLKRDY_READY = 1,
+} RT500_CLKCTL0_SYSPLL0PFD_PFD3_CLKRDY_Enum;
+
+typedef enum {
+    /* PFD3 clock is not gated */
+    RT500_CLKCTL0_SYSPLL0PFD_PFD3_CLKGATE_NOTGATED = 0,
+    /* PFD3 clock is gated */
+    RT500_CLKCTL0_SYSPLL0PFD_PFD3_CLKGATE_GATED = 1,
+} RT500_CLKCTL0_SYSPLL0PFD_PFD3_CLKGATE_Enum;
+
+typedef enum {
+    /* The change to the divider value has finished */
+    RT500_CLKCTL0_SYSCPUAHBCLKDIV_REQFLAG_DIVIDER_READY = 0,
+    /* A change is being made to the divider value */
+    RT500_CLKCTL0_SYSCPUAHBCLKDIV_REQFLAG_DIVIDER_NOT_READY = 1,
+} RT500_CLKCTL0_SYSCPUAHBCLKDIV_REQFLAG_Enum;
+
+typedef enum {
+    /* Low Power Oscillator Clock (LPOSC) */
+    RT500_CLKCTL0_MAINCLKSELA_SEL_LPOSC = 0,
+    /* FRODIV which is the output of the FRODIVSEL mux */
+    RT500_CLKCTL0_MAINCLKSELA_SEL_FRO_8 = 1,
+    /* OSC_CLK clock */
+    RT500_CLKCTL0_MAINCLKSELA_SEL_OSC_CLK = 2,
+    /* FRO_DIV1 clock */
+    RT500_CLKCTL0_MAINCLKSELA_SEL_FRO = 3,
+} RT500_CLKCTL0_MAINCLKSELA_SEL_Enum;
+
+typedef enum {
+    /* MAINCLKSELA 1st Stage Clock */
+    RT500_CLKCTL0_MAINCLKSELB_SEL_MAINCLKSELA = 0,
+    /* Main System PLL Clock */
+    RT500_CLKCTL0_MAINCLKSELB_SEL_SYSPLL = 1,
+    /* RTC 32 KHz Clock */
+    RT500_CLKCTL0_MAINCLKSELB_SEL_RTC32KHZ = 2,
+} RT500_CLKCTL0_MAINCLKSELB_SEL_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PFC0DIV_RESET_DIVIDER_COUNTER_NOT_RESET = 0,
+    /* Reset the Divider Counter */
+    RT500_CLKCTL0_PFC0DIV_RESET_DIVIDER_COUNTER_RESET = 1,
+} RT500_CLKCTL0_PFC0DIV_RESET_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PFC0DIV_HALT_DIVIDER_COUNTER_NOT_HALT = 0,
+    /* Halt (stop) the Divider Counter */
+    RT500_CLKCTL0_PFC0DIV_HALT_DIVIDER_COUNTER_HALT = 1,
+} RT500_CLKCTL0_PFC0DIV_HALT_Enum;
+
+typedef enum {
+    /* The change to the divider value has finished */
+    RT500_CLKCTL0_PFC0DIV_REQFLAG_DIVIDER_READY = 0,
+    /* A change is being made to the divider value */
+    RT500_CLKCTL0_PFC0DIV_REQFLAG_DIVIDER_NOT_READY = 1,
+} RT500_CLKCTL0_PFC0DIV_REQFLAG_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PFC1DIV_RESET_DIVIDER_COUNTER_NOT_RESET = 0,
+    /* Reset the Divider Counter */
+    RT500_CLKCTL0_PFC1DIV_RESET_DIVIDER_COUNTER_RESET = 1,
+} RT500_CLKCTL0_PFC1DIV_RESET_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_PFC1DIV_HALT_DIVIDER_COUNTER_NOT_HALT = 0,
+    /* Halt (stop) the Divider Counter */
+    RT500_CLKCTL0_PFC1DIV_HALT_DIVIDER_COUNTER_HALT = 1,
+} RT500_CLKCTL0_PFC1DIV_HALT_Enum;
+
+typedef enum {
+    /* The change to the divider value has finished */
+    RT500_CLKCTL0_PFC1DIV_REQFLAG_DIVIDER_READY = 0,
+    /* A change is being made to the divider value */
+    RT500_CLKCTL0_PFC1DIV_REQFLAG_DIVIDER_NOT_READY = 1,
+} RT500_CLKCTL0_PFC1DIV_REQFLAG_Enum;
+
+typedef enum {
+    /* Main Clock */
+    RT500_CLKCTL0_FLEXSPI0FCLKSEL_SEL_MAIN = 0,
+    /* Main System PLL Clock */
+    RT500_CLKCTL0_FLEXSPI0FCLKSEL_SEL_PLL = 1,
+    /* SYSPLL0 AUX0_PLL_Clock */
+    RT500_CLKCTL0_FLEXSPI0FCLKSEL_SEL_AUX0_PLL = 2,
+    /* FRO_DIV1 Clock */
+    RT500_CLKCTL0_FLEXSPI0FCLKSEL_SEL_FRO_192M = 3,
+    /* SYSPLL0 AUX1_PLL_Clock */
+    RT500_CLKCTL0_FLEXSPI0FCLKSEL_SEL_AUX1_PLL = 4,
+    /* None; this may be selected to reduce power when no output is needed. */
+    RT500_CLKCTL0_FLEXSPI0FCLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL0_FLEXSPI0FCLKSEL_SEL_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_FLEXSPI0FCLKDIV_RESET_DIVIDER_COUNTER_NOT_RESET = 0,
+    /* Reset the Divider Counter */
+    RT500_CLKCTL0_FLEXSPI0FCLKDIV_RESET_DIVIDER_COUNTER_RESET = 1,
+} RT500_CLKCTL0_FLEXSPI0FCLKDIV_RESET_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_FLEXSPI0FCLKDIV_HALT_DIVIDER_COUNTER_NOT_HALT = 0,
+    /* Halt (stop) the Divider Counter */
+    RT500_CLKCTL0_FLEXSPI0FCLKDIV_HALT_DIVIDER_COUNTER_HALT = 1,
+} RT500_CLKCTL0_FLEXSPI0FCLKDIV_HALT_Enum;
+
+typedef enum {
+    /* The change to the divider value has finished */
+    RT500_CLKCTL0_FLEXSPI0FCLKDIV_REQFLAG_DIVIDER_READY = 0,
+    /* A change is being made to the divider value */
+    RT500_CLKCTL0_FLEXSPI0FCLKDIV_REQFLAG_DIVIDER_NOT_READY = 1,
+} RT500_CLKCTL0_FLEXSPI0FCLKDIV_REQFLAG_Enum;
+
+typedef enum {
+    /* Main Clock */
+    RT500_CLKCTL0_FLEXSPI1FCLKSEL_SEL_MAIN = 0,
+    /* Main System PLL Clock */
+    RT500_CLKCTL0_FLEXSPI1FCLKSEL_SEL_PLL = 1,
+    /* SYSPLL0 AUX0_PLL_Clock */
+    RT500_CLKCTL0_FLEXSPI1FCLKSEL_SEL_AUX0_PLL = 2,
+    /* FRO_DIV1 Clock */
+    RT500_CLKCTL0_FLEXSPI1FCLKSEL_SEL_FRO_192M = 3,
+    /* SYSPLL0 AUX1_PLL_Clock */
+    RT500_CLKCTL0_FLEXSPI1FCLKSEL_SEL_AUX1_PLL = 4,
+    /* None; this may be selected to reduce power when no output is needed. */
+    RT500_CLKCTL0_FLEXSPI1FCLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL0_FLEXSPI1FCLKSEL_SEL_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_FLEXSPI1FCLKDIV_RESET_DIVIDER_COUNTER_NOT_RESET = 0,
+    /* Reset the Divider Counter */
+    RT500_CLKCTL0_FLEXSPI1FCLKDIV_RESET_DIVIDER_COUNTER_RESET = 1,
+} RT500_CLKCTL0_FLEXSPI1FCLKDIV_RESET_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_FLEXSPI1FCLKDIV_HALT_DIVIDER_COUNTER_NOT_HALT = 0,
+    /* Halt (stop) the Divider Counter */
+    RT500_CLKCTL0_FLEXSPI1FCLKDIV_HALT_DIVIDER_COUNTER_HALT = 1,
+} RT500_CLKCTL0_FLEXSPI1FCLKDIV_HALT_Enum;
+
+typedef enum {
+    /* The change to the divider value has finished */
+    RT500_CLKCTL0_FLEXSPI1FCLKDIV_REQFLAG_DIVIDER_READY = 0,
+    /* A change is being made to the divider value */
+    RT500_CLKCTL0_FLEXSPI1FCLKDIV_REQFLAG_DIVIDER_NOT_READY = 1,
+} RT500_CLKCTL0_FLEXSPI1FCLKDIV_REQFLAG_Enum;
+
+typedef enum {
+    /* Main Clock */
+    RT500_CLKCTL0_SCTFCLKSEL_SEL_MAIN = 0,
+    /* Main System PLL Clock */
+    RT500_CLKCTL0_SCTFCLKSEL_SEL_PLL = 1,
+    /* SYSPLL0 AUX0_PLL_Clock */
+    RT500_CLKCTL0_SCTFCLKSEL_SEL_AUX0_PLL = 2,
+    /* FRO_DIV1 Clock */
+    RT500_CLKCTL0_SCTFCLKSEL_SEL_FRO_192M = 3,
+    /* SYSPLL0 AUX1_PLL_Clock */
+    RT500_CLKCTL0_SCTFCLKSEL_SEL_AUX1_PLL = 4,
+    /* AUDIO PLL Clock */
+    RT500_CLKCTL0_SCTFCLKSEL_SEL_AUDIO_PLL = 5,
+    /* None; this may be selected to reduce power when no output is needed. */
+    RT500_CLKCTL0_SCTFCLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL0_SCTFCLKSEL_SEL_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_SCTIN7CLKDIV_RESET_DIVIDER_COUNTER_NOT_RESET = 0,
+    /* Reset the Divider Counter */
+    RT500_CLKCTL0_SCTIN7CLKDIV_RESET_DIVIDER_COUNTER_RESET = 1,
+} RT500_CLKCTL0_SCTIN7CLKDIV_RESET_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_SCTIN7CLKDIV_HALT_DIVIDER_COUNTER_NOT_HALT = 0,
+    /* Halt (stop) the Divider Counter */
+    RT500_CLKCTL0_SCTIN7CLKDIV_HALT_DIVIDER_COUNTER_HALT = 1,
+} RT500_CLKCTL0_SCTIN7CLKDIV_HALT_Enum;
+
+typedef enum {
+    /* The change to the divider value has finished */
+    RT500_CLKCTL0_SCTIN7CLKDIV_REQFLAG_DIVIDER_READY = 0,
+    /* A change is being made to the divider value */
+    RT500_CLKCTL0_SCTIN7CLKDIV_REQFLAG_DIVIDER_NOT_READY = 1,
+} RT500_CLKCTL0_SCTIN7CLKDIV_REQFLAG_Enum;
+
+typedef enum {
+    /* OSC_CLK Clock */
+    RT500_CLKCTL0_USBHSFCLKSEL_SEL_OSC_CLK = 0,
+    /* Main Clock */
+    RT500_CLKCTL0_USBHSFCLKSEL_SEL_MAIN = 1,
+    /* AUX0_PLL_CLOCK */
+    RT500_CLKCTL0_USBHSFCLKSEL_SEL_AUX0_PLL_CLOCK = 3,
+    /* None; this may be selected to reduce power when no output is needed. */
+    RT500_CLKCTL0_USBHSFCLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL0_USBHSFCLKSEL_SEL_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_USBHSFCLKDIV_RESET_DIVIDER_COUNTER_NOT_RESET = 0,
+    /* Reset the Divider Counter */
+    RT500_CLKCTL0_USBHSFCLKDIV_RESET_DIVIDER_COUNTER_RESET = 1,
+} RT500_CLKCTL0_USBHSFCLKDIV_RESET_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_USBHSFCLKDIV_HALT_DIVIDER_COUNTER_NOT_HALT = 0,
+    /* Halt (stop) the Divider Counter */
+    RT500_CLKCTL0_USBHSFCLKDIV_HALT_DIVIDER_COUNTER_HALT = 1,
+} RT500_CLKCTL0_USBHSFCLKDIV_HALT_Enum;
+
+typedef enum {
+    /* The change to the divider value has finished */
+    RT500_CLKCTL0_USBHSFCLKDIV_REQFLAG_DIVIDER_READY = 0,
+    /* A change is being made to the divider value */
+    RT500_CLKCTL0_USBHSFCLKDIV_REQFLAG_DIVIDER_NOT_READY = 1,
+} RT500_CLKCTL0_USBHSFCLKDIV_REQFLAG_Enum;
+
+typedef enum {
+    /* Main Clock */
+    RT500_CLKCTL0_SDIO0FCLKSEL_SEL_MAIN = 0,
+    /* System PLL Clock */
+    RT500_CLKCTL0_SDIO0FCLKSEL_SEL_PLL = 1,
+    /* SYSPLL0 AUX0_PLL_Clock */
+    RT500_CLKCTL0_SDIO0FCLKSEL_SEL_AUX0_PLL = 2,
+    /* FRO_DIV2 */
+    RT500_CLKCTL0_SDIO0FCLKSEL_SEL_FRO_DIV2 = 3,
+    /* SYSPLL0 AUX1_PLL_Clock */
+    RT500_CLKCTL0_SDIO0FCLKSEL_SEL_AUX1_PLL = 4,
+    /* None; this may be selected to reduce power when no output is needed. */
+    RT500_CLKCTL0_SDIO0FCLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL0_SDIO0FCLKSEL_SEL_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_SDIO0FCLKDIV_RESET_DIVIDER_COUNTER_NOT_RESET = 0,
+    /* Reset the Divider Counter */
+    RT500_CLKCTL0_SDIO0FCLKDIV_RESET_DIVIDER_COUNTER_RESET = 1,
+} RT500_CLKCTL0_SDIO0FCLKDIV_RESET_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_SDIO0FCLKDIV_HALT_DIVIDER_COUNTER_NOT_HALT = 0,
+    /* Halt (stop) the Divider Counter */
+    RT500_CLKCTL0_SDIO0FCLKDIV_HALT_DIVIDER_COUNTER_HALT = 1,
+} RT500_CLKCTL0_SDIO0FCLKDIV_HALT_Enum;
+
+typedef enum {
+    /* The change to the divider value has finished */
+    RT500_CLKCTL0_SDIO0FCLKDIV_REQFLAG_DIVIDER_READY = 0,
+    /* A change is being made to the divider value */
+    RT500_CLKCTL0_SDIO0FCLKDIV_REQFLAG_DIVIDER_NOT_READY = 1,
+} RT500_CLKCTL0_SDIO0FCLKDIV_REQFLAG_Enum;
+
+typedef enum {
+    /* Main Clock */
+    RT500_CLKCTL0_SDIO1FCLKSEL_SEL_MAIN = 0,
+    /* Main System PLL Clock */
+    RT500_CLKCTL0_SDIO1FCLKSEL_SEL_PLL = 1,
+    /* SYSPLL0 AUX0_PLL_Clock */
+    RT500_CLKCTL0_SDIO1FCLKSEL_SEL_AUX0_PLL = 2,
+    /* FRO_DIV2 */
+    RT500_CLKCTL0_SDIO1FCLKSEL_SEL_FRO_DIV2 = 3,
+    /* SYSPLL0 AUX1_PLL_Clock */
+    RT500_CLKCTL0_SDIO1FCLKSEL_SEL_AUX1_PLL = 4,
+    /* None; this may be selected to reduce power when no output is needed. */
+    RT500_CLKCTL0_SDIO1FCLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL0_SDIO1FCLKSEL_SEL_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_SDIO1FCLKDIV_RESET_DIVIDER_COUNTER_NOT_RESET = 0,
+    /* Reset the Divider Counter */
+    RT500_CLKCTL0_SDIO1FCLKDIV_RESET_DIVIDER_COUNTER_RESET = 1,
+} RT500_CLKCTL0_SDIO1FCLKDIV_RESET_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_SDIO1FCLKDIV_HALT_DIVIDER_COUNTER_NOT_HALT = 0,
+    /* Halt (stop) the Divider Counter */
+    RT500_CLKCTL0_SDIO1FCLKDIV_HALT_DIVIDER_COUNTER_HALT = 1,
+} RT500_CLKCTL0_SDIO1FCLKDIV_HALT_Enum;
+
+typedef enum {
+    /* The change to the divider value has finished */
+    RT500_CLKCTL0_SDIO1FCLKDIV_REQFLAG_DIVIDER_READY = 0,
+    /* A change is being made to the divider value */
+    RT500_CLKCTL0_SDIO1FCLKDIV_REQFLAG_DIVIDER_NOT_READY = 1,
+} RT500_CLKCTL0_SDIO1FCLKDIV_REQFLAG_Enum;
+
+typedef enum {
+    /* OSC_CLK Clock */
+    RT500_CLKCTL0_ADC0FCLKSEL0_SEL_OSC_CLK = 0,
+    /* Low Power Oscillator Clock (LPOSC) */
+    RT500_CLKCTL0_ADC0FCLKSEL0_SEL_LPOSC = 1,
+    /* FRO_DIV4 */
+    RT500_CLKCTL0_ADC0FCLKSEL0_SEL_FRO_DIV4 = 2,
+    /* None; this may be selected to reduce power when no output is needed. */
+    RT500_CLKCTL0_ADC0FCLKSEL0_SEL_NONE = 7,
+} RT500_CLKCTL0_ADC0FCLKSEL0_SEL_Enum;
+
+typedef enum {
+    /* ADC0FCLKSEL0 Multiplexed Output */
+    RT500_CLKCTL0_ADC0FCLKSEL1_SEL_ADC0FCLKSEL0_MUX = 0,
+    /* SYSPLL0 MAIN_CLK (PFD0 Output) */
+    RT500_CLKCTL0_ADC0FCLKSEL1_SEL_SYSPLL0_MAIN = 1,
+    /* SYSPLL0 AUX0_PLL_Clock */
+    RT500_CLKCTL0_ADC0FCLKSEL1_SEL_SYSPLL0_AUX0_PLL = 2,
+    /* SYSPLL0 AUX1_PLL_Clock */
+    RT500_CLKCTL0_ADC0FCLKSEL1_SEL_SYSPLL0_AUX1_PLL = 3,
+    /* None; this may be selected to reduce power when no output is needed. */
+    RT500_CLKCTL0_ADC0FCLKSEL1_SEL_NONE = 7,
+} RT500_CLKCTL0_ADC0FCLKSEL1_SEL_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_ADC0FCLKDIV_RESET_DIVIDER_COUNTER_NOT_RESET = 0,
+    /* Reset the Divider Counter */
+    RT500_CLKCTL0_ADC0FCLKDIV_RESET_DIVIDER_COUNTER_RESET = 1,
+} RT500_CLKCTL0_ADC0FCLKDIV_RESET_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_ADC0FCLKDIV_HALT_DIVIDER_COUNTER_NOT_HALT = 0,
+    /* Halt (stop) the Divider Counter */
+    RT500_CLKCTL0_ADC0FCLKDIV_HALT_DIVIDER_COUNTER_HALT = 1,
+} RT500_CLKCTL0_ADC0FCLKDIV_HALT_Enum;
+
+typedef enum {
+    /* The change to the divider value has finished */
+    RT500_CLKCTL0_ADC0FCLKDIV_REQFLAG_DIVIDER_READY = 0,
+    /* A change is being made to the divider value */
+    RT500_CLKCTL0_ADC0FCLKDIV_REQFLAG_DIVIDER_NOT_READY = 1,
+} RT500_CLKCTL0_ADC0FCLKDIV_REQFLAG_Enum;
+
+typedef enum {
+    /* Low Power Oscillator Clock (LPOSC) */
+    RT500_CLKCTL0_UTICKFCLKSEL_SEL_LPOSC = 0,
+    /* None; this may be selected to reduce power when no output is needed. */
+    RT500_CLKCTL0_UTICKFCLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL0_UTICKFCLKSEL_SEL_Enum;
+
+typedef enum {
+    /* Low Power Oscillator Clock (LPOSC) */
+    RT500_CLKCTL0_WDT0FCLKSEL_SEL_LPOSC = 0,
+    /* None; this may be selected to reduce power when no output is needed. */
+    RT500_CLKCTL0_WDT0FCLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL0_WDT0FCLKSEL_SEL_Enum;
+
+typedef enum {
+    /* 32 KHz */
+    RT500_CLKCTL0_A32KHZWAKECLKSEL_SEL_A32KHZ = 0,
+    /* Low Power Oscillator Clock (LPOSC); divided by 32 by default */
+    RT500_CLKCTL0_A32KHZWAKECLKSEL_SEL_LPOSC = 1,
+    /* None; this may be selected to reduce power when no output is needed. */
+    RT500_CLKCTL0_A32KHZWAKECLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL0_A32KHZWAKECLKSEL_SEL_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_A32KHZWAKECLKDIV_RESET_DIVIDER_COUNTER_NOT_RESET = 0,
+    /* Reset the Divider Counter */
+    RT500_CLKCTL0_A32KHZWAKECLKDIV_RESET_DIVIDER_COUNTER_RESET = 1,
+} RT500_CLKCTL0_A32KHZWAKECLKDIV_RESET_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_A32KHZWAKECLKDIV_HALT_DIVIDER_COUNTER_NOT_HALT = 0,
+    /* Halt (stop) the Divider Counter */
+    RT500_CLKCTL0_A32KHZWAKECLKDIV_HALT_DIVIDER_COUNTER_HALT = 1,
+} RT500_CLKCTL0_A32KHZWAKECLKDIV_HALT_Enum;
+
+typedef enum {
+    /* The change to the divider value has finished */
+    RT500_CLKCTL0_A32KHZWAKECLKDIV_REQFLAG_DIVIDER_READY = 0,
+    /* A change is being made to the divider value */
+    RT500_CLKCTL0_A32KHZWAKECLKDIV_REQFLAG_DIVIDER_NOT_READY = 1,
+} RT500_CLKCTL0_A32KHZWAKECLKDIV_REQFLAG_Enum;
+
+typedef enum {
+    /* Systick Divider Output Clock */
+    RT500_CLKCTL0_SYSTICKFCLKSEL_SEL_SYSTICK_DIV_OUTPUT = 0,
+    /* Low Power Oscillator Clock (LPOSC) */
+    RT500_CLKCTL0_SYSTICKFCLKSEL_SEL_LPOSC = 1,
+    /* 32 KHz RTC Clock */
+    RT500_CLKCTL0_SYSTICKFCLKSEL_SEL_A32KHZ_RTC = 2,
+    /* None; this may be selected to reduce power when no output is needed. */
+    RT500_CLKCTL0_SYSTICKFCLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL0_SYSTICKFCLKSEL_SEL_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_SYSTICKFCLKDIV_RESET_DIVIDER_COUNTER_NOT_RESET = 0,
+    /* Reset the Divider Counter */
+    RT500_CLKCTL0_SYSTICKFCLKDIV_RESET_DIVIDER_COUNTER_RESET = 1,
+} RT500_CLKCTL0_SYSTICKFCLKDIV_RESET_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_SYSTICKFCLKDIV_HALT_DIVIDER_COUNTER_NOT_HALT = 0,
+    /* Halt (stop) the Divider Counter */
+    RT500_CLKCTL0_SYSTICKFCLKDIV_HALT_DIVIDER_COUNTER_HALT = 1,
+} RT500_CLKCTL0_SYSTICKFCLKDIV_HALT_Enum;
+
+typedef enum {
+    /* The change to the divider value has finished */
+    RT500_CLKCTL0_SYSTICKFCLKDIV_REQFLAG_DIVIDER_READY = 0,
+    /* A change is being made to the divider value */
+    RT500_CLKCTL0_SYSTICKFCLKDIV_REQFLAG_DIVIDER_NOT_READY = 1,
+} RT500_CLKCTL0_SYSTICKFCLKDIV_REQFLAG_Enum;
+
+typedef enum {
+    /* FRO_DIV1 Clock */
+    RT500_CLKCTL0_DPHYCLKSEL_SEL_FRO = 0,
+    /* SYSPLL0 MAIN_CLK (PFD0 Output) */
+    RT500_CLKCTL0_DPHYCLKSEL_SEL_SYSPLL0_MAIN = 1,
+    /* SYSPLL0 AUX0_PLL_Clock */
+    RT500_CLKCTL0_DPHYCLKSEL_SEL_SYSPLL0_AUX0 = 2,
+    /* SYSPLL0 AUX1_PLL_Clock */
+    RT500_CLKCTL0_DPHYCLKSEL_SEL_SYSPLL0_AUX1 = 3,
+    /* None; this may be selected to reduce power when no output is needed. */
+    RT500_CLKCTL0_DPHYCLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL0_DPHYCLKSEL_SEL_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_DPHYCLKDIV_RESET_DIVIDER_COUNTER_NOT_RESET = 0,
+    /* Reset the Divider Counter */
+    RT500_CLKCTL0_DPHYCLKDIV_RESET_DIVIDER_COUNTER_RESET = 1,
+} RT500_CLKCTL0_DPHYCLKDIV_RESET_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_DPHYCLKDIV_HALT_DIVIDER_COUNTER_NOT_HALT = 0,
+    /* Halt (stop) the Divider Counter */
+    RT500_CLKCTL0_DPHYCLKDIV_HALT_DIVIDER_COUNTER_HALT = 1,
+} RT500_CLKCTL0_DPHYCLKDIV_HALT_Enum;
+
+typedef enum {
+    /* The change to the divider value has finished */
+    RT500_CLKCTL0_DPHYCLKDIV_REQFLAG_DIVIDER_READY = 0,
+    /* A change is being made to the divider value */
+    RT500_CLKCTL0_DPHYCLKDIV_REQFLAG_DIVIDER_NOT_READY = 1,
+} RT500_CLKCTL0_DPHYCLKDIV_REQFLAG_Enum;
+
+typedef enum {
+    /* FRO_DIV1 clock */
+    RT500_CLKCTL0_DPHYESCCLKSEL_SEL_FRO_DIV1 = 0,
+    /* FRO_DIV16 Clock */
+    RT500_CLKCTL0_DPHYESCCLKSEL_SEL_FRO_DIV16 = 1,
+    /* None; this may be selected to reduce power when no output is needed. */
+    RT500_CLKCTL0_DPHYESCCLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL0_DPHYESCCLKSEL_SEL_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_DPHYESCRXCLKDIV_RESET_DIVIDER_COUNTER_NOT_RESET = 0,
+    /* Reset the Divider Counter */
+    RT500_CLKCTL0_DPHYESCRXCLKDIV_RESET_DIVIDER_COUNTER_RESET = 1,
+} RT500_CLKCTL0_DPHYESCRXCLKDIV_RESET_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_DPHYESCRXCLKDIV_HALT_DIVIDER_COUNTER_NOT_HALT = 0,
+    /* Halt (stop) the Divider Counter */
+    RT500_CLKCTL0_DPHYESCRXCLKDIV_HALT_DIVIDER_COUNTER_HALT = 1,
+} RT500_CLKCTL0_DPHYESCRXCLKDIV_HALT_Enum;
+
+typedef enum {
+    /* The change to the divider value has finished */
+    RT500_CLKCTL0_DPHYESCRXCLKDIV_REQFLAG_DIVIDER_READY = 0,
+    /* A change is being made to the divider value */
+    RT500_CLKCTL0_DPHYESCRXCLKDIV_REQFLAG_DIVIDER_NOT_READY = 1,
+} RT500_CLKCTL0_DPHYESCRXCLKDIV_REQFLAG_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_DPHYESCTXCLKDIV_RESET_DIVIDER_COUNTER_NOT_RESET = 0,
+    /* Reset the Divider Counter */
+    RT500_CLKCTL0_DPHYESCTXCLKDIV_RESET_DIVIDER_COUNTER_RESET = 1,
+} RT500_CLKCTL0_DPHYESCTXCLKDIV_RESET_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_DPHYESCTXCLKDIV_HALT_DIVIDER_COUNTER_NOT_HALT = 0,
+    /* Halt (stop) the Divider Counter */
+    RT500_CLKCTL0_DPHYESCTXCLKDIV_HALT_DIVIDER_COUNTER_HALT = 1,
+} RT500_CLKCTL0_DPHYESCTXCLKDIV_HALT_Enum;
+
+typedef enum {
+    /* The change to the divider value has finished */
+    RT500_CLKCTL0_DPHYESCTXCLKDIV_REQFLAG_DIVIDER_READY = 0,
+    /* A change is being made to the divider value */
+    RT500_CLKCTL0_DPHYESCTXCLKDIV_REQFLAG_DIVIDER_NOT_READY = 1,
+} RT500_CLKCTL0_DPHYESCTXCLKDIV_REQFLAG_Enum;
+
+typedef enum {
+    /* Main Clock */
+    RT500_CLKCTL0_GPUCLKSEL_SEL_MAIN = 0,
+    /* FRO_DIV1 clock */
+    RT500_CLKCTL0_GPUCLKSEL_SEL_FRO = 1,
+    /* SYSPLL0 MAIN_CLK (PFD0 Output) */
+    RT500_CLKCTL0_GPUCLKSEL_SEL_SYSPLL0_MAIN = 2,
+    /* SYSPLL0 AUX0_PLL_Clock */
+    RT500_CLKCTL0_GPUCLKSEL_SEL_SYSPLL0_AUX0 = 3,
+    /* SYSPLL0 AUX1_PLL_Clock */
+    RT500_CLKCTL0_GPUCLKSEL_SEL_SYSPLL0_AUX1 = 4,
+    /* None; this may be selected to reduce power when no output is needed. */
+    RT500_CLKCTL0_GPUCLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL0_GPUCLKSEL_SEL_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_GPUCLKDIV_RESET_DIVIDER_COUNTER_NOT_RESET = 0,
+    /* Reset the Divider Counter */
+    RT500_CLKCTL0_GPUCLKDIV_RESET_DIVIDER_COUNTER_RESET = 1,
+} RT500_CLKCTL0_GPUCLKDIV_RESET_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_GPUCLKDIV_HALT_DIVIDER_COUNTER_NOT_HALT = 0,
+    /* Halt (stop) the Divider Counter */
+    RT500_CLKCTL0_GPUCLKDIV_HALT_DIVIDER_COUNTER_HALT = 1,
+} RT500_CLKCTL0_GPUCLKDIV_HALT_Enum;
+
+typedef enum {
+    /* The change to the divider value has finished */
+    RT500_CLKCTL0_GPUCLKDIV_REQFLAG_DIVIDER_READY = 0,
+    /* A change is being made to the divider value */
+    RT500_CLKCTL0_GPUCLKDIV_REQFLAG_DIVIDER_NOT_READY = 1,
+} RT500_CLKCTL0_GPUCLKDIV_REQFLAG_Enum;
+
+typedef enum {
+    /* MIPI-DSI PHY Clock */
+    RT500_CLKCTL0_DCPIXELCLKSEL_SEL_MIPI_DSI_PHY = 0,
+    /* Main Clock */
+    RT500_CLKCTL0_DCPIXELCLKSEL_SEL_MAIN = 1,
+    /* FRO_DIV1 Clock */
+    RT500_CLKCTL0_DCPIXELCLKSEL_SEL_FRO = 2,
+    /* SYSPLL0 MAIN_CLK (PFD0 Output) */
+    RT500_CLKCTL0_DCPIXELCLKSEL_SEL_SYSPLL0_MAIN = 3,
+    /* SYSPLL0 AUX0_PLL_Clock */
+    RT500_CLKCTL0_DCPIXELCLKSEL_SEL_SYSPLL0_AUX0 = 4,
+    /* SYSPLL0 AUX1_PLL_Clock */
+    RT500_CLKCTL0_DCPIXELCLKSEL_SEL_SYSPLL0_AUX1 = 5,
+    /* None; this may be selected to reduce power when no output is needed. */
+    RT500_CLKCTL0_DCPIXELCLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL0_DCPIXELCLKSEL_SEL_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_DCPIXELCLKDIV_RESET_DIVIDER_COUNTER_NOT_RESET = 0,
+    /* Reset the Divider Counter */
+    RT500_CLKCTL0_DCPIXELCLKDIV_RESET_DIVIDER_COUNTER_RESET = 1,
+} RT500_CLKCTL0_DCPIXELCLKDIV_RESET_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL0_DCPIXELCLKDIV_HALT_DIVIDER_COUNTER_NOT_HALT = 0,
+    /* Halt (stop) the Divider Counter */
+    RT500_CLKCTL0_DCPIXELCLKDIV_HALT_DIVIDER_COUNTER_HALT = 1,
+} RT500_CLKCTL0_DCPIXELCLKDIV_HALT_Enum;
+
+typedef enum {
+    /* The change to the divider value has finished */
+    RT500_CLKCTL0_DCPIXELCLKDIV_REQFLAG_DIVIDER_READY = 0,
+    /* A change is being made to the divider value */
+    RT500_CLKCTL0_DCPIXELCLKDIV_REQFLAG_DIVIDER_NOT_READY = 1,
+} RT500_CLKCTL0_DCPIXELCLKDIV_REQFLAG_Enum;
+
+
+#define RT500_CLKCTL0_REGISTER_NAMES_ARRAY(_name) \
+    const char *_name[RT500_CLKCTL0_REGS_NO] = { \
+        [R_RT500_CLKCTL0_PSCCTL0] = "PSCCTL0", \
+        [R_RT500_CLKCTL0_PSCCTL1] = "PSCCTL1", \
+        [R_RT500_CLKCTL0_PSCCTL2] = "PSCCTL2", \
+        [R_RT500_CLKCTL0_PSCCTL0_SET] = "PSCCTL0_SET", \
+        [R_RT500_CLKCTL0_PSCCTL1_SET] = "PSCCTL1_SET", \
+        [R_RT500_CLKCTL0_PSCCTL2_SET] = "PSCCTL2_SET", \
+        [R_RT500_CLKCTL0_PSCCTL0_CLR] = "PSCCTL0_CLR", \
+        [R_RT500_CLKCTL0_PSCCTL1_CLR] = "PSCCTL1_CLR", \
+        [R_RT500_CLKCTL0_PSCCTL2_CLR] = "PSCCTL2_CLR", \
+        [R_RT500_CLKCTL0_FRO_CONTROL] = "FRO_CONTROL", \
+        [R_RT500_CLKCTL0_FRO_CAPVAL] = "FRO_CAPVAL", \
+        [R_RT500_CLKCTL0_FRO_RDTRIM] = "FRO_RDTRIM", \
+        [R_RT500_CLKCTL0_FRO_SCTRIM] = "FRO_SCTRIM", \
+        [R_RT500_CLKCTL0_FRODIVSEL] = "FRODIVSEL", \
+        [R_RT500_CLKCTL0_FROCLKSTATUS] = "FROCLKSTATUS", \
+        [R_RT500_CLKCTL0_FRODIVOEN] = "FRODIVOEN", \
+        [R_RT500_CLKCTL0_LOWFREQCLKDIV] = "LOWFREQCLKDIV", \
+        [R_RT500_CLKCTL0_SYSOSCCTL0] = "SYSOSCCTL0", \
+        [R_RT500_CLKCTL0_SYSOSCBYPASS] = "SYSOSCBYPASS", \
+        [R_RT500_CLKCTL0_LPOSCCTL0] = "LPOSCCTL0", \
+        [R_RT500_CLKCTL0_OSC32KHZCTL0] = "OSC32KHZCTL0", \
+        [R_RT500_CLKCTL0_SYSPLL0CLKSEL] = "SYSPLL0CLKSEL", \
+        [R_RT500_CLKCTL0_SYSPLL0CTL0] = "SYSPLL0CTL0", \
+        [R_RT500_CLKCTL0_SYSPLL0LOCKTIMEDIV2] = "SYSPLL0LOCKTIMEDIV2", \
+        [R_RT500_CLKCTL0_SYSPLL0NUM] = "SYSPLL0NUM", \
+        [R_RT500_CLKCTL0_SYSPLL0DENOM] = "SYSPLL0DENOM", \
+        [R_RT500_CLKCTL0_SYSPLL0PFD] = "SYSPLL0PFD", \
+        [R_RT500_CLKCTL0_MAINPLLCLKDIV] = "MAINPLLCLKDIV", \
+        [R_RT500_CLKCTL0_DSPPLLCLKDIV] = "DSPPLLCLKDIV", \
+        [R_RT500_CLKCTL0_AUX0PLLCLKDIV] = "AUX0PLLCLKDIV", \
+        [R_RT500_CLKCTL0_AUX1PLLCLKDIV] = "AUX1PLLCLKDIV", \
+        [R_RT500_CLKCTL0_SYSCPUAHBCLKDIV] = "SYSCPUAHBCLKDIV", \
+        [R_RT500_CLKCTL0_MAINCLKSELA] = "MAINCLKSELA", \
+        [R_RT500_CLKCTL0_MAINCLKSELB] = "MAINCLKSELB", \
+        [R_RT500_CLKCTL0_PFC0DIV] = "PFC0DIV", \
+        [R_RT500_CLKCTL0_PFC1DIV] = "PFC1DIV", \
+        [R_RT500_CLKCTL0_FLEXSPI0FCLKSEL] = "FLEXSPI0FCLKSEL", \
+        [R_RT500_CLKCTL0_FLEXSPI0FCLKDIV] = "FLEXSPI0FCLKDIV", \
+        [R_RT500_CLKCTL0_FLEXSPI1FCLKSEL] = "FLEXSPI1FCLKSEL", \
+        [R_RT500_CLKCTL0_FLEXSPI1FCLKDIV] = "FLEXSPI1FCLKDIV", \
+        [R_RT500_CLKCTL0_SCTFCLKSEL] = "SCTFCLKSEL", \
+        [R_RT500_CLKCTL0_SCTIN7CLKDIV] = "SCTIN7CLKDIV", \
+        [R_RT500_CLKCTL0_USBHSFCLKSEL] = "USBHSFCLKSEL", \
+        [R_RT500_CLKCTL0_USBHSFCLKDIV] = "USBHSFCLKDIV", \
+        [R_RT500_CLKCTL0_SDIO0FCLKSEL] = "SDIO0FCLKSEL", \
+        [R_RT500_CLKCTL0_SDIO0FCLKDIV] = "SDIO0FCLKDIV", \
+        [R_RT500_CLKCTL0_SDIO1FCLKSEL] = "SDIO1FCLKSEL", \
+        [R_RT500_CLKCTL0_SDIO1FCLKDIV] = "SDIO1FCLKDIV", \
+        [R_RT500_CLKCTL0_ADC0FCLKSEL0] = "ADC0FCLKSEL0", \
+        [R_RT500_CLKCTL0_ADC0FCLKSEL1] = "ADC0FCLKSEL1", \
+        [R_RT500_CLKCTL0_ADC0FCLKDIV] = "ADC0FCLKDIV", \
+        [R_RT500_CLKCTL0_UTICKFCLKSEL] = "UTICKFCLKSEL", \
+        [R_RT500_CLKCTL0_WDT0FCLKSEL] = "WDT0FCLKSEL", \
+        [R_RT500_CLKCTL0_A32KHZWAKECLKSEL] = "A32KHZWAKECLKSEL", \
+        [R_RT500_CLKCTL0_A32KHZWAKECLKDIV] = "A32KHZWAKECLKDIV", \
+        [R_RT500_CLKCTL0_SYSTICKFCLKSEL] = "SYSTICKFCLKSEL", \
+        [R_RT500_CLKCTL0_SYSTICKFCLKDIV] = "SYSTICKFCLKDIV", \
+        [R_RT500_CLKCTL0_DPHYCLKSEL] = "DPHYCLKSEL", \
+        [R_RT500_CLKCTL0_DPHYCLKDIV] = "DPHYCLKDIV", \
+        [R_RT500_CLKCTL0_DPHYESCCLKSEL] = "DPHYESCCLKSEL", \
+        [R_RT500_CLKCTL0_DPHYESCRXCLKDIV] = "DPHYESCRXCLKDIV", \
+        [R_RT500_CLKCTL0_DPHYESCTXCLKDIV] = "DPHYESCTXCLKDIV", \
+        [R_RT500_CLKCTL0_GPUCLKSEL] = "GPUCLKSEL", \
+        [R_RT500_CLKCTL0_GPUCLKDIV] = "GPUCLKDIV", \
+        [R_RT500_CLKCTL0_DCPIXELCLKSEL] = "DCPIXELCLKSEL", \
+        [R_RT500_CLKCTL0_DCPIXELCLKDIV] = "DCPIXELCLKDIV", \
+    }
+
+#define RT500_CLKCTL0_REGISTER_WMASK_ARRAY(_name) \
+    const uint32_t _name[RT500_CLKCTL0_REGS_NO] = { \
+        [R_RT500_CLKCTL0_PSCCTL0] = 0x5DF71F1E, \
+        [R_RT500_CLKCTL0_PSCCTL1] = 0x101800C, \
+        [R_RT500_CLKCTL0_PSCCTL2] = 0x20000003, \
+        [R_RT500_CLKCTL0_PSCCTL0_SET] = 0x5DF71F1E, \
+        [R_RT500_CLKCTL0_PSCCTL1_SET] = 0x101800C, \
+        [R_RT500_CLKCTL0_PSCCTL2_SET] = 0x20000003, \
+        [R_RT500_CLKCTL0_PSCCTL0_CLR] = 0x5DF71F1E, \
+        [R_RT500_CLKCTL0_PSCCTL1_CLR] = 0x101800C, \
+        [R_RT500_CLKCTL0_PSCCTL2_CLR] = 0x20000003, \
+        [R_RT500_CLKCTL0_FRO_CONTROL] = 0x83FFFFFF, \
+        [R_RT500_CLKCTL0_FRO_RDTRIM] = 0x7FF, \
+        [R_RT500_CLKCTL0_FRO_SCTRIM] = 0x3F, \
+        [R_RT500_CLKCTL0_FRODIVSEL] = 0x3, \
+        [R_RT500_CLKCTL0_FRODIVOEN] = 0x1F, \
+        [R_RT500_CLKCTL0_LOWFREQCLKDIV] = 0xE00000FF, \
+        [R_RT500_CLKCTL0_SYSOSCCTL0] = 0x3, \
+        [R_RT500_CLKCTL0_SYSOSCBYPASS] = 0x7, \
+        [R_RT500_CLKCTL0_LPOSCCTL0] = 0x80000000, \
+        [R_RT500_CLKCTL0_OSC32KHZCTL0] = 0x1, \
+        [R_RT500_CLKCTL0_SYSPLL0CLKSEL] = 0x7, \
+        [R_RT500_CLKCTL0_SYSPLL0CTL0] = 0xFF2003, \
+        [R_RT500_CLKCTL0_SYSPLL0LOCKTIMEDIV2] = 0xFFFF, \
+        [R_RT500_CLKCTL0_SYSPLL0NUM] = 0x3FFFFFFF, \
+        [R_RT500_CLKCTL0_SYSPLL0DENOM] = 0x3FFFFFFF, \
+        [R_RT500_CLKCTL0_SYSPLL0PFD] = 0xFFFFFFFF, \
+        [R_RT500_CLKCTL0_MAINPLLCLKDIV] = 0xE00000FF, \
+        [R_RT500_CLKCTL0_DSPPLLCLKDIV] = 0xE00000FF, \
+        [R_RT500_CLKCTL0_AUX0PLLCLKDIV] = 0xE00000FF, \
+        [R_RT500_CLKCTL0_AUX1PLLCLKDIV] = 0xE00000FF, \
+        [R_RT500_CLKCTL0_SYSCPUAHBCLKDIV] = 0x800000FF, \
+        [R_RT500_CLKCTL0_MAINCLKSELA] = 0x3, \
+        [R_RT500_CLKCTL0_MAINCLKSELB] = 0x3, \
+        [R_RT500_CLKCTL0_PFC0DIV] = 0xE00000FF, \
+        [R_RT500_CLKCTL0_PFC1DIV] = 0xE00000FF, \
+        [R_RT500_CLKCTL0_FLEXSPI0FCLKSEL] = 0x7, \
+        [R_RT500_CLKCTL0_FLEXSPI0FCLKDIV] = 0xE00000FF, \
+        [R_RT500_CLKCTL0_FLEXSPI1FCLKSEL] = 0x7, \
+        [R_RT500_CLKCTL0_FLEXSPI1FCLKDIV] = 0xE00000FF, \
+        [R_RT500_CLKCTL0_SCTFCLKSEL] = 0x7, \
+        [R_RT500_CLKCTL0_SCTIN7CLKDIV] = 0xE00000FF, \
+        [R_RT500_CLKCTL0_USBHSFCLKSEL] = 0x7, \
+        [R_RT500_CLKCTL0_USBHSFCLKDIV] = 0xE00000FF, \
+        [R_RT500_CLKCTL0_SDIO0FCLKSEL] = 0x7, \
+        [R_RT500_CLKCTL0_SDIO0FCLKDIV] = 0xE00000FF, \
+        [R_RT500_CLKCTL0_SDIO1FCLKSEL] = 0x7, \
+        [R_RT500_CLKCTL0_SDIO1FCLKDIV] = 0xE00000FF, \
+        [R_RT500_CLKCTL0_ADC0FCLKSEL0] = 0x7, \
+        [R_RT500_CLKCTL0_ADC0FCLKSEL1] = 0x7, \
+        [R_RT500_CLKCTL0_ADC0FCLKDIV] = 0xE00000FF, \
+        [R_RT500_CLKCTL0_UTICKFCLKSEL] = 0x7, \
+        [R_RT500_CLKCTL0_WDT0FCLKSEL] = 0x7, \
+        [R_RT500_CLKCTL0_A32KHZWAKECLKSEL] = 0x7, \
+        [R_RT500_CLKCTL0_A32KHZWAKECLKDIV] = 0xE00000FF, \
+        [R_RT500_CLKCTL0_SYSTICKFCLKSEL] = 0x7, \
+        [R_RT500_CLKCTL0_SYSTICKFCLKDIV] = 0xE00000FF, \
+        [R_RT500_CLKCTL0_DPHYCLKSEL] = 0x7, \
+        [R_RT500_CLKCTL0_DPHYCLKDIV] = 0xE00000FF, \
+        [R_RT500_CLKCTL0_DPHYESCCLKSEL] = 0x7, \
+        [R_RT500_CLKCTL0_DPHYESCRXCLKDIV] = 0xE00000FF, \
+        [R_RT500_CLKCTL0_DPHYESCTXCLKDIV] = 0xE00000FF, \
+        [R_RT500_CLKCTL0_GPUCLKSEL] = 0x7, \
+        [R_RT500_CLKCTL0_GPUCLKDIV] = 0xE00000FF, \
+        [R_RT500_CLKCTL0_DCPIXELCLKSEL] = 0x7, \
+        [R_RT500_CLKCTL0_DCPIXELCLKDIV] = 0xE00000FF, \
+    }
+
+static inline void rt500_clkctl0_reset_registers(uint32_t *regs)
+{
+    regs[R_RT500_CLKCTL0_PSCCTL0] = 0x5;
+    regs[R_RT500_CLKCTL0_PSCCTL1] = 0x0;
+    regs[R_RT500_CLKCTL0_PSCCTL2] = 0x0;
+    regs[R_RT500_CLKCTL0_PSCCTL0_SET] = 0x0;
+    regs[R_RT500_CLKCTL0_PSCCTL1_SET] = 0x0;
+    regs[R_RT500_CLKCTL0_PSCCTL2_SET] = 0x0;
+    regs[R_RT500_CLKCTL0_PSCCTL0_CLR] = 0x0;
+    regs[R_RT500_CLKCTL0_PSCCTL1_CLR] = 0x0;
+    regs[R_RT500_CLKCTL0_PSCCTL2_CLR] = 0x0;
+    regs[R_RT500_CLKCTL0_FRO_CONTROL] = 0x0;
+    regs[R_RT500_CLKCTL0_FRO_CAPVAL] = 0x0;
+    regs[R_RT500_CLKCTL0_FRO_RDTRIM] = 0x3bf;
+    regs[R_RT500_CLKCTL0_FRO_SCTRIM] = 0x20;
+    regs[R_RT500_CLKCTL0_FRODIVSEL] = 0x0;
+    regs[R_RT500_CLKCTL0_FROCLKSTATUS] = 0x0;
+    regs[R_RT500_CLKCTL0_FRODIVOEN] = 0x0;
+    regs[R_RT500_CLKCTL0_LOWFREQCLKDIV] = 0x0;
+    regs[R_RT500_CLKCTL0_SYSOSCCTL0] = 0x0;
+    regs[R_RT500_CLKCTL0_SYSOSCBYPASS] = 0x0;
+    regs[R_RT500_CLKCTL0_LPOSCCTL0] = 0x807bc4d4;
+    regs[R_RT500_CLKCTL0_OSC32KHZCTL0] = 0x0;
+    regs[R_RT500_CLKCTL0_SYSPLL0CLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL0_SYSPLL0CTL0] = 0x160002;
+    regs[R_RT500_CLKCTL0_SYSPLL0LOCKTIMEDIV2] = 0xcafe;
+    regs[R_RT500_CLKCTL0_SYSPLL0NUM] = 0x4dd2f15;
+    regs[R_RT500_CLKCTL0_SYSPLL0DENOM] = 0x1fffffdb;
+    regs[R_RT500_CLKCTL0_SYSPLL0PFD] = 0x80808080;
+    regs[R_RT500_CLKCTL0_MAINPLLCLKDIV] = 0x0;
+    regs[R_RT500_CLKCTL0_DSPPLLCLKDIV] = 0x0;
+    regs[R_RT500_CLKCTL0_AUX0PLLCLKDIV] = 0x0;
+    regs[R_RT500_CLKCTL0_AUX1PLLCLKDIV] = 0x0;
+    regs[R_RT500_CLKCTL0_SYSCPUAHBCLKDIV] = 0x0;
+    regs[R_RT500_CLKCTL0_MAINCLKSELA] = 0x0;
+    regs[R_RT500_CLKCTL0_MAINCLKSELB] = 0x0;
+    regs[R_RT500_CLKCTL0_PFC0DIV] = 0x40000000;
+    regs[R_RT500_CLKCTL0_PFC1DIV] = 0x40000000;
+    regs[R_RT500_CLKCTL0_FLEXSPI0FCLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL0_FLEXSPI0FCLKDIV] = 0x40000000;
+    regs[R_RT500_CLKCTL0_FLEXSPI1FCLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL0_FLEXSPI1FCLKDIV] = 0x40000000;
+    regs[R_RT500_CLKCTL0_SCTFCLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL0_SCTIN7CLKDIV] = 0x40000000;
+    regs[R_RT500_CLKCTL0_USBHSFCLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL0_USBHSFCLKDIV] = 0x40000000;
+    regs[R_RT500_CLKCTL0_SDIO0FCLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL0_SDIO0FCLKDIV] = 0x40000000;
+    regs[R_RT500_CLKCTL0_SDIO1FCLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL0_SDIO1FCLKDIV] = 0x40000000;
+    regs[R_RT500_CLKCTL0_ADC0FCLKSEL0] = 0x7;
+    regs[R_RT500_CLKCTL0_ADC0FCLKSEL1] = 0x7;
+    regs[R_RT500_CLKCTL0_ADC0FCLKDIV] = 0x40000000;
+    regs[R_RT500_CLKCTL0_UTICKFCLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL0_WDT0FCLKSEL] = 0x0;
+    regs[R_RT500_CLKCTL0_A32KHZWAKECLKSEL] = 0x1;
+    regs[R_RT500_CLKCTL0_A32KHZWAKECLKDIV] = 0x1f;
+    regs[R_RT500_CLKCTL0_SYSTICKFCLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL0_SYSTICKFCLKDIV] = 0x40000000;
+    regs[R_RT500_CLKCTL0_DPHYCLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL0_DPHYCLKDIV] = 0x40000000;
+    regs[R_RT500_CLKCTL0_DPHYESCCLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL0_DPHYESCRXCLKDIV] = 0x40000010;
+    regs[R_RT500_CLKCTL0_DPHYESCTXCLKDIV] = 0x40000011;
+    regs[R_RT500_CLKCTL0_GPUCLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL0_GPUCLKDIV] = 0x40000000;
+    regs[R_RT500_CLKCTL0_DCPIXELCLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL0_DCPIXELCLKDIV] = 0x40000000;
+}
diff --git a/include/hw/arm/svd/rt500_clkctl1.h b/include/hw/arm/svd/rt500_clkctl1.h
new file mode 100644
index 0000000000..c5d6a23c4f
--- /dev/null
+++ b/include/hw/arm/svd/rt500_clkctl1.h
@@ -0,0 +1,3109 @@
+/*
+ * Copyright 2016-2023 NXP SPDX-License-Identifier: BSD-3-Clause
+ *
+ * Automatically generated by svd-gen-header.py from MIMXRT595S_cm33.xml
+ */
+#pragma once
+
+#include "hw/registerfields.h"
+
+/* Clock Controller 1 */
+#define RT500_CLKCTL1_REGS_NO (526)
+
+/* Clock Control 0 */
+REG32(RT500_CLKCTL1_PSCCTL0, 16);
+/* Flexcomm Interface 0 clock control */
+FIELD(RT500_CLKCTL1_PSCCTL0, FC0_CLK, 8, 1);
+/* Flexcomm Interface 1 clock control */
+FIELD(RT500_CLKCTL1_PSCCTL0, FC1_CLK, 9, 1);
+/* Flexcomm Interface 2 clock control */
+FIELD(RT500_CLKCTL1_PSCCTL0, FC2_CLK, 10, 1);
+/* Flexcomm Interface 3 clock control */
+FIELD(RT500_CLKCTL1_PSCCTL0, FC3_CLK, 11, 1);
+/* Flexcomm Interface 4 clock control */
+FIELD(RT500_CLKCTL1_PSCCTL0, FC4_CLK, 12, 1);
+/* Flexcomm Interface 5 clock control */
+FIELD(RT500_CLKCTL1_PSCCTL0, FC5_CLK, 13, 1);
+/* Flexcomm Interface 6 clock control */
+FIELD(RT500_CLKCTL1_PSCCTL0, FC6_CLK, 14, 1);
+/* Flexcomm Interface 7 clock control */
+FIELD(RT500_CLKCTL1_PSCCTL0, FC7_CLK, 15, 1);
+/* Flexcomm Interface 8 clock control */
+FIELD(RT500_CLKCTL1_PSCCTL0, FC8_CLK, 16, 1);
+/* Flexcomm Interface 9 clock control */
+FIELD(RT500_CLKCTL1_PSCCTL0, FC9_CLK, 17, 1);
+/* Flexcomm Interface 10 clock control */
+FIELD(RT500_CLKCTL1_PSCCTL0, FC10_CLK, 18, 1);
+/* Flexcomm Interface 11 clock control */
+FIELD(RT500_CLKCTL1_PSCCTL0, FC11_CLK, 19, 1);
+/* Flexcomm Interface 12 clock control */
+FIELD(RT500_CLKCTL1_PSCCTL0, FC12_CLK, 20, 1);
+/* Flexcomm Interface 13 clock control */
+FIELD(RT500_CLKCTL1_PSCCTL0, FC13_CLK, 21, 1);
+/* Flexcomm Interface 14 SPI clock control */
+FIELD(RT500_CLKCTL1_PSCCTL0, FC14_SPI_CLK, 22, 1);
+/* Flexcomm Interface 15 I2C clock control */
+FIELD(RT500_CLKCTL1_PSCCTL0, FC15_I2C_CLK, 23, 1);
+/* DMIC0 clock control */
+FIELD(RT500_CLKCTL1_PSCCTL0, DMIC0, 24, 1);
+/* Flexcomm Interface 16 SPI clock control */
+FIELD(RT500_CLKCTL1_PSCCTL0, FC16_SPI_CLK, 25, 1);
+/* OS event timer bus clock control */
+FIELD(RT500_CLKCTL1_PSCCTL0, OSEVENT_TIMER, 27, 1);
+/* FlexIO clock control */
+FIELD(RT500_CLKCTL1_PSCCTL0, FlexIO, 29, 1);
+
+/* Clock Control 1 */
+REG32(RT500_CLKCTL1_PSCCTL1, 20);
+/* Non-secure GPIO0 clock control */
+FIELD(RT500_CLKCTL1_PSCCTL1, HSGPIO0_CLK, 0, 1);
+/* Non-secure GPIO1 clock control */
+FIELD(RT500_CLKCTL1_PSCCTL1, HSGPIO1_CLK, 1, 1);
+/* Non-secure GPIO2 clock control */
+FIELD(RT500_CLKCTL1_PSCCTL1, HSGPIO2_CLK, 2, 1);
+/* Non-secure GPIO3 clock control */
+FIELD(RT500_CLKCTL1_PSCCTL1, HSGPIO3_CLK, 3, 1);
+/* Non-secure GPIO4 clock control */
+FIELD(RT500_CLKCTL1_PSCCTL1, HSGPIO4_CLK, 4, 1);
+/* Non-secure GPIO5 clock control */
+FIELD(RT500_CLKCTL1_PSCCTL1, HSGPIO5_CLK, 5, 1);
+/* Non-secure GPIO6 clock control */
+FIELD(RT500_CLKCTL1_PSCCTL1, HSGPIO6_CLK, 6, 1);
+/* Non-secure GPIO7 clock control */
+FIELD(RT500_CLKCTL1_PSCCTL1, HSGPIO7_CLK, 7, 1);
+/* CRC clock control */
+FIELD(RT500_CLKCTL1_PSCCTL1, CRC_CLK, 16, 1);
+/* DMAC0 clock control */
+FIELD(RT500_CLKCTL1_PSCCTL1, DMAC0_CLK, 23, 1);
+/* DMAC1 clock control */
+FIELD(RT500_CLKCTL1_PSCCTL1, DMAC1_CLK, 24, 1);
+/* Messaging Unit clock control */
+FIELD(RT500_CLKCTL1_PSCCTL1, MU_CLK, 28, 1);
+/* Semaphore clock control */
+FIELD(RT500_CLKCTL1_PSCCTL1, SEMA_CLK, 29, 1);
+/* Frequency Measurement clock control */
+FIELD(RT500_CLKCTL1_PSCCTL1, FREQME_CLK, 31, 1);
+
+/* Clock Control 2 */
+REG32(RT500_CLKCTL1_PSCCTL2, 24);
+/* CT32BIT bit timer 0 clock control */
+FIELD(RT500_CLKCTL1_PSCCTL2, CT32BIT0_CLK, 0, 1);
+/* CT32BIT bit timer 1 clock control */
+FIELD(RT500_CLKCTL1_PSCCTL2, CT32BIT1_CLK, 1, 1);
+/* CT32BIT bit timer 2 clock control */
+FIELD(RT500_CLKCTL1_PSCCTL2, CT32BIT2_CLK, 2, 1);
+/* CT32BIT bit timer 3 clock control */
+FIELD(RT500_CLKCTL1_PSCCTL2, CT32BIT3_CLK, 3, 1);
+/* CT32BIT bit timer 4 clock control */
+FIELD(RT500_CLKCTL1_PSCCTL2, CT32BIT4_CLK, 4, 1);
+/* RTC clock control */
+FIELD(RT500_CLKCTL1_PSCCTL2, RTCLITE_CLK, 7, 1);
+/* Multi-Rate Timer 0 clock control */
+FIELD(RT500_CLKCTL1_PSCCTL2, MRT0_CLK, 8, 1);
+/* Watchdog Timer 1 clock control */
+FIELD(RT500_CLKCTL1_PSCCTL2, WWDT1_CLK, 10, 1);
+/* I3C0 clock control */
+FIELD(RT500_CLKCTL1_PSCCTL2, I3C0_CLK, 16, 1);
+/* I3C1 clock control */
+FIELD(RT500_CLKCTL1_PSCCTL2, I3C1_CLK, 17, 1);
+/* PINT clock control */
+FIELD(RT500_CLKCTL1_PSCCTL2, GPIOINTCTL_CLK, 30, 1);
+/* INPUTMUX clock control */
+FIELD(RT500_CLKCTL1_PSCCTL2, PIMCTL_CLK, 31, 1);
+
+/* Clock Set 0 */
+REG32(RT500_CLKCTL1_PSCCTL0_SET, 64);
+/* Flexcomm Interface 0 clock set */
+FIELD(RT500_CLKCTL1_PSCCTL0_SET, FC0_CLK, 8, 1);
+/* Flexcomm Interface 1 clock set */
+FIELD(RT500_CLKCTL1_PSCCTL0_SET, FC1_CLK, 9, 1);
+/* Flexcomm Interface 2 clock set */
+FIELD(RT500_CLKCTL1_PSCCTL0_SET, FC2_CLK, 10, 1);
+/* Flexcomm Interface 3 clock set */
+FIELD(RT500_CLKCTL1_PSCCTL0_SET, FC3_CLK, 11, 1);
+/* Flexcomm Interface 4 clock set */
+FIELD(RT500_CLKCTL1_PSCCTL0_SET, FC4_CLK, 12, 1);
+/* Flexcomm Interface 5 clock set */
+FIELD(RT500_CLKCTL1_PSCCTL0_SET, FC5_CLK, 13, 1);
+/* Flexcomm Interface 6 clock set */
+FIELD(RT500_CLKCTL1_PSCCTL0_SET, FC6_CLK, 14, 1);
+/* Flexcomm Interface 7 clock set */
+FIELD(RT500_CLKCTL1_PSCCTL0_SET, FC7_CLK, 15, 1);
+/* Flexcomm Interface 8 clock set */
+FIELD(RT500_CLKCTL1_PSCCTL0_SET, FC8_CLK, 16, 1);
+/* Flexcomm Interface 9 clock set */
+FIELD(RT500_CLKCTL1_PSCCTL0_SET, FC9_CLK, 17, 1);
+/* Flexcomm Interface 10 clock set */
+FIELD(RT500_CLKCTL1_PSCCTL0_SET, FC10_CLK, 18, 1);
+/* Flexcomm Interface 11 clock set */
+FIELD(RT500_CLKCTL1_PSCCTL0_SET, FC11_CLK, 19, 1);
+/* Flexcomm Interface 12 clock set */
+FIELD(RT500_CLKCTL1_PSCCTL0_SET, FC12_CLK, 20, 1);
+/* Flexcomm Interface 13 clock set */
+FIELD(RT500_CLKCTL1_PSCCTL0_SET, FC13_CLK, 21, 1);
+/* Flexcomm Interface 14 SPI clock control */
+FIELD(RT500_CLKCTL1_PSCCTL0_SET, FC14_SPI_CLK, 22, 1);
+/* Flexcomm Interface 15 I2C clock control */
+FIELD(RT500_CLKCTL1_PSCCTL0_SET, FC15_I2C_CLK, 23, 1);
+/* DMIC0 clock control */
+FIELD(RT500_CLKCTL1_PSCCTL0_SET, DMIC0, 24, 1);
+/* Flexcomm Interface 16 SPI clock control */
+FIELD(RT500_CLKCTL1_PSCCTL0_SET, FC16_SPI_CLK, 25, 1);
+/* OS event timer bus clock control */
+FIELD(RT500_CLKCTL1_PSCCTL0_SET, OSEVENT_TIMER, 27, 1);
+/* FlexIO clock control */
+FIELD(RT500_CLKCTL1_PSCCTL0_SET, FlexIO, 29, 1);
+
+/* Clock Set 1 */
+REG32(RT500_CLKCTL1_PSCCTL1_SET, 68);
+/* Non-secure GPIO0 clock control set */
+FIELD(RT500_CLKCTL1_PSCCTL1_SET, HSGPIO0_CLK, 0, 1);
+/* Non-secure GPIO1 clock control set */
+FIELD(RT500_CLKCTL1_PSCCTL1_SET, HSGPIO1_CLK, 1, 1);
+/* Non-secure GPIO2 clock control set */
+FIELD(RT500_CLKCTL1_PSCCTL1_SET, HSGPIO2_CLK, 2, 1);
+/* Non-secure GPIO3 clock control set */
+FIELD(RT500_CLKCTL1_PSCCTL1_SET, HSGPIO3_CLK, 3, 1);
+/* Non-secure GPIO4 clock control set */
+FIELD(RT500_CLKCTL1_PSCCTL1_SET, HSGPIO4_CLK, 4, 1);
+/* Non-secure GPIO5 clock control set */
+FIELD(RT500_CLKCTL1_PSCCTL1_SET, HSGPIO5_CLK, 5, 1);
+/* Non-secure GPIO6 clock control set */
+FIELD(RT500_CLKCTL1_PSCCTL1_SET, HSGPIO6_CLK, 6, 1);
+/* Non-secure GPIO7 clock control set */
+FIELD(RT500_CLKCTL1_PSCCTL1_SET, HSGPIO7_CLK, 7, 1);
+/* CRC clock control set */
+FIELD(RT500_CLKCTL1_PSCCTL1_SET, CRC_CLK, 16, 1);
+/* DMAC0 clock control set */
+FIELD(RT500_CLKCTL1_PSCCTL1_SET, DMAC0_CLK, 23, 1);
+/* DMAC1 clock control set */
+FIELD(RT500_CLKCTL1_PSCCTL1_SET, DMAC1_CLK, 24, 1);
+/* Messaging Unit clock control set */
+FIELD(RT500_CLKCTL1_PSCCTL1_SET, MU_CLK, 28, 1);
+/* Semaphore clock control set */
+FIELD(RT500_CLKCTL1_PSCCTL1_SET, SEMA_CLK, 29, 1);
+/* Frequency Measurement clock control set */
+FIELD(RT500_CLKCTL1_PSCCTL1_SET, FREQME_CLK, 31, 1);
+
+/* Clock Set 2 */
+REG32(RT500_CLKCTL1_PSCCTL2_SET, 72);
+/* CT32BIT bit timer 0 clock set */
+FIELD(RT500_CLKCTL1_PSCCTL2_SET, CT32BIT0_CLK, 0, 1);
+/* CT32BIT bit timer 1 clock set */
+FIELD(RT500_CLKCTL1_PSCCTL2_SET, CT32BIT1_CLK, 1, 1);
+/* CT32BIT bit timer 2 clock set */
+FIELD(RT500_CLKCTL1_PSCCTL2_SET, CT32BIT2_CLK, 2, 1);
+/* CT32BIT bit timer 3 clock set */
+FIELD(RT500_CLKCTL1_PSCCTL2_SET, CT32BIT3_CLK, 3, 1);
+/* CT32BIT bit timer 4 clock set */
+FIELD(RT500_CLKCTL1_PSCCTL2_SET, CT32BIT4_CLK, 4, 1);
+/* RTC clock control set */
+FIELD(RT500_CLKCTL1_PSCCTL2_SET, RTCLITE_CLK, 7, 1);
+/* Multi-Rate Timer 0 clock control set */
+FIELD(RT500_CLKCTL1_PSCCTL2_SET, MRT0_CLK, 8, 1);
+/* Watchdog Timer 1 clock control set */
+FIELD(RT500_CLKCTL1_PSCCTL2_SET, WWDT1_CLK, 10, 1);
+/* I3C0 clock control set */
+FIELD(RT500_CLKCTL1_PSCCTL2_SET, I3C0_CLK, 16, 1);
+/* I3C1 clock control set */
+FIELD(RT500_CLKCTL1_PSCCTL2_SET, I3C1_CLK, 17, 1);
+/* PINT clock control set */
+FIELD(RT500_CLKCTL1_PSCCTL2_SET, GPIOINTCTL_CLK, 30, 1);
+/* INPUTMUX clock control set */
+FIELD(RT500_CLKCTL1_PSCCTL2_SET, PIMCTL_CLK, 31, 1);
+
+/* Clock Clear 0 */
+REG32(RT500_CLKCTL1_PSCCTL0_CLR, 112);
+/* Flexcomm Interface 0 clock control clear */
+FIELD(RT500_CLKCTL1_PSCCTL0_CLR, FC0_CLK, 8, 1);
+/* Flexcomm Interface 1 clock control clear */
+FIELD(RT500_CLKCTL1_PSCCTL0_CLR, FC1_CLK, 9, 1);
+/* Flexcomm Interface 2 clock control clear */
+FIELD(RT500_CLKCTL1_PSCCTL0_CLR, FC2_CLK, 10, 1);
+/* Flexcomm Interface 3 clock control clear */
+FIELD(RT500_CLKCTL1_PSCCTL0_CLR, FC3_CLK, 11, 1);
+/* Flexcomm Interface 4 clock control clear */
+FIELD(RT500_CLKCTL1_PSCCTL0_CLR, FC4_CLK, 12, 1);
+/* Flexcomm Interface 5 clock control clear */
+FIELD(RT500_CLKCTL1_PSCCTL0_CLR, FC5_CLK, 13, 1);
+/* Flexcomm Interface 6 clock control clear */
+FIELD(RT500_CLKCTL1_PSCCTL0_CLR, FC6_CLK, 14, 1);
+/* Flexcomm Interface 7 clock control clear */
+FIELD(RT500_CLKCTL1_PSCCTL0_CLR, FC7_CLK, 15, 1);
+/* Flexcomm Interface 8 clock control clear */
+FIELD(RT500_CLKCTL1_PSCCTL0_CLR, FC8_CLK, 16, 1);
+/* Flexcomm Interface 9 clock control clear */
+FIELD(RT500_CLKCTL1_PSCCTL0_CLR, FC9_CLK, 17, 1);
+/* Flexcomm Interface 10 clock control clear */
+FIELD(RT500_CLKCTL1_PSCCTL0_CLR, FC10_CLK, 18, 1);
+/* Flexcomm Interface 11 clock control clear */
+FIELD(RT500_CLKCTL1_PSCCTL0_CLR, FC11_CLK, 19, 1);
+/* Flexcomm Interface 12 clock control clear */
+FIELD(RT500_CLKCTL1_PSCCTL0_CLR, FC12_CLK, 20, 1);
+/* Flexcomm Interface 13 clock control clear */
+FIELD(RT500_CLKCTL1_PSCCTL0_CLR, FC13_CLK, 21, 1);
+/* Flexcomm Interface 14 SPI clock control clear */
+FIELD(RT500_CLKCTL1_PSCCTL0_CLR, FC14_SPI_CLK, 22, 1);
+/* Flexcomm Interface 15 I2C clock control clear */
+FIELD(RT500_CLKCTL1_PSCCTL0_CLR, FC15_I2C_CLK, 23, 1);
+/* DMIC0 clock control clear */
+FIELD(RT500_CLKCTL1_PSCCTL0_CLR, DMIC0, 24, 1);
+/* Flexcomm Interface 16 SPI clock control clear */
+FIELD(RT500_CLKCTL1_PSCCTL0_CLR, FC16_SPI_CLK, 25, 1);
+/* OS event timer bus clock control clear */
+FIELD(RT500_CLKCTL1_PSCCTL0_CLR, OSEVENT_TIMER, 27, 1);
+/* FlexIO clock control clear */
+FIELD(RT500_CLKCTL1_PSCCTL0_CLR, FlexIO, 29, 1);
+
+/* Clock Clear 1 */
+REG32(RT500_CLKCTL1_PSCCTL1_CLR, 116);
+/* Non-secure GPIO0 clock control */
+FIELD(RT500_CLKCTL1_PSCCTL1_CLR, HSGPIO0_CLK, 0, 1);
+/* Non-secure GPIO1 clock control */
+FIELD(RT500_CLKCTL1_PSCCTL1_CLR, HSGPIO1_CLK, 1, 1);
+/* Non-secure GPIO2 clock control */
+FIELD(RT500_CLKCTL1_PSCCTL1_CLR, HSGPIO2_CLK, 2, 1);
+/* Non-secure GPIO3 clock control */
+FIELD(RT500_CLKCTL1_PSCCTL1_CLR, HSGPIO3_CLK, 3, 1);
+/* Non-secure GPIO4 clock control */
+FIELD(RT500_CLKCTL1_PSCCTL1_CLR, HSGPIO4_CLK, 4, 1);
+/* Non-secure GPIO5 clock control */
+FIELD(RT500_CLKCTL1_PSCCTL1_CLR, HSGPIO5_CLK, 5, 1);
+/* Non-secure GPIO6 clock control */
+FIELD(RT500_CLKCTL1_PSCCTL1_CLR, HSGPIO6_CLK, 6, 1);
+/* Non-secure GPIO7 clock control */
+FIELD(RT500_CLKCTL1_PSCCTL1_CLR, HSGPIO7_CLK, 7, 1);
+/* CRC clock control */
+FIELD(RT500_CLKCTL1_PSCCTL1_CLR, CRC_CLK, 16, 1);
+/* DMAC0 clock control */
+FIELD(RT500_CLKCTL1_PSCCTL1_CLR, DMAC0_CLK, 23, 1);
+/* DMAC1 clock control */
+FIELD(RT500_CLKCTL1_PSCCTL1_CLR, DMAC1_CLK, 24, 1);
+/* Messaging Unit clock control */
+FIELD(RT500_CLKCTL1_PSCCTL1_CLR, MU_CLK, 28, 1);
+/* Semaphore clock control */
+FIELD(RT500_CLKCTL1_PSCCTL1_CLR, SEMA_CLK, 29, 1);
+/* Frequency Measurement clock control */
+FIELD(RT500_CLKCTL1_PSCCTL1_CLR, FREQME_CLK, 31, 1);
+
+/* Clock Clear 2 */
+REG32(RT500_CLKCTL1_PSCCTL2_CLR, 120);
+/* CT32BIT bit timer 0 clock clear */
+FIELD(RT500_CLKCTL1_PSCCTL2_CLR, CT32BIT0_CLK, 0, 1);
+/* CT32BIT bit timer 1 clock clear */
+FIELD(RT500_CLKCTL1_PSCCTL2_CLR, CT32BIT1_CLK, 1, 1);
+/* CT32BIT bit timer 2 clock clear */
+FIELD(RT500_CLKCTL1_PSCCTL2_CLR, CT32BIT2_CLK, 2, 1);
+/* CT32BIT bit timer 3 clock clear */
+FIELD(RT500_CLKCTL1_PSCCTL2_CLR, CT32BIT3_CLK, 3, 1);
+/* CT32BIT bit timer 4 clock clear */
+FIELD(RT500_CLKCTL1_PSCCTL2_CLR, CT32BIT4_CLK, 4, 1);
+/* RTC clock control clear */
+FIELD(RT500_CLKCTL1_PSCCTL2_CLR, RTCLITE_CLK, 7, 1);
+/* Multi-Rate Timer 0 clock control clear */
+FIELD(RT500_CLKCTL1_PSCCTL2_CLR, MRT0_CLK, 8, 1);
+/* Watchdog Timer 1 clock control clear */
+FIELD(RT500_CLKCTL1_PSCCTL2_CLR, WWDT1_CLK, 10, 1);
+/* I3C0 clock control clear */
+FIELD(RT500_CLKCTL1_PSCCTL2_CLR, I3C0_CLK, 16, 1);
+/* I3C1 clock control clear */
+FIELD(RT500_CLKCTL1_PSCCTL2_CLR, I3C1_CLK, 17, 1);
+/* PINT clock control clear */
+FIELD(RT500_CLKCTL1_PSCCTL2_CLR, GPIOINTCTL_CLK, 30, 1);
+/* INPUTMUX clock control clear */
+FIELD(RT500_CLKCTL1_PSCCTL2_CLR, PIMCTL_CLK, 31, 1);
+
+/* Audio PLL0 Clock Select */
+REG32(RT500_CLKCTL1_AUDIOPLL0CLKSEL, 512);
+/* Audio PLL0 Clock Select */
+FIELD(RT500_CLKCTL1_AUDIOPLL0CLKSEL, SEL, 0, 3);
+
+/* Audio PLL0 Control 0 */
+REG32(RT500_CLKCTL1_AUDIOPLL0CTL0, 516);
+/* AUDIOPLL0 BYPASS Mode */
+FIELD(RT500_CLKCTL1_AUDIOPLL0CTL0, BYPASS, 0, 1);
+/* AUDIOPLL0 Reset */
+FIELD(RT500_CLKCTL1_AUDIOPLL0CTL0, RESET, 1, 1);
+/* Hold Ring Off Control */
+FIELD(RT500_CLKCTL1_AUDIOPLL0CTL0, HOLDRINGOFF_ENA, 13, 1);
+/* Multiplication Factor */
+FIELD(RT500_CLKCTL1_AUDIOPLL0CTL0, MULT, 16, 8);
+
+/* Audio PLL0 Lock Time Divide-by-2 */
+REG32(RT500_CLKCTL1_AUDIOPLL0LOCKTIMEDIV2, 524);
+/* AUDIOPLL0 Lock Time Divide-by-2 */
+FIELD(RT500_CLKCTL1_AUDIOPLL0LOCKTIMEDIV2, LOCKTIMEDIV2, 0, 16);
+
+/* Audio PLL0 Numerator */
+REG32(RT500_CLKCTL1_AUDIOPLL0NUM, 528);
+/* Numerator */
+FIELD(RT500_CLKCTL1_AUDIOPLL0NUM, NUM, 0, 30);
+
+/* Audio PLL0 Denominator */
+REG32(RT500_CLKCTL1_AUDIOPLL0DENOM, 532);
+/* Denominator */
+FIELD(RT500_CLKCTL1_AUDIOPLL0DENOM, DENOM, 0, 30);
+
+/* Audio PLL0 PFD */
+REG32(RT500_CLKCTL1_AUDIOPLL0PFD, 536);
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
+/* Audio PLL Clock Divider */
+REG32(RT500_CLKCTL1_AUDIOPLLCLKDIV, 576);
+/* Audio PLL Clock Divider Value */
+FIELD(RT500_CLKCTL1_AUDIOPLLCLKDIV, DIV, 0, 8);
+/* Reset the Divider Counter */
+FIELD(RT500_CLKCTL1_AUDIOPLLCLKDIV, RESET, 29, 1);
+/* Halt the Divider Counter */
+FIELD(RT500_CLKCTL1_AUDIOPLLCLKDIV, HALT, 30, 1);
+/* Divider Status Flag */
+FIELD(RT500_CLKCTL1_AUDIOPLLCLKDIV, REQFLAG, 31, 1);
+
+/* DSP CPU Clock Divider */
+REG32(RT500_CLKCTL1_DSPCPUCLKDIV, 1024);
+/* DSP Clock Divider Value */
+FIELD(RT500_CLKCTL1_DSPCPUCLKDIV, DIV, 0, 8);
+/* Reset the Divider Counter */
+FIELD(RT500_CLKCTL1_DSPCPUCLKDIV, RESET, 29, 1);
+/* Halt the Divider Counter */
+FIELD(RT500_CLKCTL1_DSPCPUCLKDIV, HALT, 30, 1);
+/* Divider Status Flag */
+FIELD(RT500_CLKCTL1_DSPCPUCLKDIV, REQFLAG, 31, 1);
+
+/* DSP CPU Clock Select A */
+REG32(RT500_CLKCTL1_DSPCPUCLKSELA, 1072);
+/* DSP Main 1st Stage Control Clock Source */
+FIELD(RT500_CLKCTL1_DSPCPUCLKSELA, SEL, 0, 2);
+
+/* DSP CPU Clock Select B */
+REG32(RT500_CLKCTL1_DSPCPUCLKSELB, 1076);
+/* Main Clock Source */
+FIELD(RT500_CLKCTL1_DSPCPUCLKSELB, SEL, 0, 2);
+
+/* OS Event Timer Functional Clock Select */
+REG32(RT500_CLKCTL1_OSEVENTTFCLKSEL, 1152);
+/* OS Event Timer Functional Clock Source */
+FIELD(RT500_CLKCTL1_OSEVENTTFCLKSEL, SEL, 0, 3);
+
+/* Fractional Rate Generator 0 Clock Select */
+REG32(RT500_CLKCTL1_FRG0CLKSEL, 1280);
+/* Fractional Generator 0 Clock Source */
+FIELD(RT500_CLKCTL1_FRG0CLKSEL, SEL, 0, 3);
+
+/* Fractional Rate Generator 0 Control */
+REG32(RT500_CLKCTL1_FRG0CTL, 1284);
+/*
+ * Denominator of the fractional divider: DIV is equal to the programmed value
+ * +1
+ */
+FIELD(RT500_CLKCTL1_FRG0CTL, DIV, 0, 8);
+/*
+ * Numerator of the fractional divider: MULT is equal to the programmed value.
+ */
+FIELD(RT500_CLKCTL1_FRG0CTL, MULT, 8, 8);
+
+/* Flexcomm0 Clock Select */
+REG32(RT500_CLKCTL1_FC0FCLKSEL, 1288);
+/* Flexcomm Functional Clock Source */
+FIELD(RT500_CLKCTL1_FC0FCLKSEL, SEL, 0, 3);
+
+/* Fractional Rate Generator 1 Clock Select */
+REG32(RT500_CLKCTL1_FRG1CLKSEL, 1312);
+/* Fractional Generator 1 Clock Source */
+FIELD(RT500_CLKCTL1_FRG1CLKSEL, SEL, 0, 3);
+
+/* Fractional Rate Generator 1 Control */
+REG32(RT500_CLKCTL1_FRG1CTL, 1316);
+/*
+ * Denominator of the fractional divider: DIV is equal to the programmed value
+ * +1
+ */
+FIELD(RT500_CLKCTL1_FRG1CTL, DIV, 0, 8);
+/*
+ * Numerator of the fractional divider: MULT is equal to the programmed value.
+ */
+FIELD(RT500_CLKCTL1_FRG1CTL, MULT, 8, 8);
+
+/* Flexcomm1 Clock Select */
+REG32(RT500_CLKCTL1_FC1FCLKSEL, 1320);
+/* Flexcomm Functional Clock Source */
+FIELD(RT500_CLKCTL1_FC1FCLKSEL, SEL, 0, 3);
+
+/* Fractional Rate Generator 2 Clock Select */
+REG32(RT500_CLKCTL1_FRG2CLKSEL, 1344);
+/* Fractional Generator 2 Clock Source */
+FIELD(RT500_CLKCTL1_FRG2CLKSEL, SEL, 0, 3);
+
+/* Fractional Rate Generator 2 Control */
+REG32(RT500_CLKCTL1_FRG2CTL, 1348);
+/*
+ * Denominator of the fractional divider: DIV is equal to the programmed value
+ * +1
+ */
+FIELD(RT500_CLKCTL1_FRG2CTL, DIV, 0, 8);
+/*
+ * Numerator of the fractional divider: MULT is equal to the programmed value.
+ */
+FIELD(RT500_CLKCTL1_FRG2CTL, MULT, 8, 8);
+
+/* Flexcomm2 Clock Select */
+REG32(RT500_CLKCTL1_FC2FCLKSEL, 1352);
+/* Flexcomm Functional Clock Source */
+FIELD(RT500_CLKCTL1_FC2FCLKSEL, SEL, 0, 3);
+
+/* Fractional Rate Generator 3 Clock Select */
+REG32(RT500_CLKCTL1_FRG3CLKSEL, 1376);
+/* Fractional Generator 3 Clock Source */
+FIELD(RT500_CLKCTL1_FRG3CLKSEL, SEL, 0, 3);
+
+/* Fractional Rate Generator 3 Control */
+REG32(RT500_CLKCTL1_FRG3CTL, 1380);
+/*
+ * Denominator of the fractional divider: DIV is equal to the programmed value
+ * +1
+ */
+FIELD(RT500_CLKCTL1_FRG3CTL, DIV, 0, 8);
+/*
+ * Numerator of the fractional divider: MULT is equal to the programmed value.
+ */
+FIELD(RT500_CLKCTL1_FRG3CTL, MULT, 8, 8);
+
+/* Flexcomm3 Clock Select */
+REG32(RT500_CLKCTL1_FC3FCLKSEL, 1384);
+/* Flexcomm Functional Clock Source */
+FIELD(RT500_CLKCTL1_FC3FCLKSEL, SEL, 0, 3);
+
+/* Fractional Rate Generator 4 Clock Select */
+REG32(RT500_CLKCTL1_FRG4CLKSEL, 1408);
+/* Fractional Generator 4 Clock Source */
+FIELD(RT500_CLKCTL1_FRG4CLKSEL, SEL, 0, 3);
+
+/* Fractional Rate Generator 4 Control */
+REG32(RT500_CLKCTL1_FRG4CTL, 1412);
+/*
+ * Denominator of the fractional divider: DIV is equal to the programmed value
+ * +1
+ */
+FIELD(RT500_CLKCTL1_FRG4CTL, DIV, 0, 8);
+/*
+ * Numerator of the fractional divider: MULT is equal to the programmed value.
+ */
+FIELD(RT500_CLKCTL1_FRG4CTL, MULT, 8, 8);
+
+/* Flexcomm4 Clock Select */
+REG32(RT500_CLKCTL1_FC4FCLKSEL, 1416);
+/* Flexcomm Functional Clock Source */
+FIELD(RT500_CLKCTL1_FC4FCLKSEL, SEL, 0, 3);
+
+/* Fractional Rate Generator 5 Clock Select */
+REG32(RT500_CLKCTL1_FRG5CLKSEL, 1440);
+/* Fractional Generator 5 Clock Source */
+FIELD(RT500_CLKCTL1_FRG5CLKSEL, SEL, 0, 3);
+
+/* Fractional Rate Generator 5 Control */
+REG32(RT500_CLKCTL1_FRG5CTL, 1444);
+/*
+ * Denominator of the fractional divider: DIV is equal to the programmed value
+ * +1
+ */
+FIELD(RT500_CLKCTL1_FRG5CTL, DIV, 0, 8);
+/*
+ * Numerator of the fractional divider: MULT is equal to the programmed value.
+ */
+FIELD(RT500_CLKCTL1_FRG5CTL, MULT, 8, 8);
+
+/* Flexcomm5 Clock Select */
+REG32(RT500_CLKCTL1_FC5FCLKSEL, 1448);
+/* Flexcomm Functional Clock Source */
+FIELD(RT500_CLKCTL1_FC5FCLKSEL, SEL, 0, 3);
+
+/* Fractional Rate Generator 6 Clock Select */
+REG32(RT500_CLKCTL1_FRG6CLKSEL, 1472);
+/* Fractional Generator 6 Clock Source */
+FIELD(RT500_CLKCTL1_FRG6CLKSEL, SEL, 0, 3);
+
+/* Fractional Rate Generator 6 Control */
+REG32(RT500_CLKCTL1_FRG6CTL, 1476);
+/*
+ * Denominator of the fractional divider: DIV is equal to the programmed value
+ * +1
+ */
+FIELD(RT500_CLKCTL1_FRG6CTL, DIV, 0, 8);
+/*
+ * Numerator of the fractional divider: MULT is equal to the programmed value.
+ */
+FIELD(RT500_CLKCTL1_FRG6CTL, MULT, 8, 8);
+
+/* Flexcomm6 Clock Select */
+REG32(RT500_CLKCTL1_FC6FCLKSEL, 1480);
+/* Flexcomm Functional Clock Source */
+FIELD(RT500_CLKCTL1_FC6FCLKSEL, SEL, 0, 3);
+
+/* Fractional Rate Generator 7 Clock Select */
+REG32(RT500_CLKCTL1_FRG7CLKSEL, 1504);
+/* Fractional Generator 7 Clock Source */
+FIELD(RT500_CLKCTL1_FRG7CLKSEL, SEL, 0, 3);
+
+/* Fractional Rate Generator 7 Control */
+REG32(RT500_CLKCTL1_FRG7CTL, 1508);
+/*
+ * Denominator of the fractional divider: DIV is equal to the programmed value
+ * +1
+ */
+FIELD(RT500_CLKCTL1_FRG7CTL, DIV, 0, 8);
+/*
+ * Numerator of the fractional divider: MULT is equal to the programmed value.
+ */
+FIELD(RT500_CLKCTL1_FRG7CTL, MULT, 8, 8);
+
+/* Flexcomm7 Clock Select */
+REG32(RT500_CLKCTL1_FC7FCLKSEL, 1512);
+/* Flexcomm Functional Clock Source */
+FIELD(RT500_CLKCTL1_FC7FCLKSEL, SEL, 0, 3);
+
+/* Fractional Rate Generator 8 Clock Select */
+REG32(RT500_CLKCTL1_FRG8CLKSEL, 1536);
+/* Fractional Generator 8 Clock Source */
+FIELD(RT500_CLKCTL1_FRG8CLKSEL, SEL, 0, 3);
+
+/* Fractional Rate Generator 8 Control */
+REG32(RT500_CLKCTL1_FRG8CTL, 1540);
+/*
+ * Denominator of the fractional divider: DIV is equal to the programmed value
+ * +1
+ */
+FIELD(RT500_CLKCTL1_FRG8CTL, DIV, 0, 8);
+/*
+ * Numerator of the fractional divider: MULT is equal to the programmed value.
+ */
+FIELD(RT500_CLKCTL1_FRG8CTL, MULT, 8, 8);
+
+/* Flexcomm8 Clock Select */
+REG32(RT500_CLKCTL1_FC8FCLKSEL, 1544);
+/* Flexcomm Functional Clock Source */
+FIELD(RT500_CLKCTL1_FC8FCLKSEL, SEL, 0, 3);
+
+/* Fractional Rate Generator 9 Clock Select */
+REG32(RT500_CLKCTL1_FRG9CLKSEL, 1568);
+/* Fractional Generator 9 Clock Source */
+FIELD(RT500_CLKCTL1_FRG9CLKSEL, SEL, 0, 3);
+
+/* Fractional Rate Generator 9 Control */
+REG32(RT500_CLKCTL1_FRG9CTL, 1572);
+/*
+ * Denominator of the fractional divider: DIV is equal to the programmed value
+ * +1
+ */
+FIELD(RT500_CLKCTL1_FRG9CTL, DIV, 0, 8);
+/*
+ * Numerator of the fractional divider: MULT is equal to the programmed value.
+ */
+FIELD(RT500_CLKCTL1_FRG9CTL, MULT, 8, 8);
+
+/* Flexcomm9 Clock Select */
+REG32(RT500_CLKCTL1_FC9FCLKSEL, 1576);
+/* Flexcomm Functional Clock Source */
+FIELD(RT500_CLKCTL1_FC9FCLKSEL, SEL, 0, 3);
+
+/* Fractional Rate Generator 10 Clock Select */
+REG32(RT500_CLKCTL1_FRG10CLKSEL, 1600);
+/* Fractional Generator 10 Clock Source */
+FIELD(RT500_CLKCTL1_FRG10CLKSEL, SEL, 0, 3);
+
+/* Fractional Rate Generator 10 Control */
+REG32(RT500_CLKCTL1_FRG10CTL, 1604);
+/*
+ * Denominator of the fractional divider: DIV is equal to the programmed value
+ * +1
+ */
+FIELD(RT500_CLKCTL1_FRG10CTL, DIV, 0, 8);
+/*
+ * Numerator of the fractional divider: MULT is equal to the programmed value.
+ */
+FIELD(RT500_CLKCTL1_FRG10CTL, MULT, 8, 8);
+
+/* Flexcomm10 Clock Select */
+REG32(RT500_CLKCTL1_FC10FCLKSEL, 1608);
+/* Flexcomm Functional Clock Source */
+FIELD(RT500_CLKCTL1_FC10FCLKSEL, SEL, 0, 3);
+
+/* Fractional Rate Generator 11 Clock Select */
+REG32(RT500_CLKCTL1_FRG11CLKSEL, 1632);
+/* Fractional Generator 11 Clock Source */
+FIELD(RT500_CLKCTL1_FRG11CLKSEL, SEL, 0, 3);
+
+/* Fractional Rate Generator 11 Control */
+REG32(RT500_CLKCTL1_FRG11CTL, 1636);
+/*
+ * Denominator of the fractional divider: DIV is equal to the programmed value
+ * +1
+ */
+FIELD(RT500_CLKCTL1_FRG11CTL, DIV, 0, 8);
+/*
+ * Numerator of the fractional divider: MULT is equal to the programmed value.
+ */
+FIELD(RT500_CLKCTL1_FRG11CTL, MULT, 8, 8);
+
+/* Flexcomm11 Clock Select */
+REG32(RT500_CLKCTL1_FC11FCLKSEL, 1640);
+/* Flexcomm Functional Clock Source */
+FIELD(RT500_CLKCTL1_FC11FCLKSEL, SEL, 0, 3);
+
+/* Fractional Rate Generator 12 Clock Select */
+REG32(RT500_CLKCTL1_FRG12CLKSEL, 1664);
+/* Fractional Generator 12 Clock Source */
+FIELD(RT500_CLKCTL1_FRG12CLKSEL, SEL, 0, 3);
+
+/* Fractional Rate Generator 12 Control */
+REG32(RT500_CLKCTL1_FRG12CTL, 1668);
+/*
+ * Denominator of the fractional divider: DIV is equal to the programmed value
+ * +1
+ */
+FIELD(RT500_CLKCTL1_FRG12CTL, DIV, 0, 8);
+/*
+ * Numerator of the fractional divider: MULT is equal to the programmed value.
+ */
+FIELD(RT500_CLKCTL1_FRG12CTL, MULT, 8, 8);
+
+/* Flexcomm12 Clock Select */
+REG32(RT500_CLKCTL1_FC12FCLKSEL, 1672);
+/* Flexcomm Functional Clock Source */
+FIELD(RT500_CLKCTL1_FC12FCLKSEL, SEL, 0, 3);
+
+/* Fractional Rate Generator 13 Clock Select */
+REG32(RT500_CLKCTL1_FRG13CLKSEL, 1696);
+/* Fractional Generator 13 Clock Source */
+FIELD(RT500_CLKCTL1_FRG13CLKSEL, SEL, 0, 3);
+
+/* Fractional Rate Generator 13 Control */
+REG32(RT500_CLKCTL1_FRG13CTL, 1700);
+/*
+ * Denominator of the fractional divider: DIV is equal to the programmed value
+ * +1
+ */
+FIELD(RT500_CLKCTL1_FRG13CTL, DIV, 0, 8);
+/*
+ * Numerator of the fractional divider: MULT is equal to the programmed value.
+ */
+FIELD(RT500_CLKCTL1_FRG13CTL, MULT, 8, 8);
+
+/* Flexcomm13 Clock Select */
+REG32(RT500_CLKCTL1_FC13FCLKSEL, 1704);
+/* Flexcomm Functional Clock Source */
+FIELD(RT500_CLKCTL1_FC13FCLKSEL, SEL, 0, 3);
+
+/* Fractional Rate Generator 14 Clock Select */
+REG32(RT500_CLKCTL1_FRG14CLKSEL, 1728);
+/* Fractional Generator 14 Clock Source */
+FIELD(RT500_CLKCTL1_FRG14CLKSEL, SEL, 0, 3);
+
+/* Fractional Rate Generator 14 Control */
+REG32(RT500_CLKCTL1_FRG14CTL, 1732);
+/*
+ * Denominator of the fractional divider: DIV is equal to the programmed value
+ * +1
+ */
+FIELD(RT500_CLKCTL1_FRG14CTL, DIV, 0, 8);
+/*
+ * Numerator of the fractional divider: MULT is equal to the programmed value.
+ */
+FIELD(RT500_CLKCTL1_FRG14CTL, MULT, 8, 8);
+
+/* Flexcomm14 Clock Select */
+REG32(RT500_CLKCTL1_FC14FCLKSEL, 1736);
+/* Flexcomm Functional Clock Source */
+FIELD(RT500_CLKCTL1_FC14FCLKSEL, SEL, 0, 3);
+
+/* Fractional Rate Generator 15 Clock Select */
+REG32(RT500_CLKCTL1_FRG15CLKSEL, 1760);
+/* Fractional Generator 15 Clock Source */
+FIELD(RT500_CLKCTL1_FRG15CLKSEL, SEL, 0, 3);
+
+/* Fractional Rate Generator 15 Control */
+REG32(RT500_CLKCTL1_FRG15CTL, 1764);
+/*
+ * Denominator of the fractional divider: DIV is equal to the programmed value
+ * +1
+ */
+FIELD(RT500_CLKCTL1_FRG15CTL, DIV, 0, 8);
+/*
+ * Numerator of the fractional divider: MULT is equal to the programmed value.
+ */
+FIELD(RT500_CLKCTL1_FRG15CTL, MULT, 8, 8);
+
+/* Flexcomm15 Clock Select */
+REG32(RT500_CLKCTL1_FC15FCLKSEL, 1768);
+/* Flexcomm Functional Clock Source */
+FIELD(RT500_CLKCTL1_FC15FCLKSEL, SEL, 0, 3);
+
+/* Fractional Rate Generator 16 Clock Select */
+REG32(RT500_CLKCTL1_FRG16CLKSEL, 1792);
+/* Fractional Generator 16 Clock Source */
+FIELD(RT500_CLKCTL1_FRG16CLKSEL, SEL, 0, 3);
+
+/* Fractional Rate Generator 16 Control */
+REG32(RT500_CLKCTL1_FRG16CTL, 1796);
+/*
+ * Denominator of the fractional divider: DIV is equal to the programmed value
+ * +1
+ */
+FIELD(RT500_CLKCTL1_FRG16CTL, DIV, 0, 8);
+/*
+ * Numerator of the fractional divider: MULT is equal to the programmed value.
+ */
+FIELD(RT500_CLKCTL1_FRG16CTL, MULT, 8, 8);
+
+/* Flexcomm16 Clock Select */
+REG32(RT500_CLKCTL1_FC16FCLKSEL, 1800);
+/* Flexcomm Functional Clock Source */
+FIELD(RT500_CLKCTL1_FC16FCLKSEL, SEL, 0, 3);
+
+/* Fractional Rate Generator 17 Clock Select */
+REG32(RT500_CLKCTL1_FRG17CLKSEL, 1824);
+/* Fractional Generator 17 Clock Source */
+FIELD(RT500_CLKCTL1_FRG17CLKSEL, SEL, 0, 3);
+
+/* Fractional Rate Generator 17 Control */
+REG32(RT500_CLKCTL1_FRG17CTL, 1828);
+/*
+ * Denominator of the fractional divider: DIV is equal to the programmed value
+ * +1
+ */
+FIELD(RT500_CLKCTL1_FRG17CTL, DIV, 0, 8);
+/*
+ * Numerator of the fractional divider: MULT is equal to the programmed value.
+ */
+FIELD(RT500_CLKCTL1_FRG17CTL, MULT, 8, 8);
+
+/* FlexIO Clock Select */
+REG32(RT500_CLKCTL1_FLEXIOCLKSEL, 1832);
+/* FlexIO Functional Clock Source */
+FIELD(RT500_CLKCTL1_FLEXIOCLKSEL, SEL, 0, 3);
+
+/* FlexIO Clock Divider */
+REG32(RT500_CLKCTL1_FLEXIOCLKDIV, 1856);
+/* FLEXIO Clock Divider Value */
+FIELD(RT500_CLKCTL1_FLEXIOCLKDIV, DIV, 0, 8);
+/* Reset the Divider Counter */
+FIELD(RT500_CLKCTL1_FLEXIOCLKDIV, RESET, 29, 1);
+/* Halt the Divider Counter */
+FIELD(RT500_CLKCTL1_FLEXIOCLKDIV, HALT, 30, 1);
+/* Divider Status Flag */
+FIELD(RT500_CLKCTL1_FLEXIOCLKDIV, REQFLAG, 31, 1);
+
+/* Fractional Rate Generator PLL Clock Divider */
+REG32(RT500_CLKCTL1_FRGPLLCLKDIV, 1888);
+/* FRG PLL Clock Divider Value */
+FIELD(RT500_CLKCTL1_FRGPLLCLKDIV, DIV, 0, 8);
+/* Reset the Divider Counter */
+FIELD(RT500_CLKCTL1_FRGPLLCLKDIV, RESET, 29, 1);
+/* Halt the Divider Counter */
+FIELD(RT500_CLKCTL1_FRGPLLCLKDIV, HALT, 30, 1);
+/* Divider Status Flag */
+FIELD(RT500_CLKCTL1_FRGPLLCLKDIV, REQFLAG, 31, 1);
+
+/* DMIC0 Functional Clock Select */
+REG32(RT500_CLKCTL1_DMIC0FCLKSEL, 1920);
+/* DMIC Functional Clock Source */
+FIELD(RT500_CLKCTL1_DMIC0FCLKSEL, SEL, 0, 3);
+
+/* DMIC0 Functional Clock Divider */
+REG32(RT500_CLKCTL1_DMIC0FCLKDIV, 1924);
+/* 32 KHz Wake Clock Divider Value */
+FIELD(RT500_CLKCTL1_DMIC0FCLKDIV, DIV, 0, 8);
+/* Reset the Divider Counter */
+FIELD(RT500_CLKCTL1_DMIC0FCLKDIV, RESET, 29, 1);
+/* Halt the Divider Counter */
+FIELD(RT500_CLKCTL1_DMIC0FCLKDIV, HALT, 30, 1);
+/* Divider Status Flag */
+FIELD(RT500_CLKCTL1_DMIC0FCLKDIV, REQFLAG, 31, 1);
+
+/* CT32BIT bit timer index Functional Clock Select */
+REG32(RT500_CLKCTL1_CT32BITFCLKSEL0, 1952);
+REG32(RT500_CLKCTL1_CT32BITFCLKSEL1, 1956);
+REG32(RT500_CLKCTL1_CT32BITFCLKSEL2, 1960);
+REG32(RT500_CLKCTL1_CT32BITFCLKSEL3, 1964);
+REG32(RT500_CLKCTL1_CT32BITFCLKSEL4, 1968);
+/* CT32BIT bit timer 0 Functional Clock Source */
+SHARED_FIELD(RT500_CLKCTL1_CT32BITFCLKSEL_SEL, 0, 3);
+
+/* Audio MCLK Clock Select */
+REG32(RT500_CLKCTL1_AUDIOMCLKSEL, 1984);
+/* Audio MCLK Clock Source Select */
+FIELD(RT500_CLKCTL1_AUDIOMCLKSEL, SEL, 0, 3);
+
+/* Audio MCLK Clock Divider */
+REG32(RT500_CLKCTL1_AUDIOMCLKDIV, 1988);
+/* Audio MCLK Clock Divider Value */
+FIELD(RT500_CLKCTL1_AUDIOMCLKDIV, DIV, 0, 8);
+/* Reset the Divider Counter */
+FIELD(RT500_CLKCTL1_AUDIOMCLKDIV, RESET, 29, 1);
+/* Halt the Divider Counter */
+FIELD(RT500_CLKCTL1_AUDIOMCLKDIV, HALT, 30, 1);
+/* Divider Status Flag */
+FIELD(RT500_CLKCTL1_AUDIOMCLKDIV, REQFLAG, 31, 1);
+
+/* CLKOUT Clock Select 0 */
+REG32(RT500_CLKCTL1_CLKOUTSEL0, 2016);
+/* Clock Output Select 1st Stage */
+FIELD(RT500_CLKCTL1_CLKOUTSEL0, SEL, 0, 3);
+
+/* CLKOUT Clock Select 1 */
+REG32(RT500_CLKCTL1_CLKOUTSEL1, 2020);
+/* Clock Out Source */
+FIELD(RT500_CLKCTL1_CLKOUTSEL1, SEL, 0, 3);
+
+/* CLKOUT Functional Clock Divider */
+REG32(RT500_CLKCTL1_CLKOUTFCLKDIV, 2024);
+/* Clock-Out Clock Divider Value */
+FIELD(RT500_CLKCTL1_CLKOUTFCLKDIV, DIV, 0, 8);
+/* Reset the Divider Counter */
+FIELD(RT500_CLKCTL1_CLKOUTFCLKDIV, RESET, 29, 1);
+/* Halt the Divider Counter */
+FIELD(RT500_CLKCTL1_CLKOUTFCLKDIV, HALT, 30, 1);
+/* Divider Status Flag */
+FIELD(RT500_CLKCTL1_CLKOUTFCLKDIV, REQFLAG, 31, 1);
+
+/* I3C0, I3C1 Functional Clock Select */
+REG32(RT500_CLKCTL1_I3C01FCLKSEL, 2048);
+/* I3C0, I3C1 Clock Source */
+FIELD(RT500_CLKCTL1_I3C01FCLKSEL, SEL, 0, 3);
+
+/* I3C0, I3C1 Functional Slow Time Control Clock Select */
+REG32(RT500_CLKCTL1_I3C01FCLKSTCSEL, 2052);
+/* I3C0, I3C1 Clock Source */
+FIELD(RT500_CLKCTL1_I3C01FCLKSTCSEL, SEL, 0, 3);
+
+/* I3C0, I3C1 Functional Slow Time Control Clock Divider */
+REG32(RT500_CLKCTL1_I3C01FCLKSTCDIV, 2056);
+/* I3C0, I3C1 Clock Divider Value */
+FIELD(RT500_CLKCTL1_I3C01FCLKSTCDIV, DIV, 0, 8);
+/* Reset the Divider Counter */
+FIELD(RT500_CLKCTL1_I3C01FCLKSTCDIV, RESET, 29, 1);
+/* Halt the Divider Counter */
+FIELD(RT500_CLKCTL1_I3C01FCLKSTCDIV, HALT, 30, 1);
+/* Divider Status Flag */
+FIELD(RT500_CLKCTL1_I3C01FCLKSTCDIV, REQFLAG, 31, 1);
+
+/* I3C0, I3C1 Functional Slow Clock Divider */
+REG32(RT500_CLKCTL1_I3C01FCLKSDIV, 2060);
+/* I3C0, I3C1 Clock Divider Value */
+FIELD(RT500_CLKCTL1_I3C01FCLKSDIV, DIV, 0, 8);
+/* Reset the Divider Counter */
+FIELD(RT500_CLKCTL1_I3C01FCLKSDIV, RESET, 29, 1);
+/* Halt the Divider Counter */
+FIELD(RT500_CLKCTL1_I3C01FCLKSDIV, HALT, 30, 1);
+/* Divider Status Flag */
+FIELD(RT500_CLKCTL1_I3C01FCLKSDIV, REQFLAG, 31, 1);
+
+/* I3C0, I3C1 Functional Clock Divider */
+REG32(RT500_CLKCTL1_I3C01FCLKDIV, 2064);
+/* I3C0, I3C1 Clock Divider Value */
+FIELD(RT500_CLKCTL1_I3C01FCLKDIV, DIV, 0, 8);
+/* Reset the Divider Counter */
+FIELD(RT500_CLKCTL1_I3C01FCLKDIV, RESET, 29, 1);
+/* Halts the Divider Counter */
+FIELD(RT500_CLKCTL1_I3C01FCLKDIV, HALT, 30, 1);
+/* Divider Status Flag */
+FIELD(RT500_CLKCTL1_I3C01FCLKDIV, REQFLAG, 31, 1);
+
+/* I3C01 Functional Clock Select */
+REG32(RT500_CLKCTL1_I3C01FCLKSTSTCLKSEL, 2068);
+/* I3C0, I3C1 FCLK Test Clock Source */
+FIELD(RT500_CLKCTL1_I3C01FCLKSTSTCLKSEL, SEL, 0, 3);
+
+/* Watchdog Timer 1 Functional Clock Select */
+REG32(RT500_CLKCTL1_WDT1FCLKSEL, 2080);
+/* WDT1 Functional Clock Source */
+FIELD(RT500_CLKCTL1_WDT1FCLKSEL, SEL, 0, 3);
+
+/* Analog Comparator 0 Clock Select */
+REG32(RT500_CLKCTL1_ACMP0FCLKSEL, 2096);
+/* ACMP0 Fast Functional Clock Source */
+FIELD(RT500_CLKCTL1_ACMP0FCLKSEL, SEL, 0, 3);
+
+/* Analog comparator 0 FCLK divider */
+REG32(RT500_CLKCTL1_ACMP0FCLKDIV, 2100);
+/* Clock Out Clock Divider Value */
+FIELD(RT500_CLKCTL1_ACMP0FCLKDIV, DIV, 0, 8);
+/* Reset the Divider Counter */
+FIELD(RT500_CLKCTL1_ACMP0FCLKDIV, RESET, 29, 1);
+/* Halts the Divider Counter */
+FIELD(RT500_CLKCTL1_ACMP0FCLKDIV, HALT, 30, 1);
+/* Divider Status Flag */
+FIELD(RT500_CLKCTL1_ACMP0FCLKDIV, REQFLAG, 31, 1);
+
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL0_FC0_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL0_FC0_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_FC0_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL0_FC1_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL0_FC1_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_FC1_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL0_FC2_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL0_FC2_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_FC2_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL0_FC3_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL0_FC3_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_FC3_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL0_FC4_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL0_FC4_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_FC4_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL0_FC5_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL0_FC5_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_FC5_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL0_FC6_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL0_FC6_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_FC6_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL0_FC7_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL0_FC7_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_FC7_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL0_FC8_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL0_FC8_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_FC8_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL0_FC9_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL0_FC9_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_FC9_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL0_FC10_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL0_FC10_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_FC10_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL0_FC11_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL0_FC11_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_FC11_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL0_FC12_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL0_FC12_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_FC12_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL0_FC13_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL0_FC13_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_FC13_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL0_FC14_SPI_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL0_FC14_SPI_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_FC14_SPI_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL0_FC15_I2C_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL0_FC15_I2C_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_FC15_I2C_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL0_DMIC0_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL0_DMIC0_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_DMIC0_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL0_FC16_SPI_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL0_FC16_SPI_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_FC16_SPI_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL0_OSEVENT_TIMER_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL0_OSEVENT_TIMER_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_OSEVENT_TIMER_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL0_FlexIO_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL0_FlexIO_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_FlexIO_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL1_HSGPIO0_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL1_HSGPIO0_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL1_HSGPIO0_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL1_HSGPIO1_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL1_HSGPIO1_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL1_HSGPIO1_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL1_HSGPIO2_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL1_HSGPIO2_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL1_HSGPIO2_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL1_HSGPIO3_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL1_HSGPIO3_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL1_HSGPIO3_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL1_HSGPIO4_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL1_HSGPIO4_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL1_HSGPIO4_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL1_HSGPIO5_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL1_HSGPIO5_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL1_HSGPIO5_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL1_HSGPIO6_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL1_HSGPIO6_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL1_HSGPIO6_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL1_HSGPIO7_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL1_HSGPIO7_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL1_HSGPIO7_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL1_CRC_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL1_CRC_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL1_CRC_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL1_DMAC0_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL1_DMAC0_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL1_DMAC0_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL1_DMAC1_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL1_DMAC1_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL1_DMAC1_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL1_MU_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL1_MU_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL1_MU_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL1_SEMA_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL1_SEMA_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL1_SEMA_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL1_FREQME_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL1_FREQME_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL1_FREQME_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL2_CT32BIT0_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL2_CT32BIT0_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL2_CT32BIT0_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL2_CT32BIT1_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL2_CT32BIT1_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL2_CT32BIT1_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL2_CT32BIT2_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL2_CT32BIT2_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL2_CT32BIT2_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL2_CT32BIT3_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL2_CT32BIT3_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL2_CT32BIT3_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL2_CT32BIT4_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL2_CT32BIT4_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL2_CT32BIT4_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL2_RTCLITE_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL2_RTCLITE_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL2_RTCLITE_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL2_MRT0_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL2_MRT0_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL2_MRT0_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL2_WWDT1_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL2_WWDT1_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL2_WWDT1_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL2_I3C0_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL2_I3C0_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL2_I3C0_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL2_I3C1_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL2_I3C1_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL2_I3C1_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL2_GPIOINTCTL_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL2_GPIOINTCTL_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL2_GPIOINTCTL_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL2_PIMCTL_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL2_PIMCTL_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL2_PIMCTL_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL0_SET_FC0_CLK_DISABLE = 0,
+    /* Sets the PSCCTL0 bit */
+    RT500_CLKCTL1_PSCCTL0_SET_FC0_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_SET_FC0_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL0_SET_FC1_CLK_DISABLE = 0,
+    /* Sets the PSCCTL0 bit */
+    RT500_CLKCTL1_PSCCTL0_SET_FC1_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_SET_FC1_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL0_SET_FC2_CLK_DISABLE = 0,
+    /* Sets the PSCCTL0 bit */
+    RT500_CLKCTL1_PSCCTL0_SET_FC2_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_SET_FC2_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL0_SET_FC3_CLK_DISABLE = 0,
+    /* Sets the PSCCTL0 bit */
+    RT500_CLKCTL1_PSCCTL0_SET_FC3_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_SET_FC3_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL0_SET_FC4_CLK_DISABLE = 0,
+    /* Sets the PSCCTL0 bit */
+    RT500_CLKCTL1_PSCCTL0_SET_FC4_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_SET_FC4_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL0_SET_FC5_CLK_DISABLE = 0,
+    /* Sets the PSCCTL0 bit */
+    RT500_CLKCTL1_PSCCTL0_SET_FC5_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_SET_FC5_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL0_SET_FC6_CLK_DISABLE = 0,
+    /* Sets the PSCCTL0 bit */
+    RT500_CLKCTL1_PSCCTL0_SET_FC6_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_SET_FC6_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL0_SET_FC7_CLK_DISABLE = 0,
+    /* Sets the PSCCTL0 bit */
+    RT500_CLKCTL1_PSCCTL0_SET_FC7_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_SET_FC7_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL0_SET_FC8_CLK_DISABLE = 0,
+    /* Sets the PSCCTL0 bit */
+    RT500_CLKCTL1_PSCCTL0_SET_FC8_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_SET_FC8_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL0_SET_FC9_CLK_DISABLE = 0,
+    /* Sets the PSCCTL0 bit */
+    RT500_CLKCTL1_PSCCTL0_SET_FC9_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_SET_FC9_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL0_SET_FC10_CLK_DISABLE = 0,
+    /* Sets the PSCCTL0 bit */
+    RT500_CLKCTL1_PSCCTL0_SET_FC10_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_SET_FC10_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL0_SET_FC11_CLK_DISABLE = 0,
+    /* Sets the PSCCTL0 bit */
+    RT500_CLKCTL1_PSCCTL0_SET_FC11_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_SET_FC11_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL0_SET_FC12_CLK_DISABLE = 0,
+    /* Sets the PSCCTL0 bit */
+    RT500_CLKCTL1_PSCCTL0_SET_FC12_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_SET_FC12_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL0_SET_FC13_CLK_DISABLE = 0,
+    /* Sets the PSCCTL0 bit */
+    RT500_CLKCTL1_PSCCTL0_SET_FC13_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_SET_FC13_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL0_SET_FC14_SPI_CLK_DISABLE = 0,
+    /* Sets the PSCCTL0 bit */
+    RT500_CLKCTL1_PSCCTL0_SET_FC14_SPI_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_SET_FC14_SPI_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL0_SET_FC15_I2C_CLK_DISABLE = 0,
+    /* Sets the PSCCTL0 bit */
+    RT500_CLKCTL1_PSCCTL0_SET_FC15_I2C_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_SET_FC15_I2C_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL0_SET_DMIC0_DISABLE = 0,
+    /* Sets the PSCCTL0 bit */
+    RT500_CLKCTL1_PSCCTL0_SET_DMIC0_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_SET_DMIC0_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL0_SET_FC16_SPI_CLK_DISABLE = 0,
+    /* Sets the PSCCTL0 bit */
+    RT500_CLKCTL1_PSCCTL0_SET_FC16_SPI_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_SET_FC16_SPI_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL0_SET_OSEVENT_TIMER_DISABLE = 0,
+    /* Sets the PSCCTL0 bit */
+    RT500_CLKCTL1_PSCCTL0_SET_OSEVENT_TIMER_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_SET_OSEVENT_TIMER_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL0_SET_FlexIO_DISABLE = 0,
+    /* Sets the PSCCTL0 bit */
+    RT500_CLKCTL1_PSCCTL0_SET_FlexIO_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_SET_FlexIO_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL1_SET_HSGPIO0_CLK_DISABLE = 0,
+    /* Sets the PSCCTL1 bit */
+    RT500_CLKCTL1_PSCCTL1_SET_HSGPIO0_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL1_SET_HSGPIO0_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL1_SET_HSGPIO1_CLK_DISABLE = 0,
+    /* Sets the PSCCTL1 bit */
+    RT500_CLKCTL1_PSCCTL1_SET_HSGPIO1_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL1_SET_HSGPIO1_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL1_SET_HSGPIO2_CLK_DISABLE = 0,
+    /* Sets the PSCCTL1 bit */
+    RT500_CLKCTL1_PSCCTL1_SET_HSGPIO2_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL1_SET_HSGPIO2_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL1_SET_HSGPIO3_CLK_DISABLE = 0,
+    /* Sets the PSCCTL1 bit */
+    RT500_CLKCTL1_PSCCTL1_SET_HSGPIO3_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL1_SET_HSGPIO3_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL1_SET_HSGPIO4_CLK_DISABLE = 0,
+    /* Sets the PSCCTL1 bit */
+    RT500_CLKCTL1_PSCCTL1_SET_HSGPIO4_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL1_SET_HSGPIO4_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL1_SET_HSGPIO5_CLK_DISABLE = 0,
+    /* Sets the PSCCTL1 bit */
+    RT500_CLKCTL1_PSCCTL1_SET_HSGPIO5_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL1_SET_HSGPIO5_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL1_SET_HSGPIO6_CLK_DISABLE = 0,
+    /* Sets the PSCCTL1 bit */
+    RT500_CLKCTL1_PSCCTL1_SET_HSGPIO6_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL1_SET_HSGPIO6_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL1_SET_HSGPIO7_CLK_DISABLE = 0,
+    /* Sets the PSCCTL1 bit */
+    RT500_CLKCTL1_PSCCTL1_SET_HSGPIO7_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL1_SET_HSGPIO7_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL1_SET_CRC_CLK_DISABLE = 0,
+    /* Sets the PSCCTL1 bit */
+    RT500_CLKCTL1_PSCCTL1_SET_CRC_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL1_SET_CRC_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL1_SET_DMAC0_CLK_DISABLE = 0,
+    /* Sets the PSCCTL1 bit */
+    RT500_CLKCTL1_PSCCTL1_SET_DMAC0_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL1_SET_DMAC0_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL1_SET_DMAC1_CLK_DISABLE = 0,
+    /* Sets the PSCCTL1 bit */
+    RT500_CLKCTL1_PSCCTL1_SET_DMAC1_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL1_SET_DMAC1_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL1_SET_MU_CLK_DISABLE = 0,
+    /* Sets the PSCCTL1 bit */
+    RT500_CLKCTL1_PSCCTL1_SET_MU_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL1_SET_MU_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL1_SET_SEMA_CLK_DISABLE = 0,
+    /* Sets the PSCCTL1 bit */
+    RT500_CLKCTL1_PSCCTL1_SET_SEMA_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL1_SET_SEMA_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL1_SET_FREQME_CLK_DISABLE = 0,
+    /* Sets the PSCCTL1 bit */
+    RT500_CLKCTL1_PSCCTL1_SET_FREQME_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL1_SET_FREQME_CLK_Enum;
+
+typedef enum {
+    /* No Effect */
+    RT500_CLKCTL1_PSCCTL2_SET_CT32BIT0_CLK_NO_EFFECT = 0,
+    /* Set Bit */
+    RT500_CLKCTL1_PSCCTL2_SET_CT32BIT0_CLK_SET_BIT = 1,
+} RT500_CLKCTL1_PSCCTL2_SET_CT32BIT0_CLK_Enum;
+
+typedef enum {
+    /* No Effect */
+    RT500_CLKCTL1_PSCCTL2_SET_CT32BIT1_CLK_NO_EFFECT = 0,
+    /* Set Bit */
+    RT500_CLKCTL1_PSCCTL2_SET_CT32BIT1_CLK_SET_BIT = 1,
+} RT500_CLKCTL1_PSCCTL2_SET_CT32BIT1_CLK_Enum;
+
+typedef enum {
+    /* No Effect */
+    RT500_CLKCTL1_PSCCTL2_SET_CT32BIT2_CLK_NO_EFFECT = 0,
+    /* Set Bit */
+    RT500_CLKCTL1_PSCCTL2_SET_CT32BIT2_CLK_SET_BIT = 1,
+} RT500_CLKCTL1_PSCCTL2_SET_CT32BIT2_CLK_Enum;
+
+typedef enum {
+    /* No Effect */
+    RT500_CLKCTL1_PSCCTL2_SET_CT32BIT3_CLK_NO_EFFECT = 0,
+    /* Set Bit */
+    RT500_CLKCTL1_PSCCTL2_SET_CT32BIT3_CLK_SET_BIT = 1,
+} RT500_CLKCTL1_PSCCTL2_SET_CT32BIT3_CLK_Enum;
+
+typedef enum {
+    /* No Effect */
+    RT500_CLKCTL1_PSCCTL2_SET_CT32BIT4_CLK_NO_EFFECT = 0,
+    /* Set Bit */
+    RT500_CLKCTL1_PSCCTL2_SET_CT32BIT4_CLK_SET_BIT = 1,
+} RT500_CLKCTL1_PSCCTL2_SET_CT32BIT4_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL2_SET_RTCLITE_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL2_SET_RTCLITE_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL2_SET_RTCLITE_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL2_SET_MRT0_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL2_SET_MRT0_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL2_SET_MRT0_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL2_SET_WWDT1_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL2_SET_WWDT1_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL2_SET_WWDT1_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL2_SET_I3C0_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL2_SET_I3C0_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL2_SET_I3C0_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL2_SET_I3C1_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL2_SET_I3C1_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL2_SET_I3C1_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL2_SET_GPIOINTCTL_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL2_SET_GPIOINTCTL_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL2_SET_GPIOINTCTL_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL2_SET_PIMCTL_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL2_SET_PIMCTL_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL2_SET_PIMCTL_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL0_CLR_FC0_CLK_DISABLE = 0,
+    /* Clears the PSCCTL0 bit */
+    RT500_CLKCTL1_PSCCTL0_CLR_FC0_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_CLR_FC0_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL0_CLR_FC1_CLK_DISABLE = 0,
+    /* Clears the PSCCTL0 bit */
+    RT500_CLKCTL1_PSCCTL0_CLR_FC1_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_CLR_FC1_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL0_CLR_FC2_CLK_DISABLE = 0,
+    /* Clears the PSCCTL0 bit */
+    RT500_CLKCTL1_PSCCTL0_CLR_FC2_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_CLR_FC2_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL0_CLR_FC3_CLK_DISABLE = 0,
+    /* Clears the PSCCTL0 bit */
+    RT500_CLKCTL1_PSCCTL0_CLR_FC3_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_CLR_FC3_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL0_CLR_FC4_CLK_DISABLE = 0,
+    /* Clears the PSCCTL0 bit */
+    RT500_CLKCTL1_PSCCTL0_CLR_FC4_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_CLR_FC4_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL0_CLR_FC5_CLK_DISABLE = 0,
+    /* Clears the PSCCTL0 bit */
+    RT500_CLKCTL1_PSCCTL0_CLR_FC5_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_CLR_FC5_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL0_CLR_FC6_CLK_DISABLE = 0,
+    /* Clears the PSCCTL0 bit */
+    RT500_CLKCTL1_PSCCTL0_CLR_FC6_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_CLR_FC6_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL0_CLR_FC7_CLK_DISABLE = 0,
+    /* Clears the PSCCTL0 bit */
+    RT500_CLKCTL1_PSCCTL0_CLR_FC7_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_CLR_FC7_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL0_CLR_FC8_CLK_DISABLE = 0,
+    /* Clears the PSCCTL0 bit */
+    RT500_CLKCTL1_PSCCTL0_CLR_FC8_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_CLR_FC8_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL0_CLR_FC9_CLK_DISABLE = 0,
+    /* Clears the PSCCTL0 bit */
+    RT500_CLKCTL1_PSCCTL0_CLR_FC9_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_CLR_FC9_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL0_CLR_FC10_CLK_DISABLE = 0,
+    /* Clears the PSCCTL0 bit */
+    RT500_CLKCTL1_PSCCTL0_CLR_FC10_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_CLR_FC10_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL0_CLR_FC11_CLK_DISABLE = 0,
+    /* Clears the PSCCTL0 bit */
+    RT500_CLKCTL1_PSCCTL0_CLR_FC11_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_CLR_FC11_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL0_CLR_FC12_CLK_DISABLE = 0,
+    /* Clears the PSCCTL0 bit */
+    RT500_CLKCTL1_PSCCTL0_CLR_FC12_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_CLR_FC12_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL0_CLR_FC13_CLK_DISABLE = 0,
+    /* Clears the PSCCTL0 bit */
+    RT500_CLKCTL1_PSCCTL0_CLR_FC13_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_CLR_FC13_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL0_CLR_FC14_SPI_CLK_DISABLE = 0,
+    /* Clears the PSCCTL0 bit */
+    RT500_CLKCTL1_PSCCTL0_CLR_FC14_SPI_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_CLR_FC14_SPI_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL0_CLR_FC15_I2C_CLK_DISABLE = 0,
+    /* Clears the PSCCTL0 bit */
+    RT500_CLKCTL1_PSCCTL0_CLR_FC15_I2C_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_CLR_FC15_I2C_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL0_CLR_DMIC0_DISABLE = 0,
+    /* Clears the PSCCTL0 bit */
+    RT500_CLKCTL1_PSCCTL0_CLR_DMIC0_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_CLR_DMIC0_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL0_CLR_FC16_SPI_CLK_DISABLE = 0,
+    /* Clears the PSCCTL0 bit */
+    RT500_CLKCTL1_PSCCTL0_CLR_FC16_SPI_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_CLR_FC16_SPI_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL0_CLR_OSEVENT_TIMER_DISABLE = 0,
+    /* Clears the PSCCTL0 bit */
+    RT500_CLKCTL1_PSCCTL0_CLR_OSEVENT_TIMER_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_CLR_OSEVENT_TIMER_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL0_CLR_FlexIO_DISABLE = 0,
+    /* Clears the PSCCTL0 bit */
+    RT500_CLKCTL1_PSCCTL0_CLR_FlexIO_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL0_CLR_FlexIO_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL1_CLR_HSGPIO0_CLK_DISABLE = 0,
+    /* Clears the PSCCTL1 bit */
+    RT500_CLKCTL1_PSCCTL1_CLR_HSGPIO0_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL1_CLR_HSGPIO0_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL1_CLR_HSGPIO1_CLK_DISABLE = 0,
+    /* Clears the PSCCTL1 bit */
+    RT500_CLKCTL1_PSCCTL1_CLR_HSGPIO1_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL1_CLR_HSGPIO1_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL1_CLR_HSGPIO2_CLK_DISABLE = 0,
+    /* Clears the PSCCTL1 bit */
+    RT500_CLKCTL1_PSCCTL1_CLR_HSGPIO2_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL1_CLR_HSGPIO2_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL1_CLR_HSGPIO3_CLK_DISABLE = 0,
+    /* Clears the PSCCTL1 bit */
+    RT500_CLKCTL1_PSCCTL1_CLR_HSGPIO3_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL1_CLR_HSGPIO3_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL1_CLR_HSGPIO4_CLK_DISABLE = 0,
+    /* Clears the PSCCTL1 bit */
+    RT500_CLKCTL1_PSCCTL1_CLR_HSGPIO4_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL1_CLR_HSGPIO4_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL1_CLR_HSGPIO5_CLK_DISABLE = 0,
+    /* Clears the PSCCTL1 bit */
+    RT500_CLKCTL1_PSCCTL1_CLR_HSGPIO5_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL1_CLR_HSGPIO5_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL1_CLR_HSGPIO6_CLK_DISABLE = 0,
+    /* Clears the PSCCTL1 bit */
+    RT500_CLKCTL1_PSCCTL1_CLR_HSGPIO6_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL1_CLR_HSGPIO6_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL1_CLR_HSGPIO7_CLK_DISABLE = 0,
+    /* Clears the PSCCTL1 bit */
+    RT500_CLKCTL1_PSCCTL1_CLR_HSGPIO7_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL1_CLR_HSGPIO7_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL1_CLR_CRC_CLK_DISABLE = 0,
+    /* Clears the PSCCTL1 bit */
+    RT500_CLKCTL1_PSCCTL1_CLR_CRC_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL1_CLR_CRC_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL1_CLR_DMAC0_CLK_DISABLE = 0,
+    /* Clears the PSCCTL1 bit */
+    RT500_CLKCTL1_PSCCTL1_CLR_DMAC0_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL1_CLR_DMAC0_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL1_CLR_DMAC1_CLK_DISABLE = 0,
+    /* Clears the PSCCTL1 bit */
+    RT500_CLKCTL1_PSCCTL1_CLR_DMAC1_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL1_CLR_DMAC1_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL1_CLR_MU_CLK_DISABLE = 0,
+    /* Clears the PSCCTL1 bit */
+    RT500_CLKCTL1_PSCCTL1_CLR_MU_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL1_CLR_MU_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL1_CLR_SEMA_CLK_DISABLE = 0,
+    /* Clears the PSCCTL1 bit */
+    RT500_CLKCTL1_PSCCTL1_CLR_SEMA_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL1_CLR_SEMA_CLK_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_PSCCTL1_CLR_FREQME_CLK_DISABLE = 0,
+    /* Clears the PSCCTL1 bit */
+    RT500_CLKCTL1_PSCCTL1_CLR_FREQME_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL1_CLR_FREQME_CLK_Enum;
+
+typedef enum {
+    /* No Effect */
+    RT500_CLKCTL1_PSCCTL2_CLR_CT32BIT0_CLK_NO_EFFECT = 0,
+    /* Set Bit */
+    RT500_CLKCTL1_PSCCTL2_CLR_CT32BIT0_CLK_SET_BIT = 1,
+} RT500_CLKCTL1_PSCCTL2_CLR_CT32BIT0_CLK_Enum;
+
+typedef enum {
+    /* No Effect */
+    RT500_CLKCTL1_PSCCTL2_CLR_CT32BIT1_CLK_NO_EFFECT = 0,
+    /* Set Bit */
+    RT500_CLKCTL1_PSCCTL2_CLR_CT32BIT1_CLK_SET_BIT = 1,
+} RT500_CLKCTL1_PSCCTL2_CLR_CT32BIT1_CLK_Enum;
+
+typedef enum {
+    /* No Effect */
+    RT500_CLKCTL1_PSCCTL2_CLR_CT32BIT2_CLK_NO_EFFECT = 0,
+    /* Set Bit */
+    RT500_CLKCTL1_PSCCTL2_CLR_CT32BIT2_CLK_SET_BIT = 1,
+} RT500_CLKCTL1_PSCCTL2_CLR_CT32BIT2_CLK_Enum;
+
+typedef enum {
+    /* No Effect */
+    RT500_CLKCTL1_PSCCTL2_CLR_CT32BIT3_CLK_NO_EFFECT = 0,
+    /* Set Bit */
+    RT500_CLKCTL1_PSCCTL2_CLR_CT32BIT3_CLK_SET_BIT = 1,
+} RT500_CLKCTL1_PSCCTL2_CLR_CT32BIT3_CLK_Enum;
+
+typedef enum {
+    /* No Effect */
+    RT500_CLKCTL1_PSCCTL2_CLR_CT32BIT4_CLK_NO_EFFECT = 0,
+    /* Set Bit */
+    RT500_CLKCTL1_PSCCTL2_CLR_CT32BIT4_CLK_SET_BIT = 1,
+} RT500_CLKCTL1_PSCCTL2_CLR_CT32BIT4_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL2_CLR_RTCLITE_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL2_CLR_RTCLITE_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL2_CLR_RTCLITE_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL2_CLR_MRT0_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL2_CLR_MRT0_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL2_CLR_MRT0_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL2_CLR_WWDT1_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL2_CLR_WWDT1_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL2_CLR_WWDT1_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL2_CLR_I3C0_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL2_CLR_I3C0_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL2_CLR_I3C0_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL2_CLR_I3C1_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL2_CLR_I3C1_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL2_CLR_I3C1_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL2_CLR_GPIOINTCTL_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL2_CLR_GPIOINTCTL_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL2_CLR_GPIOINTCTL_CLK_Enum;
+
+typedef enum {
+    /* Disable Clock */
+    RT500_CLKCTL1_PSCCTL2_CLR_PIMCTL_CLK_DISABLE = 0,
+    /* Enable Clock */
+    RT500_CLKCTL1_PSCCTL2_CLR_PIMCTL_CLK_ENABLE = 1,
+} RT500_CLKCTL1_PSCCTL2_CLR_PIMCTL_CLK_Enum;
+
+typedef enum {
+    /* FRO_DIV8 */
+    RT500_CLKCTL1_AUDIOPLL0CLKSEL_SEL_FRRO_DIV8 = 0,
+    /* OSC_CLK clock (User-Selectable) */
+    RT500_CLKCTL1_AUDIOPLL0CLKSEL_SEL_OSC_CLK = 1,
+    /* None, output gated to reduce power */
+    RT500_CLKCTL1_AUDIOPLL0CLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL1_AUDIOPLL0CLKSEL_SEL_Enum;
+
+typedef enum {
+    /* PFD outputs are PFD-programmed clocks */
+    RT500_CLKCTL1_AUDIOPLL0CTL0_BYPASS_PFD = 0,
+    /*
+     * Bypass Mode. PFD outputs are sourced directly from the reference input
+     * clock
+     */
+    RT500_CLKCTL1_AUDIOPLL0CTL0_BYPASS_BYPASS = 1,
+} RT500_CLKCTL1_AUDIOPLL0CTL0_BYPASS_Enum;
+
+typedef enum {
+    /* AUDIOPLL0 reset is removed */
+    RT500_CLKCTL1_AUDIOPLL0CTL0_RESET_NO_RESET = 0,
+    /* AUDIOPLL0 is placed into reset */
+    RT500_CLKCTL1_AUDIOPLL0CTL0_RESET_RESET = 1,
+} RT500_CLKCTL1_AUDIOPLL0CTL0_RESET_Enum;
+
+typedef enum {
+    /* Disable */
+    RT500_CLKCTL1_AUDIOPLL0CTL0_HOLDRINGOFF_ENA_DISABLE = 0,
+    /* Enable */
+    RT500_CLKCTL1_AUDIOPLL0CTL0_HOLDRINGOFF_ENA_ENABLE = 1,
+} RT500_CLKCTL1_AUDIOPLL0CTL0_HOLDRINGOFF_ENA_Enum;
+
+typedef enum {
+    /* Multiply by 16 */
+    RT500_CLKCTL1_AUDIOPLL0CTL0_MULT_DIV16 = 16,
+    /* Multiply by 17 */
+    RT500_CLKCTL1_AUDIOPLL0CTL0_MULT_DIV17 = 17,
+    /* Multiply by 18 */
+    RT500_CLKCTL1_AUDIOPLL0CTL0_MULT_DIV18 = 18,
+    /* Multiply by 19 */
+    RT500_CLKCTL1_AUDIOPLL0CTL0_MULT_DIV19 = 19,
+    /* Multiply by 20 */
+    RT500_CLKCTL1_AUDIOPLL0CTL0_MULT_DIV20 = 20,
+    /* Multiply by 21 */
+    RT500_CLKCTL1_AUDIOPLL0CTL0_MULT_DIV21 = 21,
+    /* Multiply by 22 */
+    RT500_CLKCTL1_AUDIOPLL0CTL0_MULT_DIV22 = 22,
+} RT500_CLKCTL1_AUDIOPLL0CTL0_MULT_Enum;
+
+typedef enum {
+    /* Not ready */
+    RT500_CLKCTL1_AUDIOPLL0PFD_PFD0_CLKRDY_NOT_READY = 0,
+    /* Ready */
+    RT500_CLKCTL1_AUDIOPLL0PFD_PFD0_CLKRDY_READY = 1,
+} RT500_CLKCTL1_AUDIOPLL0PFD_PFD0_CLKRDY_Enum;
+
+typedef enum {
+    /* PFD0 clock is not gated */
+    RT500_CLKCTL1_AUDIOPLL0PFD_PFD0_CLKGATE_NOT_GATED = 0,
+    /* PFD0 clock is gated */
+    RT500_CLKCTL1_AUDIOPLL0PFD_PFD0_CLKGATE_GATED = 1,
+} RT500_CLKCTL1_AUDIOPLL0PFD_PFD0_CLKGATE_Enum;
+
+typedef enum {
+    /* Not ready */
+    RT500_CLKCTL1_AUDIOPLL0PFD_PFD1_CLKRDY_NOT_READY = 0,
+    /* Ready */
+    RT500_CLKCTL1_AUDIOPLL0PFD_PFD1_CLKRDY_READY = 1,
+} RT500_CLKCTL1_AUDIOPLL0PFD_PFD1_CLKRDY_Enum;
+
+typedef enum {
+    /* PFD1 clock is not gated */
+    RT500_CLKCTL1_AUDIOPLL0PFD_PFD1_CLKGATE_NOT_GATED = 0,
+    /* PFD1 clock is gated */
+    RT500_CLKCTL1_AUDIOPLL0PFD_PFD1_CLKGATE_GATED = 1,
+} RT500_CLKCTL1_AUDIOPLL0PFD_PFD1_CLKGATE_Enum;
+
+typedef enum {
+    /* Not ready */
+    RT500_CLKCTL1_AUDIOPLL0PFD_PFD2_CLKRDY_NOT_READY = 0,
+    /* Ready */
+    RT500_CLKCTL1_AUDIOPLL0PFD_PFD2_CLKRDY_READY = 1,
+} RT500_CLKCTL1_AUDIOPLL0PFD_PFD2_CLKRDY_Enum;
+
+typedef enum {
+    /* PFD2 clock is not gated */
+    RT500_CLKCTL1_AUDIOPLL0PFD_PFD2_CLKGATE_NOT_GATED = 0,
+    /* PFD2 clock is gated */
+    RT500_CLKCTL1_AUDIOPLL0PFD_PFD2_CLKGATE_GATED = 1,
+} RT500_CLKCTL1_AUDIOPLL0PFD_PFD2_CLKGATE_Enum;
+
+typedef enum {
+    /* Not ready */
+    RT500_CLKCTL1_AUDIOPLL0PFD_PFD3_CLKRDY_NOT_READY = 0,
+    /* Ready */
+    RT500_CLKCTL1_AUDIOPLL0PFD_PFD3_CLKRDY_READY = 1,
+} RT500_CLKCTL1_AUDIOPLL0PFD_PFD3_CLKRDY_Enum;
+
+typedef enum {
+    /* PFD3 clock is not gated */
+    RT500_CLKCTL1_AUDIOPLL0PFD_PFD3_CLKGATE_NOT_GATED = 0,
+    /* PFD3 clock is gated */
+    RT500_CLKCTL1_AUDIOPLL0PFD_PFD3_CLKGATE_GATED = 1,
+} RT500_CLKCTL1_AUDIOPLL0PFD_PFD3_CLKGATE_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_AUDIOPLLCLKDIV_RESET_DIVIDER_COUNTER_NOT_RESET = 0,
+    /* Reset the Divider Counter */
+    RT500_CLKCTL1_AUDIOPLLCLKDIV_RESET_DIVIDER_COUNTER_RESET = 1,
+} RT500_CLKCTL1_AUDIOPLLCLKDIV_RESET_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_AUDIOPLLCLKDIV_HALT_DIVIDER_COUNTER_NOT_HALT = 0,
+    /* Halt (stop) the Divider Counter */
+    RT500_CLKCTL1_AUDIOPLLCLKDIV_HALT_DIVIDER_COUNTER_HALT = 1,
+} RT500_CLKCTL1_AUDIOPLLCLKDIV_HALT_Enum;
+
+typedef enum {
+    /* The Divider change has finished */
+    RT500_CLKCTL1_AUDIOPLLCLKDIV_REQFLAG_REQFLAG_CHANGE_FINISHED = 0,
+    /* The Divider value has changed */
+    RT500_CLKCTL1_AUDIOPLLCLKDIV_REQFLAG_REQFLAG_CHANGED = 1,
+} RT500_CLKCTL1_AUDIOPLLCLKDIV_REQFLAG_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_DSPCPUCLKDIV_RESET_DIVIDER_COUNTER_NOT_RESET = 0,
+    /* Reset the Divider Counter */
+    RT500_CLKCTL1_DSPCPUCLKDIV_RESET_DIVIDER_COUNTER_RESET = 1,
+} RT500_CLKCTL1_DSPCPUCLKDIV_RESET_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_DSPCPUCLKDIV_HALT_DIVIDER_COUNTER_NOT_HALT = 0,
+    /* Halt (stop) the Divider Counter */
+    RT500_CLKCTL1_DSPCPUCLKDIV_HALT_DIVIDER_COUNTER_HALT = 1,
+} RT500_CLKCTL1_DSPCPUCLKDIV_HALT_Enum;
+
+typedef enum {
+    /*
+     * The Divider change has finished (clock being divided must be running for
+     * this status to change).
+     */
+    RT500_CLKCTL1_DSPCPUCLKDIV_REQFLAG_REQFLAG_CHANGE_FINISHED = 0,
+    /* The Divider value has changed. */
+    RT500_CLKCTL1_DSPCPUCLKDIV_REQFLAG_REQFLAG_CHANGED = 1,
+} RT500_CLKCTL1_DSPCPUCLKDIV_REQFLAG_Enum;
+
+typedef enum {
+    /* FRO_DIV1 Clock */
+    RT500_CLKCTL1_DSPCPUCLKSELA_SEL_FRO = 0,
+    /* OSC_CLK Clock */
+    RT500_CLKCTL1_DSPCPUCLKSELA_SEL_OSC_CLK = 1,
+    /* Low Power Oscillator Clock (LPOSC) */
+    RT500_CLKCTL1_DSPCPUCLKSELA_SEL_LPOSC = 2,
+} RT500_CLKCTL1_DSPCPUCLKSELA_SEL_Enum;
+
+typedef enum {
+    /* MAINCLKSELA 1st Stage Clock */
+    RT500_CLKCTL1_DSPCPUCLKSELB_SEL_MAINCLKSELA = 0,
+    /* Main System PLL Clock */
+    RT500_CLKCTL1_DSPCPUCLKSELB_SEL_MAIN_PLL = 1,
+    /* DSP System PLL Clock */
+    RT500_CLKCTL1_DSPCPUCLKSELB_SEL_DSP_PLL = 2,
+    /* RTC 32 KHz Clock */
+    RT500_CLKCTL1_DSPCPUCLKSELB_SEL_RTC_32KHZ = 3,
+} RT500_CLKCTL1_DSPCPUCLKSELB_SEL_Enum;
+
+typedef enum {
+    /* Low Power Oscillator Clock (LPOSC) */
+    RT500_CLKCTL1_OSEVENTTFCLKSEL_SEL_LPOSC = 0,
+    /* RTC 32 KHz Clock */
+    RT500_CLKCTL1_OSEVENTTFCLKSEL_SEL_RTC_32KHZ = 1,
+    /* HCLK Free-Running Clock (Global Time Stamping) */
+    RT500_CLKCTL1_OSEVENTTFCLKSEL_SEL_TEAL = 2,
+    /* None, output gated to reduce power */
+    RT500_CLKCTL1_OSEVENTTFCLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL1_OSEVENTTFCLKSEL_SEL_Enum;
+
+typedef enum {
+    /* Main Clock */
+    RT500_CLKCTL1_FRG0CLKSEL_SEL_MAIN = 0,
+    /* FRG PLL Clock */
+    RT500_CLKCTL1_FRG0CLKSEL_SEL_FRG_PLL = 1,
+    /* FRO_DIV4 clock */
+    RT500_CLKCTL1_FRG0CLKSEL_SEL_FRRO_DIV4 = 2,
+    /* None, output gated to reduce power */
+    RT500_CLKCTL1_FRG0CLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL1_FRG0CLKSEL_SEL_Enum;
+
+typedef enum {
+    /* FRO_DIV4 clock */
+    RT500_CLKCTL1_FC0FCLKSEL_SEL_FRRO_DIV4 = 0,
+    /* Audio PLL Clock */
+    RT500_CLKCTL1_FC0FCLKSEL_SEL_MASTER_CLOCK = 1,
+    /* None, output gated to reduce power */
+    RT500_CLKCTL1_FC0FCLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL1_FC0FCLKSEL_SEL_Enum;
+
+typedef enum {
+    /* Main Clock */
+    RT500_CLKCTL1_FRG1CLKSEL_SEL_MAIN = 0,
+    /* FRG PLL Clock */
+    RT500_CLKCTL1_FRG1CLKSEL_SEL_FRG_PLL = 1,
+    /* FRO_DIV4 clock */
+    RT500_CLKCTL1_FRG1CLKSEL_SEL_FRRO_DIV4 = 2,
+    /* None, output gated to reduce power */
+    RT500_CLKCTL1_FRG1CLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL1_FRG1CLKSEL_SEL_Enum;
+
+typedef enum {
+    /* FRO_DIV4 clock */
+    RT500_CLKCTL1_FC1FCLKSEL_SEL_FRRO_DIV4 = 0,
+    /* Audio PLL Clock */
+    RT500_CLKCTL1_FC1FCLKSEL_SEL_MASTER_CLOCK = 1,
+    /* None, output gated to reduce power */
+    RT500_CLKCTL1_FC1FCLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL1_FC1FCLKSEL_SEL_Enum;
+
+typedef enum {
+    /* Main Clock */
+    RT500_CLKCTL1_FRG2CLKSEL_SEL_MAIN = 0,
+    /* FRG PLL Clock */
+    RT500_CLKCTL1_FRG2CLKSEL_SEL_FRG_PLL = 1,
+    /* FRO_DIV4 clock */
+    RT500_CLKCTL1_FRG2CLKSEL_SEL_FRRO_DIV4 = 2,
+    /* None, output gated to reduce power */
+    RT500_CLKCTL1_FRG2CLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL1_FRG2CLKSEL_SEL_Enum;
+
+typedef enum {
+    /* FRO_DIV4 clock */
+    RT500_CLKCTL1_FC2FCLKSEL_SEL_FRRO_DIV4 = 0,
+    /* Audio PLL Clock */
+    RT500_CLKCTL1_FC2FCLKSEL_SEL_MASTER_CLOCK = 1,
+    /* None, output gated to reduce power */
+    RT500_CLKCTL1_FC2FCLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL1_FC2FCLKSEL_SEL_Enum;
+
+typedef enum {
+    /* Main Clock */
+    RT500_CLKCTL1_FRG3CLKSEL_SEL_MAIN = 0,
+    /* FRG PLL Clock */
+    RT500_CLKCTL1_FRG3CLKSEL_SEL_FRG_PLL = 1,
+    /* FRO_DIV4 clock */
+    RT500_CLKCTL1_FRG3CLKSEL_SEL_FRRO_DIV4 = 2,
+    /* None, output gated to reduce power */
+    RT500_CLKCTL1_FRG3CLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL1_FRG3CLKSEL_SEL_Enum;
+
+typedef enum {
+    /* FRO_DIV4 clock */
+    RT500_CLKCTL1_FC3FCLKSEL_SEL_FRRO_DIV4 = 0,
+    /* Audio PLL Clock */
+    RT500_CLKCTL1_FC3FCLKSEL_SEL_MASTER_CLOCK = 1,
+    /* None, output gated to reduce power */
+    RT500_CLKCTL1_FC3FCLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL1_FC3FCLKSEL_SEL_Enum;
+
+typedef enum {
+    /* Main Clock */
+    RT500_CLKCTL1_FRG4CLKSEL_SEL_MAIN = 0,
+    /* FRG PLL Clock */
+    RT500_CLKCTL1_FRG4CLKSEL_SEL_FRG_PLL = 1,
+    /* FRO_DIV4 clock */
+    RT500_CLKCTL1_FRG4CLKSEL_SEL_FRRO_DIV4 = 2,
+    /* None, output gated to reduce power */
+    RT500_CLKCTL1_FRG4CLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL1_FRG4CLKSEL_SEL_Enum;
+
+typedef enum {
+    /* FRO_DIV4 clock */
+    RT500_CLKCTL1_FC4FCLKSEL_SEL_FRRO_DIV4 = 0,
+    /* Audio PLL Clock */
+    RT500_CLKCTL1_FC4FCLKSEL_SEL_MASTER_CLOCK = 1,
+    /* None, output gated to reduce power */
+    RT500_CLKCTL1_FC4FCLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL1_FC4FCLKSEL_SEL_Enum;
+
+typedef enum {
+    /* Main Clock */
+    RT500_CLKCTL1_FRG5CLKSEL_SEL_MAIN = 0,
+    /* FRG PLL Clock */
+    RT500_CLKCTL1_FRG5CLKSEL_SEL_FRG_PLL = 1,
+    /* FRO_DIV4 clock */
+    RT500_CLKCTL1_FRG5CLKSEL_SEL_FRRO_DIV4 = 2,
+    /* None, output gated to reduce power */
+    RT500_CLKCTL1_FRG5CLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL1_FRG5CLKSEL_SEL_Enum;
+
+typedef enum {
+    /* FRO_DIV4 clock */
+    RT500_CLKCTL1_FC5FCLKSEL_SEL_FRRO_DIV4 = 0,
+    /* Audio PLL Clock */
+    RT500_CLKCTL1_FC5FCLKSEL_SEL_MASTER_CLOCK = 1,
+    /* None, output gated to reduce power */
+    RT500_CLKCTL1_FC5FCLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL1_FC5FCLKSEL_SEL_Enum;
+
+typedef enum {
+    /* Main Clock */
+    RT500_CLKCTL1_FRG6CLKSEL_SEL_MAIN = 0,
+    /* FRG PLL Clock */
+    RT500_CLKCTL1_FRG6CLKSEL_SEL_FRG_PLL = 1,
+    /* FRO_DIV4 clock */
+    RT500_CLKCTL1_FRG6CLKSEL_SEL_FRRO_DIV4 = 2,
+    /* None, output gated to reduce power */
+    RT500_CLKCTL1_FRG6CLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL1_FRG6CLKSEL_SEL_Enum;
+
+typedef enum {
+    /* FRO_DIV4 clock */
+    RT500_CLKCTL1_FC6FCLKSEL_SEL_FRRO_DIV4 = 0,
+    /* Audio PLL Clock */
+    RT500_CLKCTL1_FC6FCLKSEL_SEL_MASTER_CLOCK = 1,
+    /* None, output gated to reduce power */
+    RT500_CLKCTL1_FC6FCLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL1_FC6FCLKSEL_SEL_Enum;
+
+typedef enum {
+    /* Main Clock */
+    RT500_CLKCTL1_FRG7CLKSEL_SEL_MAIN = 0,
+    /* FRG PLL Clock */
+    RT500_CLKCTL1_FRG7CLKSEL_SEL_FRG_PLL = 1,
+    /* FRO_DIV4 clock */
+    RT500_CLKCTL1_FRG7CLKSEL_SEL_FRRO_DIV4 = 2,
+    /* None, output gated to reduce power */
+    RT500_CLKCTL1_FRG7CLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL1_FRG7CLKSEL_SEL_Enum;
+
+typedef enum {
+    /* FRO_DIV4 clock */
+    RT500_CLKCTL1_FC7FCLKSEL_SEL_FRRO_DIV4 = 0,
+    /* Audio PLL Clock */
+    RT500_CLKCTL1_FC7FCLKSEL_SEL_MASTER_CLOCK = 1,
+    /* None, output gated to reduce power */
+    RT500_CLKCTL1_FC7FCLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL1_FC7FCLKSEL_SEL_Enum;
+
+typedef enum {
+    /* Main Clock */
+    RT500_CLKCTL1_FRG8CLKSEL_SEL_MAIN = 0,
+    /* FRG PLL Clock */
+    RT500_CLKCTL1_FRG8CLKSEL_SEL_FRG_PLL = 1,
+    /* FRO_DIV4 clock */
+    RT500_CLKCTL1_FRG8CLKSEL_SEL_FRRO_DIV4 = 2,
+    /* None, output gated to reduce power */
+    RT500_CLKCTL1_FRG8CLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL1_FRG8CLKSEL_SEL_Enum;
+
+typedef enum {
+    /* FRO_DIV4 clock */
+    RT500_CLKCTL1_FC8FCLKSEL_SEL_FRRO_DIV4 = 0,
+    /* Audio PLL Clock */
+    RT500_CLKCTL1_FC8FCLKSEL_SEL_MASTER_CLOCK = 1,
+    /* None, output gated to reduce power */
+    RT500_CLKCTL1_FC8FCLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL1_FC8FCLKSEL_SEL_Enum;
+
+typedef enum {
+    /* Main Clock */
+    RT500_CLKCTL1_FRG9CLKSEL_SEL_MAIN = 0,
+    /* FRG PLL Clock */
+    RT500_CLKCTL1_FRG9CLKSEL_SEL_FRG_PLL = 1,
+    /* FRO_DIV4 clock */
+    RT500_CLKCTL1_FRG9CLKSEL_SEL_FRRO_DIV4 = 2,
+    /* None, output gated to reduce power */
+    RT500_CLKCTL1_FRG9CLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL1_FRG9CLKSEL_SEL_Enum;
+
+typedef enum {
+    /* FRO_DIV4 clock */
+    RT500_CLKCTL1_FC9FCLKSEL_SEL_FRRO_DIV4 = 0,
+    /* Audio PLL Clock */
+    RT500_CLKCTL1_FC9FCLKSEL_SEL_MASTER_CLOCK = 1,
+    /* None, output gated to reduce power */
+    RT500_CLKCTL1_FC9FCLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL1_FC9FCLKSEL_SEL_Enum;
+
+typedef enum {
+    /* Main Clock */
+    RT500_CLKCTL1_FRG10CLKSEL_SEL_MAIN = 0,
+    /* FRG PLL Clock */
+    RT500_CLKCTL1_FRG10CLKSEL_SEL_FRG_PLL = 1,
+    /* FRO_DIV4 clock */
+    RT500_CLKCTL1_FRG10CLKSEL_SEL_FRRO_DIV4 = 2,
+    /* None, output gated to reduce power */
+    RT500_CLKCTL1_FRG10CLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL1_FRG10CLKSEL_SEL_Enum;
+
+typedef enum {
+    /* FRO_DIV4 clock */
+    RT500_CLKCTL1_FC10FCLKSEL_SEL_FRRO_DIV4 = 0,
+    /* Audio PLL Clock */
+    RT500_CLKCTL1_FC10FCLKSEL_SEL_MASTER_CLOCK = 1,
+    /* None, output gated to reduce power */
+    RT500_CLKCTL1_FC10FCLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL1_FC10FCLKSEL_SEL_Enum;
+
+typedef enum {
+    /* Main Clock */
+    RT500_CLKCTL1_FRG11CLKSEL_SEL_MAIN = 0,
+    /* FRG PLL Clock */
+    RT500_CLKCTL1_FRG11CLKSEL_SEL_FRG_PLL = 1,
+    /* FRO_DIV4 clock */
+    RT500_CLKCTL1_FRG11CLKSEL_SEL_FRRO_DIV4 = 2,
+    /* None, output gated to reduce power */
+    RT500_CLKCTL1_FRG11CLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL1_FRG11CLKSEL_SEL_Enum;
+
+typedef enum {
+    /* FRO_DIV4 clock */
+    RT500_CLKCTL1_FC11FCLKSEL_SEL_FRRO_DIV4 = 0,
+    /* Audio PLL Clock */
+    RT500_CLKCTL1_FC11FCLKSEL_SEL_MASTER_CLOCK = 1,
+    /* None, output gated to reduce power */
+    RT500_CLKCTL1_FC11FCLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL1_FC11FCLKSEL_SEL_Enum;
+
+typedef enum {
+    /* Main Clock */
+    RT500_CLKCTL1_FRG12CLKSEL_SEL_MAIN = 0,
+    /* FRG PLL Clock */
+    RT500_CLKCTL1_FRG12CLKSEL_SEL_FRG_PLL = 1,
+    /* FRO_DIV4 clock */
+    RT500_CLKCTL1_FRG12CLKSEL_SEL_FRRO_DIV4 = 2,
+    /* None, output gated to reduce power */
+    RT500_CLKCTL1_FRG12CLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL1_FRG12CLKSEL_SEL_Enum;
+
+typedef enum {
+    /* FRO_DIV4 clock */
+    RT500_CLKCTL1_FC12FCLKSEL_SEL_FRRO_DIV4 = 0,
+    /* Audio PLL Clock */
+    RT500_CLKCTL1_FC12FCLKSEL_SEL_MASTER_CLOCK = 1,
+    /* None, output gated to reduce power */
+    RT500_CLKCTL1_FC12FCLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL1_FC12FCLKSEL_SEL_Enum;
+
+typedef enum {
+    /* Main Clock */
+    RT500_CLKCTL1_FRG13CLKSEL_SEL_MAIN = 0,
+    /* FRG PLL Clock */
+    RT500_CLKCTL1_FRG13CLKSEL_SEL_FRG_PLL = 1,
+    /* FRO_DIV4 clock */
+    RT500_CLKCTL1_FRG13CLKSEL_SEL_FRRO_DIV4 = 2,
+    /* None, output gated to reduce power */
+    RT500_CLKCTL1_FRG13CLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL1_FRG13CLKSEL_SEL_Enum;
+
+typedef enum {
+    /* FRO_DIV4 clock */
+    RT500_CLKCTL1_FC13FCLKSEL_SEL_FRRO_DIV4 = 0,
+    /* Audio PLL Clock */
+    RT500_CLKCTL1_FC13FCLKSEL_SEL_MASTER_CLOCK = 1,
+    /* None, output gated to reduce power */
+    RT500_CLKCTL1_FC13FCLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL1_FC13FCLKSEL_SEL_Enum;
+
+typedef enum {
+    /* Main Clock */
+    RT500_CLKCTL1_FRG14CLKSEL_SEL_MAIN = 0,
+    /* FRG PLL Clock */
+    RT500_CLKCTL1_FRG14CLKSEL_SEL_FRG_PLL = 1,
+    /* FRO_DIV4 clock */
+    RT500_CLKCTL1_FRG14CLKSEL_SEL_FRRO_DIV4 = 2,
+    /* None, output gated to reduce power */
+    RT500_CLKCTL1_FRG14CLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL1_FRG14CLKSEL_SEL_Enum;
+
+typedef enum {
+    /* FRO_DIV4 clock */
+    RT500_CLKCTL1_FC14FCLKSEL_SEL_FRRO_DIV4 = 0,
+    /* Audio PLL Clock */
+    RT500_CLKCTL1_FC14FCLKSEL_SEL_MASTER_CLOCK = 1,
+    /* None, output gated to reduce power */
+    RT500_CLKCTL1_FC14FCLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL1_FC14FCLKSEL_SEL_Enum;
+
+typedef enum {
+    /* Main Clock */
+    RT500_CLKCTL1_FRG15CLKSEL_SEL_MAIN = 0,
+    /* FRG PLL Clock */
+    RT500_CLKCTL1_FRG15CLKSEL_SEL_FRG_PLL = 1,
+    /* FRO_DIV4 clock */
+    RT500_CLKCTL1_FRG15CLKSEL_SEL_FRRO_DIV4 = 2,
+    /* None, output gated to reduce power */
+    RT500_CLKCTL1_FRG15CLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL1_FRG15CLKSEL_SEL_Enum;
+
+typedef enum {
+    /* FRO_DIV4 clock */
+    RT500_CLKCTL1_FC15FCLKSEL_SEL_FRRO_DIV4 = 0,
+    /* Audio PLL Clock */
+    RT500_CLKCTL1_FC15FCLKSEL_SEL_MASTER_CLOCK = 1,
+    /* None, output gated to reduce power */
+    RT500_CLKCTL1_FC15FCLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL1_FC15FCLKSEL_SEL_Enum;
+
+typedef enum {
+    /* Main Clock */
+    RT500_CLKCTL1_FRG16CLKSEL_SEL_MAIN = 0,
+    /* FRG PLL Clock */
+    RT500_CLKCTL1_FRG16CLKSEL_SEL_FRG_PLL = 1,
+    /* FRO_DIV4 clock */
+    RT500_CLKCTL1_FRG16CLKSEL_SEL_FRRO_DIV4 = 2,
+    /* None, output gated to reduce power */
+    RT500_CLKCTL1_FRG16CLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL1_FRG16CLKSEL_SEL_Enum;
+
+typedef enum {
+    /* FRO_DIV4 clock */
+    RT500_CLKCTL1_FC16FCLKSEL_SEL_FRRO_DIV4 = 0,
+    /* Audio PLL Clock */
+    RT500_CLKCTL1_FC16FCLKSEL_SEL_MASTER_CLOCK = 1,
+    /* None, output gated to reduce power */
+    RT500_CLKCTL1_FC16FCLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL1_FC16FCLKSEL_SEL_Enum;
+
+typedef enum {
+    /* Main Clock */
+    RT500_CLKCTL1_FRG17CLKSEL_SEL_MAIN = 0,
+    /* FRG PLL Clock */
+    RT500_CLKCTL1_FRG17CLKSEL_SEL_FRG_PLL = 1,
+    /* FRO_DIV4 clock */
+    RT500_CLKCTL1_FRG17CLKSEL_SEL_FRRO_DIV4 = 2,
+    /* None, output gated to reduce power */
+    RT500_CLKCTL1_FRG17CLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL1_FRG17CLKSEL_SEL_Enum;
+
+typedef enum {
+    /* FRO_DIV2 Clock */
+    RT500_CLKCTL1_FLEXIOCLKSEL_SEL_FRRO_DIV2 = 0,
+    /* Audio PLL Clock */
+    RT500_CLKCTL1_FLEXIOCLKSEL_SEL_OSC_CLK = 1,
+    /* Master Clock In */
+    RT500_CLKCTL1_FLEXIOCLKSEL_SEL_MASTER_CLKIN = 2,
+    /* FC17 FRG Clock */
+    RT500_CLKCTL1_FLEXIOCLKSEL_SEL_FC17_FRG = 3,
+    /* None, output gated to reduce power */
+    RT500_CLKCTL1_FLEXIOCLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL1_FLEXIOCLKSEL_SEL_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_FLEXIOCLKDIV_RESET_DIVIDER_COUNTER_NOT_RESET = 0,
+    /* Reset the Divider Counter */
+    RT500_CLKCTL1_FLEXIOCLKDIV_RESET_DIVIDER_COUNTER_RESET = 1,
+} RT500_CLKCTL1_FLEXIOCLKDIV_RESET_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_FLEXIOCLKDIV_HALT_DIVIDER_COUNTER_NOT_HALT = 0,
+    /* Halt (stop) the Divider Counter */
+    RT500_CLKCTL1_FLEXIOCLKDIV_HALT_DIVIDER_COUNTER_HALT = 1,
+} RT500_CLKCTL1_FLEXIOCLKDIV_HALT_Enum;
+
+typedef enum {
+    /*
+     * The Divider change has finished (clock being divided must be running for
+     * this status to change).
+     */
+    RT500_CLKCTL1_FLEXIOCLKDIV_REQFLAG_REQFLAG_CHANGE_FINISHED = 0,
+    /* The Divider value has changed */
+    RT500_CLKCTL1_FLEXIOCLKDIV_REQFLAG_REQFLAG_CHANGED = 1,
+} RT500_CLKCTL1_FLEXIOCLKDIV_REQFLAG_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_FRGPLLCLKDIV_RESET_DIVIDER_COUNTER_NOT_RESET = 0,
+    /* Reset the Divider Counter */
+    RT500_CLKCTL1_FRGPLLCLKDIV_RESET_DIVIDER_COUNTER_RESET = 1,
+} RT500_CLKCTL1_FRGPLLCLKDIV_RESET_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_FRGPLLCLKDIV_HALT_DIVIDER_COUNTER_NOT_HALT = 0,
+    /* Halt (stop) the Divider Counter */
+    RT500_CLKCTL1_FRGPLLCLKDIV_HALT_DIVIDER_COUNTER_HALT = 1,
+} RT500_CLKCTL1_FRGPLLCLKDIV_HALT_Enum;
+
+typedef enum {
+    /*
+     * The Divider change has finished (clock being divided must be running for
+     * this status to change).
+     */
+    RT500_CLKCTL1_FRGPLLCLKDIV_REQFLAG_REQFLAG_CHANGE_FINISHED = 0,
+    /* The Divider value has changed. */
+    RT500_CLKCTL1_FRGPLLCLKDIV_REQFLAG_REQFLAG_CHANGED = 1,
+} RT500_CLKCTL1_FRGPLLCLKDIV_REQFLAG_Enum;
+
+typedef enum {
+    /* FRO Clock (Divided-by-4 selection) */
+    RT500_CLKCTL1_DMIC0FCLKSEL_SEL_FRRO_DIV4 = 0,
+    /* Audio PLL Clock */
+    RT500_CLKCTL1_DMIC0FCLKSEL_SEL_AUDIO_PLL = 1,
+    /* Master Clock In */
+    RT500_CLKCTL1_DMIC0FCLKSEL_SEL_MASTER_CLOCK = 2,
+    /* Low Power Oscillator Clock (LPOSC) */
+    RT500_CLKCTL1_DMIC0FCLKSEL_SEL_LPOSC = 3,
+    /* 32 KHz Wake Clock */
+    RT500_CLKCTL1_DMIC0FCLKSEL_SEL_WAKE_32KHZ = 4,
+    /* None, output gated to reduce power */
+    RT500_CLKCTL1_DMIC0FCLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL1_DMIC0FCLKSEL_SEL_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_DMIC0FCLKDIV_RESET_DIVIDER_COUNTER_NOT_RESET = 0,
+    /* Reset the Divider Counter */
+    RT500_CLKCTL1_DMIC0FCLKDIV_RESET_DIVIDER_COUNTER_RESET = 1,
+} RT500_CLKCTL1_DMIC0FCLKDIV_RESET_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_DMIC0FCLKDIV_HALT_DIVIDER_COUNTER_NOT_HALT = 0,
+    /* Halt (stop) the Divider Counter */
+    RT500_CLKCTL1_DMIC0FCLKDIV_HALT_DIVIDER_COUNTER_HALT = 1,
+} RT500_CLKCTL1_DMIC0FCLKDIV_HALT_Enum;
+
+typedef enum {
+    /*
+     * The Divider change has finished (clock being divided must be running for
+     * this status to change).
+     */
+    RT500_CLKCTL1_DMIC0FCLKDIV_REQFLAG_REQFLAG_CHANGE_FINISHED = 0,
+    /* The Divider value has changed. */
+    RT500_CLKCTL1_DMIC0FCLKDIV_REQFLAG_REQFLAG_CHANGED = 1,
+} RT500_CLKCTL1_DMIC0FCLKDIV_REQFLAG_Enum;
+
+typedef enum {
+    /* Main Clock */
+    RT500_CLKCTL1_CT32BITFCLKSEL_SEL_MAIN = 0,
+    /* FRO_DIV1 Clock */
+    RT500_CLKCTL1_CT32BITFCLKSEL_SEL_FRO = 1,
+    /* Audio PLL Clock */
+    RT500_CLKCTL1_CT32BITFCLKSEL_SEL_AUDIO_PLL = 2,
+    /* Master Clock In */
+    RT500_CLKCTL1_CT32BITFCLKSEL_SEL_MASTER_CLOCK = 3,
+    /* 32 KHZ Wake Clock */
+    RT500_CLKCTL1_CT32BITFCLKSEL_SEL_WAKE_32KHZ = 4,
+    /* None, output gated to reduce power */
+    RT500_CLKCTL1_CT32BITFCLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL1_CT32BITFCLKSEL_SEL_Enum;
+
+typedef enum {
+    /* FRO_DIV8 Clock */
+    RT500_CLKCTL1_AUDIOMCLKSEL_SEL_FRRO_DIV8 = 0,
+    /* AUDIO PLL Clock (Shared Domain) */
+    RT500_CLKCTL1_AUDIOMCLKSEL_SEL_AUDIO_PLL = 1,
+    /* None, output gated to reduce power */
+    RT500_CLKCTL1_AUDIOMCLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL1_AUDIOMCLKSEL_SEL_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_AUDIOMCLKDIV_RESET_DIVIDER_COUNTER_NOT_RESET = 0,
+    /* Reset the Divider Counter */
+    RT500_CLKCTL1_AUDIOMCLKDIV_RESET_DIVIDER_COUNTER_RESET = 1,
+} RT500_CLKCTL1_AUDIOMCLKDIV_RESET_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_AUDIOMCLKDIV_HALT_DIVIDER_COUNTER_NOT_HALT = 0,
+    /* Halt (stop) the Divider Counter */
+    RT500_CLKCTL1_AUDIOMCLKDIV_HALT_DIVIDER_COUNTER_HALT = 1,
+} RT500_CLKCTL1_AUDIOMCLKDIV_HALT_Enum;
+
+typedef enum {
+    /*
+     * The Divider change has finished (clock being divided must be running for
+     * this status to change).
+     */
+    RT500_CLKCTL1_AUDIOMCLKDIV_REQFLAG_REQFLAG_CHANGE_FINISHED = 0,
+    /* The Divider value has changed. */
+    RT500_CLKCTL1_AUDIOMCLKDIV_REQFLAG_REQFLAG_CHANGED = 1,
+} RT500_CLKCTL1_AUDIOMCLKDIV_REQFLAG_Enum;
+
+typedef enum {
+    /* OSC_CLK Clock */
+    RT500_CLKCTL1_CLKOUTSEL0_SEL_OSC_CLK = 0,
+    /* Low Power Oscillator Clock (LPOSC) */
+    RT500_CLKCTL1_CLKOUTSEL0_SEL_LPOSC = 1,
+    /* FRO_DIV2 Clock */
+    RT500_CLKCTL1_CLKOUTSEL0_SEL_FRO = 2,
+    /* Main Clock */
+    RT500_CLKCTL1_CLKOUTSEL0_SEL_MAIN = 3,
+    /* DSP Main Clock */
+    RT500_CLKCTL1_CLKOUTSEL0_SEL_DSP_MAIN = 4,
+    /* None, output gated to reduce power */
+    RT500_CLKCTL1_CLKOUTSEL0_SEL_NONE = 7,
+} RT500_CLKCTL1_CLKOUTSEL0_SEL_Enum;
+
+typedef enum {
+    /* CLKOUTSEL0 Multiplexed Output */
+    RT500_CLKCTL1_CLKOUTSEL1_SEL_CLKOUTSEL0_MUX_OUT = 0,
+    /* Main System PLL Clock */
+    RT500_CLKCTL1_CLKOUTSEL1_SEL_MAIN_PLL = 1,
+    /* SYSPLL0 AUX0_PLL_Clock */
+    RT500_CLKCTL1_CLKOUTSEL1_SEL_SYSPLL0_AUX0_PLL = 2,
+    /* DSP PLL Clock */
+    RT500_CLKCTL1_CLKOUTSEL1_SEL_DSP_PLL = 3,
+    /* SYSPLL0 AUX1_PLL_Clock */
+    RT500_CLKCTL1_CLKOUTSEL1_SEL_SYSPLL0_AUX1_PLL = 4,
+    /* AUDIO PLL Clock */
+    RT500_CLKCTL1_CLKOUTSEL1_SEL_AUDIO_PLL = 5,
+    /* 32 KHz RTC Clock */
+    RT500_CLKCTL1_CLKOUTSEL1_SEL_RTC_32KHZ = 6,
+    /* None, output gated to reduce power */
+    RT500_CLKCTL1_CLKOUTSEL1_SEL_NONE = 7,
+} RT500_CLKCTL1_CLKOUTSEL1_SEL_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_CLKOUTFCLKDIV_RESET_DIVIDER_COUNTER_NOT_RESET = 0,
+    /* Reset the Divider Counter */
+    RT500_CLKCTL1_CLKOUTFCLKDIV_RESET_DIVIDER_COUNTER_RESET = 1,
+} RT500_CLKCTL1_CLKOUTFCLKDIV_RESET_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_CLKOUTFCLKDIV_HALT_DIVIDER_COUNTER_NOT_HALT = 0,
+    /* Halt (stop) the Divider Counter */
+    RT500_CLKCTL1_CLKOUTFCLKDIV_HALT_DIVIDER_COUNTER_HALT = 1,
+} RT500_CLKCTL1_CLKOUTFCLKDIV_HALT_Enum;
+
+typedef enum {
+    /*
+     * The Divider change has finished (clock being divided must be running for
+     * this status to change).
+     */
+    RT500_CLKCTL1_CLKOUTFCLKDIV_REQFLAG_REQFLAG_CHANGE_FINISHED = 0,
+    /* The Divider value has changed */
+    RT500_CLKCTL1_CLKOUTFCLKDIV_REQFLAG_REQFLAG_CHANGED = 1,
+} RT500_CLKCTL1_CLKOUTFCLKDIV_REQFLAG_Enum;
+
+typedef enum {
+    /* Main Clock */
+    RT500_CLKCTL1_I3C01FCLKSEL_SEL_MAIN = 0,
+    /* FRO_DIV8 Clock */
+    RT500_CLKCTL1_I3C01FCLKSEL_SEL_FRRO_DIV8 = 1,
+    /* None, output gated to reduce power */
+    RT500_CLKCTL1_I3C01FCLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL1_I3C01FCLKSEL_SEL_Enum;
+
+typedef enum {
+    /* I3C0 FCLK */
+    RT500_CLKCTL1_I3C01FCLKSTCSEL_SEL_I3C0 = 0,
+    /* Low Power Oscillator Clock (LPOSC) */
+    RT500_CLKCTL1_I3C01FCLKSTCSEL_SEL_LPOSC = 1,
+    /* None, output gated to reduce power */
+    RT500_CLKCTL1_I3C01FCLKSTCSEL_SEL_NONE = 7,
+} RT500_CLKCTL1_I3C01FCLKSTCSEL_SEL_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_I3C01FCLKSTCDIV_RESET_DIVIDER_COUNTER_NOT_RESET = 0,
+    /* Reset the Divider Counter */
+    RT500_CLKCTL1_I3C01FCLKSTCDIV_RESET_DIVIDER_COUNTER_RESET = 1,
+} RT500_CLKCTL1_I3C01FCLKSTCDIV_RESET_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_I3C01FCLKSTCDIV_HALT_DIVIDER_COUNTER_NOT_HALT = 0,
+    /* Halt (stop) the Divider Counter */
+    RT500_CLKCTL1_I3C01FCLKSTCDIV_HALT_DIVIDER_COUNTER_HALT = 1,
+} RT500_CLKCTL1_I3C01FCLKSTCDIV_HALT_Enum;
+
+typedef enum {
+    /*
+     * The Divider change has finished (clock being divided must be running for
+     * this status to change).
+     */
+    RT500_CLKCTL1_I3C01FCLKSTCDIV_REQFLAG_REQFLAG_CHANGE_FINISHED = 0,
+    /* The Divider value has changed. */
+    RT500_CLKCTL1_I3C01FCLKSTCDIV_REQFLAG_REQFLAG_CHANGED = 1,
+} RT500_CLKCTL1_I3C01FCLKSTCDIV_REQFLAG_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_I3C01FCLKSDIV_RESET_DIVIDER_COUNTER_NOT_RESET = 0,
+    /* Reset the Divider Counter */
+    RT500_CLKCTL1_I3C01FCLKSDIV_RESET_DIVIDER_COUNTER_RESET = 1,
+} RT500_CLKCTL1_I3C01FCLKSDIV_RESET_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_I3C01FCLKSDIV_HALT_DIVIDER_COUNTER_NOT_HALT = 0,
+    /* Halt (stop) the Divider Counter */
+    RT500_CLKCTL1_I3C01FCLKSDIV_HALT_DIVIDER_COUNTER_HALT = 1,
+} RT500_CLKCTL1_I3C01FCLKSDIV_HALT_Enum;
+
+typedef enum {
+    /*
+     * The Divider change has finished (clock being divided must be running for
+     * this status to change).
+     */
+    RT500_CLKCTL1_I3C01FCLKSDIV_REQFLAG_REQFLAG_CHANGE_FINISHED = 0,
+    /* The Divider value has changed. */
+    RT500_CLKCTL1_I3C01FCLKSDIV_REQFLAG_REQFLAG_CHANGED = 1,
+} RT500_CLKCTL1_I3C01FCLKSDIV_REQFLAG_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_I3C01FCLKDIV_RESET_DIVIDER_COUNTER_NOT_RESET = 0,
+    /* Reset the Divider Counter */
+    RT500_CLKCTL1_I3C01FCLKDIV_RESET_DIVIDER_COUNTER_RESET = 1,
+} RT500_CLKCTL1_I3C01FCLKDIV_RESET_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_I3C01FCLKDIV_HALT_DIVIDER_COUNTER_NOT_HALT = 0,
+    /* Halt (stop) the Divider Counter */
+    RT500_CLKCTL1_I3C01FCLKDIV_HALT_DIVIDER_COUNTER_HALT = 1,
+} RT500_CLKCTL1_I3C01FCLKDIV_HALT_Enum;
+
+typedef enum {
+    /*
+     * The Divider change has finished (clock being divided must be running for
+     * this status to change).
+     */
+    RT500_CLKCTL1_I3C01FCLKDIV_REQFLAG_REQFLAG_CHANGE_FINISHED = 0,
+    /* The Divider value has changed. */
+    RT500_CLKCTL1_I3C01FCLKDIV_REQFLAG_REQFLAG_CHANGED = 1,
+} RT500_CLKCTL1_I3C01FCLKDIV_REQFLAG_Enum;
+
+typedef enum {
+    /* Low Power Oscillator Clock (LPOSC) */
+    RT500_CLKCTL1_I3C01FCLKSTSTCLKSEL_SEL_LPOSC = 0,
+    /* None, output gated to reduce power */
+    RT500_CLKCTL1_I3C01FCLKSTSTCLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL1_I3C01FCLKSTSTCLKSEL_SEL_Enum;
+
+typedef enum {
+    /* Low Power Oscillator Clock (LPOSC) */
+    RT500_CLKCTL1_WDT1FCLKSEL_SEL_LPOSC = 0,
+    /* None, output gated to reduce power */
+    RT500_CLKCTL1_WDT1FCLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL1_WDT1FCLKSEL_SEL_Enum;
+
+typedef enum {
+    /* Main Clock */
+    RT500_CLKCTL1_ACMP0FCLKSEL_SEL_MAIN = 0,
+    /* FRO_DIV4 Clock */
+    RT500_CLKCTL1_ACMP0FCLKSEL_SEL_FRRO_DIV4 = 1,
+    /* SYSPLL0 AUX0_PLL_Clock */
+    RT500_CLKCTL1_ACMP0FCLKSEL_SEL_SYSPLL0_AUX0_PLL = 2,
+    /* SYSPLL0 AUX1_PLL_Clock */
+    RT500_CLKCTL1_ACMP0FCLKSEL_SEL_SYSPLL0_AUX1_PLL = 3,
+    /* None, output gated to reduce power */
+    RT500_CLKCTL1_ACMP0FCLKSEL_SEL_NONE = 7,
+} RT500_CLKCTL1_ACMP0FCLKSEL_SEL_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_ACMP0FCLKDIV_RESET_DIVIDER_COUNTER_NOT_RESET = 0,
+    /* Reset the Divider Counter */
+    RT500_CLKCTL1_ACMP0FCLKDIV_RESET_DIVIDER_COUNTER_RESET = 1,
+} RT500_CLKCTL1_ACMP0FCLKDIV_RESET_Enum;
+
+typedef enum {
+    /* No effect */
+    RT500_CLKCTL1_ACMP0FCLKDIV_HALT_DIVIDER_COUNTER_NOT_HALT = 0,
+    /* Halt (stop) the Divider Counter */
+    RT500_CLKCTL1_ACMP0FCLKDIV_HALT_DIVIDER_COUNTER_HALT = 1,
+} RT500_CLKCTL1_ACMP0FCLKDIV_HALT_Enum;
+
+typedef enum {
+    /*
+     * The Divider change has finished (clock being divided must be running for
+     * this status to change).
+     */
+    RT500_CLKCTL1_ACMP0FCLKDIV_REQFLAG_REQFLAG_CHANGE_FINISHED = 0,
+    /* The Divider value has changed. */
+    RT500_CLKCTL1_ACMP0FCLKDIV_REQFLAG_REQFLAG_CHANGED = 1,
+} RT500_CLKCTL1_ACMP0FCLKDIV_REQFLAG_Enum;
+
+
+#define RT500_CLKCTL1_REGISTER_NAMES_ARRAY(_name) \
+    const char *_name[RT500_CLKCTL1_REGS_NO] = { \
+        [R_RT500_CLKCTL1_PSCCTL0] = "PSCCTL0", \
+        [R_RT500_CLKCTL1_PSCCTL1] = "PSCCTL1", \
+        [R_RT500_CLKCTL1_PSCCTL2] = "PSCCTL2", \
+        [R_RT500_CLKCTL1_PSCCTL0_SET] = "PSCCTL0_SET", \
+        [R_RT500_CLKCTL1_PSCCTL1_SET] = "PSCCTL1_SET", \
+        [R_RT500_CLKCTL1_PSCCTL2_SET] = "PSCCTL2_SET", \
+        [R_RT500_CLKCTL1_PSCCTL0_CLR] = "PSCCTL0_CLR", \
+        [R_RT500_CLKCTL1_PSCCTL1_CLR] = "PSCCTL1_CLR", \
+        [R_RT500_CLKCTL1_PSCCTL2_CLR] = "PSCCTL2_CLR", \
+        [R_RT500_CLKCTL1_AUDIOPLL0CLKSEL] = "AUDIOPLL0CLKSEL", \
+        [R_RT500_CLKCTL1_AUDIOPLL0CTL0] = "AUDIOPLL0CTL0", \
+        [R_RT500_CLKCTL1_AUDIOPLL0LOCKTIMEDIV2] = "AUDIOPLL0LOCKTIMEDIV2", \
+        [R_RT500_CLKCTL1_AUDIOPLL0NUM] = "AUDIOPLL0NUM", \
+        [R_RT500_CLKCTL1_AUDIOPLL0DENOM] = "AUDIOPLL0DENOM", \
+        [R_RT500_CLKCTL1_AUDIOPLL0PFD] = "AUDIOPLL0PFD", \
+        [R_RT500_CLKCTL1_AUDIOPLLCLKDIV] = "AUDIOPLLCLKDIV", \
+        [R_RT500_CLKCTL1_DSPCPUCLKDIV] = "DSPCPUCLKDIV", \
+        [R_RT500_CLKCTL1_DSPCPUCLKSELA] = "DSPCPUCLKSELA", \
+        [R_RT500_CLKCTL1_DSPCPUCLKSELB] = "DSPCPUCLKSELB", \
+        [R_RT500_CLKCTL1_OSEVENTTFCLKSEL] = "OSEVENTTFCLKSEL", \
+        [R_RT500_CLKCTL1_FRG0CLKSEL] = "FRG0CLKSEL", \
+        [R_RT500_CLKCTL1_FRG0CTL] = "FRG0CTL", \
+        [R_RT500_CLKCTL1_FC0FCLKSEL] = "FC0FCLKSEL", \
+        [R_RT500_CLKCTL1_FRG1CLKSEL] = "FRG1CLKSEL", \
+        [R_RT500_CLKCTL1_FRG1CTL] = "FRG1CTL", \
+        [R_RT500_CLKCTL1_FC1FCLKSEL] = "FC1FCLKSEL", \
+        [R_RT500_CLKCTL1_FRG2CLKSEL] = "FRG2CLKSEL", \
+        [R_RT500_CLKCTL1_FRG2CTL] = "FRG2CTL", \
+        [R_RT500_CLKCTL1_FC2FCLKSEL] = "FC2FCLKSEL", \
+        [R_RT500_CLKCTL1_FRG3CLKSEL] = "FRG3CLKSEL", \
+        [R_RT500_CLKCTL1_FRG3CTL] = "FRG3CTL", \
+        [R_RT500_CLKCTL1_FC3FCLKSEL] = "FC3FCLKSEL", \
+        [R_RT500_CLKCTL1_FRG4CLKSEL] = "FRG4CLKSEL", \
+        [R_RT500_CLKCTL1_FRG4CTL] = "FRG4CTL", \
+        [R_RT500_CLKCTL1_FC4FCLKSEL] = "FC4FCLKSEL", \
+        [R_RT500_CLKCTL1_FRG5CLKSEL] = "FRG5CLKSEL", \
+        [R_RT500_CLKCTL1_FRG5CTL] = "FRG5CTL", \
+        [R_RT500_CLKCTL1_FC5FCLKSEL] = "FC5FCLKSEL", \
+        [R_RT500_CLKCTL1_FRG6CLKSEL] = "FRG6CLKSEL", \
+        [R_RT500_CLKCTL1_FRG6CTL] = "FRG6CTL", \
+        [R_RT500_CLKCTL1_FC6FCLKSEL] = "FC6FCLKSEL", \
+        [R_RT500_CLKCTL1_FRG7CLKSEL] = "FRG7CLKSEL", \
+        [R_RT500_CLKCTL1_FRG7CTL] = "FRG7CTL", \
+        [R_RT500_CLKCTL1_FC7FCLKSEL] = "FC7FCLKSEL", \
+        [R_RT500_CLKCTL1_FRG8CLKSEL] = "FRG8CLKSEL", \
+        [R_RT500_CLKCTL1_FRG8CTL] = "FRG8CTL", \
+        [R_RT500_CLKCTL1_FC8FCLKSEL] = "FC8FCLKSEL", \
+        [R_RT500_CLKCTL1_FRG9CLKSEL] = "FRG9CLKSEL", \
+        [R_RT500_CLKCTL1_FRG9CTL] = "FRG9CTL", \
+        [R_RT500_CLKCTL1_FC9FCLKSEL] = "FC9FCLKSEL", \
+        [R_RT500_CLKCTL1_FRG10CLKSEL] = "FRG10CLKSEL", \
+        [R_RT500_CLKCTL1_FRG10CTL] = "FRG10CTL", \
+        [R_RT500_CLKCTL1_FC10FCLKSEL] = "FC10FCLKSEL", \
+        [R_RT500_CLKCTL1_FRG11CLKSEL] = "FRG11CLKSEL", \
+        [R_RT500_CLKCTL1_FRG11CTL] = "FRG11CTL", \
+        [R_RT500_CLKCTL1_FC11FCLKSEL] = "FC11FCLKSEL", \
+        [R_RT500_CLKCTL1_FRG12CLKSEL] = "FRG12CLKSEL", \
+        [R_RT500_CLKCTL1_FRG12CTL] = "FRG12CTL", \
+        [R_RT500_CLKCTL1_FC12FCLKSEL] = "FC12FCLKSEL", \
+        [R_RT500_CLKCTL1_FRG13CLKSEL] = "FRG13CLKSEL", \
+        [R_RT500_CLKCTL1_FRG13CTL] = "FRG13CTL", \
+        [R_RT500_CLKCTL1_FC13FCLKSEL] = "FC13FCLKSEL", \
+        [R_RT500_CLKCTL1_FRG14CLKSEL] = "FRG14CLKSEL", \
+        [R_RT500_CLKCTL1_FRG14CTL] = "FRG14CTL", \
+        [R_RT500_CLKCTL1_FC14FCLKSEL] = "FC14FCLKSEL", \
+        [R_RT500_CLKCTL1_FRG15CLKSEL] = "FRG15CLKSEL", \
+        [R_RT500_CLKCTL1_FRG15CTL] = "FRG15CTL", \
+        [R_RT500_CLKCTL1_FC15FCLKSEL] = "FC15FCLKSEL", \
+        [R_RT500_CLKCTL1_FRG16CLKSEL] = "FRG16CLKSEL", \
+        [R_RT500_CLKCTL1_FRG16CTL] = "FRG16CTL", \
+        [R_RT500_CLKCTL1_FC16FCLKSEL] = "FC16FCLKSEL", \
+        [R_RT500_CLKCTL1_FRG17CLKSEL] = "FRG17CLKSEL", \
+        [R_RT500_CLKCTL1_FRG17CTL] = "FRG17CTL", \
+        [R_RT500_CLKCTL1_FLEXIOCLKSEL] = "FLEXIOCLKSEL", \
+        [R_RT500_CLKCTL1_FLEXIOCLKDIV] = "FLEXIOCLKDIV", \
+        [R_RT500_CLKCTL1_FRGPLLCLKDIV] = "FRGPLLCLKDIV", \
+        [R_RT500_CLKCTL1_DMIC0FCLKSEL] = "DMIC0FCLKSEL", \
+        [R_RT500_CLKCTL1_DMIC0FCLKDIV] = "DMIC0FCLKDIV", \
+        [R_RT500_CLKCTL1_CT32BITFCLKSEL0] = "CT32BITFCLKSEL0", \
+        [R_RT500_CLKCTL1_CT32BITFCLKSEL1] = "CT32BITFCLKSEL1", \
+        [R_RT500_CLKCTL1_CT32BITFCLKSEL2] = "CT32BITFCLKSEL2", \
+        [R_RT500_CLKCTL1_CT32BITFCLKSEL3] = "CT32BITFCLKSEL3", \
+        [R_RT500_CLKCTL1_CT32BITFCLKSEL4] = "CT32BITFCLKSEL4", \
+        [R_RT500_CLKCTL1_AUDIOMCLKSEL] = "AUDIOMCLKSEL", \
+        [R_RT500_CLKCTL1_AUDIOMCLKDIV] = "AUDIOMCLKDIV", \
+        [R_RT500_CLKCTL1_CLKOUTSEL0] = "CLKOUTSEL0", \
+        [R_RT500_CLKCTL1_CLKOUTSEL1] = "CLKOUTSEL1", \
+        [R_RT500_CLKCTL1_CLKOUTFCLKDIV] = "CLKOUTFCLKDIV", \
+        [R_RT500_CLKCTL1_I3C01FCLKSEL] = "I3C01FCLKSEL", \
+        [R_RT500_CLKCTL1_I3C01FCLKSTCSEL] = "I3C01FCLKSTCSEL", \
+        [R_RT500_CLKCTL1_I3C01FCLKSTCDIV] = "I3C01FCLKSTCDIV", \
+        [R_RT500_CLKCTL1_I3C01FCLKSDIV] = "I3C01FCLKSDIV", \
+        [R_RT500_CLKCTL1_I3C01FCLKDIV] = "I3C01FCLKDIV", \
+        [R_RT500_CLKCTL1_I3C01FCLKSTSTCLKSEL] = "I3C01FCLKSTSTCLKSEL", \
+        [R_RT500_CLKCTL1_WDT1FCLKSEL] = "WDT1FCLKSEL", \
+        [R_RT500_CLKCTL1_ACMP0FCLKSEL] = "ACMP0FCLKSEL", \
+        [R_RT500_CLKCTL1_ACMP0FCLKDIV] = "ACMP0FCLKDIV", \
+    }
+
+#define RT500_CLKCTL1_REGISTER_WMASK_ARRAY(_name) \
+    const uint32_t _name[RT500_CLKCTL1_REGS_NO] = { \
+        [R_RT500_CLKCTL1_PSCCTL0] = 0x2BFFFF00, \
+        [R_RT500_CLKCTL1_PSCCTL1] = 0xB18100FF, \
+        [R_RT500_CLKCTL1_PSCCTL2] = 0xC003059F, \
+        [R_RT500_CLKCTL1_PSCCTL0_SET] = 0x2BFFFF00, \
+        [R_RT500_CLKCTL1_PSCCTL1_SET] = 0xB18100FF, \
+        [R_RT500_CLKCTL1_PSCCTL2_SET] = 0xC003059F, \
+        [R_RT500_CLKCTL1_PSCCTL0_CLR] = 0x2BFFFF00, \
+        [R_RT500_CLKCTL1_PSCCTL1_CLR] = 0xB18100FF, \
+        [R_RT500_CLKCTL1_PSCCTL2_CLR] = 0xC003059F, \
+        [R_RT500_CLKCTL1_AUDIOPLL0CLKSEL] = 0x7, \
+        [R_RT500_CLKCTL1_AUDIOPLL0CTL0] = 0xFF2003, \
+        [R_RT500_CLKCTL1_AUDIOPLL0LOCKTIMEDIV2] = 0xFFFF, \
+        [R_RT500_CLKCTL1_AUDIOPLL0NUM] = 0x3FFFFFFF, \
+        [R_RT500_CLKCTL1_AUDIOPLL0DENOM] = 0x3FFFFFFF, \
+        [R_RT500_CLKCTL1_AUDIOPLL0PFD] = 0xFFFFFFFF, \
+        [R_RT500_CLKCTL1_AUDIOPLLCLKDIV] = 0xE00000FF, \
+        [R_RT500_CLKCTL1_DSPCPUCLKDIV] = 0xE00000FF, \
+        [R_RT500_CLKCTL1_DSPCPUCLKSELA] = 0x3, \
+        [R_RT500_CLKCTL1_DSPCPUCLKSELB] = 0x3, \
+        [R_RT500_CLKCTL1_OSEVENTTFCLKSEL] = 0x7, \
+        [R_RT500_CLKCTL1_FRG0CLKSEL] = 0x7, \
+        [R_RT500_CLKCTL1_FRG0CTL] = 0xFFFF, \
+        [R_RT500_CLKCTL1_FC0FCLKSEL] = 0x7, \
+        [R_RT500_CLKCTL1_FRG1CLKSEL] = 0x7, \
+        [R_RT500_CLKCTL1_FRG1CTL] = 0xFFFF, \
+        [R_RT500_CLKCTL1_FC1FCLKSEL] = 0x7, \
+        [R_RT500_CLKCTL1_FRG2CLKSEL] = 0x7, \
+        [R_RT500_CLKCTL1_FRG2CTL] = 0xFFFF, \
+        [R_RT500_CLKCTL1_FC2FCLKSEL] = 0x7, \
+        [R_RT500_CLKCTL1_FRG3CLKSEL] = 0x7, \
+        [R_RT500_CLKCTL1_FRG3CTL] = 0xFFFF, \
+        [R_RT500_CLKCTL1_FC3FCLKSEL] = 0x7, \
+        [R_RT500_CLKCTL1_FRG4CLKSEL] = 0x7, \
+        [R_RT500_CLKCTL1_FRG4CTL] = 0xFFFF, \
+        [R_RT500_CLKCTL1_FC4FCLKSEL] = 0x7, \
+        [R_RT500_CLKCTL1_FRG5CLKSEL] = 0x7, \
+        [R_RT500_CLKCTL1_FRG5CTL] = 0xFFFF, \
+        [R_RT500_CLKCTL1_FC5FCLKSEL] = 0x7, \
+        [R_RT500_CLKCTL1_FRG6CLKSEL] = 0x7, \
+        [R_RT500_CLKCTL1_FRG6CTL] = 0xFFFF, \
+        [R_RT500_CLKCTL1_FC6FCLKSEL] = 0x7, \
+        [R_RT500_CLKCTL1_FRG7CLKSEL] = 0x7, \
+        [R_RT500_CLKCTL1_FRG7CTL] = 0xFFFF, \
+        [R_RT500_CLKCTL1_FC7FCLKSEL] = 0x7, \
+        [R_RT500_CLKCTL1_FRG8CLKSEL] = 0x7, \
+        [R_RT500_CLKCTL1_FRG8CTL] = 0xFFFF, \
+        [R_RT500_CLKCTL1_FC8FCLKSEL] = 0x7, \
+        [R_RT500_CLKCTL1_FRG9CLKSEL] = 0x7, \
+        [R_RT500_CLKCTL1_FRG9CTL] = 0xFFFF, \
+        [R_RT500_CLKCTL1_FC9FCLKSEL] = 0x7, \
+        [R_RT500_CLKCTL1_FRG10CLKSEL] = 0x7, \
+        [R_RT500_CLKCTL1_FRG10CTL] = 0xFFFF, \
+        [R_RT500_CLKCTL1_FC10FCLKSEL] = 0x7, \
+        [R_RT500_CLKCTL1_FRG11CLKSEL] = 0x7, \
+        [R_RT500_CLKCTL1_FRG11CTL] = 0xFFFF, \
+        [R_RT500_CLKCTL1_FC11FCLKSEL] = 0x7, \
+        [R_RT500_CLKCTL1_FRG12CLKSEL] = 0x7, \
+        [R_RT500_CLKCTL1_FRG12CTL] = 0xFFFF, \
+        [R_RT500_CLKCTL1_FC12FCLKSEL] = 0x7, \
+        [R_RT500_CLKCTL1_FRG13CLKSEL] = 0x7, \
+        [R_RT500_CLKCTL1_FRG13CTL] = 0xFFFF, \
+        [R_RT500_CLKCTL1_FC13FCLKSEL] = 0x7, \
+        [R_RT500_CLKCTL1_FRG14CLKSEL] = 0x7, \
+        [R_RT500_CLKCTL1_FRG14CTL] = 0xFFFF, \
+        [R_RT500_CLKCTL1_FC14FCLKSEL] = 0x7, \
+        [R_RT500_CLKCTL1_FRG15CLKSEL] = 0x7, \
+        [R_RT500_CLKCTL1_FRG15CTL] = 0xFFFF, \
+        [R_RT500_CLKCTL1_FC15FCLKSEL] = 0x7, \
+        [R_RT500_CLKCTL1_FRG16CLKSEL] = 0x7, \
+        [R_RT500_CLKCTL1_FRG16CTL] = 0xFFFF, \
+        [R_RT500_CLKCTL1_FC16FCLKSEL] = 0x7, \
+        [R_RT500_CLKCTL1_FRG17CLKSEL] = 0x7, \
+        [R_RT500_CLKCTL1_FRG17CTL] = 0xFFFF, \
+        [R_RT500_CLKCTL1_FLEXIOCLKSEL] = 0x7, \
+        [R_RT500_CLKCTL1_FLEXIOCLKDIV] = 0xE00000FF, \
+        [R_RT500_CLKCTL1_FRGPLLCLKDIV] = 0xE00000FF, \
+        [R_RT500_CLKCTL1_DMIC0FCLKSEL] = 0x7, \
+        [R_RT500_CLKCTL1_DMIC0FCLKDIV] = 0xE00000FF, \
+        [R_RT500_CLKCTL1_CT32BITFCLKSEL0] = 0x7, \
+        [R_RT500_CLKCTL1_CT32BITFCLKSEL1] = 0x7, \
+        [R_RT500_CLKCTL1_CT32BITFCLKSEL2] = 0x7, \
+        [R_RT500_CLKCTL1_CT32BITFCLKSEL3] = 0x7, \
+        [R_RT500_CLKCTL1_CT32BITFCLKSEL4] = 0x7, \
+        [R_RT500_CLKCTL1_AUDIOMCLKSEL] = 0x7, \
+        [R_RT500_CLKCTL1_AUDIOMCLKDIV] = 0xE00000FF, \
+        [R_RT500_CLKCTL1_CLKOUTSEL0] = 0x7, \
+        [R_RT500_CLKCTL1_CLKOUTSEL1] = 0x7, \
+        [R_RT500_CLKCTL1_CLKOUTFCLKDIV] = 0xE00000FF, \
+        [R_RT500_CLKCTL1_I3C01FCLKSEL] = 0x7, \
+        [R_RT500_CLKCTL1_I3C01FCLKSTCSEL] = 0x7, \
+        [R_RT500_CLKCTL1_I3C01FCLKSTCDIV] = 0xE00000FF, \
+        [R_RT500_CLKCTL1_I3C01FCLKSDIV] = 0xE00000FF, \
+        [R_RT500_CLKCTL1_I3C01FCLKDIV] = 0xE00000FF, \
+        [R_RT500_CLKCTL1_I3C01FCLKSTSTCLKSEL] = 0x7, \
+        [R_RT500_CLKCTL1_WDT1FCLKSEL] = 0x7, \
+        [R_RT500_CLKCTL1_ACMP0FCLKSEL] = 0x7, \
+        [R_RT500_CLKCTL1_ACMP0FCLKDIV] = 0xE00000FF, \
+    }
+
+static inline void rt500_clkctl1_reset_registers(uint32_t *regs)
+{
+    regs[R_RT500_CLKCTL1_PSCCTL0] = 0x0;
+    regs[R_RT500_CLKCTL1_PSCCTL1] = 0x0;
+    regs[R_RT500_CLKCTL1_PSCCTL2] = 0x0;
+    regs[R_RT500_CLKCTL1_PSCCTL0_SET] = 0x0;
+    regs[R_RT500_CLKCTL1_PSCCTL1_SET] = 0x0;
+    regs[R_RT500_CLKCTL1_PSCCTL2_SET] = 0x0;
+    regs[R_RT500_CLKCTL1_PSCCTL0_CLR] = 0x0;
+    regs[R_RT500_CLKCTL1_PSCCTL1_CLR] = 0x0;
+    regs[R_RT500_CLKCTL1_PSCCTL2_CLR] = 0x0;
+    regs[R_RT500_CLKCTL1_AUDIOPLL0CLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL1_AUDIOPLL0CTL0] = 0x160002;
+    regs[R_RT500_CLKCTL1_AUDIOPLL0LOCKTIMEDIV2] = 0xcafe;
+    regs[R_RT500_CLKCTL1_AUDIOPLL0NUM] = 0x4dd2f15;
+    regs[R_RT500_CLKCTL1_AUDIOPLL0DENOM] = 0x1fffffdb;
+    regs[R_RT500_CLKCTL1_AUDIOPLL0PFD] = 0x80808080;
+    regs[R_RT500_CLKCTL1_AUDIOPLLCLKDIV] = 0x40000000;
+    regs[R_RT500_CLKCTL1_DSPCPUCLKDIV] = 0x40000000;
+    regs[R_RT500_CLKCTL1_DSPCPUCLKSELA] = 0x0;
+    regs[R_RT500_CLKCTL1_DSPCPUCLKSELB] = 0x0;
+    regs[R_RT500_CLKCTL1_OSEVENTTFCLKSEL] = 0x0;
+    regs[R_RT500_CLKCTL1_FRG0CLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL1_FRG0CTL] = 0xff;
+    regs[R_RT500_CLKCTL1_FC0FCLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL1_FRG1CLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL1_FRG1CTL] = 0xff;
+    regs[R_RT500_CLKCTL1_FC1FCLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL1_FRG2CLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL1_FRG2CTL] = 0xff;
+    regs[R_RT500_CLKCTL1_FC2FCLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL1_FRG3CLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL1_FRG3CTL] = 0xff;
+    regs[R_RT500_CLKCTL1_FC3FCLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL1_FRG4CLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL1_FRG4CTL] = 0xff;
+    regs[R_RT500_CLKCTL1_FC4FCLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL1_FRG5CLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL1_FRG5CTL] = 0xff;
+    regs[R_RT500_CLKCTL1_FC5FCLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL1_FRG6CLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL1_FRG6CTL] = 0xff;
+    regs[R_RT500_CLKCTL1_FC6FCLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL1_FRG7CLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL1_FRG7CTL] = 0xff;
+    regs[R_RT500_CLKCTL1_FC7FCLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL1_FRG8CLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL1_FRG8CTL] = 0xff;
+    regs[R_RT500_CLKCTL1_FC8FCLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL1_FRG9CLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL1_FRG9CTL] = 0xff;
+    regs[R_RT500_CLKCTL1_FC9FCLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL1_FRG10CLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL1_FRG10CTL] = 0xff;
+    regs[R_RT500_CLKCTL1_FC10FCLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL1_FRG11CLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL1_FRG11CTL] = 0xff;
+    regs[R_RT500_CLKCTL1_FC11FCLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL1_FRG12CLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL1_FRG12CTL] = 0xff;
+    regs[R_RT500_CLKCTL1_FC12FCLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL1_FRG13CLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL1_FRG13CTL] = 0xff;
+    regs[R_RT500_CLKCTL1_FC13FCLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL1_FRG14CLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL1_FRG14CTL] = 0xff;
+    regs[R_RT500_CLKCTL1_FC14FCLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL1_FRG15CLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL1_FRG15CTL] = 0xff;
+    regs[R_RT500_CLKCTL1_FC15FCLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL1_FRG16CLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL1_FRG16CTL] = 0xff;
+    regs[R_RT500_CLKCTL1_FC16FCLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL1_FRG17CLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL1_FRG17CTL] = 0xff;
+    regs[R_RT500_CLKCTL1_FLEXIOCLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL1_FLEXIOCLKDIV] = 0x40000000;
+    regs[R_RT500_CLKCTL1_FRGPLLCLKDIV] = 0x40000000;
+    regs[R_RT500_CLKCTL1_DMIC0FCLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL1_DMIC0FCLKDIV] = 0x40000000;
+    regs[R_RT500_CLKCTL1_CT32BITFCLKSEL0] = 0x7;
+    regs[R_RT500_CLKCTL1_CT32BITFCLKSEL1] = 0x7;
+    regs[R_RT500_CLKCTL1_CT32BITFCLKSEL2] = 0x7;
+    regs[R_RT500_CLKCTL1_CT32BITFCLKSEL3] = 0x7;
+    regs[R_RT500_CLKCTL1_CT32BITFCLKSEL4] = 0x7;
+    regs[R_RT500_CLKCTL1_AUDIOMCLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL1_AUDIOMCLKDIV] = 0x40000000;
+    regs[R_RT500_CLKCTL1_CLKOUTSEL0] = 0x7;
+    regs[R_RT500_CLKCTL1_CLKOUTSEL1] = 0x7;
+    regs[R_RT500_CLKCTL1_CLKOUTFCLKDIV] = 0x40000000;
+    regs[R_RT500_CLKCTL1_I3C01FCLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL1_I3C01FCLKSTCSEL] = 0x7;
+    regs[R_RT500_CLKCTL1_I3C01FCLKSTCDIV] = 0x40000000;
+    regs[R_RT500_CLKCTL1_I3C01FCLKSDIV] = 0x40000000;
+    regs[R_RT500_CLKCTL1_I3C01FCLKDIV] = 0x40000000;
+    regs[R_RT500_CLKCTL1_I3C01FCLKSTSTCLKSEL] = 0x0;
+    regs[R_RT500_CLKCTL1_WDT1FCLKSEL] = 0x0;
+    regs[R_RT500_CLKCTL1_ACMP0FCLKSEL] = 0x7;
+    regs[R_RT500_CLKCTL1_ACMP0FCLKDIV] = 0x40000000;
+}
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
index 0000000000..7d4a3f244f
--- /dev/null
+++ b/include/hw/misc/rt500_clkctl0.h
@@ -0,0 +1,37 @@
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
+    /* <private> */
+    SysBusDevice parent_obj;
+
+    /* <public> */
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
index 0000000000..a8da12d95c
--- /dev/null
+++ b/hw/misc/rt500_clkctl0.c
@@ -0,0 +1,226 @@
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
+#include "hw/regs.h"
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
+static RT500_CLKCTL0_REGISTER_NAMES_ARRAY(reg_names);
+
+static MemTxResult rt500_clkctl0_read(void *opaque, hwaddr addr,
+                                      uint64_t *data, unsigned size,
+                                      MemTxAttrs attrs)
+{
+    RT500ClkCtl0State *s = opaque;
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
+    trace_rt500_clkctl0_reg_read(reg_names[addr / 4], addr, *data);
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
+    static RT500_CLKCTL0_REGISTER_WMASK_ARRAY(wmask);
+
+    trace_rt500_clkctl0_reg_write(reg_names[addr / 4], addr, value);
+
+    value &= wmask[addr / 4];
+
+    switch (addr) {
+    case A_RT500_CLKCTL0_PSCCTL0:
+    case A_RT500_CLKCTL0_PSCCTL1:
+    case A_RT500_CLKCTL0_PSCCTL2:
+    {
+        s->regs[addr / 4] = value;
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
+        s->regs[addr / 4] = value;
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
+        .max_access_size = 4,
+        .min_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static void rt500_clkctl0_reset(DeviceState *dev)
+{
+    RT500ClkCtl0State *s = RT500_CLKCTL0(dev);
+
+    memset(s->regs, 0, sizeof(s->regs));
+
+    rt500_clkctl0_reset_registers(s->regs);
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
+static void rt500_clkctl0_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = rt500_clkctl0_reset;
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
index 0000000000..32ee063fb9
--- /dev/null
+++ b/hw/misc/rt500_clkctl1.c
@@ -0,0 +1,207 @@
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
+#include "hw/regs.h"
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
+static RT500_CLKCTL1_REGISTER_NAMES_ARRAY(reg_names);
+
+static MemTxResult rt500_clkctl1_read(void *opaque, hwaddr addr,
+                                      uint64_t *data, unsigned size,
+                                      MemTxAttrs attrs)
+{
+    RT500ClkCtl1State *s = opaque;
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
+    trace_rt500_clkctl1_reg_read(reg_names[addr / 4], addr, *data);
+    return ret;
+}
+
+static MemTxResult rt500_clkctl1_write(void *opaque, hwaddr addr,
+                                       uint64_t value, unsigned size,
+                                       MemTxAttrs attrs)
+{
+    RT500ClkCtl1State *s = opaque;
+
+    trace_rt500_clkctl1_reg_write(reg_names[addr / 4], addr, value);
+
+    switch (addr) {
+    case A_RT500_CLKCTL1_PSCCTL0:
+    case A_RT500_CLKCTL1_PSCCTL1:
+    case A_RT500_CLKCTL1_PSCCTL2:
+    {
+        s->regs[addr / 4] = value;
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
+        s->regs[addr / 4] = value;
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
+        .max_access_size = 4,
+        .min_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static void rt500_clkctl1_reset(DeviceState *dev)
+{
+    RT500ClkCtl1State *s = RT500_CLKCTL1(dev);
+
+    memset(s->regs, 0, sizeof(s->regs));
+
+    rt500_clkctl1_reset_registers(s->regs);
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
+static void rt500_clkctl1_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = rt500_clkctl1_reset;
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
diff --git a/hw/arm/svd/meson.build b/hw/arm/svd/meson.build
index 7f1c847caf..d017010b73 100644
--- a/hw/arm/svd/meson.build
+++ b/hw/arm/svd/meson.build
@@ -13,4 +13,10 @@ if get_option('mcux-soc-svd')
   run_target('svd-flexcomm-spi', command: svd_gen_header +
     [ '-i', rt595, '-o', '@SOURCE_ROOT@/include/hw/arm/svd/flexcomm_spi.h',
       '-p', 'SPI0', '-t', 'FLEXCOMM_SPI'])
+  run_target('svd-rt500-clkctl0', command: svd_gen_header +
+    [ '-i', rt595, '-o', '@SOURCE_ROOT@/include/hw/arm/svd/rt500_clkctl0.h',
+      '-p', 'CLKCTL0', '-t', 'RT500_CLKCTL0'])
+  run_target('svd-rt500-clkctl1', command: svd_gen_header +
+    [ '-i', rt595, '-o', '@SOURCE_ROOT@/include/hw/arm/svd/rt500_clkctl1.h',
+      '-p', 'CLKCTL1', '-t', 'RT500_CLKCTL1'])
 endif
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 14167ae9e8..392ae9e84f 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -216,4 +216,10 @@ config XLNX_VERSAL_TRNG
 config FLEXCOMM
     bool
 
+config RT500_CLKCTL0
+    bool
+
+config RT500_CLKCTL1
+    bool
+
 source macio/Kconfig
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 8414767ae3..68929949a6 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -158,3 +158,5 @@ system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
 system_ss.add(when: 'CONFIG_LASI', if_true: files('lasi.c'))
 
 system_ss.add(when: 'CONFIG_FLEXCOMM', if_true: files('flexcomm.c'))
+system_ss.add(when: 'CONFIG_RT500_CLKCTL0', if_true: files('rt500_clkctl0.c'))
+system_ss.add(when: 'CONFIG_RT500_CLKCTL1', if_true: files('rt500_clkctl1.c'))
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 71ec77de29..e65fcfa613 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -357,3 +357,11 @@ flexcomm_reset(void) ""
 flexcomm_irq(const char *id, uint8_t irq) "%s %d"
 flexcomm_reg_read(const char *devname, const char *regname, uint32_t addr, uint32_t val) "%s: %s[0x%04x] -> 0x%08x"
 flexcomm_reg_write(const char *dename, const char *regname, uint32_t addr, uint32_t val) "%s: %s[0x%04x] <- 0x%08x"
+
+# rt500_clkctl0.c
+rt500_clkctl0_reg_read(const char *regname, uint32_t addr, uint32_t val) "%s[0x%04x] -> 0x%08x"
+rt500_clkctl0_reg_write(const char *regname, uint32_t addr, uint32_t val) "%s[0x%04x] <- 0x%08x"
+
+# rt500_clkctl1.c
+rt500_clkctl1_reg_read(const char *regname, uint32_t addr, uint32_t val) "%s[0x%04x] -> 0x%08x"
+rt500_clkctl1_reg_write(const char *regname, uint32_t addr, uint32_t val) "%s[0x%04x] <- 0x%08x"
-- 
2.46.0.184.g6999bdac58-goog


