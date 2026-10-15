Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B80CC6B3A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:12:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHN6k-000642-1d; Thu, 15 Oct 2026 11:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHN6h-0005zb-RH
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 11:10:59 -0400
Received: from mail-ej1-f46.google.com ([209.85.218.46])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHN6f-0001hf-Lk
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 11:10:59 -0400
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-c2e36c3478aso314084666b.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 08:10:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792077056; x=1792681856;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IDlbDLDHRWaNADiSqZo7W6elqsi2wuUJKHLctAcDsPc=;
 b=VEJuZFh+56MX7H5PLSz79WQP/0UbpsHyR3+pbuUlaC5n/krQdMBjEoXD2NvgcpMg72
 +jrU+zXIfUxbtYqJdEN2F30b1DMYw0P+dDtRKR3pocl1I8nm+k1MfoXGwOMa/CmJ4hPD
 lXtvYBVTMzWhfSLlTmvOiHIoN9BNaqsKG1hBSXsa5VXfslkWs7hVVsP4xrCg11qZVE6B
 kbes1uXHWLEu3q/UMaJzZMngaxSDx2YR8YdVVaR1Yq15D9T2CmQMPXer7rJQxGvntLMg
 /P6qUn1K+uvjy4h4MEr4ryUuGZMx2EDnxCoZtYqXx76ZZzgs2dGa7texi680WEE7Zckk
 RIMA==
X-Gm-Message-State: AFq9FYKS8T6MyKMuAL9mFM3qJoLCXWWelhD9Kh/Rf2jsmaUF1uFWZDVh
 0ZmWIOTkT0T4aRGslxxkniBvRmKbXDIq5NjIoE+IP+hSDWYs073zvnNJS5R4Ig==
X-Gm-Gg: AYBFou1NBnn49gEZVjtyOiBK5fwAxC1PIeh/lJw0TwUa3cO5JCkcEWujBsmNUic+Eax
 zXBE21G8wU5/3b+hXbtI0PMmya2jiaaryUpBsS+u1dVB5i0K0nxNejNSt6x9aLpgEscj/g9IVf7
 cj94gyerUO0ymTt4RNdwrPXkRRtlhcj3e4fG6yLhovAlzXE0ciYGne1RLfKx0utidcUhLZEbX/W
 MvepXC28PY1zuWuTFbbf3Wmbo8NfRR3neHoQxPXf2mcHsyfmPPc2M/DmvOMxkI4nzPnCeHTb6rc
 iqMfpeKhOOQtrCu4cpPpJn7rc+tv5QeN2w6Vah2c/K2S2bCWObS/ym8jbeEe40caP8miSy0IzKL
 HeRXj4bswO7M1MPj0K0lJbRQUovL0u5WcBR9gwyE47t9E+PVziNFSyV51SXvEOVgwvWKU7E96l3
 4d1VPXvCY5VRp3hV0dPjhvVcujkNDHYMmSBUtQWDhsvQ4uitHhU9WrXhADhQDYB1b5+yneWTm5T
 iDu/Rm3IR+gC2Q/rG/gOOdDarSbxzSjtO0x26CXRRhWUA==
X-Received: by 2002:a17:907:3d0d:b0:c2d:ca32:217a with SMTP id
 a640c23a62f3a-c31aa07c3a1mr1804343266b.33.1792077055675; 
 Thu, 15 Oct 2026 08:10:55 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dface154csm637300f8f.53.2026.10.15.08.10.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 08:10:54 -0700 (PDT)
Date: Thu, 15 Oct 2026 13:57:46 +0200
Subject: [PATCH 08/22] hw/sensor: tmp421: keep the measurement across a
 range change
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-bmc-clemente-v1-8-bf591886b5b6@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792065465; l=6919;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=375Ik3T0Cx9iLheWZazLL0l1G2uWK8cbucMQ8xoxZc0=;
 b=Yhlb/H65fOBddLJAzn4/HRCh9nHGFSg7/Hru8pMtpbIYEJGp09L0mgIDc/xpSMGL0PEchkD5O
 AJp7NdOYZRvAu4koy4b8vzp7lNBI69vDXjQsCwD6m2swxBkP4FYvnSb
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.218.46; envelope-from=eblot.ml@gmail.com;
 helo=mail-ej1-f46.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

The model stored temperatures in their register form, which carries
the extended-range offset. Leaving that range therefore reinterpreted
the stored value and shifted the reported temperature by 64 degrees,
whether the range bit was cleared by a configuration write or by a
reset. The encoding was wrong at both ends too: the extended range is
offset binary, so it does not fit a signed register above +64 C, and
neither range saturated where the datasheet says it should.

Hold the measurement in millidegrees and derive the register from it
on each read, which is what the range bit selects: an encoding, not a
new measurement.

The stream keeps carrying the register form, which is what a released
QEMU writes and expects, so it stays loadable both ways; the
measurement is converted to and from it on save and load.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/sensor/tmp421.c | 96 +++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 81 insertions(+), 15 deletions(-)

diff --git a/hw/sensor/tmp421.c b/hw/sensor/tmp421.c
index ec3a9a9760..1e061045cb 100644
--- a/hw/sensor/tmp421.c
+++ b/hw/sensor/tmp421.c
@@ -53,9 +53,13 @@ struct TMP421State {
     I2CSlave parent_obj;
     /*< public >*/
 
-    int16_t temperature[4];
+    /* Measured temperature, millidegrees Celsius */
+    int32_t temp_mc[4];
     uint8_t n_correct[3];   /* remote channels only */
 
+    /* migration only: the register form the stream carries */
+    int16_t temperature[4];
+
     uint8_t status;
     uint8_t config[2];
     uint8_t rate;
@@ -114,12 +118,51 @@ OBJECT_DECLARE_TYPE(TMP421State, TMP421Class, TMP421)
 static const int32_t mins[2] = { -40000, -55000 };
 static const int32_t maxs[2] = { 127000, 150000 };
 
+/*
+ * Register form of a measurement (datasheet Table 1): whole degrees in the
+ * high byte, the fraction in the upper nibble of the low byte. The standard
+ * range is two's complement and saturates at -64 C (C0h) and +127 C (7Fh);
+ * the extended range is unsigned with a -64 C offset, spanning -64 C (00h) to
+ * +191 C (FFh). The range only selects an encoding: the measurement itself is
+ * held apart, so switching range re-reads the same temperature.
+ */
+#define TMP421_EXT_OFFSET   (64 * 256)
+#define TMP421_STD_REG_MIN  (-64 * 256)          /* C0h, -64 C */
+#define TMP421_STD_REG_MAX  (127 * 256 + 0xf0)   /* 7Fh, +127 C */
+#define TMP421_EXT_REG_MAX  (255 * 256 + 0xf0)   /* FFh, +191 C offset */
+
+static uint16_t tmp421_encode(const TMP421State *s, unsigned channel)
+{
+    bool ext_range = s->config[0] & TMP421_CONFIG_RANGE;
+    int raw = s->temp_mc[channel] * 256 / 1000;
+
+    if (ext_range) {
+        raw = MAX(0, MIN(TMP421_EXT_REG_MAX, raw + TMP421_EXT_OFFSET));
+    } else {
+        raw = MAX(TMP421_STD_REG_MIN, MIN(TMP421_STD_REG_MAX, raw));
+    }
+
+    return raw;
+}
+
+/*
+ * The inverse of tmp421_encode(). Only the standard range is signed: the
+ * extended one spans the whole byte, so its top bit is a temperature, not a
+ * sign. Rounding follows the sign so that every register value the encoder
+ * can produce decodes back to the measurement it came from.
+ */
+static int32_t tmp421_decode(const TMP421State *s, int16_t reg)
+{
+    bool ext_range = s->config[0] & TMP421_CONFIG_RANGE;
+    int32_t raw = ext_range ? (uint16_t)reg - TMP421_EXT_OFFSET : reg;
+
+    return (raw * 1000 + (raw < 0 ? -128 : 128)) / 256;
+}
+
 static void tmp421_get_temperature(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
 {
     TMP421State *s = TMP421(obj);
-    bool ext_range = (s->config[0] & TMP421_CONFIG_RANGE);
-    int offset = ext_range * 64 * 256;
     int64_t value;
     int tempid;
 
@@ -133,21 +176,18 @@ static void tmp421_get_temperature(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    value = ((s->temperature[tempid] - offset) * 1000 + 128) / 256;
+    value = s->temp_mc[tempid];
 
     visit_type_int(v, name, &value, errp);
 }
 
-/* Units are 0.001 centigrades relative to 0 C.  s->temperature is 8.8
- * fixed point, so units are 1/256 centigrades.  A simple ratio will do.
- */
+/* Units are 0.001 centigrades relative to 0 C. */
 static void tmp421_set_temperature(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
 {
     TMP421State *s = TMP421(obj);
     int64_t temp;
     bool ext_range = (s->config[0] & TMP421_CONFIG_RANGE);
-    int offset = ext_range * 64 * 256;
     int tempid;
 
     if (!visit_type_int(v, name, &temp, errp)) {
@@ -170,7 +210,7 @@ static void tmp421_set_temperature(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    s->temperature[tempid] = (int16_t) ((temp * 256 - 128) / 1000) + offset;
+    s->temp_mc[tempid] = temp;
 }
 
 static bool tmp421_channel_enabled(TMP421State *s, unsigned channel)
@@ -187,16 +227,14 @@ static bool tmp421_channel_enabled(TMP421State *s, unsigned channel)
  */
 static uint8_t tmp421_temp_high(TMP421State *s, unsigned channel)
 {
-    uint16_t reg = s->temperature[channel];
-
-    return tmp421_channel_enabled(s, channel) ? reg >> 8 : 0;
+    return tmp421_channel_enabled(s, channel) ?
+           tmp421_encode(s, channel) >> 8 : 0;
 }
 
 static uint8_t tmp421_temp_low(TMP421State *s, unsigned channel)
 {
-    uint16_t reg = s->temperature[channel];
-
-    return tmp421_channel_enabled(s, channel) ? reg & 0xf0 : 0;
+    return tmp421_channel_enabled(s, channel) ?
+           tmp421_encode(s, channel) & 0xf0 : 0;
 }
 
 static void tmp421_read(TMP421State *s)
@@ -341,10 +379,38 @@ static const VMStateDescription vmstate_tmp421_n_correct = {
     }
 };
 
+/*
+ * The stream carries the register form of the measurement: that is what a
+ * QEMU predating the millidegree state writes, and what it expects back.
+ */
+static int tmp421_pre_save(void *opaque)
+{
+    TMP421State *s = opaque;
+
+    for (unsigned channel = 0; channel < ARRAY_SIZE(s->temp_mc); channel++) {
+        s->temperature[channel] = tmp421_encode(s, channel);
+    }
+
+    return 0;
+}
+
+static int tmp421_post_load(void *opaque, int version_id)
+{
+    TMP421State *s = opaque;
+
+    for (unsigned channel = 0; channel < ARRAY_SIZE(s->temp_mc); channel++) {
+        s->temp_mc[channel] = tmp421_decode(s, s->temperature[channel]);
+    }
+
+    return 0;
+}
+
 static const VMStateDescription vmstate_tmp421 = {
     .name = "TMP421",
     .version_id = 0,
     .minimum_version_id = 0,
+    .pre_save = tmp421_pre_save,
+    .post_load = tmp421_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT8(len, TMP421State),
         VMSTATE_UINT8_ARRAY(buf, TMP421State, 2),

-- 
2.53.0-Meta


