Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E48CED24D
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 01:26:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxytI-00024Q-Fi; Mon, 07 Oct 2024 21:19:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3jIgEZwUKCu0iPkXeVddVaT.RdbfTbj-STkTacdcVcj.dgV@flex--tavip.bounces.google.com>)
 id 1sxysc-0007pC-VG
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 21:19:18 -0400
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3jIgEZwUKCu0iPkXeVddVaT.RdbfTbj-STkTacdcVcj.dgV@flex--tavip.bounces.google.com>)
 id 1sxysa-00009V-84
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 21:19:14 -0400
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-20c531e38a5so2135035ad.0
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 18:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1728350350; x=1728955150; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=8QRkphhXNdsPFrr6+C1WirROoZs1K34T9oRkyUJP42U=;
 b=aKIT0UZADk6D1kbWMMQNAEmdgkvQ82SV224drSOD1h5Zb/fjD8Tk4dpeQBuVtnUCHP
 IxJo9XOU0wd7GWDtKmLKyPQYBKCQ8/S0qgNJiKkh9+4ieAVgCa9geZCJ0SlcU67DWrzU
 5DD7rEQpUeGZHi020DWAFg0+N/GwtrXjpC5nkWfcsFQg6ESB/+W/bVfZ0h5B1tRwRICF
 syr1lyk5GeoJpjssvGKIIk3G407EZiMAQRFjs+qFJSZetaLsRinoXdOrDs8pB+VWyipf
 tyuo2YxLLprqglQHHI/eY3RLA4fTPeHP9phasntiVlkbxZwf50geSZT7Tm79K9b0ZtQl
 ZeBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728350350; x=1728955150;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8QRkphhXNdsPFrr6+C1WirROoZs1K34T9oRkyUJP42U=;
 b=tcbmIoH6vBSlP8XKrQG+DzrDkEiT6IdXViWVNaqcfMbOhf8WPZBHEPliUZ6/8yBzLm
 VCwBfUfzaXif1Zns+qLhRx6xGLbb1ou4eH90No1V/AZBkE8RRpH7C9zcder4FMpOqPKz
 UFajzdQmKPcdsWzpp+v7MBQj29MrGY8mDVJEHM2d0r2jfkqLweIqbqavPHVDz2VDmfFe
 8wEXrEt/Odu0kChPICC8eDKPzxLKPpC5NGmBQhX9o6elEi7fogx9ZKqP5bcisE5QHk57
 K0MHFtvCcfuQzC/J0ecaH4VlMIie2im5RPTJzFzHWRaxsl0imVu5l7ksMDWZS3vnPgBz
 q13Q==
X-Gm-Message-State: AOJu0Yzk9FZDqj3Nu1zE+DHaaVhlAvE8fJ0X6Uih1YWDpws+sIiVNZAX
 UUgYz00sw+ZSleXqziQXe2hwDPMUsU/qhg0VLZpJmFOCH3YTZ/G6cIbeZSM/GgF0VJKFxJOeimx
 5IA0AOa7VW+anZowAiyXa5aIp1FMzq0DwOSu7/lRim5STfkTYm+h8H/+nGwEkR54nw/NcU32mng
 PloV5hs70NMQjl1kf7OVbOhoSgQw==
X-Google-Smtp-Source: AGHT+IFV4ejJ05aZUkbHio21LY8L4/lVckYz35q8sBuQeMqIuRtHuEY0pU+3zodaECEAI/wCW3eOByzZlA==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a17:902:e80c:b0:20b:9df1:54a3
 with SMTP id
 d9443c01a7336-20bff1dfc9fmr779915ad.8.1728350348483; Mon, 07 Oct 2024
 18:19:08 -0700 (PDT)
Date: Mon,  7 Oct 2024 18:18:34 -0700
In-Reply-To: <20241008011852.1439154-1-tavip@google.com>
Mime-Version: 1.0
References: <20241008011852.1439154-1-tavip@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241008011852.1439154-9-tavip@google.com>
Subject: [PATCH v2 08/25] hw/i2c: add support for flexcomm i2c
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr, 
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org, jsnow@redhat.com, 
 crosa@redhat.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=3jIgEZwUKCu0iPkXeVddVaT.RdbfTbj-STkTacdcVcj.dgV@flex--tavip.bounces.google.com;
 helo=mail-pl1-x649.google.com
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

Add support for NXP's flexcomm i2c. It does not support slave mode or
DMA.

The patch includes an automatically generated header which contains
the register layout and helpers.

The header can be regenerated with the svd-flexcomm-i2c target when
the build is configured with --enable-mcux-soc-svd.

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 include/hw/arm/svd/flexcomm_i2c.h | 229 +++++++++++++++++++++++++++
 include/hw/i2c/flexcomm_i2c.h     |  40 +++++
 include/hw/misc/flexcomm.h        |   2 +
 hw/i2c/flexcomm_i2c.c             | 250 ++++++++++++++++++++++++++++++
 hw/misc/flexcomm.c                |   3 +
 hw/arm/svd/meson.build            |   4 +
 hw/i2c/meson.build                |   1 +
 hw/i2c/trace-events               |  10 ++
 hw/misc/Kconfig                   |   1 +
 9 files changed, 540 insertions(+)
 create mode 100644 include/hw/arm/svd/flexcomm_i2c.h
 create mode 100644 include/hw/i2c/flexcomm_i2c.h
 create mode 100644 hw/i2c/flexcomm_i2c.c

diff --git a/include/hw/arm/svd/flexcomm_i2c.h b/include/hw/arm/svd/flexcomm_i2c.h
new file mode 100644
index 0000000000..bd1dec16f3
--- /dev/null
+++ b/include/hw/arm/svd/flexcomm_i2c.h
@@ -0,0 +1,229 @@
+/*
+ * Copyright 2016-2023 NXP SPDX-License-Identifier: BSD-3-Clause
+ *
+ * Automatically generated by svd-gen-header.py from MIMXRT595S_cm33.xml
+ */
+#pragma once
+
+#include "hw/register.h"
+
+/* I2C Bus Interface */
+#define FLEXCOMM_I2C_REGS_NO (1024)
+
+/* Configuration Register */
+REG32(FLEXCOMM_I2C_CFG, 0x800);
+/* Master Enable */
+FIELD(FLEXCOMM_I2C_CFG, MSTEN, 0, 1);
+/* Slave Enable */
+FIELD(FLEXCOMM_I2C_CFG, SLVEN, 1, 1);
+/* Monitor Enable */
+FIELD(FLEXCOMM_I2C_CFG, MONEN, 2, 1);
+/* I2C bus Time-out Enable */
+FIELD(FLEXCOMM_I2C_CFG, TIMEOUTEN, 3, 1);
+/* Monitor function Clock Stretching */
+FIELD(FLEXCOMM_I2C_CFG, MONCLKSTR, 4, 1);
+/* High Speed mode Capable enable */
+FIELD(FLEXCOMM_I2C_CFG, HSCAPABLE, 5, 1);
+
+/* Status Register */
+REG32(FLEXCOMM_I2C_STAT, 0x804);
+/* Master Pending */
+FIELD(FLEXCOMM_I2C_STAT, MSTPENDING, 0, 1);
+/* Master State code */
+FIELD(FLEXCOMM_I2C_STAT, MSTSTATE, 1, 3);
+/* Idle. The Master function is available to be used for a new transaction. */
+#define FLEXCOMM_I2C_STAT_MSTSTATE_IDLE 0
+/*
+ * Receive ready. Received data is available (in Master Receiver mode). Address
+ * plus Read was previously sent and Acknowledged by a slave.
+ */
+#define FLEXCOMM_I2C_STAT_MSTSTATE_RECEIVE_READY 1
+/*
+ * Transmit ready. Data can be transmitted (in Master Transmitter mode).
+ * Address plus Write was previously sent and Acknowledged by a slave.
+ */
+#define FLEXCOMM_I2C_STAT_MSTSTATE_TRANSMIT_READY 2
+/* NACK Address. Slave NACKed address. */
+#define FLEXCOMM_I2C_STAT_MSTSTATE_NACK_ADDRESS 3
+/* NACK Data. Slave NACKed transmitted data. */
+#define FLEXCOMM_I2C_STAT_MSTSTATE_NACK_DATA 4
+
+/* Interrupt Enable Set Register */
+REG32(FLEXCOMM_I2C_INTENSET, 0x808);
+/* Master Pending interrupt Enable */
+FIELD(FLEXCOMM_I2C_INTENSET, MSTPENDINGEN, 0, 1);
+
+/* Interrupt Enable Clear Register */
+REG32(FLEXCOMM_I2C_INTENCLR, 0x80C);
+/* Master Pending interrupt clear */
+FIELD(FLEXCOMM_I2C_INTENCLR, MSTPENDINGCLR, 0, 1);
+
+/* Time-out Register */
+REG32(FLEXCOMM_I2C_TIMEOUT, 0x810);
+/* Time-out time value, the bottom 4 bits */
+FIELD(FLEXCOMM_I2C_TIMEOUT, TOMIN, 0, 4);
+
+/* Interrupt Status Register */
+REG32(FLEXCOMM_I2C_INTSTAT, 0x818);
+/* Master Pending */
+FIELD(FLEXCOMM_I2C_INTSTAT, MSTPENDING, 0, 1);
+
+/* Master Control Register */
+REG32(FLEXCOMM_I2C_MSTCTL, 0x820);
+/* Master Continue(write-only) */
+FIELD(FLEXCOMM_I2C_MSTCTL, MSTCONTINUE, 0, 1);
+/* Master Start control(write-only) */
+FIELD(FLEXCOMM_I2C_MSTCTL, MSTSTART, 1, 1);
+/* Master Stop control(write-only) */
+FIELD(FLEXCOMM_I2C_MSTCTL, MSTSTOP, 2, 1);
+/* Master DMA enable */
+FIELD(FLEXCOMM_I2C_MSTCTL, MSTDMA, 3, 1);
+
+/* Master Data Register */
+REG32(FLEXCOMM_I2C_MSTDAT, 0x828);
+/* Master function data register */
+FIELD(FLEXCOMM_I2C_MSTDAT, DATA, 0, 8);
+
+/* Slave Control Register */
+REG32(FLEXCOMM_I2C_SLVCTL, 0x840);
+
+/* Slave Data Register */
+REG32(FLEXCOMM_I2C_SLVDAT, 0x844);
+
+/* Slave Address Register */
+REG32(FLEXCOMM_I2C_SLVADR0, 0x848);
+
+/* Slave Address Register */
+REG32(FLEXCOMM_I2C_SLVADR1, 0x84C);
+
+/* Slave Address Register */
+REG32(FLEXCOMM_I2C_SLVADR2, 0x850);
+
+/* Slave Address Register */
+REG32(FLEXCOMM_I2C_SLVADR3, 0x854);
+
+/* Slave Qualification for Address 0 Register */
+REG32(FLEXCOMM_I2C_SLVQUAL0, 0x858);
+
+
+#define FLEXCOMM_I2C_REGISTER_ACCESS_INFO_ARRAY(_name) \
+    struct RegisterAccessInfo _name[FLEXCOMM_I2C_REGS_NO] = { \
+        [0 ... FLEXCOMM_I2C_REGS_NO - 1] = { \
+            .name = "", \
+            .addr = -1, \
+        }, \
+        [0x200] = { \
+            .name = "CFG", \
+            .addr = 0x800, \
+            .ro = 0xFFFFFFC0, \
+            .reset = 0x0, \
+        }, \
+        [0x201] = { \
+            .name = "STAT", \
+            .addr = 0x804, \
+            .ro = 0xFCF57FAF, \
+            .reset = 0x801, \
+        }, \
+        [0x202] = { \
+            .name = "INTENSET", \
+            .addr = 0x808, \
+            .ro = 0xFCF476AE, \
+            .reset = 0x0, \
+        }, \
+        [0x203] = { \
+            .name = "INTENCLR", \
+            .addr = 0x80C, \
+            .ro = 0xFCF476AE, \
+            .reset = 0x0, \
+        }, \
+        [0x204] = { \
+            .name = "TIMEOUT", \
+            .addr = 0x810, \
+            .ro = 0xFFFF0000, \
+            .reset = 0xFFFF, \
+        }, \
+        [0x205] = { \
+            .name = "CLKDIV", \
+            .addr = 0x814, \
+            .ro = 0xFFFF0000, \
+            .reset = 0x0, \
+        }, \
+        [0x206] = { \
+            .name = "INTSTAT", \
+            .addr = 0x818, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x801, \
+        }, \
+        [0x208] = { \
+            .name = "MSTCTL", \
+            .addr = 0x820, \
+            .ro = 0xFFFFFFF0, \
+            .reset = 0x0, \
+        }, \
+        [0x209] = { \
+            .name = "MSTTIME", \
+            .addr = 0x824, \
+            .ro = 0xFFFFFF88, \
+            .reset = 0x77, \
+        }, \
+        [0x20A] = { \
+            .name = "MSTDAT", \
+            .addr = 0x828, \
+            .ro = 0xFFFFFF00, \
+            .reset = 0x0, \
+        }, \
+        [0x210] = { \
+            .name = "SLVCTL", \
+            .addr = 0x840, \
+            .ro = 0xFFFFFCF4, \
+            .reset = 0x0, \
+        }, \
+        [0x211] = { \
+            .name = "SLVDAT", \
+            .addr = 0x844, \
+            .ro = 0xFFFFFF00, \
+            .reset = 0x0, \
+        }, \
+        [0x212] = { \
+            .name = "SLVADR0", \
+            .addr = 0x848, \
+            .ro = 0xFFFF7F00, \
+            .reset = 0x1, \
+        }, \
+        [0x213] = { \
+            .name = "SLVADR1", \
+            .addr = 0x84C, \
+            .ro = 0xFFFF7F00, \
+            .reset = 0x1, \
+        }, \
+        [0x214] = { \
+            .name = "SLVADR2", \
+            .addr = 0x850, \
+            .ro = 0xFFFF7F00, \
+            .reset = 0x1, \
+        }, \
+        [0x215] = { \
+            .name = "SLVADR3", \
+            .addr = 0x854, \
+            .ro = 0xFFFF7F00, \
+            .reset = 0x1, \
+        }, \
+        [0x216] = { \
+            .name = "SLVQUAL0", \
+            .addr = 0x858, \
+            .ro = 0xFFFFFF00, \
+            .reset = 0x0, \
+        }, \
+        [0x220] = { \
+            .name = "MONRXDAT", \
+            .addr = 0x880, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0x0, \
+        }, \
+        [0x3FF] = { \
+            .name = "ID", \
+            .addr = 0xFFC, \
+            .ro = 0xFFFFFFFF, \
+            .reset = 0xE0301300, \
+        }, \
+    }
diff --git a/include/hw/i2c/flexcomm_i2c.h b/include/hw/i2c/flexcomm_i2c.h
new file mode 100644
index 0000000000..7b27e333d7
--- /dev/null
+++ b/include/hw/i2c/flexcomm_i2c.h
@@ -0,0 +1,40 @@
+/*
+ * QEMU model for NXP's FLEXCOMM I2C
+ *
+ * Copyright (c) 2024 Google LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_FLEXCOMM_I2C_H
+#define HW_FLEXCOMM_I2C_H
+
+#include "hw/i2c/i2c.h"
+#include "hw/misc/flexcomm_function.h"
+
+#define TYPE_FLEXCOMM_I2C "flexcomm-i2c"
+OBJECT_DECLARE_TYPE(FlexcommI2cState, FlexcommI2cClass, FLEXCOMM_I2C);
+
+struct FlexcommI2cState {
+    FlexcommFunction parent_obj;
+
+    I2CBus *bus;
+};
+
+struct FlexcommI2cClass {
+    FlexcommFunctionClass parent_obj;
+
+    FlexcommFunctionSelect select;
+};
+
+#define MSTSTATE_IDLE 0
+#define MSTSTATE_RXRDY 1
+#define MSTSTATE_TXRDY 2
+#define MSTSTATE_NAKADR 3
+#define MSTSTATE_NAKDAT 4
+
+
+#endif /* HW_FLEXCOMM_I2C_H */
diff --git a/include/hw/misc/flexcomm.h b/include/hw/misc/flexcomm.h
index 679b7ea64d..c9f1cd3890 100644
--- a/include/hw/misc/flexcomm.h
+++ b/include/hw/misc/flexcomm.h
@@ -16,6 +16,7 @@
 #include "hw/arm/svd/flexcomm.h"
 #include "qemu/fifo32.h"
 #include "hw/char/flexcomm_usart.h"
+#include "hw/i2c/flexcomm_i2c.h"
 
 #define FLEXCOMM_FUNC_USART     0
 #define FLEXCOMM_FUNC_SPI       1
@@ -48,6 +49,7 @@ struct FlexcommState {
     Fifo32 rx_fifo;
     Fifo32 tx_fifo;
     FlexcommUsartState usart;
+    FlexcommI2cState i2c;
 };
 
 #endif /* HW_FLEXCOMM_H */
diff --git a/hw/i2c/flexcomm_i2c.c b/hw/i2c/flexcomm_i2c.c
new file mode 100644
index 0000000000..e5341ec241
--- /dev/null
+++ b/hw/i2c/flexcomm_i2c.c
@@ -0,0 +1,250 @@
+/*
+ * QEMU model for NXP's FLEXCOMM I2C
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
+#include "hw/i2c/flexcomm_i2c.h"
+#include "hw/arm/svd/flexcomm_i2c.h"
+
+#define REG(s, reg) (s->regs[R_FLEXCOMM_I2C_##reg])
+#define RF_WR(s, reg, field, val) \
+    ARRAY_FIELD_DP32(s->regs, FLEXCOMM_I2C_##reg, field, val)
+#define RF_RD(s, reg, field) \
+    ARRAY_FIELD_EX32(s->regs, FLEXCOMM_I2C_##reg, field)
+
+static FLEXCOMM_I2C_REGISTER_ACCESS_INFO_ARRAY(reg_info);
+
+static void flexcomm_i2c_reset(FlexcommFunction *f)
+{
+    for (int i = 0; i < FLEXCOMM_I2C_REGS_NO; i++) {
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
+static void flexcomm_i2c_irq_update(FlexcommFunction *f)
+{
+    bool enabled = RF_RD(f, CFG, MSTEN);
+    bool irq, per_irqs;
+
+    REG(f, INTSTAT) = REG(f, STAT) & REG(f, INTENSET);
+    per_irqs = REG(f, INTSTAT) != 0;
+
+    irq = enabled && per_irqs;
+
+    trace_flexcomm_i2c_irq(DEVICE(f)->id, irq, per_irqs, enabled);
+    flexcomm_set_irq(f, irq);
+}
+
+static MemTxResult flexcomm_i2c_reg_read(void *opaque, hwaddr addr,
+                                         uint64_t *data, unsigned size,
+                                         MemTxAttrs attrs)
+{
+    FlexcommFunction *f = FLEXCOMM_FUNCTION(opaque);
+    MemTxResult ret = MEMTX_OK;
+    const struct RegisterAccessInfo *rai = &reg_info[addr / 4];
+
+    if (size != 4) {
+        ret = MEMTX_ERROR;
+        goto out;
+    }
+
+    *data = f->regs[addr / 4];
+
+    flexcomm_i2c_irq_update(f);
+
+out:
+    trace_flexcomm_i2c_reg_read(DEVICE(f)->id, rai->name, addr, *data);
+    return ret;
+}
+
+static MemTxResult flexcomm_i2c_reg_write(void *opaque, hwaddr addr,
+                                          uint64_t value, unsigned size,
+                                          MemTxAttrs attrs)
+{
+    FlexcommFunction *f = FLEXCOMM_FUNCTION(opaque);
+    FlexcommI2cState *s = FLEXCOMM_I2C(opaque);
+    const struct RegisterAccessInfo *rai = &reg_info[addr / 4];
+    struct RegisterInfo ri = {
+        .data = &f->regs[addr / 4],
+        .data_size = 4,
+        .access = rai,
+    };
+
+    trace_flexcomm_i2c_reg_write(DEVICE(f)->id, rai->name, addr, value);
+
+    if (size != 4) {
+        return MEMTX_ERROR;
+    }
+
+    switch (addr) {
+    case A_FLEXCOMM_I2C_CFG:
+    {
+        register_write(&ri, value, ~0, NULL, false);
+        if (RF_RD(f, CFG, SLVEN)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "I2C slave not supported");
+        }
+        if (RF_RD(f, CFG, MONEN)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "I2C monitoring not supported");
+        }
+        break;
+    }
+    case A_FLEXCOMM_I2C_INTENCLR:
+    {
+        REG(f, INTENSET) &= ~value;
+        break;
+    }
+    case A_FLEXCOMM_I2C_TIMEOUT:
+    {
+        register_write(&ri, value, ~0, NULL, false);
+        /* The bottom 4 bits are hard-wired to 0xF */
+        RF_WR(f, TIMEOUT, TOMIN, 0xf);
+        break;
+    }
+    case A_FLEXCOMM_I2C_MSTCTL:
+    {
+        register_write(&ri, value, ~0, NULL, false);
+        if (RF_RD(f, MSTCTL, MSTSTART)) {
+            uint8_t i2c_addr = RF_RD(f, MSTDAT, DATA);
+            bool recv = i2c_addr & 1;
+
+            trace_flexcomm_i2c_start(DEVICE(s)->id, i2c_addr, recv);
+            if (i2c_start_transfer(s->bus, i2c_addr, recv)) {
+                RF_WR(f, STAT, MSTSTATE, MSTSTATE_NAKADR);
+                trace_flexcomm_i2c_nak(DEVICE(s)->id);
+            } else {
+                if (recv) {
+                    uint8_t data = i2c_recv(s->bus);
+
+                    RF_WR(f, MSTDAT, DATA, data);
+                    trace_flexcomm_i2c_rx(DEVICE(s)->id, data);
+                    RF_WR(f, STAT, MSTSTATE, MSTSTATE_RXRDY);
+                } else {
+                    RF_WR(f, STAT, MSTSTATE, MSTSTATE_TXRDY);
+                }
+            }
+        }
+        if (RF_RD(f, MSTCTL, MSTSTOP)) {
+            RF_WR(f, STAT, MSTSTATE, MSTSTATE_IDLE);
+            i2c_end_transfer(s->bus);
+        }
+        if (RF_RD(f, MSTCTL, MSTCONTINUE)) {
+            if (RF_RD(f, STAT, MSTSTATE) == MSTSTATE_TXRDY) {
+                uint8_t data = RF_RD(f, MSTDAT, DATA);
+
+                trace_flexcomm_i2c_tx(DEVICE(s)->id, data);
+                if (i2c_send(s->bus, data)) {
+                    RF_WR(f, STAT, MSTSTATE, MSTSTATE_NAKDAT);
+                }
+            } else if (RF_RD(f, STAT, MSTSTATE) == MSTSTATE_RXRDY) {
+                uint8_t data = i2c_recv(s->bus);
+
+                RF_WR(f, MSTDAT, DATA, data);
+                trace_flexcomm_i2c_rx(DEVICE(s)->id, data);
+            }
+        }
+        break;
+    }
+    case A_FLEXCOMM_I2C_STAT:
+    {
+        /* write 1 to clear bits */
+        REG(f, STAT) &= ~value;
+        break;
+    }
+    case A_FLEXCOMM_I2C_SLVCTL:
+    case A_FLEXCOMM_I2C_SLVDAT:
+    case A_FLEXCOMM_I2C_SLVADR0:
+    case A_FLEXCOMM_I2C_SLVADR1:
+    case A_FLEXCOMM_I2C_SLVADR2:
+    case A_FLEXCOMM_I2C_SLVADR3:
+    case A_FLEXCOMM_I2C_SLVQUAL0:
+    {
+        qemu_log_mask(LOG_GUEST_ERROR, "I2C slave not supported\n");
+        break;
+    }
+    default:
+        register_write(&ri, value, ~0, NULL, false);
+        break;
+    }
+
+    flexcomm_i2c_irq_update(f);
+
+    return MEMTX_OK;
+}
+
+static void flexcomm_i2c_select(FlexcommFunction *f, bool selected)
+{
+    FlexcommI2cClass *ic = FLEXCOMM_I2C_GET_CLASS(f);
+
+    if (selected) {
+        flexcomm_i2c_reset(f);
+    }
+    ic->select(f, selected);
+}
+
+static const MemoryRegionOps flexcomm_i2c_ops = {
+    .read_with_attrs = flexcomm_i2c_reg_read,
+    .write_with_attrs = flexcomm_i2c_reg_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static void flexcomm_i2c_realize(DeviceState *dev, Error **errp)
+{
+    FlexcommI2cState *s = FLEXCOMM_I2C(dev);
+
+    s->bus = i2c_init_bus(DEVICE(s), "bus");
+}
+
+static void flexcomm_i2c_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    FlexcommFunctionClass *fc = FLEXCOMM_FUNCTION_CLASS(klass);
+    FlexcommI2cClass *ic = FLEXCOMM_I2C_CLASS(klass);
+
+    dc->realize = flexcomm_i2c_realize;
+    ic->select = fc->select;
+    fc->select = flexcomm_i2c_select;
+    fc->name = "i2c";
+    fc->mmio_ops = &flexcomm_i2c_ops;
+}
+
+static const TypeInfo flexcomm_i2c_types[] = {
+    {
+        .name          = TYPE_FLEXCOMM_I2C,
+        .parent        = TYPE_FLEXCOMM_FUNCTION,
+        .instance_size = sizeof(FlexcommI2cState),
+        .class_init    = flexcomm_i2c_class_init,
+        .class_size    = sizeof(FlexcommI2cClass),
+    },
+};
+
+DEFINE_TYPES(flexcomm_i2c_types);
diff --git a/hw/misc/flexcomm.c b/hw/misc/flexcomm.c
index a291148f27..b1a2f01acf 100644
--- a/hw/misc/flexcomm.c
+++ b/hw/misc/flexcomm.c
@@ -24,6 +24,7 @@
 #include "hw/misc/flexcomm.h"
 #include "hw/arm/svd/flexcomm_usart.h"
 #include "hw/char/flexcomm_usart.h"
+#include "hw/i2c/flexcomm_i2c.h"
 
 #define REG(s, reg) (s->regs[R_FLEXCOMM_##reg])
 #define RF_WR(s, reg, field, val) \
@@ -220,6 +221,7 @@ static void flexcomm_init(Object *obj)
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->container);
     sysbus_init_irq(sbd, &s->irq);
     object_initialize_child(obj, "usart", &s->usart, TYPE_FLEXCOMM_USART);
+    object_initialize_child(obj, "i2c", &s->i2c, TYPE_FLEXCOMM_I2C);
 }
 
 static void flexcomm_finalize(Object *obj)
@@ -250,6 +252,7 @@ static void flexcomm_realize(DeviceState *dev, Error **errp)
 
     memory_region_add_subregion_overlap(&s->container, 0, &s->mmio, -1);
     flexcomm_func_realize_and_unref(FLEXCOMM_FUNCTION(&s->usart), errp);
+    flexcomm_func_realize_and_unref(FLEXCOMM_FUNCTION(&s->i2c), errp);
 }
 
 static const VMStateDescription vmstate_flexcomm = {
diff --git a/hw/arm/svd/meson.build b/hw/arm/svd/meson.build
index 3bff90bcbd..2542b56294 100644
--- a/hw/arm/svd/meson.build
+++ b/hw/arm/svd/meson.build
@@ -8,4 +8,8 @@ if get_option('mcux-soc-svd')
     [ '-i', rt595, '-o', '@SOURCE_ROOT@/include/hw/arm/svd/flexcomm_usart.h',
      '-p', 'USART0', '-t', 'FLEXCOMM_USART',
      '--fields', 'CFG:ENABLE FIFOCFG:ENABLE*,EMPTY* FIFO*:* *:'])
+  run_target('svd-flexcomm-i2c', command: svd_gen_header +
+    [ '-i', rt595, '-o', '@SOURCE_ROOT@/include/hw/arm/svd/flexcomm_i2c.h',
+      '-p', 'I2C0', '-t', 'FLEXCOMM_I2C',
+      '--fields', 'CFG TIMEOUT:TOMIN MSTCTL MSTDAT STAT:MSTPENDING,MSTSTATE INT*:MSTPENDING* SLV*:'])
 endif
diff --git a/hw/i2c/meson.build b/hw/i2c/meson.build
index c459adcb59..e7d79e6938 100644
--- a/hw/i2c/meson.build
+++ b/hw/i2c/meson.build
@@ -18,4 +18,5 @@ i2c_ss.add(when: 'CONFIG_PPC4XX', if_true: files('ppc4xx_i2c.c'))
 i2c_ss.add(when: 'CONFIG_PCA954X', if_true: files('i2c_mux_pca954x.c'))
 i2c_ss.add(when: 'CONFIG_PMBUS', if_true: files('pmbus_device.c'))
 i2c_ss.add(when: 'CONFIG_BCM2835_I2C', if_true: files('bcm2835_i2c.c'))
+i2c_ss.add(when: 'CONFIG_FLEXCOMM', if_true: files('flexcomm_i2c.c'))
 system_ss.add_all(when: 'CONFIG_I2C', if_true: i2c_ss)
diff --git a/hw/i2c/trace-events b/hw/i2c/trace-events
index 6900e06eda..9f0175fab7 100644
--- a/hw/i2c/trace-events
+++ b/hw/i2c/trace-events
@@ -51,3 +51,13 @@ npcm7xx_smbus_recv_fifo(const char *id, uint8_t received, uint8_t expected) "%s
 
 pca954x_write_bytes(uint8_t value) "PCA954X write data: 0x%02x"
 pca954x_read_data(uint8_t value) "PCA954X read data: 0x%02x"
+
+# flexcomm_i2c.c
+
+flexcomm_i2c_reg_read(const char *id, const char *reg_name, uint32_t addr, uint32_t val) " %s: %s[0x%04x] -> 0x%08x"
+flexcomm_i2c_reg_write(const char *id, const char *reg_name, uint32_t addr, uint32_t val) "%s: %s[0x%04x] <- 0x%08x"
+flexcomm_i2c_start(const char *id, uint8_t addr, uint8_t recv) "%s: 0x%02x %d"
+flexcomm_i2c_rx(const char *id, uint8_t data) "%s: <- 0x%02x"
+flexcomm_i2c_tx(const char *id, uint8_t data) "%s: -> 0x%02x"
+flexcomm_i2c_nak(const char *id) "%s: <- nak"
+flexcomm_i2c_irq(const char *id, bool irq, bool perirqs, bool enabled) "%s: %d %d %d"
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 14167ae9e8..9a244fa01d 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -215,5 +215,6 @@ config XLNX_VERSAL_TRNG
 
 config FLEXCOMM
     bool
+    select I2C
 
 source macio/Kconfig
-- 
2.47.0.rc0.187.ge670bccf7e-goog


