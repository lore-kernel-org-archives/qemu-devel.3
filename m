Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E302D606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 09:29:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOtlp-0006mX-8K; Thu, 05 Nov 2026 04:28:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtln-0006la-8E
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:28:31 -0500
Received: from mail-pf1-f170.google.com ([209.85.210.170])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtll-0006wV-8R
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:28:31 -0500
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-8a06ca6e8f4so1194603b3a.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 01:28:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793870908; x=1794475708;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+suPbMsR1vu1zaODmsUiMWxPqqQ6tFYXADKAIU1mPbw=;
 b=kW/BPmZ7HHB2HkcSujE10ONcVE9S/Qn3Svqg6jhlMxsgQcoHyENhbviEyY8A7dHPCH
 0LBl0qnLpxlfrQytfzHYYiqvK66WWCeAALKeamIYDr810nY8Ukmfc7TVzaLVKGZes01/
 h9UqF6qDkt7+qq9f8CSGEA5T2Vxu1WLDA2HQBtPVLBW+A9Nk2LVbSif+A16uK22WDZjp
 y/m+UwJo55/ZqdmA92NfE3k/o5Mt+hAqKXiZyN3RfrNHVmvTPebCUlrF88wTMfupM0dO
 rH0QsY9XELgGmgbkrKi/wKNlN5GOSNqnhgYsNhwiyIlI1E6io7Trm0tl3cDSrdLg3WqJ
 2/kQ==
X-Gm-Message-State: APuU4Z/gRgDSnUzFT0i7Gprqj8N/pD8qnXfqFDSdNOvvD5rAolxvhTLv
 GD4HV121rgX0L1f1BYEUAQLe/bvBdBhOoRiBJj09ZOxRjMYsxa+qhap4ipE0Irry12U=
X-Gm-Gg: AYBFou3safU6I+pEXE0jP4k1MmIfQi/EXkXPxJbZMXqUaBusY3FhsGbsB1qik3gD0pk
 CKcxMM0rQB2cdCUvwdOlHj87Mj2D5aQZ1WKMjx3HhoD1Gm3rAKpjzOao1daWsXTuT3aGje3E7FQ
 mdPsqhneHdDPRqcKBnN2zc75by0GGxuD16oTQqwxypypNeMmtVSV/vCjlvHA+DlKbu07FqVT18X
 QOlXoe9F9lZ1YuhCPCbliMi+AF+NK+Wd3x9oOhl+mBf1fWIFCFniQrh/GVe7QUH4Sjpzd1WMaBx
 1wqIrJRNwHBtPseU+r92BwWEU5nUywHoj0HQD9yYZLjztCVi2WFsE59UkiQ8l90OR+gkxe+cAjz
 FI7Wvt7A5wVoa9wv7Zu6LlpdB8qsGZ0F2kzJl/BVb5AITvimhxwSSDzudTcoO696OCsDE50b0lu
 PtcH6AjPsG/WHCcpZ4l+7/8c3J9ObSfuP7rnNXndeM33vUaKttLNWBvQEEyUChs2DcqvXD/oxvf
 k73esWCEkC0oX+mVA1tEGdq7E3tpBkzodVEkCGRfWGGo5MjJUHSvw/2F2JZeVOX6DGDbBvUUb7/
 yFMUqFI047eguB+QBD46W3N1Ed1H2zJEZl8jahDJaxPupSwVMxZrl4CEAgvUOMKkPky32yDC7YN
 f0A==
X-Received: by 2002:a05:6a21:8809:b0:3e1:4527:6350 with SMTP id
 adf61e73a8af0-3e928e16ca9mr13721379637.64.1793870907760; 
 Thu, 05 Nov 2026 01:28:27 -0800 (PST)
Received: from localhost (118-163-122-149.hinet-ip.hinet.net.
 [118.163.122.149]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdb4696e816sm1932872a12.21.2026.11.05.01.28.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 01:28:27 -0800 (PST)
Date: Thu, 05 Nov 2026 17:25:44 +0800
Subject: [PATCH 05/16] hw/sensor: tmp421: honor per-variant channels and
 channel enablement
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-sensor-tmp421-v1-5-c46853f5e1f0@free.fr>
References: <20261105-sensor-tmp421-v1-0-c46853f5e1f0@free.fr>
In-Reply-To: <20261105-sensor-tmp421-v1-0-c46853f5e1f0@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, eblot@meta.com, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793870742; l=6685;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=+W2zIGfj7hBkjPmQ3jaAWE9dEU5f8/eNZKicFOoIYr0=;
 b=XwPMkxH+yZR+KZ6WEj57vPk3hiNYNKwA3ZJ1781t+taXKEAwcu2FwhQrvfiz8bQqtOpFdfn+7
 K4Av9f9d3hBC/u0F+y8fESd9Takik9fjpHPPhN1olQY4WVIuWGhA6ny
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.210.170; envelope-from=eblot.ml@gmail.com;
 helo=mail-pf1-f170.google.com
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

Each part exposes a different number of temperature channels; register
only the temperature properties that exist and gate the temperature
register reads on both channel presence and the configuration enable
bits. A disabled or absent channel now reads back zero instead of stale
data, resolving the long-standing FIXME.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/sensor/tmp421.c | 100 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 58 insertions(+), 42 deletions(-)

diff --git a/hw/sensor/tmp421.c b/hw/sensor/tmp421.c
index ef738b821e..5bb5043839 100644
--- a/hw/sensor/tmp421.c
+++ b/hw/sensor/tmp421.c
@@ -60,6 +60,7 @@ struct TMP421Class {
     I2CSlaveClass parent_class;
 
     uint8_t device_id;
+    uint8_t nchannels;      /* local + remote */
     uint8_t config2_reset;
 };
 
@@ -160,12 +161,50 @@ static void tmp421_set_temperature(Object *obj, Visitor *v, const char *name,
     s->temperature[tempid] = (int16_t) ((temp * 256 - 128) / 1000) + offset;
 }
 
+static bool tmp421_channel_enabled(TMP421State *s, unsigned channel)
+{
+    TMP421Class *sc = TMP421_GET_CLASS(s);
+
+    return channel < sc->nchannels &&
+           (s->config[1] & (1 << (3 + channel)));
+}
+
+/*
+ * A disabled or absent channel reads back zero. The low byte carries the
+ * temperature fraction in its upper nibble.
+ */
+static uint8_t tmp421_temp_high(TMP421State *s, unsigned channel)
+{
+    uint16_t reg = s->temperature[channel];
+
+    return tmp421_channel_enabled(s, channel) ? reg >> 8 : 0;
+}
+
+static uint8_t tmp421_temp_low(TMP421State *s, unsigned channel)
+{
+    uint16_t reg = s->temperature[channel];
+
+    return tmp421_channel_enabled(s, channel) ? reg & 0xf0 : 0;
+}
+
 static void tmp421_read(TMP421State *s)
 {
     TMP421Class *sc = TMP421_GET_CLASS(s);
 
     s->len = 0;
 
+    if (s->pointer <= TMP421_TEMP_MSB3) {
+        /* high byte read latches the paired low byte from one conversion */
+        unsigned channel = s->pointer - TMP421_TEMP_MSB0;
+        s->buf[s->len++] = tmp421_temp_high(s, channel);
+        s->buf[s->len++] = tmp421_temp_low(s, channel);
+        return;
+    }
+    if (s->pointer >= TMP421_TEMP_LSB0 && s->pointer <= TMP421_TEMP_LSB3) {
+        s->buf[s->len++] = tmp421_temp_low(s, s->pointer - TMP421_TEMP_LSB0);
+        return;
+    }
+
     switch (s->pointer) {
     case TMP421_MANUFACTURER_ID_REG:
         s->buf[s->len++] = TMP421_MANUFACTURER_ID;
@@ -185,35 +224,8 @@ static void tmp421_read(TMP421State *s)
     case TMP421_STATUS_REG:
         s->buf[s->len++] = s->status;
         break;
-
-        /* FIXME: check for channel enablement in config registers */
-    case TMP421_TEMP_MSB0:
-        s->buf[s->len++] = (((uint16_t) s->temperature[0]) >> 8);
-        s->buf[s->len++] = (((uint16_t) s->temperature[0]) >> 0) & 0xf0;
-        break;
-    case TMP421_TEMP_MSB1:
-        s->buf[s->len++] = (((uint16_t) s->temperature[1]) >> 8);
-        s->buf[s->len++] = (((uint16_t) s->temperature[1]) >> 0) & 0xf0;
-        break;
-    case TMP421_TEMP_MSB2:
-        s->buf[s->len++] = (((uint16_t) s->temperature[2]) >> 8);
-        s->buf[s->len++] = (((uint16_t) s->temperature[2]) >> 0) & 0xf0;
-        break;
-    case TMP421_TEMP_MSB3:
-        s->buf[s->len++] = (((uint16_t) s->temperature[3]) >> 8);
-        s->buf[s->len++] = (((uint16_t) s->temperature[3]) >> 0) & 0xf0;
-        break;
-    case TMP421_TEMP_LSB0:
-        s->buf[s->len++] = (((uint16_t) s->temperature[0]) >> 0) & 0xf0;
-        break;
-    case TMP421_TEMP_LSB1:
-        s->buf[s->len++] = (((uint16_t) s->temperature[1]) >> 0) & 0xf0;
-        break;
-    case TMP421_TEMP_LSB2:
-        s->buf[s->len++] = (((uint16_t) s->temperature[2]) >> 0) & 0xf0;
-        break;
-    case TMP421_TEMP_LSB3:
-        s->buf[s->len++] = (((uint16_t) s->temperature[3]) >> 0) & 0xf0;
+    default:
+        s->buf[s->len++] = 0;
         break;
     }
 }
@@ -317,6 +329,19 @@ static void tmp421_reset_hold(Object *obj, ResetType type)
     tmp421_reset(TMP421(obj));
 }
 
+static void tmp421_initfn(Object *obj)
+{
+    TMP421Class *sc = TMP421_GET_CLASS(obj);
+
+    for (unsigned channel = 0; channel < sc->nchannels; channel++) {
+        g_autofree char *name = g_strdup_printf("temperature%u", channel);
+
+        object_property_add(obj, name, "int", &int_type_info,
+                            tmp421_get_temperature,
+                            tmp421_set_temperature, NULL, NULL);
+    }
+}
+
 static void tmp421_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -332,19 +357,7 @@ static void tmp421_class_init(ObjectClass *klass, const void *data)
 
     sc->device_id = TMP421_DEVICE_ID;
     sc->config2_reset = 0x1c;
-
-    object_class_property_add(klass, "temperature0", "int", &int_type_info,
-                              tmp421_get_temperature,
-                              tmp421_set_temperature, NULL, NULL);
-    object_class_property_add(klass, "temperature1", "int", &int_type_info,
-                              tmp421_get_temperature,
-                              tmp421_set_temperature, NULL, NULL);
-    object_class_property_add(klass, "temperature2", "int", &int_type_info,
-                              tmp421_get_temperature,
-                              tmp421_set_temperature, NULL, NULL);
-    object_class_property_add(klass, "temperature3", "int", &int_type_info,
-                              tmp421_get_temperature,
-                              tmp421_set_temperature, NULL, NULL);
+    sc->nchannels = 2;
 }
 
 static void tmp422_class_init(ObjectClass *klass, const void *data)
@@ -353,6 +366,7 @@ static void tmp422_class_init(ObjectClass *klass, const void *data)
 
     sc->device_id = TMP422_DEVICE_ID;
     sc->config2_reset = 0x3c;
+    sc->nchannels = 3;
 }
 
 static void tmp423_class_init(ObjectClass *klass, const void *data)
@@ -361,6 +375,7 @@ static void tmp423_class_init(ObjectClass *klass, const void *data)
 
     sc->device_id = TMP423_DEVICE_ID;
     sc->config2_reset = 0x7c;
+    sc->nchannels = 4;
 }
 
 static const TypeInfo tmp421_types[] = {
@@ -368,6 +383,7 @@ static const TypeInfo tmp421_types[] = {
         .name          = TYPE_TMP421,
         .parent        = TYPE_I2C_SLAVE,
         .instance_size = sizeof(TMP421State),
+        .instance_init = tmp421_initfn,
         .class_size    = sizeof(TMP421Class),
         .class_init    = tmp421_class_init,
     },

-- 
2.53.0-Meta


