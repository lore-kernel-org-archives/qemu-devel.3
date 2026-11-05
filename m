Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8357E606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 09:29:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOtlm-0006kD-4y; Thu, 05 Nov 2026 04:28:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtlg-0006gg-Nt
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:28:25 -0500
Received: from mail-pj1-f41.google.com ([209.85.216.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtld-0006vv-La
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:28:23 -0500
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-3ae1b34e0d2so239925a91.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 01:28:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793870900; x=1794475700;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UjYfulFHyJfR33AHhkVMSYX3bW2RiBBj5I0jLkWcpgI=;
 b=xN/Q/aePFlX5v5nO0FEDYxVe/xRDQWuWbBAyjQ3G0C3K3S1cmkwMmvdGgGG64CUeSg
 8ck1aaLv3znzM6locXCIrtOJxgD4wL9ZiQV1mlf1cWrPD/xTnO16a/Akg0Y1VOVWE0Yt
 dQGF1DOF65RkhTt/sTtmslVhmyo7GaklAeu7ZCp46NVl5mSyM9idkSRjRwd+uN7Phvvr
 FnvpHOO21I3h6o2kxlxP2Vja2vZdgj9/BbGLGyJTSA0mAAF8BPiXVn3+DafH9ZBNWTF5
 XegaNrzW/ROwk0LllMXCpNIRuwrqt3OTTj14J6GrX02Tx4SKn0nNO1h6yzRFf3nwUspC
 zguQ==
X-Gm-Message-State: APuU4Z+D3Dkx860347JJ2I4hSp+/lK8MhDFBNGtWQmcZ5/LOTO/6zTSd
 UgsauyFDb34Jw9p8wlMeyOJHQkD2pe2A5vY8kKIB3tzGoWhqvROlCyNVKos3my33Quk=
X-Gm-Gg: AYBFou1JR1Tl6ZXnzf2xMerz/Xsf1jkg/j+SFQ68ZcBkdiikvpQF9vZ7dIq9kqX6Xla
 ZjI8WopKiEGVhEt1MLWJppPyW+kh0in3vMCyKFJW0kS4rJGo/uJNDi2QfsBFv5Bxo818k+VBH5V
 6svx6O2ZqqE1wstJXp23Iuu8NnWGXLsyEwfso+h5ScZva5el4wszEMykMV2WAmPSW6uSDvFaK3w
 k5onpuBVXvNhvJxJMAKUhQ+N/fomrV0A+BV1v9UVQqbXwVjrZ5M6doMiEa1wdxBaMsTP3J12FEf
 0DrTiTxp0ngURd/5+L6AUV5PZY0hjMXQMUvlt0nFmEEQMoZd4L6DWj1EFBrABG36Yl9czEA4v5P
 M1SiFwzOFAbOD9kITruDiYPMPZsx3nV9/ZLgmku2Vsa6F5XwnYbaT5Y/ZrElafiB0/Ot1Yr2GUE
 L/xxVEX1pHw43fdmdCpP+eyMG5oNEEJUPf1LKfXkoTQ8sC1GUXa7OvV7tRgdPTHqSFcJbhEnjKy
 jKpnXMcWghXWKw2LPgWZ/xY2kMflz4w+eYTJcF+yJuN36aF34M5JE53lduurNMtT54b2mbbxWIW
 LuhsaGdd+IvDzN2Ka0EL87xUXLBsg9u8jxo5LpaI2jR/A/0iG4t2LzNWpxMNfHnvr747GLa7rrP
 D
X-Received: by 2002:a17:90b:4c8b:b0:3ac:9785:4c31 with SMTP id
 98e67ed59e1d1-3b0afe019d2mr1406354a91.27.1793870899727; 
 Thu, 05 Nov 2026 01:28:19 -0800 (PST)
Received: from localhost (118-163-122-149.hinet-ip.hinet.net.
 [118.163.122.149]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdb46974b71sm2019700a12.23.2026.11.05.01.28.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 01:28:18 -0800 (PST)
Date: Thu, 05 Nov 2026 17:25:43 +0800
Subject: [PATCH 04/16] hw/sensor: tmp421: model device variants with a
 class descriptor
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-sensor-tmp421-v1-4-c46853f5e1f0@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793870742; l=4921;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=hSZTxm4I3qUs71e4HVoKOMQNOX84Cl1z8VgaKmWCp30=;
 b=SK3nwkCebWzeftPfvl/g7aOu/JfLj+e7MUI/MeyW+WNQaIGYI5aBFK9fcOzbB9ngi/ZrZ2NsE
 nl39xBLO8UDDGDohGKlOsqv/Vl+D5qqlYYOnqEFvOMFOJKpKXDFML3v
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.216.41; envelope-from=eblot.ml@gmail.com;
 helo=mail-pj1-f41.google.com
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
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace the ad-hoc DeviceInfo table and its manual type-registration
loop with per-variant fields on the device class, set by a dedicated
class_init for each part and registered through DEFINE_TYPES. This
drops the abstract base type in favour of the TMP421 acting as the base
for its TMP422/TMP423 supersets.

The three instantiable type names are unchanged, but TYPE_TMP421 now
spells "tmp421" rather than the abstract "tmp421-generic", which no
longer exists, and a TMP421 cast now succeeds for the two supersets.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/sensor/tmp421.c | 98 +++++++++++++++++++++++++-----------------------------
 1 file changed, 46 insertions(+), 52 deletions(-)

diff --git a/hw/sensor/tmp421.c b/hw/sensor/tmp421.c
index 4b93d42b14..ef738b821e 100644
--- a/hw/sensor/tmp421.c
+++ b/hw/sensor/tmp421.c
@@ -39,17 +39,6 @@
 #define TMP422_DEVICE_ID                0x22
 #define TMP423_DEVICE_ID                0x23
 
-typedef struct DeviceInfo {
-    int model;
-    const char *name;
-} DeviceInfo;
-
-static const DeviceInfo devices[] = {
-    { TMP421_DEVICE_ID, "tmp421" },
-    { TMP422_DEVICE_ID, "tmp422" },
-    { TMP423_DEVICE_ID, "tmp423" },
-};
-
 struct TMP421State {
     /*< private >*/
     I2CSlave parent_obj;
@@ -69,10 +58,14 @@ struct TMP421State {
 
 struct TMP421Class {
     I2CSlaveClass parent_class;
-    const DeviceInfo *dev;
+
+    uint8_t device_id;
+    uint8_t config2_reset;
 };
 
-#define TYPE_TMP421 "tmp421-generic"
+#define TYPE_TMP421 "tmp421"
+#define TYPE_TMP422 "tmp422"
+#define TYPE_TMP423 "tmp423"
 OBJECT_DECLARE_TYPE(TMP421State, TMP421Class, TMP421)
 
 
@@ -178,7 +171,7 @@ static void tmp421_read(TMP421State *s)
         s->buf[s->len++] = TMP421_MANUFACTURER_ID;
         break;
     case TMP421_DEVICE_ID_REG:
-        s->buf[s->len++] = sc->dev->model;
+        s->buf[s->len++] = sc->device_id;
         break;
     case TMP421_CONFIG_REG_1:
         s->buf[s->len++] = s->config[0];
@@ -314,20 +307,7 @@ static void tmp421_reset(TMP421State *s)
      */
     s->pointer = 0;
     s->config[0] = 0;
-
-    /* resistance correction and channel enablement */
-    switch (sc->dev->model) {
-    case TMP421_DEVICE_ID:
-        s->config[1] = 0x1c;
-        break;
-    case TMP422_DEVICE_ID:
-        s->config[1] = 0x3c;
-        break;
-    case TMP423_DEVICE_ID:
-        s->config[1] = 0x7c;
-        break;
-    }
-
+    s->config[1] = sc->config2_reset;
     s->rate = 0x7;       /* 8Hz */
     s->status = 0;
 }
@@ -349,7 +329,9 @@ static void tmp421_class_init(ObjectClass *klass, const void *data)
     k->send = tmp421_tx;
     rc->phases.hold = tmp421_reset_hold;
     dc->vmsd = &vmstate_tmp421;
-    sc->dev = (DeviceInfo *) data;
+
+    sc->device_id = TMP421_DEVICE_ID;
+    sc->config2_reset = 0x1c;
 
     object_class_property_add(klass, "temperature0", "int", &int_type_info,
                               tmp421_get_temperature,
@@ -365,28 +347,40 @@ static void tmp421_class_init(ObjectClass *klass, const void *data)
                               tmp421_set_temperature, NULL, NULL);
 }
 
-static const TypeInfo tmp421_info = {
-    .name          = TYPE_TMP421,
-    .parent        = TYPE_I2C_SLAVE,
-    .instance_size = sizeof(TMP421State),
-    .class_size    = sizeof(TMP421Class),
-    .abstract      = true,
+static void tmp422_class_init(ObjectClass *klass, const void *data)
+{
+    TMP421Class *sc = TMP421_CLASS(klass);
+
+    sc->device_id = TMP422_DEVICE_ID;
+    sc->config2_reset = 0x3c;
+}
+
+static void tmp423_class_init(ObjectClass *klass, const void *data)
+{
+    TMP421Class *sc = TMP421_CLASS(klass);
+
+    sc->device_id = TMP423_DEVICE_ID;
+    sc->config2_reset = 0x7c;
+}
+
+static const TypeInfo tmp421_types[] = {
+    {
+        .name          = TYPE_TMP421,
+        .parent        = TYPE_I2C_SLAVE,
+        .instance_size = sizeof(TMP421State),
+        .class_size    = sizeof(TMP421Class),
+        .class_init    = tmp421_class_init,
+    },
+    {
+        .name          = TYPE_TMP422,
+        .parent        = TYPE_TMP421,
+        .class_init    = tmp422_class_init,
+    },
+    {
+        .name          = TYPE_TMP423,
+        .parent        = TYPE_TMP421,
+        .class_init    = tmp423_class_init,
+    },
 };
 
-static void tmp421_register_types(void)
-{
-    int i;
-
-    type_register_static(&tmp421_info);
-    for (i = 0; i < ARRAY_SIZE(devices); ++i) {
-        TypeInfo ti = {
-            .name       = devices[i].name,
-            .parent     = TYPE_TMP421,
-            .class_init = tmp421_class_init,
-            .class_data = &devices[i],
-        };
-        type_register_static(&ti);
-    }
-}
-
-type_init(tmp421_register_types)
+DEFINE_TYPES(tmp421_types)

-- 
2.53.0-Meta


