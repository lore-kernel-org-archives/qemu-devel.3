Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46AB9C79FA0
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 16:46:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3cTc-00057i-Jy; Mon, 07 Sep 2026 12:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1x3cTV-0004zc-4E
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:45:43 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1x3cTT-0003W0-2m
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:45:40 -0400
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4995b0343c1so52967455e9.3
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 09:45:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788799537; x=1789404337;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yoI5CWQNkKU3FBXCClJtroQLxmdLnKfTK0MOA70taBk=;
 b=dlC6j2ElPMFys0IOaxGw+mrYmThKdbBnbaMC7g15fjih5Q4qIF9aIUzho4nGFLa5CD
 G3AqpLV9tjoY+zWjMGxnRD2skx+g2AtpkNRmPvuuM3n/62iilEShYK1uYOQVOWlHTClN
 MVqLwhpFEL7iKBry+u2NfKzzeXry0DYWrJgCoXBayTrJlTJfpdIokpqrmcAIvst1B4hV
 qhk/rLuSyXq/6mM5sf/12kQNQEs7p2bhNaYSpZAiWl6PkGPwfyVJHGrLRhIBeET2TygD
 DZGJyRJJsXkEikYF8Y3QEt8aJw8/b8wMmLFZgEdkN87VYqa8Hl6V8Hndn9zzOFr2/u0I
 5USw==
X-Gm-Message-State: AFuF++lOkdM1l8FiMjRBArDAyC8yhqTnIBoXQjUoJ0TE5QL7bXr9/ju5
 tWNYWg6XxvzsIas2YcwzAh7vYOrkvBB0tYvOZuQZSQQNostUraLbM5+ZJlfUsdDO
X-Gm-Gg: AYBFou0Ud9WPixfi1FbBX+SsPMscqcADgCv5o5oLR/7IamsR6EthO0Wv07opdVHNUEz
 2iehLYuRzxmPMYpMHmnaQKYgnUZCZKJyBSgPZDPtMDDz1TaVOL2N17dQmIrdSIc2TiVxGrmf0+4
 e4HQ3zswV2b94tzDeX4MTBq8HTmaGx9DyJdxC2OBj8S5Bf5Tucv+REirMW/lnx8y+fm3Y214S26
 GM9hAq6U+dLaZupJLrj07gHia7H1V4hVtRuciaqQ8bamzT17NAO2oI4LiW4CeV4zYoiJfx9PDJ3
 2Ntj3e0G+CSlxHdwnLjgFtcKM+TIjkF1y73bg4KrXITd5SSSbtrSQNk+iHGB9Ou9kSeh3mfLuTf
 P+pRP1r5CsEoLsFs3UQHufgasgqAo6Vf+FcbWUTciQ/GZY3C/FDPXnNclVbGdgnLRoOctphlKqU
 i3KpqBKIlWHkVktL0LJKP9MI/WaVbBJmUaGMqQaNut4ps6j0Sit9i2fg9hy0oCKQ58RewoFQoxd
 bnR2Hp3H/N54ACxQlPvRz6i1Hf1cdQG8Qc=
X-Received: by 2002:a05:600c:5303:b0:49c:fa21:1c87 with SMTP id
 5b1f17b1804b1-49cfa211dadmr202126655e9.28.1788799537542; 
 Mon, 07 Sep 2026 09:45:37 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce5533ffbsm327256975e9.3.2026.09.07.09.45.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 09:45:37 -0700 (PDT)
Date: Mon, 07 Sep 2026 18:42:06 +0200
Subject: [PATCH 16/50] hw/rtc: ds1338: add a persist-on-reset property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-bmc-minerva-v1-16-0d83ad610c3b@free.fr>
References: <20260907-bmc-minerva-v1-0-0d83ad610c3b@free.fr>
In-Reply-To: <20260907-bmc-minerva-v1-0-0d83ad610c3b@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org, 
 Patrick Leis <venture@google.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788799320; l=2768;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=iRJ3rs2DSADN75Y/aKHhGRl/gUKlcklqtq6S9GY4iFg=;
 b=R1zNsI39Wl6jksng4NyYVJYC2BQuA6xSnHaHVXPj/v9jnRKS9zfyzLQs/rxG/3dJmDtQ+EEn2
 bTl0tSv/mlLAIpwmVTyiK5tUUdcySRpKst8ZmuJWIMCWgE9enT86e1f
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.45; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f45.google.com
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

A real RTC keeps counting across a reboot of the machine it sits in,
and its register file comes back with it. The model instead wiped the
registers on every reset and resynchronised the clock with the host.

Add a property selecting between the two. It defaults off, leaving
every board as it was.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/rtc/ds1338.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/hw/rtc/ds1338.c b/hw/rtc/ds1338.c
index c5fc74e6ca..21deb94689 100644
--- a/hw/rtc/ds1338.c
+++ b/hw/rtc/ds1338.c
@@ -22,6 +22,7 @@
 #include "qemu/osdep.h"
 #include "hw/i2c/i2c.h"
 #include "hw/rtc/ds1338.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/bcd.h"
 #include "qom/object.h"
@@ -56,7 +57,8 @@ struct DS1338State {
     uint8_t nvram[NVRAM_SIZE];
     int32_t ptr;
     bool addr_byte;
-    bool osc_stopped;   /* oscillator halted: time is frozen */
+    bool osc_stopped;      /* oscillator halted: time is frozen */
+    bool persist_on_reset; /* keep the registers across a reset */
 };
 
 struct DS1338Class {
@@ -263,9 +265,8 @@ static int ds1338_send(I2CSlave *i2c, uint8_t data)
     return 0;
 }
 
-static void ds1338_reset_hold(Object *obj, ResetType type)
+static void ds1338_power_on(DS1338State *s)
 {
-    DS1338State *s = DS1338(obj);
     DS1338Class *k = DS1338_GET_CLASS(s);
 
     /* The clock is running and synchronized with the host */
@@ -273,11 +274,29 @@ static void ds1338_reset_hold(Object *obj, ResetType type)
     s->wday_offset = 0;
     memset(s->nvram, 0, NVRAM_SIZE);
     s->nvram[k->ctrl_addr] = k->ctrl_reset;
+    s->osc_stopped = false;
+}
+
+static void ds1338_realize(DeviceState *dev, Error **errp)
+{
+    ds1338_power_on(DS1338(dev));
+}
+
+static void ds1338_reset_hold(Object *obj, ResetType type)
+{
+    DS1338State *s = DS1338(obj);
+
+    if (!s->persist_on_reset) {
+        ds1338_power_on(s);
+    }
     s->ptr = 0;
     s->addr_byte = false;
-    s->osc_stopped = false;
 }
 
+static const Property ds1338_properties[] = {
+    DEFINE_PROP_BOOL("persist-on-reset", DS1338State, persist_on_reset, false),
+};
+
 static void ds1338_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -289,6 +308,8 @@ static void ds1338_class_init(ObjectClass *klass, const void *data)
     k->recv = ds1338_recv;
     k->send = ds1338_send;
     rc->phases.hold = ds1338_reset_hold;
+    dc->realize = ds1338_realize;
+    device_class_set_props(dc, ds1338_properties);
     dc->desc = "DS1338 I2C RTC with 56-byte NV RAM";
     dc->vmsd = &vmstate_ds1338;
 

-- 
2.50.1


