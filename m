Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B42C2C54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 12:31:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpmOK-00052t-13; Fri, 31 Jul 2026 08:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wpmOH-00051q-SI
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 08:31:06 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wpmOF-0000Uh-Nr
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 08:31:05 -0400
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-47f71156e1aso507338f8f.3
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 05:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785501062; x=1786105862;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l3WpTee/4RoiCaj0VXXex9ekWr7UzvNx0KKU+t7qV7I=;
 b=qIV3VLz4hCbHqV4OmNXu1nRVDB2A77Q6QbDfel/YS1OO+7uwmIE2/eTBc75mLFzVlY
 jGlgc/sHVsmk7b1EXV9XZPEdb6g2DNGAsFzTHuuDLrZSZD8IZWWAUYbngjrpHJbvjc99
 wDG2L58AnobmJdwuBwCOtMUexMVx3Rz3gi/u/J+LpeToUGjmnKqheX0COePlb2c+eRvw
 Lpr29ruf1IDqvwOxzfDOXI1vjz62aKBfe7mY4/ncCkXR7ZuvVAbNmkKIjsXMNmSQgEil
 ZdNDYGziBHHzrBiNzeIEdUusd4kzGcrcbC/AyaKjl9HWTsCPQSibXj5txyxKlmK5Csrj
 VG5w==
X-Gm-Message-State: AOJu0YyrugHnkwKTNmi541LFqk4qT7bvpmHV8FjHqZadJxxahBlfC5l5
 Tg3IJwmggEMNGNVRsmH38lozqbUDcbDB79kDesY1ZKBtbFFrRNZM4biIAIASECKJ
X-Gm-Gg: AR+sD10AyU5pdKYNRTqpMXvh+IFNFqy8KxOqj/GnlUk0YmFhSo0/pBu/rHME1HS2F2x
 M80NzrSYhnPwQzIyLkRVFzwDIvf5ISlDXTIJhiKhy0xCXF9WLv4Zxus1adH9+uH/C69UDnaw7Mt
 YdbaVaVEjttURqsu/BGxjiarYjv3RA3sKwoIeQSHbw8qWo7bv9evg0Bqc7OBONUZTQW8j6HTaJ9
 t64UJbPmezlhVU4s2golcgA2ZNcWjMnMT3dAH8OrPkrpkwFsDKllTO5zQsVYilJyD5EO1EvSFAQ
 Omnzqhd7iDJG3WXDVwU0BodwwMkLmx5278C7OIAaa4XAxWfCIDp3XU4NHlncEDPw4chnZt2UY/i
 hb47TaVo9kwba2c7p11waWeaGAAvr/AaYB3ZoHk/YtOtsgJPCTind9eK+cK1IUVCZSxrN1bWjPb
 M+GfFWI2NVr1mvdOoxaGyQPToeKHBOtC+yKH1sQZixMH5udWfPH1ADbzXSdcwmttBrfqAuqDCe9
 S+i/zuVhGmUvSzBHhH55nijeSZexJS8YDzE
X-Received: by 2002:a05:6000:18a3:b0:47f:25db:8161 with SMTP id
 ffacd0b85a97d-47fd2b41707mr4545331f8f.28.1785501062069; 
 Fri, 31 Jul 2026 05:31:02 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41e2484sm4503184f8f.11.2026.07.31.05.31.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 05:31:01 -0700 (PDT)
Date: Fri, 31 Jul 2026 12:45:06 +0200
Subject: [PATCH v2 07/25] hw/sensor: tmp105: add TMP75, TMP175 and LM75B
 variants
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-sanmiguel-bmc-locator-v2-7-1266926ba769@free.fr>
References: <20260731-sanmiguel-bmc-locator-v2-0-1266926ba769@free.fr>
In-Reply-To: <20260731-sanmiguel-bmc-locator-v2-0-1266926ba769@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Emmanuel Blot <eblot@meta.com>, Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785494707; l=11711;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=lPIoQyprA+KEMRKHRKV5S5+kFK23vviUH2t6jGqoAuY=;
 b=SX2tA1C9iyS6Z9ggUR6t68npY/SDQu/QIlq87cZhVTAYgot2BpJktUmsHCoafrA3ufiZWVVB2
 uNnV0lQBizsCxJ9BHTgZHT7IyiTQtxPruljF7yKukzxX2f4SsXIxpUz
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.221.51; envelope-from=eblot.ml@gmail.com;
 helo=mail-wr1-f51.google.com
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

The TI TMP75/TMP175 and the NXP LM75B share the TMP105 register map and
control semantics, differing only in a few details. Model them as
variants of the TMP105, parameterised by a small per-type class
descriptor covering the fault-queue depths, the writable config bits,
the converter resolution, the set-point masks and the TMP75's
alert-clear on thermostat-mode change.

The variant is class data, not migrated state, so the wire format is
unchanged and all variants share the existing vmstate.

While here, align the shared shutdown handling with the hardware:
entering shutdown now clears the ALERT/OS output in interrupt mode,
correcting the base TMP105 as well.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/sensor/tmp105.c         | 176 ++++++++++++++++++++++++++++++++++++---------
 include/hw/sensor/tmp105.h |   6 +-
 2 files changed, 148 insertions(+), 34 deletions(-)

diff --git a/hw/sensor/tmp105.c b/hw/sensor/tmp105.c
index fefa661711..ece0650d70 100644
--- a/hw/sensor/tmp105.c
+++ b/hw/sensor/tmp105.c
@@ -1,5 +1,5 @@
 /*
- * Texas Instruments TMP105 temperature sensor.
+ * Texas Instruments TMP105/TMP75/TMP175/LM75B temperature sensor.
  *
  * Copyright (C) 2008 Nokia Corporation
  * Written by Andrzej Zaborowski <andrew@openedhand.com>
@@ -16,6 +16,13 @@
  *
  * You should have received a copy of the GNU General Public License along
  * with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * Limitations:
+ * - The SMBus Alert Response Address protocol and the general-call commands
+ *   are not implemented.
+ * - The over-limit comparison uses the full 8.8 fixed-point temperature and a
+ *   ">=" boundary for every variant. The LM75B's 9-bit comparison quantisation
+ *   and strict-exceed boundary are therefore only approximated.
  */
 
 #include "qemu/osdep.h"
@@ -31,15 +38,8 @@
 #include "migration/vmstate.h"
 #include "trace.h"
 
-OBJECT_DECLARE_SIMPLE_TYPE(TMP105State, TMP105)
+OBJECT_DECLARE_TYPE(TMP105State, TMP105Class, TMP105)
 
-/**
- * TMP105State:
- * @config: Bits 5 and 6 (value 32 and 64) determine the precision of the
- * temperature. See Table 8 in the data sheet.
- *
- * @see_also: http://www.ti.com/lit/gpn/tmp105
- */
 struct TMP105State {
     /*< private >*/
     I2CSlave parent_obj;
@@ -53,7 +53,7 @@ struct TMP105State {
     uint8_t config;
     int16_t temperature;
     int16_t limit[2];
-    int faults;
+    uint8_t faults;
     uint8_t fault_count;
     uint8_t alarm;
     /*
@@ -65,6 +65,27 @@ struct TMP105State {
     bool detect_falling;
 };
 
+/*
+ * Per-device-model parameters. The TMP105, TMP75, TMP175 and LM75B share the
+ * same register map and control semantics; they differ only in a handful of
+ * details captured here.
+ *
+ * @faultq: fault-queue length table selected by Config bits
+ * @config_wmask: writable Config bits. The LM75B has no resolution (R1:R0) or
+ * one-shot (OS) bits.
+ * @fixed_res: converter resolution field pinned by the device, or -1 when it is
+ * software-selectable.
+ * @limit_lsb_mask: low-byte mask applied to the T_LOW/T_HIGH limit registers.
+ */
+struct TMP105Class {
+    I2CSlaveClass parent_class;
+    const uint8_t *faultq;
+    uint8_t config_wmask;
+    int8_t fixed_res;
+    uint8_t limit_lsb_mask;
+    bool tm_change_clears_alert;
+};
+
 FIELD(CONFIG, SHUTDOWN_MODE,        0, 1)
 FIELD(CONFIG, THERMOSTAT_MODE,      1, 1)
 FIELD(CONFIG, POLARITY,             2, 1)
@@ -152,10 +173,11 @@ static void tmp105_set_temperature(Object *obj, Visitor *v, const char *name,
     tmp105_alarm_update(s, false);
 }
 
-static const int tmp105_faultq[4] = { 1, 2, 4, 6 };
-
 static void tmp105_read(TMP105State *s)
 {
+    const TMP105Class *tc = TMP105_GET_CLASS(s);
+    int res;
+
     s->len = 0;
 
     if (FIELD_EX8(s->config, CONFIG, THERMOSTAT_MODE)) {
@@ -165,9 +187,11 @@ static void tmp105_read(TMP105State *s)
 
     switch (s->pointer & 3) {
     case TMP105_REG_TEMPERATURE:
+        res = tc->fixed_res >= 0 ? tc->fixed_res :
+              FIELD_EX8(s->config, CONFIG, CONVERTER_RESOLUTION);
         s->buf[s->len++] = (((uint16_t) s->temperature) >> 8);
         s->buf[s->len++] = (((uint16_t) s->temperature) >> 0) &
-                (0xf0 << (FIELD_EX8(~s->config, CONFIG, CONVERTER_RESOLUTION)));
+                (0xf0 << (3 - res));
         break;
 
     case TMP105_REG_CONFIG:
@@ -190,6 +214,10 @@ static void tmp105_read(TMP105State *s)
 
 static void tmp105_write(TMP105State *s)
 {
+    const TMP105Class *tc = TMP105_GET_CLASS(s);
+    uint8_t config, one_shot;
+    bool waking;
+
     trace_tmp105_write(s->parent_obj.address, s->pointer);
 
     switch (s->pointer & 3) {
@@ -197,14 +225,27 @@ static void tmp105_write(TMP105State *s)
         break;
 
     case TMP105_REG_CONFIG:
-        if (FIELD_EX8(s->buf[0] & ~s->config, CONFIG, SHUTDOWN_MODE)) {
+        config = s->buf[0] & tc->config_wmask;
+        if (FIELD_EX8(config & ~s->config, CONFIG, SHUTDOWN_MODE)) {
             trace_tmp105_write_shutdown(s->parent_obj.address);
+            if (FIELD_EX8(config, CONFIG, THERMOSTAT_MODE)) {
+                s->alarm = 0;
+            }
         }
-        s->config = FIELD_DP8(s->buf[0], CONFIG, ONE_SHOT, 0);
-        s->faults = tmp105_faultq[FIELD_EX8(s->config, CONFIG, FAULT_QUEUE)];
-        if (FIELD_EX8(s->buf[0], CONFIG, ONE_SHOT) &&
-            FIELD_EX8(s->config, CONFIG, SHUTDOWN_MODE)) {
+        if (tc->tm_change_clears_alert &&
+            FIELD_EX8(config ^ s->config, CONFIG, THERMOSTAT_MODE)) {
+            s->alarm = 0;
+            s->fault_count = 0;
+            s->detect_falling = false;
+        }
+        waking = FIELD_EX8(s->config & ~config, CONFIG, SHUTDOWN_MODE);
+        one_shot = FIELD_EX8(config, CONFIG, ONE_SHOT);
+        s->config = FIELD_DP8(config, CONFIG, ONE_SHOT, 0);
+        s->faults = tc->faultq[FIELD_EX8(s->config, CONFIG, FAULT_QUEUE)];
+        if (one_shot && FIELD_EX8(s->config, CONFIG, SHUTDOWN_MODE)) {
             tmp105_alarm_update(s, true);
+        } else if (waking) {
+            tmp105_alarm_update(s, false);
         } else {
             tmp105_interrupt_update(s);
         }
@@ -214,7 +255,8 @@ static void tmp105_write(TMP105State *s)
     case TMP105_REG_T_HIGH:
         if (s->len >= 3) {
             s->limit[s->pointer & 1] = (int16_t)
-                    ((((uint16_t) s->buf[0]) << 8) | (s->buf[1] & 0xf0));
+                    ((((uint16_t) s->buf[0]) << 8) |
+                     (s->buf[1] & tc->limit_lsb_mask));
         }
         tmp105_interrupt_update(s);
         break;
@@ -265,8 +307,9 @@ static int tmp105_event(I2CSlave *i2c, enum i2c_event event)
 static int tmp105_post_load(void *opaque, int version_id)
 {
     TMP105State *s = opaque;
+    const TMP105Class *tc = TMP105_GET_CLASS(s);
 
-    s->faults = tmp105_faultq[FIELD_EX8(s->config, CONFIG, FAULT_QUEUE)];
+    s->faults = tc->faultq[FIELD_EX8(s->config, CONFIG, FAULT_QUEUE)];
 
     tmp105_interrupt_update(s);
     return 0;
@@ -339,11 +382,12 @@ static const VMStateDescription vmstate_tmp105 = {
 static void tmp105_reset_hold(Object *obj, ResetType type)
 {
     TMP105State *s = TMP105(obj);
+    const TMP105Class *tc = TMP105_GET_CLASS(s);
 
     s->temperature = 0;
     s->pointer = 0;
     s->config = 0;
-    s->faults = tmp105_faultq[FIELD_EX8(s->config, CONFIG, FAULT_QUEUE)];
+    s->faults = tc->faultq[FIELD_EX8(s->config, CONFIG, FAULT_QUEUE)];
     s->fault_count = 0;
     s->alarm = 0;
     s->detect_falling = false;
@@ -371,11 +415,25 @@ static void tmp105_initfn(Object *obj)
                                     "Temperature, in millidegrees Celsius");
 }
 
+/*
+ * Fault-queue length selected by Config F1:F0. Row 0 (1/2/4/6) is used by the
+ * TMP105, TMP175 and LM75B; row 1 (1/2/3/4) by the TMP75.
+ */
+static const uint8_t tmp105_faultq[][4] = {
+    { 1, 2, 4, 6 },
+    { 1, 2, 3, 4 },
+};
+
+/* The F1:F0 field must never index past a fault-queue table row. */
+QEMU_BUILD_BUG_ON((1 << R_CONFIG_FAULT_QUEUE_LENGTH) - 1 >=
+                  ARRAY_SIZE(tmp105_faultq[0]));
+
 static void tmp105_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
+    TMP105Class *tc = TMP105_CLASS(klass);
 
     dc->realize = tmp105_realize;
     k->event = tmp105_event;
@@ -383,19 +441,71 @@ static void tmp105_class_init(ObjectClass *klass, const void *data)
     k->send = tmp105_tx;
     rc->phases.hold = tmp105_reset_hold;
     dc->vmsd = &vmstate_tmp105;
+
+    tc->faultq = tmp105_faultq[0];
+    tc->config_wmask = 0xff;
+    tc->fixed_res = -1;
+    tc->limit_lsb_mask = 0xf0;
+    tc->tm_change_clears_alert = false;
+}
+
+static void tmp175_class_init(ObjectClass *klass, const void *data)
+{
+    TMP105Class *tc = TMP105_CLASS(klass);
+
+    tc->faultq = tmp105_faultq[0];
+    tc->config_wmask = 0xff;
+    tc->fixed_res = -1;
+    tc->limit_lsb_mask = 0xf0;
+    tc->tm_change_clears_alert = false;
+}
+
+static void tmp75_class_init(ObjectClass *klass, const void *data)
+{
+    TMP105Class *tc = TMP105_CLASS(klass);
+
+    tc->faultq = tmp105_faultq[1];
+    tc->config_wmask = 0xff;
+    tc->fixed_res = -1;
+    tc->limit_lsb_mask = 0xf0;
+    tc->tm_change_clears_alert = true;
+}
+
+static void lm75b_class_init(ObjectClass *klass, const void *data)
+{
+    TMP105Class *tc = TMP105_CLASS(klass);
+
+    tc->faultq = tmp105_faultq[0];
+    tc->config_wmask = 0x1f;
+    tc->fixed_res = 2;
+    tc->limit_lsb_mask = 0x80;
+    tc->tm_change_clears_alert = false;
 }
 
-static const TypeInfo tmp105_info = {
-    .name          = TYPE_TMP105,
-    .parent        = TYPE_I2C_SLAVE,
-    .instance_size = sizeof(TMP105State),
-    .instance_init = tmp105_initfn,
-    .class_init    = tmp105_class_init,
+static const TypeInfo tmp105_types[] = {
+    {
+        .name          = TYPE_TMP105,
+        .parent        = TYPE_I2C_SLAVE,
+        .instance_size = sizeof(TMP105State),
+        .class_size    = sizeof(TMP105Class),
+        .instance_init = tmp105_initfn,
+        .class_init    = tmp105_class_init,
+    },
+    {
+        .name          = TYPE_TMP175,
+        .parent        = TYPE_TMP105,
+        .class_init    = tmp175_class_init,
+    },
+    {
+        .name          = TYPE_TMP75,
+        .parent        = TYPE_TMP105,
+        .class_init    = tmp75_class_init,
+    },
+    {
+        .name          = TYPE_LM75B,
+        .parent        = TYPE_TMP105,
+        .class_init    = lm75b_class_init,
+    },
 };
 
-static void tmp105_register_types(void)
-{
-    type_register_static(&tmp105_info);
-}
-
-type_init(tmp105_register_types)
+DEFINE_TYPES(tmp105_types)
diff --git a/include/hw/sensor/tmp105.h b/include/hw/sensor/tmp105.h
index daece592e9..0698aeead7 100644
--- a/include/hw/sensor/tmp105.h
+++ b/include/hw/sensor/tmp105.h
@@ -1,5 +1,5 @@
 /*
- * Texas Instruments TMP105 Temperature Sensor
+ * Texas Instruments TMP105/TMP75/TMP175/LM75B Temperature Sensor
  *
  * Browse the data sheet:
  *
@@ -14,6 +14,10 @@
 #ifndef HW_SENSOR_TMP105_H
 #define HW_SENSOR_TMP105_H
 
+/* TMP75, TMP175 and NXP LM75B are register-compatible with TMP105. */
 #define TYPE_TMP105 "tmp105"
+#define TYPE_TMP175 "tmp175"
+#define TYPE_TMP75  "tmp75"
+#define TYPE_LM75B  "lm75b"
 
 #endif

-- 
2.50.1


