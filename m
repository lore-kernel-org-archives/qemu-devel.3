Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F01CCA463
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHN6G-0005lc-JX; Thu, 15 Oct 2026 11:10:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHN6C-0005k4-N3
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 11:10:28 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHN6A-0001fD-Kb
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 11:10:28 -0400
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a020e65269so35810825e9.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 08:10:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792077025; x=1792681825;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OlcJaO13/HWgHXhBu0C0Yz3eZ87xrrYAWtMGnHtQsnk=;
 b=pJulP+TGNKIATfQN4o83nHA3OATP6NmB7Kl0cVf2nl6TMjNw6j5ImbrRn3x7/9TFOg
 2aSBUV/OTSGcYqHBu0lndVzY5K2he5l56dTcaNi/sUJivw9cSdzS9f7AN0scBnv0u39A
 d7LZZO03B05lR6qdWAfVy0NINSZNi/vnwxBLRPWX/44O7W2T6qDQMiniGn4pwg5DfGWi
 swmuZ8JAh8T5WENZJxAm+Z/PWCP8HFINzqaxOIntMl72IBSHNVg37n7APISXlLGUr6/g
 LBMlxcRR6ld+3lFV9kvA7EeDD+LCnDz9MgOYVwXm03cMZrt3s15LRM2tBW1EPPbz4dyQ
 6U0w==
X-Gm-Message-State: AFq9FYLJX/jobclF3ZG2qzrVTzTklXNzrrHnGh/Ty1XW/9HvAAJo5THF
 KsIlNX95IP6riozY4f8sHRVNuE32kYeu0KciyvH4Bp4+KlKze7giFKs4BXzUaw==
X-Gm-Gg: AYBFou3SmAEQiBDS9x9tLkCzpEiBxdBzmRx0YlKhjih0f3XYi8dWAPXJ1+arC03bEFI
 5+Nhu6in8/jZkuRhBOu4D9XjoPZoQrMXPFA/jkhhAONxxS3TsoaVOQ2DrQ7PgB/qOWaqctrIZEN
 XWYuWP3omer71L1nGdlRSzBJzsVaUG9i1Ttia+1GeTEytOspmIMB720XqjyORXkdpk1szzDBqto
 n6J2dlKG7s2A5gxBuGaPMfO31mlPhWz+dJ4Eig0hF74dD22isgkW0T4mFA7B276Zdvk93IyejBl
 wgzO8j0pQr/a3Enzyigclj20tNXAy3REvdxUPDMJXqzYc36LPrARBHjfaiLj+DgdjvVdZg6pGZy
 JL0QRer1r9y0Ii1O5CsAKokVAEv503ohqEkBPeZvOtOwcKwmYyH69wshBeDg0cEcwUjGrMmZLwo
 7D/r6QBuDk8bJi8bk97tp9xE0JAHOHcl2jBgEmVDbdPOgj6JMf8gMcLRYSp44rUcvu6ap38lYOn
 LnYc1rB77BDxIMauGopeMIalyoL6amdQ+5XZ0DjJqIROQ==
X-Received: by 2002:a05:600c:3e8f:b0:4a0:1c0e:b057 with SMTP id
 5b1f17b1804b1-4a18e44653cmr399949475e9.4.1792077025117; 
 Thu, 15 Oct 2026 08:10:25 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd96f9a0sm75740515e9.1.2026.10.15.08.10.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 08:10:23 -0700 (PDT)
Date: Thu, 15 Oct 2026 13:57:43 +0200
Subject: [PATCH 05/22] hw/sensor: tmp421: honor per-variant channels and
 channel enablement
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-bmc-clemente-v1-5-bf591886b5b6@free.fr>
References: <20261015-bmc-clemente-v1-0-bf591886b5b6@free.fr>
In-Reply-To: <20261015-bmc-clemente-v1-0-bf591886b5b6@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792065465; l=6605;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=YX60yitZnrhatj4jjBlP51Qv1RKMFJvzEHfnfBzeo04=;
 b=kUaFbYlvh4B8rmDjh265ZPMM7QwzqZqcCCi0ck8Vu0/3/WJ0IMfOBLSbZjYBoFQZUwG7dEK4S
 ZbUnuBfKYecBFqqCKi9HYy0Kxx20dpgFgnUjcaTYF+Fe7sAzGXaUNV4
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.53; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f53.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
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
index 7f0e3b3214..8bacd7d05e 100644
--- a/hw/sensor/tmp421.c
+++ b/hw/sensor/tmp421.c
@@ -59,6 +59,7 @@ struct TMP421Class {
     I2CSlaveClass parent_class;
 
     uint8_t device_id;
+    uint8_t nchannels;      /* local + remote */
     uint8_t config2_reset;
 };
 
@@ -159,12 +160,50 @@ static void tmp421_set_temperature(Object *obj, Visitor *v, const char *name,
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
@@ -184,35 +223,8 @@ static void tmp421_read(TMP421State *s)
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
@@ -316,6 +328,19 @@ static void tmp421_reset_hold(Object *obj, ResetType type)
     tmp421_reset(TMP421(obj));
 }
 
+static void tmp421_initfn(Object *obj)
+{
+    TMP421Class *sc = TMP421_GET_CLASS(obj);
+
+    for (unsigned channel = 0; channel < sc->nchannels; channel++) {
+        g_autofree char *name = g_strdup_printf("temperature%u", channel);
+
+        object_property_add(obj, name, "int",
+                            tmp421_get_temperature,
+                            tmp421_set_temperature, NULL, NULL);
+    }
+}
+
 static void tmp421_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -331,19 +356,7 @@ static void tmp421_class_init(ObjectClass *klass, const void *data)
 
     sc->device_id = TMP421_DEVICE_ID;
     sc->config2_reset = 0x1c;
-
-    object_class_property_add(klass, "temperature0", "int",
-                              tmp421_get_temperature,
-                              tmp421_set_temperature, NULL, NULL);
-    object_class_property_add(klass, "temperature1", "int",
-                              tmp421_get_temperature,
-                              tmp421_set_temperature, NULL, NULL);
-    object_class_property_add(klass, "temperature2", "int",
-                              tmp421_get_temperature,
-                              tmp421_set_temperature, NULL, NULL);
-    object_class_property_add(klass, "temperature3", "int",
-                              tmp421_get_temperature,
-                              tmp421_set_temperature, NULL, NULL);
+    sc->nchannels = 2;
 }
 
 static void tmp422_class_init(ObjectClass *klass, const void *data)
@@ -352,6 +365,7 @@ static void tmp422_class_init(ObjectClass *klass, const void *data)
 
     sc->device_id = TMP422_DEVICE_ID;
     sc->config2_reset = 0x3c;
+    sc->nchannels = 3;
 }
 
 static void tmp423_class_init(ObjectClass *klass, const void *data)
@@ -360,6 +374,7 @@ static void tmp423_class_init(ObjectClass *klass, const void *data)
 
     sc->device_id = TMP423_DEVICE_ID;
     sc->config2_reset = 0x7c;
+    sc->nchannels = 4;
 }
 
 static const TypeInfo tmp421_types[] = {
@@ -367,6 +382,7 @@ static const TypeInfo tmp421_types[] = {
         .name          = TYPE_TMP421,
         .parent        = TYPE_I2C_SLAVE,
         .instance_size = sizeof(TMP421State),
+        .instance_init = tmp421_initfn,
         .class_size    = sizeof(TMP421Class),
         .class_init    = tmp421_class_init,
     },

-- 
2.53.0-Meta


