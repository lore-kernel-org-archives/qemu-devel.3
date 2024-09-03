Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9313ECD37A7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 16:13:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slW4a-0004lU-LL; Tue, 03 Sep 2024 12:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW4Z-0004fT-1Z
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:08:03 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW4T-0002ei-6z
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:08:02 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42bb885f97eso27858705e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 09:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725379676; x=1725984476; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=13B8gTkbbPzY+9dN2IYKPXcaRCE8IIQJPQasX/L66Ag=;
 b=gesrq2ff+aip66eNU4we3mDNnCHo6feNOYt11YrbYVWo3WqVQBcUy7lTcD5XPSrOjv
 wdQHFKA3xKTjNqTLrUKmc7q60n6O1imgLVvNKE0hVOuYdqkpG2PReOcZAuZ4+Og5b5nt
 CUT4BhpjvNScHfr3NCgSQvJAS5REeVraMzD79KU+Vt69U8kHFRROQfv/tgKQ2yTNI3k7
 ha4ebBq5EiTpD72kmDgJZyyCkq+/qqGjYvwM1S9OkEl7IfCDD8GsiR4spGpwiXa3HxBZ
 REApKWQCijt8ongDg6xxXtRicLSOAUzUA6UFJbP8Ux8jUBtWso9aTx4LCAEOb1rBlcRG
 rUtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725379676; x=1725984476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=13B8gTkbbPzY+9dN2IYKPXcaRCE8IIQJPQasX/L66Ag=;
 b=sxUBrnIO81gAsisDTWU6+9icgPjiSI64PFgDbzi3+G+dBwwtLpFCTSuB3mn8cg2pMY
 iLnN8xbgVvoRHkICGuPHD3I0/w/tAPo/bBiLhwQRsP2Us/hG3lRKYDbeRDl8i2if+xhB
 f6gc5UK4SNI4fTP2HSgS5RwAA6yxx5DUa/5udo6dJFBLdZeXOv392DSlGYdII0zgJO0M
 ateQCaJixYl4TAaX0GmxEeDoiLaOZsKJF2a6e6zIEX6WcQ+rAN4Rf17MTBmqVY46foXN
 zDhmBEqYzY9l5Upl8qmZ6DT9nhhjzRYDcXiMZgzkMRr+PXeyELRp8RguhjvRT35uh9Iu
 kI/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+OCS5eBKz3lDr2xPtRzFeg094ZSFdN+H4i8FAn6DkWEoZLEenLyTt1wmKLKpJCjqsYGN3V4kNLS6o@nongnu.org
X-Gm-Message-State: AOJu0YxLrxWh4Fhendd3uaOUwkGIbPAtDYuVj0QMo9T7wkjfbTly3hgS
 uzVodLSbzecV/dW3NcQMxNJHLqoOH+sazhxFh+d6IboTzqx+5D3ByBg/bL60Wv2guqbH7Bfctxt
 t
X-Google-Smtp-Source: AGHT+IFyyc/Hs97oA8IVyHGUoNq/mYs8Om898g8eCc5iZk3QvqV/H4a/S08KK46ruoRZCAGCHHYHUQ==
X-Received: by 2002:a05:600c:3ba1:b0:42a:a6dc:3083 with SMTP id
 5b1f17b1804b1-42bbb692e8fmr84195735e9.13.1725379675604; 
 Tue, 03 Sep 2024 09:07:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df1066sm175123065e9.18.2024.09.03.09.07.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 09:07:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-9.2 04/53] hw/gpio: Remove MAX7310 device
Date: Tue,  3 Sep 2024 17:07:02 +0100
Message-Id: <20240903160751.4100218-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903160751.4100218-1-peter.maydell@linaro.org>
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

The MAX7310 GPIO controller was used only by the XScale-based Zaurus
machine types.  Now they have been removed we can remove this device
model as well.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS         |   1 -
 hw/gpio/max7310.c   | 217 --------------------------------------------
 hw/gpio/Kconfig     |   4 -
 hw/gpio/meson.build |   1 -
 4 files changed, 223 deletions(-)
 delete mode 100644 hw/gpio/max7310.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7873350f6ef..e9ce1e2e051 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -927,7 +927,6 @@ F: hw/arm/mainstone.c
 F: hw/arm/z2.c
 F: hw/*/pxa2xx*
 F: hw/display/tc6393xb.c
-F: hw/gpio/max7310.c
 F: hw/gpio/zaurus.c
 F: hw/misc/mst_fpga.c
 F: include/hw/arm/pxa.h
diff --git a/hw/gpio/max7310.c b/hw/gpio/max7310.c
deleted file mode 100644
index 86315714fbd..00000000000
--- a/hw/gpio/max7310.c
+++ /dev/null
@@ -1,217 +0,0 @@
-/*
- * MAX7310 8-port GPIO expansion chip.
- *
- * Copyright (c) 2006 Openedhand Ltd.
- * Written by Andrzej Zaborowski <balrog@zabor.org>
- *
- * This file is licensed under GNU GPL.
- */
-
-#include "qemu/osdep.h"
-#include "hw/i2c/i2c.h"
-#include "hw/irq.h"
-#include "migration/vmstate.h"
-#include "qemu/log.h"
-#include "qemu/module.h"
-#include "qom/object.h"
-
-#define TYPE_MAX7310 "max7310"
-OBJECT_DECLARE_SIMPLE_TYPE(MAX7310State, MAX7310)
-
-struct MAX7310State {
-    I2CSlave parent_obj;
-
-    int i2c_command_byte;
-    int len;
-
-    uint8_t level;
-    uint8_t direction;
-    uint8_t polarity;
-    uint8_t status;
-    uint8_t command;
-    qemu_irq handler[8];
-    qemu_irq *gpio_in;
-};
-
-static void max7310_reset(DeviceState *dev)
-{
-    MAX7310State *s = MAX7310(dev);
-
-    s->level &= s->direction;
-    s->direction = 0xff;
-    s->polarity = 0xf0;
-    s->status = 0x01;
-    s->command = 0x00;
-}
-
-static uint8_t max7310_rx(I2CSlave *i2c)
-{
-    MAX7310State *s = MAX7310(i2c);
-
-    switch (s->command) {
-    case 0x00:  /* Input port */
-        return s->level ^ s->polarity;
-
-    case 0x01:  /* Output port */
-        return s->level & ~s->direction;
-
-    case 0x02:  /* Polarity inversion */
-        return s->polarity;
-
-    case 0x03:  /* Configuration */
-        return s->direction;
-
-    case 0x04:  /* Timeout */
-        return s->status;
-
-    case 0xff:  /* Reserved */
-        return 0xff;
-
-    default:
-        qemu_log_mask(LOG_UNIMP, "%s: Unsupported register 0x02%" PRIx8 "\n",
-                      __func__, s->command);
-        break;
-    }
-    return 0xff;
-}
-
-static int max7310_tx(I2CSlave *i2c, uint8_t data)
-{
-    MAX7310State *s = MAX7310(i2c);
-    uint8_t diff;
-    int line;
-
-    if (s->len ++ > 1) {
-#ifdef VERBOSE
-        printf("%s: message too long (%i bytes)\n", __func__, s->len);
-#endif
-        return 1;
-    }
-
-    if (s->i2c_command_byte) {
-        s->command = data;
-        s->i2c_command_byte = 0;
-        return 0;
-    }
-
-    switch (s->command) {
-    case 0x01:  /* Output port */
-        for (diff = (data ^ s->level) & ~s->direction; diff;
-                        diff &= ~(1 << line)) {
-            line = ctz32(diff);
-            if (s->handler[line])
-                qemu_set_irq(s->handler[line], (data >> line) & 1);
-        }
-        s->level = (s->level & s->direction) | (data & ~s->direction);
-        break;
-
-    case 0x02:  /* Polarity inversion */
-        s->polarity = data;
-        break;
-
-    case 0x03:  /* Configuration */
-        s->level &= ~(s->direction ^ data);
-        s->direction = data;
-        break;
-
-    case 0x04:  /* Timeout */
-        s->status = data;
-        break;
-
-    case 0x00:  /* Input port - ignore writes */
-        break;
-    default:
-        qemu_log_mask(LOG_UNIMP, "%s: Unsupported register 0x02%" PRIx8 "\n",
-                      __func__, s->command);
-        return 1;
-    }
-
-    return 0;
-}
-
-static int max7310_event(I2CSlave *i2c, enum i2c_event event)
-{
-    MAX7310State *s = MAX7310(i2c);
-    s->len = 0;
-
-    switch (event) {
-    case I2C_START_SEND:
-        s->i2c_command_byte = 1;
-        break;
-    case I2C_FINISH:
-#ifdef VERBOSE
-        if (s->len == 1)
-            printf("%s: message too short (%i bytes)\n", __func__, s->len);
-#endif
-        break;
-    default:
-        break;
-    }
-
-    return 0;
-}
-
-static const VMStateDescription vmstate_max7310 = {
-    .name = "max7310",
-    .version_id = 0,
-    .minimum_version_id = 0,
-    .fields = (const VMStateField[]) {
-        VMSTATE_INT32(i2c_command_byte, MAX7310State),
-        VMSTATE_INT32(len, MAX7310State),
-        VMSTATE_UINT8(level, MAX7310State),
-        VMSTATE_UINT8(direction, MAX7310State),
-        VMSTATE_UINT8(polarity, MAX7310State),
-        VMSTATE_UINT8(status, MAX7310State),
-        VMSTATE_UINT8(command, MAX7310State),
-        VMSTATE_I2C_SLAVE(parent_obj, MAX7310State),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static void max7310_gpio_set(void *opaque, int line, int level)
-{
-    MAX7310State *s = (MAX7310State *) opaque;
-    assert(line >= 0 && line < ARRAY_SIZE(s->handler));
-
-    if (level)
-        s->level |= s->direction & (1 << line);
-    else
-        s->level &= ~(s->direction & (1 << line));
-}
-
-/* MAX7310 is SMBus-compatible (can be used with only SMBus protocols),
- * but also accepts sequences that are not SMBus so return an I2C device.  */
-static void max7310_realize(DeviceState *dev, Error **errp)
-{
-    MAX7310State *s = MAX7310(dev);
-
-    qdev_init_gpio_in(dev, max7310_gpio_set, ARRAY_SIZE(s->handler));
-    qdev_init_gpio_out(dev, s->handler, ARRAY_SIZE(s->handler));
-}
-
-static void max7310_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
-
-    dc->realize = max7310_realize;
-    k->event = max7310_event;
-    k->recv = max7310_rx;
-    k->send = max7310_tx;
-    dc->reset = max7310_reset;
-    dc->vmsd = &vmstate_max7310;
-}
-
-static const TypeInfo max7310_info = {
-    .name          = TYPE_MAX7310,
-    .parent        = TYPE_I2C_SLAVE,
-    .instance_size = sizeof(MAX7310State),
-    .class_init    = max7310_class_init,
-};
-
-static void max7310_register_types(void)
-{
-    type_register_static(&max7310_info);
-}
-
-type_init(max7310_register_types)
diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig
index 19c97cc823f..c9c340f6eb4 100644
--- a/hw/gpio/Kconfig
+++ b/hw/gpio/Kconfig
@@ -1,7 +1,3 @@
-config MAX7310
-    bool
-    depends on I2C
-
 config PL061
     bool
 
diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
index a7495d196ae..010ad3bf5a7 100644
--- a/hw/gpio/meson.build
+++ b/hw/gpio/meson.build
@@ -1,7 +1,6 @@
 system_ss.add(when: 'CONFIG_GPIO_KEY', if_true: files('gpio_key.c'))
 system_ss.add(when: 'CONFIG_GPIO_MPC8XXX', if_true: files('mpc8xxx.c'))
 system_ss.add(when: 'CONFIG_GPIO_PWR', if_true: files('gpio_pwr.c'))
-system_ss.add(when: 'CONFIG_MAX7310', if_true: files('max7310.c'))
 system_ss.add(when: 'CONFIG_PCA9552', if_true: files('pca9552.c'))
 system_ss.add(when: 'CONFIG_PCA9554', if_true: files('pca9554.c'))
 system_ss.add(when: 'CONFIG_PL061', if_true: files('pl061.c'))
-- 
2.34.1


