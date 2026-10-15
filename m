Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C65F1CCA465
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHN61-0005gW-2m; Thu, 15 Oct 2026 11:10:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHN5w-0005en-6X
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 11:10:12 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHN5u-0001dN-Fe
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 11:10:11 -0400
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48de6a62a4cso2494612f8f.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 08:10:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792077009; x=1792681809;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tMgSw4UUJMwBSnxsh5UNM4ZZEUwyYmjlfix+bmhPnj0=;
 b=iFZxOPgemAzK15yfB/Sb//Wbmk1g0cQeV5Q8UVEDuGo8XdMkZEyPkdmQRPESsJ0oqs
 FMzaHfp6nrsY+JmIhVoRn3OaT7bhFJVMVy+ag14VJgqJM1J3Nr5D2TbYpNb48a14qKkX
 KJgbOjYH2QYGQ/e7b/SU5TH45vnJS6U44DYD+FrLDbjoI+SX9Wc7SYnXKgk0gyX3UO1C
 gkR8hvy1FAFRdQkXOeI6EjCFisxNcAfz4I4qaxOvot9+HUh1IyuDYGWu3oSn7/gyF1hI
 6k3UuPSFEK60XofjSIC54d9LQJJ2uD81Nc4wEw0cujae5FVSrVYcN+rcYB4EaGXeKBUv
 x46w==
X-Gm-Message-State: AFq9FYIkdTY7Glbb2vE4AASGAIE6ge/Q5TZS/bUIi+2ejnu7qw97Q6B6
 Bbw6h/PPISTrShD1aJFR0fqbLYLnvvrrUWjS2+YlJGFtXeK5zSGS3oPzua4FDQ==
X-Gm-Gg: AYBFou2Dk8EobWqijviAcdi2/Xb9nEQPKH+GhmIOaj80W4H5lFrAaYcqa6RYllyh6Ju
 yXJFWx1u6Iozn5Sns+X74f0fdb/IVMPqmqAzRaPXkXEeL419lckIacxJocM9ioWxmV5PUuJ4Mih
 xZbrucWxpaV9wKglJxffKBL0p5VTv5tFjDrNk/6gWah3knyciXH+cetNkrpoop4RWxZWDUr14/z
 TvSwEQRZyUcmSI5KWbMuumogXTJa9HBaH4d89sEIY9WHOutT1/EU2d28bbossLOaoWg3CglPIiO
 X5EDDoTNuoAskNvEMfpynNtdpCFeD4WhlAJhRp2rY494uY6lJbcvX8Jlpq5mOxshIwDcNDLweZG
 MoyzqfYIgu5O8lHReohbvPiZ5qEkH6IQ57MspkWTsCQH0pKNJ8Pn6I2eiUaWXOuXejnx6TWR9ED
 7SwQmaDXIPuCm2LuNCcIF8ETETaCL+PW4UZe22tv0To3bAwylm43Z+mladC/ueVtSQLI5/YC4Oh
 f/7CyyD19YOGjlIIc1sbUEEullbUAyZnQkdaOKJWsa0pA==
X-Received: by 2002:a05:600c:4e91:b0:4a1:7ec7:a479 with SMTP id
 5b1f17b1804b1-4a18e4f56bcmr398107885e9.33.1792077008886; 
 Thu, 15 Oct 2026 08:10:08 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd97349esm77230245e9.3.2026.10.15.08.10.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 08:10:08 -0700 (PDT)
Date: Thu, 15 Oct 2026 13:57:41 +0200
Subject: [PATCH 03/22] hw/sensor: tmp421: implement Resettable reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-bmc-clemente-v1-3-bf591886b5b6@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792065465; l=2741;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=tvoqjrv2J/EoPO9TG+O1KcuhmkCkE0+CZRSFQBVZEPU=;
 b=bfuAI4tj6xSx6us8DxH28R9e4wNaTF5rDzWe5qWPiOQmlr3R0AAkHJiAe8eEx8IuQ2u9yxBex
 ct1l++VAwwxBWrVT58OcbaAj9U70VV/yorE5z644+jKHHPLPspaIcZC
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.221.49; envelope-from=eblot.ml@gmail.com;
 helo=mail-wr1-f49.google.com
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

Wire the reset through the Resettable hold phase instead of only
calling it from realize, so bus and system resets re-initialise the
device. The measured temperatures are no longer cleared on reset: they
represent the physical input the ADC re-samples, and boards may preset
them before the machine-wide power-on reset.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/sensor/tmp421.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/hw/sensor/tmp421.c b/hw/sensor/tmp421.c
index e7927699ce..a9d15601cb 100644
--- a/hw/sensor/tmp421.c
+++ b/hw/sensor/tmp421.c
@@ -224,7 +224,7 @@ static void tmp421_read(TMP421State *s)
     }
 }
 
-static void tmp421_reset(I2CSlave *i2c);
+static void tmp421_reset(TMP421State *s);
 
 static void tmp421_write(TMP421State *s)
 {
@@ -239,7 +239,7 @@ static void tmp421_write(TMP421State *s)
         s->config[1] = s->buf[0];
         break;
     case TMP421_RESET:
-        tmp421_reset(I2C_SLAVE(s));
+        tmp421_reset(s);
         break;
     }
 }
@@ -303,17 +303,18 @@ static const VMStateDescription vmstate_tmp421 = {
     }
 };
 
-static void tmp421_reset(I2CSlave *i2c)
+static void tmp421_reset(TMP421State *s)
 {
-    TMP421State *s = TMP421(i2c);
     TMP421Class *sc = TMP421_GET_CLASS(s);
 
-    memset(s->temperature, 0, sizeof(s->temperature));
+    /*
+     * The measured temperatures are not cleared: they model the physical
+     * input the ADC re-samples after reset, and boards may preset them.
+     */
     s->pointer = 0;
+    s->config[0] = 0;
 
-    s->config[0] = 0; /* TMP421_CONFIG_RANGE */
-
-     /* resistance correction and channel enablement */
+    /* resistance correction and channel enablement */
     switch (sc->dev->model) {
     case TMP421_DEVICE_ID:
         s->config[1] = 0x1c;
@@ -330,23 +331,22 @@ static void tmp421_reset(I2CSlave *i2c)
     s->status = 0;
 }
 
-static void tmp421_realize(DeviceState *dev, Error **errp)
+static void tmp421_reset_hold(Object *obj, ResetType type)
 {
-    TMP421State *s = TMP421(dev);
-
-    tmp421_reset(&s->parent_obj);
+    tmp421_reset(TMP421(obj));
 }
 
 static void tmp421_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
     TMP421Class *sc = TMP421_CLASS(klass);
 
-    dc->realize = tmp421_realize;
     k->event = tmp421_event;
     k->recv = tmp421_rx;
     k->send = tmp421_tx;
+    rc->phases.hold = tmp421_reset_hold;
     dc->vmsd = &vmstate_tmp421;
     sc->dev = (DeviceInfo *) data;
 

-- 
2.53.0-Meta


