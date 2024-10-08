Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA58CED24D
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 01:21:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxytG-0001lq-BO; Mon, 07 Oct 2024 21:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3iogEZwUKCusgNiVcTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--tavip.bounces.google.com>)
 id 1sxysa-0007nM-Nn
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 21:19:17 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3iogEZwUKCusgNiVcTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--tavip.bounces.google.com>)
 id 1sxysX-00008v-Vp
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 21:19:12 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-e28690bc290so7535132276.1
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 18:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1728350347; x=1728955147; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Vzupf3vt9+CjqF4zkzgvZPteAeoMK9Pq2w9EB8vbI+s=;
 b=odlR4mOhxesowE5PMylvU9UJ79+ssGRuruZ3GrwUZkjNrxN3tY1V8IEYghq0EjuQgH
 HNmv+iNkohMwsN8+Q58RZGNHi4TX6Epn4x1n4bvMJlC5aOwk9AGUqfq56yWkMVmJqh3M
 WzU4pHNr0KZLgellApQnOGYxsWHAd8ZrOOsIzWFc51Qa1HsXd+zhvMHFQ9yPCXKnMbA5
 pbrgoTFDVWRGNJBLWO3n4cWxV4x0Lw/qzK8yLFFXrmPOEo81Do8l45mmOj+RHbb6SbAc
 dVaUtiLoOYeqv/h1ru7GGbmExlBz9Wi+ckgayOm92f+uAxnU4AbnNbNv09uGuOwWN6xa
 LrcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728350347; x=1728955147;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vzupf3vt9+CjqF4zkzgvZPteAeoMK9Pq2w9EB8vbI+s=;
 b=g4dQ9aHjRMxTs2FJ98aEZCl7YsJ6Ipx9tcygYO25NTBMHEow5OwCJIFW+jD+iwq79b
 XLYli5/apL92uQ+etdHiZoZzWJXv9zXGPcbb+JX9raAcUiOPVPXLLv3RVU2g2hKD9NdH
 8l/meP4iqh1pTX/+RKvlN2SLLw0wMMj7Y1+RGPZNsQjckVR6iH8FHtKx6Qs0/w29LVEp
 mRmZukAZhj3LhokQS3OGFkjM5e+AgQXSzrGHptdku1AUT7tM84Zu4iwbk9syTptR+YeM
 MvM2HHee6eTnIyeLLGbjFOUkmUtzrfdaPZIH1FtTwtZ+ubufP2GTfo20FARScVo70Upw
 cFYg==
X-Gm-Message-State: AOJu0Yw3XhfqXl0DdEMsw3O5CTtTWa9rIrQ1CZqdlunBFpRjVdKaA6GP
 EtZRxOajWZ0Q7oFQagiJoHsOvbGOcnR0gOW1tklqbD4IgfY2rljwdGHFup/WsmeDhuWSXgL3294
 r4gRQUkHpp5hrsDX0KgeDYmJ54/GinIWZBhH7Bhidw/ikfzw5fNA1e3u+ke+lCSEfA1Et7mLoJ9
 ePebs3H8CrLLhQTsVk67m70aFI1Q==
X-Google-Smtp-Source: AGHT+IF8b+KwDkEfdHpiw3avdhoIJWRKXiRbTxfcFuMGtw+4XiGc6GeHNYWj3ZNVznRFO2FNXD2xTlVYVw==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a25:6b4b:0:b0:e1a:44fa:f09 with
 SMTP id
 3f1490d57ef6-e28936c0e5amr9284276.2.1728350346664; Mon, 07 Oct 2024 18:19:06
 -0700 (PDT)
Date: Mon,  7 Oct 2024 18:18:33 -0700
In-Reply-To: <20241008011852.1439154-1-tavip@google.com>
Mime-Version: 1.0
References: <20241008011852.1439154-1-tavip@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241008011852.1439154-8-tavip@google.com>
Subject: [PATCH v2 07/25] hw/char: add support for flexcomm usart
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr, 
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org, jsnow@redhat.com, 
 crosa@redhat.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3iogEZwUKCusgNiVcTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--tavip.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
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

Add support for NXP's flexcomm usart. It supports interupts and FIFO
access but no DMA.

The patch includes an automatically generated header which contains
the register layout and helpers.

The header can be regenerated with the svd-flexcomm-usart target when
the build is configured with --enable-mcux-soc-svd.

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 include/hw/arm/svd/flexcomm_usart.h | 294 ++++++++++++++++++++++++++++
 include/hw/char/flexcomm_usart.h    |  33 ++++
 include/hw/misc/flexcomm.h          |   2 +
 hw/char/flexcomm_usart.c            | 288 +++++++++++++++++++++++++++
 hw/misc/flexcomm.c                  |   3 +
 hw/arm/svd/meson.build              |   4 +
 hw/char/meson.build                 |   1 +
 hw/char/trace-events                |   8 +
 8 files changed, 633 insertions(+)
 create mode 100644 include/hw/arm/svd/flexcomm_usart.h
 create mode 100644 include/hw/char/flexcomm_usart.h
 create mode 100644 hw/char/flexcomm_usart.c

diff --git a/include/hw/arm/svd/flexcomm_usart.h b/include/hw/arm/svd/flexcomm_usart.h
new file mode 100644
index 0000000000..a226917182
--- /dev/null
+++ b/include/hw/arm/svd/flexcomm_usart.h
@@ -0,0 +1,294 @@
+/*
+ * Copyright 2016-2023 NXP SPDX-License-Identifier: BSD-3-Clause
+ *
+ * Automatically generated by svd-gen-header.py from MIMXRT595S_cm33.xml
+ */
+#pragma once
+
+#include "hw/register.h"
+
+/* Flexcomm USART */
+#define FLEXCOMM_USART_REGS_NO (1024)
+
+/* USART Configuration */
+REG32(FLEXCOMM_USART_CFG, 0x0);
+/* USART Enable */
+FIELD(FLEXCOMM_USART_CFG, ENABLE, 0, 1);
+
+/* USART Control */
+REG32(FLEXCOMM_USART_CTL, 0x4);
+
+/* USART Status */
+REG32(FLEXCOMM_USART_STAT, 0x8);
+
+/* Interrupt Enable Read and Set for USART (not FIFO) Status */
+REG32(FLEXCOMM_USART_INTENSET, 0xC);
+
+/* Interrupt Enable Clear */
+REG32(FLEXCOMM_USART_INTENCLR, 0x10);
+
+/* Baud Rate Generator */
+REG32(FLEXCOMM_USART_BRG, 0x20);
+
+/* Interrupt Status */
+REG32(FLEXCOMM_USART_INTSTAT, 0x24);
+
+/* Oversample Selection Register for Asynchronous Communication */
+REG32(FLEXCOMM_USART_OSR, 0x28);
+
+/* Address Register for Automatic Address Matching */
+REG32(FLEXCOMM_USART_ADDR, 0x2C);
+
+/* FIFO Configuration */
+REG32(FLEXCOMM_USART_FIFOCFG, 0xE00);
+/* Enable the Transmit FIFO. */
+FIELD(FLEXCOMM_USART_FIFOCFG, ENABLETX, 0, 1);
+/* Enable the Receive FIFO */
+FIELD(FLEXCOMM_USART_FIFOCFG, ENABLERX, 1, 1);
+/* Empty Command for the Transmit FIFO */
+FIELD(FLEXCOMM_USART_FIFOCFG, EMPTYTX, 16, 1);
+/* Empty Command for the Receive FIFO */
+FIELD(FLEXCOMM_USART_FIFOCFG, EMPTYRX, 17, 1);
+
+/* FIFO Status */
+REG32(FLEXCOMM_USART_FIFOSTAT, 0xE04);
+/* TX FIFO Error */
+FIELD(FLEXCOMM_USART_FIFOSTAT, TXERR, 0, 1);
+/* RX FIFO Error */
+FIELD(FLEXCOMM_USART_FIFOSTAT, RXERR, 1, 1);
+/* Peripheral Interrupt */
+FIELD(FLEXCOMM_USART_FIFOSTAT, PERINT, 3, 1);
+/* Transmit FIFO Empty */
+FIELD(FLEXCOMM_USART_FIFOSTAT, TXEMPTY, 4, 1);
+/* Transmit FIFO is Not Full */
+FIELD(FLEXCOMM_USART_FIFOSTAT, TXNOTFULL, 5, 1);
+/* Receive FIFO is Not Empty */
+FIELD(FLEXCOMM_USART_FIFOSTAT, RXNOTEMPTY, 6, 1);
+/* Receive FIFO is Full */
+FIELD(FLEXCOMM_USART_FIFOSTAT, RXFULL, 7, 1);
+/* Transmit FIFO Current Level */
+FIELD(FLEXCOMM_USART_FIFOSTAT, TXLVL, 8, 5);
+/* Receive FIFO Current Level */
+FIELD(FLEXCOMM_USART_FIFOSTAT, RXLVL, 16, 5);
+
+/* FIFO Trigger Settings for Interrupt and DMA Request */
+REG32(FLEXCOMM_USART_FIFOTRIG, 0xE08);
+/* Transmit FIFO Level Trigger Enable. */
+FIELD(FLEXCOMM_USART_FIFOTRIG, TXLVLENA, 0, 1);
+/* Receive FIFO Level Trigger Enable */
+FIELD(FLEXCOMM_USART_FIFOTRIG, RXLVLENA, 1, 1);
+/* Transmit FIFO Level Trigger Point */
+FIELD(FLEXCOMM_USART_FIFOTRIG, TXLVL, 8, 4);
+/* Trigger when the TX FIFO becomes empty */
+#define FLEXCOMM_USART_FIFOTRIG_TXLVL_TXLVL0 0
+/* Trigger when the TX FIFO level decreases to 1 entry */
+#define FLEXCOMM_USART_FIFOTRIG_TXLVL_TXLVL1 1
+/* Trigger when the TX FIFO level decreases to 15 entries (is no longer full) */
+#define FLEXCOMM_USART_FIFOTRIG_TXLVL_TXLVL15 15
+/* Receive FIFO Level Trigger Point */
+FIELD(FLEXCOMM_USART_FIFOTRIG, RXLVL, 16, 4);
+/* Trigger when the RX FIFO has received 1 entry (is no longer empty) */
+#define FLEXCOMM_USART_FIFOTRIG_RXLVL_RXLVL1 0
+/* Trigger when the RX FIFO has received 2 entries */
+#define FLEXCOMM_USART_FIFOTRIG_RXLVL_RXLVL2 1
+/* Trigger when the RX FIFO has received 16 entries (has become full) */
+#define FLEXCOMM_USART_FIFOTRIG_RXLVL_RXLVL15 15
+
+/* FIFO Interrupt Enable */
+REG32(FLEXCOMM_USART_FIFOINTENSET, 0xE10);
+/* Transmit Error Interrupt Enable */
+FIELD(FLEXCOMM_USART_FIFOINTENSET, TXERR, 0, 1);
+/* Receive Error Interrupt Enable */
+FIELD(FLEXCOMM_USART_FIFOINTENSET, RXERR, 1, 1);
+/* Transmit FIFO Level Interrupt Enable */
+FIELD(FLEXCOMM_USART_FIFOINTENSET, TXLVL, 2, 1);
+/* Receive FIFO Level Interrupt Enable */
+FIELD(FLEXCOMM_USART_FIFOINTENSET, RXLVL, 3, 1);
+
+/* FIFO Interrupt Enable Clear */
+REG32(FLEXCOMM_USART_FIFOINTENCLR, 0xE14);
+/* Transmit Error Interrupt Enable */
+FIELD(FLEXCOMM_USART_FIFOINTENCLR, TXERR, 0, 1);
+/* Receive Error Interrupt Enable */
+FIELD(FLEXCOMM_USART_FIFOINTENCLR, RXERR, 1, 1);
+/* Transmit FIFO Level Interrupt Enable */
+FIELD(FLEXCOMM_USART_FIFOINTENCLR, TXLVL, 2, 1);
+/* Receive FIFO Level Interrupt Enable */
+FIELD(FLEXCOMM_USART_FIFOINTENCLR, RXLVL, 3, 1);
+
+/* FIFO Interrupt Status */
+REG32(FLEXCOMM_USART_FIFOINTSTAT, 0xE18);
+/* TX FIFO Error Interrupt Status */
+FIELD(FLEXCOMM_USART_FIFOINTSTAT, TXERR, 0, 1);
+/* RX FIFO Error Interrupt Status */
+FIELD(FLEXCOMM_USART_FIFOINTSTAT, RXERR, 1, 1);
+/* Transmit FIFO Level Interrupt Status */
+FIELD(FLEXCOMM_USART_FIFOINTSTAT, TXLVL, 2, 1);
+/* Receive FIFO Level Interrupt Status */
+FIELD(FLEXCOMM_USART_FIFOINTSTAT, RXLVL, 3, 1);
+/* Peripheral Interrupt Status */
+FIELD(FLEXCOMM_USART_FIFOINTSTAT, PERINT, 4, 1);
+
+/* FIFO Write Data */
+REG32(FLEXCOMM_USART_FIFOWR, 0xE20);
+/* Transmit data to the FIFO */
+FIELD(FLEXCOMM_USART_FIFOWR, TXDATA, 0, 9);
+
+/* FIFO Read Data */
+REG32(FLEXCOMM_USART_FIFORD, 0xE30);
+/* Received Data from the FIFO */
+FIELD(FLEXCOMM_USART_FIFORD, RXDATA, 0, 9);
+/* Framing Error Status Flag */
+FIELD(FLEXCOMM_USART_FIFORD, FRAMERR, 13, 1);
+/* Parity Error Status Flag */
+FIELD(FLEXCOMM_USART_FIFORD, PARITYERR, 14, 1);
+/* Received Noise Flag */
+FIELD(FLEXCOMM_USART_FIFORD, RXNOISE, 15, 1);
+
+/* FIFO Data Read with No FIFO Pop */
+REG32(FLEXCOMM_USART_FIFORDNOPOP, 0xE40);
+/* Received Data from the FIFO */
+FIELD(FLEXCOMM_USART_FIFORDNOPOP, RXDATA, 0, 9);
+/* Framing Error Status Flag */
+FIELD(FLEXCOMM_USART_FIFORDNOPOP, FRAMERR, 13, 1);
+/* Parity Error Status Flag */
+FIELD(FLEXCOMM_USART_FIFORDNOPOP, PARITYERR, 14, 1);
+/* Received Noise Flag */
+FIELD(FLEXCOMM_USART_FIFORDNOPOP, RXNOISE, 15, 1);
+
+/* FIFO Size */
+REG32(FLEXCOMM_USART_FIFOSIZE, 0xE48);
+/* FIFO Size */
+FIELD(FLEXCOMM_USART_FIFOSIZE, FIFOSIZE, 0, 5);
+
+/* Peripheral Identification */
+REG32(FLEXCOMM_USART_ID, 0xFFC);
+
+
+#define FLEXCOMM_USART_REGISTER_ACCESS_INFO_ARRAY(_name) \
+    struct RegisterAccessInfo _name[FLEXCOMM_USART_REGS_NO] = { \
+        [0 ... FLEXCOMM_USART_REGS_NO - 1] = { \
+            .name = "", \
+            .addr = -1, \
+        }, \
+        [0x0] = { \
+            .name = "CFG", \
+            .addr = 0x0, \
+            .ro = 0xFF032402, \
+            .reset = 0x0, \
+        }, \
+        [0x1] = { \
+            .name = "CTL", \
+            .addr = 0x4, \
+            .ro = 0xFFFEFCB9, \
+            .reset = 0x0, \
+        }, \
+        [0x2] = { \
+            .name = "STAT", \
+            .addr = 0x8, \
+            .ro = 0xFFFE07DF, \
+            .reset = 0xA, \
+        }, \
+        [0x3] = { \
+            .name = "INTENSET", \
+            .addr = 0xC, \
+            .ro = 0xFFFE0797, \
+            .reset = 0x0, \
+        }, \
+        [0x4] = { \
+            .name = "INTENCLR", \
+            .addr = 0x10, \
+            .ro = 0xFFFE0797, \
+            .reset = 0x0, \
+        }, \
+        [0x8] = { \
+            .name = "BRG", \
+            .addr = 0x20, \
+            .ro = 0xFFFF0000, \
+            .reset = 0x0, \
+        }, \
+        [0x9] = { \
+            .name = "INTSTAT", \
+            .addr = 0x24, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [0xA] = { \
+            .name = "OSR", \
+            .addr = 0x28, \
+            .ro = 0xFFFFFFF0, \
+            .reset = 0xF, \
+        }, \
+        [0xB] = { \
+            .name = "ADDR", \
+            .addr = 0x2C, \
+            .ro = 0xFFFFFF00, \
+            .reset = 0x0, \
+        }, \
+        [0x380] = { \
+            .name = "FIFOCFG", \
+            .addr = 0xE00, \
+            .ro = 0xFFF80FFC, \
+            .reset = 0x0, \
+        }, \
+        [0x381] = { \
+            .name = "FIFOSTAT", \
+            .addr = 0xE04, \
+            .ro = 0xFFFFFFFC, \
+            .reset = 0x30, \
+        }, \
+        [0x382] = { \
+            .name = "FIFOTRIG", \
+            .addr = 0xE08, \
+            .ro = 0xFFF0F0FC, \
+            .reset = 0x0, \
+        }, \
+        [0x384] = { \
+            .name = "FIFOINTENSET", \
+            .addr = 0xE10, \
+            .ro = 0xFFFFFFF0, \
+            .reset = 0x0, \
+        }, \
+        [0x385] = { \
+            .name = "FIFOINTENCLR", \
+            .addr = 0xE14, \
+            .ro = 0xFFFFFFF0, \
+            .reset = 0x0, \
+        }, \
+        [0x386] = { \
+            .name = "FIFOINTSTAT", \
+            .addr = 0xE18, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [0x388] = { \
+            .name = "FIFOWR", \
+            .addr = 0xE20, \
+            .ro = 0xFFFFFE00, \
+            .reset = 0x0, \
+        }, \
+        [0x38C] = { \
+            .name = "FIFORD", \
+            .addr = 0xE30, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [0x390] = { \
+            .name = "FIFORDNOPOP", \
+            .addr = 0xE40, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [0x392] = { \
+            .name = "FIFOSIZE", \
+            .addr = 0xE48, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x10, \
+        }, \
+        [0x3FF] = { \
+            .name = "ID", \
+            .addr = 0xFFC, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0xE0102100, \
+        }, \
+    }
diff --git a/include/hw/char/flexcomm_usart.h b/include/hw/char/flexcomm_usart.h
new file mode 100644
index 0000000000..e67b15208f
--- /dev/null
+++ b/include/hw/char/flexcomm_usart.h
@@ -0,0 +1,33 @@
+/*
+ * QEMU model for NXP's FLEXCOMM USART
+ *
+ * Copyright (c) 2024 Google LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_FLEXCOMM_USART_H
+#define HW_FLEXCOMM_USART_H
+
+#include "hw/misc/flexcomm_function.h"
+#include "chardev/char-fe.h"
+
+#define TYPE_FLEXCOMM_USART "flexcomm-usart"
+OBJECT_DECLARE_TYPE(FlexcommUsartState, FlexcommUsartClass, FLEXCOMM_USART);
+
+struct FlexcommUsartState {
+    FlexcommFunction parent_obj;
+
+    CharBackend chr;
+};
+
+struct FlexcommUsartClass {
+    FlexcommFunctionClass parent_obj;
+
+    FlexcommFunctionSelect select;
+};
+
+#endif /* HW_FLEXCOMM_USART_H */
diff --git a/include/hw/misc/flexcomm.h b/include/hw/misc/flexcomm.h
index 832d4cd29d..679b7ea64d 100644
--- a/include/hw/misc/flexcomm.h
+++ b/include/hw/misc/flexcomm.h
@@ -15,6 +15,7 @@
 #include "hw/sysbus.h"
 #include "hw/arm/svd/flexcomm.h"
 #include "qemu/fifo32.h"
+#include "hw/char/flexcomm_usart.h"
 
 #define FLEXCOMM_FUNC_USART     0
 #define FLEXCOMM_FUNC_SPI       1
@@ -46,6 +47,7 @@ struct FlexcommState {
     bool irq_state;
     Fifo32 rx_fifo;
     Fifo32 tx_fifo;
+    FlexcommUsartState usart;
 };
 
 #endif /* HW_FLEXCOMM_H */
diff --git a/hw/char/flexcomm_usart.c b/hw/char/flexcomm_usart.c
new file mode 100644
index 0000000000..53ab5d8379
--- /dev/null
+++ b/hw/char/flexcomm_usart.c
@@ -0,0 +1,288 @@
+/*
+ * QEMU model for NXP's FLEXCOMM USART
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
+#include "qemu/cutils.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "exec/address-spaces.h"
+#include "qapi/error.h"
+#include "trace.h"
+#include "hw/misc/flexcomm.h"
+#include "hw/char/flexcomm_usart.h"
+#include "hw/arm/svd/flexcomm_usart.h"
+
+#define REG(s, reg) (s->regs[R_FLEXCOMM_USART_##reg])
+/* register field write helper macro */
+#define RF_RD(s, reg, field, val) \
+    ARRAY_FIELD_DP32(s->regs, FLEXCOMM_USART_##reg, field, val)
+/* register field read helper macro */
+#define RF_WR(s, reg, field) \
+    ARRAY_FIELD_EX32(s->regs, FLEXCOMM_USART_##reg, field)
+
+static FLEXCOMM_USART_REGISTER_ACCESS_INFO_ARRAY(reg_info);
+
+static void flexcomm_usart_reset(FlexcommFunction *f)
+{
+    for (int i = 0; i < FLEXCOMM_USART_REGS_NO; i++) {
+        hwaddr addr = reg_info[i].addr;
+
+        if (addr != -1) {
+            struct RegisterInfo ri = {
+                .data = &f->regs[addr / 4],
+                .data_size = 4,
+                .access = &reg_info[i],
+            };
+
+            register_reset(&ri);
+        }
+    }
+}
+
+static void flexcomm_usart_irq_update(FlexcommFunction *f)
+{
+    bool irq, per_irqs, fifo_irqs, enabled = RF_WR(f, CFG, ENABLE);
+
+    flexcomm_update_fifostat(f);
+    fifo_irqs = REG(f, FIFOINTSTAT) & REG(f, FIFOINTENSET);
+
+    REG(f, INTSTAT) = REG(f, STAT) & REG(f, INTENSET);
+    per_irqs = REG(f, INTSTAT) != 0;
+
+    irq = enabled && (fifo_irqs || per_irqs);
+
+    trace_flexcomm_usart_irq(DEVICE(f)->id, irq, fifo_irqs, per_irqs, enabled);
+    flexcomm_set_irq(f, irq);
+}
+
+static int flexcomm_usart_rx_space(void *opaque)
+{
+    FlexcommUsartState *s = FLEXCOMM_USART(opaque);
+    FlexcommFunction *f = FLEXCOMM_FUNCTION(opaque);
+
+    uint32_t ret = fifo32_num_free(f->rx_fifo);
+
+    if (!RF_WR(f, CFG, ENABLE) || !RF_WR(f, FIFOCFG, ENABLERX)) {
+        ret = 0;
+    }
+
+    trace_flexcomm_usart_rx_space(DEVICE(s)->id, ret);
+
+    return ret;
+}
+
+static void flexcomm_usart_rx(void *opaque, const uint8_t *buf, int size)
+{
+    FlexcommFunction *f = FLEXCOMM_FUNCTION(opaque);
+
+    if (!RF_WR(f, CFG, ENABLE) || !RF_WR(f, FIFOCFG, ENABLERX)) {
+        return;
+    }
+
+    trace_flexcomm_usart_rx(DEVICE(f)->id);
+
+    while (!fifo32_is_full(f->rx_fifo) && size) {
+        fifo32_push(f->rx_fifo, *buf++);
+        size--;
+    }
+
+    flexcomm_usart_irq_update(f);
+}
+
+static MemTxResult flexcomm_usart_reg_read(void *opaque, hwaddr addr,
+                                           uint64_t *data, unsigned size,
+                                           MemTxAttrs attrs)
+{
+    FlexcommFunction *f = FLEXCOMM_FUNCTION(opaque);
+    FlexcommUsartState *s = FLEXCOMM_USART(opaque);
+    const struct RegisterAccessInfo *rai = &reg_info[addr / 4];
+    MemTxResult ret = MEMTX_OK;
+
+    if (size != 4) {
+        ret = MEMTX_ERROR;
+        goto out;
+    }
+
+    switch (addr) {
+    case A_FLEXCOMM_USART_FIFORD:
+    {
+        if (!fifo32_is_empty(f->rx_fifo)) {
+            *data = fifo32_pop(f->rx_fifo);
+            qemu_chr_fe_accept_input(&s->chr);
+        }
+        break;
+    }
+    case A_FLEXCOMM_USART_FIFORDNOPOP:
+    {
+        if (!fifo32_is_empty(f->rx_fifo)) {
+            *data = fifo32_peek(f->rx_fifo);
+        }
+        break;
+    }
+    default:
+        *data = f->regs[addr / 4];
+        break;
+    }
+
+    flexcomm_usart_irq_update(f);
+
+out:
+    trace_flexcomm_usart_reg_read(DEVICE(f)->id, rai->name, addr, *data);
+    return ret;
+}
+
+static MemTxResult flexcomm_usart_reg_write(void *opaque, hwaddr addr,
+                                            uint64_t value, unsigned size,
+                                            MemTxAttrs attrs)
+{
+    FlexcommFunction *f = FLEXCOMM_FUNCTION(opaque);
+    FlexcommUsartState *s = FLEXCOMM_USART(opaque);
+    const struct RegisterAccessInfo *rai = &reg_info[addr / 4];
+    struct RegisterInfo ri = {
+        .data = &f->regs[addr / 4],
+        .data_size = 4,
+        .access = rai,
+    };
+
+    trace_flexcomm_usart_reg_write(DEVICE(f)->id, rai->name, addr, value);
+
+    switch (addr) {
+    case A_FLEXCOMM_USART_INTENCLR:
+    {
+        register_write(&ri, value, ~0, NULL, false);
+        REG(f, INTENSET) &= ~REG(f, INTENCLR);
+        break;
+    }
+    case A_FLEXCOMM_USART_FIFOCFG:
+    {
+        register_write(&ri, value, ~0, NULL, false);
+        flexcomm_reset_fifos(f);
+        break;
+    }
+    case A_FLEXCOMM_USART_FIFOSTAT:
+    {
+        flexcomm_clear_fifostat(f, value);
+        break;
+    }
+    case A_FLEXCOMM_USART_FIFOINTENSET:
+    {
+        REG(f, FIFOINTENSET) |= value;
+        break;
+    }
+    case A_FLEXCOMM_USART_FIFOINTENCLR:
+    {
+        register_write(&ri, value, ~0, NULL, false);
+        REG(f, FIFOINTENSET) &= ~value;
+        break;
+    }
+    case A_FLEXCOMM_USART_FIFOWR:
+    {
+        register_write(&ri, value, ~0, NULL, false);
+
+        if (!fifo32_is_full(f->tx_fifo)) {
+            fifo32_push(f->tx_fifo, REG(f, FIFOWR));
+        }
+
+        if (!RF_WR(f, CFG, ENABLE) || !RF_WR(f, FIFOCFG, ENABLETX)) {
+            break;
+        }
+
+        while (!fifo32_is_empty(f->tx_fifo)) {
+            uint32_t val32 = fifo32_pop(f->tx_fifo);
+            uint8_t val8 = val32 & 0xff;
+
+            trace_flexcomm_usart_tx(DEVICE(f)->id);
+            qemu_chr_fe_write_all(&s->chr, &val8, sizeof(val8));
+        }
+        break;
+    }
+    case A_FLEXCOMM_USART_CFG:
+    {
+        register_write(&ri, value, ~0, NULL, false);
+        break;
+    }
+    default:
+        register_write(&ri, value, ~0, NULL, false);
+        break;
+    }
+
+    flexcomm_usart_irq_update(f);
+
+    return MEMTX_OK;
+}
+
+static void flexcomm_usart_select(FlexcommFunction *f, bool selected)
+{
+    FlexcommUsartState *s = FLEXCOMM_USART(f);
+    FlexcommUsartClass *uc = FLEXCOMM_USART_GET_CLASS(f);
+
+    if (selected) {
+        qemu_chr_fe_set_handlers(&s->chr, flexcomm_usart_rx_space,
+                             flexcomm_usart_rx, NULL, NULL,
+                             s, NULL, true);
+        flexcomm_usart_reset(f);
+    } else {
+        qemu_chr_fe_set_handlers(&s->chr, NULL, NULL, NULL, NULL, NULL, NULL,
+                                 false);
+    }
+    uc->select(f, selected);
+}
+
+static const MemoryRegionOps flexcomm_usart_ops = {
+    .read_with_attrs = flexcomm_usart_reg_read,
+    .write_with_attrs = flexcomm_usart_reg_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static Property flexcomm_usart_properties[] = {
+    DEFINE_PROP_CHR("chardev", FlexcommUsartState, chr),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void flexcomm_usart_realize(DeviceState *dev, Error **errp)
+{
+    qdev_prop_set_chr(dev, "chardev", qemu_chr_find(dev->id));
+}
+
+static void flexcomm_usart_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    FlexcommFunctionClass *fc = FLEXCOMM_FUNCTION_CLASS(klass);
+    FlexcommUsartClass *uc = FLEXCOMM_USART_CLASS(klass);
+
+    device_class_set_props(dc, flexcomm_usart_properties);
+    dc->realize = flexcomm_usart_realize;
+    uc->select = fc->select;
+    fc->select = flexcomm_usart_select;
+    fc->name = "usart";
+    fc->has_fifos = true;
+    fc->mmio_ops = &flexcomm_usart_ops;
+}
+
+static const TypeInfo flexcomm_usart_types[] = {
+    {
+        .name          = TYPE_FLEXCOMM_USART,
+        .parent        = TYPE_FLEXCOMM_FUNCTION,
+        .instance_size = sizeof(FlexcommUsartState),
+        .class_init    = flexcomm_usart_class_init,
+        .class_size    = sizeof(FlexcommUsartClass),
+    },
+};
+
+DEFINE_TYPES(flexcomm_usart_types);
diff --git a/hw/misc/flexcomm.c b/hw/misc/flexcomm.c
index a98d8845aa..a291148f27 100644
--- a/hw/misc/flexcomm.c
+++ b/hw/misc/flexcomm.c
@@ -23,6 +23,7 @@
 #include "migration/vmstate.h"
 #include "hw/misc/flexcomm.h"
 #include "hw/arm/svd/flexcomm_usart.h"
+#include "hw/char/flexcomm_usart.h"
 
 #define REG(s, reg) (s->regs[R_FLEXCOMM_##reg])
 #define RF_WR(s, reg, field, val) \
@@ -218,6 +219,7 @@ static void flexcomm_init(Object *obj)
                           TYPE_FLEXCOMM, sizeof(s->regs));
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->container);
     sysbus_init_irq(sbd, &s->irq);
+    object_initialize_child(obj, "usart", &s->usart, TYPE_FLEXCOMM_USART);
 }
 
 static void flexcomm_finalize(Object *obj)
@@ -247,6 +249,7 @@ static void flexcomm_realize(DeviceState *dev, Error **errp)
     FlexcommState *s = FLEXCOMM(dev);
 
     memory_region_add_subregion_overlap(&s->container, 0, &s->mmio, -1);
+    flexcomm_func_realize_and_unref(FLEXCOMM_FUNCTION(&s->usart), errp);
 }
 
 static const VMStateDescription vmstate_flexcomm = {
diff --git a/hw/arm/svd/meson.build b/hw/arm/svd/meson.build
index 4b0bbbbbdc..3bff90bcbd 100644
--- a/hw/arm/svd/meson.build
+++ b/hw/arm/svd/meson.build
@@ -4,4 +4,8 @@ if get_option('mcux-soc-svd')
   run_target('svd-flexcomm', command: svd_gen_header +
     [ '-i', rt595, '-o', '@SOURCE_ROOT@/include/hw/arm/svd/flexcomm.h',
     '-p', 'FLEXCOMM0', '-t', 'FLEXCOMM'])
+  run_target('svd-flexcomm-usart', command: svd_gen_header +
+    [ '-i', rt595, '-o', '@SOURCE_ROOT@/include/hw/arm/svd/flexcomm_usart.h',
+     '-p', 'USART0', '-t', 'FLEXCOMM_USART',
+     '--fields', 'CFG:ENABLE FIFOCFG:ENABLE*,EMPTY* FIFO*:* *:'])
 endif
diff --git a/hw/char/meson.build b/hw/char/meson.build
index 1750834385..5c6aaf8309 100644
--- a/hw/char/meson.build
+++ b/hw/char/meson.build
@@ -39,3 +39,4 @@ system_ss.add(when: 'CONFIG_GOLDFISH_TTY', if_true: files('goldfish_tty.c'))
 specific_ss.add(when: 'CONFIG_TERMINAL3270', if_true: files('terminal3270.c'))
 specific_ss.add(when: 'CONFIG_VIRTIO', if_true: files('virtio-serial-bus.c'))
 specific_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr_vty.c'))
+system_ss.add(when: 'CONFIG_FLEXCOMM', if_true: files('flexcomm_usart.c'))
diff --git a/hw/char/trace-events b/hw/char/trace-events
index 59e1f734a7..578551b388 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -125,3 +125,11 @@ xen_console_unrealize(unsigned int idx) "idx %u"
 xen_console_realize(unsigned int idx, const char *chrdev) "idx %u chrdev %s"
 xen_console_device_create(unsigned int idx) "idx %u"
 xen_console_device_destroy(unsigned int idx) "idx %u"
+
+# flexcomm_usart.c
+flexcomm_usart_reg_read(const char *id, const char *reg_name, uint32_t addr, uint32_t val) " %s: %s[0x%04x] -> 0x%08x"
+flexcomm_usart_reg_write(const char *id, const char *reg_name, uint32_t addr, uint32_t val) "%s: %s[0x%04x] <- 0x%08x"
+flexcomm_usart_rx_space(const char *id, uint32_t rx) "%s: %d"
+flexcomm_usart_rx(const char *id) "%s"
+flexcomm_usart_tx(const char *id) "%s"
+flexcomm_usart_irq(const char *id, bool irq, bool fifoirqs, bool perirqs, bool enabled) "%s: %d %d %d %d"
-- 
2.47.0.rc0.187.ge670bccf7e-goog


