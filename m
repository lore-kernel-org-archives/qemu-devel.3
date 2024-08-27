Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 475D2C5320E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 06:51:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sipyL-0004Oe-ES; Tue, 27 Aug 2024 02:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3GXbNZgUKCngpWrelckkcha.Ykimaiq-Zarahjkjcjq.knc@flex--tavip.bounces.google.com>)
 id 1sipxm-0003ZI-RO
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 02:46:05 -0400
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3GXbNZgUKCngpWrelckkcha.Ykimaiq-Zarahjkjcjq.knc@flex--tavip.bounces.google.com>)
 id 1sipxd-00066l-R1
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 02:45:56 -0400
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-2d3df5f6c80so4901375a91.3
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 23:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1724741147; x=1725345947; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=bU70bdcufemm1O9NAVTUDPyNlNzxR5BGl9YSnH8Np+c=;
 b=sp9Z+PUjTyIFD8vZYLj/OkBlvli21OdkWu8SatSiuWId7ENLl+x1s8OmF9lWJfT2Qs
 kszsgl2omzjedoefvKQWpnYmAb15m8lbEZemEbG9noHLPbJ3cHZFYorxgcB6/7K2re0P
 WwaSu0GSUtWHwVjaLrqC6jwJev9vCyp7xHp/CkAXOFGfGgoDR4TEj3A47k4VCpDziLWo
 1hoPdaInP9SEg4ragn/YHDdezFkppfNRs2nukoF8+1ylOugw1r7H5EruxZgAzvvQmoR5
 vvCEiJ+LCgc9nbl1MG6CgI467kOFNfB9pgjfQrxjVYqFY1V8d0VjcOLxY4KzIsi29aGs
 nbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724741147; x=1725345947;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bU70bdcufemm1O9NAVTUDPyNlNzxR5BGl9YSnH8Np+c=;
 b=Vh7XEcM5TTRztlmAdlNwbxyJnspZQ2qZ6T/8yqFMNICekiwVBNR+Mmu7M83Ugy2PPN
 qfaxAJsCf3Qck3IdjTQhpl/bwOiazPo795DYlwymVp06+iEKqjmUeQMHs0vvEgOt6yt/
 1iM0EGzV6GLlk61fNMoDR0OhkJSKs+EjTQ5Y2cxDFIJlg2W2a1YcQlfFLaRC1+zShBYj
 bQ4ygXYQBTTe2MEEm8b1+ttKPEHoi+sdLGvUgfEux/ZL7auNT2nZxS6U5lfjcXCtef9b
 sSPrMsvedUTpBM5dssdNP2vMXJs/ivMq+Wp+qgMxSXYTM0TitJawmsJ+Y8WLPnJoF4fM
 8mHA==
X-Gm-Message-State: AOJu0Ywxrx2/cRurrIEbtcvpDu1/xYteCliXNzm2xzuWjan5jymJ7TvY
 X+rK+hq78AKt+ClB1czxh9AY09cKex8kkqVR2A8VHoQx+U4T/3LUJRtmD2rFCsf02U2G1RJ3/pX
 og4JNdbliqGslDBCayGpsiiLjGws4Fzof2AGRlueJ2IqpLdGBLwcPmqcIBeLRVNX6LzBcbgiML8
 NxD9XbBPuFjmspmj/moTtI4dn4GQ==
X-Google-Smtp-Source: AGHT+IH3yme6YTlxNzCHhBc1Wo4fCxrrSi6Y/OqhocyCbIUTx97Zl9Qo9vU8cFrzTlhGuTjkd/mBqB1ZcA==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a17:90a:2f45:b0:2d3:c2ee:8e06
 with SMTP id
 98e67ed59e1d1-2d8259d530emr3698a91.6.1724741145727; Mon, 26 Aug 2024 23:45:45
 -0700 (PDT)
Date: Mon, 26 Aug 2024 23:45:12 -0700
In-Reply-To: <20240827064529.1246786-1-tavip@google.com>
Mime-Version: 1.0
References: <20240827064529.1246786-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240827064529.1246786-9-tavip@google.com>
Subject: [RFC PATCH v3 08/24] hw/ssi: add support for flexcomm spi
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr, 
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org, jsnow@redhat.com, 
 crosa@redhat.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3GXbNZgUKCngpWrelckkcha.Ykimaiq-Zarahjkjcjq.knc@flex--tavip.bounces.google.com;
 helo=mail-pj1-x104a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
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

From: Sebastian Ene <sebastianene@google.com>

Add support for NXP's flexcomm spi. It supports FIFO access,
interrupts and master mode only. It does not support DMA.

The patch includes an automatically generated header which contains
the register layout and helpers.

The header can be regenerated with the svd-flexcomm-spi target when
the build is configured with --enable-mcux-soc-svd.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
[tavip: add suport for CFG.SPOL, CFG.LSBF, TX control flags per FIFO
entry and 8/16 bit access to FIFORD and FIFOWR]
Signed-off-by: Octavian Purdila <tavip@google.com>
---
 include/hw/arm/svd/flexcomm_spi.h | 1038 +++++++++++++++++++++++++++++
 include/hw/misc/flexcomm.h        |    7 +
 include/hw/ssi/flexcomm_spi.h     |   20 +
 hw/misc/flexcomm.c                |    6 +
 hw/ssi/flexcomm_spi.c             |  442 ++++++++++++
 hw/arm/svd/meson.build            |    3 +
 hw/ssi/meson.build                |    1 +
 hw/ssi/trace-events               |    8 +
 8 files changed, 1525 insertions(+)
 create mode 100644 include/hw/arm/svd/flexcomm_spi.h
 create mode 100644 include/hw/ssi/flexcomm_spi.h
 create mode 100644 hw/ssi/flexcomm_spi.c

diff --git a/include/hw/arm/svd/flexcomm_spi.h b/include/hw/arm/svd/flexcomm_spi.h
new file mode 100644
index 0000000000..51d8a27ef8
--- /dev/null
+++ b/include/hw/arm/svd/flexcomm_spi.h
@@ -0,0 +1,1038 @@
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
+/* Serial Peripheral Interfaces (SPI) */
+#define FLEXCOMM_SPI_REGS_NO (1024)
+
+/* Configuration Register */
+REG32(FLEXCOMM_SPI_CFG, 1024);
+/* SPI Enable */
+FIELD(FLEXCOMM_SPI_CFG, ENABLE, 0, 1);
+/* Master Mode Select */
+FIELD(FLEXCOMM_SPI_CFG, MASTER, 2, 1);
+/* LSB First Mode Enable */
+FIELD(FLEXCOMM_SPI_CFG, LSBF, 3, 1);
+/* Clock Phase Select */
+FIELD(FLEXCOMM_SPI_CFG, CPHA, 4, 1);
+/* Clock Polarity Select */
+FIELD(FLEXCOMM_SPI_CFG, CPOL, 5, 1);
+/* Loopback Mode Enable */
+FIELD(FLEXCOMM_SPI_CFG, LOOP, 7, 1);
+/* SSEL0 Polarity Select */
+FIELD(FLEXCOMM_SPI_CFG, SPOL0, 8, 1);
+/* SSEL1 Polarity Select */
+FIELD(FLEXCOMM_SPI_CFG, SPOL1, 9, 1);
+/* SSEL2 Polarity Select */
+FIELD(FLEXCOMM_SPI_CFG, SPOL2, 10, 1);
+/* SSEL3 Polarity Select */
+FIELD(FLEXCOMM_SPI_CFG, SPOL3, 11, 1);
+
+/* Delay Register */
+REG32(FLEXCOMM_SPI_DLY, 1028);
+/* Pre-Delay */
+FIELD(FLEXCOMM_SPI_DLY, PRE_DELAY, 0, 4);
+/* Post-Delay */
+FIELD(FLEXCOMM_SPI_DLY, POST_DELAY, 4, 4);
+/* Frame Delay */
+FIELD(FLEXCOMM_SPI_DLY, FRAME_DELAY, 8, 4);
+/* Transfer Delay */
+FIELD(FLEXCOMM_SPI_DLY, TRANSFER_DELAY, 12, 4);
+
+/* Status Register */
+REG32(FLEXCOMM_SPI_STAT, 1032);
+/* Slave Select Assert */
+FIELD(FLEXCOMM_SPI_STAT, SSA, 4, 1);
+/* Slave Select Deassert */
+FIELD(FLEXCOMM_SPI_STAT, SSD, 5, 1);
+/* Stalled Status Flag */
+FIELD(FLEXCOMM_SPI_STAT, STALLED, 6, 1);
+/* End Transfer Control */
+FIELD(FLEXCOMM_SPI_STAT, ENDTRANSFER, 7, 1);
+/* Master Idle Status Flag */
+FIELD(FLEXCOMM_SPI_STAT, MSTIDLE, 8, 1);
+
+/* Interrupt Enable Register */
+REG32(FLEXCOMM_SPI_INTENSET, 1036);
+/* Slave Select Assert Interrupt Enable */
+FIELD(FLEXCOMM_SPI_INTENSET, SSAEN, 4, 1);
+/* Slave Select Deassert Interrupt Enable */
+FIELD(FLEXCOMM_SPI_INTENSET, SSDEN, 5, 1);
+/* Master Idle Interrupt Enable */
+FIELD(FLEXCOMM_SPI_INTENSET, MSTIDLEEN, 8, 1);
+
+/* Interrupt Enable Clear Register */
+REG32(FLEXCOMM_SPI_INTENCLR, 1040);
+/* Slave Select Assert Interrupt Enable */
+FIELD(FLEXCOMM_SPI_INTENCLR, SSAEN, 4, 1);
+/* Slave Select Deassert Interrupt Enable */
+FIELD(FLEXCOMM_SPI_INTENCLR, SSDEN, 5, 1);
+/* Master Idle Interrupt Enable */
+FIELD(FLEXCOMM_SPI_INTENCLR, MSTIDLE, 8, 1);
+
+/* Clock Divider Register */
+REG32(FLEXCOMM_SPI_DIV, 1060);
+/* Rate Divider Value */
+FIELD(FLEXCOMM_SPI_DIV, DIVVAL, 0, 16);
+
+/* Interrupt Status Register */
+REG32(FLEXCOMM_SPI_INTSTAT, 1064);
+/* Slave Select Assert Interrupt */
+FIELD(FLEXCOMM_SPI_INTSTAT, SSA, 4, 1);
+/* Slave Select Deassert Interrupt */
+FIELD(FLEXCOMM_SPI_INTSTAT, SSD, 5, 1);
+/* Master Idle Status Flag Interrupt */
+FIELD(FLEXCOMM_SPI_INTSTAT, MSTIDLE, 8, 1);
+
+/* FIFO Configuration Register */
+REG32(FLEXCOMM_SPI_FIFOCFG, 3584);
+/* Enable the Transmit FIFO */
+FIELD(FLEXCOMM_SPI_FIFOCFG, ENABLETX, 0, 1);
+/* Enable the Receive FIFO */
+FIELD(FLEXCOMM_SPI_FIFOCFG, ENABLERX, 1, 1);
+/* FIFO Size Configuration */
+FIELD(FLEXCOMM_SPI_FIFOCFG, SIZE, 4, 2);
+/* DMA Configuration for Transmit */
+FIELD(FLEXCOMM_SPI_FIFOCFG, DMATX, 12, 1);
+/* DMA Configuration for Receive */
+FIELD(FLEXCOMM_SPI_FIFOCFG, DMARX, 13, 1);
+/* Wake-up for Transmit FIFO Level */
+FIELD(FLEXCOMM_SPI_FIFOCFG, WAKETX, 14, 1);
+/* Wake-up for Receive FIFO Level */
+FIELD(FLEXCOMM_SPI_FIFOCFG, WAKERX, 15, 1);
+/* Empty Command for the Transmit FIFO */
+FIELD(FLEXCOMM_SPI_FIFOCFG, EMPTYTX, 16, 1);
+/* Empty Command for the Receive FIFO */
+FIELD(FLEXCOMM_SPI_FIFOCFG, EMPTYRX, 17, 1);
+/* Pop FIFO for Debug Reads */
+FIELD(FLEXCOMM_SPI_FIFOCFG, POPDBG, 18, 1);
+
+/* FIFO Status Register */
+REG32(FLEXCOMM_SPI_FIFOSTAT, 3588);
+/* TX FIFO Error */
+FIELD(FLEXCOMM_SPI_FIFOSTAT, TXERR, 0, 1);
+/* RX FIFO Error */
+FIELD(FLEXCOMM_SPI_FIFOSTAT, RXERR, 1, 1);
+/* Peripheral Interrupt */
+FIELD(FLEXCOMM_SPI_FIFOSTAT, PERINT, 3, 1);
+/* Transmit FIFO Empty */
+FIELD(FLEXCOMM_SPI_FIFOSTAT, TXEMPTY, 4, 1);
+/* Transmit FIFO is Not Full */
+FIELD(FLEXCOMM_SPI_FIFOSTAT, TXNOTFULL, 5, 1);
+/* Receive FIFO is Not Empty */
+FIELD(FLEXCOMM_SPI_FIFOSTAT, RXNOTEMPTY, 6, 1);
+/* Receive FIFO is Full */
+FIELD(FLEXCOMM_SPI_FIFOSTAT, RXFULL, 7, 1);
+/* Transmit FIFO Current Level */
+FIELD(FLEXCOMM_SPI_FIFOSTAT, TXLVL, 8, 5);
+/* Receive FIFO Current Level */
+FIELD(FLEXCOMM_SPI_FIFOSTAT, RXLVL, 16, 5);
+
+/* FIFO Trigger Register */
+REG32(FLEXCOMM_SPI_FIFOTRIG, 3592);
+/* Transmit FIFO Level Trigger Enable */
+FIELD(FLEXCOMM_SPI_FIFOTRIG, TXLVLENA, 0, 1);
+/* Receive FIFO Level Trigger Enable */
+FIELD(FLEXCOMM_SPI_FIFOTRIG, RXLVLENA, 1, 1);
+/* Transmit FIFO Level Trigger Point */
+FIELD(FLEXCOMM_SPI_FIFOTRIG, TXLVL, 8, 4);
+/* Receive FIFO Level Trigger Point */
+FIELD(FLEXCOMM_SPI_FIFOTRIG, RXLVL, 16, 4);
+
+/* FIFO Interrupt Enable Register */
+REG32(FLEXCOMM_SPI_FIFOINTENSET, 3600);
+/* TX Error Interrupt Enable */
+FIELD(FLEXCOMM_SPI_FIFOINTENSET, TXERR, 0, 1);
+/* Receive Error Interrupt Enable */
+FIELD(FLEXCOMM_SPI_FIFOINTENSET, RXERR, 1, 1);
+/* Transmit FIFO Level Interrupt Enable */
+FIELD(FLEXCOMM_SPI_FIFOINTENSET, TXLVL, 2, 1);
+/* Receive FIFO Level Interrupt Enable */
+FIELD(FLEXCOMM_SPI_FIFOINTENSET, RXLVL, 3, 1);
+
+/* FIFO Interrupt Enable Clear Register */
+REG32(FLEXCOMM_SPI_FIFOINTENCLR, 3604);
+/* TX Error Interrupt Enable */
+FIELD(FLEXCOMM_SPI_FIFOINTENCLR, TXERR, 0, 1);
+/* Receive Error Interrupt Enable */
+FIELD(FLEXCOMM_SPI_FIFOINTENCLR, RXERR, 1, 1);
+/* Transmit FIFO Level Interrupt Enable */
+FIELD(FLEXCOMM_SPI_FIFOINTENCLR, TXLVL, 2, 1);
+/* Receive FIFO Level Interrupt Enable */
+FIELD(FLEXCOMM_SPI_FIFOINTENCLR, RXLVL, 3, 1);
+
+/* FIFO Interrupt Status Register */
+REG32(FLEXCOMM_SPI_FIFOINTSTAT, 3608);
+/* TX FIFO Error Interrupt Status */
+FIELD(FLEXCOMM_SPI_FIFOINTSTAT, TXERR, 0, 1);
+/* RX FIFO Error Interrupt Status */
+FIELD(FLEXCOMM_SPI_FIFOINTSTAT, RXERR, 1, 1);
+/* Transmit FIFO Level Interrupt Status */
+FIELD(FLEXCOMM_SPI_FIFOINTSTAT, TXLVL, 2, 1);
+/* Receive FIFO Level Interrupt Status */
+FIELD(FLEXCOMM_SPI_FIFOINTSTAT, RXLVL, 3, 1);
+/* Peripheral Interrupt Status */
+FIELD(FLEXCOMM_SPI_FIFOINTSTAT, PERINT, 4, 1);
+
+/* FIFO Write Data Register */
+REG32(FLEXCOMM_SPI_FIFOWR, 3616);
+/* Transmit Data to the FIFO */
+FIELD(FLEXCOMM_SPI_FIFOWR, TXDATA, 0, 16);
+/* Transmit Slave Select 0 */
+FIELD(FLEXCOMM_SPI_FIFOWR, TXSSEL0_N, 16, 1);
+/* Transmit Slave Select 1 */
+FIELD(FLEXCOMM_SPI_FIFOWR, TXSSEL1_N, 17, 1);
+/* Transmit Slave Select 2 */
+FIELD(FLEXCOMM_SPI_FIFOWR, TXSSEL2_N, 18, 1);
+/* Transmit Slave Select 3 */
+FIELD(FLEXCOMM_SPI_FIFOWR, TXSSEL3_N, 19, 1);
+/* End of Transfer */
+FIELD(FLEXCOMM_SPI_FIFOWR, EOT, 20, 1);
+/* End of Frame */
+FIELD(FLEXCOMM_SPI_FIFOWR, EOF, 21, 1);
+/* Receive Ignore */
+FIELD(FLEXCOMM_SPI_FIFOWR, RXIGNORE, 22, 1);
+/* Transmit Ignore */
+FIELD(FLEXCOMM_SPI_FIFOWR, TXIGNORE, 23, 1);
+/* Data Length */
+FIELD(FLEXCOMM_SPI_FIFOWR, LEN, 24, 4);
+
+/* FIFO Read Data Register */
+REG32(FLEXCOMM_SPI_FIFORD, 3632);
+/* Received Data from the FIFO */
+FIELD(FLEXCOMM_SPI_FIFORD, RXDATA, 0, 16);
+/* Slave Select 0 for Receive */
+FIELD(FLEXCOMM_SPI_FIFORD, RXSSEL0_N, 16, 1);
+/* Slave Select 1 for Receive */
+FIELD(FLEXCOMM_SPI_FIFORD, RXSSEL1_N, 17, 1);
+/* Slave Select 2 for Receive */
+FIELD(FLEXCOMM_SPI_FIFORD, RXSSEL2_N, 18, 1);
+/* Slave Select 3 for Receive */
+FIELD(FLEXCOMM_SPI_FIFORD, RXSSEL3_N, 19, 1);
+/* Start of Transfer Flag */
+FIELD(FLEXCOMM_SPI_FIFORD, SOT, 20, 1);
+
+/* FIFO Data Read with no FIFO Pop Register */
+REG32(FLEXCOMM_SPI_FIFORDNOPOP, 3648);
+/* Received Data from the FIFO */
+FIELD(FLEXCOMM_SPI_FIFORDNOPOP, RXDATA, 0, 16);
+/* Slave Select 0 for Receive */
+FIELD(FLEXCOMM_SPI_FIFORDNOPOP, RXSSEL0_N, 16, 1);
+/* Slave Select 1 for Receive */
+FIELD(FLEXCOMM_SPI_FIFORDNOPOP, RXSSEL1_N, 17, 1);
+/* Slave Select 2 for Receive */
+FIELD(FLEXCOMM_SPI_FIFORDNOPOP, RXSSEL2_N, 18, 1);
+/* Slave Select 3 for Receive */
+FIELD(FLEXCOMM_SPI_FIFORDNOPOP, RXSSEL3_N, 19, 1);
+/* Start of Transfer Flag */
+FIELD(FLEXCOMM_SPI_FIFORDNOPOP, SOT, 20, 1);
+
+/* FIFO Size Register */
+REG32(FLEXCOMM_SPI_FIFOSIZE, 3656);
+/* FIFO Size */
+FIELD(FLEXCOMM_SPI_FIFOSIZE, FIFOSIZE, 0, 5);
+
+/* Peripheral Identification Register */
+REG32(FLEXCOMM_SPI_ID, 4092);
+/* Aperture */
+FIELD(FLEXCOMM_SPI_ID, APERTURE, 0, 8);
+/* Minor revision of module implementation */
+FIELD(FLEXCOMM_SPI_ID, MINOR_REV, 8, 4);
+/* Major revision of module implementation */
+FIELD(FLEXCOMM_SPI_ID, MAJOR_REV, 12, 4);
+/* Module identifier for the selected function */
+FIELD(FLEXCOMM_SPI_ID, ID, 16, 16);
+
+
+typedef enum {
+    /*
+     * Disabled. The SPI is disabled and the internal state machine and
+     * counters are reset.
+     */
+    FLEXCOMM_SPI_CFG_ENABLE_DISABLED = 0,
+    /* Enabled. The SPI is enabled for operation. */
+    FLEXCOMM_SPI_CFG_ENABLE_ENABLED = 1,
+} FLEXCOMM_SPI_CFG_ENABLE_Enum;
+
+typedef enum {
+    /*
+     * Slave mode. The SPI will operate in slave mode. SCK, MOSI, and the SSEL
+     * signals are inputs; MISO is an output.
+     */
+    FLEXCOMM_SPI_CFG_MASTER_SLAVE_MODE = 0,
+    /*
+     * Master mode. The SPI will operate in master mode. SCK, MOSI, and the
+     * SSEL signals are outputs; MISO is an input.
+     */
+    FLEXCOMM_SPI_CFG_MASTER_MASTER_MODE = 1,
+} FLEXCOMM_SPI_CFG_MASTER_Enum;
+
+typedef enum {
+    /*
+     * Standard. Data is transmitted and received in standard MSB-first order.
+     */
+    FLEXCOMM_SPI_CFG_LSBF_STANDARD = 0,
+    /*
+     * Reverse. Data is transmitted and received in reverse order (LSB first).
+     */
+    FLEXCOMM_SPI_CFG_LSBF_REVERSE = 1,
+} FLEXCOMM_SPI_CFG_LSBF_Enum;
+
+typedef enum {
+    /* Change */
+    FLEXCOMM_SPI_CFG_CPHA_CHANGE = 0,
+    /* Capture */
+    FLEXCOMM_SPI_CFG_CPHA_CAPTURE = 1,
+} FLEXCOMM_SPI_CFG_CPHA_Enum;
+
+typedef enum {
+    /* Low. The rest state of the clock (between transfers) is low. */
+    FLEXCOMM_SPI_CFG_CPOL_LOW = 0,
+    /* High. The rest state of the clock (between transfers) is high. */
+    FLEXCOMM_SPI_CFG_CPOL_HIGH = 1,
+} FLEXCOMM_SPI_CFG_CPOL_Enum;
+
+typedef enum {
+    /* Disabled */
+    FLEXCOMM_SPI_CFG_LOOP_DISABLED = 0,
+    /* Enabled */
+    FLEXCOMM_SPI_CFG_LOOP_ENABLED = 1,
+} FLEXCOMM_SPI_CFG_LOOP_Enum;
+
+typedef enum {
+    /* Low. The SSEL0 pin is active low. */
+    FLEXCOMM_SPI_CFG_SPOL0_LOW = 0,
+    /* High. The SSEL0 pin is active high. */
+    FLEXCOMM_SPI_CFG_SPOL0_HIGH = 1,
+} FLEXCOMM_SPI_CFG_SPOL0_Enum;
+
+typedef enum {
+    /* Low. The SSEL1 pin is active low. */
+    FLEXCOMM_SPI_CFG_SPOL1_LOW = 0,
+    /* High. The SSEL1 pin is active high. */
+    FLEXCOMM_SPI_CFG_SPOL1_HIGH = 1,
+} FLEXCOMM_SPI_CFG_SPOL1_Enum;
+
+typedef enum {
+    /* Low. The SSEL2 pin is active low. */
+    FLEXCOMM_SPI_CFG_SPOL2_LOW = 0,
+    /* High. The SSEL2 pin is active high. */
+    FLEXCOMM_SPI_CFG_SPOL2_HIGH = 1,
+} FLEXCOMM_SPI_CFG_SPOL2_Enum;
+
+typedef enum {
+    /* Low. The SSEL3 pin is active low. */
+    FLEXCOMM_SPI_CFG_SPOL3_LOW = 0,
+    /* High. The SSEL3 pin is active high. */
+    FLEXCOMM_SPI_CFG_SPOL3_HIGH = 1,
+} FLEXCOMM_SPI_CFG_SPOL3_Enum;
+
+typedef enum {
+    /* No additional time is inserted */
+    FLEXCOMM_SPI_DLY_PRE_DELAY_PRE_DELAY0 = 0,
+    /* 1 SPI clock time is inserted */
+    FLEXCOMM_SPI_DLY_PRE_DELAY_PRE_DELAY1 = 1,
+    /* 2 SPI clock times are inserted */
+    FLEXCOMM_SPI_DLY_PRE_DELAY_PRE_DELAY2 = 2,
+    /* 15 SPI clock times are inserted */
+    FLEXCOMM_SPI_DLY_PRE_DELAY_PRE_DELAY15 = 15,
+} FLEXCOMM_SPI_DLY_PRE_DELAY_Enum;
+
+typedef enum {
+    /* No additional time is inserted */
+    FLEXCOMM_SPI_DLY_POST_DELAY_POST_DELAY0 = 0,
+    /* 1 SPI clock time is inserted */
+    FLEXCOMM_SPI_DLY_POST_DELAY_POST_DELAY1 = 1,
+    /* 2 SPI clock times are inserted */
+    FLEXCOMM_SPI_DLY_POST_DELAY_POST_DELAY2 = 2,
+    /* 15 SPI clock times are inserted */
+    FLEXCOMM_SPI_DLY_POST_DELAY_POST_DELAY15 = 15,
+} FLEXCOMM_SPI_DLY_POST_DELAY_Enum;
+
+typedef enum {
+    /* No additional time is inserted */
+    FLEXCOMM_SPI_DLY_FRAME_DELAY_FRAME_DELAY0 = 0,
+    /* 1 SPI clock time is inserted */
+    FLEXCOMM_SPI_DLY_FRAME_DELAY_FRAME_DELAY1 = 1,
+    /* 2 SPI clock times are inserted */
+    FLEXCOMM_SPI_DLY_FRAME_DELAY_FRAME_DELAY2 = 2,
+    /* 15 SPI clock times are inserted */
+    FLEXCOMM_SPI_DLY_FRAME_DELAY_FRAME_DELAY15 = 15,
+} FLEXCOMM_SPI_DLY_FRAME_DELAY_Enum;
+
+typedef enum {
+    /*
+     * The minimum time that SSEL is deasserted is 1 SPI clock time (zero-added
+     * time)
+     */
+    FLEXCOMM_SPI_DLY_TRANSFER_DELAY_TRANSFER_DELAY1 = 0,
+    /* The minimum time that SSEL is deasserted is 2 SPI clock times */
+    FLEXCOMM_SPI_DLY_TRANSFER_DELAY_TRANSFER_DELAY2 = 1,
+    /* The minimum time that SSEL is deasserted is 3 SPI clock times */
+    FLEXCOMM_SPI_DLY_TRANSFER_DELAY_TRANSFER_DELAY3 = 2,
+    /* The minimum time that SSEL is deasserted is 16 SPI clock times */
+    FLEXCOMM_SPI_DLY_TRANSFER_DELAY_TRANSFER_DELAY16 = 15,
+} FLEXCOMM_SPI_DLY_TRANSFER_DELAY_Enum;
+
+typedef enum {
+    /*
+     * Disabled. No interrupt will be generated when any Slave Select
+     * transitions from deasserted to asserted.
+     */
+    FLEXCOMM_SPI_INTENSET_SSAEN_DISABLED = 0,
+    /*
+     * Enabled. An interrupt will be generated when any Slave Select
+     * transitions from deasserted to asserted.
+     */
+    FLEXCOMM_SPI_INTENSET_SSAEN_ENABLED = 1,
+} FLEXCOMM_SPI_INTENSET_SSAEN_Enum;
+
+typedef enum {
+    /*
+     * Disabled. No interrupt will be generated when all asserted Slave Selects
+     * transition to deasserted.
+     */
+    FLEXCOMM_SPI_INTENSET_SSDEN_DISABLED = 0,
+    /*
+     * Enabled. An interrupt will be generated when all asserted Slave Selects
+     * transition to deasserted.
+     */
+    FLEXCOMM_SPI_INTENSET_SSDEN_ENABLED = 1,
+} FLEXCOMM_SPI_INTENSET_SSDEN_Enum;
+
+typedef enum {
+    /* No interrupt will be generated when the SPI master function is idle. */
+    FLEXCOMM_SPI_INTENSET_MSTIDLEEN_DISABLED = 0,
+    /*
+     * An interrupt will be generated when the SPI master function is fully
+     * idle.
+     */
+    FLEXCOMM_SPI_INTENSET_MSTIDLEEN_ENABLED = 1,
+} FLEXCOMM_SPI_INTENSET_MSTIDLEEN_Enum;
+
+typedef enum {
+    /* No effect */
+    FLEXCOMM_SPI_INTENCLR_SSAEN_NO_EFFECT = 0,
+    /* Clear the Slave Select Assert Interrupt Enable bit (INTENSET[SSAEN]) */
+    FLEXCOMM_SPI_INTENCLR_SSAEN_CLEAR_THE_SSAEN = 1,
+} FLEXCOMM_SPI_INTENCLR_SSAEN_Enum;
+
+typedef enum {
+    /* No effect */
+    FLEXCOMM_SPI_INTENCLR_SSDEN_NO_EFFECT = 0,
+    /* Clear the Slave Select Deassert Interrupt Enable bit (INTENSET[SSDEN]) */
+    FLEXCOMM_SPI_INTENCLR_SSDEN_CLEAR_THE_SSDEN = 1,
+} FLEXCOMM_SPI_INTENCLR_SSDEN_Enum;
+
+typedef enum {
+    /* No effect */
+    FLEXCOMM_SPI_INTENCLR_MSTIDLE_NO_EFFECT = 0,
+    /* Clear the Master Idle Interrupt Enable bit (INTENSET[MSTIDLE]) */
+    FLEXCOMM_SPI_INTENCLR_MSTIDLE_CLEAR_THE_MSTIDLE = 1,
+} FLEXCOMM_SPI_INTENCLR_MSTIDLE_Enum;
+
+typedef enum {
+    /* Disabled */
+    FLEXCOMM_SPI_INTSTAT_SSA_SSA_INTERRUPT_DISABLED = 0,
+    /* Enabled */
+    FLEXCOMM_SPI_INTSTAT_SSA_SSA_INTERRUPT_ENABLED = 1,
+} FLEXCOMM_SPI_INTSTAT_SSA_Enum;
+
+typedef enum {
+    /* Disabled */
+    FLEXCOMM_SPI_INTSTAT_SSD_SSD_INTERRUPT_DISABLED = 0,
+    /* Enabled */
+    FLEXCOMM_SPI_INTSTAT_SSD_SSD_INTERRUPT_ENABLED = 1,
+} FLEXCOMM_SPI_INTSTAT_SSD_Enum;
+
+typedef enum {
+    /* Disabled */
+    FLEXCOMM_SPI_INTSTAT_MSTIDLE_MSTIDLE_INTERRUPT_DISABLED = 0,
+    /* Enabled */
+    FLEXCOMM_SPI_INTSTAT_MSTIDLE_MSTIDLE_INTERRUPT_ENABLED = 1,
+} FLEXCOMM_SPI_INTSTAT_MSTIDLE_Enum;
+
+typedef enum {
+    /* The transmit FIFO is not enabled */
+    FLEXCOMM_SPI_FIFOCFG_ENABLETX_DISABLED = 0,
+    /* The transmit FIFO is enabled */
+    FLEXCOMM_SPI_FIFOCFG_ENABLETX_ENABLED = 1,
+} FLEXCOMM_SPI_FIFOCFG_ENABLETX_Enum;
+
+typedef enum {
+    /* The receive FIFO is not enabled */
+    FLEXCOMM_SPI_FIFOCFG_ENABLERX_DISABLED = 0,
+    /* The receive FIFO is enabled */
+    FLEXCOMM_SPI_FIFOCFG_ENABLERX_ENABLED = 1,
+} FLEXCOMM_SPI_FIFOCFG_ENABLERX_Enum;
+
+typedef enum {
+    /* FIFO is configured as 16 entries of 8 bits. */
+    FLEXCOMM_SPI_FIFOCFG_SIZE_SIZE16ENTRIES8BITS = 0,
+    /* FIFO is configured as 8 entries of 16 bits. */
+    FLEXCOMM_SPI_FIFOCFG_SIZE_SIZE8ENTRIES16BITS = 1,
+    /* Not used */
+    FLEXCOMM_SPI_FIFOCFG_SIZE_SIZEINVALID2 = 2,
+    /* Not used */
+    FLEXCOMM_SPI_FIFOCFG_SIZE_SIZEINVALID3 = 3,
+} FLEXCOMM_SPI_FIFOCFG_SIZE_Enum;
+
+typedef enum {
+    /* DMA is not used for the transmit function */
+    FLEXCOMM_SPI_FIFOCFG_DMATX_DISABLED = 0,
+    /*
+     * Issues DMA request for the transmit function if the FIFO is not full.
+     * Generally, data interrupts would be disabled if DMA is enabled.
+     */
+    FLEXCOMM_SPI_FIFOCFG_DMATX_ENABLED = 1,
+} FLEXCOMM_SPI_FIFOCFG_DMATX_Enum;
+
+typedef enum {
+    /* DMA is not used for the receive function. */
+    FLEXCOMM_SPI_FIFOCFG_DMARX_DISABLED = 0,
+    /*
+     * Issues a DMA request for the receive function if the FIFO is not empty.
+     * Generally, data interrupts would be disabled if DMA is enabled.
+     */
+    FLEXCOMM_SPI_FIFOCFG_DMARX_ENABLED = 1,
+} FLEXCOMM_SPI_FIFOCFG_DMARX_Enum;
+
+typedef enum {
+    /*
+     * Only enabled interrupts will wake up the device form reduced power modes
+     */
+    FLEXCOMM_SPI_FIFOCFG_WAKETX_DISABLED = 0,
+    /*
+     * A device wake-up for DMA will occur if the transmit FIFO level reaches
+     * the value specified by TXLVL in FIFOTRIG, even when the TXLVL interrupt
+     * is not enabled.
+     */
+    FLEXCOMM_SPI_FIFOCFG_WAKETX_ENABLED = 1,
+} FLEXCOMM_SPI_FIFOCFG_WAKETX_Enum;
+
+typedef enum {
+    /*
+     * Only enabled interrupts will wake up the device form reduced power
+     * modes.
+     */
+    FLEXCOMM_SPI_FIFOCFG_WAKERX_DISABLED = 0,
+    /*
+     * A device wake-up for DMA will occur if the receive FIFO level reaches
+     * the value specified by FIFOTRIG[RXLVL], even when the RXLVL interrupt is
+     * not enabled.
+     */
+    FLEXCOMM_SPI_FIFOCFG_WAKERX_ENABLED = 1,
+} FLEXCOMM_SPI_FIFOCFG_WAKERX_Enum;
+
+typedef enum {
+    /* No effect */
+    FLEXCOMM_SPI_FIFOCFG_EMPTYTX_NO_EFFECT = 0,
+    /* The TX FIFO is emptied */
+    FLEXCOMM_SPI_FIFOCFG_EMPTYTX_EMPTY_THE_TX_FIFO = 1,
+} FLEXCOMM_SPI_FIFOCFG_EMPTYTX_Enum;
+
+typedef enum {
+    /* No effect */
+    FLEXCOMM_SPI_FIFOCFG_EMPTYRX_NO_EFFECT = 0,
+    /* The RX FIFO is emptied */
+    FLEXCOMM_SPI_FIFOCFG_EMPTYRX_EMPTY_THE_RX_FIFO = 1,
+} FLEXCOMM_SPI_FIFOCFG_EMPTYRX_Enum;
+
+typedef enum {
+    /* Debug reads of the FIFO do not pop the FIFO */
+    FLEXCOMM_SPI_FIFOCFG_POPDBG_DO_NOT_POP = 0,
+    /* A debug read will cause the FIFO to pop */
+    FLEXCOMM_SPI_FIFOCFG_POPDBG_POP = 1,
+} FLEXCOMM_SPI_FIFOCFG_POPDBG_Enum;
+
+typedef enum {
+    /* A transmit FIFO error has not occurred. */
+    FLEXCOMM_SPI_FIFOSTAT_TXERR_NO_TXERR = 0,
+    /*
+     * A transmit FIFO error has occurred. This error could be an overflow
+     * caused by pushing data into a full FIFO, or by an underflow if the FIFO
+     * is empty when data is needed.
+     */
+    FLEXCOMM_SPI_FIFOSTAT_TXERR_TXERR = 1,
+} FLEXCOMM_SPI_FIFOSTAT_TXERR_Enum;
+
+typedef enum {
+    /* A receive FIFO overflow has not occurred */
+    FLEXCOMM_SPI_FIFOSTAT_RXERR_NO_RXERR = 0,
+    /*
+     * A receive FIFO overflow has occurred, caused by software or DMA not
+     * emptying the FIFO fast enough
+     */
+    FLEXCOMM_SPI_FIFOSTAT_RXERR_RXERR = 1,
+} FLEXCOMM_SPI_FIFOSTAT_RXERR_Enum;
+
+typedef enum {
+    /* The peripheral function has not asserted an interrupt */
+    FLEXCOMM_SPI_FIFOSTAT_PERINT_NO_PERINT = 0,
+    /*
+     * Indicates that the peripheral function has asserted an interrupt. More
+     * information can be found by reading the peripheral's status register
+     * (STAT).
+     */
+    FLEXCOMM_SPI_FIFOSTAT_PERINT_PERINT = 1,
+} FLEXCOMM_SPI_FIFOSTAT_PERINT_Enum;
+
+typedef enum {
+    /* The transmit FIFO is not empty */
+    FLEXCOMM_SPI_FIFOSTAT_TXEMPTY_TXFIFO_ISNOTEMPTY = 0,
+    /*
+     * The transmit FIFO is empty, although the peripheral may still be
+     * processing the last piece of data.
+     */
+    FLEXCOMM_SPI_FIFOSTAT_TXEMPTY_TXFIFO_ISEMPTY = 1,
+} FLEXCOMM_SPI_FIFOSTAT_TXEMPTY_Enum;
+
+typedef enum {
+    /* The transmit FIFO is full and another write would cause it to overflow */
+    FLEXCOMM_SPI_FIFOSTAT_TXNOTFULL_TXFIFO_ISFULL = 0,
+    /* The transmit FIFO is not full, so more data can be written */
+    FLEXCOMM_SPI_FIFOSTAT_TXNOTFULL_TXFIFO_ISNOTFULL = 1,
+} FLEXCOMM_SPI_FIFOSTAT_TXNOTFULL_Enum;
+
+typedef enum {
+    /* When 0, the receive FIFO is empty */
+    FLEXCOMM_SPI_FIFOSTAT_RXNOTEMPTY_RXFIFO_ISEMPTY = 0,
+    /* When 1, the receive FIFO is not empty, so data can be read */
+    FLEXCOMM_SPI_FIFOSTAT_RXNOTEMPTY_RXFIFO_ISNOTEMPTY = 1,
+} FLEXCOMM_SPI_FIFOSTAT_RXNOTEMPTY_Enum;
+
+typedef enum {
+    /* The receive FIFO is not full */
+    FLEXCOMM_SPI_FIFOSTAT_RXFULL_RXFIFO_ISNOTFULL = 0,
+    /*
+     * The receive FIFO is full. To prevent the peripheral from causing an
+     * overflow, data should be read out.
+     */
+    FLEXCOMM_SPI_FIFOSTAT_RXFULL_RXFIFO_ISFULL = 1,
+} FLEXCOMM_SPI_FIFOSTAT_RXFULL_Enum;
+
+typedef enum {
+    /* Transmit FIFO level does not generate a FIFO level trigger */
+    FLEXCOMM_SPI_FIFOTRIG_TXLVLENA_DISABLED = 0,
+    /*
+     * An trigger will be generated if the transmit FIFO level reaches the
+     * value specified by the FIFOTRIG[TXLVL] field.
+     */
+    FLEXCOMM_SPI_FIFOTRIG_TXLVLENA_ENABLED = 1,
+} FLEXCOMM_SPI_FIFOTRIG_TXLVLENA_Enum;
+
+typedef enum {
+    /* Receive FIFO level does not generate a FIFO level trigger */
+    FLEXCOMM_SPI_FIFOTRIG_RXLVLENA_DISABLED = 0,
+    /*
+     * An trigger will be generated if the receive FIFO level reaches the value
+     * specified by the FIFOTRIG[RXLVL] field.
+     */
+    FLEXCOMM_SPI_FIFOTRIG_RXLVLENA_ENABLED = 1,
+} FLEXCOMM_SPI_FIFOTRIG_RXLVLENA_Enum;
+
+typedef enum {
+    /* Trigger when the TX FIFO becomes empty */
+    FLEXCOMM_SPI_FIFOTRIG_TXLVL_TXLVL0 = 0,
+    /* Trigger when the TX FIFO level decreases to 1 entry */
+    FLEXCOMM_SPI_FIFOTRIG_TXLVL_TXLVL1 = 1,
+    /*
+     * Trigger when the TX FIFO level decreases to 15 entries (is no longer
+     * full)
+     */
+    FLEXCOMM_SPI_FIFOTRIG_TXLVL_TXLVL15 = 15,
+} FLEXCOMM_SPI_FIFOTRIG_TXLVL_Enum;
+
+typedef enum {
+    /* Trigger when the RX FIFO has received 1 entry (is no longer empty) */
+    FLEXCOMM_SPI_FIFOTRIG_RXLVL_RXLVL1 = 0,
+    /* Trigger when the RX FIFO has received 2 entries */
+    FLEXCOMM_SPI_FIFOTRIG_RXLVL_RXLVL2 = 1,
+    /* Trigger when the RX FIFO has received 16 entries (has become full) */
+    FLEXCOMM_SPI_FIFOTRIG_RXLVL_RXLVL15 = 15,
+} FLEXCOMM_SPI_FIFOTRIG_RXLVL_Enum;
+
+typedef enum {
+    /* No interrupt will be generated for a transmit error */
+    FLEXCOMM_SPI_FIFOINTENSET_TXERR_DISABLED = 0,
+    /* An interrupt will be generated when a transmit error occurs */
+    FLEXCOMM_SPI_FIFOINTENSET_TXERR_ENABLED = 1,
+} FLEXCOMM_SPI_FIFOINTENSET_TXERR_Enum;
+
+typedef enum {
+    /* No interrupt will be generated for a receive error */
+    FLEXCOMM_SPI_FIFOINTENSET_RXERR_DISABLED = 0,
+    /* An interrupt will be generated when a receive error occurs */
+    FLEXCOMM_SPI_FIFOINTENSET_RXERR_ENABLED = 1,
+} FLEXCOMM_SPI_FIFOINTENSET_RXERR_Enum;
+
+typedef enum {
+    /* No interrupt will be generated based on the TX FIFO level */
+    FLEXCOMM_SPI_FIFOINTENSET_TXLVL_DISABLED = 0,
+    /*
+     * If FIFOTRIG[TXLVLENA]=1, then an interrupt will be generated when the TX
+     * FIFO level decreases to the level specified by FIFOTRIG[TXLVL]
+     */
+    FLEXCOMM_SPI_FIFOINTENSET_TXLVL_ENABLED = 1,
+} FLEXCOMM_SPI_FIFOINTENSET_TXLVL_Enum;
+
+typedef enum {
+    /* No interrupt will be generated based on the RX FIFO level */
+    FLEXCOMM_SPI_FIFOINTENSET_RXLVL_DISABLED = 0,
+    /*
+     * If FIFOTRIG[RXLVLENA]=1, then an interrupt will be generated when the RX
+     * FIFO level increases to the level specified by FIFOTRIG[RXLVL]
+     */
+    FLEXCOMM_SPI_FIFOINTENSET_RXLVL_ENABLED = 1,
+} FLEXCOMM_SPI_FIFOINTENSET_RXLVL_Enum;
+
+typedef enum {
+    /* No effect */
+    FLEXCOMM_SPI_FIFOINTENCLR_TXERR_NO_EFFECT = 0,
+    /* Clear the TX Error Interrupt Enable bit FIFOINTENSET[TXERR] */
+    FLEXCOMM_SPI_FIFOINTENCLR_TXERR_CLEAR_THE_TXERR = 1,
+} FLEXCOMM_SPI_FIFOINTENCLR_TXERR_Enum;
+
+typedef enum {
+    /* No effect */
+    FLEXCOMM_SPI_FIFOINTENCLR_RXERR_NO_EFFECT = 0,
+    /* Clear the Receive Error Interrupt Enable bit FIFOINTENSET[RXERR] */
+    FLEXCOMM_SPI_FIFOINTENCLR_RXERR_CLEAR_THE_RXERR = 1,
+} FLEXCOMM_SPI_FIFOINTENCLR_RXERR_Enum;
+
+typedef enum {
+    /* No effect */
+    FLEXCOMM_SPI_FIFOINTENCLR_TXLVL_NO_EFFECT = 0,
+    /* Clear the Transmit FIFO Level Interrupt Enable bit FIFOINTENSET[TXLVL] */
+    FLEXCOMM_SPI_FIFOINTENCLR_TXLVL_CLEAR_THE_TXLVL = 1,
+} FLEXCOMM_SPI_FIFOINTENCLR_TXLVL_Enum;
+
+typedef enum {
+    /* No effect */
+    FLEXCOMM_SPI_FIFOINTENCLR_RXLVL_NO_EFFECT = 0,
+    /* Clear the Receive FIFO Level Interrupt Enable bit FIFOINTENSET[RXLVL] */
+    FLEXCOMM_SPI_FIFOINTENCLR_RXLVL_CLEAR_THE_RXLVL = 1,
+} FLEXCOMM_SPI_FIFOINTENCLR_RXLVL_Enum;
+
+typedef enum {
+    /* Not pending */
+    FLEXCOMM_SPI_FIFOINTSTAT_TXERR_TXERR_ISNOTPENDING = 0,
+    /* Pending */
+    FLEXCOMM_SPI_FIFOINTSTAT_TXERR_TXERR_ISPENDING = 1,
+} FLEXCOMM_SPI_FIFOINTSTAT_TXERR_Enum;
+
+typedef enum {
+    /* Not pending */
+    FLEXCOMM_SPI_FIFOINTSTAT_RXERR_RXERR_ISNOTPENDING = 0,
+    /* Pending */
+    FLEXCOMM_SPI_FIFOINTSTAT_RXERR_RXERR_ISPENDING = 1,
+} FLEXCOMM_SPI_FIFOINTSTAT_RXERR_Enum;
+
+typedef enum {
+    /* Not pending */
+    FLEXCOMM_SPI_FIFOINTSTAT_TXLVL_TXLVL_ISNOTPENDING = 0,
+    /* Pending */
+    FLEXCOMM_SPI_FIFOINTSTAT_TXLVL_TXLVL_ISPENDING = 1,
+} FLEXCOMM_SPI_FIFOINTSTAT_TXLVL_Enum;
+
+typedef enum {
+    /* Not pending */
+    FLEXCOMM_SPI_FIFOINTSTAT_RXLVL_RXLVL_ISNOTPENDING = 0,
+    /* Pending */
+    FLEXCOMM_SPI_FIFOINTSTAT_RXLVL_RXLVL_ISPENDING = 1,
+} FLEXCOMM_SPI_FIFOINTSTAT_RXLVL_Enum;
+
+typedef enum {
+    /* Not pending */
+    FLEXCOMM_SPI_FIFOINTSTAT_PERINT_PERINT_ISNOTPENDING = 0,
+    /* Pending */
+    FLEXCOMM_SPI_FIFOINTSTAT_PERINT_PERINT_ISPENDING = 1,
+} FLEXCOMM_SPI_FIFOINTSTAT_PERINT_Enum;
+
+typedef enum {
+    /* SSEL0 is asserted */
+    FLEXCOMM_SPI_FIFOWR_TXSSEL0_N_ASSERTED = 0,
+    /* SSEL0 is not asserted */
+    FLEXCOMM_SPI_FIFOWR_TXSSEL0_N_NOT_ASSERTED = 1,
+} FLEXCOMM_SPI_FIFOWR_TXSSEL0_N_Enum;
+
+typedef enum {
+    /* SSEL1 is asserted */
+    FLEXCOMM_SPI_FIFOWR_TXSSEL1_N_ASSERTED = 0,
+    /* SSEL1 is not asserted */
+    FLEXCOMM_SPI_FIFOWR_TXSSEL1_N_NOT_ASSERTED = 1,
+} FLEXCOMM_SPI_FIFOWR_TXSSEL1_N_Enum;
+
+typedef enum {
+    /* SSEL2 is asserted */
+    FLEXCOMM_SPI_FIFOWR_TXSSEL2_N_ASSERTED = 0,
+    /* SSEL2 is not asserted */
+    FLEXCOMM_SPI_FIFOWR_TXSSEL2_N_NOT_ASSERTED = 1,
+} FLEXCOMM_SPI_FIFOWR_TXSSEL2_N_Enum;
+
+typedef enum {
+    /* SSEL3 is asserted */
+    FLEXCOMM_SPI_FIFOWR_TXSSEL3_N_ASSERTED = 0,
+    /* SSEL3 is not asserted */
+    FLEXCOMM_SPI_FIFOWR_TXSSEL3_N_NOT_ASSERTED = 1,
+} FLEXCOMM_SPI_FIFOWR_TXSSEL3_N_Enum;
+
+typedef enum {
+    /*
+     * SSEL is not deasserted. This piece of data is not treated as the end of
+     * a transfer. SSEL will not be deasserted at the end of this data.
+     */
+    FLEXCOMM_SPI_FIFOWR_EOT_NOT_DEASSERTED = 0,
+    /*
+     * SSEL is deasserted. This piece of data is treated as the end of a
+     * transfer. SSEL will be deasserted at the end of this piece of data.
+     */
+    FLEXCOMM_SPI_FIFOWR_EOT_DEASSERTED = 1,
+} FLEXCOMM_SPI_FIFOWR_EOT_Enum;
+
+typedef enum {
+    /*
+     * Data not EOF. This piece of data transmitted is not treated as the end
+     * of a frame.
+     */
+    FLEXCOMM_SPI_FIFOWR_EOF_NOT_EOF = 0,
+    /*
+     * Data EOF. This piece of data is treated as the end of a frame, causing
+     * the Frame_delay time to be inserted before subsequent data is
+     * transmitted.
+     */
+    FLEXCOMM_SPI_FIFOWR_EOF_EOF = 1,
+} FLEXCOMM_SPI_FIFOWR_EOF_Enum;
+
+typedef enum {
+    /*
+     * Read received data. Received data must be read, to allow transmission to
+     * proceed. SPI transmit will halt when the receive data FIFO is full. In
+     * slave mode, an overrun error will occur if received data is not read
+     * before new data is received.
+     */
+    FLEXCOMM_SPI_FIFOWR_RXIGNORE_READ = 0,
+    /*
+     * Ignore received data. Received data is ignored, allowing transmission
+     * without reading unneeded received data. No receiver flags are generated.
+     */
+    FLEXCOMM_SPI_FIFOWR_RXIGNORE_IGNORE = 1,
+} FLEXCOMM_SPI_FIFOWR_RXIGNORE_Enum;
+
+typedef enum {
+    /* Write transmit data */
+    FLEXCOMM_SPI_FIFOWR_TXIGNORE_WRITETXDATA = 0,
+    /* Ignore transmit data */
+    FLEXCOMM_SPI_FIFOWR_TXIGNORE_IGNORETXDATA = 1,
+} FLEXCOMM_SPI_FIFOWR_TXIGNORE_Enum;
+
+typedef enum {
+    /* Data transfer is 4 bits in length */
+    FLEXCOMM_SPI_FIFOWR_LEN_LEN_4BITS = 3,
+    /* Data transfer is 5 bits in length */
+    FLEXCOMM_SPI_FIFOWR_LEN_LEN_5BITS = 4,
+    /* Data transfer is 16 bits in length */
+    FLEXCOMM_SPI_FIFOWR_LEN_LEN_16BITS = 15,
+} FLEXCOMM_SPI_FIFOWR_LEN_Enum;
+
+typedef enum {
+    /* Slave Select 0 is active */
+    FLEXCOMM_SPI_FIFORD_RXSSEL0_N_RXSSEL0_ISACTIVE = 0,
+    /* Slave Select 0 is not active */
+    FLEXCOMM_SPI_FIFORD_RXSSEL0_N_RXSSEL0_ISNOTACTIVE = 1,
+} FLEXCOMM_SPI_FIFORD_RXSSEL0_N_Enum;
+
+typedef enum {
+    /* Slave Select 1 is active */
+    FLEXCOMM_SPI_FIFORD_RXSSEL1_N_RXSSEL1_ISACTIVE = 0,
+    /* Slave Select 1 is not active */
+    FLEXCOMM_SPI_FIFORD_RXSSEL1_N_RXSSEL1_ISNOTACTIVE = 1,
+} FLEXCOMM_SPI_FIFORD_RXSSEL1_N_Enum;
+
+typedef enum {
+    /* Slave Select 2 is active */
+    FLEXCOMM_SPI_FIFORD_RXSSEL2_N_RXSSEL2_ISACTIVE = 0,
+    /* Slave Select 2 is not active */
+    FLEXCOMM_SPI_FIFORD_RXSSEL2_N_RXSSEL2_ISNOTACTIVE = 1,
+} FLEXCOMM_SPI_FIFORD_RXSSEL2_N_Enum;
+
+typedef enum {
+    /* Slave Select 3 is active */
+    FLEXCOMM_SPI_FIFORD_RXSSEL3_N_RXSSEL3_ISACTIVE = 0,
+    /* Slave Select 3 is not active */
+    FLEXCOMM_SPI_FIFORD_RXSSEL3_N_RXSSEL3_ISNOTACTIVE = 1,
+} FLEXCOMM_SPI_FIFORD_RXSSEL3_N_Enum;
+
+typedef enum {
+    /*
+     * This is not the 1st data after the SSELs went from deasserted to
+     * asserted
+     */
+    FLEXCOMM_SPI_FIFORD_SOT_SOT0 = 0,
+    /*
+     * This is the 1st data after the SSELs went from deasserted to asserted
+     * (i.e., any previous transfer has ended). This information can be used to
+     * identify the 1st piece of data in cases where the transfer length is
+     * greater than 16 bits.
+     */
+    FLEXCOMM_SPI_FIFORD_SOT_SOT1 = 1,
+} FLEXCOMM_SPI_FIFORD_SOT_Enum;
+
+typedef enum {
+    /* Not selected */
+    FLEXCOMM_SPI_FIFORDNOPOP_RXSSEL0_N_NOT_SELECTED = 0,
+    /* Selected */
+    FLEXCOMM_SPI_FIFORDNOPOP_RXSSEL0_N_RXSSEL0_N_SELECTED = 1,
+} FLEXCOMM_SPI_FIFORDNOPOP_RXSSEL0_N_Enum;
+
+typedef enum {
+    /* Not selected */
+    FLEXCOMM_SPI_FIFORDNOPOP_RXSSEL1_N_NOT_SELECTED = 0,
+    /* Selected */
+    FLEXCOMM_SPI_FIFORDNOPOP_RXSSEL1_N_RXSSEL1_N_SELECTED = 1,
+} FLEXCOMM_SPI_FIFORDNOPOP_RXSSEL1_N_Enum;
+
+typedef enum {
+    /* Not selected */
+    FLEXCOMM_SPI_FIFORDNOPOP_RXSSEL2_N_NOT_SELECTED = 0,
+    /* Selected */
+    FLEXCOMM_SPI_FIFORDNOPOP_RXSSEL2_N_RXSSEL2_N_SELECTED = 1,
+} FLEXCOMM_SPI_FIFORDNOPOP_RXSSEL2_N_Enum;
+
+typedef enum {
+    /* Not selected */
+    FLEXCOMM_SPI_FIFORDNOPOP_RXSSEL3_N_NOT_SELECTED = 0,
+    /* Selected */
+    FLEXCOMM_SPI_FIFORDNOPOP_RXSSEL3_N_RXSSEL3_N_SELECTED = 1,
+} FLEXCOMM_SPI_FIFORDNOPOP_RXSSEL3_N_Enum;
+
+typedef enum {
+    /* Not active */
+    FLEXCOMM_SPI_FIFORDNOPOP_SOT_SOT_NOT_ACTIVE = 0,
+    /* Active */
+    FLEXCOMM_SPI_FIFORDNOPOP_SOT_SOT_ACTIVE = 1,
+} FLEXCOMM_SPI_FIFORDNOPOP_SOT_Enum;
+
+
+#define FLEXCOMM_SPI_REGISTER_ACCESS_INFO_ARRAY(_name) \
+    struct RegisterAccessInfo _name[FLEXCOMM_SPI_REGS_NO] = { \
+        [0 ... FLEXCOMM_SPI_REGS_NO - 1] = { \
+            .name = "", \
+            .addr = -1, \
+        }, \
+        [R_FLEXCOMM_SPI_CFG] = { \
+            .name = "CFG", \
+            .addr = 0x400, \
+            .ro = 0xFFFFF042, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXCOMM_SPI_DLY] = { \
+            .name = "DLY", \
+            .addr = 0x404, \
+            .ro = 0xFFFF0000, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXCOMM_SPI_STAT] = { \
+            .name = "STAT", \
+            .addr = 0x408, \
+            .ro = 0xFFFFFF4F, \
+            .reset = 0x100, \
+        }, \
+        [R_FLEXCOMM_SPI_INTENSET] = { \
+            .name = "INTENSET", \
+            .addr = 0x40C, \
+            .ro = 0xFFFFFECF, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXCOMM_SPI_INTENCLR] = { \
+            .name = "INTENCLR", \
+            .addr = 0x410, \
+            .ro = 0xFFFFFECF, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXCOMM_SPI_DIV] = { \
+            .name = "DIV", \
+            .addr = 0x424, \
+            .ro = 0xFFFF0000, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXCOMM_SPI_INTSTAT] = { \
+            .name = "INTSTAT", \
+            .addr = 0x428, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXCOMM_SPI_FIFOCFG] = { \
+            .name = "FIFOCFG", \
+            .addr = 0xE00, \
+            .ro = 0xFFF80FFC, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXCOMM_SPI_FIFOSTAT] = { \
+            .name = "FIFOSTAT", \
+            .addr = 0xE04, \
+            .ro = 0xFFFFFFFC, \
+            .reset = 0x30, \
+        }, \
+        [R_FLEXCOMM_SPI_FIFOTRIG] = { \
+            .name = "FIFOTRIG", \
+            .addr = 0xE08, \
+            .ro = 0xFFF0F0FC, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXCOMM_SPI_FIFOINTENSET] = { \
+            .name = "FIFOINTENSET", \
+            .addr = 0xE10, \
+            .ro = 0xFFFFFFF0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXCOMM_SPI_FIFOINTENCLR] = { \
+            .name = "FIFOINTENCLR", \
+            .addr = 0xE14, \
+            .ro = 0xFFFFFFF0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXCOMM_SPI_FIFOINTSTAT] = { \
+            .name = "FIFOINTSTAT", \
+            .addr = 0xE18, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXCOMM_SPI_FIFOWR] = { \
+            .name = "FIFOWR", \
+            .addr = 0xE20, \
+            .ro = 0xF0000000, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXCOMM_SPI_FIFORD] = { \
+            .name = "FIFORD", \
+            .addr = 0xE30, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXCOMM_SPI_FIFORDNOPOP] = { \
+            .name = "FIFORDNOPOP", \
+            .addr = 0xE40, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXCOMM_SPI_FIFOSIZE] = { \
+            .name = "FIFOSIZE", \
+            .addr = 0xE48, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXCOMM_SPI_ID] = { \
+            .name = "ID", \
+            .addr = 0xFFC, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0xE0201200, \
+        }, \
+    }
diff --git a/include/hw/misc/flexcomm.h b/include/hw/misc/flexcomm.h
index 2fdca81ba9..0f44eabc57 100644
--- a/include/hw/misc/flexcomm.h
+++ b/include/hw/misc/flexcomm.h
@@ -15,9 +15,12 @@
 #include "hw/sysbus.h"
 #include "chardev/char-fe.h"
 #include "hw/i2c/i2c.h"
+#include "hw/ssi/ssi.h"
 #include "hw/arm/svd/flexcomm.h"
 #include "hw/arm/svd/flexcomm_usart.h"
 #include "hw/arm/svd/flexcomm_i2c.h"
+#undef EOF
+#include "hw/arm/svd/flexcomm_spi.h"
 #include "qemu/fifo32.h"
 
 #define TYPE_FLEXCOMM "flexcomm"
@@ -51,6 +54,10 @@ typedef struct {
     Fifo32 tx_fifo;
     Fifo32 rx_fifo;
     I2CBus *i2c;
+    SSIBus *spi;
+    qemu_irq cs[4];
+    bool cs_asserted[4];
+    uint32_t spi_tx_ctrl;
 } FlexcommState;
 
 typedef struct {
diff --git a/include/hw/ssi/flexcomm_spi.h b/include/hw/ssi/flexcomm_spi.h
new file mode 100644
index 0000000000..d5567aa1e6
--- /dev/null
+++ b/include/hw/ssi/flexcomm_spi.h
@@ -0,0 +1,20 @@
+/*
+ * QEMU model for NXP's FLEXCOMM SPI
+ *
+ * Copyright (c) 2024 Google LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_CHAR_FLEXCOMM_SPI_H
+#define HW_CHAR_FLEXCOMM_SPI_H
+
+#include "hw/misc/flexcomm.h"
+
+void flexcomm_spi_init(FlexcommState *s);
+void flexcomm_spi_register(void);
+
+#endif /* HW_CHAR_FLEXCOMM_SPI_H */
diff --git a/hw/misc/flexcomm.c b/hw/misc/flexcomm.c
index 52fd09cf8e..833e291613 100644
--- a/hw/misc/flexcomm.c
+++ b/hw/misc/flexcomm.c
@@ -23,6 +23,7 @@
 #include "hw/misc/flexcomm.h"
 #include "hw/char/flexcomm_usart.h"
 #include "hw/i2c/flexcomm_i2c.h"
+#include "hw/ssi/flexcomm_spi.h"
 
 #define REG(s, reg) (s->regs[R_FLEXCOMM_##reg])
 #define RF_WR(s, reg, field, val) \
@@ -255,6 +256,10 @@ static void flexcomm_realize(DeviceState *dev, Error **errp)
     if (has_function(s, FLEXCOMM_FUNC_I2C)) {
         flexcomm_i2c_init(s);
     }
+
+    if (has_function(s, FLEXCOMM_FUNC_SPI)) {
+        flexcomm_spi_init(s);
+    }
 }
 
 static void flexcomm_class_init(ObjectClass *klass, void *data)
@@ -267,6 +272,7 @@ static void flexcomm_class_init(ObjectClass *klass, void *data)
 
     flexcomm_usart_register();
     flexcomm_i2c_register();
+    flexcomm_spi_register();
 }
 
 static const TypeInfo flexcomm_types[] = {
diff --git a/hw/ssi/flexcomm_spi.c b/hw/ssi/flexcomm_spi.c
new file mode 100644
index 0000000000..06e11cc242
--- /dev/null
+++ b/hw/ssi/flexcomm_spi.c
@@ -0,0 +1,442 @@
+/*
+ * QEMU model for NXP's FLEXCOMM SPI
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
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+#include "qemu/cutils.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "exec/address-spaces.h"
+#include "qapi/error.h"
+#include "trace.h"
+#include "hw/ssi/flexcomm_spi.h"
+
+#define REG(s, reg) (s->regs[R_FLEXCOMM_SPI_##reg])
+#define RF_WR(s, reg, field, val) \
+    ARRAY_FIELD_DP32(s->regs, FLEXCOMM_SPI_##reg, field, val)
+#define RF_RD(s, reg, field) \
+    ARRAY_FIELD_EX32(s->regs, FLEXCOMM_SPI_##reg, field)
+
+#define FLEXCOMM_SSEL_ASSERTED             (0)
+#define FLEXCOMM_SSEL_DEASSERTED           (1)
+
+#define FLEXCOMM_SPI_FIFOWR_LEN_MIN        (3)
+#define FLEXCOMM_SPI_FIFOWR_LEN_MAX        (15)
+
+static const FLEXCOMM_SPI_REGISTER_ACCESS_INFO_ARRAY(reg_info);
+
+static void flexcomm_spi_reset(FlexcommState *s)
+{
+    for (int i = 0; i < FLEXCOMM_SPI_REGS_NO; i++) {
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
+    RF_WR(s, FIFOSIZE, FIFOSIZE, 0x8);
+}
+
+static void update_fifo_stat(FlexcommState *s)
+{
+    int rxlvl = fifo32_num_used(&s->rx_fifo);
+    int txlvl = fifo32_num_used(&s->tx_fifo);
+
+    RF_WR(s, FIFOSTAT, RXLVL, fifo32_num_used(&s->rx_fifo));
+    RF_WR(s, FIFOSTAT, TXLVL, fifo32_num_used(&s->tx_fifo));
+    RF_WR(s, FIFOSTAT, RXFULL, fifo32_is_full(&s->rx_fifo) ? 1 : 0);
+    RF_WR(s, FIFOSTAT, RXNOTEMPTY, !fifo32_is_empty(&s->rx_fifo) ? 1 : 0);
+    RF_WR(s, FIFOSTAT, TXNOTFULL, !fifo32_is_full(&s->tx_fifo) ? 1 : 0);
+    RF_WR(s, FIFOSTAT, TXEMPTY, fifo32_is_empty(&s->tx_fifo) ? 1 : 0);
+
+    if (RF_RD(s, FIFOTRIG, RXLVLENA) &&
+        (rxlvl > RF_RD(s, FIFOTRIG, RXLVL))) {
+        RF_WR(s, FIFOINTSTAT, RXLVL, 1);
+    } else {
+        RF_WR(s, FIFOINTSTAT, RXLVL, 0);
+    }
+
+    if (RF_RD(s, FIFOTRIG, TXLVLENA) &&
+        (txlvl <= RF_RD(s, FIFOTRIG, TXLVL))) {
+        RF_WR(s, FIFOINTSTAT, TXLVL, 1);
+    } else {
+        RF_WR(s, FIFOINTSTAT, TXLVL, 0);
+    }
+
+    trace_flexcomm_spi_fifostat(DEVICE(s)->id, REG(s, FIFOSTAT),
+                               REG(s, FIFOINTSTAT));
+}
+
+static void flexcomm_spi_irq_update(FlexcommState *s)
+{
+    bool irq, per_irqs, fifo_irqs, enabled = RF_RD(s, CFG, ENABLE);
+
+    update_fifo_stat(s);
+    fifo_irqs = REG(s, FIFOINTSTAT) & REG(s, FIFOINTENSET);
+
+    REG(s, INTSTAT) = REG(s, STAT) & REG(s, INTENSET);
+    per_irqs = REG(s, INTSTAT) != 0;
+
+    irq = enabled && (fifo_irqs || per_irqs);
+
+    trace_flexcomm_spi_irq(DEVICE(s)->id, irq, fifo_irqs, per_irqs, enabled);
+    flexcomm_irq(s, irq);
+}
+
+static void flexcomm_spi_select(void *opaque, FlexcommState *s, int f,
+                               bool set)
+{
+    if (set) {
+        bool spol[] = {
+            RF_RD(s, CFG, SPOL0), RF_RD(s, CFG, SPOL1), RF_RD(s, CFG, SPOL2),
+            RF_RD(s, CFG, SPOL3),
+        };
+
+        flexcomm_spi_reset(s);
+        fifo32_create(&s->rx_fifo, RF_RD(s, FIFOSIZE, FIFOSIZE));
+        fifo32_create(&s->tx_fifo, RF_RD(s, FIFOSIZE, FIFOSIZE));
+        for (int i = 0; i < ARRAY_SIZE(s->cs); i++) {
+            s->cs_asserted[i] = false;
+            qemu_set_irq(s->cs[i], !spol[i]);
+        }
+    } else {
+        fifo32_destroy(&s->rx_fifo);
+        fifo32_destroy(&s->tx_fifo);
+    }
+}
+
+static MemTxResult flexcomm_spi_reg_read(void *opaque, FlexcommState *s,
+                                        int f, hwaddr addr, uint64_t *data,
+                                        unsigned size)
+{
+    MemTxResult ret = MEMTX_OK;
+    const struct RegisterAccessInfo *rai = &reg_info[addr / 4];
+
+    /*
+     * Allow 8/16 bits access to the FIFORD LSB half-word. This is supported by
+     * hardware and required for 1/2 byte(s) width DMA transfers.
+     */
+    if (size != 4 && addr != A_FLEXCOMM_SPI_FIFORD) {
+        ret = MEMTX_ERROR;
+        goto out;
+    }
+
+    switch (addr) {
+    case A_FLEXCOMM_SPI_FIFORD:
+    {
+        /* If we are running in loopback mode get the data from TX FIFO */
+        if (RF_RD(s, CFG, LOOP) &&
+            RF_RD(s, CFG, MASTER))
+        {
+            if (!fifo32_is_empty(&s->tx_fifo)) {
+                *data = fifo32_pop(&s->tx_fifo);
+            }
+            break;
+        }
+
+        if (!fifo32_is_empty(&s->rx_fifo)) {
+            *data = fifo32_pop(&s->rx_fifo);
+            qemu_chr_fe_accept_input(&s->chr);
+        }
+        break;
+    }
+    case A_FLEXCOMM_SPI_FIFORDNOPOP:
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
+    flexcomm_spi_irq_update(s);
+
+out:
+    trace_flexcomm_spi_reg_read(DEVICE(s)->id, rai->name, addr, *data);
+    return ret;
+}
+
+static uint32_t fifowr_len_bits(uint32_t val)
+{
+    int len = FIELD_EX32(val, FLEXCOMM_SPI_FIFOWR, LEN);
+
+    if (len < FLEXCOMM_SPI_FIFOWR_LEN_MIN ||
+        len > FLEXCOMM_SPI_FIFOWR_LEN_MAX) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid spi xfer len %d\n",
+                      __func__, val);
+        return 0;
+    }
+
+    return len + 1;
+}
+
+static inline uint32_t fifowr_len_bytes(uint32_t val)
+{
+    return fifowr_len_bits(val) > 8 ? 2 : 1;
+}
+
+static uint32_t flexcomm_spi_xfer_word(FlexcommState *s,
+                                      uint32_t out_data,
+                                      int bytes,
+                                      bool be)
+{
+    uint32_t word = 0;
+    int out = 0;
+
+    for (int i = 0; i < bytes; i++) {
+        if (be) {
+            int byte_offset = bytes - i - 1;
+            out = (out_data & (0xFF << byte_offset * 8)) >> byte_offset * 8;
+            word |= ssi_transfer(s->spi, out) << byte_offset * 8;
+        } else {
+            out = (out_data & (0xFF << i * 8)) >> i * 8;
+            word |= ssi_transfer(s->spi, out) << i * 8;
+        }
+    }
+
+    return word;
+}
+
+static uint32_t flexcomm_spi_get_ss_mask(FlexcommState *s,
+                                        uint32_t txfifo_val)
+{
+    uint32_t slave_select_mask = 0;
+    bool ss[] = {
+        FIELD_EX32(txfifo_val, FLEXCOMM_SPI_FIFOWR, TXSSEL0_N),
+        FIELD_EX32(txfifo_val, FLEXCOMM_SPI_FIFOWR, TXSSEL1_N),
+        FIELD_EX32(txfifo_val, FLEXCOMM_SPI_FIFOWR, TXSSEL2_N),
+        FIELD_EX32(txfifo_val, FLEXCOMM_SPI_FIFOWR, TXSSEL3_N),
+    };
+    bool spol[] = {
+        RF_RD(s, CFG, SPOL0), RF_RD(s, CFG, SPOL1), RF_RD(s, CFG, SPOL2),
+        RF_RD(s, CFG, SPOL3),
+    };
+
+    for (int i = 0; i < ARRAY_SIZE(s->cs); i++) {
+        int irq_level = ss[i] ? spol[i] : !spol[i];
+
+        slave_select_mask |= (ss[i] << i);
+        s->cs_asserted[i] = ss[i];
+        qemu_set_irq(s->cs[i], irq_level);
+    }
+
+    return slave_select_mask;
+}
+
+static MemTxResult flexcomm_spi_reg_write(void *opaque, FlexcommState *s,
+                                         int f, hwaddr addr, uint64_t value,
+                                         unsigned size)
+{
+    MemTxResult ret = MEMTX_OK;
+    const struct RegisterAccessInfo *rai = &reg_info[addr / 4];
+    struct RegisterInfo ri = {
+        .data = &s->regs[addr / 4],
+        .data_size = 4,
+        .access = rai,
+    };
+
+    trace_flexcomm_spi_reg_write(DEVICE(s)->id, rai->name, addr, value);
+
+    /*
+     * Allow 8/16 bits access to both the FIFOWR MSB and LSB half-words. The
+     * former is required for updating the control bits while the latter for DMA
+     * transfers of 1/2 byte(s) width.
+     */
+    if (size != 4 && (addr / 4 != R_FLEXCOMM_SPI_FIFOWR)) {
+        return MEMTX_ERROR;
+    }
+
+    switch (addr) {
+    case A_FLEXCOMM_SPI_CFG:
+    {
+        register_write(&ri, value, ~0, NULL, false);
+        if (RF_RD(s, CFG, ENABLE)) {
+            qemu_chr_fe_accept_input(&s->chr);
+        }
+        break;
+    }
+    case A_FLEXCOMM_SPI_INTENCLR:
+    {
+        register_write(&ri, value, ~0, NULL, false);
+        REG(s, INTENSET) &= ~REG(s, INTENCLR);
+        break;
+    }
+    case A_FLEXCOMM_SPI_FIFOCFG:
+    {
+        register_write(&ri, value, ~0, NULL, false);
+        if (RF_RD(s, FIFOCFG, EMPTYRX)) {
+            RF_WR(s, FIFOCFG, EMPTYRX, 0);
+            fifo32_reset(&s->rx_fifo);
+        }
+        if (RF_RD(s, FIFOCFG, EMPTYTX)) {
+            RF_WR(s, FIFOCFG, EMPTYTX, 0);
+            fifo32_reset(&s->tx_fifo);
+        }
+        if (RF_RD(s, FIFOCFG, ENABLERX)) {
+            qemu_chr_fe_accept_input(&s->chr);
+        }
+        break;
+    }
+    case A_FLEXCOMM_SPI_FIFOSTAT:
+    {
+        bool rxerr = RF_RD(s, FIFOSTAT, RXERR);
+        bool txerr = RF_RD(s, FIFOSTAT, TXERR);
+
+        register_write(&ri, value, ~0, NULL, false);
+
+        if (rxerr && RF_RD(s, FIFOSTAT, RXERR)) {
+            rxerr = false;
+        }
+        if (txerr && RF_RD(s, FIFOSTAT, TXERR)) {
+            txerr = false;
+        }
+
+        RF_WR(s, FIFOSTAT, RXERR, rxerr);
+        RF_WR(s, FIFOSTAT, TXERR, txerr);
+        break;
+    }
+    case A_FLEXCOMM_SPI_FIFOINTENSET:
+    {
+        REG(s, FIFOINTENSET) |= value;
+        break;
+    }
+    case A_FLEXCOMM_SPI_FIFOINTENCLR:
+    {
+        register_write(&ri, value, ~0, NULL, false);
+        REG(s, FIFOINTENSET) &= ~REG(s, FIFOINTENCLR);
+        break;
+    }
+    /* update control bits but don't push into the FIFO */
+    case A_FLEXCOMM_SPI_FIFOWR + 2:
+    {
+        if (value != 0) {
+            s->spi_tx_ctrl = value << 16;
+        }
+        break;
+    }
+    /* update control bits but don't push into the FIFO */
+    case A_FLEXCOMM_SPI_FIFOWR + 3:
+    {
+        if (value != 0) {
+            s->spi_tx_ctrl = value << 24;
+        }
+        break;
+    }
+    case A_FLEXCOMM_SPI_FIFOWR:
+    {
+        /* fifo value contains both data and control bits */
+        uint32_t txfifo_val;
+        uint16_t tx_data = FIELD_EX32(value, FLEXCOMM_SPI_FIFOWR, TXDATA);
+        uint32_t tx_ctrl = value & 0xffff0000;
+
+        if (size > 2 && tx_ctrl != 0) {
+            /* non-zero writes to control bits updates them */
+            s->spi_tx_ctrl = tx_ctrl;
+        }
+
+        /* push the data and control bits into the FIFO */
+        txfifo_val = tx_data | s->spi_tx_ctrl;
+
+        if (!fifo32_is_full(&s->tx_fifo)) {
+            fifo32_push(&s->tx_fifo, txfifo_val);
+        }
+
+        if (!RF_RD(s, CFG, ENABLE) || !RF_RD(s, FIFOCFG, ENABLETX)) {
+            break;
+        }
+
+        /*
+         * On loopback mode we just insert the values in the TX FIFO. On slave
+         * mode master needs to initiate the SPI transfer.
+         */
+        if (RF_RD(s, CFG, LOOP) || !RF_RD(s, CFG, MASTER)) {
+            break;
+        }
+
+        while (!fifo32_is_empty(&s->tx_fifo)) {
+            txfifo_val = fifo32_pop(&s->tx_fifo);
+
+            uint32_t ss_mask = flexcomm_spi_get_ss_mask(s, txfifo_val);
+            uint32_t data = FIELD_EX32(txfifo_val, FLEXCOMM_SPI_FIFOWR, TXDATA);
+            uint8_t bytes = fifowr_len_bytes(txfifo_val);
+            bool msb = !RF_RD(s, CFG, LSBF);
+            uint32_t val32;
+
+            val32 = flexcomm_spi_xfer_word(s, data, bytes, msb);
+
+            if (!fifo32_is_full(&s->rx_fifo)) {
+                /* Append the mask that informs which client is active */
+                val32 |= (ss_mask << R_FLEXCOMM_SPI_FIFORD_RXSSEL0_N_SHIFT);
+                fifo32_push(&s->rx_fifo, val32);
+            }
+
+            /* If this is the end of the transfer raise the CS line */
+            if (FIELD_EX32(txfifo_val, FLEXCOMM_SPI_FIFOWR, EOT)) {
+                bool spol[ARRAY_SIZE(s->cs)] = {
+                    RF_RD(s, CFG, SPOL0),
+                    RF_RD(s, CFG, SPOL1),
+                    RF_RD(s, CFG, SPOL2),
+                    RF_RD(s, CFG, SPOL3),
+                };
+
+                for (int i = 0; i < ARRAY_SIZE(s->cs); i++) {
+                    if (s->cs_asserted[i]) {
+                        s->cs_asserted[i] = false;
+                        qemu_set_irq(s->cs[i], !spol[i]);
+                    }
+                }
+            }
+        }
+        break;
+    }
+    default:
+        register_write(&ri, value, ~0, NULL, false);
+        break;
+    }
+
+    flexcomm_spi_irq_update(s);
+
+    return ret;
+}
+
+static const FlexcommFunctionOps flexcomm_spi_ops = {
+    .select = flexcomm_spi_select,
+    .reg_read = flexcomm_spi_reg_read,
+    .reg_write = flexcomm_spi_reg_write,
+};
+
+void flexcomm_spi_init(FlexcommState *s)
+{
+    s->spi = ssi_create_bus(DEVICE(s), "spi");
+    qdev_init_gpio_out_named(DEVICE(s), &s->cs[0], "cs", ARRAY_SIZE(s->cs));
+}
+
+/* Register the SPI operations with the flexcomm upper layer */
+void flexcomm_spi_register(void)
+{
+    Error *err = NULL;
+
+    if (!flexcomm_register_ops(FLEXCOMM_FUNC_SPI, NULL,
+                               &flexcomm_spi_ops, &err)) {
+        error_report_err(err);
+    }
+}
diff --git a/hw/arm/svd/meson.build b/hw/arm/svd/meson.build
index 417491cd5c..7f1c847caf 100644
--- a/hw/arm/svd/meson.build
+++ b/hw/arm/svd/meson.build
@@ -10,4 +10,7 @@ if get_option('mcux-soc-svd')
   run_target('svd-flexcomm-i2c', command: svd_gen_header +
     [ '-i', rt595, '-o', '@SOURCE_ROOT@/include/hw/arm/svd/flexcomm_i2c.h',
       '-p', 'I2C0', '-t', 'FLEXCOMM_I2C'])
+  run_target('svd-flexcomm-spi', command: svd_gen_header +
+    [ '-i', rt595, '-o', '@SOURCE_ROOT@/include/hw/arm/svd/flexcomm_spi.h',
+      '-p', 'SPI0', '-t', 'FLEXCOMM_SPI'])
 endif
diff --git a/hw/ssi/meson.build b/hw/ssi/meson.build
index b999aeb027..57d3e14727 100644
--- a/hw/ssi/meson.build
+++ b/hw/ssi/meson.build
@@ -12,3 +12,4 @@ system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_spi.c'))
 system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_spi.c'))
 system_ss.add(when: 'CONFIG_IBEX', if_true: files('ibex_spi_host.c'))
 system_ss.add(when: 'CONFIG_BCM2835_SPI', if_true: files('bcm2835_spi.c'))
+system_ss.add(when: 'CONFIG_FLEXCOMM', if_true: files('flexcomm_spi.c'))
diff --git a/hw/ssi/trace-events b/hw/ssi/trace-events
index 2d5bd2b83d..5caa1c17ac 100644
--- a/hw/ssi/trace-events
+++ b/hw/ssi/trace-events
@@ -32,3 +32,11 @@ ibex_spi_host_reset(const char *msg) "%s"
 ibex_spi_host_transfer(uint32_t tx_data, uint32_t rx_data) "tx_data: 0x%" PRIx32 " rx_data: @0x%" PRIx32
 ibex_spi_host_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size %u: 0x%" PRIx64
 ibex_spi_host_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size %u:"
+
+# flexcomm_spi.c
+flexcomm_spi_reg_read(const char *id, const char *reg_name, uint32_t addr, uint32_t val) " %s: %s[0x%04x] -> 0x%08x"
+flexcomm_spi_reg_write(const char *id, const char *reg_name, uint32_t addr, uint32_t val) "%s: %s[0x%04x] <- 0x%08x"
+flexcomm_spi_fifostat(const char *id, uint32_t fifostat, uint32_t fifoinstat) "%s: %08x %08x"
+flexcomm_spi_irq(const char *id, bool irq, bool fifoirqs, bool perirqs, bool enabled) "%s: %d %d %d %d"
+flexcomm_spi_chr_rx_space(const char *id, uint32_t rx) "%s: %d"
+flexcomm_spi_chr_rx(const char *id) "%s"
-- 
2.46.0.295.g3b9ea8a38a-goog


