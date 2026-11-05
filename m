Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC8F606A32D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 09:31:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOtoV-0005Bx-4g; Thu, 05 Nov 2026 04:31:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtoS-00059n-Ld
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:31:16 -0500
Received: from mail-pl1-f180.google.com ([209.85.214.180])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtoQ-0007P8-If
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:31:16 -0500
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2e8f2c3ad6bso9291255ad.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 01:31:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793871073; x=1794475873;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xm/sD/tm31/bn3OopsmMC26LjJqjTVX5a9Bu1dF/zcY=;
 b=Y6TEutiZ54gPWyPm413wAWFsh8xFsh8y9QDC/cNmhP++d72x29pQgj+8AMnQHLoBBo
 Ou8wKpmapS3+tF8/DrTiv1kiQf6KZsydwgTGR18tkVsVqv/JRulo5BHBHLcjPYP3OHqx
 QQYw1g0MH3Im972QXtMGUzPCpYahdqRQ7y3is6PkGfehOlAyhlPn9Pmk8kOwOfjARIOh
 kqST429TAib68aolLufL6/mCG/4GPxZTCxxSPyhBJUyWgu2DfLOgUgONsqA2UZJUhESB
 Yny8y8W/0iY2q/A566f/fhc89aMVUmBosT7rAE6Orj+Txnf5EzLkb8d1sULmn51z5UEA
 uF6A==
X-Gm-Message-State: APuU4Z9XMZT9+485KU9Nefp8IXMIzgziO0/chFPqlQsNSponY3MCWsXi
 07NG2BH2B+NBTGAWTvKoDk/TK6/Eqn/9uVIGwep36fjhQVI5W0MATsmuzZPww4vRRqI=
X-Gm-Gg: AYBFou242OHBpsTqHr76XOMm79DFlD9Roj19rih/e6FnR92ct39T3j9mIV1OqJwht0A
 aa8z6fhfIa3dA2xU3ZVJ9G33atme143CZreqwF2dfeoRJx43vITueLkw7mbmD2UBC+RXx5GJCkJ
 xLBdCyV6hl/J8D6zZH7aBAnp9p5dSQBLReVyrV149aLj1Yq2OC4u9Q3+UDOHZCGNBR7MViEuMZm
 QpQ+ctQ7nCV52tLwZEreffZLblW1QO8ov0J8qeRDKfzMmKofHhaiUejV0UWTD/FwFuJBCyP+f0I
 wemq00jyE+o7OHd4lyw/AkjY3u+Wlnzv7St/sl08dQjiR5YjOttBjyXUYqXCZhk94wUJlC4aiy3
 RIaP0wPlhd/G7nU6cMUN5PfQIjj9/YskeGK5AfEdawFdOzFObBI1WrpRl7OJ0V4T3KdGnFuut5o
 IymXfi6NV/TZrqeEWPT/IDcQqoEXLQ881E6HXxtZCSxAyolVukJWnVJpbFOh4e6hi0i6LLIsBL9
 5AD7jDXbzGfpsIVTar18lzkcEGRCL9gsH+ZSRSKa4doQzA88JaqTSz59z3Q4NxyOcm9LmUTT4q3
 Mb4g6i8jw5gIpwTCE0rynYOSQkTHvg+CDZ+y+tRFndYrH/+E2TeeoljcXI+5LoD2QKOBTLZDJ4a
 p
X-Received: by 2002:a17:903:3c6d:b0:2e9:7ff5:5459 with SMTP id
 d9443c01a7336-2eb3649ba98mr174859035ad.15.1793871072826; 
 Thu, 05 Nov 2026 01:31:12 -0800 (PST)
Received: from localhost (118-163-122-149.hinet-ip.hinet.net.
 [118.163.122.149]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ed08bd4a4asm15819435ad.9.2026.11.05.01.31.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 01:31:12 -0800 (PST)
Date: Thu, 05 Nov 2026 17:25:53 +0800
Subject: [PATCH 1/4] hw/sensor: tmp105: add the TMP1075 variant
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-sensor-tmp1075-v1-1-d2ee5da0b880@free.fr>
References: <20261105-sensor-tmp1075-v1-0-d2ee5da0b880@free.fr>
In-Reply-To: <20261105-sensor-tmp1075-v1-0-d2ee5da0b880@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, eblot@meta.com, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793870754; l=8350;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=5w41bILkz/aCt1e3vT95QNA8REBAimprckle6TbTIxY=;
 b=YbNY2y5iO7evDzH/YK4vzAaKmjhqoUg38+xzVh5Rt4UNA4s7NoPfW3xFQy3uwDA03drjxzL5D
 CnI1N5Viv3qCKNPyAb0wMpN2wZmBE6ngk/ftkuuioKzJMxPueWctxk7
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.214.180; envelope-from=eblot.ml@gmail.com;
 helo=mail-pl1-f180.google.com
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
index ec39c31d90..3b8ccba4e3 100644
--- a/hw/sensor/tmp105.c
+++ b/hw/sensor/tmp105.c
@@ -1,5 +1,5 @@
 /*
- * Texas Instruments TMP105/TMP75/TMP175/LM75B temperature sensor.
+ * Texas Instruments TMP105/TMP75/TMP175/TMP1075/LM75B temperature sensor.
  *
  * Copyright (C) 2008 Nokia Corporation
  * Written by Andrzej Zaborowski <andrew@openedhand.com>
@@ -52,6 +52,7 @@ struct TMP105State {
 
     uint8_t pointer;
     uint8_t config;
+    uint8_t config_lsb;
     int16_t temperature;
     int16_t limit[2];
     uint8_t faults;
@@ -77,6 +78,12 @@ struct TMP105State {
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
@@ -85,6 +92,8 @@ struct TMP105Class {
     int8_t fixed_res;
     uint8_t limit_lsb_mask;
     bool tm_change_clears_alert;
+    bool config16;
+    uint16_t die_id;
 };
 
 FIELD(CONFIG, SHUTDOWN_MODE,        0, 1)
@@ -186,6 +195,13 @@ static void tmp105_read(TMP105State *s)
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
@@ -197,6 +213,9 @@ static void tmp105_read(TMP105State *s)
 
     case TMP105_REG_CONFIG:
         s->buf[s->len++] = s->config;
+        if (tc->config16) {
+            s->buf[s->len++] = s->config_lsb;
+        }
         break;
 
     case TMP105_REG_T_LOW:
@@ -221,11 +240,29 @@ static void tmp105_write(TMP105State *s)
 
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
@@ -335,6 +372,13 @@ static bool fault_count_needed(void *opaque)
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
@@ -357,6 +401,17 @@ static const VMStateDescription vmstate_tmp105_fault_count = {
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
@@ -376,6 +431,7 @@ static const VMStateDescription vmstate_tmp105 = {
     .subsections = (const VMStateDescription * const []) {
         &vmstate_tmp105_detect_falling,
         &vmstate_tmp105_fault_count,
+        &vmstate_tmp105_config_lsb,
         NULL
     }
 };
@@ -388,6 +444,7 @@ static void tmp105_reset_hold(Object *obj, ResetType type)
     s->temperature = 0;
     s->pointer = 0;
     s->config = 0;
+    s->config_lsb = tc->config16 ? 0xff : 0;
     s->faults = tc->faultq[FIELD_EX8(s->config, CONFIG, FAULT_QUEUE)];
     s->fault_count = 0;
     s->alarm = 0;
@@ -448,6 +505,8 @@ static void tmp105_class_init(ObjectClass *klass, const void *data)
     tc->fixed_res = -1;
     tc->limit_lsb_mask = 0xf0;
     tc->tm_change_clears_alert = false;
+    tc->config16 = false;
+    tc->die_id = 0;
 }
 
 static void tmp175_class_init(ObjectClass *klass, const void *data)
@@ -483,6 +542,25 @@ static void lm75b_class_init(ObjectClass *klass, const void *data)
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
@@ -507,6 +585,11 @@ static const TypeInfo tmp105_types[] = {
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


