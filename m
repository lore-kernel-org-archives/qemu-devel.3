Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4629C606A328
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 09:30:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOtll-0006jQ-6n; Thu, 05 Nov 2026 04:28:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtlX-0006eM-CG
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:28:16 -0500
Received: from mail-pl1-f174.google.com ([209.85.214.174])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtlV-0006vK-Fe
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:28:15 -0500
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2eb18f4da15so5676895ad.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 01:28:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793870892; x=1794475692;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=retw+hCi5vVKjipTQvsUltaajOcauTJ+Xp/W71jLDVc=;
 b=Uu/BjLbCPWoieQVgAtWPCvLG06xLvvRLV07qxalmUD8xAzskfelsnZVl28Gt1cCpRy
 2Ci/jAnotsgTSzb/56dz9ZiQ+N+MYdWtxjpJ4kyo5Ufi9xOSOzyIMmOKfeoZfFteCVrb
 tvLDIR+YvCHTN0VmBxOjJ9L5qBlDXGc+HnIyyPZdo5S9CHCLgI1YZ9GPlvLcSdu3oaGa
 WXbXgmoFN9CLSBJeRO0CJV/r801xATas+gYkZfmV35nfYLRIROozNHMkF9yTEayVKdJf
 hm8Bn9sMi2YwnMVahVsNXhbD8EPhuJtrMVGZQ1R29bBClr1QF8P01wq47RetJ2kDWhXt
 DOVg==
X-Gm-Message-State: APuU4Z/SfwCLyEpZGZVEEAa5cmziZFWTysVVzq5snbIzxeM2bj2AC/kL
 bN6esZf5jamsRQaMknbs9P0RUe9IUBERb3/Qj457IYy4f/Kpt6B7jSFHhehyXyxhdYY=
X-Gm-Gg: AYBFou3WDQD9gBf1RxeMc7MHZulhHEtXvsIgw/weXcX7C/3ClcsBA4gjhpWoQktqcyE
 uzI/Rnau/hpLN9xdO4dZ7BioVeaakNlBP2wdLidPdl0WSftEqKBka5QrH3JxXCmBB68JwJDkimk
 gZ+t+Xoh20br5WxkDfLIAE4CRI3MCoon2xMrHjnIqJX1oNXQ5T48Q8to9TQnImYrulfir7zCnJn
 R+h4Pc0g0c2JNBBnRwQ4V15AUJ3hMijM28zYVd0GURCjxqJxNvgz7cAPRmYBLqFaCNlJJuARP6c
 ClWMXshBUmdF9fzK/Ow9HNsHozgBNz5udw8kQq64uvlLoG8+1neue1jBvtNPe4pibTw49iyc/3F
 ELebew8B8My0nDGkUuNfZi1TvUR9/5ud2vFLvQQr7ECx1/X//XCINw+ozYUMMH0gJnX/W89rgWF
 kgyExFgZiAU9tMlrn5aukohdQkkxVLgQCC6j2HXu0fFc4DNseOYgDdq45q4953t7xfXR3KR5Xyr
 /vwQJailN1JoXrqe6TPWkOgfpPHbBEc/vGqDuEgqYqjyyxM5W7sQ0wFJsnNfnE93xzesN3IInk6
 3Bc+hZeOfxVnUZlQSetTFk5QC6XrPmAy9fpdnQtrqfVcD8PI95af3pGFhe70mPR/QzmeHwObKPy
 U
X-Received: by 2002:a17:902:ce05:b0:2dd:ad73:5b6f with SMTP id
 d9443c01a7336-2eb364b55camr171857535ad.31.1793870891693; 
 Thu, 05 Nov 2026 01:28:11 -0800 (PST)
Received: from localhost (118-163-122-149.hinet-ip.hinet.net.
 [118.163.122.149]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ed2c79ea15sm3709255ad.63.2026.11.05.01.28.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 01:28:11 -0800 (PST)
Date: Thu, 05 Nov 2026 17:25:42 +0800
Subject: [PATCH 03/16] hw/sensor: tmp421: implement Resettable reset
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-sensor-tmp421-v1-3-c46853f5e1f0@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793870742; l=2741;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=jjLzkdYMOkO0VP5ki4S9XNixanshbfj1QWCH+5pzHwI=;
 b=0d1GjFHyw0hNWxqlmXuYkjR853Y2s95/pA0FYQQP9fymiJtvfp71ubFKf5/uLSIfbaaQ2imIj
 jbN+OcGdoIIBDWtuKclwNKFtNDTXCNRilAmcI0/g6sHdpLk/99BGruL
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.214.174; envelope-from=eblot.ml@gmail.com;
 helo=mail-pl1-f174.google.com
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
index 55e261a090..4b93d42b14 100644
--- a/hw/sensor/tmp421.c
+++ b/hw/sensor/tmp421.c
@@ -225,7 +225,7 @@ static void tmp421_read(TMP421State *s)
     }
 }
 
-static void tmp421_reset(I2CSlave *i2c);
+static void tmp421_reset(TMP421State *s);
 
 static void tmp421_write(TMP421State *s)
 {
@@ -240,7 +240,7 @@ static void tmp421_write(TMP421State *s)
         s->config[1] = s->buf[0];
         break;
     case TMP421_RESET:
-        tmp421_reset(I2C_SLAVE(s));
+        tmp421_reset(s);
         break;
     }
 }
@@ -304,17 +304,18 @@ static const VMStateDescription vmstate_tmp421 = {
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
@@ -331,23 +332,22 @@ static void tmp421_reset(I2CSlave *i2c)
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


