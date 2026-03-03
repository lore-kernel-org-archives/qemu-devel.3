Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A6BEDEBFC
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 22:23:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxY8E-0004ou-T1; Tue, 03 Mar 2026 17:22:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vxY8D-0004nM-2T
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 17:22:21 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vxY8B-0002V6-JI
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 17:22:20 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48373a4bca3so37992885e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 14:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772576538; x=1773181338; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ov4Nf1FlvKPPTI6Fk3jlGNb+uvop9rtwW4FuxRgecD4=;
 b=IxXpAeLwCU4Hz6r+z3kFEs32Ofu34lAPVJUYCT3Lq2DBVYmk3MB6eyoTQ54Nq3nuUr
 cGeswy0PQFaZTLD0ZdC3qY0k5e2qTTWHwxqFqt4T9bTOrX7nBYHzlNMdMnAnQtJrDXTB
 cDVSRmuvNpv89Knv9kTiPR5dP7C/S1Uax19/QyZ15mvlQ4+iAt57wb/4L4MfF+0ScLeQ
 SZgGVU59DyOJ5llJFfPCHqcYjgoaoC4mlyjMx0l9D5Zs2dL/8xBdpH+KIwjMQn/3Vs9m
 V7ZXGUFuEaOifPOtwDQtvKIJ7wv5Zf1rmg8c/4GL7ikDRIxVO5VCQ0cvbA11rltbLwWg
 FQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772576538; x=1773181338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ov4Nf1FlvKPPTI6Fk3jlGNb+uvop9rtwW4FuxRgecD4=;
 b=dKaBFaI9/LXmuxGo8ImNj4H0MkpBprRIjK1A4RpBeVzw80uZ7x9OFaptS0yG4MRzXe
 VQ65slB1Qv/9p7gCMlUaA0KYpNkBTGGUCwB3zUrizcBTXV5ix/8WI/d+kH0yOMfWuXYT
 NkmCf98TUb3rAeikOlHXQUo0eFqH/sZANItH85Ku8NKqtWbs4hJUavIliZQwgmhyaQIE
 b7iZo08e0q/Ir4PFPw44lBwrrbnjb1WC632ZsIvvKkJplrQO/yIiaaMcZSkw3hzCdCtl
 wOpWHvd3v8vpIGMdzzKY2ck0Vfd4osW7KBf2bF2RFi9TYM1qFzwbpX9nZ+3mtybUwne7
 K8Xg==
X-Gm-Message-State: AOJu0YzvMJtD2IDGkMT94Efz6AsmHAtkusYeMN+7BhgVqBF+awhyXdoG
 ej3rlafLEysqLRzW7qcYJIEnpYj4NkdX86Suv5CTk3FlO/04Dg0GkguA3w0H3A==
X-Gm-Gg: ATEYQzwhjTXIUcpfNu3YtksYohitke4B2fM/y9x6vqgWkC922IT1mAxjI/lEc3665vl
 26lXE26ZBkGtl9LYShk5iHSEWM5nJakLwlCvIBFcxqdjLICHa2Tv2OxbNoPNU9FpnC2RkMKQXtn
 +f3XojBYooN13is/WudfuvSC8dRrJfYxHnfAi1CK4CJF5RM2SzZZooZ2psll8NJNx5XY98u7C3o
 OqjE/XW/LpxhgqC+kWXtEEM4nXPR6Cvq8ravk67zu/KlYVdLatIkL/qOi3RLo+KZWVXFTTrnK+d
 6W5mb++yjQx6LpNLz89WTJzqUJALUvs6ZnhhTKG1tUehm+GThA1GstNglyuzNkanmhACLK44wwK
 CYA4GlXDlwlKy7ejDL0iHgiV4IB6ROtLwpL0D4UbNcxznoDzhJ35tuSqPTI1DSWG4TFMd5oHuxR
 y1foD9zKSRcL+12havGPk8ZEgj+KiJzQR6SgovUPoseX04+VGtg8If9ir1wNXZrPaXnIDOxoaVe
 7641gOjD0btXBNnvIW97j2Z5C/zxTw=
X-Received: by 2002:a05:600c:4e0f:b0:483:103c:b1ee with SMTP id
 5b1f17b1804b1-483c9b9d925mr281291425e9.8.1772576537542; 
 Tue, 03 Mar 2026 14:22:17 -0800 (PST)
Received: from Provence
 (dynamic-2a02-3100-1c79-b600-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:1c79:b600:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485187c81adsm7577715e9.6.2026.03.03.14.22.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 14:22:17 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Troy Lee <leetroy@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-arm@nongnu.org,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 13/13] hw/char/serial: Plug into reset framework
Date: Tue,  3 Mar 2026 23:21:43 +0100
Message-ID: <20260303222143.142741-14-shentey@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303222143.142741-1-shentey@gmail.com>
References: <20260303222143.142741-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Now that SerialState inherits from SysBusDevice we can take advantage of
having the reset method called by the bus hierarchy rather than having
to plug and unplug it manually.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/char/serial.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index fc92897376..31ce3c7b40 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -31,7 +31,6 @@
 #include "chardev/char-serial.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
-#include "system/reset.h"
 #include "system/runstate.h"
 #include "qemu/error-report.h"
 #include "trace.h"
@@ -853,9 +852,9 @@ const VMStateDescription vmstate_serial = {
     }
 };
 
-static void serial_reset(void *opaque)
+static void serial_reset(DeviceState *dev)
 {
-    SerialState *s = opaque;
+    SerialState *s = SERIAL(dev);
 
     if (s->watch_tag > 0) {
         g_source_remove(s->watch_tag);
@@ -985,7 +984,6 @@ static void serial_realize(DeviceState *dev, Error **errp)
     s->modem_status_poll = timer_new_ns(QEMU_CLOCK_VIRTUAL, (QEMUTimerCB *) serial_update_msl, s);
 
     s->fifo_timeout_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, (QEMUTimerCB *) fifo_timeout_int, s);
-    qemu_register_reset(serial_reset, s);
 
     qemu_chr_fe_set_handlers(&s->chr, serial_can_receive1, serial_receive1,
                              serial_event, serial_be_change, s, NULL, true);
@@ -1008,8 +1006,6 @@ static void serial_unrealize(DeviceState *dev)
 
     fifo8_destroy(&s->recv_fifo);
     fifo8_destroy(&s->xmit_fifo);
-
-    qemu_unregister_reset(serial_reset, s);
 }
 
 static const Property serial_properties[] = {
@@ -1032,6 +1028,7 @@ static void serial_class_init(ObjectClass *klass, const void *data)
     dc->user_creatable = false;
     dc->realize = serial_realize;
     dc->unrealize = serial_unrealize;
+    device_class_set_legacy_reset(dc, serial_reset);
     device_class_set_props(dc, serial_properties);
 }
 
-- 
2.53.0


