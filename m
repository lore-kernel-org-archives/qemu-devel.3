Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A12FCCA463
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:12:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHN88-0001JH-TU; Thu, 15 Oct 2026 11:12:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHN85-0001DE-RS
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 11:12:26 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHN83-0001zN-6u
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 11:12:25 -0400
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a02718da81so43636195e9.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 08:12:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792077142; x=1792681942;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Wz917+uBupSyWRH1dqvy7enyaP5Nw7m4IxLZ4sXKP08=;
 b=QQSfttJvyVJVDPMmM1/Fti7GEa5ACYw8r0fFY9GUC9TeNkCleybLV2zhk6jCdA2o6G
 ujPTUZo8nva97T7laK67bHPh/edmpA3mOuZaX9Kni0vnbePBWiA+Yp6shmZ4iOXgHo2R
 ONIfXFuZfJk02BVwrpFUF7UsLSvujjlYRdwm4krSJR2XNRZqLkjuE+y0hBFjMCzjLrgm
 OpW3H2ikZwqS4CLwMfzX4UfHLbVHK445Rt0tQldyBKu/ZoqC6Gi5gC+BN+5aQ+9g9jh3
 ycJd8AdxjmTOEqPS/pHoT6LeukOniV1B9UHuWd3y0G5HXt/wNJxiXX1mPxR984ivuexB
 PNGg==
X-Gm-Message-State: AFq9FYIcxa/yJPB54lo+MPnP0pN3TOC+NTwEpcCb6FpSFOo/oBbsowyl
 e+/8DoLbiUX+Mm5LYvHvnvESKsZLCybAqvdOeYPaJ0kJtZ0/75UMV91rxWeYDg==
X-Gm-Gg: AYBFou1F/0fBgXyHpVl5jbHvgEs+vScV/7FVtQC/c5dGzc4YMsA3NdkdjNoOyGPcS5R
 7TpSTF9kXOPwkEPmxl+kCzvKAIQfChBNSRNKMu14pyhG7vHwGJg+cE05X5oe4rkHaKHuS6Sz0Nh
 4wS4Wrrmw4xyIp4kk9tmU9qhfkI8FaU3sQufMVhJogF7qf6TJukLRKCvdtsn0w0F4voJb+As4kF
 ZB3BTIeEO2vZugpPFFtaRHJqbTrVfNM9PKw4cI6o/wws65gF6+k5vhn1YIaMcfzNBa53VWvy2K5
 +YLbb7pR3Qh9XQ6xT2sNAz9Mq9AORdIfKwF7mXj4M/93M++3FOLxQfORDRQvKry9v6S9w157Ixm
 j1teEd5ut0O+8SlQ3LoGWO5EoUHEv9HOzrYaPcdNyYt9ROKnu1gAVaSj+0gR5aRjfDtcNVj7jIQ
 7I2fGk6/POysgw8QEnAoQ/O+snbXftmO5rjZ0iZ7atrd3b569tbhvAqEkfWLkV/P5rt3S5eKGRJ
 jJf8Pi2Uchdsc4J1j4NzfmQo33zHq0QtwRK2o0kieh46Q==
X-Received: by 2002:a05:600c:3e8c:b0:49e:6861:50f7 with SMTP id
 5b1f17b1804b1-4a18e49d251mr364033375e9.5.1792077141562; 
 Thu, 15 Oct 2026 08:12:21 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bdc036a4sm89459775e9.11.2026.10.15.08.12.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 08:12:18 -0700 (PDT)
Date: Thu, 15 Oct 2026 13:57:55 +0200
Subject: [PATCH 17/22] hw/sensor: tmp105: add the TMP1075 variant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-bmc-clemente-v1-17-bf591886b5b6@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792065465; l=8350;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=yuPMFyntZoIKyBRcJ/PEi8kqrviD7nEvWLABiSDbjNo=;
 b=/DA700DdktBm2jgRRZSTsxbDMloG3YmYfPNerMT57DG19YJKNpl9DW+QpjizHHP69k5VTXGJ1
 KglcVC35cvCAUOe4+pG4+d+/VPjKCThuaLhgsteQZdmlyJwqku8Df3G
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.43; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f43.google.com
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

The TMP1075 is register-compatible with the xx75 family but widens the
Config register to 16 bits and adds a read-only Device ID register.
Model it as a new variant of the shared TMP105 device: the control bits
keep the legacy layout in the upper byte, the lower byte has no function
of its own but is writable, and single-byte access stays compatible with
the 8-bit parts. The converter is fixed at 12 bits and the fault queue
matches the TMP75.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/sensor/tmp105.c              | 85 ++++++++++++++++++++++++++++++++++++++++-
 include/hw/sensor/tmp105.h      |  2 +
 include/hw/sensor/tmp105_regs.h |  5 +++
 3 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/hw/sensor/tmp105.c b/hw/sensor/tmp105.c
index ece0650d70..c5aa553d9a 100644
--- a/hw/sensor/tmp105.c
+++ b/hw/sensor/tmp105.c
@@ -1,5 +1,5 @@
 /*
- * Texas Instruments TMP105/TMP75/TMP175/LM75B temperature sensor.
+ * Texas Instruments TMP105/TMP75/TMP175/TMP1075/LM75B temperature sensor.
  *
  * Copyright (C) 2008 Nokia Corporation
  * Written by Andrzej Zaborowski <andrew@openedhand.com>
@@ -51,6 +51,7 @@ struct TMP105State {
 
     uint8_t pointer;
     uint8_t config;
+    uint8_t config_lsb;
     int16_t temperature;
     int16_t limit[2];
     uint8_t faults;
@@ -76,6 +77,12 @@ struct TMP105State {
  * @fixed_res: converter resolution field pinned by the device, or -1 when it is
  * software-selectable.
  * @limit_lsb_mask: low-byte mask applied to the T_LOW/T_HIGH limit registers.
+ * @config16: the Config register is 16 bits wide over I2C. Its control bits
+ * occupy the upper byte (mirroring the 8-bit layout); the lower byte has no
+ * function of its own but is writable, and comes up as 0xff. Single-byte
+ * access stays compatible with the 8-bit parts.
+ * @die_id: value of the read-only Device ID register, or 0 when the device has
+ * none.
  */
 struct TMP105Class {
     I2CSlaveClass parent_class;
@@ -84,6 +91,8 @@ struct TMP105Class {
     int8_t fixed_res;
     uint8_t limit_lsb_mask;
     bool tm_change_clears_alert;
+    bool config16;
+    uint16_t die_id;
 };
 
 FIELD(CONFIG, SHUTDOWN_MODE,        0, 1)
@@ -185,6 +194,13 @@ static void tmp105_read(TMP105State *s)
         tmp105_interrupt_update(s);
     }
 
+    if (tc->die_id && (s->pointer & 0x0f) == TMP105_REG_DIE_ID) {
+        s->buf[s->len++] = tc->die_id >> 8;
+        s->buf[s->len++] = tc->die_id & 0xff;
+        trace_tmp105_read(s->parent_obj.address, s->pointer);
+        return;
+    }
+
     switch (s->pointer & 3) {
     case TMP105_REG_TEMPERATURE:
         res = tc->fixed_res >= 0 ? tc->fixed_res :
@@ -196,6 +212,9 @@ static void tmp105_read(TMP105State *s)
 
     case TMP105_REG_CONFIG:
         s->buf[s->len++] = s->config;
+        if (tc->config16) {
+            s->buf[s->len++] = s->config_lsb;
+        }
         break;
 
     case TMP105_REG_T_LOW:
@@ -220,11 +239,29 @@ static void tmp105_write(TMP105State *s)
 
     trace_tmp105_write(s->parent_obj.address, s->pointer);
 
+    if (tc->die_id && (s->pointer & 0x0f) == TMP105_REG_DIE_ID) {
+        return; /* Device ID register is read-only */
+    }
+
     switch (s->pointer & 3) {
     case TMP105_REG_TEMPERATURE:
         break;
 
     case TMP105_REG_CONFIG:
+        /*
+         * The control bits live in the first data byte for every variant (the
+         * upper byte of the TMP1075 16-bit register); a second byte is the low
+         * byte, which drives nothing but keeps what it is given.
+         */
+        if (s->len == 3) {
+            if (tc->config16) {
+                s->config_lsb = s->buf[1];
+            }
+            break;
+        }
+        if (s->len != 2) {
+            break;
+        }
         config = s->buf[0] & tc->config_wmask;
         if (FIELD_EX8(config & ~s->config, CONFIG, SHUTDOWN_MODE)) {
             trace_tmp105_write_shutdown(s->parent_obj.address);
@@ -334,6 +371,13 @@ static bool fault_count_needed(void *opaque)
     return s->fault_count != 0;
 }
 
+static bool config_lsb_needed(void *opaque)
+{
+    TMP105State *s = opaque;
+
+    return TMP105_GET_CLASS(s)->config16 && s->config_lsb != 0xff;
+}
+
 static const VMStateDescription vmstate_tmp105_detect_falling = {
     .name = "TMP105/detect-falling",
     .version_id = 1,
@@ -356,6 +400,17 @@ static const VMStateDescription vmstate_tmp105_fault_count = {
     }
 };
 
+static const VMStateDescription vmstate_tmp105_config_lsb = {
+    .name = "TMP105/config-lsb",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = config_lsb_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT8(config_lsb, TMP105State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_tmp105 = {
     .name = "TMP105",
     .version_id = 0,
@@ -375,6 +430,7 @@ static const VMStateDescription vmstate_tmp105 = {
     .subsections = (const VMStateDescription * const []) {
         &vmstate_tmp105_detect_falling,
         &vmstate_tmp105_fault_count,
+        &vmstate_tmp105_config_lsb,
         NULL
     }
 };
@@ -387,6 +443,7 @@ static void tmp105_reset_hold(Object *obj, ResetType type)
     s->temperature = 0;
     s->pointer = 0;
     s->config = 0;
+    s->config_lsb = tc->config16 ? 0xff : 0;
     s->faults = tc->faultq[FIELD_EX8(s->config, CONFIG, FAULT_QUEUE)];
     s->fault_count = 0;
     s->alarm = 0;
@@ -447,6 +504,8 @@ static void tmp105_class_init(ObjectClass *klass, const void *data)
     tc->fixed_res = -1;
     tc->limit_lsb_mask = 0xf0;
     tc->tm_change_clears_alert = false;
+    tc->config16 = false;
+    tc->die_id = 0;
 }
 
 static void tmp175_class_init(ObjectClass *klass, const void *data)
@@ -482,6 +541,25 @@ static void lm75b_class_init(ObjectClass *klass, const void *data)
     tc->tm_change_clears_alert = false;
 }
 
+/*
+ * The TMP1075 fixes the converter at 12 bits (its R1:R0 bits select the
+ * conversion rate instead, which this instantaneous model does not track), uses
+ * the TMP75 fault-queue mapping, exposes a 16-bit Config register and answers
+ * the Device ID register with 0x7500.
+ */
+static void tmp1075_class_init(ObjectClass *klass, const void *data)
+{
+    TMP105Class *tc = TMP105_CLASS(klass);
+
+    tc->faultq = tmp105_faultq[1];
+    tc->config_wmask = 0xff;
+    tc->fixed_res = 3;
+    tc->limit_lsb_mask = 0xf0;
+    tc->tm_change_clears_alert = true;
+    tc->config16 = true;
+    tc->die_id = TMP1075_DEVICE_ID;
+}
+
 static const TypeInfo tmp105_types[] = {
     {
         .name          = TYPE_TMP105,
@@ -506,6 +584,11 @@ static const TypeInfo tmp105_types[] = {
         .parent        = TYPE_TMP105,
         .class_init    = lm75b_class_init,
     },
+    {
+        .name          = TYPE_TMP1075,
+        .parent        = TYPE_TMP105,
+        .class_init    = tmp1075_class_init,
+    },
 };
 
 DEFINE_TYPES(tmp105_types)
diff --git a/include/hw/sensor/tmp105.h b/include/hw/sensor/tmp105.h
index 0698aeead7..6a30504c7c 100644
--- a/include/hw/sensor/tmp105.h
+++ b/include/hw/sensor/tmp105.h
@@ -19,5 +19,7 @@
 #define TYPE_TMP175 "tmp175"
 #define TYPE_TMP75  "tmp75"
 #define TYPE_LM75B  "lm75b"
+/* TMP1075 adds a 16-bit Config register and a Device ID register. */
+#define TYPE_TMP1075 "tmp1075"
 
 #endif
diff --git a/include/hw/sensor/tmp105_regs.h b/include/hw/sensor/tmp105_regs.h
index ef015ee5cf..ecd0510c2e 100644
--- a/include/hw/sensor/tmp105_regs.h
+++ b/include/hw/sensor/tmp105_regs.h
@@ -21,6 +21,7 @@
  * @TMP105_REG_CONFIG: Configuration register
  * @TMP105_REG_T_LOW: Low temperature register (also known as T_hyst)
  * @TMP105_REG_T_HIGH: High temperature register (also known as T_OS)
+ * @TMP105_REG_DIE_ID: Device ID register (TMP1075 only)
  *
  * The following temperature sensors are
  * compatible with the TMP105 registers:
@@ -46,6 +47,10 @@ typedef enum TMP105Reg {
     TMP105_REG_CONFIG,
     TMP105_REG_T_LOW,
     TMP105_REG_T_HIGH,
+    TMP105_REG_DIE_ID = 0x0f,
 } TMP105Reg;
 
+/* Value returned by the TMP1075 Device ID register. */
+#define TMP1075_DEVICE_ID 0x7500
+
 #endif

-- 
2.53.0-Meta


