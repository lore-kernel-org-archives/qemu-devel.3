Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 723F6CA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 15:09:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGHe7-00081E-B3; Mon, 12 Oct 2026 11:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xGHe0-00080W-3u
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:08:52 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xGHdy-0007KA-Bb
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:08:51 -0400
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a061a13884so17416755e9.3
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 08:08:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791817728; x=1792422528;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yoI5CWQNkKU3FBXCClJtroQLxmdLnKfTK0MOA70taBk=;
 b=WnZe6mYOBq/XbnpoRfjtWXDvw790w5MBmcCd5T/PzfSVAoVkTmIzUAQwb9Nn3q4XP7
 nERVoz0P9RBaHO0cxu/C+mMh4QPESu1fhvLKqhkt0TRS6+ZWXJHT8mTb3A867ZSCQgFl
 NtCE3iuGbizii6Kh5QyLbJBjUvv+Qr+/BAhl10wUrQvWtgET/yWoHnOUxCtq2BqQrMpj
 n9AKxk8RJWHMhZGndubWB5k2G0LNwdzhLsE60J0t+CfvpH+6xvf11Xz1JetvxQe+lPjC
 oJ5yH7ZSTen/HEeODvQpphj8BZVf5jbd8QzrRiBJsDZoL2m8wwfkZiO+NZ6Bwj6BFu0d
 St5w==
X-Gm-Message-State: AFq9FYJ6ZWx+zgqsBImLpcRAFsd03hHYmokqM9vJgatLE1hAKNw1zSKh
 CBJZGeig39CC0+68KGPXY7yrNV8NXNYA4qQphHFF2SOpwV4EmeTPZhYCatigh9BC
X-Gm-Gg: AYBFou1Yw4QjB3dTD7MqO70MDzxM6p2f5HKN/QQMLgLE/jyMhG1vdY006+r4JySPhqA
 RayeLybxKlg9k2H96C1MsgcnTPatC7Y/QQniCeHEDrDHCg4ADOUlmojqlK2Dt6iS8v8H8IM+uT3
 Zw2JPxWOGe1xmOtlaYTslJ5K8M/Aa1JuFAQ81rL6IaH1Oh+nylS1Wo/dWC2oPwLkOK9K/F6tWK/
 2U2eI9EnYVs7LNrDZ0n1W2STCof9/yTbJ+IoK/uqsdmRSOeQLBhWcfSrsun4q8dmHZOvAp2xVgn
 tPyS0m7FjeEdnKDVdkKKkx9vIbc1nLdHn/6zVZQJNgpX3qs2LBG/Dc9mBwnZ8NHvjMfiGBCp/ps
 jg3COAfOwSwg6b5kXHmxLz+ux826xeRaiuu9pKR3ImH/W2B9y1PHe5gvr05N/RIJxzfpNJ6oZ5w
 FGO3pbuGyYk8zwgPwKydOGu+Pq86VFoJcy/qEBvaE+xmTmJjFUdOwyZHDM0YkuJZF+uNZ2PSzjR
 nAsXMibjNixWzJqm9zIcz3MLarx52RBZTqXRKzmwOFcWw==
X-Received: by 2002:a05:600c:674a:b0:49f:f0bd:1e40 with SMTP id
 5b1f17b1804b1-4a18e4afe9cmr172116475e9.23.1791817727904; 
 Mon, 12 Oct 2026 08:08:47 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be8c5e7sm369203195e9.4.2026.10.12.08.08.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 08:08:47 -0700 (PDT)
Date: Mon, 12 Oct 2026 16:32:09 +0200
Subject: [PATCH v2 16/50] hw/rtc: ds1338: add a persist-on-reset property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-bmc-minerva-v2-16-4c3dff084ec9@free.fr>
References: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
In-Reply-To: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
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
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791815520; l=2768;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=iRJ3rs2DSADN75Y/aKHhGRl/gUKlcklqtq6S9GY4iFg=;
 b=LDDgByaSsE/yCzMpiyeYGFE3fRE0Wq8PEfJurPiQ/qp7WDod40sbkL0nj7CsyRJxYzeRMsPnc
 OAA9dAKXSnzCjd9kplVbXmIQFhHqE/XjRIWRhoZEzBVB3DIGbnybUUO
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.52; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f52.google.com
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


