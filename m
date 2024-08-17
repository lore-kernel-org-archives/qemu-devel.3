Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A2AC52D7F
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2024 10:28:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfGeK-00087A-Ht; Sat, 17 Aug 2024 06:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <35XrAZgUKChoJ0L8F6EE6B4.2ECG4CK-34L4BDED6DK.EH6@flex--tavip.bounces.google.com>)
 id 1sfGeC-0007Sc-R0
 for qemu-devel@nongnu.org; Sat, 17 Aug 2024 06:27:01 -0400
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <35XrAZgUKChoJ0L8F6EE6B4.2ECG4CK-34L4BDED6DK.EH6@flex--tavip.bounces.google.com>)
 id 1sfGe1-0003MS-Kb
 for qemu-devel@nongnu.org; Sat, 17 Aug 2024 06:26:56 -0400
Received: by mail-pf1-x44a.google.com with SMTP id
 d2e1a72fcca58-7104f37771eso2531082b3a.2
 for <qemu-devel@nongnu.org>; Sat, 17 Aug 2024 03:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1723890407; x=1724495207; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=vfoeE0ROQLqrqANwkPHf1SaF+L7jJAjfzTp6KCQeYAA=;
 b=ma7zr0EQGjSeanvfyyjoBOzo27fEmwMYOhs3fgB5saT44qzbyio8z6J14V1rznclm/
 fCKcJyMZ6gaosMPUsPJ/IVri7Oa5T/ABAYLLrOeasBfOvtPNZlUJssFpeDxJ5GIcnMRR
 87+oV4AhDXp9d5s6zuhfPJuocx5brS5GNsA+xD3KEOhDiRYi+AJEXASNF+dVkdjJV0Xm
 rGiADlJYhvec+3VB48mv+G2FLzFIMXpwmF6mGx6u/zziaCcesN0HAaLntyX49C8dJfUX
 l1InQnV/E9AJYypBhPw4Fh3HU9WcX+WXAGuQMR8uI0kMvGvuDiAPnn53zhDCBX/IOe8S
 QNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723890407; x=1724495207;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vfoeE0ROQLqrqANwkPHf1SaF+L7jJAjfzTp6KCQeYAA=;
 b=jDxzg0xUSYmLyLWnbaxIfylJCMAk0chKq4MkUPzOcPaSJu7DBdvDTR7ZhMUeLnRiew
 kBsaHs+KA3xhmLkN/BY0BROqvUGbWWiHievlQCMKcrxYS+ilO4ES4jBOBJ6ZZKRDOn/6
 JFXKXJTTE0LZkjlAi1TwSERn+q900usPYyIgKkC/4tKLVU6x1tC/a/hvE5B4/qwYP+dK
 ecXtgk2KqehrSAI73wSG8oLze48BLR9nXBC+2HKqFwABw8fJC703QDdABfufcaUkwsS+
 Zb5KkrnydcRgpPtt9vbHuhXiuBODvDmPL3hA9KEqIjeFqHpqBy87Z9fB+H7RdRJbJ1I8
 EEbA==
X-Gm-Message-State: AOJu0YxWfjv73AQdjfV74U5sN/2IwUvL4nasLeZqjwRX8HNHXDDsB+Np
 6KKco5XAom7GNjSDKooPdQgN/FHCylAPN6S9hw2wTcq5E/qkapQJrd5UrQA1DYDTsQzYgZlFrga
 lymXRqGW82zGOAyM0rZg+dfOV06Dy1d8aEFBzSeP03t4vLS0Fa0lgEVeZnM9xxJHzpsZBonxKaO
 E3IAlodk876/SytT8zGBj8j5Mwrg==
X-Google-Smtp-Source: AGHT+IHEzzbwECDFmSxZGyZI/ItJvoftOIqQxxciqRWobL8HWQjNqfbhGmt7Sqo5/CI/IBgLgDpr91QOSw==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a05:6a00:48:b0:705:ca19:2d08 with
 SMTP id
 d2e1a72fcca58-713c53d82d5mr14693b3a.6.1723890405717; Sat, 17 Aug 2024
 03:26:45 -0700 (PDT)
Date: Sat, 17 Aug 2024 03:26:03 -0700
In-Reply-To: <20240817102606.3996242-1-tavip@google.com>
Mime-Version: 1.0
References: <20240817102606.3996242-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240817102606.3996242-21-tavip@google.com>
Subject: [RFC PATCH v2 20/23] hw/ssi: add support for flexspi
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 thuth@redhat.com, peter.maydell@linaro.org, marcandre.lureau@redhat.com, 
 alistair@alistair23.me, berrange@redhat.com, philmd@linaro.org, 
 jsnow@redhat.com, crosa@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::44a;
 envelope-from=35XrAZgUKChoJ0L8F6EE6B4.2ECG4CK-34L4BDED6DK.EH6@flex--tavip.bounces.google.com;
 helo=mail-pf1-x44a.google.com
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

This is mostly a stub which completes SPI transactions as noops
by masking out the error interrupts and never clearing the IPCMDDONE
interrupt.

Although incomplete, this allows software that uses NXP's mcuxpresso
SDK to run the SDK board initialization functions.

It also supports AHB memory access, aka XIP, for now as simple RAM
memory regions.

The patch includes an automatically generated header which contains
the register layout and helpers.

The header can be regenerated with the svd-flexspi target when the
build is configured with --enable-mcux-soc-svd.

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 include/hw/arm/svd/flexspi.h | 2100 ++++++++++++++++++++++++++++++++++
 include/hw/ssi/flexspi.h     |   32 +
 hw/ssi/flexspi.c             |  157 +++
 hw/arm/svd/meson.build       |    3 +
 hw/ssi/Kconfig               |    4 +
 hw/ssi/meson.build           |    1 +
 hw/ssi/trace-events          |    4 +
 7 files changed, 2301 insertions(+)
 create mode 100644 include/hw/arm/svd/flexspi.h
 create mode 100644 include/hw/ssi/flexspi.h
 create mode 100644 hw/ssi/flexspi.c

diff --git a/include/hw/arm/svd/flexspi.h b/include/hw/arm/svd/flexspi.h
new file mode 100644
index 0000000000..5b789aa4f4
--- /dev/null
+++ b/include/hw/arm/svd/flexspi.h
@@ -0,0 +1,2100 @@
+/*
+ * Copyright 2016-2023 NXP SPDX-License-Identifier: BSD-3-Clause
+ *
+ * Automatically generated by svd-gen-header.py from MIMXRT595S_cm33.xml
+ */
+#pragma once
+
+#include "hw/registerfields.h"
+
+/* FlexSPI */
+#define FLEXSPI_REGS_NO (267)
+
+/* Module Control Register 0 */
+REG32(FLEXSPI_MCR0, 0);
+/* Software Reset */
+FIELD(FLEXSPI_MCR0, SWRESET, 0, 1);
+/* Module Disable */
+FIELD(FLEXSPI_MCR0, MDIS, 1, 1);
+/* Sample Clock source selection for Flash Reading */
+FIELD(FLEXSPI_MCR0, RXCLKSRC, 4, 2);
+/* Serial root clock */
+FIELD(FLEXSPI_MCR0, SERCLKDIV, 8, 3);
+/* Half Speed Serial Flash Access Enable. */
+FIELD(FLEXSPI_MCR0, HSEN, 11, 1);
+/* Doze mode enable bit */
+FIELD(FLEXSPI_MCR0, DOZEEN, 12, 1);
+/*
+ * This bit is used to enable SCLK output free-running. For FPGA applications,
+ * the external device may use SCLK as reference clock to its internal PLL.
+ */
+FIELD(FLEXSPI_MCR0, SCKFREERUNEN, 14, 1);
+/* This bit is used to enable/disable the data learning feature. */
+FIELD(FLEXSPI_MCR0, LEARNEN, 15, 1);
+/* Timeout wait cycle for IP command grant. */
+FIELD(FLEXSPI_MCR0, IPGRANTWAIT, 16, 8);
+/* Timeout wait cycle for AHB command grant. */
+FIELD(FLEXSPI_MCR0, AHBGRANTWAIT, 24, 8);
+
+/* Module Control Register 1 */
+REG32(FLEXSPI_MCR1, 4);
+/* AHB Bus wait */
+FIELD(FLEXSPI_MCR1, AHBBUSWAIT, 0, 16);
+/*
+ * Command Sequence Execution will timeout and abort after SEQWAIT * 1024
+ * Serial Root Clock cycles. When sequence execution timeout occurs, there will
+ * be an interrupt generated (INTR[SEQTIMEOUT]) if this interrupt is enabled
+ * (INTEN[SEQTIMEOUTEN] is set 0x1) and AHB command is ignored by arbitrator.
+ */
+FIELD(FLEXSPI_MCR1, SEQWAIT, 16, 16);
+
+/* Module Control Register 2 */
+REG32(FLEXSPI_MCR2, 8);
+/* Clear AHB buffer */
+FIELD(FLEXSPI_MCR2, CLRAHBBUFOPT, 11, 1);
+/*
+ * The sampling clock phase selection will be reset to phase 0 when this bit is
+ * written with 0x1. This bit will be auto-cleared immediately.
+ */
+FIELD(FLEXSPI_MCR2, CLRLEARNPHASE, 14, 1);
+/*
+ * All external devices are same devices (both in type and size) for
+ * A1/A2/B1/B2.
+ */
+FIELD(FLEXSPI_MCR2, SAMEDEVICEEN, 15, 1);
+/*
+ * Wait cycle (in AHB clock cycle) for idle state before suspended command
+ * sequence resumed.
+ */
+FIELD(FLEXSPI_MCR2, RESUMEWAIT, 24, 8);
+
+/* AHB Bus Control Register */
+REG32(FLEXSPI_AHBCR, 12);
+/* Parallel mode enabled for AHB triggered Command (both read and write). */
+FIELD(FLEXSPI_AHBCR, APAREN, 0, 1);
+/* Clear the status/pointers of AHB TX Buffer. Auto-cleared. */
+FIELD(FLEXSPI_AHBCR, CLRAHBTXBUF, 2, 1);
+/* Enable AHB bus cachable read access support. */
+FIELD(FLEXSPI_AHBCR, CACHABLEEN, 3, 1);
+/* Enable AHB bus bufferable write access support. */
+FIELD(FLEXSPI_AHBCR, BUFFERABLEEN, 4, 1);
+/* AHB Read Prefetch Enable. */
+FIELD(FLEXSPI_AHBCR, PREFETCHEN, 5, 1);
+/*
+ * AHB Read Address option bit. This option bit is intended to remove AHB burst
+ * start address alignment limitation.
+ */
+FIELD(FLEXSPI_AHBCR, READADDROPT, 6, 1);
+/* AHB Read Resume Disable */
+FIELD(FLEXSPI_AHBCR, RESUMEDISABLE, 7, 1);
+/* AHB Read Size Alignment */
+FIELD(FLEXSPI_AHBCR, READSZALIGN, 10, 1);
+
+/* Interrupt Enable Register */
+REG32(FLEXSPI_INTEN, 16);
+/* IP triggered Command Sequences Execution finished interrupt enable. */
+FIELD(FLEXSPI_INTEN, IPCMDDONEEN, 0, 1);
+/* IP triggered Command Sequences Grant Timeout interrupt enable. */
+FIELD(FLEXSPI_INTEN, IPCMDGEEN, 1, 1);
+/* AHB triggered Command Sequences Grant Timeout interrupt enable. */
+FIELD(FLEXSPI_INTEN, AHBCMDGEEN, 2, 1);
+/* IP triggered Command Sequences Error Detected interrupt enable. */
+FIELD(FLEXSPI_INTEN, IPCMDERREN, 3, 1);
+/* AHB triggered Command Sequences Error Detected interrupt enable. */
+FIELD(FLEXSPI_INTEN, AHBCMDERREN, 4, 1);
+/* IP RX FIFO WaterMark available interrupt enable. */
+FIELD(FLEXSPI_INTEN, IPRXWAEN, 5, 1);
+/* IP TX FIFO WaterMark empty interrupt enable. */
+FIELD(FLEXSPI_INTEN, IPTXWEEN, 6, 1);
+/* Data Learning failed interrupt enable. */
+FIELD(FLEXSPI_INTEN, DATALEARNFAILEN, 7, 1);
+/*
+ * SCLK is stopped during command sequence because Async RX FIFO full interrupt
+ * enable.
+ */
+FIELD(FLEXSPI_INTEN, SCKSTOPBYRDEN, 8, 1);
+/*
+ * SCLK is stopped during command sequence because Async TX FIFO empty
+ * interrupt enable.
+ */
+FIELD(FLEXSPI_INTEN, SCKSTOPBYWREN, 9, 1);
+/* AHB Bus error interrupt enable. */
+FIELD(FLEXSPI_INTEN, AHBBUSERROREN, 10, 1);
+/* Sequence execution timeout interrupt enable. */
+FIELD(FLEXSPI_INTEN, SEQTIMEOUTEN, 11, 1);
+/* OTFAD key blob processing done interrupt enable. */
+FIELD(FLEXSPI_INTEN, KEYDONEEN, 12, 1);
+/* OTFAD key blob processing error interrupt enable. */
+FIELD(FLEXSPI_INTEN, KEYERROREN, 13, 1);
+
+/* Interrupt Register */
+REG32(FLEXSPI_INTR, 20);
+/*
+ * IP triggered Command Sequences Execution finished interrupt. This interrupt
+ * is also generated when there is IPCMDGE or IPCMDERR interrupt generated.
+ */
+FIELD(FLEXSPI_INTR, IPCMDDONE, 0, 1);
+/* IP triggered Command Sequences Grant Timeout interrupt. */
+FIELD(FLEXSPI_INTR, IPCMDGE, 1, 1);
+/* AHB triggered Command Sequences Grant Timeout interrupt. */
+FIELD(FLEXSPI_INTR, AHBCMDGE, 2, 1);
+/*
+ * IP triggered Command Sequences Error Detected interrupt. When an error
+ * detected for IP command, this command will be ignored and not executed at
+ * all.
+ */
+FIELD(FLEXSPI_INTR, IPCMDERR, 3, 1);
+/*
+ * AHB triggered Command Sequences Error Detected interrupt. When an error
+ * detected for AHB command, this command will be ignored and not executed at
+ * all.
+ */
+FIELD(FLEXSPI_INTR, AHBCMDERR, 4, 1);
+/* IP RX FIFO watermark available interrupt. */
+FIELD(FLEXSPI_INTR, IPRXWA, 5, 1);
+/* IP TX FIFO watermark empty interrupt. */
+FIELD(FLEXSPI_INTR, IPTXWE, 6, 1);
+/* Data Learning failed interrupt. */
+FIELD(FLEXSPI_INTR, DATALEARNFAIL, 7, 1);
+/*
+ * SCLK is stopped during command sequence because Async RX FIFO full
+ * interrupt.
+ */
+FIELD(FLEXSPI_INTR, SCKSTOPBYRD, 8, 1);
+/*
+ * SCLK is stopped during command sequence because Async TX FIFO empty
+ * interrupt.
+ */
+FIELD(FLEXSPI_INTR, SCKSTOPBYWR, 9, 1);
+/*
+ * AHB Bus timeout or AHB bus illegal access Flash during OTFAD key blob
+ * processing interrupt.
+ */
+FIELD(FLEXSPI_INTR, AHBBUSERROR, 10, 1);
+/* Sequence execution timeout interrupt. */
+FIELD(FLEXSPI_INTR, SEQTIMEOUT, 11, 1);
+/* OTFAD key blob processing done interrupt. */
+FIELD(FLEXSPI_INTR, KEYDONE, 12, 1);
+/* OTFAD key blob processing error interrupt. */
+FIELD(FLEXSPI_INTR, KEYERROR, 13, 1);
+
+/* LUT Key Register */
+REG32(FLEXSPI_LUTKEY, 24);
+/* The Key to lock or unlock LUT. */
+FIELD(FLEXSPI_LUTKEY, KEY, 0, 32);
+
+/* LUT Control Register */
+REG32(FLEXSPI_LUTCR, 28);
+/* Lock LUT */
+FIELD(FLEXSPI_LUTCR, LOCK, 0, 1);
+/* Unlock LUT */
+FIELD(FLEXSPI_LUTCR, UNLOCK, 1, 1);
+
+/* AHB RX Buffer 0 Control Register 0 */
+REG32(FLEXSPI_AHBRXBUF0CR0, 32);
+/* AHB RX Buffer Size in 64 bits. */
+FIELD(FLEXSPI_AHBRXBUF0CR0, BUFSZ, 0, 8);
+/* This AHB RX Buffer is assigned according to AHB Master with ID (MSTR_ID). */
+FIELD(FLEXSPI_AHBRXBUF0CR0, MSTRID, 16, 4);
+/*
+ * This priority for AHB Master Read which this AHB RX Buffer is assigned. 7 is
+ * the highest priority, 0 the lowest.
+ */
+FIELD(FLEXSPI_AHBRXBUF0CR0, PRIORITY, 24, 3);
+/* AHB Read Prefetch Enable for current AHB RX Buffer corresponding Master. */
+FIELD(FLEXSPI_AHBRXBUF0CR0, PREFETCHEN, 31, 1);
+
+/* AHB RX Buffer 1 Control Register 0 */
+REG32(FLEXSPI_AHBRXBUF1CR0, 36);
+/* AHB RX Buffer Size in 64 bits. */
+FIELD(FLEXSPI_AHBRXBUF1CR0, BUFSZ, 0, 8);
+/* This AHB RX Buffer is assigned according to AHB Master with ID (MSTR_ID). */
+FIELD(FLEXSPI_AHBRXBUF1CR0, MSTRID, 16, 4);
+/*
+ * This priority for AHB Master Read which this AHB RX Buffer is assigned. 7 is
+ * the highest priority, 0 the lowest.
+ */
+FIELD(FLEXSPI_AHBRXBUF1CR0, PRIORITY, 24, 3);
+/* AHB Read Prefetch Enable for current AHB RX Buffer corresponding Master. */
+FIELD(FLEXSPI_AHBRXBUF1CR0, PREFETCHEN, 31, 1);
+
+/* AHB RX Buffer 2 Control Register 0 */
+REG32(FLEXSPI_AHBRXBUF2CR0, 40);
+/* AHB RX Buffer Size in 64 bits. */
+FIELD(FLEXSPI_AHBRXBUF2CR0, BUFSZ, 0, 8);
+/* This AHB RX Buffer is assigned according to AHB Master with ID (MSTR_ID). */
+FIELD(FLEXSPI_AHBRXBUF2CR0, MSTRID, 16, 4);
+/*
+ * This priority for AHB Master Read which this AHB RX Buffer is assigned. 7 is
+ * the highest priority, 0 the lowest.
+ */
+FIELD(FLEXSPI_AHBRXBUF2CR0, PRIORITY, 24, 3);
+/* AHB Read Prefetch Enable for current AHB RX Buffer corresponding Master. */
+FIELD(FLEXSPI_AHBRXBUF2CR0, PREFETCHEN, 31, 1);
+
+/* AHB RX Buffer 3 Control Register 0 */
+REG32(FLEXSPI_AHBRXBUF3CR0, 44);
+/* AHB RX Buffer Size in 64 bits. */
+FIELD(FLEXSPI_AHBRXBUF3CR0, BUFSZ, 0, 8);
+/* This AHB RX Buffer is assigned according to AHB Master with ID (MSTR_ID). */
+FIELD(FLEXSPI_AHBRXBUF3CR0, MSTRID, 16, 4);
+/*
+ * This priority for AHB Master Read which this AHB RX Buffer is assigned. 7 is
+ * the highest priority, 0 the lowest.
+ */
+FIELD(FLEXSPI_AHBRXBUF3CR0, PRIORITY, 24, 3);
+/* AHB Read Prefetch Enable for current AHB RX Buffer corresponding Master. */
+FIELD(FLEXSPI_AHBRXBUF3CR0, PREFETCHEN, 31, 1);
+
+/* AHB RX Buffer 4 Control Register 0 */
+REG32(FLEXSPI_AHBRXBUF4CR0, 48);
+/* AHB RX Buffer Size in 64 bits. */
+FIELD(FLEXSPI_AHBRXBUF4CR0, BUFSZ, 0, 8);
+/* This AHB RX Buffer is assigned according to AHB Master with ID (MSTR_ID). */
+FIELD(FLEXSPI_AHBRXBUF4CR0, MSTRID, 16, 4);
+/*
+ * This priority for AHB Master Read which this AHB RX Buffer is assigned. 7 is
+ * the highest priority, 0 the lowest.
+ */
+FIELD(FLEXSPI_AHBRXBUF4CR0, PRIORITY, 24, 3);
+/* AHB Read Prefetch Enable for current AHB RX Buffer corresponding Master. */
+FIELD(FLEXSPI_AHBRXBUF4CR0, PREFETCHEN, 31, 1);
+
+/* AHB RX Buffer 5 Control Register 0 */
+REG32(FLEXSPI_AHBRXBUF5CR0, 52);
+/* AHB RX Buffer Size in 64 bits. */
+FIELD(FLEXSPI_AHBRXBUF5CR0, BUFSZ, 0, 8);
+/* This AHB RX Buffer is assigned according to AHB Master with ID (MSTR_ID). */
+FIELD(FLEXSPI_AHBRXBUF5CR0, MSTRID, 16, 4);
+/*
+ * This priority for AHB Master Read which this AHB RX Buffer is assigned. 7 is
+ * the highest priority, 0 the lowest.
+ */
+FIELD(FLEXSPI_AHBRXBUF5CR0, PRIORITY, 24, 3);
+/* AHB Read Prefetch Enable for current AHB RX Buffer corresponding Master. */
+FIELD(FLEXSPI_AHBRXBUF5CR0, PREFETCHEN, 31, 1);
+
+/* AHB RX Buffer 6 Control Register 0 */
+REG32(FLEXSPI_AHBRXBUF6CR0, 56);
+/* AHB RX Buffer Size in 64 bits. */
+FIELD(FLEXSPI_AHBRXBUF6CR0, BUFSZ, 0, 8);
+/* This AHB RX Buffer is assigned according to AHB Master with ID (MSTR_ID). */
+FIELD(FLEXSPI_AHBRXBUF6CR0, MSTRID, 16, 4);
+/*
+ * This priority for AHB Master Read which this AHB RX Buffer is assigned. 7 is
+ * the highest priority, 0 the lowest.
+ */
+FIELD(FLEXSPI_AHBRXBUF6CR0, PRIORITY, 24, 3);
+/* AHB Read Prefetch Enable for current AHB RX Buffer corresponding Master. */
+FIELD(FLEXSPI_AHBRXBUF6CR0, PREFETCHEN, 31, 1);
+
+/* AHB RX Buffer 7 Control Register 0 */
+REG32(FLEXSPI_AHBRXBUF7CR0, 60);
+/* AHB RX Buffer Size in 64 bits. */
+FIELD(FLEXSPI_AHBRXBUF7CR0, BUFSZ, 0, 8);
+/* This AHB RX Buffer is assigned according to AHB Master with ID (MSTR_ID). */
+FIELD(FLEXSPI_AHBRXBUF7CR0, MSTRID, 16, 4);
+/*
+ * This priority for AHB Master Read which this AHB RX Buffer is assigned. 7 is
+ * the highest priority, 0 the lowest.
+ */
+FIELD(FLEXSPI_AHBRXBUF7CR0, PRIORITY, 24, 3);
+/* AHB Read Prefetch Enable for current AHB RX Buffer corresponding Master. */
+FIELD(FLEXSPI_AHBRXBUF7CR0, PREFETCHEN, 31, 1);
+
+/* Flash Control Register 0 */
+REG32(FLEXSPI_FLSHA1CR0, 96);
+/* Flash Size in KByte. */
+FIELD(FLEXSPI_FLSHA1CR0, FLSHSZ, 0, 23);
+
+/* Flash Control Register 0 */
+REG32(FLEXSPI_FLSHA2CR0, 100);
+/* Flash Size in KByte. */
+FIELD(FLEXSPI_FLSHA2CR0, FLSHSZ, 0, 23);
+
+/* Flash Control Register 0 */
+REG32(FLEXSPI_FLSHB1CR0, 104);
+/* Flash Size in KByte. */
+FIELD(FLEXSPI_FLSHB1CR0, FLSHSZ, 0, 23);
+
+/* Flash Control Register 0 */
+REG32(FLEXSPI_FLSHB2CR0, 108);
+/* Flash Size in KByte. */
+FIELD(FLEXSPI_FLSHB2CR0, FLSHSZ, 0, 23);
+
+/* Flash Control Register 1 */
+REG32(FLEXSPI_FLSHCR1A1, 112);
+/* Serial Flash CS setup time. */
+FIELD(FLEXSPI_FLSHCR1A1, TCSS, 0, 5);
+/* Serial Flash CS Hold time. */
+FIELD(FLEXSPI_FLSHCR1A1, TCSH, 5, 5);
+/* Word Addressable. */
+FIELD(FLEXSPI_FLSHCR1A1, WA, 10, 1);
+/* Column Address Size. */
+FIELD(FLEXSPI_FLSHCR1A1, CAS, 11, 4);
+/* CS interval unit */
+FIELD(FLEXSPI_FLSHCR1A1, CSINTERVALUNIT, 15, 1);
+/*
+ * This field is used to set the minimum interval between flash device chip
+ * select deassertion and flash device chip select assertion. If external flash
+ * has a limitation on the interval between command sequences, this field
+ * should be set accordingly. If there is no limitation, set this field with
+ * value 0x0.
+ */
+FIELD(FLEXSPI_FLSHCR1A1, CSINTERVAL, 16, 16);
+
+/* Flash Control Register 1 */
+REG32(FLEXSPI_FLSHCR1A2, 116);
+/* Serial Flash CS setup time. */
+FIELD(FLEXSPI_FLSHCR1A2, TCSS, 0, 5);
+/* Serial Flash CS Hold time. */
+FIELD(FLEXSPI_FLSHCR1A2, TCSH, 5, 5);
+/* Word Addressable. */
+FIELD(FLEXSPI_FLSHCR1A2, WA, 10, 1);
+/* Column Address Size. */
+FIELD(FLEXSPI_FLSHCR1A2, CAS, 11, 4);
+/* CS interval unit */
+FIELD(FLEXSPI_FLSHCR1A2, CSINTERVALUNIT, 15, 1);
+/*
+ * This field is used to set the minimum interval between flash device chip
+ * select deassertion and flash device chip select assertion. If external flash
+ * has a limitation on the interval between command sequences, this field
+ * should be set accordingly. If there is no limitation, set this field with
+ * value 0x0.
+ */
+FIELD(FLEXSPI_FLSHCR1A2, CSINTERVAL, 16, 16);
+
+/* Flash Control Register 1 */
+REG32(FLEXSPI_FLSHCR1B1, 120);
+/* Serial Flash CS setup time. */
+FIELD(FLEXSPI_FLSHCR1B1, TCSS, 0, 5);
+/* Serial Flash CS Hold time. */
+FIELD(FLEXSPI_FLSHCR1B1, TCSH, 5, 5);
+/* Word Addressable. */
+FIELD(FLEXSPI_FLSHCR1B1, WA, 10, 1);
+/* Column Address Size. */
+FIELD(FLEXSPI_FLSHCR1B1, CAS, 11, 4);
+/* CS interval unit */
+FIELD(FLEXSPI_FLSHCR1B1, CSINTERVALUNIT, 15, 1);
+/*
+ * This field is used to set the minimum interval between flash device chip
+ * select deassertion and flash device chip select assertion. If external flash
+ * has a limitation on the interval between command sequences, this field
+ * should be set accordingly. If there is no limitation, set this field with
+ * value 0x0.
+ */
+FIELD(FLEXSPI_FLSHCR1B1, CSINTERVAL, 16, 16);
+
+/* Flash Control Register 1 */
+REG32(FLEXSPI_FLSHCR1B2, 124);
+/* Serial Flash CS setup time. */
+FIELD(FLEXSPI_FLSHCR1B2, TCSS, 0, 5);
+/* Serial Flash CS Hold time. */
+FIELD(FLEXSPI_FLSHCR1B2, TCSH, 5, 5);
+/* Word Addressable. */
+FIELD(FLEXSPI_FLSHCR1B2, WA, 10, 1);
+/* Column Address Size. */
+FIELD(FLEXSPI_FLSHCR1B2, CAS, 11, 4);
+/* CS interval unit */
+FIELD(FLEXSPI_FLSHCR1B2, CSINTERVALUNIT, 15, 1);
+/*
+ * This field is used to set the minimum interval between flash device chip
+ * select deassertion and flash device chip select assertion. If external flash
+ * has a limitation on the interval between command sequences, this field
+ * should be set accordingly. If there is no limitation, set this field with
+ * value 0x0.
+ */
+FIELD(FLEXSPI_FLSHCR1B2, CSINTERVAL, 16, 16);
+
+/* Flash Control Register 2 */
+REG32(FLEXSPI_FLSHCR2A1, 128);
+/* Sequence Index for AHB Read triggered Command in LUT. */
+FIELD(FLEXSPI_FLSHCR2A1, ARDSEQID, 0, 4);
+/* Sequence Number for AHB Read triggered Command in LUT. */
+FIELD(FLEXSPI_FLSHCR2A1, ARDSEQNUM, 5, 3);
+/* Sequence Index for AHB Write triggered Command. */
+FIELD(FLEXSPI_FLSHCR2A1, AWRSEQID, 8, 4);
+/* Sequence Number for AHB Write triggered Command. */
+FIELD(FLEXSPI_FLSHCR2A1, AWRSEQNUM, 13, 3);
+/*
+ * For certain devices (such as FPGA), it need some time to write data into
+ * internal memory after the command sequences finished on FlexSPI interface.
+ * If another Read command sequence comes before previous programming finished
+ * internally, the read data may be wrong. This field is used to hold AHB Bus
+ * ready for AHB write access to wait the programming finished in external
+ * device. Then there will be no AHB read command triggered before the
+ * programming finished in external device. The Wait cycle between AHB
+ * triggered command sequences finished on FlexSPI interface and AHB return Bus
+ * ready: AWRWAIT * AWRWAITUNIT
+ */
+FIELD(FLEXSPI_FLSHCR2A1, AWRWAIT, 16, 12);
+/* AWRWAIT unit */
+FIELD(FLEXSPI_FLSHCR2A1, AWRWAITUNIT, 28, 3);
+/*
+ * Clear the instruction pointer which is internally saved pointer by
+ * JMP_ON_CS.
+ */
+FIELD(FLEXSPI_FLSHCR2A1, CLRINSTRPTR, 31, 1);
+
+/* Flash Control Register 2 */
+REG32(FLEXSPI_FLSHCR2A2, 132);
+/* Sequence Index for AHB Read triggered Command in LUT. */
+FIELD(FLEXSPI_FLSHCR2A2, ARDSEQID, 0, 4);
+/* Sequence Number for AHB Read triggered Command in LUT. */
+FIELD(FLEXSPI_FLSHCR2A2, ARDSEQNUM, 5, 3);
+/* Sequence Index for AHB Write triggered Command. */
+FIELD(FLEXSPI_FLSHCR2A2, AWRSEQID, 8, 4);
+/* Sequence Number for AHB Write triggered Command. */
+FIELD(FLEXSPI_FLSHCR2A2, AWRSEQNUM, 13, 3);
+/*
+ * For certain devices (such as FPGA), it need some time to write data into
+ * internal memory after the command sequences finished on FlexSPI interface.
+ * If another Read command sequence comes before previous programming finished
+ * internally, the read data may be wrong. This field is used to hold AHB Bus
+ * ready for AHB write access to wait the programming finished in external
+ * device. Then there will be no AHB read command triggered before the
+ * programming finished in external device. The Wait cycle between AHB
+ * triggered command sequences finished on FlexSPI interface and AHB return Bus
+ * ready: AWRWAIT * AWRWAITUNIT
+ */
+FIELD(FLEXSPI_FLSHCR2A2, AWRWAIT, 16, 12);
+/* AWRWAIT unit */
+FIELD(FLEXSPI_FLSHCR2A2, AWRWAITUNIT, 28, 3);
+/*
+ * Clear the instruction pointer which is internally saved pointer by
+ * JMP_ON_CS.
+ */
+FIELD(FLEXSPI_FLSHCR2A2, CLRINSTRPTR, 31, 1);
+
+/* Flash Control Register 2 */
+REG32(FLEXSPI_FLSHCR2B1, 136);
+/* Sequence Index for AHB Read triggered Command in LUT. */
+FIELD(FLEXSPI_FLSHCR2B1, ARDSEQID, 0, 4);
+/* Sequence Number for AHB Read triggered Command in LUT. */
+FIELD(FLEXSPI_FLSHCR2B1, ARDSEQNUM, 5, 3);
+/* Sequence Index for AHB Write triggered Command. */
+FIELD(FLEXSPI_FLSHCR2B1, AWRSEQID, 8, 4);
+/* Sequence Number for AHB Write triggered Command. */
+FIELD(FLEXSPI_FLSHCR2B1, AWRSEQNUM, 13, 3);
+/*
+ * For certain devices (such as FPGA), it need some time to write data into
+ * internal memory after the command sequences finished on FlexSPI interface.
+ * If another Read command sequence comes before previous programming finished
+ * internally, the read data may be wrong. This field is used to hold AHB Bus
+ * ready for AHB write access to wait the programming finished in external
+ * device. Then there will be no AHB read command triggered before the
+ * programming finished in external device. The Wait cycle between AHB
+ * triggered command sequences finished on FlexSPI interface and AHB return Bus
+ * ready: AWRWAIT * AWRWAITUNIT
+ */
+FIELD(FLEXSPI_FLSHCR2B1, AWRWAIT, 16, 12);
+/* AWRWAIT unit */
+FIELD(FLEXSPI_FLSHCR2B1, AWRWAITUNIT, 28, 3);
+/*
+ * Clear the instruction pointer which is internally saved pointer by
+ * JMP_ON_CS.
+ */
+FIELD(FLEXSPI_FLSHCR2B1, CLRINSTRPTR, 31, 1);
+
+/* Flash Control Register 2 */
+REG32(FLEXSPI_FLSHCR2B2, 140);
+/* Sequence Index for AHB Read triggered Command in LUT. */
+FIELD(FLEXSPI_FLSHCR2B2, ARDSEQID, 0, 4);
+/* Sequence Number for AHB Read triggered Command in LUT. */
+FIELD(FLEXSPI_FLSHCR2B2, ARDSEQNUM, 5, 3);
+/* Sequence Index for AHB Write triggered Command. */
+FIELD(FLEXSPI_FLSHCR2B2, AWRSEQID, 8, 4);
+/* Sequence Number for AHB Write triggered Command. */
+FIELD(FLEXSPI_FLSHCR2B2, AWRSEQNUM, 13, 3);
+/*
+ * For certain devices (such as FPGA), it need some time to write data into
+ * internal memory after the command sequences finished on FlexSPI interface.
+ * If another Read command sequence comes before previous programming finished
+ * internally, the read data may be wrong. This field is used to hold AHB Bus
+ * ready for AHB write access to wait the programming finished in external
+ * device. Then there will be no AHB read command triggered before the
+ * programming finished in external device. The Wait cycle between AHB
+ * triggered command sequences finished on FlexSPI interface and AHB return Bus
+ * ready: AWRWAIT * AWRWAITUNIT
+ */
+FIELD(FLEXSPI_FLSHCR2B2, AWRWAIT, 16, 12);
+/* AWRWAIT unit */
+FIELD(FLEXSPI_FLSHCR2B2, AWRWAITUNIT, 28, 3);
+/*
+ * Clear the instruction pointer which is internally saved pointer by
+ * JMP_ON_CS.
+ */
+FIELD(FLEXSPI_FLSHCR2B2, CLRINSTRPTR, 31, 1);
+
+/* Flash Control Register 4 */
+REG32(FLEXSPI_FLSHCR4, 148);
+/*
+ * Write mask option bit 1. This option bit could be used to remove AHB and IP
+ * write burst start address alignment limitation.
+ */
+FIELD(FLEXSPI_FLSHCR4, WMOPT1, 0, 1);
+/*
+ * Write mask enable bit for flash device on port A. When write mask function
+ * is needed for memory device on port A, this bit must be set.
+ */
+FIELD(FLEXSPI_FLSHCR4, WMENA, 2, 1);
+
+/* IP Control Register 0 */
+REG32(FLEXSPI_IPCR0, 160);
+/* Serial Flash Address for IP command. */
+FIELD(FLEXSPI_IPCR0, SFAR, 0, 32);
+
+/* IP Control Register 1 */
+REG32(FLEXSPI_IPCR1, 164);
+/* Flash Read/Program Data Size (in Bytes) for IP command. */
+FIELD(FLEXSPI_IPCR1, IDATSZ, 0, 16);
+/* Sequence Index in LUT for IP command. */
+FIELD(FLEXSPI_IPCR1, ISEQID, 16, 4);
+/* Sequence Number for IP command: ISEQNUM+1. */
+FIELD(FLEXSPI_IPCR1, ISEQNUM, 24, 3);
+/* Parallel mode Enabled for IP command. */
+FIELD(FLEXSPI_IPCR1, IPAREN, 31, 1);
+
+/* IP Command Register */
+REG32(FLEXSPI_IPCMD, 176);
+/* Setting this bit will trigger an IP Command. */
+FIELD(FLEXSPI_IPCMD, TRG, 0, 1);
+
+/* Data Learn Pattern Register */
+REG32(FLEXSPI_DLPR, 180);
+/* Data Learning Pattern. */
+FIELD(FLEXSPI_DLPR, DLP, 0, 32);
+
+/* IP RX FIFO Control Register */
+REG32(FLEXSPI_IPRXFCR, 184);
+/* Clear all valid data entries in IP RX FIFO. */
+FIELD(FLEXSPI_IPRXFCR, CLRIPRXF, 0, 1);
+/* IP RX FIFO reading by DMA enabled. */
+FIELD(FLEXSPI_IPRXFCR, RXDMAEN, 1, 1);
+/* Watermark level is (RXWMRK+1)*64 bits. */
+FIELD(FLEXSPI_IPRXFCR, RXWMRK, 2, 7);
+
+/* IP TX FIFO Control Register */
+REG32(FLEXSPI_IPTXFCR, 188);
+/* Clear all valid data entries in IP TX FIFO. */
+FIELD(FLEXSPI_IPTXFCR, CLRIPTXF, 0, 1);
+/* IP TX FIFO filling by DMA enabled. */
+FIELD(FLEXSPI_IPTXFCR, TXDMAEN, 1, 1);
+/* Watermark level is (TXWMRK+1)*64 Bits. */
+FIELD(FLEXSPI_IPTXFCR, TXWMRK, 2, 7);
+
+/* DLL Control Register 0 */
+REG32(FLEXSPI_DLLCRA, 192);
+/* DLL calibration enable. */
+FIELD(FLEXSPI_DLLCRA, DLLEN, 0, 1);
+/* DLL reset */
+FIELD(FLEXSPI_DLLCRA, DLLRESET, 1, 1);
+/*
+ * The delay target for slave delay line is: ((SLVDLYTARGET+1) * 1/32 * clock
+ * cycle of reference clock (serial root clock). If serial root clock is >= 100
+ * MHz, DLLEN set to 0x1, OVRDEN set to =0x0, then SLVDLYTARGET setting of 0 is
+ * recommended.
+ */
+FIELD(FLEXSPI_DLLCRA, SLVDLYTARGET, 3, 4);
+/* Slave clock delay line delay cell number selection override enable. */
+FIELD(FLEXSPI_DLLCRA, OVRDEN, 8, 1);
+/* Slave clock delay line delay cell number selection override value. */
+FIELD(FLEXSPI_DLLCRA, OVRDVAL, 9, 6);
+
+/* DLL Control Register 0 */
+REG32(FLEXSPI_DLLCRB, 196);
+/* DLL calibration enable. */
+FIELD(FLEXSPI_DLLCRB, DLLEN, 0, 1);
+/* DLL reset */
+FIELD(FLEXSPI_DLLCRB, DLLRESET, 1, 1);
+/*
+ * The delay target for slave delay line is: ((SLVDLYTARGET+1) * 1/32 * clock
+ * cycle of reference clock (serial root clock). If serial root clock is >= 100
+ * MHz, DLLEN set to 0x1, OVRDEN set to =0x0, then SLVDLYTARGET setting of 0 is
+ * recommended.
+ */
+FIELD(FLEXSPI_DLLCRB, SLVDLYTARGET, 3, 4);
+/* Slave clock delay line delay cell number selection override enable. */
+FIELD(FLEXSPI_DLLCRB, OVRDEN, 8, 1);
+/* Slave clock delay line delay cell number selection override value. */
+FIELD(FLEXSPI_DLLCRB, OVRDVAL, 9, 6);
+
+/* Status Register 0 */
+REG32(FLEXSPI_STS0, 224);
+/*
+ * This status bit indicates the state machine in SEQ_CTL is idle and there is
+ * command sequence executing on FlexSPI interface.
+ */
+FIELD(FLEXSPI_STS0, SEQIDLE, 0, 1);
+/*
+ * This status bit indicates the state machine in ARB_CTL is busy and there is
+ * command sequence granted by arbitrator and not finished yet on FlexSPI
+ * interface. When ARB_CTL state (ARBIDLE=0x1) is idle, there will be no
+ * transaction on FlexSPI interface also (SEQIDLE=0x1). So this bit should be
+ * polled to wait for FlexSPI controller become idle instead of SEQIDLE.
+ */
+FIELD(FLEXSPI_STS0, ARBIDLE, 1, 1);
+/*
+ * This status field indicates the trigger source of current command sequence
+ * granted by arbitrator. This field value is meaningless when ARB_CTL is not
+ * busy (STS0[ARBIDLE]=0x1).
+ */
+FIELD(FLEXSPI_STS0, ARBCMDSRC, 2, 2);
+/* Indicate the sampling clock phase selection on Port A after Data Learning. */
+FIELD(FLEXSPI_STS0, DATALEARNPHASEA, 4, 4);
+
+/* Status Register 1 */
+REG32(FLEXSPI_STS1, 228);
+/*
+ * Indicates the sequence index when an AHB command error is detected. This
+ * field will be cleared when INTR[AHBCMDERR] is write-1-clear(w1c).
+ */
+FIELD(FLEXSPI_STS1, AHBCMDERRID, 0, 4);
+/*
+ * Indicates the Error Code when AHB command Error detected. This field will be
+ * cleared when INTR[AHBCMDERR] is write-1-clear(w1c).
+ */
+FIELD(FLEXSPI_STS1, AHBCMDERRCODE, 8, 4);
+/* Indicates the sequence Index when IP command error detected. */
+FIELD(FLEXSPI_STS1, IPCMDERRID, 16, 4);
+/*
+ * Indicates the Error Code when IP command Error detected. This field will be
+ * cleared when INTR[IPCMDERR] is write-1-clear(w1c).
+ */
+FIELD(FLEXSPI_STS1, IPCMDERRCODE, 24, 4);
+
+/* Status Register 2 */
+REG32(FLEXSPI_STS2, 232);
+/* Flash A sample clock slave delay line locked. */
+FIELD(FLEXSPI_STS2, ASLVLOCK, 0, 1);
+/* Flash A sample clock reference delay line locked. */
+FIELD(FLEXSPI_STS2, AREFLOCK, 1, 1);
+/* Flash A sample clock slave delay line delay cell number selection . */
+FIELD(FLEXSPI_STS2, ASLVSEL, 2, 6);
+/* Flash A sample clock reference delay line delay cell number selection. */
+FIELD(FLEXSPI_STS2, AREFSEL, 8, 6);
+/* Flash B sample clock slave delay line locked. */
+FIELD(FLEXSPI_STS2, BSLVLOCK, 16, 1);
+/* Flash B sample clock reference delay line locked. */
+FIELD(FLEXSPI_STS2, BREFLOCK, 17, 1);
+/* Flash B sample clock slave delay line delay cell number selection. */
+FIELD(FLEXSPI_STS2, BSLVSEL, 18, 6);
+/* Flash B sample clock reference delay line delay cell number selection. */
+FIELD(FLEXSPI_STS2, BREFSEL, 24, 6);
+
+/* AHB Suspend Status Register */
+REG32(FLEXSPI_AHBSPNDSTS, 236);
+/* Indicates if an AHB read prefetch command sequence has been suspended. */
+FIELD(FLEXSPI_AHBSPNDSTS, ACTIVE, 0, 1);
+/* AHB RX BUF ID for suspended command sequence. */
+FIELD(FLEXSPI_AHBSPNDSTS, BUFID, 1, 3);
+/* The Data size left for suspended command sequence (in byte). */
+FIELD(FLEXSPI_AHBSPNDSTS, DATLFT, 16, 16);
+
+/* IP RX FIFO Status Register */
+REG32(FLEXSPI_IPRXFSTS, 240);
+/* Fill level of IP RX FIFO. */
+FIELD(FLEXSPI_IPRXFSTS, FILL, 0, 8);
+/* Total Read Data Counter: RDCNTR * 64 Bits. */
+FIELD(FLEXSPI_IPRXFSTS, RDCNTR, 16, 16);
+
+/* IP TX FIFO Status Register */
+REG32(FLEXSPI_IPTXFSTS, 244);
+/* Fill level of IP TX FIFO. */
+FIELD(FLEXSPI_IPTXFSTS, FILL, 0, 8);
+/* Total Write Data Counter: WRCNTR * 64 Bits. */
+FIELD(FLEXSPI_IPTXFSTS, WRCNTR, 16, 16);
+
+/* IP RX FIFO Data Register x */
+REG32(FLEXSPI_RFDR0, 256);
+REG32(FLEXSPI_RFDR1, 260);
+REG32(FLEXSPI_RFDR2, 264);
+REG32(FLEXSPI_RFDR3, 268);
+REG32(FLEXSPI_RFDR4, 272);
+REG32(FLEXSPI_RFDR5, 276);
+REG32(FLEXSPI_RFDR6, 280);
+REG32(FLEXSPI_RFDR7, 284);
+REG32(FLEXSPI_RFDR8, 288);
+REG32(FLEXSPI_RFDR9, 292);
+REG32(FLEXSPI_RFDR10, 296);
+REG32(FLEXSPI_RFDR11, 300);
+REG32(FLEXSPI_RFDR12, 304);
+REG32(FLEXSPI_RFDR13, 308);
+REG32(FLEXSPI_RFDR14, 312);
+REG32(FLEXSPI_RFDR15, 316);
+REG32(FLEXSPI_RFDR16, 320);
+REG32(FLEXSPI_RFDR17, 324);
+REG32(FLEXSPI_RFDR18, 328);
+REG32(FLEXSPI_RFDR19, 332);
+REG32(FLEXSPI_RFDR20, 336);
+REG32(FLEXSPI_RFDR21, 340);
+REG32(FLEXSPI_RFDR22, 344);
+REG32(FLEXSPI_RFDR23, 348);
+REG32(FLEXSPI_RFDR24, 352);
+REG32(FLEXSPI_RFDR25, 356);
+REG32(FLEXSPI_RFDR26, 360);
+REG32(FLEXSPI_RFDR27, 364);
+REG32(FLEXSPI_RFDR28, 368);
+REG32(FLEXSPI_RFDR29, 372);
+REG32(FLEXSPI_RFDR30, 376);
+REG32(FLEXSPI_RFDR31, 380);
+/* RX Data. */
+SHARED_FIELD(FLEXSPI_RFDR_RXDATA, 0, 32);
+
+/* IP TX FIFO Data Register x */
+REG32(FLEXSPI_TFDR0, 384);
+REG32(FLEXSPI_TFDR1, 388);
+REG32(FLEXSPI_TFDR2, 392);
+REG32(FLEXSPI_TFDR3, 396);
+REG32(FLEXSPI_TFDR4, 400);
+REG32(FLEXSPI_TFDR5, 404);
+REG32(FLEXSPI_TFDR6, 408);
+REG32(FLEXSPI_TFDR7, 412);
+REG32(FLEXSPI_TFDR8, 416);
+REG32(FLEXSPI_TFDR9, 420);
+REG32(FLEXSPI_TFDR10, 424);
+REG32(FLEXSPI_TFDR11, 428);
+REG32(FLEXSPI_TFDR12, 432);
+REG32(FLEXSPI_TFDR13, 436);
+REG32(FLEXSPI_TFDR14, 440);
+REG32(FLEXSPI_TFDR15, 444);
+REG32(FLEXSPI_TFDR16, 448);
+REG32(FLEXSPI_TFDR17, 452);
+REG32(FLEXSPI_TFDR18, 456);
+REG32(FLEXSPI_TFDR19, 460);
+REG32(FLEXSPI_TFDR20, 464);
+REG32(FLEXSPI_TFDR21, 468);
+REG32(FLEXSPI_TFDR22, 472);
+REG32(FLEXSPI_TFDR23, 476);
+REG32(FLEXSPI_TFDR24, 480);
+REG32(FLEXSPI_TFDR25, 484);
+REG32(FLEXSPI_TFDR26, 488);
+REG32(FLEXSPI_TFDR27, 492);
+REG32(FLEXSPI_TFDR28, 496);
+REG32(FLEXSPI_TFDR29, 500);
+REG32(FLEXSPI_TFDR30, 504);
+REG32(FLEXSPI_TFDR31, 508);
+/* TX Data */
+SHARED_FIELD(FLEXSPI_TFDR_TXDATA, 0, 32);
+
+/* LUT x */
+REG32(FLEXSPI_LUT0, 512);
+REG32(FLEXSPI_LUT1, 516);
+REG32(FLEXSPI_LUT2, 520);
+REG32(FLEXSPI_LUT3, 524);
+REG32(FLEXSPI_LUT4, 528);
+REG32(FLEXSPI_LUT5, 532);
+REG32(FLEXSPI_LUT6, 536);
+REG32(FLEXSPI_LUT7, 540);
+REG32(FLEXSPI_LUT8, 544);
+REG32(FLEXSPI_LUT9, 548);
+REG32(FLEXSPI_LUT10, 552);
+REG32(FLEXSPI_LUT11, 556);
+REG32(FLEXSPI_LUT12, 560);
+REG32(FLEXSPI_LUT13, 564);
+REG32(FLEXSPI_LUT14, 568);
+REG32(FLEXSPI_LUT15, 572);
+REG32(FLEXSPI_LUT16, 576);
+REG32(FLEXSPI_LUT17, 580);
+REG32(FLEXSPI_LUT18, 584);
+REG32(FLEXSPI_LUT19, 588);
+REG32(FLEXSPI_LUT20, 592);
+REG32(FLEXSPI_LUT21, 596);
+REG32(FLEXSPI_LUT22, 600);
+REG32(FLEXSPI_LUT23, 604);
+REG32(FLEXSPI_LUT24, 608);
+REG32(FLEXSPI_LUT25, 612);
+REG32(FLEXSPI_LUT26, 616);
+REG32(FLEXSPI_LUT27, 620);
+REG32(FLEXSPI_LUT28, 624);
+REG32(FLEXSPI_LUT29, 628);
+REG32(FLEXSPI_LUT30, 632);
+REG32(FLEXSPI_LUT31, 636);
+REG32(FLEXSPI_LUT32, 640);
+REG32(FLEXSPI_LUT33, 644);
+REG32(FLEXSPI_LUT34, 648);
+REG32(FLEXSPI_LUT35, 652);
+REG32(FLEXSPI_LUT36, 656);
+REG32(FLEXSPI_LUT37, 660);
+REG32(FLEXSPI_LUT38, 664);
+REG32(FLEXSPI_LUT39, 668);
+REG32(FLEXSPI_LUT40, 672);
+REG32(FLEXSPI_LUT41, 676);
+REG32(FLEXSPI_LUT42, 680);
+REG32(FLEXSPI_LUT43, 684);
+REG32(FLEXSPI_LUT44, 688);
+REG32(FLEXSPI_LUT45, 692);
+REG32(FLEXSPI_LUT46, 696);
+REG32(FLEXSPI_LUT47, 700);
+REG32(FLEXSPI_LUT48, 704);
+REG32(FLEXSPI_LUT49, 708);
+REG32(FLEXSPI_LUT50, 712);
+REG32(FLEXSPI_LUT51, 716);
+REG32(FLEXSPI_LUT52, 720);
+REG32(FLEXSPI_LUT53, 724);
+REG32(FLEXSPI_LUT54, 728);
+REG32(FLEXSPI_LUT55, 732);
+REG32(FLEXSPI_LUT56, 736);
+REG32(FLEXSPI_LUT57, 740);
+REG32(FLEXSPI_LUT58, 744);
+REG32(FLEXSPI_LUT59, 748);
+REG32(FLEXSPI_LUT60, 752);
+REG32(FLEXSPI_LUT61, 756);
+REG32(FLEXSPI_LUT62, 760);
+REG32(FLEXSPI_LUT63, 764);
+/* OPERAND0 */
+SHARED_FIELD(FLEXSPI_LUT_OPERAND0, 0, 8);
+/* NUM_PADS0 */
+SHARED_FIELD(FLEXSPI_LUT_NUM_PADS0, 8, 2);
+/* OPCODE */
+SHARED_FIELD(FLEXSPI_LUT_OPCODE0, 10, 6);
+/* OPERAND1 */
+SHARED_FIELD(FLEXSPI_LUT_OPERAND1, 16, 8);
+/* NUM_PADS1 */
+SHARED_FIELD(FLEXSPI_LUT_NUM_PADS1, 24, 2);
+/* OPCODE1 */
+SHARED_FIELD(FLEXSPI_LUT_OPCODE1, 26, 6);
+
+/* HADDR REMAP START ADDR */
+REG32(FLEXSPI_HADDRSTART, 1056);
+/* AHB Bus address remap function enable */
+FIELD(FLEXSPI_HADDRSTART, REMAPEN, 0, 1);
+/* HADDR start address */
+FIELD(FLEXSPI_HADDRSTART, ADDRSTART, 12, 20);
+
+/* HADDR REMAP END ADDR */
+REG32(FLEXSPI_HADDREND, 1060);
+/* HADDR remap range's end address, 4K aligned */
+FIELD(FLEXSPI_HADDREND, ENDSTART, 12, 20);
+
+/* HADDR REMAP OFFSET */
+REG32(FLEXSPI_HADDROFFSET, 1064);
+/*
+ * HADDR offset field, remapped address will be
+ * ADDR[31:12]=ADDR_original[31:12]+ADDROFFSET
+ */
+FIELD(FLEXSPI_HADDROFFSET, ADDROFFSET, 12, 20);
+
+
+typedef enum {
+    /* No impact */
+    FLEXSPI_MCR0_SWRESET_val0 = 0,
+    /* Software reset */
+    FLEXSPI_MCR0_SWRESET_val1 = 1,
+} FLEXSPI_MCR0_SWRESET_Enum;
+
+typedef enum {
+    /* No impact */
+    FLEXSPI_MCR0_MDIS_val0 = 0,
+    /* Module disable */
+    FLEXSPI_MCR0_MDIS_val1 = 1,
+} FLEXSPI_MCR0_MDIS_Enum;
+
+typedef enum {
+    /*
+     * Dummy Read strobe generated by FlexSPI Controller and loopback
+     * internally.
+     */
+    FLEXSPI_MCR0_RXCLKSRC_val0 = 0,
+    /*
+     * Dummy Read strobe generated by FlexSPI Controller and loopback from DQS
+     * pad.
+     */
+    FLEXSPI_MCR0_RXCLKSRC_val1 = 1,
+    /* Flash provided Read strobe and input from DQS pad */
+    FLEXSPI_MCR0_RXCLKSRC_val3 = 3,
+} FLEXSPI_MCR0_RXCLKSRC_Enum;
+
+typedef enum {
+    /* Divided by 1 */
+    FLEXSPI_MCR0_SERCLKDIV_val0 = 0,
+    /* Divided by 2 */
+    FLEXSPI_MCR0_SERCLKDIV_val1 = 1,
+    /* Divided by 3 */
+    FLEXSPI_MCR0_SERCLKDIV_val2 = 2,
+    /* Divided by 4 */
+    FLEXSPI_MCR0_SERCLKDIV_val3 = 3,
+    /* Divided by 5 */
+    FLEXSPI_MCR0_SERCLKDIV_val4 = 4,
+    /* Divided by 6 */
+    FLEXSPI_MCR0_SERCLKDIV_val5 = 5,
+    /* Divided by 7 */
+    FLEXSPI_MCR0_SERCLKDIV_val6 = 6,
+    /* Divided by 8 */
+    FLEXSPI_MCR0_SERCLKDIV_val7 = 7,
+} FLEXSPI_MCR0_SERCLKDIV_Enum;
+
+typedef enum {
+    /* Disable divide by 2 of serial flash clock for half clock frequency. */
+    FLEXSPI_MCR0_HSEN_val0 = 0,
+    /* Enable divide by 2 of serial flash clock for half clock frequency. */
+    FLEXSPI_MCR0_HSEN_val1 = 1,
+} FLEXSPI_MCR0_HSEN_Enum;
+
+typedef enum {
+    /*
+     * Doze mode support disabled. AHB clock and serial clock will not be gated
+     * off when there is doze mode request from system.
+     */
+    FLEXSPI_MCR0_DOZEEN_val0 = 0,
+    /*
+     * Doze mode support enabled. AHB clock and serial clock will be gated off
+     * when there is doze mode request from system.
+     */
+    FLEXSPI_MCR0_DOZEEN_val1 = 1,
+} FLEXSPI_MCR0_DOZEEN_Enum;
+
+typedef enum {
+    /* Disable SCLK output free-running. */
+    FLEXSPI_MCR0_SCKFREERUNEN_DISABLE = 0,
+    /* Enable SCLK output free-running. */
+    FLEXSPI_MCR0_SCKFREERUNEN_ENABLE = 1,
+} FLEXSPI_MCR0_SCKFREERUNEN_Enum;
+
+typedef enum {
+    /* Disable the data learning feature. */
+    FLEXSPI_MCR0_LEARNEN_DISABLE = 0,
+    /* Enable the data learning feature. */
+    FLEXSPI_MCR0_LEARNEN_ENABLE = 1,
+} FLEXSPI_MCR0_LEARNEN_Enum;
+
+typedef enum {
+    /*
+     * AHB RX/TX Buffer will not be cleared automatically when FlexSPI returns
+     * Stop mode ACK.
+     */
+    FLEXSPI_MCR2_CLRAHBBUFOPT_val0 = 0,
+    /*
+     * AHB RX/TX Buffer will be cleared automatically when FlexSPI returns Stop
+     * mode ACK.
+     */
+    FLEXSPI_MCR2_CLRAHBBUFOPT_val1 = 1,
+} FLEXSPI_MCR2_CLRAHBBUFOPT_Enum;
+
+typedef enum {
+    /* No impact */
+    FLEXSPI_MCR2_CLRLEARNPHASE_val0 = 0,
+    /*
+     * The sampling clock phase selection will be reset to phase 0 when this
+     * bit is written with 0x1. This bit will be auto-cleared immediately.
+     */
+    FLEXSPI_MCR2_CLRLEARNPHASE_val1 = 1,
+} FLEXSPI_MCR2_CLRLEARNPHASE_Enum;
+
+typedef enum {
+    /*
+     * In Individual mode, FLSHA1CRx/FLSHA2CRx/FLSHB1CRx/FLSHB2CRx register
+     * setting will be applied to Flash A1/A2/B1/B2 separately. In Parallel
+     * mode, FLSHA1CRx register setting will be applied to Flash A1 and B1,
+     * FLSHA2CRx register setting will be applied to Flash A2 and B2.
+     * FLSHB1CRx/FLSHB2CRx register setting will be ignored.
+     */
+    FLEXSPI_MCR2_SAMEDEVICEEN_individual_parallel = 0,
+    /*
+     * FLSHA1CR0/FLSHA1CR1/FLSHA1CR2 register setting will be applied to Flash
+     * A1/A2/B1/B2. FLSHA2CRx/FLSHB1CRx/FLSHB2CRx will be ignored.
+     */
+    FLEXSPI_MCR2_SAMEDEVICEEN_ENABLE = 1,
+} FLEXSPI_MCR2_SAMEDEVICEEN_Enum;
+
+typedef enum {
+    /* Flash will be accessed in Individual mode. */
+    FLEXSPI_AHBCR_APAREN_individual = 0,
+    /* Flash will be accessed in Parallel mode. */
+    FLEXSPI_AHBCR_APAREN_ENABLE = 1,
+} FLEXSPI_AHBCR_APAREN_Enum;
+
+typedef enum {
+    /* No function. */
+    FLEXSPI_AHBCR_CLRAHBTXBUF_val0 = 0,
+    /* Clear operation enable. */
+    FLEXSPI_AHBCR_CLRAHBTXBUF_val1 = 1,
+} FLEXSPI_AHBCR_CLRAHBTXBUF_Enum;
+
+typedef enum {
+    /*
+     * Disabled. When there is AHB bus cachable read access, FlexSPI will not
+     * check whether it hit AHB TX Buffer.
+     */
+    FLEXSPI_AHBCR_CACHABLEEN_val0 = 0,
+    /*
+     * Enabled. When there is AHB bus cachable read access, FlexSPI will check
+     * whether it hit AHB TX Buffer first.
+     */
+    FLEXSPI_AHBCR_CACHABLEEN_val1 = 1,
+} FLEXSPI_AHBCR_CACHABLEEN_Enum;
+
+typedef enum {
+    /*
+     * Disabled. For all AHB write accesses (bufferable or non-bufferable),
+     * FlexSPI will return AHB Bus ready after all data is transmitted to
+     * external device and AHB command finished.
+     */
+    FLEXSPI_AHBCR_BUFFERABLEEN_val0 = 0,
+    /*
+     * Enabled. For AHB bufferable write access, FlexSPI will return AHB Bus
+     * ready when the AHB command is granted by arbitrator and will not wait
+     * for AHB command finished.
+     */
+    FLEXSPI_AHBCR_BUFFERABLEEN_val1 = 1,
+} FLEXSPI_AHBCR_BUFFERABLEEN_Enum;
+
+typedef enum {
+    /*
+     * There is AHB read burst start address alignment limitation when flash is
+     * accessed in parallel mode or flash is word-addressable.
+     */
+    FLEXSPI_AHBCR_READADDROPT_val0 = 0,
+    /*
+     * There is no AHB read burst start address alignment limitation. FlexSPI
+     * will fetch more data than AHB burst required to meet the alignment
+     * requirement.
+     */
+    FLEXSPI_AHBCR_READADDROPT_val1 = 1,
+} FLEXSPI_AHBCR_READADDROPT_Enum;
+
+typedef enum {
+    /* Suspended AHB read prefetch will start to resume when AHB is IDLE */
+    FLEXSPI_AHBCR_RESUMEDISABLE_val0 = 0,
+    /* Suspended AHB read prefetch will not resume once it is aborted */
+    FLEXSPI_AHBCR_RESUMEDISABLE_val1 = 1,
+} FLEXSPI_AHBCR_RESUMEDISABLE_Enum;
+
+typedef enum {
+    /*
+     * AHB read size will be decided by other register setting like
+     * PREFETCH_EN,OTFAD_EN...
+     */
+    FLEXSPI_AHBCR_READSZALIGN_val0 = 0,
+    /* AHB read size to up size to 8 bytes aligned, no prefetching */
+    FLEXSPI_AHBCR_READSZALIGN_val1 = 1,
+} FLEXSPI_AHBCR_READSZALIGN_Enum;
+
+typedef enum {
+    /* Disable interrupt or no impact */
+    FLEXSPI_INTEN_IPCMDDONEEN_value0 = 0,
+    /* Enable interrupt */
+    FLEXSPI_INTEN_IPCMDDONEEN_value1 = 1,
+} FLEXSPI_INTEN_IPCMDDONEEN_Enum;
+
+typedef enum {
+    /* Disable interrupt or no impact */
+    FLEXSPI_INTEN_IPCMDGEEN_value0 = 0,
+    /* Enable interrupt */
+    FLEXSPI_INTEN_IPCMDGEEN_value1 = 1,
+} FLEXSPI_INTEN_IPCMDGEEN_Enum;
+
+typedef enum {
+    /* Disable interrupt or no impact */
+    FLEXSPI_INTEN_AHBCMDGEEN_value0 = 0,
+    /* Enable interrupt */
+    FLEXSPI_INTEN_AHBCMDGEEN_value1 = 1,
+} FLEXSPI_INTEN_AHBCMDGEEN_Enum;
+
+typedef enum {
+    /* Disable interrupt or no impact */
+    FLEXSPI_INTEN_IPCMDERREN_value0 = 0,
+    /* Enable interrupt */
+    FLEXSPI_INTEN_IPCMDERREN_value1 = 1,
+} FLEXSPI_INTEN_IPCMDERREN_Enum;
+
+typedef enum {
+    /* Disable interrupt or no impact */
+    FLEXSPI_INTEN_AHBCMDERREN_value0 = 0,
+    /* Enable interrupt */
+    FLEXSPI_INTEN_AHBCMDERREN_value1 = 1,
+} FLEXSPI_INTEN_AHBCMDERREN_Enum;
+
+typedef enum {
+    /* Disable interrupt or no impact */
+    FLEXSPI_INTEN_IPRXWAEN_value0 = 0,
+    /* Enable interrupt */
+    FLEXSPI_INTEN_IPRXWAEN_value1 = 1,
+} FLEXSPI_INTEN_IPRXWAEN_Enum;
+
+typedef enum {
+    /* Disable interrupt or no impact */
+    FLEXSPI_INTEN_IPTXWEEN_value0 = 0,
+    /* Enable interrupt */
+    FLEXSPI_INTEN_IPTXWEEN_value1 = 1,
+} FLEXSPI_INTEN_IPTXWEEN_Enum;
+
+typedef enum {
+    /* Disable interrupt or no impact */
+    FLEXSPI_INTEN_DATALEARNFAILEN_value0 = 0,
+    /* Enable interrupt */
+    FLEXSPI_INTEN_DATALEARNFAILEN_value1 = 1,
+} FLEXSPI_INTEN_DATALEARNFAILEN_Enum;
+
+typedef enum {
+    /* Disable interrupt or no impact */
+    FLEXSPI_INTEN_SCKSTOPBYRDEN_value0 = 0,
+    /* Enable interrupt */
+    FLEXSPI_INTEN_SCKSTOPBYRDEN_value1 = 1,
+} FLEXSPI_INTEN_SCKSTOPBYRDEN_Enum;
+
+typedef enum {
+    /* Disable interrupt or no impact */
+    FLEXSPI_INTEN_SCKSTOPBYWREN_value0 = 0,
+    /* Enable interrupt */
+    FLEXSPI_INTEN_SCKSTOPBYWREN_value1 = 1,
+} FLEXSPI_INTEN_SCKSTOPBYWREN_Enum;
+
+typedef enum {
+    /* Disable interrupt or no impact */
+    FLEXSPI_INTEN_AHBBUSERROREN_value0 = 0,
+    /* Enable interrupt */
+    FLEXSPI_INTEN_AHBBUSERROREN_value1 = 1,
+} FLEXSPI_INTEN_AHBBUSERROREN_Enum;
+
+typedef enum {
+    /* Disable interrupt or no impact */
+    FLEXSPI_INTEN_SEQTIMEOUTEN_value0 = 0,
+    /* Enable interrupt */
+    FLEXSPI_INTEN_SEQTIMEOUTEN_value1 = 1,
+} FLEXSPI_INTEN_SEQTIMEOUTEN_Enum;
+
+typedef enum {
+    /* Disable interrupt or no impact */
+    FLEXSPI_INTEN_KEYDONEEN_value0 = 0,
+    /* Enable interrupt */
+    FLEXSPI_INTEN_KEYDONEEN_value1 = 1,
+} FLEXSPI_INTEN_KEYDONEEN_Enum;
+
+typedef enum {
+    /* Disable interrupt or no impact */
+    FLEXSPI_INTEN_KEYERROREN_value0 = 0,
+    /* Enable interrupt */
+    FLEXSPI_INTEN_KEYERROREN_value1 = 1,
+} FLEXSPI_INTEN_KEYERROREN_Enum;
+
+typedef enum {
+    /* No impact */
+    FLEXSPI_LUTCR_LOCK_value0 = 0,
+    /* Lock LUT, LUT will be locked and can't be written */
+    FLEXSPI_LUTCR_LOCK_value1 = 1,
+} FLEXSPI_LUTCR_LOCK_Enum;
+
+typedef enum {
+    /* No impact */
+    FLEXSPI_LUTCR_UNLOCK_value0 = 0,
+    /* Unlock LUT, the LUT can be written */
+    FLEXSPI_LUTCR_UNLOCK_value1 = 1,
+} FLEXSPI_LUTCR_UNLOCK_Enum;
+
+typedef enum {
+    /* No prefetch */
+    FLEXSPI_AHBRXBUF0CR0_PREFETCHEN_value0 = 0,
+    /* Prefetch enable */
+    FLEXSPI_AHBRXBUF0CR0_PREFETCHEN_value1 = 1,
+} FLEXSPI_AHBRXBUF0CR0_PREFETCHEN_Enum;
+
+typedef enum {
+    /* No prefetch */
+    FLEXSPI_AHBRXBUF1CR0_PREFETCHEN_value0 = 0,
+    /* Prefetch enable */
+    FLEXSPI_AHBRXBUF1CR0_PREFETCHEN_value1 = 1,
+} FLEXSPI_AHBRXBUF1CR0_PREFETCHEN_Enum;
+
+typedef enum {
+    /* No prefetch */
+    FLEXSPI_AHBRXBUF2CR0_PREFETCHEN_value0 = 0,
+    /* Prefetch enable */
+    FLEXSPI_AHBRXBUF2CR0_PREFETCHEN_value1 = 1,
+} FLEXSPI_AHBRXBUF2CR0_PREFETCHEN_Enum;
+
+typedef enum {
+    /* No prefetch */
+    FLEXSPI_AHBRXBUF3CR0_PREFETCHEN_value0 = 0,
+    /* Prefetch enable */
+    FLEXSPI_AHBRXBUF3CR0_PREFETCHEN_value1 = 1,
+} FLEXSPI_AHBRXBUF3CR0_PREFETCHEN_Enum;
+
+typedef enum {
+    /* No prefetch */
+    FLEXSPI_AHBRXBUF4CR0_PREFETCHEN_value0 = 0,
+    /* Prefetch enable */
+    FLEXSPI_AHBRXBUF4CR0_PREFETCHEN_value1 = 1,
+} FLEXSPI_AHBRXBUF4CR0_PREFETCHEN_Enum;
+
+typedef enum {
+    /* No prefetch */
+    FLEXSPI_AHBRXBUF5CR0_PREFETCHEN_value0 = 0,
+    /* Prefetch enable */
+    FLEXSPI_AHBRXBUF5CR0_PREFETCHEN_value1 = 1,
+} FLEXSPI_AHBRXBUF5CR0_PREFETCHEN_Enum;
+
+typedef enum {
+    /* No prefetch */
+    FLEXSPI_AHBRXBUF6CR0_PREFETCHEN_value0 = 0,
+    /* Prefetch enable */
+    FLEXSPI_AHBRXBUF6CR0_PREFETCHEN_value1 = 1,
+} FLEXSPI_AHBRXBUF6CR0_PREFETCHEN_Enum;
+
+typedef enum {
+    /* No prefetch */
+    FLEXSPI_AHBRXBUF7CR0_PREFETCHEN_value0 = 0,
+    /* Prefetch enable */
+    FLEXSPI_AHBRXBUF7CR0_PREFETCHEN_value1 = 1,
+} FLEXSPI_AHBRXBUF7CR0_PREFETCHEN_Enum;
+
+typedef enum {
+    /* This bit should be set as 0 when external Flash is byte addressable. */
+    FLEXSPI_FLSHCR1A1_WA_value0 = 0,
+    /*
+     * This bit should be set as 1 when external Flash is word addressable. If
+     * Flash is word addressable, it should be accessed in terms of 16 bits. At
+     * this time, FlexSPI will not transmit Flash address bit 0 to external
+     * Flash.
+     */
+    FLEXSPI_FLSHCR1A1_WA_value1 = 1,
+} FLEXSPI_FLSHCR1A1_WA_Enum;
+
+typedef enum {
+    /* The CS interval unit is 1 serial clock cycle */
+    FLEXSPI_FLSHCR1A1_CSINTERVALUNIT_val0 = 0,
+    /* The CS interval unit is 256 serial clock cycle */
+    FLEXSPI_FLSHCR1A1_CSINTERVALUNIT_val1 = 1,
+} FLEXSPI_FLSHCR1A1_CSINTERVALUNIT_Enum;
+
+typedef enum {
+    /* This bit should be set as 0 when external Flash is byte addressable. */
+    FLEXSPI_FLSHCR1A2_WA_value0 = 0,
+    /*
+     * This bit should be set as 1 when external Flash is word addressable. If
+     * Flash is word addressable, it should be accessed in terms of 16 bits. At
+     * this time, FlexSPI will not transmit Flash address bit 0 to external
+     * Flash.
+     */
+    FLEXSPI_FLSHCR1A2_WA_value1 = 1,
+} FLEXSPI_FLSHCR1A2_WA_Enum;
+
+typedef enum {
+    /* The CS interval unit is 1 serial clock cycle */
+    FLEXSPI_FLSHCR1A2_CSINTERVALUNIT_val0 = 0,
+    /* The CS interval unit is 256 serial clock cycle */
+    FLEXSPI_FLSHCR1A2_CSINTERVALUNIT_val1 = 1,
+} FLEXSPI_FLSHCR1A2_CSINTERVALUNIT_Enum;
+
+typedef enum {
+    /* This bit should be set as 0 when external Flash is byte addressable. */
+    FLEXSPI_FLSHCR1B1_WA_value0 = 0,
+    /*
+     * This bit should be set as 1 when external Flash is word addressable. If
+     * Flash is word addressable, it should be accessed in terms of 16 bits. At
+     * this time, FlexSPI will not transmit Flash address bit 0 to external
+     * Flash.
+     */
+    FLEXSPI_FLSHCR1B1_WA_value1 = 1,
+} FLEXSPI_FLSHCR1B1_WA_Enum;
+
+typedef enum {
+    /* The CS interval unit is 1 serial clock cycle */
+    FLEXSPI_FLSHCR1B1_CSINTERVALUNIT_val0 = 0,
+    /* The CS interval unit is 256 serial clock cycle */
+    FLEXSPI_FLSHCR1B1_CSINTERVALUNIT_val1 = 1,
+} FLEXSPI_FLSHCR1B1_CSINTERVALUNIT_Enum;
+
+typedef enum {
+    /* This bit should be set as 0 when external Flash is byte addressable. */
+    FLEXSPI_FLSHCR1B2_WA_value0 = 0,
+    /*
+     * This bit should be set as 1 when external Flash is word addressable. If
+     * Flash is word addressable, it should be accessed in terms of 16 bits. At
+     * this time, FlexSPI will not transmit Flash address bit 0 to external
+     * Flash.
+     */
+    FLEXSPI_FLSHCR1B2_WA_value1 = 1,
+} FLEXSPI_FLSHCR1B2_WA_Enum;
+
+typedef enum {
+    /* The CS interval unit is 1 serial clock cycle */
+    FLEXSPI_FLSHCR1B2_CSINTERVALUNIT_val0 = 0,
+    /* The CS interval unit is 256 serial clock cycle */
+    FLEXSPI_FLSHCR1B2_CSINTERVALUNIT_val1 = 1,
+} FLEXSPI_FLSHCR1B2_CSINTERVALUNIT_Enum;
+
+typedef enum {
+    /* The AWRWAIT unit is 2 AHB clock cycle */
+    FLEXSPI_FLSHCR2A1_AWRWAITUNIT_val0 = 0,
+    /* The AWRWAIT unit is 8 AHB clock cycle */
+    FLEXSPI_FLSHCR2A1_AWRWAITUNIT_val1 = 1,
+    /* The AWRWAIT unit is 32 AHB clock cycle */
+    FLEXSPI_FLSHCR2A1_AWRWAITUNIT_val2 = 2,
+    /* The AWRWAIT unit is 128 AHB clock cycle */
+    FLEXSPI_FLSHCR2A1_AWRWAITUNIT_val3 = 3,
+    /* The AWRWAIT unit is 512 AHB clock cycle */
+    FLEXSPI_FLSHCR2A1_AWRWAITUNIT_val4 = 4,
+    /* The AWRWAIT unit is 2048 AHB clock cycle */
+    FLEXSPI_FLSHCR2A1_AWRWAITUNIT_val5 = 5,
+    /* The AWRWAIT unit is 8192 AHB clock cycle */
+    FLEXSPI_FLSHCR2A1_AWRWAITUNIT_val6 = 6,
+    /* The AWRWAIT unit is 32768 AHB clock cycle */
+    FLEXSPI_FLSHCR2A1_AWRWAITUNIT_val7 = 7,
+} FLEXSPI_FLSHCR2A1_AWRWAITUNIT_Enum;
+
+typedef enum {
+    /* The AWRWAIT unit is 2 AHB clock cycle */
+    FLEXSPI_FLSHCR2A2_AWRWAITUNIT_val0 = 0,
+    /* The AWRWAIT unit is 8 AHB clock cycle */
+    FLEXSPI_FLSHCR2A2_AWRWAITUNIT_val1 = 1,
+    /* The AWRWAIT unit is 32 AHB clock cycle */
+    FLEXSPI_FLSHCR2A2_AWRWAITUNIT_val2 = 2,
+    /* The AWRWAIT unit is 128 AHB clock cycle */
+    FLEXSPI_FLSHCR2A2_AWRWAITUNIT_val3 = 3,
+    /* The AWRWAIT unit is 512 AHB clock cycle */
+    FLEXSPI_FLSHCR2A2_AWRWAITUNIT_val4 = 4,
+    /* The AWRWAIT unit is 2048 AHB clock cycle */
+    FLEXSPI_FLSHCR2A2_AWRWAITUNIT_val5 = 5,
+    /* The AWRWAIT unit is 8192 AHB clock cycle */
+    FLEXSPI_FLSHCR2A2_AWRWAITUNIT_val6 = 6,
+    /* The AWRWAIT unit is 32768 AHB clock cycle */
+    FLEXSPI_FLSHCR2A2_AWRWAITUNIT_val7 = 7,
+} FLEXSPI_FLSHCR2A2_AWRWAITUNIT_Enum;
+
+typedef enum {
+    /* The AWRWAIT unit is 2 AHB clock cycle */
+    FLEXSPI_FLSHCR2B1_AWRWAITUNIT_val0 = 0,
+    /* The AWRWAIT unit is 8 AHB clock cycle */
+    FLEXSPI_FLSHCR2B1_AWRWAITUNIT_val1 = 1,
+    /* The AWRWAIT unit is 32 AHB clock cycle */
+    FLEXSPI_FLSHCR2B1_AWRWAITUNIT_val2 = 2,
+    /* The AWRWAIT unit is 128 AHB clock cycle */
+    FLEXSPI_FLSHCR2B1_AWRWAITUNIT_val3 = 3,
+    /* The AWRWAIT unit is 512 AHB clock cycle */
+    FLEXSPI_FLSHCR2B1_AWRWAITUNIT_val4 = 4,
+    /* The AWRWAIT unit is 2048 AHB clock cycle */
+    FLEXSPI_FLSHCR2B1_AWRWAITUNIT_val5 = 5,
+    /* The AWRWAIT unit is 8192 AHB clock cycle */
+    FLEXSPI_FLSHCR2B1_AWRWAITUNIT_val6 = 6,
+    /* The AWRWAIT unit is 32768 AHB clock cycle */
+    FLEXSPI_FLSHCR2B1_AWRWAITUNIT_val7 = 7,
+} FLEXSPI_FLSHCR2B1_AWRWAITUNIT_Enum;
+
+typedef enum {
+    /* The AWRWAIT unit is 2 AHB clock cycle */
+    FLEXSPI_FLSHCR2B2_AWRWAITUNIT_val0 = 0,
+    /* The AWRWAIT unit is 8 AHB clock cycle */
+    FLEXSPI_FLSHCR2B2_AWRWAITUNIT_val1 = 1,
+    /* The AWRWAIT unit is 32 AHB clock cycle */
+    FLEXSPI_FLSHCR2B2_AWRWAITUNIT_val2 = 2,
+    /* The AWRWAIT unit is 128 AHB clock cycle */
+    FLEXSPI_FLSHCR2B2_AWRWAITUNIT_val3 = 3,
+    /* The AWRWAIT unit is 512 AHB clock cycle */
+    FLEXSPI_FLSHCR2B2_AWRWAITUNIT_val4 = 4,
+    /* The AWRWAIT unit is 2048 AHB clock cycle */
+    FLEXSPI_FLSHCR2B2_AWRWAITUNIT_val5 = 5,
+    /* The AWRWAIT unit is 8192 AHB clock cycle */
+    FLEXSPI_FLSHCR2B2_AWRWAITUNIT_val6 = 6,
+    /* The AWRWAIT unit is 32768 AHB clock cycle */
+    FLEXSPI_FLSHCR2B2_AWRWAITUNIT_val7 = 7,
+} FLEXSPI_FLSHCR2B2_AWRWAITUNIT_Enum;
+
+typedef enum {
+    /*
+     * DQS pin will be used as Write Mask when writing to external device.
+     * There is no limitation on AHB/IP write burst start address alignment
+     * when flash is accessed in individual mode.
+     */
+    FLEXSPI_FLSHCR4_WMOPT1_DISABLE = 0,
+    /*
+     * DQS pin will not be used as Write Mask when writing to external device.
+     * There is limitation on AHB/IP write burst start address alignment when
+     * flash is accessed in individual mode.
+     */
+    FLEXSPI_FLSHCR4_WMOPT1_ENABLE = 1,
+} FLEXSPI_FLSHCR4_WMOPT1_Enum;
+
+typedef enum {
+    /*
+     * Write mask is disabled, DQS(RWDS) pin will not be driven when writing to
+     * external device.
+     */
+    FLEXSPI_FLSHCR4_WMENA_val0 = 0,
+    /*
+     * Write mask is enabled, DQS(RWDS) pin will be driven by FlexSPI as write
+     * mask output when writing to external device.
+     */
+    FLEXSPI_FLSHCR4_WMENA_val1 = 1,
+} FLEXSPI_FLSHCR4_WMENA_Enum;
+
+typedef enum {
+    /* Flash will be accessed in Individual mode. */
+    FLEXSPI_IPCR1_IPAREN_DISABLE = 0,
+    /* Flash will be accessed in Parallel mode. */
+    FLEXSPI_IPCR1_IPAREN_ENABLE = 1,
+} FLEXSPI_IPCR1_IPAREN_Enum;
+
+typedef enum {
+    /* No function. */
+    FLEXSPI_IPRXFCR_CLRIPRXF_value0 = 0,
+    /* A clock cycle pulse to clear all valid data entries in IP RX FIFO. */
+    FLEXSPI_IPRXFCR_CLRIPRXF_value1 = 1,
+} FLEXSPI_IPRXFCR_CLRIPRXF_Enum;
+
+typedef enum {
+    /* IP RX FIFO would be read by processor. */
+    FLEXSPI_IPRXFCR_RXDMAEN_val0 = 0,
+    /* IP RX FIFO would be read by DMA. */
+    FLEXSPI_IPRXFCR_RXDMAEN_val1 = 1,
+} FLEXSPI_IPRXFCR_RXDMAEN_Enum;
+
+typedef enum {
+    /* No function. */
+    FLEXSPI_IPTXFCR_CLRIPTXF_value0 = 0,
+    /* A clock cycle pulse to clear all valid data entries in IP TX FIFO. */
+    FLEXSPI_IPTXFCR_CLRIPTXF_value1 = 1,
+} FLEXSPI_IPTXFCR_CLRIPTXF_Enum;
+
+typedef enum {
+    /* IP TX FIFO would be filled by processor. */
+    FLEXSPI_IPTXFCR_TXDMAEN_val0 = 0,
+    /* IP TX FIFO would be filled by DMA. */
+    FLEXSPI_IPTXFCR_TXDMAEN_val1 = 1,
+} FLEXSPI_IPTXFCR_TXDMAEN_Enum;
+
+typedef enum {
+    /* DLL calibration is disabled */
+    FLEXSPI_DLLCRA_DLLEN_value0 = 0,
+    /* DLL calibration is enabled */
+    FLEXSPI_DLLCRA_DLLEN_value1 = 1,
+} FLEXSPI_DLLCRA_DLLEN_Enum;
+
+typedef enum {
+    /* No function. */
+    FLEXSPI_DLLCRA_DLLRESET_value0 = 0,
+    /* Software could force a reset on DLL by setting this field to 0x1. */
+    FLEXSPI_DLLCRA_DLLRESET_value1 = 1,
+} FLEXSPI_DLLCRA_DLLRESET_Enum;
+
+typedef enum {
+    /*
+     * Slave clock delay line delay cell number selection override is disabled.
+     */
+    FLEXSPI_DLLCRA_OVRDEN_value0 = 0,
+    /*
+     * Slave clock delay line delay cell number selection override is enabled.
+     */
+    FLEXSPI_DLLCRA_OVRDEN_value1 = 1,
+} FLEXSPI_DLLCRA_OVRDEN_Enum;
+
+typedef enum {
+    /* DLL calibration is disabled */
+    FLEXSPI_DLLCRB_DLLEN_value0 = 0,
+    /* DLL calibration is enabled */
+    FLEXSPI_DLLCRB_DLLEN_value1 = 1,
+} FLEXSPI_DLLCRB_DLLEN_Enum;
+
+typedef enum {
+    /* No function. */
+    FLEXSPI_DLLCRB_DLLRESET_value0 = 0,
+    /* Software could force a reset on DLL by setting this field to 0x1. */
+    FLEXSPI_DLLCRB_DLLRESET_value1 = 1,
+} FLEXSPI_DLLCRB_DLLRESET_Enum;
+
+typedef enum {
+    /*
+     * Slave clock delay line delay cell number selection override is disabled.
+     */
+    FLEXSPI_DLLCRB_OVRDEN_value0 = 0,
+    /*
+     * Slave clock delay line delay cell number selection override is enabled.
+     */
+    FLEXSPI_DLLCRB_OVRDEN_value1 = 1,
+} FLEXSPI_DLLCRB_OVRDEN_Enum;
+
+typedef enum {
+    /* State machine in SEQ_CTL is not idle. */
+    FLEXSPI_STS0_SEQIDLE_value0 = 0,
+    /* State machine in SEQ_CTL is idle. */
+    FLEXSPI_STS0_SEQIDLE_value1 = 1,
+} FLEXSPI_STS0_SEQIDLE_Enum;
+
+typedef enum {
+    /* Triggered by AHB read command. */
+    FLEXSPI_STS0_ARBCMDSRC_val0 = 0,
+    /* Triggered by AHB write command. */
+    FLEXSPI_STS0_ARBCMDSRC_val1 = 1,
+    /*
+     * Triggered by IP command (triggered by setting register bit IPCMD[TRG]).
+     */
+    FLEXSPI_STS0_ARBCMDSRC_val2 = 2,
+    /* Triggered by suspended command (resumed). */
+    FLEXSPI_STS0_ARBCMDSRC_val3 = 3,
+} FLEXSPI_STS0_ARBCMDSRC_Enum;
+
+typedef enum {
+    /* No error. */
+    FLEXSPI_STS1_AHBCMDERRCODE_val0 = 0,
+    /* AHB Write command with JMP_ON_CS instruction used in the sequence. */
+    FLEXSPI_STS1_AHBCMDERRCODE_val2 = 2,
+    /* There is unknown instruction opcode in the sequence. */
+    FLEXSPI_STS1_AHBCMDERRCODE_val3 = 3,
+    /* Instruction DUMMY_SDR/DUMMY_RWDS_SDR used in DDR sequence. */
+    FLEXSPI_STS1_AHBCMDERRCODE_val4 = 4,
+    /* Instruction DUMMY_DDR/DUMMY_RWDS_DDR used in SDR sequence. */
+    FLEXSPI_STS1_AHBCMDERRCODE_val5 = 5,
+    /* Sequence execution timeout. */
+    FLEXSPI_STS1_AHBCMDERRCODE_val6 = 14,
+} FLEXSPI_STS1_AHBCMDERRCODE_Enum;
+
+typedef enum {
+    /* No error. */
+    FLEXSPI_STS1_IPCMDERRCODE_val0 = 0,
+    /* IP command with JMP_ON_CS instruction used in the sequence. */
+    FLEXSPI_STS1_IPCMDERRCODE_val2 = 2,
+    /* There is unknown instruction opcode in the sequence. */
+    FLEXSPI_STS1_IPCMDERRCODE_val3 = 3,
+    /* Instruction DUMMY_SDR/DUMMY_RWDS_SDR used in DDR sequence. */
+    FLEXSPI_STS1_IPCMDERRCODE_val4 = 4,
+    /* Instruction DUMMY_DDR/DUMMY_RWDS_DDR used in SDR sequence. */
+    FLEXSPI_STS1_IPCMDERRCODE_val5 = 5,
+    /*
+     * Flash access start address exceed the whole flash address range
+     * (A1/A2/B1/B2).
+     */
+    FLEXSPI_STS1_IPCMDERRCODE_val6 = 6,
+    /* Sequence execution timeout. */
+    FLEXSPI_STS1_IPCMDERRCODE_val7 = 14,
+    /* Flash boundary crossed. */
+    FLEXSPI_STS1_IPCMDERRCODE_val8 = 15,
+} FLEXSPI_STS1_IPCMDERRCODE_Enum;
+
+typedef enum {
+    /* Flash A sample clock slave delay line is not locked */
+    FLEXSPI_STS2_ASLVLOCK_val0 = 0,
+    /* Flash A sample clock slave delay line is locked */
+    FLEXSPI_STS2_ASLVLOCK_val1 = 1,
+} FLEXSPI_STS2_ASLVLOCK_Enum;
+
+typedef enum {
+    /* Flash A sample clock reference delay line is not locked */
+    FLEXSPI_STS2_AREFLOCK_val0 = 0,
+    /* Flash A sample clock reference delay line is locked */
+    FLEXSPI_STS2_AREFLOCK_val1 = 1,
+} FLEXSPI_STS2_AREFLOCK_Enum;
+
+typedef enum {
+    /* Flash B sample clock slave delay line is not locked. */
+    FLEXSPI_STS2_BSLVLOCK_val0 = 0,
+    /* Flash B sample clock slave delay line is locked. */
+    FLEXSPI_STS2_BSLVLOCK_val1 = 1,
+} FLEXSPI_STS2_BSLVLOCK_Enum;
+
+typedef enum {
+    /* Flash B sample clock reference delay line is not locked. */
+    FLEXSPI_STS2_BREFLOCK_val0 = 0,
+    /* Flash B sample clock reference delay line is locked. */
+    FLEXSPI_STS2_BREFLOCK_val1 = 1,
+} FLEXSPI_STS2_BREFLOCK_Enum;
+
+typedef enum {
+    /* No suspended AHB read prefetch command. */
+    FLEXSPI_AHBSPNDSTS_ACTIVE_val0 = 0,
+    /* An AHB read prefetch command sequence has been suspended. */
+    FLEXSPI_AHBSPNDSTS_ACTIVE_val1 = 1,
+} FLEXSPI_AHBSPNDSTS_ACTIVE_Enum;
+
+typedef enum {
+    /* HADDR REMAP Disabled */
+    FLEXSPI_HADDRSTART_REMAPEN_val0 = 0,
+    /* HADDR REMAP Enabled */
+    FLEXSPI_HADDRSTART_REMAPEN_val1 = 1,
+} FLEXSPI_HADDRSTART_REMAPEN_Enum;
+
+
+#define FLEXSPI_REGISTER_NAMES_ARRAY(_name) \
+    const char *_name[FLEXSPI_REGS_NO] = { \
+        [R_FLEXSPI_MCR0] = "MCR0", \
+        [R_FLEXSPI_MCR1] = "MCR1", \
+        [R_FLEXSPI_MCR2] = "MCR2", \
+        [R_FLEXSPI_AHBCR] = "AHBCR", \
+        [R_FLEXSPI_INTEN] = "INTEN", \
+        [R_FLEXSPI_INTR] = "INTR", \
+        [R_FLEXSPI_LUTKEY] = "LUTKEY", \
+        [R_FLEXSPI_LUTCR] = "LUTCR", \
+        [R_FLEXSPI_AHBRXBUF0CR0] = "AHBRXBUF0CR0", \
+        [R_FLEXSPI_AHBRXBUF1CR0] = "AHBRXBUF1CR0", \
+        [R_FLEXSPI_AHBRXBUF2CR0] = "AHBRXBUF2CR0", \
+        [R_FLEXSPI_AHBRXBUF3CR0] = "AHBRXBUF3CR0", \
+        [R_FLEXSPI_AHBRXBUF4CR0] = "AHBRXBUF4CR0", \
+        [R_FLEXSPI_AHBRXBUF5CR0] = "AHBRXBUF5CR0", \
+        [R_FLEXSPI_AHBRXBUF6CR0] = "AHBRXBUF6CR0", \
+        [R_FLEXSPI_AHBRXBUF7CR0] = "AHBRXBUF7CR0", \
+        [R_FLEXSPI_FLSHA1CR0] = "FLSHA1CR0", \
+        [R_FLEXSPI_FLSHA2CR0] = "FLSHA2CR0", \
+        [R_FLEXSPI_FLSHB1CR0] = "FLSHB1CR0", \
+        [R_FLEXSPI_FLSHB2CR0] = "FLSHB2CR0", \
+        [R_FLEXSPI_FLSHCR1A1] = "FLSHCR1A1", \
+        [R_FLEXSPI_FLSHCR1A2] = "FLSHCR1A2", \
+        [R_FLEXSPI_FLSHCR1B1] = "FLSHCR1B1", \
+        [R_FLEXSPI_FLSHCR1B2] = "FLSHCR1B2", \
+        [R_FLEXSPI_FLSHCR2A1] = "FLSHCR2A1", \
+        [R_FLEXSPI_FLSHCR2A2] = "FLSHCR2A2", \
+        [R_FLEXSPI_FLSHCR2B1] = "FLSHCR2B1", \
+        [R_FLEXSPI_FLSHCR2B2] = "FLSHCR2B2", \
+        [R_FLEXSPI_FLSHCR4] = "FLSHCR4", \
+        [R_FLEXSPI_IPCR0] = "IPCR0", \
+        [R_FLEXSPI_IPCR1] = "IPCR1", \
+        [R_FLEXSPI_IPCMD] = "IPCMD", \
+        [R_FLEXSPI_DLPR] = "DLPR", \
+        [R_FLEXSPI_IPRXFCR] = "IPRXFCR", \
+        [R_FLEXSPI_IPTXFCR] = "IPTXFCR", \
+        [R_FLEXSPI_DLLCRA] = "DLLCRA", \
+        [R_FLEXSPI_DLLCRB] = "DLLCRB", \
+        [R_FLEXSPI_STS0] = "STS0", \
+        [R_FLEXSPI_STS1] = "STS1", \
+        [R_FLEXSPI_STS2] = "STS2", \
+        [R_FLEXSPI_AHBSPNDSTS] = "AHBSPNDSTS", \
+        [R_FLEXSPI_IPRXFSTS] = "IPRXFSTS", \
+        [R_FLEXSPI_IPTXFSTS] = "IPTXFSTS", \
+        [R_FLEXSPI_RFDR0] = "RFDR0", \
+        [R_FLEXSPI_RFDR1] = "RFDR1", \
+        [R_FLEXSPI_RFDR2] = "RFDR2", \
+        [R_FLEXSPI_RFDR3] = "RFDR3", \
+        [R_FLEXSPI_RFDR4] = "RFDR4", \
+        [R_FLEXSPI_RFDR5] = "RFDR5", \
+        [R_FLEXSPI_RFDR6] = "RFDR6", \
+        [R_FLEXSPI_RFDR7] = "RFDR7", \
+        [R_FLEXSPI_RFDR8] = "RFDR8", \
+        [R_FLEXSPI_RFDR9] = "RFDR9", \
+        [R_FLEXSPI_RFDR10] = "RFDR10", \
+        [R_FLEXSPI_RFDR11] = "RFDR11", \
+        [R_FLEXSPI_RFDR12] = "RFDR12", \
+        [R_FLEXSPI_RFDR13] = "RFDR13", \
+        [R_FLEXSPI_RFDR14] = "RFDR14", \
+        [R_FLEXSPI_RFDR15] = "RFDR15", \
+        [R_FLEXSPI_RFDR16] = "RFDR16", \
+        [R_FLEXSPI_RFDR17] = "RFDR17", \
+        [R_FLEXSPI_RFDR18] = "RFDR18", \
+        [R_FLEXSPI_RFDR19] = "RFDR19", \
+        [R_FLEXSPI_RFDR20] = "RFDR20", \
+        [R_FLEXSPI_RFDR21] = "RFDR21", \
+        [R_FLEXSPI_RFDR22] = "RFDR22", \
+        [R_FLEXSPI_RFDR23] = "RFDR23", \
+        [R_FLEXSPI_RFDR24] = "RFDR24", \
+        [R_FLEXSPI_RFDR25] = "RFDR25", \
+        [R_FLEXSPI_RFDR26] = "RFDR26", \
+        [R_FLEXSPI_RFDR27] = "RFDR27", \
+        [R_FLEXSPI_RFDR28] = "RFDR28", \
+        [R_FLEXSPI_RFDR29] = "RFDR29", \
+        [R_FLEXSPI_RFDR30] = "RFDR30", \
+        [R_FLEXSPI_RFDR31] = "RFDR31", \
+        [R_FLEXSPI_TFDR0] = "TFDR0", \
+        [R_FLEXSPI_TFDR1] = "TFDR1", \
+        [R_FLEXSPI_TFDR2] = "TFDR2", \
+        [R_FLEXSPI_TFDR3] = "TFDR3", \
+        [R_FLEXSPI_TFDR4] = "TFDR4", \
+        [R_FLEXSPI_TFDR5] = "TFDR5", \
+        [R_FLEXSPI_TFDR6] = "TFDR6", \
+        [R_FLEXSPI_TFDR7] = "TFDR7", \
+        [R_FLEXSPI_TFDR8] = "TFDR8", \
+        [R_FLEXSPI_TFDR9] = "TFDR9", \
+        [R_FLEXSPI_TFDR10] = "TFDR10", \
+        [R_FLEXSPI_TFDR11] = "TFDR11", \
+        [R_FLEXSPI_TFDR12] = "TFDR12", \
+        [R_FLEXSPI_TFDR13] = "TFDR13", \
+        [R_FLEXSPI_TFDR14] = "TFDR14", \
+        [R_FLEXSPI_TFDR15] = "TFDR15", \
+        [R_FLEXSPI_TFDR16] = "TFDR16", \
+        [R_FLEXSPI_TFDR17] = "TFDR17", \
+        [R_FLEXSPI_TFDR18] = "TFDR18", \
+        [R_FLEXSPI_TFDR19] = "TFDR19", \
+        [R_FLEXSPI_TFDR20] = "TFDR20", \
+        [R_FLEXSPI_TFDR21] = "TFDR21", \
+        [R_FLEXSPI_TFDR22] = "TFDR22", \
+        [R_FLEXSPI_TFDR23] = "TFDR23", \
+        [R_FLEXSPI_TFDR24] = "TFDR24", \
+        [R_FLEXSPI_TFDR25] = "TFDR25", \
+        [R_FLEXSPI_TFDR26] = "TFDR26", \
+        [R_FLEXSPI_TFDR27] = "TFDR27", \
+        [R_FLEXSPI_TFDR28] = "TFDR28", \
+        [R_FLEXSPI_TFDR29] = "TFDR29", \
+        [R_FLEXSPI_TFDR30] = "TFDR30", \
+        [R_FLEXSPI_TFDR31] = "TFDR31", \
+        [R_FLEXSPI_LUT0] = "LUT0", \
+        [R_FLEXSPI_LUT1] = "LUT1", \
+        [R_FLEXSPI_LUT2] = "LUT2", \
+        [R_FLEXSPI_LUT3] = "LUT3", \
+        [R_FLEXSPI_LUT4] = "LUT4", \
+        [R_FLEXSPI_LUT5] = "LUT5", \
+        [R_FLEXSPI_LUT6] = "LUT6", \
+        [R_FLEXSPI_LUT7] = "LUT7", \
+        [R_FLEXSPI_LUT8] = "LUT8", \
+        [R_FLEXSPI_LUT9] = "LUT9", \
+        [R_FLEXSPI_LUT10] = "LUT10", \
+        [R_FLEXSPI_LUT11] = "LUT11", \
+        [R_FLEXSPI_LUT12] = "LUT12", \
+        [R_FLEXSPI_LUT13] = "LUT13", \
+        [R_FLEXSPI_LUT14] = "LUT14", \
+        [R_FLEXSPI_LUT15] = "LUT15", \
+        [R_FLEXSPI_LUT16] = "LUT16", \
+        [R_FLEXSPI_LUT17] = "LUT17", \
+        [R_FLEXSPI_LUT18] = "LUT18", \
+        [R_FLEXSPI_LUT19] = "LUT19", \
+        [R_FLEXSPI_LUT20] = "LUT20", \
+        [R_FLEXSPI_LUT21] = "LUT21", \
+        [R_FLEXSPI_LUT22] = "LUT22", \
+        [R_FLEXSPI_LUT23] = "LUT23", \
+        [R_FLEXSPI_LUT24] = "LUT24", \
+        [R_FLEXSPI_LUT25] = "LUT25", \
+        [R_FLEXSPI_LUT26] = "LUT26", \
+        [R_FLEXSPI_LUT27] = "LUT27", \
+        [R_FLEXSPI_LUT28] = "LUT28", \
+        [R_FLEXSPI_LUT29] = "LUT29", \
+        [R_FLEXSPI_LUT30] = "LUT30", \
+        [R_FLEXSPI_LUT31] = "LUT31", \
+        [R_FLEXSPI_LUT32] = "LUT32", \
+        [R_FLEXSPI_LUT33] = "LUT33", \
+        [R_FLEXSPI_LUT34] = "LUT34", \
+        [R_FLEXSPI_LUT35] = "LUT35", \
+        [R_FLEXSPI_LUT36] = "LUT36", \
+        [R_FLEXSPI_LUT37] = "LUT37", \
+        [R_FLEXSPI_LUT38] = "LUT38", \
+        [R_FLEXSPI_LUT39] = "LUT39", \
+        [R_FLEXSPI_LUT40] = "LUT40", \
+        [R_FLEXSPI_LUT41] = "LUT41", \
+        [R_FLEXSPI_LUT42] = "LUT42", \
+        [R_FLEXSPI_LUT43] = "LUT43", \
+        [R_FLEXSPI_LUT44] = "LUT44", \
+        [R_FLEXSPI_LUT45] = "LUT45", \
+        [R_FLEXSPI_LUT46] = "LUT46", \
+        [R_FLEXSPI_LUT47] = "LUT47", \
+        [R_FLEXSPI_LUT48] = "LUT48", \
+        [R_FLEXSPI_LUT49] = "LUT49", \
+        [R_FLEXSPI_LUT50] = "LUT50", \
+        [R_FLEXSPI_LUT51] = "LUT51", \
+        [R_FLEXSPI_LUT52] = "LUT52", \
+        [R_FLEXSPI_LUT53] = "LUT53", \
+        [R_FLEXSPI_LUT54] = "LUT54", \
+        [R_FLEXSPI_LUT55] = "LUT55", \
+        [R_FLEXSPI_LUT56] = "LUT56", \
+        [R_FLEXSPI_LUT57] = "LUT57", \
+        [R_FLEXSPI_LUT58] = "LUT58", \
+        [R_FLEXSPI_LUT59] = "LUT59", \
+        [R_FLEXSPI_LUT60] = "LUT60", \
+        [R_FLEXSPI_LUT61] = "LUT61", \
+        [R_FLEXSPI_LUT62] = "LUT62", \
+        [R_FLEXSPI_LUT63] = "LUT63", \
+        [R_FLEXSPI_HADDRSTART] = "HADDRSTART", \
+        [R_FLEXSPI_HADDREND] = "HADDREND", \
+        [R_FLEXSPI_HADDROFFSET] = "HADDROFFSET", \
+    }
+
+#define FLEXSPI_REGISTER_WMASK_ARRAY(_name) \
+    const uint32_t _name[FLEXSPI_REGS_NO] = { \
+        [R_FLEXSPI_MCR0] = 0xFFFFDF33, \
+        [R_FLEXSPI_MCR1] = 0xFFFFFFFF, \
+        [R_FLEXSPI_MCR2] = 0xFF00C800, \
+        [R_FLEXSPI_AHBCR] = 0x4FD, \
+        [R_FLEXSPI_INTEN] = 0x3FFF, \
+        [R_FLEXSPI_INTR] = 0x1FFF, \
+        [R_FLEXSPI_LUTKEY] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUTCR] = 0x3, \
+        [R_FLEXSPI_AHBRXBUF0CR0] = 0x870F00FF, \
+        [R_FLEXSPI_AHBRXBUF1CR0] = 0x870F00FF, \
+        [R_FLEXSPI_AHBRXBUF2CR0] = 0x870F00FF, \
+        [R_FLEXSPI_AHBRXBUF3CR0] = 0x870F00FF, \
+        [R_FLEXSPI_AHBRXBUF4CR0] = 0x870F00FF, \
+        [R_FLEXSPI_AHBRXBUF5CR0] = 0x870F00FF, \
+        [R_FLEXSPI_AHBRXBUF6CR0] = 0x870F00FF, \
+        [R_FLEXSPI_AHBRXBUF7CR0] = 0x870F00FF, \
+        [R_FLEXSPI_FLSHA1CR0] = 0x7FFFFF, \
+        [R_FLEXSPI_FLSHA2CR0] = 0x7FFFFF, \
+        [R_FLEXSPI_FLSHB1CR0] = 0x7FFFFF, \
+        [R_FLEXSPI_FLSHB2CR0] = 0x7FFFFF, \
+        [R_FLEXSPI_FLSHCR1A1] = 0xFFFFFFFF, \
+        [R_FLEXSPI_FLSHCR1A2] = 0xFFFFFFFF, \
+        [R_FLEXSPI_FLSHCR1B1] = 0xFFFFFFFF, \
+        [R_FLEXSPI_FLSHCR1B2] = 0xFFFFFFFF, \
+        [R_FLEXSPI_FLSHCR2A1] = 0xFFFFEFEF, \
+        [R_FLEXSPI_FLSHCR2A2] = 0xFFFFEFEF, \
+        [R_FLEXSPI_FLSHCR2B1] = 0xFFFFEFEF, \
+        [R_FLEXSPI_FLSHCR2B2] = 0xFFFFEFEF, \
+        [R_FLEXSPI_FLSHCR4] = 0x5, \
+        [R_FLEXSPI_IPCR0] = 0xFFFFFFFF, \
+        [R_FLEXSPI_IPCR1] = 0x870FFFFF, \
+        [R_FLEXSPI_IPCMD] = 0x1, \
+        [R_FLEXSPI_DLPR] = 0xFFFFFFFF, \
+        [R_FLEXSPI_IPRXFCR] = 0x1FF, \
+        [R_FLEXSPI_IPTXFCR] = 0x1FF, \
+        [R_FLEXSPI_DLLCRA] = 0x7F7B, \
+        [R_FLEXSPI_DLLCRB] = 0x7F7B, \
+        [R_FLEXSPI_TFDR0] = 0xFFFFFFFF, \
+        [R_FLEXSPI_TFDR1] = 0xFFFFFFFF, \
+        [R_FLEXSPI_TFDR2] = 0xFFFFFFFF, \
+        [R_FLEXSPI_TFDR3] = 0xFFFFFFFF, \
+        [R_FLEXSPI_TFDR4] = 0xFFFFFFFF, \
+        [R_FLEXSPI_TFDR5] = 0xFFFFFFFF, \
+        [R_FLEXSPI_TFDR6] = 0xFFFFFFFF, \
+        [R_FLEXSPI_TFDR7] = 0xFFFFFFFF, \
+        [R_FLEXSPI_TFDR8] = 0xFFFFFFFF, \
+        [R_FLEXSPI_TFDR9] = 0xFFFFFFFF, \
+        [R_FLEXSPI_TFDR10] = 0xFFFFFFFF, \
+        [R_FLEXSPI_TFDR11] = 0xFFFFFFFF, \
+        [R_FLEXSPI_TFDR12] = 0xFFFFFFFF, \
+        [R_FLEXSPI_TFDR13] = 0xFFFFFFFF, \
+        [R_FLEXSPI_TFDR14] = 0xFFFFFFFF, \
+        [R_FLEXSPI_TFDR15] = 0xFFFFFFFF, \
+        [R_FLEXSPI_TFDR16] = 0xFFFFFFFF, \
+        [R_FLEXSPI_TFDR17] = 0xFFFFFFFF, \
+        [R_FLEXSPI_TFDR18] = 0xFFFFFFFF, \
+        [R_FLEXSPI_TFDR19] = 0xFFFFFFFF, \
+        [R_FLEXSPI_TFDR20] = 0xFFFFFFFF, \
+        [R_FLEXSPI_TFDR21] = 0xFFFFFFFF, \
+        [R_FLEXSPI_TFDR22] = 0xFFFFFFFF, \
+        [R_FLEXSPI_TFDR23] = 0xFFFFFFFF, \
+        [R_FLEXSPI_TFDR24] = 0xFFFFFFFF, \
+        [R_FLEXSPI_TFDR25] = 0xFFFFFFFF, \
+        [R_FLEXSPI_TFDR26] = 0xFFFFFFFF, \
+        [R_FLEXSPI_TFDR27] = 0xFFFFFFFF, \
+        [R_FLEXSPI_TFDR28] = 0xFFFFFFFF, \
+        [R_FLEXSPI_TFDR29] = 0xFFFFFFFF, \
+        [R_FLEXSPI_TFDR30] = 0xFFFFFFFF, \
+        [R_FLEXSPI_TFDR31] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT0] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT1] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT2] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT3] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT4] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT5] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT6] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT7] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT8] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT9] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT10] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT11] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT12] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT13] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT14] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT15] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT16] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT17] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT18] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT19] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT20] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT21] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT22] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT23] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT24] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT25] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT26] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT27] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT28] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT29] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT30] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT31] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT32] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT33] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT34] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT35] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT36] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT37] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT38] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT39] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT40] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT41] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT42] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT43] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT44] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT45] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT46] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT47] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT48] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT49] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT50] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT51] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT52] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT53] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT54] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT55] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT56] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT57] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT58] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT59] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT60] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT61] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT62] = 0xFFFFFFFF, \
+        [R_FLEXSPI_LUT63] = 0xFFFFFFFF, \
+        [R_FLEXSPI_HADDRSTART] = 0xFFFFF001, \
+        [R_FLEXSPI_HADDREND] = 0xFFFFF000, \
+        [R_FLEXSPI_HADDROFFSET] = 0xFFFFF000, \
+    }
+
+static inline void flexspi_reset_registers(uint32_t *regs)
+{
+    regs[R_FLEXSPI_MCR0] = 0xffff80c2;
+    regs[R_FLEXSPI_MCR1] = 0xffffffff;
+    regs[R_FLEXSPI_MCR2] = 0x200081f7;
+    regs[R_FLEXSPI_AHBCR] = 0x18;
+    regs[R_FLEXSPI_INTEN] = 0x0;
+    regs[R_FLEXSPI_INTR] = 0x0;
+    regs[R_FLEXSPI_LUTKEY] = 0x5af05af0;
+    regs[R_FLEXSPI_LUTCR] = 0x2;
+    regs[R_FLEXSPI_AHBRXBUF0CR0] = 0x80000010;
+    regs[R_FLEXSPI_AHBRXBUF1CR0] = 0x80010010;
+    regs[R_FLEXSPI_AHBRXBUF2CR0] = 0x80020010;
+    regs[R_FLEXSPI_AHBRXBUF3CR0] = 0x80030010;
+    regs[R_FLEXSPI_AHBRXBUF4CR0] = 0x80040010;
+    regs[R_FLEXSPI_AHBRXBUF5CR0] = 0x80050010;
+    regs[R_FLEXSPI_AHBRXBUF6CR0] = 0x80060010;
+    regs[R_FLEXSPI_AHBRXBUF7CR0] = 0x80070010;
+    regs[R_FLEXSPI_FLSHA1CR0] = 0x10000;
+    regs[R_FLEXSPI_FLSHA2CR0] = 0x10000;
+    regs[R_FLEXSPI_FLSHB1CR0] = 0x10000;
+    regs[R_FLEXSPI_FLSHB2CR0] = 0x10000;
+    regs[R_FLEXSPI_FLSHCR1A1] = 0x63;
+    regs[R_FLEXSPI_FLSHCR1A2] = 0x63;
+    regs[R_FLEXSPI_FLSHCR1B1] = 0x63;
+    regs[R_FLEXSPI_FLSHCR1B2] = 0x63;
+    regs[R_FLEXSPI_FLSHCR2A1] = 0x0;
+    regs[R_FLEXSPI_FLSHCR2A2] = 0x0;
+    regs[R_FLEXSPI_FLSHCR2B1] = 0x0;
+    regs[R_FLEXSPI_FLSHCR2B2] = 0x0;
+    regs[R_FLEXSPI_FLSHCR4] = 0x0;
+    regs[R_FLEXSPI_IPCR0] = 0x0;
+    regs[R_FLEXSPI_IPCR1] = 0x0;
+    regs[R_FLEXSPI_IPCMD] = 0x0;
+    regs[R_FLEXSPI_DLPR] = 0x0;
+    regs[R_FLEXSPI_IPRXFCR] = 0x0;
+    regs[R_FLEXSPI_IPTXFCR] = 0x0;
+    regs[R_FLEXSPI_DLLCRA] = 0x100;
+    regs[R_FLEXSPI_DLLCRB] = 0x100;
+    regs[R_FLEXSPI_STS0] = 0x2;
+    regs[R_FLEXSPI_STS1] = 0x0;
+    regs[R_FLEXSPI_STS2] = 0x1000100;
+    regs[R_FLEXSPI_AHBSPNDSTS] = 0x0;
+    regs[R_FLEXSPI_IPRXFSTS] = 0x0;
+    regs[R_FLEXSPI_IPTXFSTS] = 0x0;
+    regs[R_FLEXSPI_RFDR0] = 0x0;
+    regs[R_FLEXSPI_RFDR1] = 0x0;
+    regs[R_FLEXSPI_RFDR2] = 0x0;
+    regs[R_FLEXSPI_RFDR3] = 0x0;
+    regs[R_FLEXSPI_RFDR4] = 0x0;
+    regs[R_FLEXSPI_RFDR5] = 0x0;
+    regs[R_FLEXSPI_RFDR6] = 0x0;
+    regs[R_FLEXSPI_RFDR7] = 0x0;
+    regs[R_FLEXSPI_RFDR8] = 0x0;
+    regs[R_FLEXSPI_RFDR9] = 0x0;
+    regs[R_FLEXSPI_RFDR10] = 0x0;
+    regs[R_FLEXSPI_RFDR11] = 0x0;
+    regs[R_FLEXSPI_RFDR12] = 0x0;
+    regs[R_FLEXSPI_RFDR13] = 0x0;
+    regs[R_FLEXSPI_RFDR14] = 0x0;
+    regs[R_FLEXSPI_RFDR15] = 0x0;
+    regs[R_FLEXSPI_RFDR16] = 0x0;
+    regs[R_FLEXSPI_RFDR17] = 0x0;
+    regs[R_FLEXSPI_RFDR18] = 0x0;
+    regs[R_FLEXSPI_RFDR19] = 0x0;
+    regs[R_FLEXSPI_RFDR20] = 0x0;
+    regs[R_FLEXSPI_RFDR21] = 0x0;
+    regs[R_FLEXSPI_RFDR22] = 0x0;
+    regs[R_FLEXSPI_RFDR23] = 0x0;
+    regs[R_FLEXSPI_RFDR24] = 0x0;
+    regs[R_FLEXSPI_RFDR25] = 0x0;
+    regs[R_FLEXSPI_RFDR26] = 0x0;
+    regs[R_FLEXSPI_RFDR27] = 0x0;
+    regs[R_FLEXSPI_RFDR28] = 0x0;
+    regs[R_FLEXSPI_RFDR29] = 0x0;
+    regs[R_FLEXSPI_RFDR30] = 0x0;
+    regs[R_FLEXSPI_RFDR31] = 0x0;
+    regs[R_FLEXSPI_TFDR0] = 0x0;
+    regs[R_FLEXSPI_TFDR1] = 0x0;
+    regs[R_FLEXSPI_TFDR2] = 0x0;
+    regs[R_FLEXSPI_TFDR3] = 0x0;
+    regs[R_FLEXSPI_TFDR4] = 0x0;
+    regs[R_FLEXSPI_TFDR5] = 0x0;
+    regs[R_FLEXSPI_TFDR6] = 0x0;
+    regs[R_FLEXSPI_TFDR7] = 0x0;
+    regs[R_FLEXSPI_TFDR8] = 0x0;
+    regs[R_FLEXSPI_TFDR9] = 0x0;
+    regs[R_FLEXSPI_TFDR10] = 0x0;
+    regs[R_FLEXSPI_TFDR11] = 0x0;
+    regs[R_FLEXSPI_TFDR12] = 0x0;
+    regs[R_FLEXSPI_TFDR13] = 0x0;
+    regs[R_FLEXSPI_TFDR14] = 0x0;
+    regs[R_FLEXSPI_TFDR15] = 0x0;
+    regs[R_FLEXSPI_TFDR16] = 0x0;
+    regs[R_FLEXSPI_TFDR17] = 0x0;
+    regs[R_FLEXSPI_TFDR18] = 0x0;
+    regs[R_FLEXSPI_TFDR19] = 0x0;
+    regs[R_FLEXSPI_TFDR20] = 0x0;
+    regs[R_FLEXSPI_TFDR21] = 0x0;
+    regs[R_FLEXSPI_TFDR22] = 0x0;
+    regs[R_FLEXSPI_TFDR23] = 0x0;
+    regs[R_FLEXSPI_TFDR24] = 0x0;
+    regs[R_FLEXSPI_TFDR25] = 0x0;
+    regs[R_FLEXSPI_TFDR26] = 0x0;
+    regs[R_FLEXSPI_TFDR27] = 0x0;
+    regs[R_FLEXSPI_TFDR28] = 0x0;
+    regs[R_FLEXSPI_TFDR29] = 0x0;
+    regs[R_FLEXSPI_TFDR30] = 0x0;
+    regs[R_FLEXSPI_TFDR31] = 0x0;
+    regs[R_FLEXSPI_LUT0] = 0x0;
+    regs[R_FLEXSPI_LUT1] = 0x0;
+    regs[R_FLEXSPI_LUT2] = 0x0;
+    regs[R_FLEXSPI_LUT3] = 0x0;
+    regs[R_FLEXSPI_LUT4] = 0x0;
+    regs[R_FLEXSPI_LUT5] = 0x0;
+    regs[R_FLEXSPI_LUT6] = 0x0;
+    regs[R_FLEXSPI_LUT7] = 0x0;
+    regs[R_FLEXSPI_LUT8] = 0x0;
+    regs[R_FLEXSPI_LUT9] = 0x0;
+    regs[R_FLEXSPI_LUT10] = 0x0;
+    regs[R_FLEXSPI_LUT11] = 0x0;
+    regs[R_FLEXSPI_LUT12] = 0x0;
+    regs[R_FLEXSPI_LUT13] = 0x0;
+    regs[R_FLEXSPI_LUT14] = 0x0;
+    regs[R_FLEXSPI_LUT15] = 0x0;
+    regs[R_FLEXSPI_LUT16] = 0x0;
+    regs[R_FLEXSPI_LUT17] = 0x0;
+    regs[R_FLEXSPI_LUT18] = 0x0;
+    regs[R_FLEXSPI_LUT19] = 0x0;
+    regs[R_FLEXSPI_LUT20] = 0x0;
+    regs[R_FLEXSPI_LUT21] = 0x0;
+    regs[R_FLEXSPI_LUT22] = 0x0;
+    regs[R_FLEXSPI_LUT23] = 0x0;
+    regs[R_FLEXSPI_LUT24] = 0x0;
+    regs[R_FLEXSPI_LUT25] = 0x0;
+    regs[R_FLEXSPI_LUT26] = 0x0;
+    regs[R_FLEXSPI_LUT27] = 0x0;
+    regs[R_FLEXSPI_LUT28] = 0x0;
+    regs[R_FLEXSPI_LUT29] = 0x0;
+    regs[R_FLEXSPI_LUT30] = 0x0;
+    regs[R_FLEXSPI_LUT31] = 0x0;
+    regs[R_FLEXSPI_LUT32] = 0x0;
+    regs[R_FLEXSPI_LUT33] = 0x0;
+    regs[R_FLEXSPI_LUT34] = 0x0;
+    regs[R_FLEXSPI_LUT35] = 0x0;
+    regs[R_FLEXSPI_LUT36] = 0x0;
+    regs[R_FLEXSPI_LUT37] = 0x0;
+    regs[R_FLEXSPI_LUT38] = 0x0;
+    regs[R_FLEXSPI_LUT39] = 0x0;
+    regs[R_FLEXSPI_LUT40] = 0x0;
+    regs[R_FLEXSPI_LUT41] = 0x0;
+    regs[R_FLEXSPI_LUT42] = 0x0;
+    regs[R_FLEXSPI_LUT43] = 0x0;
+    regs[R_FLEXSPI_LUT44] = 0x0;
+    regs[R_FLEXSPI_LUT45] = 0x0;
+    regs[R_FLEXSPI_LUT46] = 0x0;
+    regs[R_FLEXSPI_LUT47] = 0x0;
+    regs[R_FLEXSPI_LUT48] = 0x0;
+    regs[R_FLEXSPI_LUT49] = 0x0;
+    regs[R_FLEXSPI_LUT50] = 0x0;
+    regs[R_FLEXSPI_LUT51] = 0x0;
+    regs[R_FLEXSPI_LUT52] = 0x0;
+    regs[R_FLEXSPI_LUT53] = 0x0;
+    regs[R_FLEXSPI_LUT54] = 0x0;
+    regs[R_FLEXSPI_LUT55] = 0x0;
+    regs[R_FLEXSPI_LUT56] = 0x0;
+    regs[R_FLEXSPI_LUT57] = 0x0;
+    regs[R_FLEXSPI_LUT58] = 0x0;
+    regs[R_FLEXSPI_LUT59] = 0x0;
+    regs[R_FLEXSPI_LUT60] = 0x0;
+    regs[R_FLEXSPI_LUT61] = 0x0;
+    regs[R_FLEXSPI_LUT62] = 0x0;
+    regs[R_FLEXSPI_LUT63] = 0x0;
+    regs[R_FLEXSPI_HADDRSTART] = 0x0;
+    regs[R_FLEXSPI_HADDREND] = 0x0;
+    regs[R_FLEXSPI_HADDROFFSET] = 0x0;
+}
diff --git a/include/hw/ssi/flexspi.h b/include/hw/ssi/flexspi.h
new file mode 100644
index 0000000000..7487f40521
--- /dev/null
+++ b/include/hw/ssi/flexspi.h
@@ -0,0 +1,32 @@
+/*
+ * QEMU model for FLEXSPI
+ *
+ * Copyright (c) 2024 Google LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_RT500_FLEXSPI_H
+#define HW_RT500_FLEXSPI_H
+
+#include "hw/sysbus.h"
+#include "hw/ssi/ssi.h"
+#include "hw/arm/svd/flexspi.h"
+
+#define TYPE_FLEXSPI "flexspi"
+#define FLEXSPI(obj) OBJECT_CHECK(FlexSpiState, (obj), TYPE_FLEXSPI)
+
+typedef struct {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+    uint32_t regs[FLEXSPI_REGS_NO];
+    MemoryRegion mem;
+    uint64_t mmap_base;
+    uint64_t mmap_size;
+} FlexSpiState;
+
+#endif /* HW_RT500_FLEXSPI_H */
diff --git a/hw/ssi/flexspi.c b/hw/ssi/flexspi.c
new file mode 100644
index 0000000000..0ec84776c9
--- /dev/null
+++ b/hw/ssi/flexspi.c
@@ -0,0 +1,157 @@
+/*
+ * QEMU model for FLEXSPI
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
+#include "qemu/mmap-alloc.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/units.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
+#include "migration/vmstate.h"
+#include "exec/address-spaces.h"
+#include "hw/regs.h"
+#include "hw/ssi/flexspi.h"
+#include "hw/arm/svd/flexspi.h"
+
+#include "trace.h"
+
+#define REG(s, reg) (s->regs[R_FLEXSPI_##reg])
+#define RF_WR(s, reg, field, val) \
+    ARRAY_FIELD_DP32(s->regs, FLEXSPI_##reg, field, val)
+#define RF_RD(s, reg, field) \
+    ARRAY_FIELD_EX32(s->regs, FLEXSPI_##reg, field)
+
+static FLEXSPI_REGISTER_NAMES_ARRAY(reg_names);
+
+static void flexspi_reset(DeviceState *dev)
+{
+    FlexSpiState *s = FLEXSPI(dev);
+
+    memset(s->regs, 0, sizeof(s->regs));
+
+    flexspi_reset_registers(s->regs);
+
+    /* idle immediately after reset */
+    RF_WR(s, STS0, SEQIDLE, 1);
+}
+
+static MemTxResult flexspi_read(void *opaque, hwaddr addr,
+                                     uint64_t *data, unsigned size,
+                                     MemTxAttrs attrs)
+{
+    FlexSpiState *s = opaque;
+    MemTxResult ret = MEMTX_OK;
+
+    switch (addr) {
+    default:
+        *data = s->regs[addr / 4];
+        break;
+    }
+
+    trace_flexspi_reg_read(DEVICE(s)->id, reg_names[addr / 4], addr, *data);
+    return ret;
+}
+
+
+static MemTxResult flexspi_write(void *opaque, hwaddr addr,
+                                      uint64_t value, unsigned size,
+                                      MemTxAttrs attrs)
+{
+    static FLEXSPI_REGISTER_WMASK_ARRAY(wmask);
+    FlexSpiState *s = opaque;
+
+    trace_flexspi_reg_write(DEVICE(s)->id, reg_names[addr / 4], addr, value);
+
+    value &= wmask[addr / 4];
+
+    switch (addr) {
+    case A_FLEXSPI_MCR0:
+    {
+        s->regs[addr / 4] = value;
+
+        if (RF_RD(s, MCR0, SWRESET)) {
+            RF_WR(s, MCR0, SWRESET, 0);
+        }
+        break;
+    }
+    case A_FLEXSPI_INTR:
+    {
+        /* fake SPI transfer completion */
+        RF_WR(s, INTR, IPCMDDONE, 1);
+        break;
+    }
+
+    default:
+        s->regs[addr / 4] = value;
+        break;
+    }
+
+    return MEMTX_OK;
+}
+
+static const MemoryRegionOps flexspi_ops = {
+    .read_with_attrs = flexspi_read,
+    .write_with_attrs = flexspi_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .max_access_size = 4,
+        .min_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static Property flexspi_properties[] = {
+    DEFINE_PROP_UINT64("mmap_size", FlexSpiState, mmap_size, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void flexspi_init(Object *obj)
+{
+    FlexSpiState *s = FLEXSPI(obj);
+
+    memory_region_init_io(&s->mmio, obj, &flexspi_ops, s, TYPE_FLEXSPI,
+                          sizeof(s->regs));
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+}
+
+static void flexspi_realize(DeviceState *dev, Error **errp)
+{
+    FlexSpiState *s = FLEXSPI(dev);
+
+    if (s->mmap_size) {
+        memory_region_init_ram(&s->mem, OBJECT(s), DEVICE(s)->id, s->mmap_size,
+                               NULL);
+        sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->mem);
+    }
+}
+
+static void flexspi_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = flexspi_reset;
+    dc->realize = flexspi_realize;
+    device_class_set_props(dc, flexspi_properties);
+}
+
+static const TypeInfo flexspi_types[] = {
+    {
+        .name          = TYPE_FLEXSPI,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(FlexSpiState),
+        .instance_init = flexspi_init,
+        .class_init    = flexspi_class_init,
+    },
+};
+
+DEFINE_TYPES(flexspi_types);
diff --git a/hw/arm/svd/meson.build b/hw/arm/svd/meson.build
index d017010b73..7e59eda0d3 100644
--- a/hw/arm/svd/meson.build
+++ b/hw/arm/svd/meson.build
@@ -19,4 +19,7 @@ if get_option('mcux-soc-svd')
   run_target('svd-rt500-clkctl1', command: svd_gen_header +
     [ '-i', rt595, '-o', '@SOURCE_ROOT@/include/hw/arm/svd/rt500_clkctl1.h',
       '-p', 'CLKCTL1', '-t', 'RT500_CLKCTL1'])
+  run_target('svd-flexspi', command: svd_gen_header +
+    [ '-i', rt595, '-o', '@SOURCE_ROOT@/include/hw/arm/svd/flexspi.h',
+      '-p', 'FLEXSPI0', '-t', 'FLEXSPI'])
 endif
diff --git a/hw/ssi/Kconfig b/hw/ssi/Kconfig
index 83ee53c1d0..fb8feeb024 100644
--- a/hw/ssi/Kconfig
+++ b/hw/ssi/Kconfig
@@ -24,3 +24,7 @@ config STM32F2XX_SPI
 config BCM2835_SPI
     bool
     select SSI
+
+config FLEXSPI
+    bool
+    select SSI
diff --git a/hw/ssi/meson.build b/hw/ssi/meson.build
index 57d3e14727..c5b7e0a6e2 100644
--- a/hw/ssi/meson.build
+++ b/hw/ssi/meson.build
@@ -13,3 +13,4 @@ system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_spi.c'))
 system_ss.add(when: 'CONFIG_IBEX', if_true: files('ibex_spi_host.c'))
 system_ss.add(when: 'CONFIG_BCM2835_SPI', if_true: files('bcm2835_spi.c'))
 system_ss.add(when: 'CONFIG_FLEXCOMM', if_true: files('flexcomm_spi.c'))
+system_ss.add(when: 'CONFIG_FLEXSPI', if_true: files('flexspi.c'))
diff --git a/hw/ssi/trace-events b/hw/ssi/trace-events
index 5caa1c17ac..d623022a79 100644
--- a/hw/ssi/trace-events
+++ b/hw/ssi/trace-events
@@ -40,3 +40,7 @@ flexcomm_spi_fifostat(const char *id, uint32_t fifostat, uint32_t fifoinstat) "%
 flexcomm_spi_irq(const char *id, bool irq, bool fifoirqs, bool perirqs, bool enabled) "%s: %d %d %d %d"
 flexcomm_spi_chr_rx_space(const char *id, uint32_t rx) "%s: %d"
 flexcomm_spi_chr_rx(const char *id) "%s"
+
+# flexspi.c
+flexspi_reg_read(const char *id, const char *reg_name, uint32_t addr, uint32_t val) " %s: %s[0x%04x] -> 0x%08x"
+flexspi_reg_write(const char *id, const char *reg_name, uint32_t addr, uint32_t val) "%s: %s[0x%04x] <- 0x%08x"
-- 
2.46.0.184.g6999bdac58-goog


