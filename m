Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7894ACD379F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 16:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slW4W-0004Su-1Y; Tue, 03 Sep 2024 12:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW4U-0004OS-UA
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:07:58 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW4S-0002eH-9N
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:07:58 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-428e0d184b4so46210835e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 09:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725379674; x=1725984474; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=THIrIBfM4vzOfJ3nHM2ubG7+E5S52F8G9as4tfAXnnQ=;
 b=OiP5F+uOFDoaoEmh/UEQI1EfponDU6E+/CRPFjFx6el6fuNV8s+xuYnA5vvRuAMdiR
 IG01rjLjN3ZE1N4RXliSY+40FFx1zbYCWmKeHsKtT/ShiBtgbWJFxVwx+xm8Q3oncs8X
 VmGyA67E9o4AcMkbW3JYXTSOyy/JfjUTV6BJ86KdeFvmS7rtIDq7MC/BOh1y0FM/b179
 CBvn2QH80GXsWWfM2GLoWnHO8KZ5K6BIs+1uhaGaDJRMBtlwAeE+DslVd4dwYplkpVkU
 BOIqfVU3QVZRv1JygTGzr0YGinDfICXX/Mpwiy1FqVpQwg7Cq6HzJ5arevNYA8UKssIW
 c7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725379674; x=1725984474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=THIrIBfM4vzOfJ3nHM2ubG7+E5S52F8G9as4tfAXnnQ=;
 b=vCPUOmHc06xQJY0oycpbHoSUWiB62mWcXuoKjKAlK4TIStAW1PHDwioe55UtIXW3Ri
 AYS2av1ZJ8ozPkUiJvVVZAY4+we3v6hXoLtooJvlsKccegE0Hxlyxjg1kdqvjdpip47m
 sgnQG49S5ZHTXr7Iy/AVaKsj9Rvcl6veV/dbvJduTzgV7L7P2nczyZkHTw47/Wm+liSw
 JYphpAzry2CCnwD/YZIvYfSzlVnKpEpOjnUCKZNKLalGhXerO6MlllBRn3MlChswtITd
 7j0Tc7NAd9j2hgq2e00dlmxI71RMdVKJnG2J/yEI7Lfoc2MQKDkIr5FMW1DW8+SzMAWk
 FzxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmFgoFsn38gLJgKipYAiUysaVzzMqCo8p0xptkuU0L4ixDMbPqz9Jb9Db/lj0AsL8TNyWCW0ZXjRTR@nongnu.org
X-Gm-Message-State: AOJu0YzURZf22x1vb4RkJPeaHYsweT1csWKJlufIoSGImaqulnwG3cTW
 0B34POCmElrIIp0tXz5BOfS/tIyqFBTkUBnBylRPf/epWgDrXybUzhkqiocn4vUIWGoDSytDNVH
 +
X-Google-Smtp-Source: AGHT+IEp7TvbwtOJWUi4Sn5IYHzE+ZJ3TCXshTUBXDmRm1Nhrk5H2AIoHEN+PJVi/Cs+0uls+57vrQ==
X-Received: by 2002:a05:600c:1d16:b0:42b:892d:54c0 with SMTP id
 5b1f17b1804b1-42c7b5a8db6mr72483765e9.12.1725379674527; 
 Tue, 03 Sep 2024 09:07:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df1066sm175123065e9.18.2024.09.03.09.07.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 09:07:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-9.2 02/53] hw/input: Drop ADS7846 device
Date: Tue,  3 Sep 2024 17:07:00 +0100
Message-Id: <20240903160751.4100218-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903160751.4100218-1-peter.maydell@linaro.org>
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The ADS7846 touchscreen controller device was used only by
the XScale-based PDA machine types. Now that they have been
removed, this device is not used in the tree and can be
deleted.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS          |   1 -
 hw/input/ads7846.c   | 186 -------------------------------------------
 hw/input/Kconfig     |   3 -
 hw/input/meson.build |   1 -
 4 files changed, 191 deletions(-)
 delete mode 100644 hw/input/ads7846.c

diff --git a/MAINTAINERS b/MAINTAINERS
index bcd84582099..4f00c7a3427 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -929,7 +929,6 @@ F: hw/*/pxa2xx*
 F: hw/display/tc6393xb.c
 F: hw/gpio/max7310.c
 F: hw/gpio/zaurus.c
-F: hw/input/ads7846.c
 F: hw/misc/mst_fpga.c
 F: hw/adc/max111x.c
 F: include/hw/adc/max111x.h
diff --git a/hw/input/ads7846.c b/hw/input/ads7846.c
deleted file mode 100644
index cde38922165..00000000000
--- a/hw/input/ads7846.c
+++ /dev/null
@@ -1,186 +0,0 @@
-/*
- * TI ADS7846 / TSC2046 chip emulation.
- *
- * Copyright (c) 2006 Openedhand Ltd.
- * Written by Andrzej Zaborowski <balrog@zabor.org>
- *
- * This code is licensed under the GNU GPL v2.
- *
- * Contributions after 2012-01-13 are licensed under the terms of the
- * GNU GPL, version 2 or (at your option) any later version.
- */
-
-#include "qemu/osdep.h"
-#include "hw/irq.h"
-#include "hw/ssi/ssi.h"
-#include "migration/vmstate.h"
-#include "qemu/module.h"
-#include "ui/console.h"
-#include "qom/object.h"
-
-struct ADS7846State {
-    SSIPeripheral ssidev;
-    qemu_irq interrupt;
-
-    int input[8];
-    int pressure;
-    int noise;
-
-    int cycle;
-    int output;
-};
-
-#define TYPE_ADS7846 "ads7846"
-OBJECT_DECLARE_SIMPLE_TYPE(ADS7846State, ADS7846)
-
-/* Control-byte bitfields */
-#define CB_PD0          (1 << 0)
-#define CB_PD1          (1 << 1)
-#define CB_SER          (1 << 2)
-#define CB_MODE         (1 << 3)
-#define CB_A0           (1 << 4)
-#define CB_A1           (1 << 5)
-#define CB_A2           (1 << 6)
-#define CB_START        (1 << 7)
-
-#define X_AXIS_DMAX     3470
-#define X_AXIS_MIN      290
-#define Y_AXIS_DMAX     3450
-#define Y_AXIS_MIN      200
-
-#define ADS_VBAT        2000
-#define ADS_VAUX        2000
-#define ADS_TEMP0       2000
-#define ADS_TEMP1       3000
-#define ADS_XPOS(x, y)  (X_AXIS_MIN + ((X_AXIS_DMAX * (x)) >> 15))
-#define ADS_YPOS(x, y)  (Y_AXIS_MIN + ((Y_AXIS_DMAX * (y)) >> 15))
-#define ADS_Z1POS(x, y) 600
-#define ADS_Z2POS(x, y) (600 + 6000 / ADS_XPOS(x, y))
-
-static void ads7846_int_update(ADS7846State *s)
-{
-    if (s->interrupt)
-        qemu_set_irq(s->interrupt, s->pressure == 0);
-}
-
-static uint32_t ads7846_transfer(SSIPeripheral *dev, uint32_t value)
-{
-    ADS7846State *s = ADS7846(dev);
-
-    switch (s->cycle ++) {
-    case 0:
-        if (!(value & CB_START)) {
-            s->cycle = 0;
-            break;
-        }
-
-        s->output = s->input[(value >> 4) & 7];
-
-        /* Imitate the ADC noise, some drivers expect this.  */
-        s->noise = (s->noise + 3) & 7;
-        switch ((value >> 4) & 7) {
-        case 1: s->output += s->noise ^ 2; break;
-        case 3: s->output += s->noise ^ 0; break;
-        case 4: s->output += s->noise ^ 7; break;
-        case 5: s->output += s->noise ^ 5; break;
-        }
-
-        if (value & CB_MODE)
-            s->output >>= 4;    /* 8 bits instead of 12 */
-
-        break;
-    case 1:
-        s->cycle = 0;
-        break;
-    }
-    return s->output;
-}
-
-static void ads7846_ts_event(void *opaque,
-                int x, int y, int z, int buttons_state)
-{
-    ADS7846State *s = opaque;
-
-    if (buttons_state) {
-        x = 0x7fff - x;
-        s->input[1] = ADS_XPOS(x, y);
-        s->input[3] = ADS_Z1POS(x, y);
-        s->input[4] = ADS_Z2POS(x, y);
-        s->input[5] = ADS_YPOS(x, y);
-    }
-
-    if (s->pressure == !buttons_state) {
-        s->pressure = !!buttons_state;
-
-        ads7846_int_update(s);
-    }
-}
-
-static int ads7856_post_load(void *opaque, int version_id)
-{
-    ADS7846State *s = opaque;
-
-    s->pressure = 0;
-    ads7846_int_update(s);
-    return 0;
-}
-
-static const VMStateDescription vmstate_ads7846 = {
-    .name = "ads7846",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .post_load = ads7856_post_load,
-    .fields = (const VMStateField[]) {
-        VMSTATE_SSI_PERIPHERAL(ssidev, ADS7846State),
-        VMSTATE_INT32_ARRAY(input, ADS7846State, 8),
-        VMSTATE_INT32(noise, ADS7846State),
-        VMSTATE_INT32(cycle, ADS7846State),
-        VMSTATE_INT32(output, ADS7846State),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static void ads7846_realize(SSIPeripheral *d, Error **errp)
-{
-    DeviceState *dev = DEVICE(d);
-    ADS7846State *s = ADS7846(d);
-
-    qdev_init_gpio_out(dev, &s->interrupt, 1);
-
-    s->input[0] = ADS_TEMP0;    /* TEMP0 */
-    s->input[2] = ADS_VBAT;     /* VBAT */
-    s->input[6] = ADS_VAUX;     /* VAUX */
-    s->input[7] = ADS_TEMP1;    /* TEMP1 */
-
-    /* We want absolute coordinates */
-    qemu_add_mouse_event_handler(ads7846_ts_event, s, 1,
-                    "QEMU ADS7846-driven Touchscreen");
-
-    ads7846_int_update(s);
-
-    vmstate_register_any(NULL, &vmstate_ads7846, s);
-}
-
-static void ads7846_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    SSIPeripheralClass *k = SSI_PERIPHERAL_CLASS(klass);
-
-    k->realize = ads7846_realize;
-    k->transfer = ads7846_transfer;
-    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
-}
-
-static const TypeInfo ads7846_info = {
-    .name          = TYPE_ADS7846,
-    .parent        = TYPE_SSI_PERIPHERAL,
-    .instance_size = sizeof(ADS7846State),
-    .class_init    = ads7846_class_init,
-};
-
-static void ads7846_register_types(void)
-{
-    type_register_static(&ads7846_info);
-}
-
-type_init(ads7846_register_types)
diff --git a/hw/input/Kconfig b/hw/input/Kconfig
index f86e98c8293..acfdba5c4ca 100644
--- a/hw/input/Kconfig
+++ b/hw/input/Kconfig
@@ -1,9 +1,6 @@
 config ADB
     bool
 
-config ADS7846
-    bool
-
 config LM832X
     bool
     depends on I2C
diff --git a/hw/input/meson.build b/hw/input/meson.build
index 3cc8ab85f0c..07a28c2c01c 100644
--- a/hw/input/meson.build
+++ b/hw/input/meson.build
@@ -1,6 +1,5 @@
 system_ss.add(files('hid.c'))
 system_ss.add(when: 'CONFIG_ADB', if_true: files('adb.c', 'adb-mouse.c', 'adb-kbd.c'))
-system_ss.add(when: 'CONFIG_ADS7846', if_true: files('ads7846.c'))
 system_ss.add(when: 'CONFIG_LM832X', if_true: files('lm832x.c'))
 system_ss.add(when: 'CONFIG_PCKBD', if_true: files('pckbd.c'))
 system_ss.add(when: 'CONFIG_PL050', if_true: files('pl050.c'))
-- 
2.34.1


