Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82115CDD553
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 19:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr0Gr-0004zj-2J; Wed, 18 Sep 2024 15:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3nCjrZgUKCtcM3OBI9HH9E7.5HFJ7FN-67O7EGHG9GN.HK9@flex--tavip.bounces.google.com>)
 id 1sr0Gi-0004ZO-3X
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 15:23:18 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3nCjrZgUKCtcM3OBI9HH9E7.5HFJ7FN-67O7EGHG9GN.HK9@flex--tavip.bounces.google.com>)
 id 1sr0Gd-0007KQ-Mm
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 15:23:15 -0400
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-e03623b24ddso329410276.1
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 12:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1726687390; x=1727292190; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=xmpqpcBa8Qo/XngN2ic3QcHcQRbwoEZX18IKXPSjlUw=;
 b=Yf4IFczGgsfLjPsn1XJIQ5o7wT6aqwD9d/WlQJaxlAQmsJM6z8XM9Hv45YrUUe4ocw
 YofgT3OvMIWlX7DBhxsj+e641abRT3GZKhnK6zluge3zOYZFaCwgaxEUjqGWTOikhlu8
 HWSc8RqkVFngRELkrTF17UyGeL0bo7oPeV3xKel90LwPQmGAN0b/hziTiO/4LmXlQpJn
 B3yOtBJsDhNmNeQO5t9jmCtqVlY9tROFlNTRJYOqywG5vGuJdHR9RGZh8Vvwe95yPjSk
 lneVzQWEpvo2q/rfoTP092G8RXrqi52XfpDf5KugmzLXCFAsGy+HVD6pVYz7eRbSFxNK
 nO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726687390; x=1727292190;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xmpqpcBa8Qo/XngN2ic3QcHcQRbwoEZX18IKXPSjlUw=;
 b=V0S0umDjLvHByqSaMCte3pvmFI5Vz72mEZO42OXKdpSrqQND5zh0dRH6FjKATkwZHy
 xD5lZC+sJpc2b0L0VAKvHcKMZr57e90qyv6FSEYqFe+RrWwufPseAgTrspCBa+fq1oWC
 57vA8+HdB1tRbpPSmVLTDaWZNYCZPsXPfCrvaeHTgmAwfW2colnY5Ex52BSuzpIBeP6q
 5Xwb7MsnXT8kLQTl3VthO5LT7ftYc9i8yQyA+8CtZKyQPuzLij3bOPnMI+uUx1FVGVWP
 s8bnbW+cv/5stwuwf8KdquMjHdTUzEzuI0w0f+akjDJ4Try9v+QmmGzEIKQvxBj4rJNW
 046w==
X-Gm-Message-State: AOJu0YyIsyML32EWS9Eo/aLRVbz8y+rS3QOHdIKiAI63zJb8PvLzQEXK
 tQvQXSWHMXZZPeV/Qn6obfmd3ofj+z7L6i1F4n3lqIhOAXn/jyHmvwNprcazCdqkA/dzr7Zbi8l
 UqXlOpO33BcN5OX2Lno7/Ce41DJeZuqwweNyG/3+/t/6v9WBz40qJ8NDHSA13PaVnsE3tUaYNw1
 kDX7YHFAtB6C8ICn4YNqK0QN7ncw==
X-Google-Smtp-Source: AGHT+IG/J21RX/4/rBb4vBdHgWjpP6SzuffZf3BdvxIoPfXuti3VGlLSwLiah7sDKGdGmUrVesPlc6mFGQ==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a25:8709:0:b0:e1f:eaf1:2254 with
 SMTP id
 3f1490d57ef6-e1feaf12aa2mr24348276.8.1726687388992; Wed, 18 Sep 2024 12:23:08
 -0700 (PDT)
Date: Wed, 18 Sep 2024 12:22:35 -0700
In-Reply-To: <20240918192254.3136903-1-tavip@google.com>
Mime-Version: 1.0
References: <20240918192254.3136903-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Message-ID: <20240918192254.3136903-8-tavip@google.com>
Subject: [PATCH 07/25] hw/char: add support for flexcomm usart
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr, 
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org, jsnow@redhat.com, 
 crosa@redhat.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3nCjrZgUKCtcM3OBI9HH9E7.5HFJ7FN-67O7EGHG9GN.HK9@flex--tavip.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Add support for NXP's flexcomm usart. It supports interupts and FIFO
access but no DMA.

The patch includes an automatically generated header which contains
the register layout and helpers.

The header can be regenerated with the svd-flexcomm-usart target when
the build is configured with --enable-mcux-soc-svd.

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 include/hw/arm/svd/flexcomm_usart.h | 1021 +++++++++++++++++++++++++++
 include/hw/char/flexcomm_usart.h    |   33 +
 include/hw/misc/flexcomm.h          |    2 +
 hw/char/flexcomm_usart.c            |  288 ++++++++
 hw/misc/flexcomm.c                  |    3 +
 hw/arm/svd/meson.build              |    3 +
 hw/char/meson.build                 |    1 +
 hw/char/trace-events                |    8 +
 8 files changed, 1359 insertions(+)
 create mode 100644 include/hw/arm/svd/flexcomm_usart.h
 create mode 100644 include/hw/char/flexcomm_usart.h
 create mode 100644 hw/char/flexcomm_usart.c

diff --git a/include/hw/arm/svd/flexcomm_usart.h b/include/hw/arm/svd/flexcomm_usart.h
new file mode 100644
index 0000000000..fe560d5566
--- /dev/null
+++ b/include/hw/arm/svd/flexcomm_usart.h
@@ -0,0 +1,1021 @@
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
+REG32(FLEXCOMM_USART_CFG, 0);
+/* USART Enable */
+FIELD(FLEXCOMM_USART_CFG, ENABLE, 0, 1);
+/* Data Length. Selects the data size for the USART. */
+FIELD(FLEXCOMM_USART_CFG, DATALEN, 2, 2);
+/* Parity Select. Selects what type of parity is used by the USART. */
+FIELD(FLEXCOMM_USART_CFG, PARITYSEL, 4, 2);
+/* Stop Length */
+FIELD(FLEXCOMM_USART_CFG, STOPLEN, 6, 1);
+/* Mode 32 kHz */
+FIELD(FLEXCOMM_USART_CFG, MODE32K, 7, 1);
+/* LIN Break Mode Enable */
+FIELD(FLEXCOMM_USART_CFG, LINMODE, 8, 1);
+/* CTS Enable */
+FIELD(FLEXCOMM_USART_CFG, CTSEN, 9, 1);
+/* Synchronous Enable. Selects synchronous or asynchronous operation. */
+FIELD(FLEXCOMM_USART_CFG, SYNCEN, 11, 1);
+/* Clock Polarity */
+FIELD(FLEXCOMM_USART_CFG, CLKPOL, 12, 1);
+/* Synchronous mode Master Select */
+FIELD(FLEXCOMM_USART_CFG, SYNCMST, 14, 1);
+/* Loopback Mode */
+FIELD(FLEXCOMM_USART_CFG, LOOP, 15, 1);
+/* Output Enable Turnaround Time Enable for RS-485 Operation. */
+FIELD(FLEXCOMM_USART_CFG, OETA, 18, 1);
+/* Automatic Address Matching Enable */
+FIELD(FLEXCOMM_USART_CFG, AUTOADDR, 19, 1);
+/* Output Enable Select */
+FIELD(FLEXCOMM_USART_CFG, OESEL, 20, 1);
+/* Output Enable Polarity */
+FIELD(FLEXCOMM_USART_CFG, OEPOL, 21, 1);
+/* Receive Data Polarity */
+FIELD(FLEXCOMM_USART_CFG, RXPOL, 22, 1);
+/* Transmit data polarity */
+FIELD(FLEXCOMM_USART_CFG, TXPOL, 23, 1);
+
+/* USART Control */
+REG32(FLEXCOMM_USART_CTL, 4);
+/* Break Enable */
+FIELD(FLEXCOMM_USART_CTL, TXBRKEN, 1, 1);
+/* Enable Address Detect Mode */
+FIELD(FLEXCOMM_USART_CTL, ADDRDET, 2, 1);
+/* Transmit Disable */
+FIELD(FLEXCOMM_USART_CTL, TXDIS, 6, 1);
+/* Continuous Clock Generation */
+FIELD(FLEXCOMM_USART_CTL, CC, 8, 1);
+/* Clear Continuous Clock */
+FIELD(FLEXCOMM_USART_CTL, CLRCCONRX, 9, 1);
+/* Autobaud Enable */
+FIELD(FLEXCOMM_USART_CTL, AUTOBAUD, 16, 1);
+
+/* USART Status */
+REG32(FLEXCOMM_USART_STAT, 8);
+/* Receiver Idle */
+FIELD(FLEXCOMM_USART_STAT, RXIDLE, 1, 1);
+/* Transmitter Idle */
+FIELD(FLEXCOMM_USART_STAT, TXIDLE, 3, 1);
+/* CTS value */
+FIELD(FLEXCOMM_USART_STAT, CTS, 4, 1);
+/* Delta CTS */
+FIELD(FLEXCOMM_USART_STAT, DELTACTS, 5, 1);
+/* Transmitter Disabled Status Flag */
+FIELD(FLEXCOMM_USART_STAT, TXDISSTAT, 6, 1);
+/* Received Break */
+FIELD(FLEXCOMM_USART_STAT, RXBRK, 10, 1);
+/* Delta Received Break */
+FIELD(FLEXCOMM_USART_STAT, DELTARXBRK, 11, 1);
+/* Start */
+FIELD(FLEXCOMM_USART_STAT, START, 12, 1);
+/* Framing Error Interrupt Flag */
+FIELD(FLEXCOMM_USART_STAT, FRAMERRINT, 13, 1);
+/* Parity Error Interrupt Flag */
+FIELD(FLEXCOMM_USART_STAT, PARITYERRINT, 14, 1);
+/* Received Noise Interrupt Flag */
+FIELD(FLEXCOMM_USART_STAT, RXNOISEINT, 15, 1);
+/* Auto Baud Error */
+FIELD(FLEXCOMM_USART_STAT, ABERR, 16, 1);
+
+/* Interrupt Enable Read and Set for USART (not FIFO) Status */
+REG32(FLEXCOMM_USART_INTENSET, 12);
+/* Transmit Idle Flag */
+FIELD(FLEXCOMM_USART_INTENSET, TXIDLEEN, 3, 1);
+/* Delta CTS Input Flag */
+FIELD(FLEXCOMM_USART_INTENSET, DELTACTSEN, 5, 1);
+/* Transmit Disabled Flag */
+FIELD(FLEXCOMM_USART_INTENSET, TXDISEN, 6, 1);
+/* Delta Receive Break Enable */
+FIELD(FLEXCOMM_USART_INTENSET, DELTARXBRKEN, 11, 1);
+/* Start Enable */
+FIELD(FLEXCOMM_USART_INTENSET, STARTEN, 12, 1);
+/* Frame Error Enable */
+FIELD(FLEXCOMM_USART_INTENSET, FRAMERREN, 13, 1);
+/* Parity Error Enble */
+FIELD(FLEXCOMM_USART_INTENSET, PARITYERREN, 14, 1);
+/* Receive Noise Enable */
+FIELD(FLEXCOMM_USART_INTENSET, RXNOISEEN, 15, 1);
+/* Auto Baud Error Enable */
+FIELD(FLEXCOMM_USART_INTENSET, ABERREN, 16, 1);
+
+/* Interrupt Enable Clear */
+REG32(FLEXCOMM_USART_INTENCLR, 16);
+/* Transmit Idle Clear */
+FIELD(FLEXCOMM_USART_INTENCLR, TXIDLECLR, 3, 1);
+/* Delta CTS Clear */
+FIELD(FLEXCOMM_USART_INTENCLR, DELTACTSCLR, 5, 1);
+/* Transmit Disable Clear */
+FIELD(FLEXCOMM_USART_INTENCLR, TXDISCLR, 6, 1);
+/* Delta Receive Break Clear */
+FIELD(FLEXCOMM_USART_INTENCLR, DELTARXBRKCLR, 11, 1);
+/* Start Clear */
+FIELD(FLEXCOMM_USART_INTENCLR, STARTCLR, 12, 1);
+/* Frame Error Clear */
+FIELD(FLEXCOMM_USART_INTENCLR, FRAMERRCLR, 13, 1);
+/* Parity Error Clear */
+FIELD(FLEXCOMM_USART_INTENCLR, PARITYERRCLR, 14, 1);
+/* Receive Noise Clear */
+FIELD(FLEXCOMM_USART_INTENCLR, RXNOISECLR, 15, 1);
+/* Auto Baud Error Clear */
+FIELD(FLEXCOMM_USART_INTENCLR, ABERRCLR, 16, 1);
+
+/* Baud Rate Generator */
+REG32(FLEXCOMM_USART_BRG, 32);
+/* Baud Rate Generator Value */
+FIELD(FLEXCOMM_USART_BRG, BRGVAL, 0, 16);
+
+/* Interrupt Status */
+REG32(FLEXCOMM_USART_INTSTAT, 36);
+/* Transmitter Idle Flag */
+FIELD(FLEXCOMM_USART_INTSTAT, TXIDLE, 3, 1);
+/* Delta CTS Change Flag */
+FIELD(FLEXCOMM_USART_INTSTAT, DELTACTS, 5, 1);
+/* Transmitter Disabled Interrupt Flag */
+FIELD(FLEXCOMM_USART_INTSTAT, TXDISINT, 6, 1);
+/* Delta Receiver Break Change Flag */
+FIELD(FLEXCOMM_USART_INTSTAT, DELTARXBRK, 11, 1);
+/* Start Detected on Receiver Flag */
+FIELD(FLEXCOMM_USART_INTSTAT, START, 12, 1);
+/* Framing Error Interrupt Flag */
+FIELD(FLEXCOMM_USART_INTSTAT, FRAMERRINT, 13, 1);
+/* Parity Error Interrupt Flag */
+FIELD(FLEXCOMM_USART_INTSTAT, PARITYERRINT, 14, 1);
+/* Received Noise Interrupt Flag */
+FIELD(FLEXCOMM_USART_INTSTAT, RXNOISEINT, 15, 1);
+/* Auto Baud Error Interrupt Flag */
+FIELD(FLEXCOMM_USART_INTSTAT, ABERRINT, 16, 1);
+
+/* Oversample Selection Register for Asynchronous Communication */
+REG32(FLEXCOMM_USART_OSR, 40);
+/* Oversample Selection Value */
+FIELD(FLEXCOMM_USART_OSR, OSRVAL, 0, 4);
+
+/* Address Register for Automatic Address Matching */
+REG32(FLEXCOMM_USART_ADDR, 44);
+/* Address */
+FIELD(FLEXCOMM_USART_ADDR, ADDRESS, 0, 8);
+
+/* FIFO Configuration */
+REG32(FLEXCOMM_USART_FIFOCFG, 3584);
+/* Enable the Transmit FIFO. */
+FIELD(FLEXCOMM_USART_FIFOCFG, ENABLETX, 0, 1);
+/* Enable the Receive FIFO */
+FIELD(FLEXCOMM_USART_FIFOCFG, ENABLERX, 1, 1);
+/* FIFO Size Configuration */
+FIELD(FLEXCOMM_USART_FIFOCFG, SIZE, 4, 2);
+/* DMA Configuration for Transmit */
+FIELD(FLEXCOMM_USART_FIFOCFG, DMATX, 12, 1);
+/* DMA Configuration for Receive */
+FIELD(FLEXCOMM_USART_FIFOCFG, DMARX, 13, 1);
+/* Wake-up for Transmit FIFO Level */
+FIELD(FLEXCOMM_USART_FIFOCFG, WAKETX, 14, 1);
+/* Wake-up for Receive FIFO Level */
+FIELD(FLEXCOMM_USART_FIFOCFG, WAKERX, 15, 1);
+/* Empty Command for the Transmit FIFO */
+FIELD(FLEXCOMM_USART_FIFOCFG, EMPTYTX, 16, 1);
+/* Empty Command for the Receive FIFO */
+FIELD(FLEXCOMM_USART_FIFOCFG, EMPTYRX, 17, 1);
+/* Pop FIFO for Debug Reads */
+FIELD(FLEXCOMM_USART_FIFOCFG, POPDBG, 18, 1);
+
+/* FIFO Status */
+REG32(FLEXCOMM_USART_FIFOSTAT, 3588);
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
+REG32(FLEXCOMM_USART_FIFOTRIG, 3592);
+/* Transmit FIFO Level Trigger Enable. */
+FIELD(FLEXCOMM_USART_FIFOTRIG, TXLVLENA, 0, 1);
+/* Receive FIFO Level Trigger Enable */
+FIELD(FLEXCOMM_USART_FIFOTRIG, RXLVLENA, 1, 1);
+/* Transmit FIFO Level Trigger Point */
+FIELD(FLEXCOMM_USART_FIFOTRIG, TXLVL, 8, 4);
+/* Receive FIFO Level Trigger Point */
+FIELD(FLEXCOMM_USART_FIFOTRIG, RXLVL, 16, 4);
+
+/* FIFO Interrupt Enable */
+REG32(FLEXCOMM_USART_FIFOINTENSET, 3600);
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
+REG32(FLEXCOMM_USART_FIFOINTENCLR, 3604);
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
+REG32(FLEXCOMM_USART_FIFOINTSTAT, 3608);
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
+REG32(FLEXCOMM_USART_FIFOWR, 3616);
+/* Transmit data to the FIFO */
+FIELD(FLEXCOMM_USART_FIFOWR, TXDATA, 0, 9);
+
+/* FIFO Read Data */
+REG32(FLEXCOMM_USART_FIFORD, 3632);
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
+REG32(FLEXCOMM_USART_FIFORDNOPOP, 3648);
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
+REG32(FLEXCOMM_USART_FIFOSIZE, 3656);
+/* FIFO Size */
+FIELD(FLEXCOMM_USART_FIFOSIZE, FIFOSIZE, 0, 5);
+
+/* Peripheral Identification */
+REG32(FLEXCOMM_USART_ID, 4092);
+/* Aperture */
+FIELD(FLEXCOMM_USART_ID, APERTURE, 0, 8);
+/* Minor revision of module implementation */
+FIELD(FLEXCOMM_USART_ID, MINOR_REV, 8, 4);
+/* Major revision of module implementation */
+FIELD(FLEXCOMM_USART_ID, MAJOR_REV, 12, 4);
+/* Module identifier for the selected function */
+FIELD(FLEXCOMM_USART_ID, ID, 16, 16);
+
+
+typedef enum {
+    /* Disabled */
+    FLEXCOMM_USART_CFG_ENABLE_DISABLED = 0,
+    /* Enabled. The USART is enabled for operation. */
+    FLEXCOMM_USART_CFG_ENABLE_ENABLED = 1,
+} FLEXCOMM_USART_CFG_ENABLE_Enum;
+
+typedef enum {
+    /* 7 bit data length */
+    FLEXCOMM_USART_CFG_DATALEN_BIT_7 = 0,
+    /* 8 bit data length */
+    FLEXCOMM_USART_CFG_DATALEN_BIT_8 = 1,
+    /*
+     * 9 bit data length. The 9th bit is commonly used for addressing in
+     * multidrop mode. See the ADDRDET[CTL].
+     */
+    FLEXCOMM_USART_CFG_DATALEN_BIT_9 = 2,
+} FLEXCOMM_USART_CFG_DATALEN_Enum;
+
+typedef enum {
+    /* No parity */
+    FLEXCOMM_USART_CFG_PARITYSEL_NO_PARITY = 0,
+    /* Even parity */
+    FLEXCOMM_USART_CFG_PARITYSEL_EVEN_PARITY = 2,
+    /* Odd parity */
+    FLEXCOMM_USART_CFG_PARITYSEL_ODD_PARITY = 3,
+} FLEXCOMM_USART_CFG_PARITYSEL_Enum;
+
+typedef enum {
+    /* 1 stop bit */
+    FLEXCOMM_USART_CFG_STOPLEN_BIT_1 = 0,
+    /*
+     * 2 stop bits. This setting should be used only for asynchronous
+     * communication.
+     */
+    FLEXCOMM_USART_CFG_STOPLEN_BITS_2 = 1,
+} FLEXCOMM_USART_CFG_STOPLEN_Enum;
+
+typedef enum {
+    /* Disabled. USART uses standard clocking. */
+    FLEXCOMM_USART_CFG_MODE32K_DISABLED = 0,
+    /* Enabled */
+    FLEXCOMM_USART_CFG_MODE32K_ENABLED = 1,
+} FLEXCOMM_USART_CFG_MODE32K_Enum;
+
+typedef enum {
+    /*
+     * Disabled. Break detect and generate is configured for normal operation.
+     */
+    FLEXCOMM_USART_CFG_LINMODE_DISABLED = 0,
+    /*
+     * Enabled. Break detect and generate is configured for LIN bus operation.
+     */
+    FLEXCOMM_USART_CFG_LINMODE_ENABLED = 1,
+} FLEXCOMM_USART_CFG_LINMODE_Enum;
+
+typedef enum {
+    /*
+     * No flow control. The transmitter does not receive any automatic flow
+     * control signal.
+     */
+    FLEXCOMM_USART_CFG_CTSEN_DISABLED = 0,
+    /*
+     * Flow control enabled. The transmitter uses the CTS input (or RTS output
+     * in loopback mode) for flow control purposes.
+     */
+    FLEXCOMM_USART_CFG_CTSEN_ENABLED = 1,
+} FLEXCOMM_USART_CFG_CTSEN_Enum;
+
+typedef enum {
+    /* Asynchronous mode */
+    FLEXCOMM_USART_CFG_SYNCEN_ASYNCHRONOUS_MODE = 0,
+    /* Synchronous mode */
+    FLEXCOMM_USART_CFG_SYNCEN_SYNCHRONOUS_MODE = 1,
+} FLEXCOMM_USART_CFG_SYNCEN_Enum;
+
+typedef enum {
+    /* Falling edge. RXD is sampled on the falling edge of SCLK. */
+    FLEXCOMM_USART_CFG_CLKPOL_FALLING_EDGE = 0,
+    /* Rising edge. RXD is sampled on the rising edge of SCLK. */
+    FLEXCOMM_USART_CFG_CLKPOL_RISING_EDGE = 1,
+} FLEXCOMM_USART_CFG_CLKPOL_Enum;
+
+typedef enum {
+    /* Slave. When synchronous mode is enabled, the USART is a slave. */
+    FLEXCOMM_USART_CFG_SYNCMST_SLAVE = 0,
+    /* Master. When synchronous mode is enabled, the USART is a master. */
+    FLEXCOMM_USART_CFG_SYNCMST_MASTER = 1,
+} FLEXCOMM_USART_CFG_SYNCMST_Enum;
+
+typedef enum {
+    /* Normal operation */
+    FLEXCOMM_USART_CFG_LOOP_NORMAL = 0,
+    /* Loopback mode */
+    FLEXCOMM_USART_CFG_LOOP_LOOPBACK = 1,
+} FLEXCOMM_USART_CFG_LOOP_Enum;
+
+typedef enum {
+    /* Disabled */
+    FLEXCOMM_USART_CFG_OETA_DISABLED = 0,
+    /* Enabled */
+    FLEXCOMM_USART_CFG_OETA_ENABLED = 1,
+} FLEXCOMM_USART_CFG_OETA_Enum;
+
+typedef enum {
+    /* Disabled */
+    FLEXCOMM_USART_CFG_AUTOADDR_DISABLED = 0,
+    /* Enabled */
+    FLEXCOMM_USART_CFG_AUTOADDR_ENABLED = 1,
+} FLEXCOMM_USART_CFG_AUTOADDR_Enum;
+
+typedef enum {
+    /*
+     * Standard. The RTS signal is used as the standard flow control function.
+     */
+    FLEXCOMM_USART_CFG_OESEL_STANDARD = 0,
+    /*
+     * RS-485. The RTS signal is configured to provide an output enable signal
+     * to control an RS-485 transceiver.
+     */
+    FLEXCOMM_USART_CFG_OESEL_RS_485 = 1,
+} FLEXCOMM_USART_CFG_OESEL_Enum;
+
+typedef enum {
+    /* Low. If selected by OESEL, the output enable is active low. */
+    FLEXCOMM_USART_CFG_OEPOL_LOW = 0,
+    /* High. If selected by OESEL, the output enable is active high. */
+    FLEXCOMM_USART_CFG_OEPOL_HIGH = 1,
+} FLEXCOMM_USART_CFG_OEPOL_Enum;
+
+typedef enum {
+    /* Standard */
+    FLEXCOMM_USART_CFG_RXPOL_STANDARD = 0,
+    /* Inverted */
+    FLEXCOMM_USART_CFG_RXPOL_INVERTED = 1,
+} FLEXCOMM_USART_CFG_RXPOL_Enum;
+
+typedef enum {
+    /* Standard */
+    FLEXCOMM_USART_CFG_TXPOL_STANDARD = 0,
+    /* Inverted */
+    FLEXCOMM_USART_CFG_TXPOL_INVERTED = 1,
+} FLEXCOMM_USART_CFG_TXPOL_Enum;
+
+typedef enum {
+    /* Normal operation */
+    FLEXCOMM_USART_CTL_TXBRKEN_NORMAL = 0,
+    /* Continuous break */
+    FLEXCOMM_USART_CTL_TXBRKEN_CONTINUOUS = 1,
+} FLEXCOMM_USART_CTL_TXBRKEN_Enum;
+
+typedef enum {
+    /* Disabled. The USART presents all incoming data. */
+    FLEXCOMM_USART_CTL_ADDRDET_DISABLED = 0,
+    /* Enabled */
+    FLEXCOMM_USART_CTL_ADDRDET_ENABLED = 1,
+} FLEXCOMM_USART_CTL_ADDRDET_Enum;
+
+typedef enum {
+    /* Not disabled. USART transmitter is not disabled. */
+    FLEXCOMM_USART_CTL_TXDIS_ENABLED = 0,
+    /*
+     * Disabled. USART transmitter is disabled after any character currently
+     * being transmitted is complete. This feature can be used to facilitate
+     * software flow control.
+     */
+    FLEXCOMM_USART_CTL_TXDIS_DISABLED = 1,
+} FLEXCOMM_USART_CTL_TXDIS_Enum;
+
+typedef enum {
+    /* Clock on character */
+    FLEXCOMM_USART_CTL_CC_CLOCK_ON_CHARACTER = 0,
+    /* Continuous clock */
+    FLEXCOMM_USART_CTL_CC_CONTINOUS_CLOCK = 1,
+} FLEXCOMM_USART_CTL_CC_Enum;
+
+typedef enum {
+    /* No effect. No effect on the CC bit. */
+    FLEXCOMM_USART_CTL_CLRCCONRX_NO_EFFECT = 0,
+    /* Auto-clear */
+    FLEXCOMM_USART_CTL_CLRCCONRX_AUTO_CLEAR = 1,
+} FLEXCOMM_USART_CTL_CLRCCONRX_Enum;
+
+typedef enum {
+    /* Disabled */
+    FLEXCOMM_USART_CTL_AUTOBAUD_DISABLED = 0,
+    /* Enabled */
+    FLEXCOMM_USART_CTL_AUTOBAUD_ENABLED = 1,
+} FLEXCOMM_USART_CTL_AUTOBAUD_Enum;
+
+typedef enum {
+    /* The receiver is currently receiving data. */
+    FLEXCOMM_USART_STAT_RXIDLE_RX_ACTIVE = 0,
+    /* The receiver is not currently receiving data. */
+    FLEXCOMM_USART_STAT_RXIDLE_RX_IDLE = 1,
+} FLEXCOMM_USART_STAT_RXIDLE_Enum;
+
+typedef enum {
+    /* The transmitter is currently sending data. */
+    FLEXCOMM_USART_STAT_TXIDLE_TX_ACTIVE = 0,
+    /* The transmitter is not currently sending data. */
+    FLEXCOMM_USART_STAT_TXIDLE_TX_IDLE = 1,
+} FLEXCOMM_USART_STAT_TXIDLE_Enum;
+
+typedef enum {
+    /*
+     * Not Idle. Indicates that the USART transmitter is NOT fully idle after
+     * being disabled.
+     */
+    FLEXCOMM_USART_STAT_TXDISSTAT_TX_NOT_IDLE = 0,
+    /*
+     * Idle. Indicates that the USART transmitter is fully idle after being
+     * disabled (CTL[TXDIS] = 1).
+     */
+    FLEXCOMM_USART_STAT_TXDISSTAT_TX_IDLE = 1,
+} FLEXCOMM_USART_STAT_TXDISSTAT_Enum;
+
+typedef enum {
+    /*
+     * Enables an interrupt when the transmitter becomes idle (STAT[TXIDLE] =
+     * 1).
+     */
+    FLEXCOMM_USART_INTENSET_TXIDLEEN_ENABLE = 1,
+} FLEXCOMM_USART_INTENSET_TXIDLEEN_Enum;
+
+typedef enum {
+    /*
+     * Enables an interrupt when there is a change in the state of the CTS
+     * input.
+     */
+    FLEXCOMM_USART_INTENSET_DELTACTSEN_ENABLE = 1,
+} FLEXCOMM_USART_INTENSET_DELTACTSEN_Enum;
+
+typedef enum {
+    /*
+     * Enables an interrupt when the transmitter is fully disabled as indicated
+     * by the STAT[TXDISINT] flag. See the description of the STAT[TXDISINT]
+     * flag.
+     */
+    FLEXCOMM_USART_INTENSET_TXDISEN_ENABLE = 1,
+} FLEXCOMM_USART_INTENSET_TXDISEN_Enum;
+
+typedef enum {
+    /* Enable */
+    FLEXCOMM_USART_INTENSET_DELTARXBRKEN_ENABLE = 1,
+} FLEXCOMM_USART_INTENSET_DELTARXBRKEN_Enum;
+
+typedef enum {
+    /* Enables an interrupt when a received start bit has been detected. */
+    FLEXCOMM_USART_INTENSET_STARTEN_ENABLE = 1,
+} FLEXCOMM_USART_INTENSET_STARTEN_Enum;
+
+typedef enum {
+    /* Enables an interrupt when a framing error has been detected. */
+    FLEXCOMM_USART_INTENSET_FRAMERREN_ENABLE = 1,
+} FLEXCOMM_USART_INTENSET_FRAMERREN_Enum;
+
+typedef enum {
+    /* Enables an interrupt when a parity error has been detected. */
+    FLEXCOMM_USART_INTENSET_PARITYERREN_ENABLE = 1,
+} FLEXCOMM_USART_INTENSET_PARITYERREN_Enum;
+
+typedef enum {
+    /*
+     * Enables an interrupt when noise is detected. See the description of the
+     * CTL[RXNOISEINT] bit.
+     */
+    FLEXCOMM_USART_INTENSET_RXNOISEEN_ENABLE = 1,
+} FLEXCOMM_USART_INTENSET_RXNOISEEN_Enum;
+
+typedef enum {
+    /* Enables an interrupt when an auto baud error occurs. */
+    FLEXCOMM_USART_INTENSET_ABERREN_ENABLE = 1,
+} FLEXCOMM_USART_INTENSET_ABERREN_Enum;
+
+typedef enum {
+    /* FCLK is used directly by the USART function. */
+    FLEXCOMM_USART_BRG_BRGVAL_Zero = 0,
+    /* FCLK is divided by 2 before use by the USART function. */
+    FLEXCOMM_USART_BRG_BRGVAL_One = 1,
+    /* FCLK is divided by 3 before use by the USART function. */
+    FLEXCOMM_USART_BRG_BRGVAL_Two = 2,
+    /* FCLK is divided by 65,536 before use by the USART function. */
+    FLEXCOMM_USART_BRG_BRGVAL_FFFF = 65535,
+} FLEXCOMM_USART_BRG_BRGVAL_Enum;
+
+typedef enum {
+    /* Not supported */
+    FLEXCOMM_USART_OSR_OSRVAL_zero = 0,
+    /* Not supported */
+    FLEXCOMM_USART_OSR_OSRVAL_one = 1,
+    /* Not supported */
+    FLEXCOMM_USART_OSR_OSRVAL_two = 2,
+    /* Not supported */
+    FLEXCOMM_USART_OSR_OSRVAL_three = 3,
+    /* 5 function clocks are used to transmit and receive each data bit. */
+    FLEXCOMM_USART_OSR_OSRVAL_four = 4,
+    /* 6 function clocks are used to transmit and receive each data bit. */
+    FLEXCOMM_USART_OSR_OSRVAL_five = 5,
+    /* 16 function clocks are used to transmit and receive each data bit. */
+    FLEXCOMM_USART_OSR_OSRVAL_sixteen = 15,
+} FLEXCOMM_USART_OSR_OSRVAL_Enum;
+
+typedef enum {
+    /* The transmit FIFO is not enabled. */
+    FLEXCOMM_USART_FIFOCFG_ENABLETX_DISABLED = 0,
+    /* The transmit FIFO is enabled. */
+    FLEXCOMM_USART_FIFOCFG_ENABLETX_ENABLED = 1,
+} FLEXCOMM_USART_FIFOCFG_ENABLETX_Enum;
+
+typedef enum {
+    /* The receive FIFO is not enabled. */
+    FLEXCOMM_USART_FIFOCFG_ENABLERX_DISABLED = 0,
+    /* The receive FIFO is enabled. */
+    FLEXCOMM_USART_FIFOCFG_ENABLERX_ENABLED = 1,
+} FLEXCOMM_USART_FIFOCFG_ENABLERX_Enum;
+
+typedef enum {
+    /* FIFO is configured as 16 entries of 8 bits. */
+    FLEXCOMM_USART_FIFOCFG_SIZE_SIZE16 = 0,
+    /* Not used */
+    FLEXCOMM_USART_FIFOCFG_SIZE_SIZEINVALID1 = 1,
+    /* Not used */
+    FLEXCOMM_USART_FIFOCFG_SIZE_SIZEINVALID2 = 2,
+    /* Not used */
+    FLEXCOMM_USART_FIFOCFG_SIZE_SIZEINVALID3 = 3,
+} FLEXCOMM_USART_FIFOCFG_SIZE_Enum;
+
+typedef enum {
+    /* DMA is not used for the transmit function. */
+    FLEXCOMM_USART_FIFOCFG_DMATX_DISABLED = 0,
+    /*
+     * Triggers DMA for the transmit function if the FIFO is not full.
+     * Generally, data interrupts would be disabled if DMA is enabled.
+     */
+    FLEXCOMM_USART_FIFOCFG_DMATX_ENABLED = 1,
+} FLEXCOMM_USART_FIFOCFG_DMATX_Enum;
+
+typedef enum {
+    /* DMA is not used for the receive function. */
+    FLEXCOMM_USART_FIFOCFG_DMARX_DISABLED = 0,
+    /*
+     * Triggers DMA for the receive function if the FIFO is not empty.
+     * Generally, data interrupts would be disabled if DMA is enabled.
+     */
+    FLEXCOMM_USART_FIFOCFG_DMARX_ENABLED = 1,
+} FLEXCOMM_USART_FIFOCFG_DMARX_Enum;
+
+typedef enum {
+    /* Only enabled interrupts will wake up the device from low power modes. */
+    FLEXCOMM_USART_FIFOCFG_WAKETX_DISABLED = 0,
+    /*
+     * A device wake-up for DMA will occur if the transmit FIFO level reaches
+     * the value specified by FIFOTRIG[TXLVL], even when the TXLVL interrupt is
+     * not enabled.
+     */
+    FLEXCOMM_USART_FIFOCFG_WAKETX_ENABLED = 1,
+} FLEXCOMM_USART_FIFOCFG_WAKETX_Enum;
+
+typedef enum {
+    /* Only enabled interrupts will wake up the device from low power modes. */
+    FLEXCOMM_USART_FIFOCFG_WAKERX_DISABLED = 0,
+    /*
+     * A device wake-up for DMA will occur if the receive FIFO level reaches
+     * the value specified by FIFOTRIG[RXLVL], even when the RXLVL interrupt is
+     * not enabled.
+     */
+    FLEXCOMM_USART_FIFOCFG_WAKERX_ENABLED = 1,
+} FLEXCOMM_USART_FIFOCFG_WAKERX_Enum;
+
+typedef enum {
+    /* No effect */
+    FLEXCOMM_USART_FIFOCFG_EMPTYTX_NO_EFFECT = 0,
+    /* The TX FIFO is emptied. */
+    FLEXCOMM_USART_FIFOCFG_EMPTYTX_EMPTY_THE_TX_FIFO = 1,
+} FLEXCOMM_USART_FIFOCFG_EMPTYTX_Enum;
+
+typedef enum {
+    /* No effect */
+    FLEXCOMM_USART_FIFOCFG_EMPTYRX_NO_EFFECT = 0,
+    /* The RX FIFO is emptied. */
+    FLEXCOMM_USART_FIFOCFG_EMPTYRX_EMPTY_THE_RX_FIFO = 1,
+} FLEXCOMM_USART_FIFOCFG_EMPTYRX_Enum;
+
+typedef enum {
+    /* Debug reads of the FIFO do not pop the FIFO. */
+    FLEXCOMM_USART_FIFOCFG_POPDBG_DO_NOT_POP = 0,
+    /* A debug read will cause the FIFO to pop. */
+    FLEXCOMM_USART_FIFOCFG_POPDBG_POP = 1,
+} FLEXCOMM_USART_FIFOCFG_POPDBG_Enum;
+
+typedef enum {
+    /* A transmit FIFO error has not occurred. */
+    FLEXCOMM_USART_FIFOSTAT_TXERR_NO_TXERR = 0,
+    /*
+     * A transmit FIFO error has occurred. This error could be an overflow
+     * caused by pushing data into a full FIFO, or by an underflow if the FIFO
+     * is empty when data is needed.
+     */
+    FLEXCOMM_USART_FIFOSTAT_TXERR_TXERR = 1,
+} FLEXCOMM_USART_FIFOSTAT_TXERR_Enum;
+
+typedef enum {
+    /* A receive FIFO overflow has not occurred */
+    FLEXCOMM_USART_FIFOSTAT_RXERR_NO_RXERR = 0,
+    /*
+     * A receive FIFO overflow has occurred, caused by software or DMA not
+     * emptying the FIFO fast enough
+     */
+    FLEXCOMM_USART_FIFOSTAT_RXERR_RXERR = 1,
+} FLEXCOMM_USART_FIFOSTAT_RXERR_Enum;
+
+typedef enum {
+    /* No Peripheral Interrupt */
+    FLEXCOMM_USART_FIFOSTAT_PERINT_NO_PERINT = 0,
+    /* Peripheral Interrupt */
+    FLEXCOMM_USART_FIFOSTAT_PERINT_PERINT = 1,
+} FLEXCOMM_USART_FIFOSTAT_PERINT_Enum;
+
+typedef enum {
+    /* The transmit FIFO is not empty. */
+    FLEXCOMM_USART_FIFOSTAT_TXEMPTY_TXFIFO_ISNOTEMPTY = 0,
+    /*
+     * The transmit FIFO is empty, although the peripheral may still be
+     * processing the last piece of data.
+     */
+    FLEXCOMM_USART_FIFOSTAT_TXEMPTY_TXFIFO_ISEMPTY = 1,
+} FLEXCOMM_USART_FIFOSTAT_TXEMPTY_Enum;
+
+typedef enum {
+    /*
+     * The transmit FIFO is full and another write would cause it to overflow.
+     */
+    FLEXCOMM_USART_FIFOSTAT_TXNOTFULL_TXFIFO_ISFULL = 0,
+    /* The transmit FIFO is not full, so more data can be written. */
+    FLEXCOMM_USART_FIFOSTAT_TXNOTFULL_TXFIFO_ISNOTFULL = 1,
+} FLEXCOMM_USART_FIFOSTAT_TXNOTFULL_Enum;
+
+typedef enum {
+    /* The receive FIFO is empty. */
+    FLEXCOMM_USART_FIFOSTAT_RXNOTEMPTY_RXFIFO_ISEMPTY = 0,
+    /* The receive FIFO is not empty, so data can be read. */
+    FLEXCOMM_USART_FIFOSTAT_RXNOTEMPTY_RXFIFO_ISNOTEMPTY = 1,
+} FLEXCOMM_USART_FIFOSTAT_RXNOTEMPTY_Enum;
+
+typedef enum {
+    /* The receive FIFO is not full. */
+    FLEXCOMM_USART_FIFOSTAT_RXFULL_RXFIFO_ISNOTFULL = 0,
+    /* The receive FIFO is full. */
+    FLEXCOMM_USART_FIFOSTAT_RXFULL_RXFIFO_ISFULL = 1,
+} FLEXCOMM_USART_FIFOSTAT_RXFULL_Enum;
+
+typedef enum {
+    /* Transmit FIFO level does not generate a FIFO level trigger. */
+    FLEXCOMM_USART_FIFOTRIG_TXLVLENA_DISABLED = 0,
+    /*
+     * A trigger will be generated if the transmit FIFO level reaches the value
+     * specified by the TXLVL field.
+     */
+    FLEXCOMM_USART_FIFOTRIG_TXLVLENA_ENABLED = 1,
+} FLEXCOMM_USART_FIFOTRIG_TXLVLENA_Enum;
+
+typedef enum {
+    /* Receive FIFO level does not generate a FIFO level trigger. */
+    FLEXCOMM_USART_FIFOTRIG_RXLVLENA_DISABLED = 0,
+    /*
+     * An trigger will be generated if the receive FIFO level reaches the value
+     * specified by the RXLVL field.
+     */
+    FLEXCOMM_USART_FIFOTRIG_RXLVLENA_ENABLED = 1,
+} FLEXCOMM_USART_FIFOTRIG_RXLVLENA_Enum;
+
+typedef enum {
+    /* Trigger when the TX FIFO becomes empty */
+    FLEXCOMM_USART_FIFOTRIG_TXLVL_TXLVL0 = 0,
+    /* Trigger when the TX FIFO level decreases to 1 entry */
+    FLEXCOMM_USART_FIFOTRIG_TXLVL_TXLVL1 = 1,
+    /*
+     * Trigger when the TX FIFO level decreases to 15 entries (is no longer
+     * full)
+     */
+    FLEXCOMM_USART_FIFOTRIG_TXLVL_TXLVL15 = 15,
+} FLEXCOMM_USART_FIFOTRIG_TXLVL_Enum;
+
+typedef enum {
+    /* Trigger when the RX FIFO has received 1 entry (is no longer empty) */
+    FLEXCOMM_USART_FIFOTRIG_RXLVL_RXLVL1 = 0,
+    /* Trigger when the RX FIFO has received 2 entries */
+    FLEXCOMM_USART_FIFOTRIG_RXLVL_RXLVL2 = 1,
+    /* Trigger when the RX FIFO has received 16 entries (has become full) */
+    FLEXCOMM_USART_FIFOTRIG_RXLVL_RXLVL15 = 15,
+} FLEXCOMM_USART_FIFOTRIG_RXLVL_Enum;
+
+typedef enum {
+    /* No interrupt will be generated for a transmit error. */
+    FLEXCOMM_USART_FIFOINTENSET_TXERR_DISABLED = 0,
+    /* An interrupt will be generated when a transmit error occurs. */
+    FLEXCOMM_USART_FIFOINTENSET_TXERR_ENABLED = 1,
+} FLEXCOMM_USART_FIFOINTENSET_TXERR_Enum;
+
+typedef enum {
+    /* No interrupt will be generated for a receive error. */
+    FLEXCOMM_USART_FIFOINTENSET_RXERR_DISABLED = 0,
+    /* An interrupt will be generated when a receive error occurs. */
+    FLEXCOMM_USART_FIFOINTENSET_RXERR_ENABLED = 1,
+} FLEXCOMM_USART_FIFOINTENSET_RXERR_Enum;
+
+typedef enum {
+    /* No interrupt will be generated based on the TX FIFO level. */
+    FLEXCOMM_USART_FIFOINTENSET_TXLVL_DISABLED = 0,
+    /*
+     * If FIFOTRIG[TXLVLENA] = 1, then an interrupt will be generated when the
+     * TX FIFO level decreases to the level specified by FIFOTRIG[TXLVL]
+     */
+    FLEXCOMM_USART_FIFOINTENSET_TXLVL_ENABLED = 1,
+} FLEXCOMM_USART_FIFOINTENSET_TXLVL_Enum;
+
+typedef enum {
+    /* No interrupt will be generated based on the RX FIFO level. */
+    FLEXCOMM_USART_FIFOINTENSET_RXLVL_DISABLED = 0,
+    /*
+     * If FIFOTRIG[RXLVLENA] = 1, an interrupt will be generated when the when
+     * the RX FIFO level increases to the level specified by FIFOTRIG[RXLVL].
+     */
+    FLEXCOMM_USART_FIFOINTENSET_RXLVL_ENABLED = 1,
+} FLEXCOMM_USART_FIFOINTENSET_RXLVL_Enum;
+
+typedef enum {
+    /* No effect */
+    FLEXCOMM_USART_FIFOINTENCLR_TXERR_NO_EFFECT = 0,
+    /* Clear the interrupt */
+    FLEXCOMM_USART_FIFOINTENCLR_TXERR_CLEAR_THE_TXERR = 1,
+} FLEXCOMM_USART_FIFOINTENCLR_TXERR_Enum;
+
+typedef enum {
+    /* No effect */
+    FLEXCOMM_USART_FIFOINTENCLR_RXERR_NO_EFFECT = 0,
+    /* Clear the interrupt */
+    FLEXCOMM_USART_FIFOINTENCLR_RXERR_CLEAR_THE_RXERR = 1,
+} FLEXCOMM_USART_FIFOINTENCLR_RXERR_Enum;
+
+typedef enum {
+    /* No effect */
+    FLEXCOMM_USART_FIFOINTENCLR_TXLVL_NO_EFFECT = 0,
+    /* Clear the interrupt */
+    FLEXCOMM_USART_FIFOINTENCLR_TXLVL_CLEAR_THE_TXLVL = 1,
+} FLEXCOMM_USART_FIFOINTENCLR_TXLVL_Enum;
+
+typedef enum {
+    /* No effect */
+    FLEXCOMM_USART_FIFOINTENCLR_RXLVL_NO_EFFECT = 0,
+    /* Clear the interrupt */
+    FLEXCOMM_USART_FIFOINTENCLR_RXLVL_CLEAR_THE_RXLVL = 1,
+} FLEXCOMM_USART_FIFOINTENCLR_RXLVL_Enum;
+
+typedef enum {
+    /* Not pending */
+    FLEXCOMM_USART_FIFOINTSTAT_TXERR_TXERR_ISNOTPENDING = 0,
+    /* Pending */
+    FLEXCOMM_USART_FIFOINTSTAT_TXERR_TXERR_ISPENDING = 1,
+} FLEXCOMM_USART_FIFOINTSTAT_TXERR_Enum;
+
+typedef enum {
+    /* Not pending */
+    FLEXCOMM_USART_FIFOINTSTAT_RXERR_RXERR_ISNOTPENDING = 0,
+    /* Pending */
+    FLEXCOMM_USART_FIFOINTSTAT_RXERR_RXERR_ISPENDING = 1,
+} FLEXCOMM_USART_FIFOINTSTAT_RXERR_Enum;
+
+typedef enum {
+    /* Not pending */
+    FLEXCOMM_USART_FIFOINTSTAT_TXLVL_TXLVL_ISNOTPENDING = 0,
+    /* Pending */
+    FLEXCOMM_USART_FIFOINTSTAT_TXLVL_TXLVL_ISPENDING = 1,
+} FLEXCOMM_USART_FIFOINTSTAT_TXLVL_Enum;
+
+typedef enum {
+    /* Not pending */
+    FLEXCOMM_USART_FIFOINTSTAT_RXLVL_RXLVL_ISNOTPENDING = 0,
+    /* Pending */
+    FLEXCOMM_USART_FIFOINTSTAT_RXLVL_RXLVL_ISPENDING = 1,
+} FLEXCOMM_USART_FIFOINTSTAT_RXLVL_Enum;
+
+typedef enum {
+    /* Not pending */
+    FLEXCOMM_USART_FIFOINTSTAT_PERINT_PERINT_ISNOTPENDING = 0,
+    /* Pending */
+    FLEXCOMM_USART_FIFOINTSTAT_PERINT_PERINT_ISPENDING = 1,
+} FLEXCOMM_USART_FIFOINTSTAT_PERINT_Enum;
+
+
+#define FLEXCOMM_USART_REGISTER_ACCESS_INFO_ARRAY(_name) \
+    struct RegisterAccessInfo _name[FLEXCOMM_USART_REGS_NO] = { \
+        [0 ... FLEXCOMM_USART_REGS_NO - 1] = { \
+            .name = "", \
+            .addr = -1, \
+        }, \
+        [R_FLEXCOMM_USART_CFG] = { \
+            .name = "CFG", \
+            .addr = 0x0, \
+            .ro = 0xFF032402, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXCOMM_USART_CTL] = { \
+            .name = "CTL", \
+            .addr = 0x4, \
+            .ro = 0xFFFEFCB9, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXCOMM_USART_STAT] = { \
+            .name = "STAT", \
+            .addr = 0x8, \
+            .ro = 0xFFFE07DF, \
+            .reset = 0xA, \
+        }, \
+        [R_FLEXCOMM_USART_INTENSET] = { \
+            .name = "INTENSET", \
+            .addr = 0xC, \
+            .ro = 0xFFFE0797, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXCOMM_USART_INTENCLR] = { \
+            .name = "INTENCLR", \
+            .addr = 0x10, \
+            .ro = 0xFFFE0797, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXCOMM_USART_BRG] = { \
+            .name = "BRG", \
+            .addr = 0x20, \
+            .ro = 0xFFFF0000, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXCOMM_USART_INTSTAT] = { \
+            .name = "INTSTAT", \
+            .addr = 0x24, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXCOMM_USART_OSR] = { \
+            .name = "OSR", \
+            .addr = 0x28, \
+            .ro = 0xFFFFFFF0, \
+            .reset = 0xF, \
+        }, \
+        [R_FLEXCOMM_USART_ADDR] = { \
+            .name = "ADDR", \
+            .addr = 0x2C, \
+            .ro = 0xFFFFFF00, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXCOMM_USART_FIFOCFG] = { \
+            .name = "FIFOCFG", \
+            .addr = 0xE00, \
+            .ro = 0xFFF80FFC, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXCOMM_USART_FIFOSTAT] = { \
+            .name = "FIFOSTAT", \
+            .addr = 0xE04, \
+            .ro = 0xFFFFFFFC, \
+            .reset = 0x30, \
+        }, \
+        [R_FLEXCOMM_USART_FIFOTRIG] = { \
+            .name = "FIFOTRIG", \
+            .addr = 0xE08, \
+            .ro = 0xFFF0F0FC, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXCOMM_USART_FIFOINTENSET] = { \
+            .name = "FIFOINTENSET", \
+            .addr = 0xE10, \
+            .ro = 0xFFFFFFF0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXCOMM_USART_FIFOINTENCLR] = { \
+            .name = "FIFOINTENCLR", \
+            .addr = 0xE14, \
+            .ro = 0xFFFFFFF0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXCOMM_USART_FIFOINTSTAT] = { \
+            .name = "FIFOINTSTAT", \
+            .addr = 0xE18, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXCOMM_USART_FIFOWR] = { \
+            .name = "FIFOWR", \
+            .addr = 0xE20, \
+            .ro = 0xFFFFFE00, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXCOMM_USART_FIFORD] = { \
+            .name = "FIFORD", \
+            .addr = 0xE30, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXCOMM_USART_FIFORDNOPOP] = { \
+            .name = "FIFORDNOPOP", \
+            .addr = 0xE40, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXCOMM_USART_FIFOSIZE] = { \
+            .name = "FIFOSIZE", \
+            .addr = 0xE48, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x10, \
+        }, \
+        [R_FLEXCOMM_USART_ID] = { \
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
index 4b0bbbbbdc..2bde34d15b 100644
--- a/hw/arm/svd/meson.build
+++ b/hw/arm/svd/meson.build
@@ -4,4 +4,7 @@ if get_option('mcux-soc-svd')
   run_target('svd-flexcomm', command: svd_gen_header +
     [ '-i', rt595, '-o', '@SOURCE_ROOT@/include/hw/arm/svd/flexcomm.h',
     '-p', 'FLEXCOMM0', '-t', 'FLEXCOMM'])
+  run_target('svd-flexcomm-usart', command: svd_gen_header +
+    [ '-i', rt595, '-o', '@SOURCE_ROOT@/include/hw/arm/svd/flexcomm_usart.h',
+    '-p', 'USART0', '-t', 'FLEXCOMM_USART'])
 endif
diff --git a/hw/char/meson.build b/hw/char/meson.build
index a4c4c5ff0f..761e4b817c 100644
--- a/hw/char/meson.build
+++ b/hw/char/meson.build
@@ -38,3 +38,4 @@ system_ss.add(when: 'CONFIG_GOLDFISH_TTY', if_true: files('goldfish_tty.c'))
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
2.46.0.662.g92d0881bb0-goog


