Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B93CD3427
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 16:53:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJwXQ-0004Ah-08; Mon, 04 May 2026 12:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.hansen@9elements.com>)
 id 1wJwXC-00047D-CW
 for qemu-devel@nongnu.org; Mon, 04 May 2026 12:52:45 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.hansen@9elements.com>)
 id 1wJwX9-0005Fy-Hl
 for qemu-devel@nongnu.org; Mon, 04 May 2026 12:52:41 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43fe3e22e33so2385219f8f.0
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 09:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1777913558; x=1778518358; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ld3Dd39c2wJSVAkgWIeLW7ciUNQJ7dEcrGhn5btwy4o=;
 b=GL+dLQwv+Y493t/vR6n8+j31h16wFQCfUzEAC75GmevzoiWKdy3ef3ZIIN2LzgB/mg
 qQ7BEXCn0sKc15gZPt5fMu3FSUWKm5ZZBwG0AXB1KIQrin+BWKE2zl62l0R4W/S+1H9I
 1f214DdxkBnSvIr4C4yzMmtSYOptHV+6j43YcHTp9QkzVI7wubhNCmKwKFhTnvoLPaWT
 UjlparXvA9arp6UhtTRTR/dgJfuVgD5zFjsGjn6DwE3F5QZOJqavpK0idaXvdO4ePL2M
 1sf7DGvPHge5yQKxbpw4vqcVWqpHuL/KFlv3y27iDNf/H5SqTlxU7irEtdjBnzJglRAJ
 j94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777913558; x=1778518358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ld3Dd39c2wJSVAkgWIeLW7ciUNQJ7dEcrGhn5btwy4o=;
 b=hysI3WDOhpEO32VTxDcf6pZYoFhgu/5lhdJViNzC+0rYV8MGuYCnYC820I51ztFT4X
 mcSytBxOsbRwIxQuRyni6oTylxeUSGb36I7VtWU3MlYoJriTFArYT35m/9IOt2gbjB0O
 aMgVcxztn4yGkPc19MdY3SaBEDPPLMqyZY5V9R32vvogS7wkHNubvAmVI1l0otprv0Ms
 o1ap77HWdPjg+sLOmSltxCOECx1WVu0Esa4lH2xiwASJ2K2SauW/uOd9hW3yvA+k8fJd
 L2Iw55A5Fod1wstTFkPTzOayOG9ztM4I6voSaNjbVlEHdAdkyoEgyMYdFlfgRD4hycyV
 UPYw==
X-Gm-Message-State: AOJu0YzSjSmJqK3XwUqocrB290bPTc/UkpgAvA5Yi2pg412mKm3pqNWf
 TYIbVyFDtmHfzABlZQ3A8OgEI5ZR+4IvCYvpsk32uaz+cLfBPeHlloOaK7kYTjGy+N2sCe2d4cX
 d3fbtjTw=
X-Gm-Gg: AeBDies45Zs45O/B4IPUH6Dv8jIjvN0Fk4vSPDUpiqTIJoA3Vj2vAtu7SpOUH8eRSlI
 Rc5mJDxbJSEHW2w68bj/uU7e004d3XRYT9iINrz6xtSX1xfKDxxXbRGJFxccbu/IRFTqSYOFVuh
 CBber2Sqm7UjZZzvuELtCgtxFejdsbFjyDYSSPoDgJ7MYft/2dLS1xaE5c3JpTf6/nCha1D1D9d
 2aMergmOWbc+vckYs+2n/8oac12T237fBkR3nKmNHpe7c3iJuoM32eNS6urxDCeWrPcvlJjEnMw
 fShQNDkzAPcmqMC2x80iSS/z3ctzFTMN8IyKGobDDUhVVYAhZbiQAQmQcrlCbx+1bjosGCtoGNH
 bdUg22814RlIDEN7jRSQgUE1YN/bE4Nra6I21/5i4pGmcN48Z78y5HY7z4XLkMAEOKQ7yU5mY3+
 4QnAwpsTBfeaH/y9uYhFZL7lTv0Oa5V8a58dUhrhOWO8VHmTTZK0u7yEU=
X-Received: by 2002:a05:6000:18a5:b0:43d:7508:c9c9 with SMTP id
 ffacd0b85a97d-44bb59627cbmr17749335f8f.27.1777913557239; 
 Mon, 04 May 2026 09:52:37 -0700 (PDT)
Received: from alexanderarchlinux ([188.111.3.154])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44a8ef50e59sm26482830f8f.10.2026.05.04.09.52.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 09:52:36 -0700 (PDT)
From: Alexander Hansen <alexander.hansen@9elements.com>
To: qemu-devel@nongnu.org
Cc: Alexander Hansen <alexander.hansen@9elements.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH 2/4] hw/sensor: support MAX11615
Date: Mon,  4 May 2026 18:48:34 +0200
Message-ID: <20260504165043.213704-4-alexander.hansen@9elements.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504165043.213704-2-alexander.hansen@9elements.com>
References: <20260504165043.213704-2-alexander.hansen@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alexander.hansen@9elements.com; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Product: [1]
Datasheet: [2]

Sensor readings can be provided upon creation of the device. In case no
readings are provided the ADC reads a pre-deviced arbitrary value.

```
root@yosemite4:~# cat /sys/bus/iio/devices/iio:device2/in_voltage0_raw
2770
```

trace:
```
less /tmp/qemu-trace.log | grep -i max116
max11615_realize i2c_addr: 0x33
max11615_realize i2c_addr: 0x33
max11615_event i2c_addr: 0x33, event: 0x01
max11615_write_setup i2c_addr: 0x33, data: 0xd2
max11615_write_config i2c_addr: 0x33, data: 0x0f
max11615_event i2c_addr: 0x33, event: 0x03
max11615_event i2c_addr: 0x33, event: 0x01
max11615_write_setup i2c_addr: 0x33, data: 0xd2
max11615_write_config i2c_addr: 0x33, data: 0x0f
max11615_event i2c_addr: 0x33, event: 0x03
max11615_event i2c_addr: 0x33, event: 0x01
max11615_write_setup i2c_addr: 0x33, data: 0xd2
max11615_write_config i2c_addr: 0x33, data: 0x61
max11615_event i2c_addr: 0x33, event: 0x03
max11615_event i2c_addr: 0x33, event: 0x00
max11615_recv i2c_addr: 0x33, reg_addr: 0x00
max11615_recv_return i2c_addr: 0x33, returns: 0xfa
max11615_recv i2c_addr: 0x33, reg_addr: 0x00
max11615_recv_return i2c_addr: 0x33, returns: 0xd2
max11615_event i2c_addr: 0x33, event: 0x04
max11615_event i2c_addr: 0x33, event: 0x03
```

References:
[1] https://www.analog.com/en/products/MAX11615.html
[2] https://www.analog.com/media/en/technical-documentation/data-sheets/MAX11612-MAX11617.pdf

Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org> (odd fixer:Overall sensors)
Cc: Paolo Bonzini <pbonzini@redhat.com> (maintainer:Kconfig)
Cc: Peter Maydell <peter.maydell@linaro.org> (supporter:ARM TCG CPUs)
Cc: qemu-devel@nongnu.org (open list:All patches CC here)
Cc: qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Signed-off-by: Alexander Hansen <alexander.hansen@9elements.com>
---
 hw/arm/Kconfig               |   1 +
 hw/sensor/Kconfig            |   4 +
 hw/sensor/max11615.c         | 200 +++++++++++++++++++++++++++++++++++
 hw/sensor/meson.build        |   1 +
 hw/sensor/trace-events       |   8 ++
 include/hw/sensor/max11615.h |  20 ++++
 6 files changed, 234 insertions(+)
 create mode 100644 hw/sensor/max11615.c
 create mode 100644 include/hw/sensor/max11615.h

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index c62db7e609..decbc8b0d8 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -552,6 +552,7 @@ config ASPEED_SOC
     select PMBUS
     select MAX31785
     select MAX31790
+    select MAX11615
     select FSI_APB2OPB_ASPEED
     select AT24C
     select PCI_EXPRESS
diff --git a/hw/sensor/Kconfig b/hw/sensor/Kconfig
index ece2f2b167..84eede9d84 100644
--- a/hw/sensor/Kconfig
+++ b/hw/sensor/Kconfig
@@ -47,3 +47,7 @@ config MAX31785
 config MAX31790
     bool
     depends on PMBUS
+
+config MAX11615
+    bool
+    depends on I2C
diff --git a/hw/sensor/max11615.c b/hw/sensor/max11615.c
new file mode 100644
index 0000000000..88b519ad58
--- /dev/null
+++ b/hw/sensor/max11615.c
@@ -0,0 +1,200 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Maxim MAX11615 Low-Power 12 bit ADC
+ * Models MAX11612,MAX11613,MAX11614,MAX11615,MAX11616,MAX11617
+ *
+ * Datasheet:
+ * https://www.analog.com/media/en/technical-documentation/data-sheets/MAX11612-MAX11617.pdf
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "hw/i2c/i2c.h"
+#include "migration/vmstate.h"
+#include "qapi/error.h"
+#include "qapi/visitor.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "trace.h"
+#include "hw/sensor/max11615.h"
+
+#define MAX11615_NUM_CHANNELS 8
+
+struct MAX11615State {
+    I2CSlave i2c;
+
+    uint16_t channels[MAX11615_NUM_CHANNELS];
+
+    /* output buffer */
+    uint8_t outlen;
+    uint8_t outbuf[2];
+
+    /* selected channel for read/write operation */
+    uint8_t pointer;
+};
+
+struct MAX11615Class {
+    I2CSlaveClass parent_class;
+};
+
+OBJECT_DECLARE_TYPE(MAX11615State, MAX11615Class, MAX11615)
+
+static void max11615_read(MAX11615State *s)
+{
+    /* read an ADC channel, first 4 bits must be high */
+    uint8_t msb = s->channels[s->pointer] >> 8;
+    uint8_t lsb = s->channels[s->pointer] & 0xff;
+    s->outbuf[0] = 0b11110000 | (msb & 0b00001111);
+    s->outbuf[1] = lsb;
+}
+
+static void max11615_write_config_byte(MAX11615State *s, uint8_t data)
+{
+    trace_max11615_write_config(s->i2c.address, data);
+
+    uint8_t channelSelect = (data >> 1) & 0b1111;
+
+    /* Table 3. Channel Selection (AIN0 ... AIN11) */
+    if (channelSelect > 11) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid channel select", __func__);
+        channelSelect = 11;
+    }
+    s->pointer = channelSelect;
+}
+
+static void max11615_write_setup_byte(MAX11615State *s, uint8_t data)
+{
+    trace_max11615_write_setup(s->i2c.address, data);
+    /* we ignore the setup byte, not implemented */
+}
+
+static int max11615_send(I2CSlave *i2c, uint8_t data)
+{
+    MAX11615State *s = MAX11615(i2c);
+    const uint8_t msb = (data >> 7) & 0b1;
+
+    if (msb) {
+        max11615_write_setup_byte(s, data);
+    } else {
+        max11615_write_config_byte(s, data);
+    }
+
+    s->outlen = 0;
+    return 0;
+}
+
+static uint8_t max11615_recv(I2CSlave *i2c)
+{
+    MAX11615State *s = MAX11615(i2c);
+    trace_max11615_recv(s->i2c.address, s->pointer);
+
+    max11615_read(s);
+
+    if (s->outlen >= 2) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: too many bytes read", __func__);
+        s->outlen = 0;
+    }
+
+    const uint8_t data =  s->outbuf[s->outlen++];
+
+    trace_max11615_recv_return(s->i2c.address, data);
+    return data;
+}
+
+static int max11615_event(I2CSlave *i2c, enum i2c_event event)
+{
+    MAX11615State *s = MAX11615(i2c);
+
+    trace_max11615_event(s->i2c.address, event);
+
+    switch (event) {
+    case I2C_START_RECV:
+        s->outlen = 0;
+        break;
+    default:
+        break;
+    }
+
+    return 0;
+}
+
+static const VMStateDescription vmstate_max11615 = {
+    .name = TYPE_MAX11615,
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (const VMStateField[]){
+        VMSTATE_UINT16_ARRAY(channels, MAX11615State, MAX11615_NUM_CHANNELS),
+        VMSTATE_UINT8(outlen, MAX11615State),
+        VMSTATE_UINT8_ARRAY(outbuf, MAX11615State, 2),
+        VMSTATE_UINT8(pointer, MAX11615State),
+        VMSTATE_I2C_SLAVE(i2c, MAX11615State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void max11615_init(Object *obj)
+{
+    /* Nothing to do */
+}
+
+I2CSlave *max11615_init_with_values(I2CBus *bus, uint8_t address,
+    const uint16_t *init_values, uint32_t init_values_size)
+{
+    MAX11615State *s;
+
+    s = MAX11615(i2c_slave_new(TYPE_MAX11615, address));
+
+    for (int i = 0; i < MAX11615_NUM_CHANNELS && i < init_values_size; i++) {
+
+        /* arbitrary value */
+        uint16_t value = 0b0000101011010010;
+
+        if (i < init_values_size) {
+            value = init_values[i];
+        }
+        s->channels[i] = value;
+    }
+
+    i2c_slave_realize_and_unref(I2C_SLAVE(s), bus, &error_abort);
+
+    return I2C_SLAVE(s);
+}
+
+static void max11615_realize(DeviceState *dev, Error **errp)
+{
+    MAX11615State *s = MAX11615(dev);
+
+    trace_max11615_realize(s->i2c.address);
+
+    s->pointer = 0;
+    s->outlen = 0;
+}
+
+static void max11615_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
+
+    dc->realize = max11615_realize;
+    dc->desc = "Maxim MAX11615 12-bit ADC";
+    dc->vmsd = &vmstate_max11615;
+    k->event = max11615_event;
+    k->recv = max11615_recv;
+    k->send = max11615_send;
+}
+
+static const TypeInfo max31790_info = {
+    .name = TYPE_MAX11615,
+    .parent = TYPE_I2C_SLAVE,
+    .instance_size = sizeof(MAX11615State),
+    .class_size = sizeof(MAX11615Class),
+    .instance_init = max11615_init,
+    .class_init = max11615_class_init,
+};
+
+static void max31790_register_types(void)
+{
+    type_register_static(&max31790_info);
+}
+
+type_init(max31790_register_types)
diff --git a/hw/sensor/meson.build b/hw/sensor/meson.build
index 4987c3b253..a1e26604fa 100644
--- a/hw/sensor/meson.build
+++ b/hw/sensor/meson.build
@@ -9,3 +9,4 @@ system_ss.add(when: 'CONFIG_LSM303DLHC_MAG', if_true: files('lsm303dlhc_mag.c'))
 system_ss.add(when: 'CONFIG_ISL_PMBUS_VR', if_true: files('isl_pmbus_vr.c'))
 system_ss.add(when: 'CONFIG_MAX31785', if_true: files('max31785.c'))
 system_ss.add(when: 'CONFIG_MAX31790', if_true: files('max31790.c'))
+system_ss.add(when: 'CONFIG_MAX11615', if_true: files('max11615.c'))
diff --git a/hw/sensor/trace-events b/hw/sensor/trace-events
index c15c0a7e93..3fed979e85 100644
--- a/hw/sensor/trace-events
+++ b/hw/sensor/trace-events
@@ -12,3 +12,11 @@ max31790_recv_return(uint8_t i2c_addr, uint8_t data) "i2c_addr: 0x%02x, returns:
 max31790_event(uint8_t i2c_addr, uint8_t event) "i2c_addr: 0x%02x, event: 0x%02x"
 max31790_realize(uint8_t i2c_addr) "i2c_addr: 0x%02x"
 max31790_pwm_write(uint8_t i2c_addr, size_t index, uint16_t value) "i2c_addr: 0x%02x, index: %zu, value: 0x%04x"
+
+# max11615.c
+max11615_write_setup(uint8_t i2c_addr, uint8_t send) "i2c_addr: 0x%02x, data: 0x%02x"
+max11615_write_config(uint8_t i2c_addr, uint8_t send) "i2c_addr: 0x%02x, data: 0x%02x"
+max11615_recv(uint8_t i2c_addr, uint8_t reg_addr) "i2c_addr: 0x%02x, reg_addr: 0x%02x"
+max11615_recv_return(uint8_t i2c_addr, uint8_t data) "i2c_addr: 0x%02x, returns: 0x%02x"
+max11615_event(uint8_t i2c_addr, uint8_t event) "i2c_addr: 0x%02x, event: 0x%02x"
+max11615_realize(uint8_t i2c_addr) "i2c_addr: 0x%02x"
diff --git a/include/hw/sensor/max11615.h b/include/hw/sensor/max11615.h
new file mode 100644
index 0000000000..ccc0c9bc2e
--- /dev/null
+++ b/include/hw/sensor/max11615.h
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#ifndef QEMU_MAX11615_H
+#define QEMU_MAX11615_H
+
+#include <stdint.h>
+#include "hw/i2c/i2c.h"
+
+#define TYPE_MAX11615 "max11615"
+
+/*
+ * Create and realize a MAX11615 ADC with constant caller-supplied readings
+ * @bus: I2C bus to put it on
+ * @address: I2C address
+ * @init_values: array of readings for each ADC channel
+ * @init_values_size: Size of @init_values, can be less than the number of channels
+ */
+I2CSlave *max11615_init_with_values(I2CBus *bus, uint8_t address,
+                                    const uint16_t *init_values, uint32_t init_values_size);
+
+#endif
-- 
2.54.0


