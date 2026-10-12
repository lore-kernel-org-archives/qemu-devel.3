Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F0CCA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 15:16:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGHk4-000374-AG; Mon, 12 Oct 2026 11:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xGHjw-000359-Ks
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:15:02 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xGHjt-0008BE-2O
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:15:00 -0400
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a180fbeef5so18462275e9.1
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 08:14:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791818096; x=1792422896;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xjPmksDx32sBE3I0U0f2mMmY0tOvAwSTdWeiZF0OcZw=;
 b=LedYGPUAJCkyCM1gRSmzl+C6tr+W2v5NLIw0ENCgmSuZtEO9F+HpkDnQlB6VQodg7B
 GlyJ2y7uvtFmJchxXJuLBkIzuHUvQoL2pQaxt2ydfZpAHzX1OKqreiavViWzH4Y1zces
 JEHkGrojUpPRCg1fzHeMbehy1sWa9Ve43ZEq4L3vVhzQME+eyWvSTQi+6HRwWSuVDMeb
 1kjIbjyBUIXfEUSmSWnM2JqQj0B2yr2bwoyrJ4+Oo5p7iiBi/qPzcUNWKuU4Q40WzwLK
 08R29DEeTBeDvwkOg4Ia7nYLcWchTy6QPSxRDACdSgDDWwJRBybx1CkZn1AHubYzvCyS
 /Zsg==
X-Gm-Message-State: AFq9FYKuFVpIAj51evM1o0B/ljxeXGEbZZWeSt7gt0OrcJMgg0CqOjqo
 HEIYXqx7n58x7z2wN7Oxy42tDH4oEmaTgGgsLCRspyYIPB6I8nVl9/5zC49tWypc
X-Gm-Gg: AYBFou3Ubk9c5gjwwP2c+IcyI2eG6jWfZMZxFrTU4HWvNudGvgy4WmEYzr9wuYIv66P
 EpcnobP9wTme+y02mBnRXwv6IXd7x/Gp9Mfn5TGEvmAs4RfTYELCdinsm+u96U4OBg0hYwZZk1P
 6jw7SQy7od+Vsmb8O3B0Hc+zjWgpK+Jv32VMRaD+Lhd+1va38dyXPoQGw3NV01nW+9s8E9Vto4J
 Gqw+KjpPrz6fCccxTlnl5ZtZ7LKoWQ+0f6YaePrEElOopjRsbSeLC59tOT0fGuVvIAoiS0LFlOD
 j/Svx52WgxCuCQW198drmGm86xsFVEiz1f2ABen1XeER6u01lcELwMQwX+RtqDOUbZS9ogCpmVd
 ZF5q02XyEaYHYsKavJvN0YjENU1XmeDbu5GYIN9SVJug1s9T1MV9k/lV283zm5AGrkaQ6FMHBwL
 ifzSWsV8LoqLlOkrf+z2mfwTm3Wya3sUv2ext+KKMd4OtKw2LpkWkjSPbPlzBUQVDpNwAen6W0w
 ibZ7ow1F8pOSWNYQ8jjibZG+yjsDTscqReqqu+U8DBTQZqpgLYJCDcR
X-Received: by 2002:a05:600c:8b51:b0:49f:d6f0:6f24 with SMTP id
 5b1f17b1804b1-4a18e443b3fmr186393375e9.2.1791818095438; 
 Mon, 12 Oct 2026 08:14:55 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1a1feb78csm88245365e9.0.2026.10.12.08.14.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 08:14:55 -0700 (PDT)
Date: Mon, 12 Oct 2026 16:32:15 +0200
Subject: [PATCH v2 22/50] hw/rtc: ds1338: add DS1339 variant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-bmc-minerva-v2-22-4c3dff084ec9@free.fr>
References: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
In-Reply-To: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org, 
 Patrick Leis <venture@google.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791815520; l=13372;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=xoWhr5Wtvx2t0SPDX34IEK+W+ImMd1a8R+3tANP1tIE=;
 b=4WCb3FyCPzvR5vENM5Hoo9TNk4uoeGRuJC2f31+VI4GeTGpw1gwUswDXbsc4uU3KIoLagG840
 MRyDLjfCf4XBsfD/tC3xKRMVIEK6nEfrxTt6MK+zWB83k8s871MMmZB
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.43; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f43.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Emmanuel Blot <emmanuel.blot@free.fr>
From:  Emmanuel Blot via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The Dallas/Maxim DS1339 register map is only partially compatible with
the DS1338: it shares the clock/calendar time registers but differs
elsewhere. It has no general-purpose NVRAM, moves the control register,
and relocates the oscillator-stop flag.

Add a 'ds1339' variant, modelling the EOSC oscillator stop, the
OSF/A2F/A1F status register and the century bit. The alarm,
square-wave and trickle-charger functions are not modelled.

A migrated register pointer is now range-checked; it used to index the
register array unvalidated.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/rtc/ds1338.c         | 180 ++++++++++++++++++++++++++++++++++++++++++++----
 include/hw/rtc/ds1338.h |   3 +-
 2 files changed, 168 insertions(+), 15 deletions(-)

diff --git a/hw/rtc/ds1338.c b/hw/rtc/ds1338.c
index 21deb94689..63a049292e 100644
--- a/hw/rtc/ds1338.c
+++ b/hw/rtc/ds1338.c
@@ -1,5 +1,5 @@
 /*
- * MAXIM DS1338 I2C RTC+NVRAM
+ * MAXIM DS1338/DS1339 I2C RTC+NVRAM
  *
  * Copyright (c) 2009 CodeSourcery.
  * Written by Paul Brook
@@ -10,6 +10,13 @@
  * GNU GPL, version 2 or (at your option) any later version.
  *
  * Limitations:
+ * - The DS1339 alarm registers, the alarm-enable control bits, the A1F/A2F
+ *   status flags and the trickle charger are stored but never evaluated: no
+ *   alarm matching is performed, no flag is ever set by hardware and no
+ *   charging happens.
+ * - The INT#/SQW output pin is not exposed: neither alarm interrupts nor
+ *   square-wave generation are produced. No board wires this pin and the guest
+ *   does not use the RTC wakealarm here.
  * - Writing the seconds register does not reset the internal countdown chain,
  *   so the sub-second phase of the clock is not modelled.
  * - The user registers are refreshed on a START and on a read that wraps the
@@ -47,6 +54,23 @@
 /* POR: OUT, OSF, SQWE and both rate-select bits come up set. */
 #define DS1338_CTRL_RESET  0xb3
 
+/* Sentinel register address meaning "this variant has no such register". */
+#define DS1338_NO_REG      0xff
+
+/* DS1339 register map: 0x00..0x10 only, no general-purpose NVRAM */
+#define DS1339_NUM_REGS    0x11         /* 0x00..0x10, then wraps */
+#define DS1339_CONTROL     0x0e
+#define DS1339_CTRL_MASK   0xbf         /* bit 6 is reserved, reads back zero */
+#define DS1339_CTRL_EOSC   0x80         /* EOSC: 1 stops the oscillator */
+#define DS1339_CTRL_RESET  0x18         /* POR: RS2=RS1=1 (32 kHz), rest zero */
+#define DS1339_MONTH_CENTURY 0x80       /* Century is bit 7 of the month reg */
+#define DS1339_STATUS      0x0f
+#define DS1339_STATUS_OSF  0x80         /* OSF is bit 7 of the status reg */
+/* Status bits that exist (OSF | A2F | A1F); bits 6..2 are reserved, read 0. */
+#define DS1339_STATUS_MASK 0x83
+/* All three status flags are hardware-set and clear-only (write 0). */
+#define DS1339_STATUS_W0   0x83
+
 OBJECT_DECLARE_TYPE(DS1338State, DS1338Class, DS1338)
 
 struct DS1338State {
@@ -58,6 +82,7 @@ struct DS1338State {
     int32_t ptr;
     bool addr_byte;
     bool osc_stopped;      /* oscillator halted: time is frozen */
+    uint8_t prev_century;  /* century index (tm_year/100) at last capture */
     bool persist_on_reset; /* keep the registers across a reset */
 };
 
@@ -69,24 +94,70 @@ struct DS1338Class {
     uint8_t ctrl_mask;      /* writable/read-back bits of the control reg */
     uint8_t osf_addr;       /* register holding the OSF flag */
     uint8_t osf_mask;       /* OSF bit within osf_addr */
+    uint8_t status_addr;    /* status register address */
+    uint8_t status_mask;    /* bits that exist; reserved bits read 0 */
+    uint8_t status_w0_mask; /* flags that can only be cleared */
     uint8_t ctrl_reset;     /* control-register power-on value */
+    uint8_t status_reset;   /* status-register power-on value */
+    uint8_t eosc_mask;      /* oscillator-disable bit in the control reg */
+    uint8_t century_mask;   /* Century bit in the month register */
     uint8_t ch_mask;        /* Clock-halt bit in the seconds reg */
 };
 
+static int ds1338_post_load(void *opaque, int version_id)
+{
+    DS1338State *s = opaque;
+    DS1338Class *k = DS1338_GET_CLASS(s);
+
+    /* Both accessors index nvram[] with ptr before incrementing it. */
+    if (s->ptr < 0 || s->ptr >= k->num_regs) {
+        return -EINVAL;
+    }
+
+    /*
+     * prev_century did not exist before version 3, so an older incoming stream
+     * leaves it zero.
+     */
+    if (version_id < 3) {
+        struct tm now;
+
+        qemu_get_timedate(&now, s->offset);
+        s->prev_century = now.tm_year / 100;
+    }
+    return 0;
+}
+
+static const VMStateField vmstate_ds1338_fields[] = {
+    VMSTATE_I2C_SLAVE(parent_obj, DS1338State),
+    VMSTATE_INT64(offset, DS1338State),
+    VMSTATE_UINT8_V(wday_offset, DS1338State, 2),
+    VMSTATE_UINT8_ARRAY(nvram, DS1338State, NVRAM_SIZE),
+    VMSTATE_INT32(ptr, DS1338State),
+    VMSTATE_BOOL(addr_byte, DS1338State),
+    VMSTATE_BOOL_V(osc_stopped, DS1338State, 3),
+    VMSTATE_UINT8_V(prev_century, DS1338State, 3),
+    VMSTATE_END_OF_LIST()
+};
+
 static const VMStateDescription vmstate_ds1338 = {
     .name = "ds1338",
     .version_id = 3,
     .minimum_version_id = 1,
-    .fields = (const VMStateField[]) {
-        VMSTATE_I2C_SLAVE(parent_obj, DS1338State),
-        VMSTATE_INT64(offset, DS1338State),
-        VMSTATE_UINT8_V(wday_offset, DS1338State, 2),
-        VMSTATE_UINT8_ARRAY(nvram, DS1338State, NVRAM_SIZE),
-        VMSTATE_INT32(ptr, DS1338State),
-        VMSTATE_BOOL(addr_byte, DS1338State),
-        VMSTATE_BOOL_V(osc_stopped, DS1338State, 3),
-        VMSTATE_END_OF_LIST()
-    }
+    .post_load = ds1338_post_load,
+    .fields = vmstate_ds1338_fields,
+};
+
+/*
+ * The DS1339 reuses the DS1338 migration field list, so it migrates the full
+ * NVRAM_SIZE-byte nvram[] array even though it only implements registers
+ * 0x00..0x10.
+ */
+static const VMStateDescription vmstate_ds1339 = {
+    .name = "ds1339",
+    .version_id = 3,
+    .minimum_version_id = 3,
+    .post_load = ds1338_post_load,
+    .fields = vmstate_ds1338_fields,
 };
 
 /* Reconstruct a struct tm from the BCD time registers in nvram. */
@@ -109,7 +180,7 @@ static void ds1338_time_from_regs(DS1338State *s, struct tm *now)
     }
     now->tm_mday = from_bcd(s->nvram[4] & 0x3f);
     now->tm_mon = from_bcd(s->nvram[5] & 0x1f) - 1;
-    now->tm_year = from_bcd(s->nvram[6]) + 100;
+    now->tm_year = s->prev_century * 100 + from_bcd(s->nvram[6]);
 }
 
 static void ds1338_resync_from_regs(DS1338State *s)
@@ -129,13 +200,22 @@ static void ds1338_capture_current_time(DS1338State *s)
     /* Capture the current time into the secondary registers
      * which will be actually read by the data transfer operation.
      */
+    DS1338Class *k = DS1338_GET_CLASS(s);
     struct tm now;
+    uint8_t century;
 
     if (s->osc_stopped) {
         return;
     }
 
     qemu_get_timedate(&now, s->offset);
+
+    century = now.tm_year / 100;
+    if (k->century_mask && ((century ^ s->prev_century) & 1)) {
+        s->nvram[5] ^= k->century_mask;
+    }
+    s->prev_century = century;
+
     s->nvram[0] = to_bcd(now.tm_sec);
     s->nvram[1] = to_bcd(now.tm_min);
     if (s->nvram[2] & HOURS_12) {
@@ -153,7 +233,7 @@ static void ds1338_capture_current_time(DS1338State *s)
     }
     s->nvram[3] = (now.tm_wday + s->wday_offset) % 7 + 1;
     s->nvram[4] = to_bcd(now.tm_mday);
-    s->nvram[5] = to_bcd(now.tm_mon + 1);
+    s->nvram[5] = to_bcd(now.tm_mon + 1) | (s->nvram[5] & k->century_mask);
     s->nvram[6] = to_bcd(now.tm_year % 100);
 }
 
@@ -204,6 +284,16 @@ static uint8_t ds1338_recv(I2CSlave *i2c)
     return res;
 }
 
+/* OSF is raised by hardware whenever the oscillator stops. */
+static void ds1338_raise_osf(DS1338State *s)
+{
+    DS1338Class *k = DS1338_GET_CLASS(s);
+
+    if (k->osf_addr != DS1338_NO_REG) {
+        s->nvram[k->osf_addr] |= k->osf_mask;
+    }
+}
+
 static int ds1338_send(I2CSlave *i2c, uint8_t data)
 {
     DS1338State *s = DS1338(i2c);
@@ -234,12 +324,14 @@ static int ds1338_send(I2CSlave *i2c, uint8_t data)
             if (k->ch_mask) {
                 halt = data & k->ch_mask;
             }
+        } else if (s->ptr == 5) {
+            mask |= k->century_mask;
         }
 
         if (halt && !s->osc_stopped) {
             /* CH set: freeze the counters before the register is stored. */
             ds1338_capture_current_time(s);
-            s->nvram[k->osf_addr] |= k->osf_mask;
+            ds1338_raise_osf(s);
         }
         s->nvram[s->ptr] = data & mask;
         s->osc_stopped = halt;
@@ -250,6 +342,19 @@ static int ds1338_send(I2CSlave *i2c, uint8_t data)
         if (s->ptr == k->ctrl_addr) {
             /* Control register: reserved bits read back as zero. */
             data &= k->ctrl_mask;
+            if (k->eosc_mask) {
+                bool now_stop = data & k->eosc_mask;
+                bool was_stop = s->nvram[k->ctrl_addr] & k->eosc_mask;
+                if (now_stop && !was_stop) {
+                    ds1338_capture_current_time(s);
+                    s->osc_stopped = true;
+                    ds1338_raise_osf(s);
+                } else if (!now_stop && was_stop) {
+                    /* EOSC cleared: resume counting from the frozen time. */
+                    ds1338_resync_from_regs(s);
+                    s->osc_stopped = false;
+                }
+            }
         }
         if (s->ptr == k->osf_addr) {
             /*
@@ -259,6 +364,13 @@ static int ds1338_send(I2CSlave *i2c, uint8_t data)
             data = (data & ~k->osf_mask) |
                    (data & s->nvram[s->ptr] & k->osf_mask);
         }
+        if (s->ptr == k->status_addr) {
+            /* Reserved bits read zero; flags are clear-only, OSF included. */
+            uint8_t cur = s->nvram[s->ptr];
+            data &= k->status_mask;
+            data = (data & ~k->status_w0_mask) |
+                   (data & cur & k->status_w0_mask);
+        }
         s->nvram[s->ptr] = data;
     }
     ds1338_inc_regptr(s);
@@ -268,13 +380,19 @@ static int ds1338_send(I2CSlave *i2c, uint8_t data)
 static void ds1338_power_on(DS1338State *s)
 {
     DS1338Class *k = DS1338_GET_CLASS(s);
+    struct tm now;
 
     /* The clock is running and synchronized with the host */
     s->offset = 0;
     s->wday_offset = 0;
     memset(s->nvram, 0, NVRAM_SIZE);
     s->nvram[k->ctrl_addr] = k->ctrl_reset;
+    if (k->status_addr != DS1338_NO_REG) {
+        s->nvram[k->status_addr] = k->status_reset;
+    }
     s->osc_stopped = false;
+    qemu_get_timedate(&now, 0);
+    s->prev_century = now.tm_year / 100;
 }
 
 static void ds1338_realize(DeviceState *dev, Error **errp)
@@ -318,10 +436,39 @@ static void ds1338_class_init(ObjectClass *klass, const void *data)
     dsc->ctrl_mask  = DS1338_CTRL_MASK;
     dsc->osf_addr   = DS1338_CONTROL;
     dsc->osf_mask   = CTRL_OSF;
+    dsc->status_addr = DS1338_NO_REG;   /* the DS1338 has no status register */
+    dsc->status_mask = 0;
+    dsc->status_w0_mask = 0;
     dsc->ctrl_reset = DS1338_CTRL_RESET;
+    dsc->status_reset = 0;
+    dsc->eosc_mask = 0;
+    dsc->century_mask = 0;
     dsc->ch_mask = SECONDS_CH;
 }
 
+static void ds1339_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    DS1338Class *dsc = DS1338_CLASS(klass);
+
+    dc->desc = "DS1339 I2C serial real-time clock";
+    dc->vmsd = &vmstate_ds1339;
+
+    dsc->num_regs   = DS1339_NUM_REGS;
+    dsc->ctrl_addr  = DS1339_CONTROL;
+    dsc->ctrl_mask  = DS1339_CTRL_MASK;
+    dsc->osf_addr   = DS1339_STATUS;   /* OSF lives in the status register */
+    dsc->osf_mask   = DS1339_STATUS_OSF;
+    dsc->status_addr = DS1339_STATUS;
+    dsc->status_mask = DS1339_STATUS_MASK;
+    dsc->status_w0_mask = DS1339_STATUS_W0;
+    dsc->ctrl_reset = DS1339_CTRL_RESET;
+    dsc->status_reset = DS1339_STATUS_OSF;   /* OSF set at power-on */
+    dsc->eosc_mask = DS1339_CTRL_EOSC;
+    dsc->century_mask = DS1339_MONTH_CENTURY;
+    dsc->ch_mask = 0;   /* bit 7 of the seconds register reads back zero */
+}
+
 static const TypeInfo ds1338_types[] = {
     {
         .name          = TYPE_DS1338,
@@ -330,6 +477,11 @@ static const TypeInfo ds1338_types[] = {
         .class_size    = sizeof(DS1338Class),
         .class_init    = ds1338_class_init,
     },
+    {
+        .name          = TYPE_DS1339,
+        .parent        = TYPE_DS1338,
+        .class_init    = ds1339_class_init,
+    },
 };
 
 DEFINE_TYPES(ds1338_types)
diff --git a/include/hw/rtc/ds1338.h b/include/hw/rtc/ds1338.h
index f4cfe6a8e7..fff04c225d 100644
--- a/include/hw/rtc/ds1338.h
+++ b/include/hw/rtc/ds1338.h
@@ -1,5 +1,5 @@
 /*
- * MAXIM DS1338 I2C RTC+NVRAM
+ * MAXIM DS1338/DS1339 I2C RTC+NVRAM
  *
  * Copyright (c) 2009 CodeSourcery.
  * Written by Paul Brook
@@ -16,5 +16,6 @@
 #define HW_RTC_DS1338_H
 
 #define TYPE_DS1338 "ds1338"
+#define TYPE_DS1339 "ds1339"
 
 #endif

-- 
2.50.1


