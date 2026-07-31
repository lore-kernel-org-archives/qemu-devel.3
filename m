Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 542F3C54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 12:26:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpmJK-0001jG-FV; Fri, 31 Jul 2026 08:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wpmJI-0001iw-M5
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 08:25:56 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wpmJH-0007Tu-7C
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 08:25:56 -0400
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-472326ca506so642862f8f.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 05:25:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785500754; x=1786105554;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9Rx1so6O2DvHoxNj8RGDiYjwjmDl40dAURIIyBXbKtg=;
 b=iiUGxTg6MYIthJ4CDI+QEXcwyz6yD/xHc9rTHnx5C6QZ535W/+yvcluXSm9V3x/5L/
 VBLAgjVOg2Xs3YMyx1hBFO9Qf0oqNbpu+ISGnGyjEra8t8SyWwE/i0d8sLMrO4m/eG81
 Ets0duL95ZvNCn/QgNFaYMpno28nWpdZDmYULsQlaZ0dkCocbeiz3iiOYW4Hkxtm22sc
 OG0+ER1UykfM4FmAaL5iTliSRXSGrLL8OuscHhqu8XwGoBcDF05pKxUrHli9wmS4Cy09
 eULSNc85EQA+2/qr/tVoYVG3bgNaWoc/NPPPTyXmkzeNIgCJxTCQgmW7JumXEWPqSIIT
 jv7w==
X-Gm-Message-State: AOJu0YxJsc8JVE1W38I7pDlkqZjuvpn3ucuS56YcWRfOStf3B6bo/WCc
 LTv+aoCvBGqEFeanHOFK0AyMze2+ytQzWXGKTQLDsFgAxmuXp1RSYdydNRvDw6yR
X-Gm-Gg: AR+sD12VZJ+07Ozh3TTGOwS/mUUnXZBLz18WxrbcAvpvCgt02w1xxhWJlmRjQifib9O
 hVJrkNfTU0eFTsP7XXiMSSPIxjCm2/x41FVxmJXhX7+QLErVw7oRsIQ1dNt+HY2oF8hYFPMWFoK
 3gQGshpx0JX8z11WasBpOT+TUapqB6km3TZGUnpsX+1iG6TObuOHNEASxbqw2U3rvAOPMnxsRWQ
 Mj5jke/GxJvK7zUB6xl0Tqt2yiCxZgD6vSBX7P4v9zcSpmhH9Yso9QEUaHKQx6z9TKG+oQJnhOf
 9FXwbYhBVLgIIrLfgbrIkDmLNxKklS7D2wcWryvx1E/S2byR896qqGrkYBiNEvCbefmITTnqFYr
 IwesvA9yKZq45EcZy8CaA5KmLP4EWtgxEYlmzr1VQjz86gqgPd96YpOWM8kIdQDPVZkDW4a72cc
 cakM1RsiPPvf8XclgnZgGYKqWkhfZib5NTtdBlOgnrEawdwt7V4nnD4Kw/fTAf2HFWbrRgdEB+s
 M0VAhGiUNiekxpuPrzH+m3hj+MT0XIsMjRt
X-Received: by 2002:a05:6000:2c02:b0:475:f0f0:9ef7 with SMTP id
 ffacd0b85a97d-47fd2b653e6mr4749189f8f.60.1785500753574; 
 Fri, 31 Jul 2026 05:25:53 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd456a6d7sm4455881f8f.19.2026.07.31.05.25.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 05:25:53 -0700 (PDT)
Date: Fri, 31 Jul 2026 12:45:01 +0200
Subject: [PATCH v2 02/25] hw/sensor: tmp105: name the parent object field
 parent_obj
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-sanmiguel-bmc-locator-v2-2-1266926ba769@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785494707; l=2294;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=IPpKdB4GNfibCBuZaz5CjB0TPUppqW5ZDDXX0F0+Glo=;
 b=eZW/p0A+N6UUAczLR7SIkQA4mEdwYgg4QdPiKGpwSCI4ay9LnsvtdaVbJEi9mxOdIgLtkyCRk
 Fpu/jwFsk6IAoBWndOiQz8363WM7HDhwsW8sCaS+1QqK7u3z2Shr5Ty
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.221.46; envelope-from=eblot.ml@gmail.com;
 helo=mail-wr1-f46.google.com
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

QEMU coding conventions expect the embedded parent object of a QOM type
to be named parent_obj. Rename the TMP105State I2CSlave member
accordingly and update its references; the change is purely cosmetic.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/sensor/tmp105.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/sensor/tmp105.c b/hw/sensor/tmp105.c
index 6069c0905d..aabeb34f08 100644
--- a/hw/sensor/tmp105.c
+++ b/hw/sensor/tmp105.c
@@ -42,7 +42,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(TMP105State, TMP105)
  */
 struct TMP105State {
     /*< private >*/
-    I2CSlave i2c;
+    I2CSlave parent_obj;
     /*< public >*/
 
     uint8_t len;
@@ -187,12 +187,12 @@ static void tmp105_read(TMP105State *s)
         break;
     }
 
-    trace_tmp105_read(s->i2c.address, s->pointer);
+    trace_tmp105_read(s->parent_obj.address, s->pointer);
 }
 
 static void tmp105_write(TMP105State *s)
 {
-    trace_tmp105_write(s->i2c.address, s->pointer);
+    trace_tmp105_write(s->parent_obj.address, s->pointer);
 
     switch (s->pointer & 3) {
     case TMP105_REG_TEMPERATURE:
@@ -200,7 +200,7 @@ static void tmp105_write(TMP105State *s)
 
     case TMP105_REG_CONFIG:
         if (FIELD_EX8(s->buf[0] & ~s->config, CONFIG, SHUTDOWN_MODE)) {
-            trace_tmp105_write_shutdown(s->i2c.address);
+            trace_tmp105_write_shutdown(s->parent_obj.address);
         }
         s->config = FIELD_DP8(s->buf[0], CONFIG, ONE_SHOT, 0);
         s->faults = tmp105_faultq[FIELD_EX8(s->config, CONFIG, FAULT_QUEUE)];
@@ -305,7 +305,7 @@ static const VMStateDescription vmstate_tmp105 = {
         VMSTATE_INT16(temperature, TMP105State),
         VMSTATE_INT16_ARRAY(limit, TMP105State, 2),
         VMSTATE_UINT8(alarm, TMP105State),
-        VMSTATE_I2C_SLAVE(i2c, TMP105State),
+        VMSTATE_I2C_SLAVE(parent_obj, TMP105State),
         VMSTATE_END_OF_LIST()
     },
     .subsections = (const VMStateDescription * const []) {
@@ -338,7 +338,7 @@ static void tmp105_realize(DeviceState *dev, Error **errp)
 
     qdev_init_gpio_out(&i2c->qdev, &s->pin, 1);
 
-    tmp105_reset(&s->i2c);
+    tmp105_reset(&s->parent_obj);
 }
 
 static void tmp105_initfn(Object *obj)

-- 
2.50.1


