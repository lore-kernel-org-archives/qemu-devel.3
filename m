Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C29CBCED24E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 01:25:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxytN-0002Wa-L6; Mon, 07 Oct 2024 21:20:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3jogEZwUKCu8kRmZgXffXcV.TfdhVdl-UVmVcefeXel.fiX@flex--tavip.bounces.google.com>)
 id 1sxysg-0007qG-3U
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 21:19:21 -0400
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3jogEZwUKCu8kRmZgXffXcV.TfdhVdl-UVmVcefeXel.fiX@flex--tavip.bounces.google.com>)
 id 1sxysa-00009c-T4
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 21:19:16 -0400
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-6e2b049b64aso81156477b3.3
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 18:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1728350351; x=1728955151; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=bFIqfrB60fzUJwtasXiqxuXbxvJUBaZy8yqqf9RYqyc=;
 b=x1peIlfIAg5KUmhXJxqFRQ2JwbyBiiA2MOZrzbRJn+dFSPPF2i+C7+DLYaupQuDwq9
 E2Rt72z3rC2arKSNOc9xO0BhWpTPGwh9UKOSxFsf4UEqCwLoNWlchCN/j/2xcephNA2f
 n9Xwmg1EkwIaG9Qn3hsDrevPPgRz+a7r67koCKG9uGVmdWh/e+MqXxLB3l+whqcDF+OI
 AJJ9hzzs1wqOKz8vAg7mdgh98iTGqZdOngksyrbtw2kq1SWKevKLxbfBq2k0HhFd6MsU
 ZSoHkDuYSQjMF5y+KCEFjnjAfhXHNRPE2so2NEbfAku6dh0T+06gQfkap1BS4bQVP1WU
 Elxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728350351; x=1728955151;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bFIqfrB60fzUJwtasXiqxuXbxvJUBaZy8yqqf9RYqyc=;
 b=CcxDY6DrkVmFXOvBqHwwpaOcsxfDOstM4MunzEqeWI/LOEgcJPz4UUyCrWCvyyfSC3
 rsXUdKHZPJplydD/YHQMennAb2M11DR0tw5HO58MqztnNBYkCgQoxMbH5g8pxGBoX5yc
 E8NOubH+3fIehav7Imew4TC8Nezu8EKOMtNCMe+Ij5UPzkjg6yzDrldWpKVgn3LZ5evx
 N80N41JhMF+LipH3RUbQLuIuzchLmwtaU3lduRwTW6bFNC3ZM74YKI3T0lNNICHg3LsT
 GBfdjkJC59kjc6MpiSdfcSJ49Y36AnvaeStBWhfnwlYDJYABNZI/e1nMTCgTa4Vl8Rxw
 GniA==
X-Gm-Message-State: AOJu0YwH4QN0fndhBvGHjC9m1ngrUb2VIU98tTLbUZ/mh7wsPihKKZmR
 TqNEHHPSjUFMZg5Ik/ZrxRK/I649yr+9pxm9GRC7f2YzC18NHImFGAcc3R05L2CyVG+sioxxvzE
 dSj45GHj1sQs16E8106w3MNXIXiPtLtnuQWNyk7yCViGGGYRnlTlFJjfbe2yU0gLTVc0vJl0Mbg
 ZfyfGwV3+WiGYFL4fFZsK8+L963Q==
X-Google-Smtp-Source: AGHT+IGkuD7TbREcq6U/rFFH7/EYiI9O0MyX/NGirkYsV/sq33w1AV5NrldGAUI8PuBzb2XtTF0vKNw1DQ==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a05:690c:945:b0:6db:7b3d:b414
 with SMTP id
 00721157ae682-6e2c6e9b946mr1970347b3.0.1728350350652; Mon, 07 Oct 2024
 18:19:10 -0700 (PDT)
Date: Mon,  7 Oct 2024 18:18:35 -0700
In-Reply-To: <20241008011852.1439154-1-tavip@google.com>
Mime-Version: 1.0
References: <20241008011852.1439154-1-tavip@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241008011852.1439154-10-tavip@google.com>
Subject: [PATCH v2 09/25] hw/ssi: add support for flexcomm spi
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr, 
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org, jsnow@redhat.com, 
 crosa@redhat.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3jogEZwUKCu8kRmZgXffXcV.TfdhVdl-UVmVcefeXel.fiX@flex--tavip.bounces.google.com;
 helo=mail-yw1-x114a.google.com
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

From: Sebastian Ene <sebastianene@google.com>

Add support for NXP's flexcomm spi. It supports FIFO access,
interrupts and master mode only. It does not support DMA.

The patch includes an automatically generated header which contains
the register layout and helpers.

The header can be regenerated with the svd-flexcomm-spi target when
the build is configured with --enable-mcux-soc-svd.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
[tavip: add suport for CFG.SPOL, CFG.LSBF, TX control flags per FIFO
entry and 8/16 bit access to FIFORD and FIFOWR, convert to Resettable
interface, add support for migration]
Signed-off-by: Octavian Purdila <tavip@google.com>
---
 include/hw/arm/svd/flexcomm_spi.h | 327 +++++++++++++++++++++++
 include/hw/misc/flexcomm.h        |   2 +
 include/hw/ssi/flexcomm_spi.h     |  36 +++
 hw/misc/flexcomm.c                |   3 +
 hw/ssi/flexcomm_spi.c             | 422 ++++++++++++++++++++++++++++++
 hw/arm/svd/meson.build            |   4 +
 hw/misc/Kconfig                   |   1 +
 hw/ssi/meson.build                |   1 +
 hw/ssi/trace-events               |   5 +
 9 files changed, 801 insertions(+)
 create mode 100644 include/hw/arm/svd/flexcomm_spi.h
 create mode 100644 include/hw/ssi/flexcomm_spi.h
 create mode 100644 hw/ssi/flexcomm_spi.c

diff --git a/include/hw/arm/svd/flexcomm_spi.h b/include/hw/arm/svd/flexcomm_spi.h
new file mode 100644
index 0000000000..c9ab2c661a
--- /dev/null
+++ b/include/hw/arm/svd/flexcomm_spi.h
@@ -0,0 +1,327 @@
+/*
+ * Copyright 2016-2023 NXP SPDX-License-Identifier: BSD-3-Clause
+ *
+ * Automatically generated by svd-gen-header.py from MIMXRT595S_cm33.xml
+ */
+#pragma once
+
+#include "hw/register.h"
+
+/* Serial Peripheral Interfaces (SPI) */
+#define FLEXCOMM_SPI_REGS_NO (1024)
+
+/* Configuration Register */
+REG32(FLEXCOMM_SPI_CFG, 0x400);
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
+/* Status Register */
+REG32(FLEXCOMM_SPI_STAT, 0x408);
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
+REG32(FLEXCOMM_SPI_INTENSET, 0x40C);
+
+/* Interrupt Enable Clear Register */
+REG32(FLEXCOMM_SPI_INTENCLR, 0x410);
+
+/* Interrupt Status Register */
+REG32(FLEXCOMM_SPI_INTSTAT, 0x428);
+
+/* FIFO Configuration Register */
+REG32(FLEXCOMM_SPI_FIFOCFG, 0xE00);
+/* Enable the Transmit FIFO */
+FIELD(FLEXCOMM_SPI_FIFOCFG, ENABLETX, 0, 1);
+/* Enable the Receive FIFO */
+FIELD(FLEXCOMM_SPI_FIFOCFG, ENABLERX, 1, 1);
+/* Empty Command for the Transmit FIFO */
+FIELD(FLEXCOMM_SPI_FIFOCFG, EMPTYTX, 16, 1);
+/* Empty Command for the Receive FIFO */
+FIELD(FLEXCOMM_SPI_FIFOCFG, EMPTYRX, 17, 1);
+
+/* FIFO Status Register */
+REG32(FLEXCOMM_SPI_FIFOSTAT, 0xE04);
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
+REG32(FLEXCOMM_SPI_FIFOTRIG, 0xE08);
+/* Transmit FIFO Level Trigger Enable */
+FIELD(FLEXCOMM_SPI_FIFOTRIG, TXLVLENA, 0, 1);
+/* Receive FIFO Level Trigger Enable */
+FIELD(FLEXCOMM_SPI_FIFOTRIG, RXLVLENA, 1, 1);
+/* Transmit FIFO Level Trigger Point */
+FIELD(FLEXCOMM_SPI_FIFOTRIG, TXLVL, 8, 4);
+/* Trigger when the TX FIFO becomes empty */
+#define FLEXCOMM_SPI_FIFOTRIG_TXLVL_TXLVL0 0
+/* Trigger when the TX FIFO level decreases to 1 entry */
+#define FLEXCOMM_SPI_FIFOTRIG_TXLVL_TXLVL1 1
+/* Trigger when the TX FIFO level decreases to 15 entries (is no longer full) */
+#define FLEXCOMM_SPI_FIFOTRIG_TXLVL_TXLVL15 15
+/* Receive FIFO Level Trigger Point */
+FIELD(FLEXCOMM_SPI_FIFOTRIG, RXLVL, 16, 4);
+/* Trigger when the RX FIFO has received 1 entry (is no longer empty) */
+#define FLEXCOMM_SPI_FIFOTRIG_RXLVL_RXLVL1 0
+/* Trigger when the RX FIFO has received 2 entries */
+#define FLEXCOMM_SPI_FIFOTRIG_RXLVL_RXLVL2 1
+/* Trigger when the RX FIFO has received 16 entries (has become full) */
+#define FLEXCOMM_SPI_FIFOTRIG_RXLVL_RXLVL15 15
+
+/* FIFO Interrupt Enable Register */
+REG32(FLEXCOMM_SPI_FIFOINTENSET, 0xE10);
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
+REG32(FLEXCOMM_SPI_FIFOINTENCLR, 0xE14);
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
+REG32(FLEXCOMM_SPI_FIFOINTSTAT, 0xE18);
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
+REG32(FLEXCOMM_SPI_FIFOWR, 0xE20);
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
+/* Data transfer is 4 bits in length */
+#define FLEXCOMM_SPI_FIFOWR_LEN_LEN_4BITS 3
+/* Data transfer is 5 bits in length */
+#define FLEXCOMM_SPI_FIFOWR_LEN_LEN_5BITS 4
+/* Data transfer is 16 bits in length */
+#define FLEXCOMM_SPI_FIFOWR_LEN_LEN_16BITS 15
+
+/* FIFO Read Data Register */
+REG32(FLEXCOMM_SPI_FIFORD, 0xE30);
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
+REG32(FLEXCOMM_SPI_FIFORDNOPOP, 0xE40);
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
+REG32(FLEXCOMM_SPI_FIFOSIZE, 0xE48);
+/* FIFO Size */
+FIELD(FLEXCOMM_SPI_FIFOSIZE, FIFOSIZE, 0, 5);
+
+
+#define FLEXCOMM_SPI_REGISTER_ACCESS_INFO_ARRAY(_name) \
+    struct RegisterAccessInfo _name[FLEXCOMM_SPI_REGS_NO] = { \
+        [0 ... FLEXCOMM_SPI_REGS_NO - 1] = { \
+            .name = "", \
+            .addr = -1, \
+        }, \
+        [0x100] = { \
+            .name = "CFG", \
+            .addr = 0x400, \
+            .ro = 0xFFFFF042, \
+            .reset = 0x0, \
+        }, \
+        [0x101] = { \
+            .name = "DLY", \
+            .addr = 0x404, \
+            .ro = 0xFFFF0000, \
+            .reset = 0x0, \
+        }, \
+        [0x102] = { \
+            .name = "STAT", \
+            .addr = 0x408, \
+            .ro = 0xFFFFFF4F, \
+            .reset = 0x100, \
+        }, \
+        [0x103] = { \
+            .name = "INTENSET", \
+            .addr = 0x40C, \
+            .ro = 0xFFFFFECF, \
+            .reset = 0x0, \
+        }, \
+        [0x104] = { \
+            .name = "INTENCLR", \
+            .addr = 0x410, \
+            .ro = 0xFFFFFECF, \
+            .reset = 0x0, \
+        }, \
+        [0x109] = { \
+            .name = "DIV", \
+            .addr = 0x424, \
+            .ro = 0xFFFF0000, \
+            .reset = 0x0, \
+        }, \
+        [0x10A] = { \
+            .name = "INTSTAT", \
+            .addr = 0x428, \
+            .ro = 0xFFFFFFFF, \
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
+            .ro = 0xF0000000, \
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
+            .reset = 0x0, \
+        }, \
+        [0x3FF] = { \
+            .name = "ID", \
+            .addr = 0xFFC, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0xE0201200, \
+        }, \
+    }
diff --git a/include/hw/misc/flexcomm.h b/include/hw/misc/flexcomm.h
index c9f1cd3890..757453df97 100644
--- a/include/hw/misc/flexcomm.h
+++ b/include/hw/misc/flexcomm.h
@@ -17,6 +17,7 @@
 #include "qemu/fifo32.h"
 #include "hw/char/flexcomm_usart.h"
 #include "hw/i2c/flexcomm_i2c.h"
+#include "hw/ssi/flexcomm_spi.h"
 
 #define FLEXCOMM_FUNC_USART     0
 #define FLEXCOMM_FUNC_SPI       1
@@ -50,6 +51,7 @@ struct FlexcommState {
     Fifo32 tx_fifo;
     FlexcommUsartState usart;
     FlexcommI2cState i2c;
+    FlexcommSpiState spi;
 };
 
 #endif /* HW_FLEXCOMM_H */
diff --git a/include/hw/ssi/flexcomm_spi.h b/include/hw/ssi/flexcomm_spi.h
new file mode 100644
index 0000000000..c39cc33de4
--- /dev/null
+++ b/include/hw/ssi/flexcomm_spi.h
@@ -0,0 +1,36 @@
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
+#ifndef HW_FLEXCOMM_SPI_H
+#define HW_FLEXCOMM_SPI_H
+
+#include "hw/misc/flexcomm_function.h"
+#include "hw/ssi/ssi.h"
+
+#define TYPE_FLEXCOMM_SPI "flexcomm-spi"
+OBJECT_DECLARE_TYPE(FlexcommSpiState, FlexcommSpiClass, FLEXCOMM_SPI);
+
+struct FlexcommSpiState {
+    FlexcommFunction parent_obj;
+
+    SSIBus *bus;
+    qemu_irq cs[4];
+    bool cs_asserted[4];
+    uint32_t tx_ctrl;
+};
+
+struct FlexcommSpiClass {
+    FlexcommFunctionClass parent_obj;
+
+    FlexcommFunctionSelect select;
+};
+
+#endif /* HW_FLEXCOMM_SPI_H */
diff --git a/hw/misc/flexcomm.c b/hw/misc/flexcomm.c
index b1a2f01acf..fef220eb5b 100644
--- a/hw/misc/flexcomm.c
+++ b/hw/misc/flexcomm.c
@@ -25,6 +25,7 @@
 #include "hw/arm/svd/flexcomm_usart.h"
 #include "hw/char/flexcomm_usart.h"
 #include "hw/i2c/flexcomm_i2c.h"
+#include "hw/ssi/flexcomm_spi.h"
 
 #define REG(s, reg) (s->regs[R_FLEXCOMM_##reg])
 #define RF_WR(s, reg, field, val) \
@@ -222,6 +223,7 @@ static void flexcomm_init(Object *obj)
     sysbus_init_irq(sbd, &s->irq);
     object_initialize_child(obj, "usart", &s->usart, TYPE_FLEXCOMM_USART);
     object_initialize_child(obj, "i2c", &s->i2c, TYPE_FLEXCOMM_I2C);
+    object_initialize_child(obj, "spi", &s->spi, TYPE_FLEXCOMM_SPI);
 }
 
 static void flexcomm_finalize(Object *obj)
@@ -253,6 +255,7 @@ static void flexcomm_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion_overlap(&s->container, 0, &s->mmio, -1);
     flexcomm_func_realize_and_unref(FLEXCOMM_FUNCTION(&s->usart), errp);
     flexcomm_func_realize_and_unref(FLEXCOMM_FUNCTION(&s->i2c), errp);
+    flexcomm_func_realize_and_unref(FLEXCOMM_FUNCTION(&s->spi), errp);
 }
 
 static const VMStateDescription vmstate_flexcomm = {
diff --git a/hw/ssi/flexcomm_spi.c b/hw/ssi/flexcomm_spi.c
new file mode 100644
index 0000000000..d8ecd37024
--- /dev/null
+++ b/hw/ssi/flexcomm_spi.c
@@ -0,0 +1,422 @@
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
+#include "migration/vmstate.h"
+#include "hw/misc/flexcomm.h"
+#include "hw/arm/svd/flexcomm_spi.h"
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
+static void flexcomm_spi_reset(FlexcommFunction *f)
+{
+    for (int i = 0; i < FLEXCOMM_SPI_REGS_NO; i++) {
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
+
+    RF_WR(f, FIFOSIZE, FIFOSIZE, 0x8);
+}
+
+static void flexcomm_spi_irq_update(FlexcommFunction *f)
+{
+    bool irq, per_irqs, fifo_irqs, enabled = RF_RD(f, CFG, ENABLE);
+
+    flexcomm_update_fifostat(f);
+    fifo_irqs = REG(f, FIFOINTSTAT) & REG(f, FIFOINTENSET);
+
+    REG(f, INTSTAT) = REG(f, STAT) & REG(f, INTENSET);
+    per_irqs = REG(f, INTSTAT) != 0;
+
+    irq = enabled && (fifo_irqs || per_irqs);
+
+    trace_flexcomm_spi_irq(DEVICE(f)->id, irq, fifo_irqs, per_irqs, enabled);
+    flexcomm_set_irq(f, irq);
+}
+
+static void flexcomm_spi_select(FlexcommFunction *f, bool selected)
+{
+    FlexcommSpiState *s = FLEXCOMM_SPI(f);
+    FlexcommSpiClass *sc = FLEXCOMM_SPI_GET_CLASS(f);
+
+    if (selected) {
+        bool spol[] = {
+            RF_RD(f, CFG, SPOL0), RF_RD(f, CFG, SPOL1), RF_RD(f, CFG, SPOL2),
+            RF_RD(f, CFG, SPOL3),
+        };
+
+        flexcomm_spi_reset(f);
+        for (int i = 0; i < ARRAY_SIZE(s->cs); i++) {
+            s->cs_asserted[i] = false;
+            qemu_set_irq(s->cs[i], !spol[i]);
+        }
+    }
+    sc->select(f, selected);
+}
+
+static MemTxResult flexcomm_spi_reg_read(void *opaque, hwaddr addr,
+                                         uint64_t *data, unsigned size,
+                                         MemTxAttrs attrs)
+{
+    FlexcommFunction *f = FLEXCOMM_FUNCTION(opaque);
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
+        if (RF_RD(f, CFG, LOOP) &&
+            RF_RD(f, CFG, MASTER))
+        {
+            if (!fifo32_is_empty(f->tx_fifo)) {
+                *data = fifo32_pop(f->tx_fifo);
+            }
+            break;
+        }
+
+        if (!fifo32_is_empty(f->rx_fifo)) {
+            *data = fifo32_pop(f->rx_fifo);
+        }
+        break;
+    }
+    case A_FLEXCOMM_SPI_FIFORDNOPOP:
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
+    flexcomm_spi_irq_update(f);
+
+out:
+    trace_flexcomm_spi_reg_read(DEVICE(f)->id, rai->name, addr, *data);
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
+static uint32_t flexcomm_spi_xfer_word(FlexcommSpiState *s, uint32_t out_data,
+                                       int bytes, bool be)
+{
+    uint32_t word = 0;
+    int out = 0;
+
+    for (int i = 0; i < bytes; i++) {
+        if (be) {
+            int byte_offset = bytes - i - 1;
+            out = (out_data & (0xFF << byte_offset * 8)) >> byte_offset * 8;
+            word |= ssi_transfer(s->bus, out) << byte_offset * 8;
+        } else {
+            out = (out_data & (0xFF << i * 8)) >> i * 8;
+            word |= ssi_transfer(s->bus, out) << i * 8;
+        }
+    }
+
+    return word;
+}
+
+static uint32_t flexcomm_spi_get_ss_mask(FlexcommSpiState *s,
+                                        uint32_t txfifo_val)
+{
+    FlexcommFunction *f = FLEXCOMM_FUNCTION(s);
+
+    uint32_t slave_select_mask = 0;
+    bool ss[] = {
+        FIELD_EX32(txfifo_val, FLEXCOMM_SPI_FIFOWR, TXSSEL0_N),
+        FIELD_EX32(txfifo_val, FLEXCOMM_SPI_FIFOWR, TXSSEL1_N),
+        FIELD_EX32(txfifo_val, FLEXCOMM_SPI_FIFOWR, TXSSEL2_N),
+        FIELD_EX32(txfifo_val, FLEXCOMM_SPI_FIFOWR, TXSSEL3_N),
+    };
+    bool spol[] = {
+        RF_RD(f, CFG, SPOL0), RF_RD(f, CFG, SPOL1), RF_RD(f, CFG, SPOL2),
+        RF_RD(f, CFG, SPOL3),
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
+static MemTxResult flexcomm_spi_reg_write(void *opaque, hwaddr addr,
+                                          uint64_t value, unsigned size,
+                                          MemTxAttrs attrs)
+{
+    FlexcommFunction *f = FLEXCOMM_FUNCTION(opaque);
+    FlexcommSpiState *s = FLEXCOMM_SPI(opaque);
+    const struct RegisterAccessInfo *rai = &reg_info[addr / 4];
+    struct RegisterInfo ri = {
+        .data = &f->regs[addr / 4],
+        .data_size = 4,
+        .access = rai,
+    };
+    MemTxResult ret = MEMTX_OK;
+
+    trace_flexcomm_spi_reg_write(DEVICE(f)->id, rai->name, addr, value);
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
+        break;
+    }
+    case A_FLEXCOMM_SPI_INTENCLR:
+    {
+        register_write(&ri, value, ~0, NULL, false);
+        REG(f, INTENSET) &= ~REG(f, INTENCLR);
+        break;
+    }
+    case A_FLEXCOMM_SPI_FIFOCFG:
+    {
+        register_write(&ri, value, ~0, NULL, false);
+        flexcomm_reset_fifos(f);
+        break;
+    }
+    case A_FLEXCOMM_SPI_FIFOSTAT:
+    {
+        flexcomm_clear_fifostat(f, value);
+        break;
+    }
+    case A_FLEXCOMM_SPI_FIFOINTENSET:
+    {
+        REG(f, FIFOINTENSET) |= value;
+        break;
+    }
+    case A_FLEXCOMM_SPI_FIFOINTENCLR:
+    {
+        register_write(&ri, value, ~0, NULL, false);
+        REG(f, FIFOINTENSET) &= ~REG(f, FIFOINTENCLR);
+        break;
+    }
+    /* update control bits but don't push into the FIFO */
+    case A_FLEXCOMM_SPI_FIFOWR + 2:
+    {
+        if (value != 0) {
+            s->tx_ctrl = value << 16;
+        }
+        break;
+    }
+    /* update control bits but don't push into the FIFO */
+    case A_FLEXCOMM_SPI_FIFOWR + 3:
+    {
+        if (value != 0) {
+            s->tx_ctrl = value << 24;
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
+            s->tx_ctrl = tx_ctrl;
+        }
+
+        /* push the data and control bits into the FIFO */
+        txfifo_val = tx_data | s->tx_ctrl;
+
+        if (!fifo32_is_full(f->tx_fifo)) {
+            fifo32_push(f->tx_fifo, txfifo_val);
+        }
+
+        if (!RF_RD(f, CFG, ENABLE) || !RF_RD(f, FIFOCFG, ENABLETX)) {
+            break;
+        }
+
+        /*
+         * On loopback mode we just insert the values in the TX FIFO. On slave
+         * mode master needs to initiate the SPI transfer.
+         */
+        if (RF_RD(f, CFG, LOOP) || !RF_RD(f, CFG, MASTER)) {
+            break;
+        }
+
+        while (!fifo32_is_empty(f->tx_fifo)) {
+            txfifo_val = fifo32_pop(f->tx_fifo);
+
+            uint32_t ss_mask = flexcomm_spi_get_ss_mask(s, txfifo_val);
+            uint32_t data = FIELD_EX32(txfifo_val, FLEXCOMM_SPI_FIFOWR, TXDATA);
+            uint8_t bytes = fifowr_len_bytes(txfifo_val);
+            bool msb = !RF_RD(f, CFG, LSBF);
+            uint32_t val32;
+
+            val32 = flexcomm_spi_xfer_word(s, data, bytes, msb);
+
+            if (!fifo32_is_full(f->rx_fifo)) {
+                /* Append the mask that informs which client is active */
+                val32 |= (ss_mask << R_FLEXCOMM_SPI_FIFORD_RXSSEL0_N_SHIFT);
+                fifo32_push(f->rx_fifo, val32);
+            }
+
+            /* If this is the end of the transfer raise the CS line */
+            if (FIELD_EX32(txfifo_val, FLEXCOMM_SPI_FIFOWR, EOT)) {
+                bool spol[ARRAY_SIZE(s->cs)] = {
+                    RF_RD(f, CFG, SPOL0),
+                    RF_RD(f, CFG, SPOL1),
+                    RF_RD(f, CFG, SPOL2),
+                    RF_RD(f, CFG, SPOL3),
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
+    flexcomm_spi_irq_update(f);
+
+    return ret;
+}
+
+static const MemoryRegionOps flexcomm_spi_ops = {
+    .read_with_attrs = flexcomm_spi_reg_read,
+    .write_with_attrs = flexcomm_spi_reg_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static void flexcomm_spi_realize(DeviceState *dev, Error **error)
+{
+    FlexcommSpiState *s = FLEXCOMM_SPI(dev);
+
+    s->bus = ssi_create_bus(DEVICE(s), "bus");
+    qdev_init_gpio_out_named(DEVICE(s), s->cs, "cs", ARRAY_SIZE(s->cs));
+}
+
+static const VMStateDescription vmstate_flexcomm_spi = {
+    .name = "flexcomm-spi",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_BOOL_ARRAY(cs_asserted, FlexcommSpiState, 4),
+        VMSTATE_UINT32(tx_ctrl, FlexcommSpiState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void flexcomm_spi_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    FlexcommFunctionClass *fc = FLEXCOMM_FUNCTION_CLASS(klass);
+    FlexcommSpiClass *sc = FLEXCOMM_SPI_CLASS(klass);
+
+    dc->realize = flexcomm_spi_realize;
+    dc->vmsd = &vmstate_flexcomm_spi;
+    sc->select = fc->select;
+    fc->select = flexcomm_spi_select;
+    fc->name = "spi";
+    fc->has_fifos = true;
+    fc->mmio_ops = &flexcomm_spi_ops;
+}
+
+static const TypeInfo flexcomm_spi_types[] = {
+    {
+        .name          = TYPE_FLEXCOMM_SPI,
+        .parent        = TYPE_FLEXCOMM_FUNCTION,
+        .instance_size = sizeof(FlexcommSpiState),
+        .class_init    = flexcomm_spi_class_init,
+        .class_size    = sizeof(FlexcommSpiClass),
+    },
+};
+
+DEFINE_TYPES(flexcomm_spi_types);
diff --git a/hw/arm/svd/meson.build b/hw/arm/svd/meson.build
index 2542b56294..e7d62a7f35 100644
--- a/hw/arm/svd/meson.build
+++ b/hw/arm/svd/meson.build
@@ -12,4 +12,8 @@ if get_option('mcux-soc-svd')
     [ '-i', rt595, '-o', '@SOURCE_ROOT@/include/hw/arm/svd/flexcomm_i2c.h',
       '-p', 'I2C0', '-t', 'FLEXCOMM_I2C',
       '--fields', 'CFG TIMEOUT:TOMIN MSTCTL MSTDAT STAT:MSTPENDING,MSTSTATE INT*:MSTPENDING* SLV*:'])
+  run_target('svd-flexcomm-spi', command: svd_gen_header +
+    [ '-i', rt595, '-o', '@SOURCE_ROOT@/include/hw/arm/svd/flexcomm_spi.h',
+      '-p', 'SPI0', '-t', 'FLEXCOMM_SPI',
+      '--fields', 'CFG FIFOCFG:ENABLE*,EMPTY* FIFO*:* INT*: STAT'])
 endif
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 9a244fa01d..b373e651e1 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -216,5 +216,6 @@ config XLNX_VERSAL_TRNG
 config FLEXCOMM
     bool
     select I2C
+    select SSI
 
 source macio/Kconfig
diff --git a/hw/ssi/meson.build b/hw/ssi/meson.build
index 23cd425ab0..58e0d14b37 100644
--- a/hw/ssi/meson.build
+++ b/hw/ssi/meson.build
@@ -12,3 +12,4 @@ system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_spi.c'))
 system_ss.add(when: 'CONFIG_IBEX', if_true: files('ibex_spi_host.c'))
 system_ss.add(when: 'CONFIG_BCM2835_SPI', if_true: files('bcm2835_spi.c'))
 system_ss.add(when: 'CONFIG_PNV_SPI', if_true: files('pnv_spi.c'))
+system_ss.add(when: 'CONFIG_FLEXCOMM', if_true: files('flexcomm_spi.c'))
diff --git a/hw/ssi/trace-events b/hw/ssi/trace-events
index 089d269994..f849f1f8be 100644
--- a/hw/ssi/trace-events
+++ b/hw/ssi/trace-events
@@ -53,3 +53,8 @@ pnv_spi_rx_read_N2frame(void) ""
 pnv_spi_shift_rx(uint8_t byte, uint32_t index) "byte = 0x%2.2x into RDR from payload index %d"
 pnv_spi_sequencer_stop_requested(const char* reason) "due to %s"
 pnv_spi_RDR_match(const char* result) "%s"
+
+# flexcomm_spi.c
+flexcomm_spi_reg_read(const char *id, const char *reg_name, uint32_t addr, uint32_t val) " %s: %s[0x%04x] -> 0x%08x"
+flexcomm_spi_reg_write(const char *id, const char *reg_name, uint32_t addr, uint32_t val) "%s: %s[0x%04x] <- 0x%08x"
+flexcomm_spi_irq(const char *id, bool irq, bool fifoirqs, bool perirqs, bool enabled) "%s: %d %d %d %d"
-- 
2.47.0.rc0.187.ge670bccf7e-goog


