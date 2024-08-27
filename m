Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB67C5320E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 06:51:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sipyK-0004J6-Pp; Tue, 27 Aug 2024 02:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3FXbNZgUKCnQlSnahYggYdW.UgeiWem-VWnWdfgfYfm.gjY@flex--tavip.bounces.google.com>)
 id 1sipxd-000312-OE
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 02:45:50 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3FXbNZgUKCnQlSnahYggYdW.UgeiWem-VWnWdfgfYfm.gjY@flex--tavip.bounces.google.com>)
 id 1sipxX-00065g-QB
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 02:45:49 -0400
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-e164e64efb6so9570825276.3
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 23:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1724741142; x=1725345942; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=MUptCNKb7fQCzCuOM6B8parO9p5OujSGWqVEiaYxFh4=;
 b=Jvr/C8oQyde165iqJvvTyJfguYf0cy65cpMDmiBjvFrulbs+ilJGpLV7tY2hRY5CIv
 +H9oaV27ZhFRGzb6kMfd0tf0X6CrrqCi379kWtNzmtMCp4Y+H/10g0aDpN2NxmgCEC1S
 Sk9Ct3a4sGerrNlRCYbBAz4w/gzbNK1RCRpcj1ULNxoptTbEio7S6hF7M2YUanbHhHZx
 ThCGdHyk0k+OBJ7JmzS6pMjRMEQmYOnyVblFt6N266139o7yvU6Nk5d0tl+J0HOpFK2q
 bCA7ZnoxtoYJ0BQ/YdjpTjEmqXr+Kn5/Gc9jtoOXbpbbQb426KIA2PFAuTJqt2pgN3fM
 uIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724741142; x=1725345942;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MUptCNKb7fQCzCuOM6B8parO9p5OujSGWqVEiaYxFh4=;
 b=c2ArYYl5H3+kYb3rtsAo6OspIlJ96P7YSvi65z6WtKUgp8UrZrtu4tNoU5+gzk9dDe
 OcwHmOxpYVmjlRVniHsPw7Gk1+X93E3QEMwE0BFs4ixTi+7rYgPpneXvnRzelRBgr64u
 ttfXB5QMvAexS23q9MegftQ80h6CUjxrommR23Kt+pcS79el0QCz8bgnZhuuUE/m7zTo
 viBf7ISr4P6Ova57clb7ZfRPv8HPKiibxdspcrJu2zfwlEm8bQuq87KVi/BmhBkYPjnb
 w0VEpgauW9JHYzheonVYfa7hXeMnHZrkS7I0RMPPBpV+bUNis90r+6temEAICSFWhzqo
 Liww==
X-Gm-Message-State: AOJu0YzkbszP2+OuX4aQhwxEy/9QobZ6G+gqci1zO9sRUn3ABniOoWuz
 o/7nvbHZZwkKK/VqtTQqZQhNxBwoRjLI05vI7tNL7QH6365ihWfCddhixvNhCVYT5K5XWtEpji9
 rbCoaFUys5Ebj0m04soPTFYW8EggBcdELUcFb7T26M8YZgM0qOf2zqRDQrDQ9NiQFXxbHyhgfwp
 65rkuDRCwrpdrVt7UnRZQhQ8wo/A==
X-Google-Smtp-Source: AGHT+IFCPS7Spgx8cnfKpo5KLgUOrhkYzpYWdtPgSAvVX+fZ4aZHx8cK8kJCJ069SpHsuFOuSI500T+C4g==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a25:3617:0:b0:e13:c772:5c18 with
 SMTP id
 3f1490d57ef6-e17a866a769mr20563276.12.1724741141704; Mon, 26 Aug 2024
 23:45:41 -0700 (PDT)
Date: Mon, 26 Aug 2024 23:45:10 -0700
In-Reply-To: <20240827064529.1246786-1-tavip@google.com>
Mime-Version: 1.0
References: <20240827064529.1246786-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240827064529.1246786-7-tavip@google.com>
Subject: [RFC PATCH v3 06/24] hw/char: add support for flexcomm usart
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr, 
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org, jsnow@redhat.com, 
 crosa@redhat.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3FXbNZgUKCnQlSnahYggYdW.UgeiWem-VWnWdfgfYfm.gjY@flex--tavip.bounces.google.com;
 helo=mail-yb1-xb49.google.com
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

Add support for NXP's flexcomm usart. It supports interupts and FIFO
access but no DMA.

The patch includes an automatically generated header which contains
the register layout and helpers.

The header can be regenerated with the svd-flexcomm-usart target when
the build is configured with --enable-mcux-soc-svd.

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 include/hw/arm/svd/flexcomm_usart.h | 1023 +++++++++++++++++++++++++++
 include/hw/char/flexcomm_usart.h    |   20 +
 include/hw/misc/flexcomm.h          |    5 +
 hw/char/flexcomm_usart.c            |  306 ++++++++
 hw/misc/flexcomm.c                  |    9 +
 hw/arm/svd/meson.build              |    3 +
 hw/char/meson.build                 |    1 +
 hw/char/trace-events                |    9 +
 8 files changed, 1376 insertions(+)
 create mode 100644 include/hw/arm/svd/flexcomm_usart.h
 create mode 100644 include/hw/char/flexcomm_usart.h
 create mode 100644 hw/char/flexcomm_usart.c

diff --git a/include/hw/arm/svd/flexcomm_usart.h b/include/hw/arm/svd/flexcomm_usart.h
new file mode 100644
index 0000000000..fc85ff897f
--- /dev/null
+++ b/include/hw/arm/svd/flexcomm_usart.h
@@ -0,0 +1,1023 @@
+/*
+ * Copyright 2016-2023 NXP SPDX-License-Identifier: BSD-3-Clause
+ *
+ * Automatically generated by svd-gen-header.py from MIMXRT595S_cm33.xml
+ */
+#pragma once
+
+#include "hw/register.h"
+
+#include "hw/registerfields.h"
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
index 0000000000..07d14cb330
--- /dev/null
+++ b/include/hw/char/flexcomm_usart.h
@@ -0,0 +1,20 @@
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
+#ifndef HW_CHAR_FLEXCOMM_USART_H
+#define HW_CHAR_FLEXCOMM_USART_H
+
+#include "hw/misc/flexcomm.h"
+
+void flexcomm_usart_init(FlexcommState *s);
+void flexcomm_usart_register(void);
+
+#endif /* HW_CHAR_RT500_FLEXCOMM_USART_H */
diff --git a/include/hw/misc/flexcomm.h b/include/hw/misc/flexcomm.h
index 137e483412..a4dfdb225f 100644
--- a/include/hw/misc/flexcomm.h
+++ b/include/hw/misc/flexcomm.h
@@ -13,7 +13,9 @@
 #define HW_FLEXCOMM_H
 
 #include "hw/sysbus.h"
+#include "chardev/char-fe.h"
 #include "hw/arm/svd/flexcomm.h"
+#include "hw/arm/svd/flexcomm_usart.h"
 #include "qemu/fifo32.h"
 
 #define TYPE_FLEXCOMM "flexcomm"
@@ -43,6 +45,9 @@ typedef struct {
     uint32_t functions;
     qemu_irq irq;
     bool irq_state;
+    CharBackend chr;
+    Fifo32 tx_fifo;
+    Fifo32 rx_fifo;
 } FlexcommState;
 
 typedef struct {
diff --git a/hw/char/flexcomm_usart.c b/hw/char/flexcomm_usart.c
new file mode 100644
index 0000000000..4e097b6990
--- /dev/null
+++ b/hw/char/flexcomm_usart.c
@@ -0,0 +1,306 @@
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
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "exec/address-spaces.h"
+#include "qapi/error.h"
+#include "trace.h"
+#include "hw/char/flexcomm_usart.h"
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
+static void flexcomm_usart_reset(FlexcommState *s)
+{
+    for (int i = 0; i < FLEXCOMM_USART_REGS_NO; i++) {
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
+static void update_fifo_stat(FlexcommState *s)
+{
+    int rxlvl = fifo32_num_used(&s->rx_fifo);
+    int txlvl = fifo32_num_used(&s->tx_fifo);
+
+    RF_RD(s, FIFOSTAT, RXLVL, fifo32_num_used(&s->rx_fifo));
+    RF_RD(s, FIFOSTAT, TXLVL, fifo32_num_used(&s->tx_fifo));
+    RF_RD(s, FIFOSTAT, RXFULL, fifo32_is_full(&s->rx_fifo));
+    RF_RD(s, FIFOSTAT, RXNOTEMPTY, !fifo32_is_empty(&s->rx_fifo));
+    RF_RD(s, FIFOSTAT, TXNOTFULL, !fifo32_is_full(&s->tx_fifo));
+    RF_RD(s, FIFOSTAT, TXEMPTY, fifo32_is_empty(&s->tx_fifo));
+
+    if (RF_WR(s, FIFOTRIG, RXLVLENA) &&
+        (rxlvl > RF_WR(s, FIFOTRIG, RXLVL))) {
+        RF_RD(s, FIFOINTSTAT, RXLVL, 1);
+    } else {
+        RF_RD(s, FIFOINTSTAT, RXLVL, 0);
+    }
+
+    if (RF_WR(s, FIFOTRIG, TXLVLENA) &&
+        (txlvl <= RF_WR(s, FIFOTRIG, TXLVL))) {
+        RF_RD(s, FIFOINTSTAT, TXLVL, 1);
+    } else {
+        RF_RD(s, FIFOINTSTAT, TXLVL, 0);
+    }
+
+    trace_flexcomm_usart_fifostat(DEVICE(s)->id, REG(s, FIFOSTAT),
+                                  REG(s, FIFOINTSTAT));
+}
+
+static void flexcomm_usart_irq_update(FlexcommState *s)
+{
+    bool irq, per_irqs, fifo_irqs, enabled = RF_WR(s, CFG, ENABLE);
+
+    update_fifo_stat(s);
+    fifo_irqs = REG(s, FIFOINTSTAT) & REG(s, FIFOINTENSET);
+
+    REG(s, INTSTAT) = REG(s, STAT) & REG(s, INTENSET);
+    per_irqs = REG(s, INTSTAT) != 0;
+
+    irq = enabled && (fifo_irqs || per_irqs);
+
+    trace_flexcomm_usart_irq(DEVICE(s)->id, irq, fifo_irqs, per_irqs, enabled);
+    flexcomm_irq(s, irq);
+}
+
+static int flexcomm_usart_rx_space(void *opaque)
+{
+    FlexcommState *s = opaque;
+    uint32_t ret = fifo32_num_free(&s->rx_fifo);
+
+    if (!RF_WR(s, CFG, ENABLE) || !RF_WR(s, FIFOCFG, ENABLERX)) {
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
+    FlexcommState *s = opaque;
+
+    if (!RF_WR(s, CFG, ENABLE) || !RF_WR(s, FIFOCFG, ENABLERX)) {
+        return;
+    }
+
+    trace_flexcomm_usart_rx(DEVICE(s)->id);
+
+    while (!fifo32_is_full(&s->rx_fifo) && size) {
+        fifo32_push(&s->rx_fifo, *buf++);
+        size--;
+    }
+
+    flexcomm_usart_irq_update(s);
+}
+
+static MemTxResult flexcomm_usart_reg_read(void *opaque, FlexcommState *s,
+                                          int f, hwaddr addr, uint64_t *data,
+                                          unsigned size)
+{
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
+        if (!fifo32_is_empty(&s->rx_fifo)) {
+            *data = fifo32_pop(&s->rx_fifo);
+            qemu_chr_fe_accept_input(&s->chr);
+        }
+        break;
+    }
+    case A_FLEXCOMM_USART_FIFORDNOPOP:
+    {
+        if (!fifo32_is_empty(&s->rx_fifo)) {
+            *data = fifo32_peek(&s->rx_fifo);
+        }
+        break;
+    }
+    default:
+        *data = s->regs[addr / 4];
+        break;
+    }
+
+    flexcomm_usart_irq_update(s);
+
+out:
+    trace_flexcomm_usart_reg_read(DEVICE(s)->id, rai->name, addr, *data);
+    return ret;
+}
+
+static MemTxResult flexcomm_usart_reg_write(void *opaque, FlexcommState *s,
+                                           int f, hwaddr addr, uint64_t value,
+                                           unsigned size)
+{
+    const struct RegisterAccessInfo *rai = &reg_info[addr / 4];
+    struct RegisterInfo ri = {
+        .data = &s->regs[addr / 4],
+        .data_size = 4,
+        .access = rai,
+    };
+
+    trace_flexcomm_usart_reg_write(DEVICE(s)->id, rai->name, addr, value);
+
+    if (size != 4) {
+        return MEMTX_ERROR;
+    }
+
+    switch (addr) {
+    case A_FLEXCOMM_USART_INTENCLR:
+    {
+        register_write(&ri, value, ~0, NULL, false);
+        REG(s, INTENSET) &= ~REG(s, INTENCLR);
+        break;
+    }
+    case A_FLEXCOMM_USART_FIFOCFG:
+    {
+        register_write(&ri, value, ~0, NULL, false);
+        if (RF_WR(s, FIFOCFG, EMPTYRX)) {
+            RF_RD(s, FIFOCFG, EMPTYRX, 0);
+            fifo32_reset(&s->rx_fifo);
+        }
+        if (RF_WR(s, FIFOCFG, EMPTYTX)) {
+            RF_RD(s, FIFOCFG, EMPTYTX, 0);
+            fifo32_reset(&s->tx_fifo);
+        }
+        break;
+    }
+    case A_FLEXCOMM_USART_FIFOSTAT:
+    {
+        bool rxerr = RF_WR(s, FIFOSTAT, RXERR);
+        bool txerr = RF_WR(s, FIFOSTAT, TXERR);
+
+        register_write(&ri, value, ~0, NULL, false);
+
+        if (rxerr && RF_WR(s, FIFOSTAT, RXERR)) {
+            rxerr = false;
+        }
+        if (txerr && RF_WR(s, FIFOSTAT, TXERR)) {
+            txerr = false;
+        }
+
+        RF_RD(s, FIFOSTAT, RXERR, rxerr);
+        RF_RD(s, FIFOSTAT, TXERR, txerr);
+        break;
+    }
+    case A_FLEXCOMM_USART_FIFOINTENSET:
+    {
+        REG(s, FIFOINTENSET) |= value;
+        break;
+    }
+    case A_FLEXCOMM_USART_FIFOINTENCLR:
+    {
+        register_write(&ri, value, ~0, NULL, false);
+        REG(s, FIFOINTENSET) &= ~value;
+        break;
+    }
+    case A_FLEXCOMM_USART_FIFOWR:
+    {
+        register_write(&ri, value, ~0, NULL, false);
+
+        if (!fifo32_is_full(&s->tx_fifo)) {
+            fifo32_push(&s->tx_fifo, REG(s, FIFOWR));
+        }
+
+        if (!RF_WR(s, CFG, ENABLE) || !RF_WR(s, FIFOCFG, ENABLETX)) {
+            break;
+        }
+
+        while (!fifo32_is_empty(&s->tx_fifo)) {
+            uint32_t val32 = fifo32_pop(&s->tx_fifo);
+            uint8_t val8 = val32 & 0xff;
+
+            trace_flexcomm_usart_tx(DEVICE(s)->id);
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
+    flexcomm_usart_irq_update(s);
+
+    return MEMTX_OK;
+}
+
+static void flexcomm_usart_select(void *opaque, FlexcommState *s, int f,
+                                 bool set)
+{
+    if (set) {
+        qemu_chr_fe_set_handlers(&s->chr, flexcomm_usart_rx_space,
+                             flexcomm_usart_rx, NULL, NULL,
+                             s, NULL, true);
+        flexcomm_usart_reset(s);
+        fifo32_create(&s->rx_fifo, RF_WR(s, FIFOSIZE, FIFOSIZE));
+        fifo32_create(&s->tx_fifo, RF_WR(s, FIFOSIZE, FIFOSIZE));
+    } else {
+        qemu_chr_fe_set_handlers(&s->chr, NULL, NULL, NULL, NULL, NULL, NULL,
+                                 false);
+        fifo32_destroy(&s->rx_fifo);
+        fifo32_destroy(&s->tx_fifo);
+    }
+}
+
+static const FlexcommFunctionOps flexcomm_usart_ops = {
+    .select = flexcomm_usart_select,
+    .reg_read = flexcomm_usart_reg_read,
+    .reg_write = flexcomm_usart_reg_write,
+};
+
+void flexcomm_usart_init(FlexcommState *s)
+{
+}
+
+void flexcomm_usart_register(void)
+{
+    Error *err = NULL;
+
+    if (!flexcomm_register_ops(FLEXCOMM_FUNC_USART, NULL,
+                               &flexcomm_usart_ops, &err)) {
+        error_report_err(err);
+    }
+}
diff --git a/hw/misc/flexcomm.c b/hw/misc/flexcomm.c
index 2bac4f008e..3d296b50d3 100644
--- a/hw/misc/flexcomm.c
+++ b/hw/misc/flexcomm.c
@@ -21,6 +21,7 @@
 #include "qapi/error.h"
 #include "trace.h"
 #include "hw/misc/flexcomm.h"
+#include "hw/char/flexcomm_usart.h"
 
 #define REG(s, reg) (s->regs[R_FLEXCOMM_##reg])
 #define RF_WR(s, reg, field, val) \
@@ -225,6 +226,7 @@ static const MemoryRegionOps flexcomm_ops = {
 static Property flexcomm_properties[] = {
     DEFINE_PROP_UINT32("functions", FlexcommState, functions,
                        FLEXCOMM_FULL),
+    DEFINE_PROP_CHR("chardev", FlexcommState, chr),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -243,6 +245,11 @@ static void flexcomm_init(Object *obj)
 
 static void flexcomm_realize(DeviceState *dev, Error **errp)
 {
+    FlexcommState *s = FLEXCOMM(dev);
+
+    if (has_function(s, FLEXCOMM_FUNC_USART)) {
+        flexcomm_usart_init(s);
+    }
 }
 
 static void flexcomm_class_init(ObjectClass *klass, void *data)
@@ -252,6 +259,8 @@ static void flexcomm_class_init(ObjectClass *klass, void *data)
     dc->reset = flexcomm_reset;
     device_class_set_props(dc, flexcomm_properties);
     dc->realize = flexcomm_realize;
+
+    flexcomm_usart_register();
 }
 
 static const TypeInfo flexcomm_types[] = {
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
index e5b13b6958..8f8c17ae66 100644
--- a/hw/char/meson.build
+++ b/hw/char/meson.build
@@ -39,3 +39,4 @@ system_ss.add(when: 'CONFIG_GOLDFISH_TTY', if_true: files('goldfish_tty.c'))
 specific_ss.add(when: 'CONFIG_TERMINAL3270', if_true: files('terminal3270.c'))
 specific_ss.add(when: 'CONFIG_VIRTIO', if_true: files('virtio-serial-bus.c'))
 specific_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr_vty.c'))
+system_ss.add(when: 'CONFIG_FLEXCOMM', if_true: files('flexcomm_usart.c'))
diff --git a/hw/char/trace-events b/hw/char/trace-events
index 8875758076..19fcf1f832 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -125,3 +125,12 @@ xen_console_unrealize(unsigned int idx) "idx %u"
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
+flexcomm_usart_fifostat(const char *id, uint32_t fifostat, uint32_t fifoinstat) "%s: %08x %08x"
+flexcomm_usart_irq(const char *id, bool irq, bool fifoirqs, bool perirqs, bool enabled) "%s: %d %d %d %d"
-- 
2.46.0.295.g3b9ea8a38a-goog


