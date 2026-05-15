Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C83CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 15:08:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNu7n-000372-DK; Fri, 15 May 2026 11:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.hansen@9elements.com>)
 id 1wNu7V-0002zL-64
 for qemu-devel@nongnu.org; Fri, 15 May 2026 11:06:35 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.hansen@9elements.com>)
 id 1wNu7R-0006LZ-RL
 for qemu-devel@nongnu.org; Fri, 15 May 2026 11:06:32 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48e6db3ff7eso40829285e9.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 08:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1778857588; x=1779462388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6lDjrDU3Q/KdKDylQl0w2uoCBsU0aoWVJyspqQ2WgDE=;
 b=Og4KBy0cRyrxY0A8w/0hqSbxGLg3BBRsqSOm+32tNn8Vm2OMVFoyuDJhpOgx4h11Ca
 pxHwXHiTl/0BtP/f6ulrx1bG5DfVzYqEScOr4FFq/g1Fn+lzcGPSkvsc9u2oPrefIqmT
 3+zsJo9Qa4br+exyB/jv6p1K09EhBEYWJxhtoy1p6vVW86VwdS/heXHSe8WbNRn1IYP+
 ogQ5RBzGlTYnpp+YCcdzyn7hVzneLfFqcmluWGTiWsXR2mewhugGmf10RGB9AGro6FpV
 RgLUSIoflb2M+1Rqb2XLEx/8AepXDhrM2+FGaqXkrWNzqJNRTWi4X4DQJ9aZ3mw+OZ8E
 XFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778857588; x=1779462388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6lDjrDU3Q/KdKDylQl0w2uoCBsU0aoWVJyspqQ2WgDE=;
 b=EchuLPC+A+bUePno6wL2tAqpME866ivKq5jS6C1iBW/qAVtRULrplwdQ7C2vTGQHUn
 pvD0Cx/ldX3bdQYIDRUid5VZss9n9yCg82xrY75nEuFDx4JlJzdL8CmaEyd09dXjvhWo
 ns0eRexs3tJgowXnaqEaLB6HTkEIBPfCqnSLgubiFvGKk/38LQfWQks8if3TLH6SEnw/
 SALN06JWSMAVEaR7gkjQwhAE3+PgZCRrZchABFpasz4EaFOgxSnu8FGy6nHjUwAhDcOW
 2QXAYs79rJCwuokA0eucbY2DVwdho22GJVg8/BPTDorrs1qyOqe7RtMRmqt/IXXJqtxE
 u3KQ==
X-Gm-Message-State: AOJu0YybkW1x6kSD+kuGESf1sWoap2718YpVgzJlKTHL3xIJVlONs7lo
 XWNGQYGVuheUcKlg6o9DBDP4gWXdfM0yTO6AQ0BNOHJ2J7eTVvihEyrfPIP2J4IMU9pwcV3oACi
 ODXQqSiw=
X-Gm-Gg: Acq92OGzHq3am42vpullpAMpVTThWbe2y1JRklXVzARwe1KThAko1p1b3I5oijfOKaa
 tTcF109oPr5/s59f4R2aSLVPsssTJd1EusGareY8NWp5K6CE1qMiSKz2GG4IOF28ImCKRIX8sK5
 1OJryNU6ybsAFgarFVgxrZwTlHwq2dDirhUqvgciVQJjTQhxT27F3a/x9RfGMmHpuoXAPaP0VHi
 5FQe7JEiywnvp0kF/xC3WjD0DKWh7SOLwOjgWQfMP5GCHavPEH61lJOm1MmX/NDqv5d6L/o9oGm
 fZDXL/AVKf+bjaw1GDtO9JHqHCCEYvtUujAzGEWGlkiPHun4w7SlJJmyAStDAGzF+TpYi/XmF2f
 GsVcSwsu5DeWjfzH2N9QkzwlXaeQaoNGyA8fJdUVWVeeAPq4kJzThFqIaJ4b6GPP+vDoUanwDhg
 m8ey+cN2orWO1dz60GGY/x1z5Zet8mZA2WxhA0SZiNjcvKZKnGBC4CcsM=
X-Received: by 2002:a05:600c:3b0f:b0:48f:e230:72fb with SMTP id
 5b1f17b1804b1-48fe6631512mr60346105e9.32.1778857588083; 
 Fri, 15 May 2026 08:06:28 -0700 (PDT)
Received: from alexanderarchlinux ([188.111.3.154])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feab290e1sm29444715e9.2.2026.05.15.08.06.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 08:06:27 -0700 (PDT)
From: Alexander Hansen <alexander.hansen@9elements.com>
To: qemu-devel@nongnu.org
Cc: Alexander Hansen <alexander.hansen@9elements.com>,
 Titus Rwantare <titusr@google.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
Subject: [PATCH v4 3/5] hw/sensor: MAX31790 support
Date: Fri, 15 May 2026 16:58:00 +0200
Message-ID: <20260515150610.381066-4-alexander.hansen@9elements.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515150610.381066-1-alexander.hansen@9elements.com>
References: <20260515150610.381066-1-alexander.hansen@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alexander.hansen@9elements.com; helo=mail-wm1-x331.google.com
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

MAX31790 Support:
- fan inputs are reading
- tach reading propertional to pwm setting from linux driver
- fans do not show any fault
- 6 PWM registers influence 6 TACH registers

There is intentional stub behavior in some places and various functions
of the device are currently unsupported.

MAX31790 currently unsupported:
- slave address restriction
- fan dynamics
- spin-up configuration
- fault state / failure possibility
- rate-of-change control
- tach mode
- mixed layouts where number of fans != number of tachs
- see Figure 5.9 in [2] for example of mixed layout

Anyone could expand it in the future for more accurate emulation.

The reason for adding this device is to support Yosemite V4 emulation.

Tested: on yosemite 4 qemu

root@yosemite4:~# ls /sys/class/hwmon/hwmon2/
device	    fan2_fault   fan3_target  fan5_fault   fan6_target  pwm2	     pwm5
fan1_enable  fan2_input   fan4_enable  fan5_input   name	pwm2_enable  pwm5_enable
fan1_fault   fan2_target  fan4_fault   fan5_target  of_node	pwm3	     pwm6
fan1_input   fan3_enable  fan4_input   fan6_enable  power	pwm3_enable  pwm6_enable
fan1_target  fan3_fault   fan4_target  fan6_fault   pwm1	pwm4	     subsystem
fan2_enable  fan3_input   fan5_enable  fan6_input   pwm1_enable  pwm4_enable  uevent
root@yosemite4:~# cat /sys/class/hwmon/hwmon2/fan1_input
4551
root@yosemite4:~# cat /sys/class/hwmon/hwmon2/fan1_enable
1
root@yosemite4:~# cat /sys/class/hwmon/hwmon2/fan1_fault
0
root@yosemite4:~# cat /sys/class/hwmon/hwmon2/fan1_target
2048
root@yosemite4:~# cat /sys/class/hwmon/hwmon2/pwm1
178
root@yosemite4:~# cat /sys/class/hwmon/hwmon2/name
max31790

Trace output:
max31790_realize i2c_addr: 0x20
max31790_realize i2c_addr: 0x2f
max31790_realize i2c_addr: 0x20
max31790_realize i2c_addr: 0x2f
max31790_event i2c_addr: 0x20, event: 0x01
max31790_send i2c_addr: 0x20, data: 0x02
max31790_event i2c_addr: 0x20, event: 0x00
max31790_recv i2c_addr: 0x20, reg_addr: 0x02
max31790_recv_return i2c_addr: 0x20, returns: 0x08
...

References:
[1] https://www.analog.com/en/products/MAX31790.html
[2] https://www.analog.com/media/en/technical-documentation/data-sheets/MAX31790.pdf

Cc: Titus Rwantare <titusr@google.com>
Cc: "Cédric Le Goater" <clg@kaod.org> (maintainer:ASPEED BMCs)
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org>
Cc: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org
Signed-off-by: Alexander Hansen <alexander.hansen@9elements.com>
---
 MAINTAINERS                              |   1 +
 hw/arm/aspeed_ast2600_fby4.c             |   4 +-
 hw/sensor/max31790.c                     | 501 +++++++++++++++++++++++
 hw/arm/Kconfig                           |   1 +
 hw/sensor/Kconfig                        |   4 +
 hw/sensor/meson.build                    |   1 +
 hw/sensor/trace-events                   |   8 +
 tests/functional/arm/test_aspeed_fby4.py |  18 +
 8 files changed, 536 insertions(+), 2 deletions(-)
 create mode 100644 hw/sensor/max31790.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 80d28e618d..dc0cdb4089 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3986,6 +3986,7 @@ S: Maintained
 F: hw/i2c/pmbus_device.c
 F: hw/sensor/adm1272.c
 F: hw/sensor/isl_pmbus_vr.c
+F: hw/sensor/max31790.c
 F: hw/sensor/max34451.c
 F: include/hw/i2c/pmbus_device.h
 F: include/hw/sensor/isl_pmbus_vr.h
diff --git a/hw/arm/aspeed_ast2600_fby4.c b/hw/arm/aspeed_ast2600_fby4.c
index 89fb0ac2fd..1f391022a2 100644
--- a/hw/arm/aspeed_ast2600_fby4.c
+++ b/hw/arm/aspeed_ast2600_fby4.c
@@ -164,7 +164,7 @@ static void fby4_i2c_init_fanboard(I2CSlave *fan_mux, size_t eepromSize)
         /* TODO */
 
         /* maxim,max31790 @ 0x20   (pwm) */
-        /* TODO */
+        i2c_slave_create_simple(bus, "max31790", 0x20);
 
         /*
          * ti,tca6424 @ 0x22       (gpio)
@@ -182,7 +182,7 @@ static void fby4_i2c_init_fanboard(I2CSlave *fan_mux, size_t eepromSize)
          */
 
         /* maxim,max31790 @ 0x2f   (pwm) */
-        /* TODO */
+        i2c_slave_create_simple(bus, "max31790", 0x2f);
 
         /* maxim,max11615 @ 0x33   (adc) */
         /* TODO */
diff --git a/hw/sensor/max31790.c b/hw/sensor/max31790.c
new file mode 100644
index 0000000000..30bab2e74e
--- /dev/null
+++ b/hw/sensor/max31790.c
@@ -0,0 +1,501 @@
+/*
+ * Maxim MAX31790 PMBus 6-Channel Fan Controller
+ *
+ * Datasheet:
+ * https://www.analog.com/media/en/technical-documentation/data-sheets/MAX31790.pdf
+ *
+ * Copyright 2026 9elements
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/i2c/i2c.h"
+#include "qapi/error.h"
+#include "qapi/visitor.h"
+#include "migration/vmstate.h"
+#include "qemu/module.h"
+#include "qom/object.h"
+#include "trace.h"
+
+#define TYPE_MAX31790 "max31790"
+
+#define MAX31790_NUM_FANS 6
+#define MAX31790_NUM_TACHS 12
+
+#define MAX31790_REG_GLOBAL_CONFIG 0x00
+#define MAX31790_REG_PWM_FREQ 0x01
+
+/* 0x02 to 0x07: N = 0 .. 5 */
+#define MAX31790_REG_FAN_CONFIG(N) (0x02 + N)
+
+/* 0x08 to 0x0d: N = 0 .. 5 */
+#define MAX31790_REG_FAN_DYNAMICS(N) (0x08 + N)
+
+#define MAX31790_REG_FAN_FAULT_STATUS_2 0x10
+#define MAX31790_REG_FAN_FAULT_STATUS_1 0x11
+#define MAX31790_REG_FAN_FAULT_MASK_2 0x12
+#define MAX31790_REG_FAN_FAULT_MASK_1 0x13
+#define MAX31790_REG_FAILED_FAN_OPT 0x14
+
+/* 0x18 to 0x2f: N = 0 .. 11 */
+#define MAX31790_REG_TACH_COUNT_MSB(N) (0x18 + 2 * N)
+#define MAX31790_REG_TACH_COUNT_LSB(N) (0x19 + 2 * N)
+
+/* 0x30 to 0x3b: N = 0 .. 5 */
+#define MAX31790_REG_PWM_DUTY_CYCLE_MSB(N) (0x30 + 2 * N)
+#define MAX31790_REG_PWM_DUTY_CYCLE_LSB(N) (0x31 + 2 * N)
+
+/* .. reserved registers ... */
+
+/* 0x40 to 0x4b: N = 0 .. 5 */
+#define MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(N) (0x40 + 2 * N)
+#define MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(N) (0x41 + 2 * N)
+
+/* ... 'User Byte' registers ... */
+
+/* 0x50 to 0x5b: N = 0 .. 5 */
+#define MAX31790_REG_TACH_TARGET_COUNT_MSB(N) (0x50 + 2 * N)
+#define MAX31790_REG_TACH_TARGET_COUNT_LSB(N) (0x51 + 2 * N)
+
+struct MAX31790State {
+    I2CSlave i2c;
+
+    uint8_t fan_config[MAX31790_NUM_FANS];
+    uint8_t fan_dynamics[MAX31790_NUM_FANS];
+
+    uint16_t pwm[MAX31790_NUM_FANS];
+    uint16_t tach_target[MAX31790_NUM_FANS];
+    uint16_t rpm[MAX31790_NUM_TACHS];
+
+    /* command buffer */
+    uint8_t len;
+    uint8_t buf[2];
+
+    /* output buffer */
+    uint8_t outlen;
+    uint8_t outbuf[2];
+
+    /* selected register for read/write operation */
+    uint8_t pointer;
+};
+
+struct MAX31790Class {
+    I2CSlaveClass parent_class;
+};
+
+OBJECT_DECLARE_TYPE(MAX31790State, MAX31790Class, MAX31790)
+
+static void max31790_read(MAX31790State *s)
+{
+    size_t index = 0;
+    uint8_t out0 = 0;
+    uint8_t out1 = 0;
+
+    switch (s->pointer) {
+    case MAX31790_REG_FAN_CONFIG(0):
+    case MAX31790_REG_FAN_CONFIG(1):
+    case MAX31790_REG_FAN_CONFIG(2):
+    case MAX31790_REG_FAN_CONFIG(3):
+    case MAX31790_REG_FAN_CONFIG(4):
+    case MAX31790_REG_FAN_CONFIG(5):
+        out0 = s->fan_config[s->pointer - MAX31790_REG_FAN_CONFIG(0)];
+        break;
+    case MAX31790_REG_FAN_DYNAMICS(0):
+    case MAX31790_REG_FAN_DYNAMICS(1):
+    case MAX31790_REG_FAN_DYNAMICS(2):
+    case MAX31790_REG_FAN_DYNAMICS(3):
+    case MAX31790_REG_FAN_DYNAMICS(4):
+    case MAX31790_REG_FAN_DYNAMICS(5):
+        out0 = s->fan_dynamics[s->pointer - MAX31790_REG_FAN_DYNAMICS(0)];
+        break;
+    case MAX31790_REG_FAN_FAULT_STATUS_1:
+    case MAX31790_REG_FAN_FAULT_STATUS_2:
+        /* we do not have any fan fault */
+        out0 = 0x00;
+        out1 = 0x00;
+        break;
+    case MAX31790_REG_TACH_COUNT_MSB(0):
+    case MAX31790_REG_TACH_COUNT_MSB(1):
+    case MAX31790_REG_TACH_COUNT_MSB(2):
+    case MAX31790_REG_TACH_COUNT_MSB(3):
+    case MAX31790_REG_TACH_COUNT_MSB(4):
+    case MAX31790_REG_TACH_COUNT_MSB(5):
+    case MAX31790_REG_TACH_COUNT_MSB(6):
+    case MAX31790_REG_TACH_COUNT_MSB(7):
+    case MAX31790_REG_TACH_COUNT_MSB(8):
+    case MAX31790_REG_TACH_COUNT_MSB(9):
+    case MAX31790_REG_TACH_COUNT_MSB(10):
+    case MAX31790_REG_TACH_COUNT_MSB(11):
+        index = (s->pointer - MAX31790_REG_TACH_COUNT_MSB(0)) / 2;
+        out0 = (s->rpm[index] >> 8) & 0xff;
+        out1 = s->rpm[index] & 0xff;
+        break;
+
+    case MAX31790_REG_TACH_COUNT_LSB(0):
+    case MAX31790_REG_TACH_COUNT_LSB(1):
+    case MAX31790_REG_TACH_COUNT_LSB(2):
+    case MAX31790_REG_TACH_COUNT_LSB(3):
+    case MAX31790_REG_TACH_COUNT_LSB(4):
+    case MAX31790_REG_TACH_COUNT_LSB(5):
+    case MAX31790_REG_TACH_COUNT_LSB(6):
+    case MAX31790_REG_TACH_COUNT_LSB(7):
+    case MAX31790_REG_TACH_COUNT_LSB(8):
+    case MAX31790_REG_TACH_COUNT_LSB(9):
+    case MAX31790_REG_TACH_COUNT_LSB(10):
+    case MAX31790_REG_TACH_COUNT_LSB(11):
+        index = (s->pointer - MAX31790_REG_TACH_COUNT_LSB(0)) / 2;
+        out0 = s->rpm[index] & 0xff;
+        break;
+
+    case MAX31790_REG_PWM_DUTY_CYCLE_MSB(0):
+    case MAX31790_REG_PWM_DUTY_CYCLE_MSB(1):
+    case MAX31790_REG_PWM_DUTY_CYCLE_MSB(2):
+    case MAX31790_REG_PWM_DUTY_CYCLE_MSB(3):
+    case MAX31790_REG_PWM_DUTY_CYCLE_MSB(4):
+    case MAX31790_REG_PWM_DUTY_CYCLE_MSB(5):
+        index = (s->pointer - MAX31790_REG_PWM_DUTY_CYCLE_MSB(0)) / 2;
+        out0 = (s->pwm[index] >> 8) & 0xff;
+        out1 = s->pwm[index] & 0xff;
+        break;
+    case MAX31790_REG_PWM_DUTY_CYCLE_LSB(0):
+    case MAX31790_REG_PWM_DUTY_CYCLE_LSB(1):
+    case MAX31790_REG_PWM_DUTY_CYCLE_LSB(2):
+    case MAX31790_REG_PWM_DUTY_CYCLE_LSB(3):
+    case MAX31790_REG_PWM_DUTY_CYCLE_LSB(4):
+    case MAX31790_REG_PWM_DUTY_CYCLE_LSB(5):
+        index = (s->pointer - MAX31790_REG_PWM_DUTY_CYCLE_LSB(0)) / 2;
+        out0 = s->pwm[index] & 0xff;
+        break;
+
+    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(0):
+    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(1):
+    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(2):
+    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(3):
+    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(4):
+    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(5):
+        index = (s->pointer - MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(0)) / 2;
+        out0 = (s->pwm[index] >> 8) & 0xff;
+        out1 = s->pwm[index] & 0xff;
+        break;
+    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(0):
+    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(1):
+    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(2):
+    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(3):
+    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(4):
+    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(5):
+        index = (s->pointer - MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(0)) / 2;
+        out0 = s->pwm[index] & 0xff;
+        break;
+    case MAX31790_REG_TACH_TARGET_COUNT_MSB(0):
+    case MAX31790_REG_TACH_TARGET_COUNT_MSB(1):
+    case MAX31790_REG_TACH_TARGET_COUNT_MSB(2):
+    case MAX31790_REG_TACH_TARGET_COUNT_MSB(3):
+    case MAX31790_REG_TACH_TARGET_COUNT_MSB(4):
+    case MAX31790_REG_TACH_TARGET_COUNT_MSB(5):
+        index = (s->pointer - MAX31790_REG_TACH_TARGET_COUNT_MSB(0)) / 2;
+        out0 = (s->tach_target[index] >> 8) & 0xff;
+        out1 = s->tach_target[index] & 0xff;
+        break;
+    case MAX31790_REG_TACH_TARGET_COUNT_LSB(0):
+    case MAX31790_REG_TACH_TARGET_COUNT_LSB(1):
+    case MAX31790_REG_TACH_TARGET_COUNT_LSB(2):
+    case MAX31790_REG_TACH_TARGET_COUNT_LSB(3):
+    case MAX31790_REG_TACH_TARGET_COUNT_LSB(4):
+    case MAX31790_REG_TACH_TARGET_COUNT_LSB(5):
+        index = (s->pointer - MAX31790_REG_TACH_TARGET_COUNT_LSB(0)) / 2;
+        out0 = s->tach_target[index] & 0xff;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: read of register %d", __func__,
+                      s->pointer);
+        break;
+    }
+
+    s->outbuf[0] = out0;
+    s->outbuf[1] = out1;
+}
+
+static void max31790_set_rpm(MAX31790State *s, size_t index, uint16_t rpm)
+{
+    /* datasheet: lowest 5 bits are 0 */
+    s->rpm[index] = rpm & ~0b11111;
+}
+
+static void max31790_pwm_write(MAX31790State *s, size_t index, uint16_t value)
+{
+    trace_max31790_pwm_write(s->i2c.address, index, value);
+
+    s->pwm[index] = value;
+
+    /* change rpm based on pwm input */
+    const uint16_t pwm_no_reserve = s->pwm[index] >> 7;
+
+    /*
+     * This formula has magic values which model the relationship
+     * of PWM input to a fan. Not derived from datasheet.
+     */
+    max31790_set_rpm(s, index, 0x1000 + (pwm_no_reserve << 3));
+}
+
+static void max31790_write_2_byte(MAX31790State *s)
+{
+    size_t index = 0;
+    const uint8_t value0 = s->buf[0];
+    const uint8_t value1 = s->buf[1];
+
+    switch (s->pointer) {
+    case MAX31790_REG_FAN_CONFIG(0):
+    case MAX31790_REG_FAN_CONFIG(1):
+    case MAX31790_REG_FAN_CONFIG(2):
+    case MAX31790_REG_FAN_CONFIG(3):
+    case MAX31790_REG_FAN_CONFIG(4):
+    case MAX31790_REG_FAN_CONFIG(5):
+        break; /* handled by one byte write */
+    case MAX31790_REG_FAN_DYNAMICS(0):
+    case MAX31790_REG_FAN_DYNAMICS(1):
+    case MAX31790_REG_FAN_DYNAMICS(2):
+    case MAX31790_REG_FAN_DYNAMICS(3):
+    case MAX31790_REG_FAN_DYNAMICS(4):
+    case MAX31790_REG_FAN_DYNAMICS(5):
+        break; /* handled by one byte write */
+    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(0):
+    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(1):
+    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(2):
+    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(3):
+    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(4):
+    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(5):
+        index = (s->pointer - MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(0)) / 2;
+        max31790_pwm_write(s, index, value0 << 8 | value1);
+        break;
+    case MAX31790_REG_TACH_TARGET_COUNT_MSB(0):
+    case MAX31790_REG_TACH_TARGET_COUNT_MSB(1):
+    case MAX31790_REG_TACH_TARGET_COUNT_MSB(2):
+    case MAX31790_REG_TACH_TARGET_COUNT_MSB(3):
+    case MAX31790_REG_TACH_TARGET_COUNT_MSB(4):
+    case MAX31790_REG_TACH_TARGET_COUNT_MSB(5):
+        index = (s->pointer - MAX31790_REG_TACH_TARGET_COUNT_MSB(0)) / 2;
+        s->tach_target[index] = (value0 << 8) | value1;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: write to register %d", __func__,
+                      s->pointer);
+        break;
+    }
+}
+
+static void max31790_write_1_byte(MAX31790State *s)
+{
+
+    size_t index = 0;
+    uint16_t pwm = 0;
+    const uint8_t value = s->buf[0];
+    switch (s->pointer) {
+    case MAX31790_REG_FAN_CONFIG(0):
+    case MAX31790_REG_FAN_CONFIG(1):
+    case MAX31790_REG_FAN_CONFIG(2):
+    case MAX31790_REG_FAN_CONFIG(3):
+    case MAX31790_REG_FAN_CONFIG(4):
+    case MAX31790_REG_FAN_CONFIG(5):
+        s->fan_config[s->pointer - MAX31790_REG_FAN_CONFIG(0)] = value;
+        break;
+    case MAX31790_REG_FAN_DYNAMICS(0):
+    case MAX31790_REG_FAN_DYNAMICS(1):
+    case MAX31790_REG_FAN_DYNAMICS(2):
+    case MAX31790_REG_FAN_DYNAMICS(3):
+    case MAX31790_REG_FAN_DYNAMICS(4):
+    case MAX31790_REG_FAN_DYNAMICS(5):
+        s->fan_dynamics[s->pointer - MAX31790_REG_FAN_DYNAMICS(0)] = value;
+        break;
+    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(0):
+    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(1):
+    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(2):
+    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(3):
+    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(4):
+    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(5):
+        index = (s->pointer - MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(0)) / 2;
+        pwm = (value << 8) | (s->pwm[index] & 0x00ff);
+        max31790_pwm_write(s, index, pwm);
+        break;
+    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(0):
+    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(1):
+    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(2):
+    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(3):
+    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(4):
+    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(5):
+        index = (s->pointer - MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(0)) / 2;
+        pwm = (s->pwm[index] & 0xff00) | (value & 0x00ff);
+        max31790_pwm_write(s, index, pwm);
+        break;
+    case MAX31790_REG_TACH_TARGET_COUNT_MSB(0):
+    case MAX31790_REG_TACH_TARGET_COUNT_MSB(1):
+    case MAX31790_REG_TACH_TARGET_COUNT_MSB(2):
+    case MAX31790_REG_TACH_TARGET_COUNT_MSB(3):
+    case MAX31790_REG_TACH_TARGET_COUNT_MSB(4):
+    case MAX31790_REG_TACH_TARGET_COUNT_MSB(5):
+        index = (s->pointer - MAX31790_REG_TACH_TARGET_COUNT_MSB(0)) / 2;
+        s->tach_target[index] = (s->tach_target[index] & 0x00ff) | (value << 8);
+        break;
+    case MAX31790_REG_TACH_TARGET_COUNT_LSB(0):
+    case MAX31790_REG_TACH_TARGET_COUNT_LSB(1):
+    case MAX31790_REG_TACH_TARGET_COUNT_LSB(2):
+    case MAX31790_REG_TACH_TARGET_COUNT_LSB(3):
+    case MAX31790_REG_TACH_TARGET_COUNT_LSB(4):
+    case MAX31790_REG_TACH_TARGET_COUNT_LSB(5):
+        index = (s->pointer - MAX31790_REG_TACH_TARGET_COUNT_LSB(0)) / 2;
+        s->tach_target[index] = (s->tach_target[index] & 0xff00) | value;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: write to register %d", __func__,
+                      s->pointer);
+        break;
+    }
+}
+
+static int max31790_send(I2CSlave *i2c, uint8_t data)
+{
+    MAX31790State *s = MAX31790(i2c);
+
+    trace_max31790_send(s->i2c.address, data);
+
+    if (s->len == 0) {
+        /* first byte is the register pointer for a read / write operation */
+        s->pointer = data;
+        s->len++;
+        return 0;
+    }
+
+    if (s->len > 2) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: write too many bytes", __func__);
+        return 1; /* NAK */
+    }
+
+    /* second / third byte is the data to write */
+    s->buf[s->len - 1] = data;
+    s->len++;
+
+    if (s->len == 2) {
+        max31790_write_1_byte(s);
+    } else if (s->len == 3) {
+        max31790_write_2_byte(s);
+    }
+
+    return 0;
+}
+
+static uint8_t max31790_recv(I2CSlave *i2c)
+{
+    MAX31790State *s = MAX31790(i2c);
+    trace_max31790_recv(s->i2c.address, s->pointer);
+
+    max31790_read(s);
+    s->len = 0;
+
+    if (s->outlen >= 2) {
+        /* error */
+        s->outlen = 0;
+    }
+
+    const uint8_t data = s->outbuf[s->outlen++];
+
+    trace_max31790_recv_return(s->i2c.address, data);
+    return data;
+}
+
+static int max31790_event(I2CSlave *i2c, enum i2c_event event)
+{
+    MAX31790State *s = MAX31790(i2c);
+
+    trace_max31790_event(s->i2c.address, event);
+
+    switch (event) {
+    case I2C_START_RECV:
+        s->outlen = 0;
+        break;
+    case I2C_START_SEND:
+        s->len = 0;
+        break;
+    default:
+        break;
+    }
+
+    return 0;
+}
+
+static const VMStateDescription vmstate_max31790 = {
+    .name = TYPE_MAX31790,
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields =
+        (const VMStateField[]){
+            VMSTATE_UINT8(len, MAX31790State),
+            VMSTATE_UINT8_ARRAY(fan_config, MAX31790State, MAX31790_NUM_FANS),
+            VMSTATE_UINT8_ARRAY(fan_dynamics, MAX31790State, MAX31790_NUM_FANS),
+            VMSTATE_UINT16_ARRAY(pwm, MAX31790State, MAX31790_NUM_FANS),
+            VMSTATE_UINT16_ARRAY(tach_target, MAX31790State, MAX31790_NUM_FANS),
+            VMSTATE_UINT16_ARRAY(rpm, MAX31790State, MAX31790_NUM_TACHS),
+            VMSTATE_UINT8_ARRAY(buf, MAX31790State, 2),
+            VMSTATE_UINT8(outlen, MAX31790State),
+            VMSTATE_UINT8_ARRAY(outbuf, MAX31790State, 2),
+            VMSTATE_UINT8(pointer, MAX31790State),
+            VMSTATE_I2C_SLAVE(i2c, MAX31790State), VMSTATE_END_OF_LIST() }
+};
+
+static void max31790_reset(DeviceState *dev)
+{
+    MAX31790State *s = MAX31790(dev);
+
+    for (int i = 0; i < MAX31790_NUM_FANS; i++) {
+        /* POR-State 0b 0XX0 0000 */
+        s->fan_config[i] = 0b00000000;
+
+        /* same as POR-State */
+        s->tach_target[i] = 0b0011110000000000;
+
+        /* same as POR-State */
+        s->fan_dynamics[i] = 0b01001100;
+
+        s->pwm[i] = 0;
+    }
+
+    for (int i = 0; i < MAX31790_NUM_TACHS; i++) {
+        max31790_set_rpm(s, i, 0x4444);
+    }
+}
+
+static void max31790_realize(DeviceState *dev, Error **errp)
+{
+    MAX31790State *s = MAX31790(dev);
+
+    trace_max31790_realize(s->i2c.address);
+}
+
+static void max31790_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
+
+    dc->realize = max31790_realize;
+    dc->desc = "Maxim MAX31790 6-Channel Fan Controller";
+    dc->vmsd = &vmstate_max31790;
+    dc->legacy_reset = max31790_reset;
+    k->event = max31790_event;
+    k->recv = max31790_recv;
+    k->send = max31790_send;
+}
+
+static const TypeInfo max31790_info = {
+    .name = TYPE_MAX31790,
+    .parent = TYPE_I2C_SLAVE,
+    .instance_size = sizeof(MAX31790State),
+    .class_size = sizeof(MAX31790Class),
+    .class_init = max31790_class_init,
+};
+
+static void max31790_register_types(void)
+{
+    type_register_static(&max31790_info);
+}
+
+type_init(max31790_register_types)
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 5b198402d5..99864eb878 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -552,6 +552,7 @@ config ASPEED_SOC
     select LED
     select PMBUS
     select MAX31785
+    select MAX31790
     select FSI_APB2OPB_ASPEED
     select AT24C
     select PCI_EXPRESS
diff --git a/hw/sensor/Kconfig b/hw/sensor/Kconfig
index bc6331b4ab..ece2f2b167 100644
--- a/hw/sensor/Kconfig
+++ b/hw/sensor/Kconfig
@@ -43,3 +43,7 @@ config ISL_PMBUS_VR
 config MAX31785
     bool
     depends on PMBUS
+
+config MAX31790
+    bool
+    depends on PMBUS
diff --git a/hw/sensor/meson.build b/hw/sensor/meson.build
index 420fdc3359..4987c3b253 100644
--- a/hw/sensor/meson.build
+++ b/hw/sensor/meson.build
@@ -8,3 +8,4 @@ system_ss.add(when: 'CONFIG_MAX34451', if_true: files('max34451.c'))
 system_ss.add(when: 'CONFIG_LSM303DLHC_MAG', if_true: files('lsm303dlhc_mag.c'))
 system_ss.add(when: 'CONFIG_ISL_PMBUS_VR', if_true: files('isl_pmbus_vr.c'))
 system_ss.add(when: 'CONFIG_MAX31785', if_true: files('max31785.c'))
+system_ss.add(when: 'CONFIG_MAX31790', if_true: files('max31790.c'))
diff --git a/hw/sensor/trace-events b/hw/sensor/trace-events
index a3fe54fa6d..c15c0a7e93 100644
--- a/hw/sensor/trace-events
+++ b/hw/sensor/trace-events
@@ -4,3 +4,11 @@
 tmp105_read(uint8_t dev, uint8_t addr) "device: 0x%02x, addr: 0x%02x"
 tmp105_write(uint8_t dev, uint8_t addr) "device: 0x%02x, addr 0x%02x"
 tmp105_write_shutdown(uint8_t dev) "device: 0x%02x"
+
+# max31790.c
+max31790_send(uint8_t i2c_addr, uint8_t send) "i2c_addr: 0x%02x, data: 0x%02x"
+max31790_recv(uint8_t i2c_addr, uint8_t reg_addr) "i2c_addr: 0x%02x, reg_addr: 0x%02x"
+max31790_recv_return(uint8_t i2c_addr, uint8_t data) "i2c_addr: 0x%02x, returns: 0x%02x"
+max31790_event(uint8_t i2c_addr, uint8_t event) "i2c_addr: 0x%02x, event: 0x%02x"
+max31790_realize(uint8_t i2c_addr) "i2c_addr: 0x%02x"
+max31790_pwm_write(uint8_t i2c_addr, size_t index, uint16_t value) "i2c_addr: 0x%02x, index: %zu, value: 0x%04x"
diff --git a/tests/functional/arm/test_aspeed_fby4.py b/tests/functional/arm/test_aspeed_fby4.py
index a3124c240f..d29423add7 100755
--- a/tests/functional/arm/test_aspeed_fby4.py
+++ b/tests/functional/arm/test_aspeed_fby4.py
@@ -7,6 +7,8 @@
 from qemu_test import Asset
 from aspeed import AspeedTest
 
+from qemu_test import wait_for_console_pattern, exec_command
+from qemu_test import exec_command_and_wait_for_pattern
 
 class YosemiteV4Machine(AspeedTest):
 
@@ -33,6 +35,22 @@ def do_test_arm_aspeed_openbmc_no_network(self, machine, image, uboot,
         # different from the other machines.
         self.wait_for_console_pattern('yosemite4 login:')
 
+        # perform login
+        exec_command_and_wait_for_pattern(self,
+                                          "root", "Password:");
+
+        exec_command_and_wait_for_pattern(self, "0penBmc", "#");
+
+        # MAX31790 test
+        exec_command_and_wait_for_pattern(self,
+            "cat /sys/class/hwmon/hwmon2/name", "max31790");
+        exec_command_and_wait_for_pattern(self,
+            "cat /sys/class/hwmon/hwmon2/fan1_input", "4530");
+        exec_command_and_wait_for_pattern(self,
+            "cat /sys/class/hwmon/hwmon2/fan1_enable", "1");
+        exec_command_and_wait_for_pattern(self,
+            "cat /sys/class/hwmon/hwmon2/fan1_fault", "0");
+
     def test_arm_ast2600_yosemitev4_openbmc(self):
         image_path = self.uncompress(self.ASSET_YOSEMITE_V4_FLASH)
 
-- 
2.54.0


