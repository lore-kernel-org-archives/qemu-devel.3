Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DA3606A326
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 08:58:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOtIZ-0004E7-4a; Thu, 05 Nov 2026 03:58:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtIQ-0003vw-1u
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 03:58:11 -0500
Received: from mail-pl1-f174.google.com ([209.85.214.174])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtIN-0003lJ-Ft
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 03:58:09 -0500
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2e9ae391a05so3175455ad.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 00:58:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793869085; x=1794473885;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i/fJVu0RAkQNpYAD+bvYA8hnncGtRkMKhtyQVwo+Ypc=;
 b=JMzCxmnK/Qs84we3HowJKRx8zR4XqtmmJqgcyb0d1IEyuVQ+UBc/kmwUULxkcrj0lo
 plpTylvnHc+O3/AF3JlKXzuBlf0GKY/p+7xE/WfvBiai3hnaJjkryuFGKbC0gA/PyMzY
 fPivaR5UcXfORLkCqs3WmUR/WD+V47zoiXxpTSjWwGACNfygWDBYLOhXgoBB3BTuGccx
 hBAOR2bjiak5zCtNP5zVdk/iUZZ+Xf82l07tPVWaMaiyEL+RyE0VGuk1lLMF5D8/1CuZ
 NjAnWk8OBF3l/BtEfggW7JEu3/cPqgFMX3fGWbd5pY4RkrpCUtiF7K2ZQVHXAoC9Xdui
 tVBg==
X-Gm-Message-State: APuU4Z+vC64oaR8YtEYD8l3wTbu145DUmJkckzUDLX8t2yKRdIQw8pcZ
 joJOsm0ESENIRWE6SPmhHHcgIyoVFnd5d+xlxo+k9lHZPpSO8YdZPyBx4qVHzomt/ok=
X-Gm-Gg: AYBFou3Lj9DBJ8hzLeWsX1+clNr51er6Vfyb4WG6Ul+lrdCOxm6IArqEfe2wpDE3d+/
 EEHjMyKcAYXLtrCt8SOG++Ds1H/VPf7czRXZpNiGDoHhVjiJGDUR+1rlCDgB/e4kWgtYbBJa5Y3
 irtbkgaUgsTYt+dgexYoPtRydidZXMsu2uYa2I2rp+i3dTlTM3v7e/GjGpVntdMxAQxlDZl2+hD
 boOcvyXKHLGjXCofjkPS7avcfI/8wy4NgWJMq0/YuRb97MaJS9UA9HmwEkRVkWWv0g3ylvvniMs
 PYMRr1gSDuYDPShFImbY6JGZSfXczWmdEbYAZ7QXaC/Q2cPZ+v6V8mQiPLLvXSwkH74gc+rId+J
 UW4b8m9nKpU/n7s/b8QTiJuE6N98pLbaRZpU62QBvZbdGuFqxPfkFLrK3mSiKMzjCnEp5Ao3DkF
 /9t0eDorqdw3bn3YBWTvfSRekge6YDIBICJ/DopxEUUgGyOIL0QdPZvJOcGJHbVUYNvJA3/X7hF
 Nxk5Ofnot84NhxxQ/kktjgHmMTaP6oHDBrCDmMpvMLH4oP1WnRX63yq4b75gWqVbtie80GmRPMN
 TFqPFmonY68QOvHtqqweqg3+dsgBN79X6SmtXi4nHYG8ZA4wI7W/zpQ475R/sEgCuZx8rNWr6qi
 +ypvpxw==
X-Received: by 2002:a17:902:ecce:b0:2dd:86a3:232d with SMTP id
 d9443c01a7336-2ed2407d509mr12245015ad.8.1793869084915; 
 Thu, 05 Nov 2026 00:58:04 -0800 (PST)
Received: from localhost (118-163-122-149.hinet-ip.hinet.net.
 [118.163.122.149]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ed08fe55bdsm15377455ad.15.2026.11.05.00.58.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 00:58:04 -0800 (PST)
Date: Thu, 05 Nov 2026 16:50:46 +0800
Subject: [PATCH 10/19] hw/rtc: ds1338: add DS1339 variant
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-rtc-ds1339-v1-10-50a8dc463ee8@free.fr>
References: <20261105-rtc-ds1339-v1-0-50a8dc463ee8@free.fr>
In-Reply-To: <20261105-rtc-ds1339-v1-0-50a8dc463ee8@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, eblot@meta.com, 
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793868640; l=13377;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=renBzme08gMcnv/4M4nG6ZLUFiR64cw9Bpyli/NRkr8=;
 b=IGsljTOV7eG6GMyjeXNY/BthGkCqhFwu/UxvKtlFRthi7Ptnc4k+EfG0Arv13fkgkZIl0YucO
 960qR3shK2pCkT3Na7t8YGcs5Lig2B8c+HLiPzxVvHBzDfD6PqX4YZr
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.214.174; envelope-from=eblot.ml@gmail.com;
 helo=mail-pl1-f174.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Emmanuel Blot <emmanuel.blot@free.fr>
From:  Emmanuel Blot via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
2.53.0-Meta


