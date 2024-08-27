Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7983C5320E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 06:49:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sipyQ-0004vF-GV; Tue, 27 Aug 2024 02:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3HXbNZgUKCnwyf0nulttlqj.htrvjrz-ij0jqstslsz.twl@flex--tavip.bounces.google.com>)
 id 1sipy7-000417-Co
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 02:46:31 -0400
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3HXbNZgUKCnwyf0nulttlqj.htrvjrz-ij0jqstslsz.twl@flex--tavip.bounces.google.com>)
 id 1sipxh-00067h-Q1
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 02:46:04 -0400
Received: by mail-pj1-x1049.google.com with SMTP id
 98e67ed59e1d1-2d5dafe951eso5864702a91.3
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 23:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1724741151; x=1725345951; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=3+5tp6qRSt5nO/Adw6qruy8dPAUtFWiexzZXKlGvbak=;
 b=Zs5B1sZliFaOqyaz2fYHLgQdqaBU3nwZQAygRN8UxfiRjibml1tX2RPj48U8V68U7X
 jQNa/5We1Uar54BlR6+2im4e0TvS3IE8gbBn3shHHyC4RgwfkSVHAw6S6aGOwB60Qv76
 qm0o7YqBLAWhbmZESTqhOjy3iIDNMmD4gAP4DKcMUnd7XAJUuelyIi1+4fZ27E2APLeY
 FpLskOxAPcMYdzPRgYsAPRrUSAK9ErL7SFzINQDWcJtlrBYYb92PH6OpEKXi61ZE62/N
 TiPi8w94fCxM3DmhsW6LMQbN2ZZCfp58aKpOzUnX+31xoMw32b7RHsC9K0S5471e8AFp
 iuNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724741151; x=1725345951;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3+5tp6qRSt5nO/Adw6qruy8dPAUtFWiexzZXKlGvbak=;
 b=lPPSlwbJTXMKonn+dMWl6xuaS7ZhE+IE040jOXZ5P3wUwo2RbVRJXYWzyE/7hjgabx
 Kd/efe7iLF7SjftOnc1RMBdW8ZJqlHhnFqv+5AN9V0lVX+TC0HTDCqqu9g2+adWW1NfZ
 FEQm4535sYPqC8eb8I22LftKIWqf9fYqnPlqz9d9rwZbHy9mkm3faipViz69K27XCZ0o
 Tgeb6zvxL39ffOWvDVfBRAj3DL/OwU3eMjug1lQhq6eAzD0GjIZJ4rqRb2VHA+drj+Yq
 IkSlLAvHCreAtyMnwA66Qr8XB2VE0lEAQVlSdwKX02rfUR1k9Ln9EoptUwQcs2EOPKHR
 +rNQ==
X-Gm-Message-State: AOJu0Yyjq5HyY5JkyHF5uZ0mThYN7JSB2fPHFj57KSvq8iUG6DLrqtyH
 sUO81tyvrtWu1H4pboV6yIdFaJQ+VwcUOmpxp1doljscEzcd1j0Xj4qPhWtLxJI2twMPDZG3Qa8
 eEMOMYMTTdFE6RpXf18mvnh40RZyFJZQqJFZMSsKSeAFAotDvoEi/GUUXt8IhKIGNhzarYfVum+
 0U9OTKi0PKJyGHbatir7xhNNkjpQ==
X-Google-Smtp-Source: AGHT+IGigLAsy02kDyPnKwCTdTDCXWOolHdJWTfDWcbDrigzQeBGRDBZHYRuuKSf6M17wDCIzX3YS9TVDg==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a17:902:d486:b0:202:3019:210a
 with SMTP id
 d9443c01a7336-2039e478cc7mr12694425ad.3.1724741149663; Mon, 26 Aug 2024
 23:45:49 -0700 (PDT)
Date: Mon, 26 Aug 2024 23:45:14 -0700
In-Reply-To: <20240827064529.1246786-1-tavip@google.com>
Mime-Version: 1.0
References: <20240827064529.1246786-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240827064529.1246786-11-tavip@google.com>
Subject: [RFC PATCH v3 10/24] hw/ssi: add support for flexspi
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr, 
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org, jsnow@redhat.com, 
 crosa@redhat.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1049;
 envelope-from=3HXbNZgUKCnwyf0nulttlqj.htrvjrz-ij0jqstslsz.twl@flex--tavip.bounces.google.com;
 helo=mail-pj1-x1049.google.com
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
 include/hw/arm/svd/flexspi.h | 2658 ++++++++++++++++++++++++++++++++++
 include/hw/ssi/flexspi.h     |   32 +
 hw/ssi/flexspi.c             |  169 +++
 hw/arm/svd/meson.build       |    3 +
 hw/ssi/Kconfig               |    4 +
 hw/ssi/meson.build           |    1 +
 hw/ssi/trace-events          |    4 +
 7 files changed, 2871 insertions(+)
 create mode 100644 include/hw/arm/svd/flexspi.h
 create mode 100644 include/hw/ssi/flexspi.h
 create mode 100644 hw/ssi/flexspi.c

diff --git a/include/hw/arm/svd/flexspi.h b/include/hw/arm/svd/flexspi.h
new file mode 100644
index 0000000000..1599884c5f
--- /dev/null
+++ b/include/hw/arm/svd/flexspi.h
@@ -0,0 +1,2658 @@
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
+#define FLEXSPI_REGISTER_ACCESS_INFO_ARRAY(_name) \
+    struct RegisterAccessInfo _name[FLEXSPI_REGS_NO] = { \
+        [0 ... FLEXSPI_REGS_NO - 1] = { \
+            .name = "", \
+            .addr = -1, \
+        }, \
+        [R_FLEXSPI_MCR0] = { \
+            .name = "MCR0", \
+            .addr = 0x0, \
+            .ro = 0x20CC, \
+            .reset = 0xFFFF80C2, \
+        }, \
+        [R_FLEXSPI_MCR1] = { \
+            .name = "MCR1", \
+            .addr = 0x4, \
+            .ro = 0x0, \
+            .reset = 0xFFFFFFFF, \
+        }, \
+        [R_FLEXSPI_MCR2] = { \
+            .name = "MCR2", \
+            .addr = 0x8, \
+            .ro = 0xFF37FF, \
+            .reset = 0x200081F7, \
+        }, \
+        [R_FLEXSPI_AHBCR] = { \
+            .name = "AHBCR", \
+            .addr = 0xC, \
+            .ro = 0xFFFFFB02, \
+            .reset = 0x18, \
+        }, \
+        [R_FLEXSPI_INTEN] = { \
+            .name = "INTEN", \
+            .addr = 0x10, \
+            .ro = 0xFFFFC000, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_INTR] = { \
+            .name = "INTR", \
+            .addr = 0x14, \
+            .ro = 0xFFFFE000, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUTKEY] = { \
+            .name = "LUTKEY", \
+            .addr = 0x18, \
+            .ro = 0x0, \
+            .reset = 0x5AF05AF0, \
+        }, \
+        [R_FLEXSPI_LUTCR] = { \
+            .name = "LUTCR", \
+            .addr = 0x1C, \
+            .ro = 0xFFFFFFFC, \
+            .reset = 0x2, \
+        }, \
+        [R_FLEXSPI_AHBRXBUF0CR0] = { \
+            .name = "AHBRXBUF0CR0", \
+            .addr = 0x20, \
+            .ro = 0x78F0FF00, \
+            .reset = 0x80000010, \
+        }, \
+        [R_FLEXSPI_AHBRXBUF1CR0] = { \
+            .name = "AHBRXBUF1CR0", \
+            .addr = 0x24, \
+            .ro = 0x78F0FF00, \
+            .reset = 0x80010010, \
+        }, \
+        [R_FLEXSPI_AHBRXBUF2CR0] = { \
+            .name = "AHBRXBUF2CR0", \
+            .addr = 0x28, \
+            .ro = 0x78F0FF00, \
+            .reset = 0x80020010, \
+        }, \
+        [R_FLEXSPI_AHBRXBUF3CR0] = { \
+            .name = "AHBRXBUF3CR0", \
+            .addr = 0x2C, \
+            .ro = 0x78F0FF00, \
+            .reset = 0x80030010, \
+        }, \
+        [R_FLEXSPI_AHBRXBUF4CR0] = { \
+            .name = "AHBRXBUF4CR0", \
+            .addr = 0x30, \
+            .ro = 0x78F0FF00, \
+            .reset = 0x80040010, \
+        }, \
+        [R_FLEXSPI_AHBRXBUF5CR0] = { \
+            .name = "AHBRXBUF5CR0", \
+            .addr = 0x34, \
+            .ro = 0x78F0FF00, \
+            .reset = 0x80050010, \
+        }, \
+        [R_FLEXSPI_AHBRXBUF6CR0] = { \
+            .name = "AHBRXBUF6CR0", \
+            .addr = 0x38, \
+            .ro = 0x78F0FF00, \
+            .reset = 0x80060010, \
+        }, \
+        [R_FLEXSPI_AHBRXBUF7CR0] = { \
+            .name = "AHBRXBUF7CR0", \
+            .addr = 0x3C, \
+            .ro = 0x78F0FF00, \
+            .reset = 0x80070010, \
+        }, \
+        [R_FLEXSPI_FLSHA1CR0] = { \
+            .name = "FLSHA1CR0", \
+            .addr = 0x60, \
+            .ro = 0xFF800000, \
+            .reset = 0x10000, \
+        }, \
+        [R_FLEXSPI_FLSHA2CR0] = { \
+            .name = "FLSHA2CR0", \
+            .addr = 0x64, \
+            .ro = 0xFF800000, \
+            .reset = 0x10000, \
+        }, \
+        [R_FLEXSPI_FLSHB1CR0] = { \
+            .name = "FLSHB1CR0", \
+            .addr = 0x68, \
+            .ro = 0xFF800000, \
+            .reset = 0x10000, \
+        }, \
+        [R_FLEXSPI_FLSHB2CR0] = { \
+            .name = "FLSHB2CR0", \
+            .addr = 0x6C, \
+            .ro = 0xFF800000, \
+            .reset = 0x10000, \
+        }, \
+        [R_FLEXSPI_FLSHCR1A1] = { \
+            .name = "FLSHCR1A1", \
+            .addr = 0x70, \
+            .ro = 0x0, \
+            .reset = 0x63, \
+        }, \
+        [R_FLEXSPI_FLSHCR1A2] = { \
+            .name = "FLSHCR1A2", \
+            .addr = 0x74, \
+            .ro = 0x0, \
+            .reset = 0x63, \
+        }, \
+        [R_FLEXSPI_FLSHCR1B1] = { \
+            .name = "FLSHCR1B1", \
+            .addr = 0x78, \
+            .ro = 0x0, \
+            .reset = 0x63, \
+        }, \
+        [R_FLEXSPI_FLSHCR1B2] = { \
+            .name = "FLSHCR1B2", \
+            .addr = 0x7C, \
+            .ro = 0x0, \
+            .reset = 0x63, \
+        }, \
+        [R_FLEXSPI_FLSHCR2A1] = { \
+            .name = "FLSHCR2A1", \
+            .addr = 0x80, \
+            .ro = 0x1010, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_FLSHCR2A2] = { \
+            .name = "FLSHCR2A2", \
+            .addr = 0x84, \
+            .ro = 0x1010, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_FLSHCR2B1] = { \
+            .name = "FLSHCR2B1", \
+            .addr = 0x88, \
+            .ro = 0x1010, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_FLSHCR2B2] = { \
+            .name = "FLSHCR2B2", \
+            .addr = 0x8C, \
+            .ro = 0x1010, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_FLSHCR4] = { \
+            .name = "FLSHCR4", \
+            .addr = 0x94, \
+            .ro = 0xFFFFFFFA, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_IPCR0] = { \
+            .name = "IPCR0", \
+            .addr = 0xA0, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_IPCR1] = { \
+            .name = "IPCR1", \
+            .addr = 0xA4, \
+            .ro = 0x78F00000, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_IPCMD] = { \
+            .name = "IPCMD", \
+            .addr = 0xB0, \
+            .ro = 0xFFFFFFFE, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_DLPR] = { \
+            .name = "DLPR", \
+            .addr = 0xB4, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_IPRXFCR] = { \
+            .name = "IPRXFCR", \
+            .addr = 0xB8, \
+            .ro = 0xFFFFFE00, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_IPTXFCR] = { \
+            .name = "IPTXFCR", \
+            .addr = 0xBC, \
+            .ro = 0xFFFFFE00, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_DLLCRA] = { \
+            .name = "DLLCRA", \
+            .addr = 0xC0, \
+            .ro = 0xFFFF8084, \
+            .reset = 0x100, \
+        }, \
+        [R_FLEXSPI_DLLCRB] = { \
+            .name = "DLLCRB", \
+            .addr = 0xC4, \
+            .ro = 0xFFFF8084, \
+            .reset = 0x100, \
+        }, \
+        [R_FLEXSPI_STS0] = { \
+            .name = "STS0", \
+            .addr = 0xE0, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x2, \
+        }, \
+        [R_FLEXSPI_STS1] = { \
+            .name = "STS1", \
+            .addr = 0xE4, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_STS2] = { \
+            .name = "STS2", \
+            .addr = 0xE8, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x1000100, \
+        }, \
+        [R_FLEXSPI_AHBSPNDSTS] = { \
+            .name = "AHBSPNDSTS", \
+            .addr = 0xEC, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_IPRXFSTS] = { \
+            .name = "IPRXFSTS", \
+            .addr = 0xF0, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_IPTXFSTS] = { \
+            .name = "IPTXFSTS", \
+            .addr = 0xF4, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_RFDR0] = { \
+            .name = "RFDR0", \
+            .addr = 0x100, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_RFDR1] = { \
+            .name = "RFDR1", \
+            .addr = 0x104, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_RFDR2] = { \
+            .name = "RFDR2", \
+            .addr = 0x108, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_RFDR3] = { \
+            .name = "RFDR3", \
+            .addr = 0x10C, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_RFDR4] = { \
+            .name = "RFDR4", \
+            .addr = 0x110, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_RFDR5] = { \
+            .name = "RFDR5", \
+            .addr = 0x114, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_RFDR6] = { \
+            .name = "RFDR6", \
+            .addr = 0x118, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_RFDR7] = { \
+            .name = "RFDR7", \
+            .addr = 0x11C, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_RFDR8] = { \
+            .name = "RFDR8", \
+            .addr = 0x120, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_RFDR9] = { \
+            .name = "RFDR9", \
+            .addr = 0x124, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_RFDR10] = { \
+            .name = "RFDR10", \
+            .addr = 0x128, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_RFDR11] = { \
+            .name = "RFDR11", \
+            .addr = 0x12C, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_RFDR12] = { \
+            .name = "RFDR12", \
+            .addr = 0x130, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_RFDR13] = { \
+            .name = "RFDR13", \
+            .addr = 0x134, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_RFDR14] = { \
+            .name = "RFDR14", \
+            .addr = 0x138, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_RFDR15] = { \
+            .name = "RFDR15", \
+            .addr = 0x13C, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_RFDR16] = { \
+            .name = "RFDR16", \
+            .addr = 0x140, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_RFDR17] = { \
+            .name = "RFDR17", \
+            .addr = 0x144, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_RFDR18] = { \
+            .name = "RFDR18", \
+            .addr = 0x148, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_RFDR19] = { \
+            .name = "RFDR19", \
+            .addr = 0x14C, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_RFDR20] = { \
+            .name = "RFDR20", \
+            .addr = 0x150, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_RFDR21] = { \
+            .name = "RFDR21", \
+            .addr = 0x154, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_RFDR22] = { \
+            .name = "RFDR22", \
+            .addr = 0x158, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_RFDR23] = { \
+            .name = "RFDR23", \
+            .addr = 0x15C, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_RFDR24] = { \
+            .name = "RFDR24", \
+            .addr = 0x160, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_RFDR25] = { \
+            .name = "RFDR25", \
+            .addr = 0x164, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_RFDR26] = { \
+            .name = "RFDR26", \
+            .addr = 0x168, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_RFDR27] = { \
+            .name = "RFDR27", \
+            .addr = 0x16C, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_RFDR28] = { \
+            .name = "RFDR28", \
+            .addr = 0x170, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_RFDR29] = { \
+            .name = "RFDR29", \
+            .addr = 0x174, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_RFDR30] = { \
+            .name = "RFDR30", \
+            .addr = 0x178, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_RFDR31] = { \
+            .name = "RFDR31", \
+            .addr = 0x17C, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_TFDR0] = { \
+            .name = "TFDR0", \
+            .addr = 0x180, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_TFDR1] = { \
+            .name = "TFDR1", \
+            .addr = 0x184, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_TFDR2] = { \
+            .name = "TFDR2", \
+            .addr = 0x188, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_TFDR3] = { \
+            .name = "TFDR3", \
+            .addr = 0x18C, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_TFDR4] = { \
+            .name = "TFDR4", \
+            .addr = 0x190, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_TFDR5] = { \
+            .name = "TFDR5", \
+            .addr = 0x194, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_TFDR6] = { \
+            .name = "TFDR6", \
+            .addr = 0x198, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_TFDR7] = { \
+            .name = "TFDR7", \
+            .addr = 0x19C, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_TFDR8] = { \
+            .name = "TFDR8", \
+            .addr = 0x1A0, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_TFDR9] = { \
+            .name = "TFDR9", \
+            .addr = 0x1A4, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_TFDR10] = { \
+            .name = "TFDR10", \
+            .addr = 0x1A8, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_TFDR11] = { \
+            .name = "TFDR11", \
+            .addr = 0x1AC, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_TFDR12] = { \
+            .name = "TFDR12", \
+            .addr = 0x1B0, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_TFDR13] = { \
+            .name = "TFDR13", \
+            .addr = 0x1B4, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_TFDR14] = { \
+            .name = "TFDR14", \
+            .addr = 0x1B8, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_TFDR15] = { \
+            .name = "TFDR15", \
+            .addr = 0x1BC, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_TFDR16] = { \
+            .name = "TFDR16", \
+            .addr = 0x1C0, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_TFDR17] = { \
+            .name = "TFDR17", \
+            .addr = 0x1C4, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_TFDR18] = { \
+            .name = "TFDR18", \
+            .addr = 0x1C8, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_TFDR19] = { \
+            .name = "TFDR19", \
+            .addr = 0x1CC, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_TFDR20] = { \
+            .name = "TFDR20", \
+            .addr = 0x1D0, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_TFDR21] = { \
+            .name = "TFDR21", \
+            .addr = 0x1D4, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_TFDR22] = { \
+            .name = "TFDR22", \
+            .addr = 0x1D8, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_TFDR23] = { \
+            .name = "TFDR23", \
+            .addr = 0x1DC, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_TFDR24] = { \
+            .name = "TFDR24", \
+            .addr = 0x1E0, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_TFDR25] = { \
+            .name = "TFDR25", \
+            .addr = 0x1E4, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_TFDR26] = { \
+            .name = "TFDR26", \
+            .addr = 0x1E8, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_TFDR27] = { \
+            .name = "TFDR27", \
+            .addr = 0x1EC, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_TFDR28] = { \
+            .name = "TFDR28", \
+            .addr = 0x1F0, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_TFDR29] = { \
+            .name = "TFDR29", \
+            .addr = 0x1F4, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_TFDR30] = { \
+            .name = "TFDR30", \
+            .addr = 0x1F8, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_TFDR31] = { \
+            .name = "TFDR31", \
+            .addr = 0x1FC, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT0] = { \
+            .name = "LUT0", \
+            .addr = 0x200, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT1] = { \
+            .name = "LUT1", \
+            .addr = 0x204, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT2] = { \
+            .name = "LUT2", \
+            .addr = 0x208, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT3] = { \
+            .name = "LUT3", \
+            .addr = 0x20C, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT4] = { \
+            .name = "LUT4", \
+            .addr = 0x210, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT5] = { \
+            .name = "LUT5", \
+            .addr = 0x214, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT6] = { \
+            .name = "LUT6", \
+            .addr = 0x218, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT7] = { \
+            .name = "LUT7", \
+            .addr = 0x21C, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT8] = { \
+            .name = "LUT8", \
+            .addr = 0x220, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT9] = { \
+            .name = "LUT9", \
+            .addr = 0x224, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT10] = { \
+            .name = "LUT10", \
+            .addr = 0x228, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT11] = { \
+            .name = "LUT11", \
+            .addr = 0x22C, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT12] = { \
+            .name = "LUT12", \
+            .addr = 0x230, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT13] = { \
+            .name = "LUT13", \
+            .addr = 0x234, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT14] = { \
+            .name = "LUT14", \
+            .addr = 0x238, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT15] = { \
+            .name = "LUT15", \
+            .addr = 0x23C, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT16] = { \
+            .name = "LUT16", \
+            .addr = 0x240, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT17] = { \
+            .name = "LUT17", \
+            .addr = 0x244, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT18] = { \
+            .name = "LUT18", \
+            .addr = 0x248, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT19] = { \
+            .name = "LUT19", \
+            .addr = 0x24C, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT20] = { \
+            .name = "LUT20", \
+            .addr = 0x250, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT21] = { \
+            .name = "LUT21", \
+            .addr = 0x254, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT22] = { \
+            .name = "LUT22", \
+            .addr = 0x258, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT23] = { \
+            .name = "LUT23", \
+            .addr = 0x25C, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT24] = { \
+            .name = "LUT24", \
+            .addr = 0x260, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT25] = { \
+            .name = "LUT25", \
+            .addr = 0x264, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT26] = { \
+            .name = "LUT26", \
+            .addr = 0x268, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT27] = { \
+            .name = "LUT27", \
+            .addr = 0x26C, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT28] = { \
+            .name = "LUT28", \
+            .addr = 0x270, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT29] = { \
+            .name = "LUT29", \
+            .addr = 0x274, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT30] = { \
+            .name = "LUT30", \
+            .addr = 0x278, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT31] = { \
+            .name = "LUT31", \
+            .addr = 0x27C, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT32] = { \
+            .name = "LUT32", \
+            .addr = 0x280, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT33] = { \
+            .name = "LUT33", \
+            .addr = 0x284, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT34] = { \
+            .name = "LUT34", \
+            .addr = 0x288, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT35] = { \
+            .name = "LUT35", \
+            .addr = 0x28C, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT36] = { \
+            .name = "LUT36", \
+            .addr = 0x290, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT37] = { \
+            .name = "LUT37", \
+            .addr = 0x294, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT38] = { \
+            .name = "LUT38", \
+            .addr = 0x298, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT39] = { \
+            .name = "LUT39", \
+            .addr = 0x29C, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT40] = { \
+            .name = "LUT40", \
+            .addr = 0x2A0, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT41] = { \
+            .name = "LUT41", \
+            .addr = 0x2A4, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT42] = { \
+            .name = "LUT42", \
+            .addr = 0x2A8, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT43] = { \
+            .name = "LUT43", \
+            .addr = 0x2AC, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT44] = { \
+            .name = "LUT44", \
+            .addr = 0x2B0, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT45] = { \
+            .name = "LUT45", \
+            .addr = 0x2B4, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT46] = { \
+            .name = "LUT46", \
+            .addr = 0x2B8, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT47] = { \
+            .name = "LUT47", \
+            .addr = 0x2BC, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT48] = { \
+            .name = "LUT48", \
+            .addr = 0x2C0, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT49] = { \
+            .name = "LUT49", \
+            .addr = 0x2C4, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT50] = { \
+            .name = "LUT50", \
+            .addr = 0x2C8, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT51] = { \
+            .name = "LUT51", \
+            .addr = 0x2CC, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT52] = { \
+            .name = "LUT52", \
+            .addr = 0x2D0, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT53] = { \
+            .name = "LUT53", \
+            .addr = 0x2D4, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT54] = { \
+            .name = "LUT54", \
+            .addr = 0x2D8, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT55] = { \
+            .name = "LUT55", \
+            .addr = 0x2DC, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT56] = { \
+            .name = "LUT56", \
+            .addr = 0x2E0, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT57] = { \
+            .name = "LUT57", \
+            .addr = 0x2E4, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT58] = { \
+            .name = "LUT58", \
+            .addr = 0x2E8, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT59] = { \
+            .name = "LUT59", \
+            .addr = 0x2EC, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT60] = { \
+            .name = "LUT60", \
+            .addr = 0x2F0, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT61] = { \
+            .name = "LUT61", \
+            .addr = 0x2F4, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT62] = { \
+            .name = "LUT62", \
+            .addr = 0x2F8, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_LUT63] = { \
+            .name = "LUT63", \
+            .addr = 0x2FC, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_HADDRSTART] = { \
+            .name = "HADDRSTART", \
+            .addr = 0x420, \
+            .ro = 0xFFE, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_HADDREND] = { \
+            .name = "HADDREND", \
+            .addr = 0x424, \
+            .ro = 0xFFF, \
+            .reset = 0x0, \
+        }, \
+        [R_FLEXSPI_HADDROFFSET] = { \
+            .name = "HADDROFFSET", \
+            .addr = 0x428, \
+            .ro = 0xFFF, \
+            .reset = 0x0, \
+        }, \
+    }
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
index 0000000000..55f493caa1
--- /dev/null
+++ b/hw/ssi/flexspi.c
@@ -0,0 +1,169 @@
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
+static FLEXSPI_REGISTER_ACCESS_INFO_ARRAY(reg_info);
+
+static void flexspi_reset(DeviceState *dev)
+{
+    FlexSpiState *s = FLEXSPI(dev);
+
+    for (int i = 0; i < FLEXSPI_REGS_NO; i++) {
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
+    /* idle immediately after reset */
+    RF_WR(s, STS0, SEQIDLE, 1);
+}
+
+static MemTxResult flexspi_read(void *opaque, hwaddr addr,
+                                     uint64_t *data, unsigned size,
+                                     MemTxAttrs attrs)
+{
+    FlexSpiState *s = opaque;
+    const struct RegisterAccessInfo *rai = &reg_info[addr / 4];
+    MemTxResult ret = MEMTX_OK;
+
+    switch (addr) {
+    default:
+        *data = s->regs[addr / 4];
+        break;
+    }
+
+    trace_flexspi_reg_read(DEVICE(s)->id, rai->name, addr, *data);
+    return ret;
+}
+
+
+static MemTxResult flexspi_write(void *opaque, hwaddr addr,
+                                      uint64_t value, unsigned size,
+                                      MemTxAttrs attrs)
+{
+    FlexSpiState *s = opaque;
+    const struct RegisterAccessInfo *rai = &reg_info[addr / 4];
+    struct RegisterInfo ri = {
+        .data = &s->regs[addr / 4],
+        .data_size = 4,
+        .access = rai,
+    };
+
+    trace_flexspi_reg_write(DEVICE(s)->id, rai->name, addr, value);
+
+    switch (addr) {
+    case A_FLEXSPI_MCR0:
+    {
+        register_write(&ri, value, ~0, NULL, false);
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
+    default:
+        register_write(&ri, value, ~0, NULL, false);
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
+        .min_access_size = 1,
+        .max_access_size = 4,
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
2.46.0.295.g3b9ea8a38a-goog


