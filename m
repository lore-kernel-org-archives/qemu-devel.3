Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BDD6EB363C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 22:04:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxBMJ-0000Sj-BX; Mon, 02 Mar 2026 17:03:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vxBMI-0000RZ-0y
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 17:03:22 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vxBMG-0001Ar-A0
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 17:03:21 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-4375d4fb4d4so3620958f8f.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 14:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772488999; x=1773093799; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I3pSiajhTDR+3+VSpc4ntxNFFZn7kZ6nNzxA+ROJWxI=;
 b=TWV+lkWdY1I69pyTximCnHHM8006+JsBcXcSRraKI1v0xHKzbpEql4K/wS17w3z2wP
 0kj1dLAd6j8Yd4uX9z7AfHcaOld3CCi+V8npL7ZvO5FXjNOjr3/2ujcNYb93qVaOHRaF
 F1JoDsMYagszyQ/SwA2ZSOY8G9Xkd0hTd8ndxVSXOybzxByUFqQcto1lYR+g962uyQyL
 VLK3HKYWhL4SwaPlDcdPCGJK/qqiCBB3tfpMbwtBqTID44agRsyXzfbaHvHVHWA+5Fe3
 /L+vR00EWTcKsoglL2mxvR7Plt94HzeeTGoxiXgG2B2fKs1sGKqtA/QCgMW4FAcIHWvE
 v0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772488999; x=1773093799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I3pSiajhTDR+3+VSpc4ntxNFFZn7kZ6nNzxA+ROJWxI=;
 b=NMXrEzEB1oiYjPvA6HKXpO0JL7zY6uuiEcJDl9gimZIUmPdzwZBYcN3UkfTnLprkLx
 GGDr/HYU8p9WY9chWhQzLElwA8pZSiNUkofAw6gva7ACjCC1IemA558u9T0bq689/cby
 Abdg50RECP+kN9cc5vMV1vFh8BYDg7xy2biCU897bBNjt013OR3YRIZh5DdYUPOBSntu
 mKykAJmBZ+8+lFF7ym6ilTDAbC+ADFU6QEIm7L4OeL94lOWkWI032F1ZkZ8lm3OHRDN1
 POtRQ80RRGAKmS1MQE5KeNRnwCWP5DfMliGRMwboGQF1PsLaprXxFs1tYliSyRKBo1Bu
 /g9Q==
X-Gm-Message-State: AOJu0Yx7vkcyESYd/zln6ybzioDzll/Dgc4yrZ0C2j7Q7Ivcg9W6dCLq
 xIkPCxh9LB+h1FwsENmPlxqzfowke8S5DDd6zIefJlc7arLtBCauX12Ety0EBA==
X-Gm-Gg: ATEYQzyEVBaLTpIa0PU4AgqiP9xIyHMzXx5d8d4sJVIM3aTAVYZbbq0obvF31Ajx4A+
 xn/FCTM6iGNAigg0ddMTcgCUeyZ72J9Wl2g9nCXfqFMG4C4y8mz81cEJsHk7TVd3WeS7kylMlIM
 kn2Fxx4HHV8LvupziGHa5iFKI+8trGFKn7irqBk01sKT4ypoN3PX3LiE/CYkLtrkFLuUtJ5LLuE
 eRzh7Z0r0FLp/nOgdMphXOz+DrtTicnRlYYsP0fi11d06Ee14jvD1ZnmbU/31cOdqBs7WMe3c0y
 +v89nXGBcSeh0mV0E19o01BrfWiSdZLet3j3+snzjXdQ3YObqcsFvgpNy/2M4pg7FG2VBLKVyZE
 DGU5iDuq/P3EXWmFqlmPZTSvRRSBwTMXVYIvU6vtm11htHqdyQzbIHifX9YF39rxqfrOKyzlLhL
 Wzans8oHLBsOXtLbY2ssfIJQb90i3OGFrVXC0UU4LCm4JmUHOVbxCtN5WqyM/xDbf7oCqs1kg5k
 X2+GsfVJuwnKFOGRzx9E4/cyJCaC/4dXmgvtvPukUJ2439kyeb/HOsnww==
X-Received: by 2002:a05:6000:2502:b0:439:abcd:b2f6 with SMTP id
 ffacd0b85a97d-439abcdb576mr15242115f8f.27.1772488998506; 
 Mon, 02 Mar 2026 14:03:18 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-2a02-3100-2e0b-4800-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:2e0b:4800:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c765c38sm29308102f8f.31.2026.03.02.14.03.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 14:03:17 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Helge Deller <deller@gmx.de>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Troy Lee <leetroy@gmail.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 12/12] hw/char/serial: Plug into reset framework
Date: Mon,  2 Mar 2026 23:02:54 +0100
Message-ID: <20260302220254.1166849-13-shentey@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302220254.1166849-1-shentey@gmail.com>
References: <20260302220254.1166849-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x429.google.com
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
index c58337bd20..c4537e5764 100644
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
@@ -928,7 +927,6 @@ static void serial_realize(DeviceState *dev, Error **errp)
     s->modem_status_poll = timer_new_ns(QEMU_CLOCK_VIRTUAL, (QEMUTimerCB *) serial_update_msl, s);
 
     s->fifo_timeout_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, (QEMUTimerCB *) fifo_timeout_int, s);
-    qemu_register_reset(serial_reset, s);
 
     qemu_chr_fe_set_handlers(&s->chr, serial_can_receive1, serial_receive1,
                              serial_event, serial_be_change, s, NULL, true);
@@ -951,8 +949,6 @@ static void serial_unrealize(DeviceState *dev)
 
     fifo8_destroy(&s->recv_fifo);
     fifo8_destroy(&s->xmit_fifo);
-
-    qemu_unregister_reset(serial_reset, s);
 }
 
 const MemoryRegionOps serial_io_ops = {
@@ -982,6 +978,7 @@ static void serial_class_init(ObjectClass *klass, const void *data)
     dc->user_creatable = false;
     dc->realize = serial_realize;
     dc->unrealize = serial_unrealize;
+    device_class_set_legacy_reset(dc, serial_reset);
     device_class_set_props(dc, serial_properties);
 }
 
-- 
2.53.0


