Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CDFCCC6B3A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:12:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHN6t-0006cR-AX; Thu, 15 Oct 2026 11:11:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHN6s-0006aQ-73
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 11:11:10 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHN6p-0001iG-1y
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 11:11:09 -0400
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48c4be28b82so562348f8f.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 08:11:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792077065; x=1792681865;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QALtB1JjwJWKzUBaARxhOo0RyLWLhPW//31H+iGWjAk=;
 b=GHrguPEECqlOfmA+LDkx6OpRqYFAW+HhnamxWoe2RKa62dva7uzWSB5qKiYoO6qodp
 jmAz5UwyIe469aTLHmvrIloP+i+fQ616cabIrhGzd/wKPSKtyp//la5+cRij/hn7XXmh
 eF54PuBSCu3V89u5aBDlzAQ4VLUJOGYCBQMZ4lJmozc5uKqDlTL6x0HHh29qR9S6wxW4
 O2PHE/ifKJnNgG+E/VA3Ln5dTlSTAOzGvEFhkQnLtBo+1ptTsLgNOoP5MruD3n6VpOsq
 00Ajq4ugPOxup7AzjOBL3B8QUifQC7Ni3nXFFoY5bACT5ZhMffOoVj1c4RVS9B35VAeh
 o3ZQ==
X-Gm-Message-State: AFq9FYKWQ1c9pSDbxzlFI2XVLMbG4s1j3QeDQAUD870B5MMQ+dBpw8CV
 oL0c9PWPhQahKMasf/B8ZddwLF2E55OaJgT+9t1Sazb3XEBwOiDizLDrd/7uMw==
X-Gm-Gg: AYBFou13tIajg1w5o9tQLBz2Z6TKq2fStKfiCdLZ69c99C7EYXwH9bvY1qVVdAbn61c
 P8M7L/8pyHuRIo8B57t7VZrVPfsuAprRWhyzJFQLtGSoYwrYDvCrwSHvtei/P192j3Yr8blOje/
 c7/Af+ByHIK5BfGqpWGOnEkUvooItmQYv5amZjVfCPc3HfpJLUIzWb/0BlWeJ2BmmhUp3FCbGIE
 yzHFGc+R01zfZ51tHeHcA8Uk6OVoeVLbRhOrhTN4Qq4EGFBhoKdECfgahVHJTTZQ+Zy2abn7lvp
 oyQvMO+4R7UA3ZvELkw/dPv/LoIiRg5Outb6pGfe6la3yG0Y8bApQZS4TK7zsOLmSPcDS6oWnpa
 Sz83jvxw9n/bbRXPtlgE1tWU5orH5kfFqyVHpr4NVjGPLmuuUdUwuPO3OJCKqMAI/dcP4wfLm3n
 Mo98HDfx7qP/zJ8214e9iOT536Lu6HGJLtlGK5DdN4+QHmHhwHRuqM01G1BpGpi4L/3kcEJoRmF
 pdxKrxKW57vD7BsxzXDRJuapOLr0P9LiEPXxU/lp4ARBg==
X-Received: by 2002:a05:6000:2606:b0:48d:eb45:742d with SMTP id
 ffacd0b85a97d-48deb45757dmr10400041f8f.22.1792077065222; 
 Thu, 15 Oct 2026 08:11:05 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0ac5265sm20302446f8f.41.2026.10.15.08.11.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 08:11:03 -0700 (PDT)
Date: Thu, 15 Oct 2026 13:57:47 +0200
Subject: [PATCH 09/22] hw/sensor: tmp421: migrate the exact measurement
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-bmc-clemente-v1-9-bf591886b5b6@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792065465; l=3784;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=WkdVkGiPzxeWatF4oFQP9cdVEfej5xbiLCyVJyd/Exg=;
 b=iTInpBgYCl9BA8spP92Lp0rju5OGi6Ykf9mvFhRxNkqTIW6K6EIizFAEUjgVD8Eh5sLol4dj2
 iMHQ7e+ePNlApbO+C2RWgUwGVgNV5pw0daZjYdZBZfl7npDyKU4ULV2
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.221.54; envelope-from=eblot.ml@gmail.com;
 helo=mail-wr1-f54.google.com
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

The register form the stream carries only resolves a sixteenth of a
degree, so a temperature set through the property does not survive a
round trip unless it happens to fall on that grid.

Add a subsection holding the measurement itself, sent only when the
register form cannot reproduce it. A stream from a sensor holding an
expressible value -- the usual case, boards preset whole degrees --
therefore stays loadable by a QEMU that knows nothing of it.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/sensor/tmp421.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 2 deletions(-)

diff --git a/hw/sensor/tmp421.c b/hw/sensor/tmp421.c
index 1e061045cb..e391bb20e1 100644
--- a/hw/sensor/tmp421.c
+++ b/hw/sensor/tmp421.c
@@ -59,6 +59,7 @@ struct TMP421State {
 
     /* migration only: the register form the stream carries */
     int16_t temperature[4];
+    bool temp_mc_loaded;
 
     uint8_t status;
     uint8_t config[2];
@@ -379,6 +380,56 @@ static const VMStateDescription vmstate_tmp421_n_correct = {
     }
 };
 
+/*
+ * That form only resolves a sixteenth of a degree, so the measurement itself
+ * travels in a subsection -- sent only when the register form cannot
+ * reproduce it, which leaves the usual stream loadable by a QEMU that does
+ * not know the subsection.
+ */
+static bool tmp421_temp_mc_needed(void *opaque)
+{
+    TMP421State *s = opaque;
+    bool ext_range = s->config[0] & TMP421_CONFIG_RANGE;
+    int32_t offset = ext_range ? TMP421_EXT_OFFSET : 0;
+
+    /*
+     * The register form reproduces a measurement when the conversion divides
+     * exactly and the encoder had nothing to clamp. Asking the decoder
+     * instead would settle the question with the function whose result the
+     * subsection exists to protect, and hide any error it has.
+     */
+    for (unsigned channel = 0; channel < ARRAY_SIZE(s->temp_mc); channel++) {
+        int32_t scaled = s->temp_mc[channel] * 256;
+
+        if (scaled % 1000 ||
+            (uint16_t)(scaled / 1000 + offset) != tmp421_encode(s, channel)) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
+static int tmp421_temp_mc_post_load(void *opaque, int version_id)
+{
+    TMP421State *s = opaque;
+
+    s->temp_mc_loaded = true;
+    return 0;
+}
+
+static const VMStateDescription vmstate_tmp421_temp_mc = {
+    .name = "TMP421/temperature-mc",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = tmp421_temp_mc_needed,
+    .post_load = tmp421_temp_mc_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_INT32_ARRAY(temp_mc, TMP421State, 4),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 /*
  * The stream carries the register form of the measurement: that is what a
  * QEMU predating the millidegree state writes, and what it expects back.
@@ -398,9 +449,13 @@ static int tmp421_post_load(void *opaque, int version_id)
 {
     TMP421State *s = opaque;
 
-    for (unsigned channel = 0; channel < ARRAY_SIZE(s->temp_mc); channel++) {
-        s->temp_mc[channel] = tmp421_decode(s, s->temperature[channel]);
+    if (!s->temp_mc_loaded) {
+        for (unsigned channel = 0; channel < ARRAY_SIZE(s->temp_mc);
+             channel++) {
+            s->temp_mc[channel] = tmp421_decode(s, s->temperature[channel]);
+        }
     }
+    s->temp_mc_loaded = false;
 
     return 0;
 }
@@ -423,6 +478,7 @@ static const VMStateDescription vmstate_tmp421 = {
         VMSTATE_END_OF_LIST()
     },
     .subsections = (const VMStateDescription * const []) {
+        &vmstate_tmp421_temp_mc,
         &vmstate_tmp421_n_correct,
         NULL
     }

-- 
2.53.0-Meta


