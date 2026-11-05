Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD83606A326
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 08:57:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOtHh-0003HE-8M; Thu, 05 Nov 2026 03:57:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtHe-0003Gi-MZ
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 03:57:22 -0500
Received: from mail-pg1-f172.google.com ([209.85.215.172])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtHc-0003gU-Jo
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 03:57:22 -0500
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-cc4aa0246b7so790856a12.3
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 00:57:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793869038; x=1794473838;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9jZpvK/2JIYvTgChmDwtU9W+dxG3f61FuvNfLFka24M=;
 b=tgkjhy5Bsb2Vd9KwqUL7IQrf0RVVKap30IPR7FZqOESgFz1vJmUpPsi6VVzw3iDRBv
 hSSupCqkv/X2mlVEVGDqH3xJlSCvIsCdz5PKZFY7wnzkGbhxlNTuW68EVVnXkzbi7o0b
 8KCI5jwsBJc87Q6pIOKMSAF95/xr0uWct7zwXAY9D7LNQ5BpCc9aQg7sT22MAK88YHC8
 CNUYAgWUQXiypRzW//gRYBdBJpfNlvO9cwWWCSxfOtOMRjUeDt1wDjlFP/7etR9IZhNt
 AA6xK7Ha+4fDoM5DluTbWlKD4hTi3SqbKPKLaSOYM0aNhMzoV2fl/j7zF9FLIfAf/plE
 +l+g==
X-Gm-Message-State: APuU4Z/bbs8AOpN3nFleK2t6Mac2CqJZkQ2f6gUi/Loe9LrpklUuT2fo
 LrA/nozAvTr2PvCNQbhhGkLhAfl2gNANhlvYgdMIPvrp1Kj84q2HGcOSQoU69g==
X-Gm-Gg: AYBFou1BzGJGi1rw+74XKcYJ7rv8UUp1EbQFIftW1TBLBUsffu26XSE4251j2fcQ92U
 z8ne1ld/vd5m3/TbuYV41kYyTFneGVmqHDTs+OMRyeY96Pqfg3dmaCbpgSONAUKKriVF6YiVkxr
 bD0/8NMskJOLv/xwG4zYAnX0ZmFuHbLN8qzn5eACuUoa/BMPS8z0t6GI6+DmJcdBdM8+xUNI/bm
 tsEKnV2ZmqjzijwZWx7d24E4vxnsvxEaiSCLZ9s49+U8bBaZqOuIfPmm1y5ZOlI3Qq8bfvrfAur
 EaXUUGTEHoNgI86zxZgbEI/KvtDO5IKOMX827IUEUufLUQ5Kwgov1TkdqzEiY6BGw5ys3bhpPDh
 aqi6nD+V2OEvhfxc31HvwKV+OLV2Bb0ukcUiQ65lrpBsf5Sg3GX4keL9ijSeGau7sScgb1j0XUq
 0flkGy/z9LEkB1SpwCJ+b7xsELQNOooJ5i3jDlL7SW65dost7pat7QPwBfpPG8D0RLAvlbhGsom
 dEI2sCVHzsuKHxjojiBIu7OQ+UHRf1pXviixP3/NkvFDMZD1QCUpVodCbCUiV4nTrxNMC7K7bVv
 v+dY6Oo7T+AQcTYNh7OTiiSohQjMtbhH2xiw5R3ZuXKUftTs8jWz+kz9z8mCXCKyZGgPrzGbeB1
 fNyNRlw==
X-Received: by 2002:a17:90b:4c52:b0:3b0:a4d1:6d7a with SMTP id
 98e67ed59e1d1-3b0a4d1700dmr2715390a91.31.1793869038514; 
 Thu, 05 Nov 2026 00:57:18 -0800 (PST)
Received: from localhost (118-163-122-149.hinet-ip.hinet.net.
 [118.163.122.149]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0b2cf31acsm2819893a91.0.2026.11.05.00.57.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 00:57:18 -0800 (PST)
Date: Thu, 05 Nov 2026 16:50:40 +0800
Subject: [PATCH 04/19] hw/rtc: ds1338: add a persist-on-reset property
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-rtc-ds1339-v1-4-50a8dc463ee8@free.fr>
References: <20261105-rtc-ds1339-v1-0-50a8dc463ee8@free.fr>
In-Reply-To: <20261105-rtc-ds1339-v1-0-50a8dc463ee8@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, eblot@meta.com, 
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793868640; l=2773;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=qmvk0g/rmD++ZnSC5okHJqYVp2DjqufV612HoOi6RBE=;
 b=NQSJsxRYfHyZJVlxOFC0ObgfDRhQRJ+qIor2L0kbQWc2aeexcOBdllhrxwWVfdBVSxv3zlWra
 ghpOc/sYj+iC81Jx6RHrIGaXrBDJOSYflumCYsCSJQeWNC7KCqVkWvz
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.215.172; envelope-from=eblot.ml@gmail.com;
 helo=mail-pg1-f172.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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
2.53.0-Meta


