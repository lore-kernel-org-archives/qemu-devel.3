Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86FE0CED24E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 01:24:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxyt5-0000Sy-MY; Mon, 07 Oct 2024 21:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3kYgEZwUKCvInUpcjaiiafY.WigkYgo-XYpYfhihaho.ila@flex--tavip.bounces.google.com>)
 id 1sxysi-0007rU-TT
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 21:19:21 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3kYgEZwUKCvInUpcjaiiafY.WigkYgo-XYpYfhihaho.ila@flex--tavip.bounces.google.com>)
 id 1sxyse-0000AH-3C
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 21:19:20 -0400
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-e28690bc290so7535228276.1
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 18:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1728350354; x=1728955154; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=0eZ20KWycrpoAWSK7v7xZhJPuQ4t9+MXTd5omboFwxE=;
 b=ayqP1iztqATkPL7eEDLYvjwruRwu8EIZADTsb8Uu3uppQUfSasSdSx/U007jqitfgg
 F470M+sif/tftqGUB7EBgHTBpEgO/sBDAmqns+quTtDsdyYqiM677VUAoLKVRXP6RYUc
 VSho5mQ5ocVB29boFRnMe+1hGQkGxaORyKluhGeh1e9+xm14+7Dh22cnWvYdHnqo1JL0
 kqPhngvF6q5a7Wkd9+yMadV1/b4UZYzFzq7PKdU0ufb7ywX504WVUDun0GOiSGJ1R4y5
 voL/fRGalzNp9zcK5qJ5B0u5tQdlYQPN0m9oEZ69piqKTr1VKylEouEUKk/fomRr+bV7
 tFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728350354; x=1728955154;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0eZ20KWycrpoAWSK7v7xZhJPuQ4t9+MXTd5omboFwxE=;
 b=P7+me+SYRX7LFkJPQqZIwTiJnXT3zI7H22Htz8Q+u8xCQjbVs9oSgwcCQFNIp1Ax9f
 thG9pgXBtjfkYKqdINdFug2Mw0UiukEJpZd77WAEHwmG3lbGQ7hcyM5ONwgoErCkTFYZ
 CI6r6+cs4jsJtk5eZqpZec6A5FC0nMScHIa/t4KqrZ155M8P/q/hTGz3PGoWPoIxJ0SD
 BQRoPfcZcRRoZ1+Ka3A4rFuG4BITAZjmAfv8RueUJWgq9/PSJX/aSsqQsB6M//Vff3Gr
 r1ecSWUZ+iyddGMfoIO1zD9UENO99M1Vhbe/TqUZufm58mXBkRBfLSzR6bAnVwc+ow9R
 7BTA==
X-Gm-Message-State: AOJu0YyG1BBNSplQs526F/+ewEPL0WvDdhQWq6TSpKacVnnWjujp018B
 JC49nEN3ZEtfMbILVPLG+3L0Ja0F/ACp7vuGizjkews4Xbrku6MhjlU7lTxiNoC7KlsTM529dar
 bXx/LIc2iLwc9fVgQAgD+Gmoy2IMRQGq5NE9O0Cg6+w9bxpAAnohnVb8dgwxvgW+MjtOsv59md3
 +k+sa6asmWZBMI9rqKCO8BSzXH2w==
X-Google-Smtp-Source: AGHT+IHSUmcJnw1C/+86tM9pY+DBOVdB9rYfekCN7zWgSpmD4h6ImtNtH8wO9EKcNCt9vM3jVhBUP7duBg==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a25:a444:0:b0:e13:e11c:507 with
 SMTP id
 3f1490d57ef6-e28936d614bmr11062276.3.1728350353966; Mon, 07 Oct 2024 18:19:13
 -0700 (PDT)
Date: Mon,  7 Oct 2024 18:18:37 -0700
In-Reply-To: <20241008011852.1439154-1-tavip@google.com>
Mime-Version: 1.0
References: <20241008011852.1439154-1-tavip@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241008011852.1439154-12-tavip@google.com>
Subject: [PATCH v2 11/25] hw/ssi: add support for flexspi
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr, 
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org, jsnow@redhat.com, 
 crosa@redhat.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3kYgEZwUKCvInUpcjaiiafY.WigkYgo-XYpYfhihaho.ila@flex--tavip.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.024,
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
 include/hw/arm/svd/flexspi.h | 1085 ++++++++++++++++++++++++++++++++++
 include/hw/ssi/flexspi.h     |   31 +
 hw/ssi/flexspi.c             |  181 ++++++
 hw/arm/svd/meson.build       |    4 +
 hw/ssi/Kconfig               |    4 +
 hw/ssi/meson.build           |    1 +
 hw/ssi/trace-events          |    4 +
 7 files changed, 1310 insertions(+)
 create mode 100644 include/hw/arm/svd/flexspi.h
 create mode 100644 include/hw/ssi/flexspi.h
 create mode 100644 hw/ssi/flexspi.c

diff --git a/include/hw/arm/svd/flexspi.h b/include/hw/arm/svd/flexspi.h
new file mode 100644
index 0000000000..6e7e715d51
--- /dev/null
+++ b/include/hw/arm/svd/flexspi.h
@@ -0,0 +1,1085 @@
+/*
+ * Copyright 2016-2023 NXP SPDX-License-Identifier: BSD-3-Clause
+ *
+ * Automatically generated by svd-gen-header.py from MIMXRT595S_cm33.xml
+ */
+#pragma once
+
+#include "hw/register.h"
+
+/* FlexSPI */
+#define FLEXSPI_REGS_NO (267)
+
+/* Module Control Register 0 */
+REG32(FLEXSPI_MCR0, 0x0);
+/* Software Reset */
+FIELD(FLEXSPI_MCR0, SWRESET, 0, 1);
+
+/* Interrupt Register */
+REG32(FLEXSPI_INTR, 0x14);
+/*
+ * IP triggered Command Sequences Execution finished interrupt. This interrupt
+ * is also generated when there is IPCMDGE or IPCMDERR interrupt generated.
+ */
+FIELD(FLEXSPI_INTR, IPCMDDONE, 0, 1);
+
+/* Status Register 0 */
+REG32(FLEXSPI_STS0, 0xE0);
+/*
+ * This status bit indicates the state machine in SEQ_CTL is idle and there is
+ * command sequence executing on FlexSPI interface.
+ */
+FIELD(FLEXSPI_STS0, SEQIDLE, 0, 1);
+
+
+#define FLEXSPI_REGISTER_ACCESS_INFO_ARRAY(_name) \
+    struct RegisterAccessInfo _name[FLEXSPI_REGS_NO] = { \
+        [0 ... FLEXSPI_REGS_NO - 1] = { \
+            .name = "", \
+            .addr = -1, \
+        }, \
+        [0x0] = { \
+            .name = "MCR0", \
+            .addr = 0x0, \
+            .ro = 0x20CC, \
+            .reset = 0xFFFF80C2, \
+        }, \
+        [0x1] = { \
+            .name = "MCR1", \
+            .addr = 0x4, \
+            .ro = 0x0, \
+            .reset = 0xFFFFFFFF, \
+        }, \
+        [0x2] = { \
+            .name = "MCR2", \
+            .addr = 0x8, \
+            .ro = 0xFF37FF, \
+            .reset = 0x200081F7, \
+        }, \
+        [0x3] = { \
+            .name = "AHBCR", \
+            .addr = 0xC, \
+            .ro = 0xFFFFFB02, \
+            .reset = 0x18, \
+        }, \
+        [0x4] = { \
+            .name = "INTEN", \
+            .addr = 0x10, \
+            .ro = 0xFFFFC000, \
+            .reset = 0x0, \
+        }, \
+        [0x5] = { \
+            .name = "INTR", \
+            .addr = 0x14, \
+            .ro = 0xFFFFE000, \
+            .reset = 0x0, \
+        }, \
+        [0x6] = { \
+            .name = "LUTKEY", \
+            .addr = 0x18, \
+            .ro = 0x0, \
+            .reset = 0x5AF05AF0, \
+        }, \
+        [0x7] = { \
+            .name = "LUTCR", \
+            .addr = 0x1C, \
+            .ro = 0xFFFFFFFC, \
+            .reset = 0x2, \
+        }, \
+        [0x8] = { \
+            .name = "AHBRXBUF0CR0", \
+            .addr = 0x20, \
+            .ro = 0x78F0FF00, \
+            .reset = 0x80000010, \
+        }, \
+        [0x9] = { \
+            .name = "AHBRXBUF1CR0", \
+            .addr = 0x24, \
+            .ro = 0x78F0FF00, \
+            .reset = 0x80010010, \
+        }, \
+        [0xA] = { \
+            .name = "AHBRXBUF2CR0", \
+            .addr = 0x28, \
+            .ro = 0x78F0FF00, \
+            .reset = 0x80020010, \
+        }, \
+        [0xB] = { \
+            .name = "AHBRXBUF3CR0", \
+            .addr = 0x2C, \
+            .ro = 0x78F0FF00, \
+            .reset = 0x80030010, \
+        }, \
+        [0xC] = { \
+            .name = "AHBRXBUF4CR0", \
+            .addr = 0x30, \
+            .ro = 0x78F0FF00, \
+            .reset = 0x80040010, \
+        }, \
+        [0xD] = { \
+            .name = "AHBRXBUF5CR0", \
+            .addr = 0x34, \
+            .ro = 0x78F0FF00, \
+            .reset = 0x80050010, \
+        }, \
+        [0xE] = { \
+            .name = "AHBRXBUF6CR0", \
+            .addr = 0x38, \
+            .ro = 0x78F0FF00, \
+            .reset = 0x80060010, \
+        }, \
+        [0xF] = { \
+            .name = "AHBRXBUF7CR0", \
+            .addr = 0x3C, \
+            .ro = 0x78F0FF00, \
+            .reset = 0x80070010, \
+        }, \
+        [0x18] = { \
+            .name = "FLSHA1CR0", \
+            .addr = 0x60, \
+            .ro = 0xFF800000, \
+            .reset = 0x10000, \
+        }, \
+        [0x19] = { \
+            .name = "FLSHA2CR0", \
+            .addr = 0x64, \
+            .ro = 0xFF800000, \
+            .reset = 0x10000, \
+        }, \
+        [0x1A] = { \
+            .name = "FLSHB1CR0", \
+            .addr = 0x68, \
+            .ro = 0xFF800000, \
+            .reset = 0x10000, \
+        }, \
+        [0x1B] = { \
+            .name = "FLSHB2CR0", \
+            .addr = 0x6C, \
+            .ro = 0xFF800000, \
+            .reset = 0x10000, \
+        }, \
+        [0x1C] = { \
+            .name = "FLSHCR1A1", \
+            .addr = 0x70, \
+            .ro = 0x0, \
+            .reset = 0x63, \
+        }, \
+        [0x1D] = { \
+            .name = "FLSHCR1A2", \
+            .addr = 0x74, \
+            .ro = 0x0, \
+            .reset = 0x63, \
+        }, \
+        [0x1E] = { \
+            .name = "FLSHCR1B1", \
+            .addr = 0x78, \
+            .ro = 0x0, \
+            .reset = 0x63, \
+        }, \
+        [0x1F] = { \
+            .name = "FLSHCR1B2", \
+            .addr = 0x7C, \
+            .ro = 0x0, \
+            .reset = 0x63, \
+        }, \
+        [0x20] = { \
+            .name = "FLSHCR2A1", \
+            .addr = 0x80, \
+            .ro = 0x1010, \
+            .reset = 0x0, \
+        }, \
+        [0x21] = { \
+            .name = "FLSHCR2A2", \
+            .addr = 0x84, \
+            .ro = 0x1010, \
+            .reset = 0x0, \
+        }, \
+        [0x22] = { \
+            .name = "FLSHCR2B1", \
+            .addr = 0x88, \
+            .ro = 0x1010, \
+            .reset = 0x0, \
+        }, \
+        [0x23] = { \
+            .name = "FLSHCR2B2", \
+            .addr = 0x8C, \
+            .ro = 0x1010, \
+            .reset = 0x0, \
+        }, \
+        [0x25] = { \
+            .name = "FLSHCR4", \
+            .addr = 0x94, \
+            .ro = 0xFFFFFFFA, \
+            .reset = 0x0, \
+        }, \
+        [0x28] = { \
+            .name = "IPCR0", \
+            .addr = 0xA0, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x29] = { \
+            .name = "IPCR1", \
+            .addr = 0xA4, \
+            .ro = 0x78F00000, \
+            .reset = 0x0, \
+        }, \
+        [0x2C] = { \
+            .name = "IPCMD", \
+            .addr = 0xB0, \
+            .ro = 0xFFFFFFFE, \
+            .reset = 0x0, \
+        }, \
+        [0x2D] = { \
+            .name = "DLPR", \
+            .addr = 0xB4, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x2E] = { \
+            .name = "IPRXFCR", \
+            .addr = 0xB8, \
+            .ro = 0xFFFFFE00, \
+            .reset = 0x0, \
+        }, \
+        [0x2F] = { \
+            .name = "IPTXFCR", \
+            .addr = 0xBC, \
+            .ro = 0xFFFFFE00, \
+            .reset = 0x0, \
+        }, \
+        [0x30] = { \
+            .name = "DLLCRA", \
+            .addr = 0xC0, \
+            .ro = 0xFFFF8084, \
+            .reset = 0x100, \
+        }, \
+        [0x31] = { \
+            .name = "DLLCRB", \
+            .addr = 0xC4, \
+            .ro = 0xFFFF8084, \
+            .reset = 0x100, \
+        }, \
+        [0x38] = { \
+            .name = "STS0", \
+            .addr = 0xE0, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x2, \
+        }, \
+        [0x39] = { \
+            .name = "STS1", \
+            .addr = 0xE4, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [0x3A] = { \
+            .name = "STS2", \
+            .addr = 0xE8, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x1000100, \
+        }, \
+        [0x3B] = { \
+            .name = "AHBSPNDSTS", \
+            .addr = 0xEC, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [0x3C] = { \
+            .name = "IPRXFSTS", \
+            .addr = 0xF0, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [0x3D] = { \
+            .name = "IPTXFSTS", \
+            .addr = 0xF4, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [0x40] = { \
+            .name = "RFDR0", \
+            .addr = 0x100, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [0x41] = { \
+            .name = "RFDR1", \
+            .addr = 0x104, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [0x42] = { \
+            .name = "RFDR2", \
+            .addr = 0x108, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [0x43] = { \
+            .name = "RFDR3", \
+            .addr = 0x10C, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [0x44] = { \
+            .name = "RFDR4", \
+            .addr = 0x110, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [0x45] = { \
+            .name = "RFDR5", \
+            .addr = 0x114, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [0x46] = { \
+            .name = "RFDR6", \
+            .addr = 0x118, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [0x47] = { \
+            .name = "RFDR7", \
+            .addr = 0x11C, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [0x48] = { \
+            .name = "RFDR8", \
+            .addr = 0x120, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [0x49] = { \
+            .name = "RFDR9", \
+            .addr = 0x124, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [0x4A] = { \
+            .name = "RFDR10", \
+            .addr = 0x128, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [0x4B] = { \
+            .name = "RFDR11", \
+            .addr = 0x12C, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [0x4C] = { \
+            .name = "RFDR12", \
+            .addr = 0x130, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [0x4D] = { \
+            .name = "RFDR13", \
+            .addr = 0x134, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [0x4E] = { \
+            .name = "RFDR14", \
+            .addr = 0x138, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [0x4F] = { \
+            .name = "RFDR15", \
+            .addr = 0x13C, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [0x50] = { \
+            .name = "RFDR16", \
+            .addr = 0x140, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [0x51] = { \
+            .name = "RFDR17", \
+            .addr = 0x144, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [0x52] = { \
+            .name = "RFDR18", \
+            .addr = 0x148, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [0x53] = { \
+            .name = "RFDR19", \
+            .addr = 0x14C, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [0x54] = { \
+            .name = "RFDR20", \
+            .addr = 0x150, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [0x55] = { \
+            .name = "RFDR21", \
+            .addr = 0x154, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [0x56] = { \
+            .name = "RFDR22", \
+            .addr = 0x158, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [0x57] = { \
+            .name = "RFDR23", \
+            .addr = 0x15C, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [0x58] = { \
+            .name = "RFDR24", \
+            .addr = 0x160, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [0x59] = { \
+            .name = "RFDR25", \
+            .addr = 0x164, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [0x5A] = { \
+            .name = "RFDR26", \
+            .addr = 0x168, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [0x5B] = { \
+            .name = "RFDR27", \
+            .addr = 0x16C, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [0x5C] = { \
+            .name = "RFDR28", \
+            .addr = 0x170, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [0x5D] = { \
+            .name = "RFDR29", \
+            .addr = 0x174, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [0x5E] = { \
+            .name = "RFDR30", \
+            .addr = 0x178, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [0x5F] = { \
+            .name = "RFDR31", \
+            .addr = 0x17C, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [0x60] = { \
+            .name = "TFDR0", \
+            .addr = 0x180, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x61] = { \
+            .name = "TFDR1", \
+            .addr = 0x184, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x62] = { \
+            .name = "TFDR2", \
+            .addr = 0x188, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x63] = { \
+            .name = "TFDR3", \
+            .addr = 0x18C, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x64] = { \
+            .name = "TFDR4", \
+            .addr = 0x190, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x65] = { \
+            .name = "TFDR5", \
+            .addr = 0x194, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x66] = { \
+            .name = "TFDR6", \
+            .addr = 0x198, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x67] = { \
+            .name = "TFDR7", \
+            .addr = 0x19C, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x68] = { \
+            .name = "TFDR8", \
+            .addr = 0x1A0, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x69] = { \
+            .name = "TFDR9", \
+            .addr = 0x1A4, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x6A] = { \
+            .name = "TFDR10", \
+            .addr = 0x1A8, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x6B] = { \
+            .name = "TFDR11", \
+            .addr = 0x1AC, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x6C] = { \
+            .name = "TFDR12", \
+            .addr = 0x1B0, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x6D] = { \
+            .name = "TFDR13", \
+            .addr = 0x1B4, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x6E] = { \
+            .name = "TFDR14", \
+            .addr = 0x1B8, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x6F] = { \
+            .name = "TFDR15", \
+            .addr = 0x1BC, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x70] = { \
+            .name = "TFDR16", \
+            .addr = 0x1C0, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x71] = { \
+            .name = "TFDR17", \
+            .addr = 0x1C4, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x72] = { \
+            .name = "TFDR18", \
+            .addr = 0x1C8, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x73] = { \
+            .name = "TFDR19", \
+            .addr = 0x1CC, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x74] = { \
+            .name = "TFDR20", \
+            .addr = 0x1D0, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x75] = { \
+            .name = "TFDR21", \
+            .addr = 0x1D4, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x76] = { \
+            .name = "TFDR22", \
+            .addr = 0x1D8, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x77] = { \
+            .name = "TFDR23", \
+            .addr = 0x1DC, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x78] = { \
+            .name = "TFDR24", \
+            .addr = 0x1E0, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x79] = { \
+            .name = "TFDR25", \
+            .addr = 0x1E4, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x7A] = { \
+            .name = "TFDR26", \
+            .addr = 0x1E8, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x7B] = { \
+            .name = "TFDR27", \
+            .addr = 0x1EC, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x7C] = { \
+            .name = "TFDR28", \
+            .addr = 0x1F0, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x7D] = { \
+            .name = "TFDR29", \
+            .addr = 0x1F4, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x7E] = { \
+            .name = "TFDR30", \
+            .addr = 0x1F8, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x7F] = { \
+            .name = "TFDR31", \
+            .addr = 0x1FC, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x80] = { \
+            .name = "LUT0", \
+            .addr = 0x200, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x81] = { \
+            .name = "LUT1", \
+            .addr = 0x204, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x82] = { \
+            .name = "LUT2", \
+            .addr = 0x208, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x83] = { \
+            .name = "LUT3", \
+            .addr = 0x20C, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x84] = { \
+            .name = "LUT4", \
+            .addr = 0x210, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x85] = { \
+            .name = "LUT5", \
+            .addr = 0x214, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x86] = { \
+            .name = "LUT6", \
+            .addr = 0x218, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x87] = { \
+            .name = "LUT7", \
+            .addr = 0x21C, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x88] = { \
+            .name = "LUT8", \
+            .addr = 0x220, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x89] = { \
+            .name = "LUT9", \
+            .addr = 0x224, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x8A] = { \
+            .name = "LUT10", \
+            .addr = 0x228, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x8B] = { \
+            .name = "LUT11", \
+            .addr = 0x22C, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x8C] = { \
+            .name = "LUT12", \
+            .addr = 0x230, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x8D] = { \
+            .name = "LUT13", \
+            .addr = 0x234, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x8E] = { \
+            .name = "LUT14", \
+            .addr = 0x238, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x8F] = { \
+            .name = "LUT15", \
+            .addr = 0x23C, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x90] = { \
+            .name = "LUT16", \
+            .addr = 0x240, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x91] = { \
+            .name = "LUT17", \
+            .addr = 0x244, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x92] = { \
+            .name = "LUT18", \
+            .addr = 0x248, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x93] = { \
+            .name = "LUT19", \
+            .addr = 0x24C, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x94] = { \
+            .name = "LUT20", \
+            .addr = 0x250, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x95] = { \
+            .name = "LUT21", \
+            .addr = 0x254, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x96] = { \
+            .name = "LUT22", \
+            .addr = 0x258, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x97] = { \
+            .name = "LUT23", \
+            .addr = 0x25C, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x98] = { \
+            .name = "LUT24", \
+            .addr = 0x260, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x99] = { \
+            .name = "LUT25", \
+            .addr = 0x264, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x9A] = { \
+            .name = "LUT26", \
+            .addr = 0x268, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x9B] = { \
+            .name = "LUT27", \
+            .addr = 0x26C, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x9C] = { \
+            .name = "LUT28", \
+            .addr = 0x270, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x9D] = { \
+            .name = "LUT29", \
+            .addr = 0x274, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x9E] = { \
+            .name = "LUT30", \
+            .addr = 0x278, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x9F] = { \
+            .name = "LUT31", \
+            .addr = 0x27C, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0xA0] = { \
+            .name = "LUT32", \
+            .addr = 0x280, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0xA1] = { \
+            .name = "LUT33", \
+            .addr = 0x284, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0xA2] = { \
+            .name = "LUT34", \
+            .addr = 0x288, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0xA3] = { \
+            .name = "LUT35", \
+            .addr = 0x28C, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0xA4] = { \
+            .name = "LUT36", \
+            .addr = 0x290, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0xA5] = { \
+            .name = "LUT37", \
+            .addr = 0x294, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0xA6] = { \
+            .name = "LUT38", \
+            .addr = 0x298, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0xA7] = { \
+            .name = "LUT39", \
+            .addr = 0x29C, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0xA8] = { \
+            .name = "LUT40", \
+            .addr = 0x2A0, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0xA9] = { \
+            .name = "LUT41", \
+            .addr = 0x2A4, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0xAA] = { \
+            .name = "LUT42", \
+            .addr = 0x2A8, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0xAB] = { \
+            .name = "LUT43", \
+            .addr = 0x2AC, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0xAC] = { \
+            .name = "LUT44", \
+            .addr = 0x2B0, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0xAD] = { \
+            .name = "LUT45", \
+            .addr = 0x2B4, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0xAE] = { \
+            .name = "LUT46", \
+            .addr = 0x2B8, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0xAF] = { \
+            .name = "LUT47", \
+            .addr = 0x2BC, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0xB0] = { \
+            .name = "LUT48", \
+            .addr = 0x2C0, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0xB1] = { \
+            .name = "LUT49", \
+            .addr = 0x2C4, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0xB2] = { \
+            .name = "LUT50", \
+            .addr = 0x2C8, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0xB3] = { \
+            .name = "LUT51", \
+            .addr = 0x2CC, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0xB4] = { \
+            .name = "LUT52", \
+            .addr = 0x2D0, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0xB5] = { \
+            .name = "LUT53", \
+            .addr = 0x2D4, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0xB6] = { \
+            .name = "LUT54", \
+            .addr = 0x2D8, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0xB7] = { \
+            .name = "LUT55", \
+            .addr = 0x2DC, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0xB8] = { \
+            .name = "LUT56", \
+            .addr = 0x2E0, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0xB9] = { \
+            .name = "LUT57", \
+            .addr = 0x2E4, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0xBA] = { \
+            .name = "LUT58", \
+            .addr = 0x2E8, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0xBB] = { \
+            .name = "LUT59", \
+            .addr = 0x2EC, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0xBC] = { \
+            .name = "LUT60", \
+            .addr = 0x2F0, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0xBD] = { \
+            .name = "LUT61", \
+            .addr = 0x2F4, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0xBE] = { \
+            .name = "LUT62", \
+            .addr = 0x2F8, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0xBF] = { \
+            .name = "LUT63", \
+            .addr = 0x2FC, \
+            .ro = 0x0, \
+            .reset = 0x0, \
+        }, \
+        [0x108] = { \
+            .name = "HADDRSTART", \
+            .addr = 0x420, \
+            .ro = 0xFFE, \
+            .reset = 0x0, \
+        }, \
+        [0x109] = { \
+            .name = "HADDREND", \
+            .addr = 0x424, \
+            .ro = 0xFFF, \
+            .reset = 0x0, \
+        }, \
+        [0x10A] = { \
+            .name = "HADDROFFSET", \
+            .addr = 0x428, \
+            .ro = 0xFFF, \
+            .reset = 0x0, \
+        }, \
+    }
diff --git a/include/hw/ssi/flexspi.h b/include/hw/ssi/flexspi.h
new file mode 100644
index 0000000000..51699e1ceb
--- /dev/null
+++ b/include/hw/ssi/flexspi.h
@@ -0,0 +1,31 @@
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
+    uint64_t mmap_size;
+} FlexSpiState;
+
+#endif /* HW_RT500_FLEXSPI_H */
diff --git a/hw/ssi/flexspi.c b/hw/ssi/flexspi.c
new file mode 100644
index 0000000000..d5d9e4f098
--- /dev/null
+++ b/hw/ssi/flexspi.c
@@ -0,0 +1,181 @@
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
+static void flexspi_reset_enter(Object *obj, ResetType type)
+{
+    FlexSpiState *s = FLEXSPI(obj);
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
+static const VMStateDescription vmstate_flexspi = {
+    .name = "flexspi",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, FlexSpiState, FLEXSPI_REGS_NO),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void flexspi_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    rc->phases.enter = flexspi_reset_enter;
+    dc->realize = flexspi_realize;
+    dc->vmsd = &vmstate_flexspi;
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
index 9c458b314c..adf0f8327a 100644
--- a/hw/arm/svd/meson.build
+++ b/hw/arm/svd/meson.build
@@ -24,4 +24,8 @@ if get_option('mcux-soc-svd')
     [ '-i', rt595, '-o', '@SOURCE_ROOT@/include/hw/arm/svd/rt500_clkctl1.h',
       '-p', 'CLKCTL1', '-t', 'RT500_CLKCTL1',
       '--fields', 'PSCCTL*:FlexIO AUDIOPLL0PFD OSEVENTTFCLKSEL'])
+  run_target('svd-flexspi', command: svd_gen_header +
+    [ '-i', rt595, '-o', '@SOURCE_ROOT@/include/hw/arm/svd/flexspi.h',
+      '-p', 'FLEXSPI0', '-t', 'FLEXSPI',
+      '--fields', 'STS0:SEQIDLE MCR0:SWRESET INTR:IPCMDDONE'])
 endif
diff --git a/hw/ssi/Kconfig b/hw/ssi/Kconfig
index 8d180de7cf..e3de40e6b6 100644
--- a/hw/ssi/Kconfig
+++ b/hw/ssi/Kconfig
@@ -28,3 +28,7 @@ config BCM2835_SPI
 config PNV_SPI
     bool
     select SSI
+
+config FLEXSPI
+    bool
+    select SSI
diff --git a/hw/ssi/meson.build b/hw/ssi/meson.build
index 58e0d14b37..31a2618d52 100644
--- a/hw/ssi/meson.build
+++ b/hw/ssi/meson.build
@@ -13,3 +13,4 @@ system_ss.add(when: 'CONFIG_IBEX', if_true: files('ibex_spi_host.c'))
 system_ss.add(when: 'CONFIG_BCM2835_SPI', if_true: files('bcm2835_spi.c'))
 system_ss.add(when: 'CONFIG_PNV_SPI', if_true: files('pnv_spi.c'))
 system_ss.add(when: 'CONFIG_FLEXCOMM', if_true: files('flexcomm_spi.c'))
+system_ss.add(when: 'CONFIG_FLEXSPI', if_true: files('flexspi.c'))
diff --git a/hw/ssi/trace-events b/hw/ssi/trace-events
index f849f1f8be..dd2f04cb22 100644
--- a/hw/ssi/trace-events
+++ b/hw/ssi/trace-events
@@ -58,3 +58,7 @@ pnv_spi_RDR_match(const char* result) "%s"
 flexcomm_spi_reg_read(const char *id, const char *reg_name, uint32_t addr, uint32_t val) " %s: %s[0x%04x] -> 0x%08x"
 flexcomm_spi_reg_write(const char *id, const char *reg_name, uint32_t addr, uint32_t val) "%s: %s[0x%04x] <- 0x%08x"
 flexcomm_spi_irq(const char *id, bool irq, bool fifoirqs, bool perirqs, bool enabled) "%s: %d %d %d %d"
+
+# flexspi.c
+flexspi_reg_read(const char *id, const char *reg_name, uint32_t addr, uint32_t val) " %s: %s[0x%04x] -> 0x%08x"
+flexspi_reg_write(const char *id, const char *reg_name, uint32_t addr, uint32_t val) "%s: %s[0x%04x] <- 0x%08x"
-- 
2.47.0.rc0.187.ge670bccf7e-goog


