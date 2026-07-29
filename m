Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA8DBC53219
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:28:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp6CQ-0000s3-8W; Wed, 29 Jul 2026 11:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wp6CO-0000ra-WB
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 11:28:01 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wp6CN-00080B-Fa
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 11:28:00 -0400
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-495590dde14so11424485e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 08:27:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785338878; x=1785943678;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9Rx1so6O2DvHoxNj8RGDiYjwjmDl40dAURIIyBXbKtg=;
 b=Hy/MSbrVbSYmJ3VAOmZmEzss2oNAWQPpY40KDm1YCaVdjVFI/B4/qFrA1GX+xfuc0W
 FTVIrzdvzaNURdeLG04HUKhQCvWeeivLrbHGbBCYA0e+vfjlwpqL0yiYi8EBf2RyLBsA
 ar8Q19pCkhsj4jdOrsJRkaEPRT22uw7AFXa6CT5GJPYlxF0Rp8mfAs9eK6yAagWIyAgo
 xeSE2BlXbAIcdmZG+kH7MetkJPo43xzbAOY/LHyp2sgv89LGv9yDqKk2/WGFTJ317xoP
 ffMIg0lI0bapFfY9NdwSRurgQMsBtGjTnz6x6fKH1yOA9kEPlw2F7DHmR80vdJfIOZQ9
 jqXg==
X-Gm-Message-State: AOJu0YzkZj8m7zWgYXRzYMPzzaQAKos+yJWlpXAnZrdLJ58gY8MikScX
 BSBZgTM8CETlhAQ+o7+pR2HLIA6Ku0K9EqjHdXvgs2vu+VXaIWHqJfC9RXGCBsav
X-Gm-Gg: AR+sD13i7xvsk6bp6ZUqZDOvq2qkOobSnYJX6ThEey/cwEaN/m+zs+Cl0Gicok445b3
 JTD3+9JWLa5toXb5YUs/bFR6ZDdjByaafO3nQeFR3c3w7SR8hDw93SK9R/cif4/e2+9Da9vPu7Z
 EW3fhmlnJbrUz0aedbEwS7Nhxi36NQ3X73PNOq+qnsDud8gpasBD5Yem1xX6R+KW8zXEyjmx4Me
 HG4KF2st4YJRaclSQurliYBq4p59thhCo+rnbZMKuClJ0HRSrn7VtERZmzrWKRE296Isoh26Rye
 eI1fRKvMlRmLn2delR+rp/w8uvjpZ5HvyeOVbJwd0OooJBtAY3bL4NzUvfUISlJmcwLFevokqLj
 sukqCjnw1BkH1KRzX0HcWfv34OgXJBFZFJlk2RIsI5gPIwDlz/D5aLVMV5rtiVV5fJZMQ4X3wLt
 YmT0yIMLbdryx9IfNMmHKvVn5unAed9gpub++JpnJ6HSmyba2ek/jORXcYHK1wE3Z1LGYoUZE0a
 RSq9gJ9XA/cjl4VZdnB8NnrTZUglnU26ED70zPDLDcOW+k=
X-Received: by 2002:a05:600c:e549:20b0:495:71f8:7325 with SMTP id
 5b1f17b1804b1-496c6586a5amr55084735e9.32.1785338877905; 
 Wed, 29 Jul 2026 08:27:57 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c44af19bsm158956295e9.3.2026.07.29.08.27.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 08:27:57 -0700 (PDT)
Date: Wed, 29 Jul 2026 17:12:38 +0200
Subject: [PATCH 02/25] hw/sensor: tmp105: name the parent object field
 parent_obj
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-sanmiguel-bmc-locator-v1-2-c8f9a8d101f6@free.fr>
References: <20260729-sanmiguel-bmc-locator-v1-0-c8f9a8d101f6@free.fr>
In-Reply-To: <20260729-sanmiguel-bmc-locator-v1-0-c8f9a8d101f6@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Emmanuel Blot <eblot@meta.com>, Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785337963; l=2294;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=IPpKdB4GNfibCBuZaz5CjB0TPUppqW5ZDDXX0F0+Glo=;
 b=2yuXF/Z06uJl/0lRd/rMbrEiHrFDmhgqS9xMBmzKyL2dtweSS8cV3iJZzR4xsMbmavJMFfiPU
 zAMSLLlcVOPDdOX/0TyFKZ1Jim2iZ5spqgsCBFdcHFH2bs4NefMOnd2
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.42; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f42.google.com
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


