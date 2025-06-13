Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CDA8C7114C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 00:04:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPruB-0005nl-LH; Thu, 12 Jun 2025 20:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3AGtLaAcKCk0z3103sxv33v0t.r315t19-stAt0232v29.36v@flex--komlodi.bounces.google.com>)
 id 1uPru9-0005md-Ja
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 20:04:21 -0400
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3AGtLaAcKCk0z3103sxv33v0t.r315t19-stAt0232v29.36v@flex--komlodi.bounces.google.com>)
 id 1uPru6-0000Wu-ND
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 20:04:21 -0400
Received: by mail-pf1-x44a.google.com with SMTP id
 d2e1a72fcca58-747d394f45fso1343906b3a.2
 for <qemu-devel@nongnu.org>; Thu, 12 Jun 2025 17:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1749773057; x=1750377857; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=rlKLlPaZ/qjCDaZme7JPe4na4UPbi/S79jkvjPexJpU=;
 b=jFKhybts4p+lkAyt/hRlc52F/fo6eUdw+Yfpk324NH3XHAPNHOQLR3RXCswtj56eDN
 /GMGNJk4eHS0gr/U2+/IQ/DvA5K4ka84x0Y+dUQQ2IgaMOGOd4PsNlBaBIdTr/whBBNq
 QKcW/hyzo59/uzOPRELca/owYw2KL99ddM0HDmfvgUUIyr9TUj6IcGs1pXtazORX+b4V
 zxnpLn7WInNn4j4bk7seF6SYBDCJumLSB1jg33KgbVsrMVeuBLRIQ+lwp1Y80+vUvdlQ
 d2gKBsVrEzYYOCnEfpBglWzxakyYcqmBRRCag7Sd1c49fubfHz+fzONnifqZ7Sa0/pFu
 yJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749773057; x=1750377857;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rlKLlPaZ/qjCDaZme7JPe4na4UPbi/S79jkvjPexJpU=;
 b=YoUJvVOEG3dF2jN7BHXaJOo96X0omNmruNBcSi1VCzWpT3aOSLvZdJOw3rKT+MH7MV
 gqZuH/tsr3AuocybR6cg8WMj4WK+SVrQONkc0z+NjFiXWN6VWgGIUA0Khsiphw13zIlO
 kK1135jojLwTnOTWlY6rjvU8eOHIMNFtztW698BNq0napip4ieeFWsWkVto8u9kukyww
 KXXoddopWSD/HgHWmCyWYNnYh/Bty6cLkUytV4O7MXVan8EeyBXcn7VRNVaQ9ikKdbtn
 arjoOpgVuJ/OEfTGNnKDUUavFfP1nKwPyAlU/U4wyfmw9M+qK3E9tALomBJY8Fcl9DKU
 WJ+g==
X-Gm-Message-State: AOJu0Ywdl3ZfqIZjCwWmDmW140kYlASgBcvKxHl08n4/RRJ/Q209nENy
 c0kBgmdQzS97u1cIzK319k3l/IqWr8F+5LCek0ksSo82A503sAFdH3MRlhZ9hsDYkJ9vE5uYl+b
 DkkQVsrUA4kFqIbyparWS2IQc83OL8WSFTFREBNB8QEXOeOq8/CqGKKtth8WbWNWNXRbDQT/7ON
 3S01Urz8QbxSPhUjVClIBPuov5n96pXRIuX7yr24r+
X-Google-Smtp-Source: AGHT+IG6akEqGlNM8qsP7MZTZas9c60HPxg5e6upy7QQEHMJbGLhCImjYT8+m30GdpsgxYtDz8rNbPPE8oHp
X-Received: from pgbfy9.prod.google.com ([2002:a05:6a02:2a89:b0:b2c:374b:9e48])
 (user=komlodi job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:700d:b0:1f5:769a:a4be
 with SMTP id adf61e73a8af0-21fad0bb9b6mr1359209637.36.1749773056758; Thu, 12
 Jun 2025 17:04:16 -0700 (PDT)
Date: Fri, 13 Jun 2025 00:03:55 +0000
In-Reply-To: <20250613000411.1516521-1-komlodi@google.com>
Mime-Version: 1.0
References: <20250613000411.1516521-1-komlodi@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250613000411.1516521-4-komlodi@google.com>
Subject: [PATCH 03/19] hw/i3c: Split DesignWare I3C out of Aspeed I3C
From: Joe Komlodi <komlodi@google.com>
To: qemu-devel@nongnu.org
Cc: venture@google.com, komlodi@google.com, clg@kaod.org, 
 peter.maydell@linaro.org, steven_lee@aspeedtech.com, leetroy@gmail.com, 
 jamin_lin@aspeedtech.com, andrew@codeconstruct.com.au, joel@jms.id.au, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::44a;
 envelope-from=3AGtLaAcKCk0z3103sxv33v0t.r315t19-stAt0232v29.36v@flex--komlodi.bounces.google.com;
 helo=mail-pf1-x44a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

The Aspeed I3C IP block is technically an Aspeed IP block that manages
6 DW I3C controllers.

To help reflect this better and to make it easier for other SoCs to use
the DW I3C model, we'll split out the DW portion from the Aspeed
portion.

Signed-off-by: Joe Komlodi <komlodi@google.com>
---
 hw/arm/Kconfig              |   1 +
 hw/i3c/Kconfig              |   3 +
 hw/i3c/aspeed_i3c.c         | 183 +-------------------------------
 hw/i3c/dw-i3c.c             | 204 ++++++++++++++++++++++++++++++++++++
 hw/i3c/meson.build          |   1 +
 hw/i3c/trace-events         |   6 +-
 include/hw/i3c/aspeed_i3c.h |  19 +---
 include/hw/i3c/dw-i3c.h     |  35 +++++++
 8 files changed, 254 insertions(+), 198 deletions(-)
 create mode 100644 hw/i3c/dw-i3c.c
 create mode 100644 include/hw/i3c/dw-i3c.h

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 427d0f0271..53d62cd08d 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -531,6 +531,7 @@ config ASPEED_SOC
     select FTGMAC100
     select I2C
     select I3C
+    select DW_I3C
     select DPS310
     select PCA9552
     select SERIAL_MM
diff --git a/hw/i3c/Kconfig b/hw/i3c/Kconfig
index e07fe445c6..ecec77d6fc 100644
--- a/hw/i3c/Kconfig
+++ b/hw/i3c/Kconfig
@@ -1,2 +1,5 @@
 config I3C
     bool
+
+config DW_I3C
+    bool
diff --git a/hw/i3c/aspeed_i3c.c b/hw/i3c/aspeed_i3c.c
index e56822f928..cb0332828c 100644
--- a/hw/i3c/aspeed_i3c.c
+++ b/hw/i3c/aspeed_i3c.c
@@ -2,6 +2,7 @@
  * ASPEED I3C Controller
  *
  * Copyright (C) 2021 ASPEED Technology Inc.
+ * Copyright (C) 2025 Google, LLC.
  *
  * This code is licensed under the GPL version 2 or later.  See
  * the COPYING file in the top-level directory.
@@ -43,162 +44,6 @@ REG32(I3C6_REG1, 0x64)
     FIELD(I3C6_REG1, I2C_MODE,  0,  1)
     FIELD(I3C6_REG1, SA_EN,     15, 1)
 
-/* I3C Device Registers */
-REG32(DEVICE_CTRL,                  0x00)
-REG32(DEVICE_ADDR,                  0x04)
-REG32(HW_CAPABILITY,                0x08)
-REG32(COMMAND_QUEUE_PORT,           0x0c)
-REG32(RESPONSE_QUEUE_PORT,          0x10)
-REG32(RX_TX_DATA_PORT,              0x14)
-REG32(IBI_QUEUE_STATUS,             0x18)
-REG32(IBI_QUEUE_DATA,               0x18)
-REG32(QUEUE_THLD_CTRL,              0x1c)
-REG32(DATA_BUFFER_THLD_CTRL,        0x20)
-REG32(IBI_QUEUE_CTRL,               0x24)
-REG32(IBI_MR_REQ_REJECT,            0x2c)
-REG32(IBI_SIR_REQ_REJECT,           0x30)
-REG32(RESET_CTRL,                   0x34)
-REG32(SLV_EVENT_CTRL,               0x38)
-REG32(INTR_STATUS,                  0x3c)
-REG32(INTR_STATUS_EN,               0x40)
-REG32(INTR_SIGNAL_EN,               0x44)
-REG32(INTR_FORCE,                   0x48)
-REG32(QUEUE_STATUS_LEVEL,           0x4c)
-REG32(DATA_BUFFER_STATUS_LEVEL,     0x50)
-REG32(PRESENT_STATE,                0x54)
-REG32(CCC_DEVICE_STATUS,            0x58)
-REG32(DEVICE_ADDR_TABLE_POINTER,    0x5c)
-    FIELD(DEVICE_ADDR_TABLE_POINTER, DEPTH, 16, 16)
-    FIELD(DEVICE_ADDR_TABLE_POINTER, ADDR,  0,  16)
-REG32(DEV_CHAR_TABLE_POINTER,       0x60)
-REG32(VENDOR_SPECIFIC_REG_POINTER,  0x6c)
-REG32(SLV_MIPI_PID_VALUE,           0x70)
-REG32(SLV_PID_VALUE,                0x74)
-REG32(SLV_CHAR_CTRL,                0x78)
-REG32(SLV_MAX_LEN,                  0x7c)
-REG32(MAX_READ_TURNAROUND,          0x80)
-REG32(MAX_DATA_SPEED,               0x84)
-REG32(SLV_DEBUG_STATUS,             0x88)
-REG32(SLV_INTR_REQ,                 0x8c)
-REG32(DEVICE_CTRL_EXTENDED,         0xb0)
-REG32(SCL_I3C_OD_TIMING,            0xb4)
-REG32(SCL_I3C_PP_TIMING,            0xb8)
-REG32(SCL_I2C_FM_TIMING,            0xbc)
-REG32(SCL_I2C_FMP_TIMING,           0xc0)
-REG32(SCL_EXT_LCNT_TIMING,          0xc8)
-REG32(SCL_EXT_TERMN_LCNT_TIMING,    0xcc)
-REG32(BUS_FREE_TIMING,              0xd4)
-REG32(BUS_IDLE_TIMING,              0xd8)
-REG32(I3C_VER_ID,                   0xe0)
-REG32(I3C_VER_TYPE,                 0xe4)
-REG32(EXTENDED_CAPABILITY,          0xe8)
-REG32(SLAVE_CONFIG,                 0xec)
-
-static const uint32_t ast2600_i3c_device_resets[ASPEED_I3C_DEVICE_NR_REGS] = {
-    [R_HW_CAPABILITY]               = 0x000e00bf,
-    [R_QUEUE_THLD_CTRL]             = 0x01000101,
-    [R_I3C_VER_ID]                  = 0x3130302a,
-    [R_I3C_VER_TYPE]                = 0x6c633033,
-    [R_DEVICE_ADDR_TABLE_POINTER]   = 0x00080280,
-    [R_DEV_CHAR_TABLE_POINTER]      = 0x00020200,
-    [A_VENDOR_SPECIFIC_REG_POINTER] = 0x000000b0,
-    [R_SLV_MAX_LEN]                 = 0x00ff00ff,
-};
-
-static uint64_t aspeed_i3c_device_read(void *opaque, hwaddr offset,
-                                       unsigned size)
-{
-    AspeedI3CDevice *s = ASPEED_I3C_DEVICE(opaque);
-    uint32_t addr = offset >> 2;
-    uint64_t value;
-
-    switch (addr) {
-    case R_COMMAND_QUEUE_PORT:
-        value = 0;
-        break;
-    default:
-        value = s->regs[addr];
-        break;
-    }
-
-    trace_aspeed_i3c_device_read(s->id, offset, value);
-
-    return value;
-}
-
-static void aspeed_i3c_device_write(void *opaque, hwaddr offset,
-                                    uint64_t value, unsigned size)
-{
-    AspeedI3CDevice *s = ASPEED_I3C_DEVICE(opaque);
-    uint32_t addr = offset >> 2;
-
-    trace_aspeed_i3c_device_write(s->id, offset, value);
-
-    switch (addr) {
-    case R_HW_CAPABILITY:
-    case R_RESPONSE_QUEUE_PORT:
-    case R_IBI_QUEUE_DATA:
-    case R_QUEUE_STATUS_LEVEL:
-    case R_PRESENT_STATE:
-    case R_CCC_DEVICE_STATUS:
-    case R_DEVICE_ADDR_TABLE_POINTER:
-    case R_VENDOR_SPECIFIC_REG_POINTER:
-    case R_SLV_CHAR_CTRL:
-    case R_SLV_MAX_LEN:
-    case R_MAX_READ_TURNAROUND:
-    case R_I3C_VER_ID:
-    case R_I3C_VER_TYPE:
-    case R_EXTENDED_CAPABILITY:
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: write to readonly register[0x%02" HWADDR_PRIx
-                      "] = 0x%08" PRIx64 "\n",
-                      __func__, offset, value);
-        break;
-    case R_RX_TX_DATA_PORT:
-        break;
-    case R_RESET_CTRL:
-        break;
-    default:
-        s->regs[addr] = value;
-        break;
-    }
-}
-
-static const VMStateDescription aspeed_i3c_device_vmstate = {
-    .name = TYPE_ASPEED_I3C,
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .fields = (const VMStateField[]){
-        VMSTATE_UINT32_ARRAY(regs, AspeedI3CDevice, ASPEED_I3C_DEVICE_NR_REGS),
-        VMSTATE_END_OF_LIST(),
-    }
-};
-
-static const MemoryRegionOps aspeed_i3c_device_ops = {
-    .read = aspeed_i3c_device_read,
-    .write = aspeed_i3c_device_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
-};
-
-static void aspeed_i3c_device_reset(DeviceState *dev)
-{
-    AspeedI3CDevice *s = ASPEED_I3C_DEVICE(dev);
-
-    memcpy(s->regs, ast2600_i3c_device_resets, sizeof(s->regs));
-}
-
-static void aspeed_i3c_device_realize(DeviceState *dev, Error **errp)
-{
-    AspeedI3CDevice *s = ASPEED_I3C_DEVICE(dev);
-    g_autofree char *name = g_strdup_printf(TYPE_ASPEED_I3C_DEVICE ".%d",
-                                            s->id);
-
-    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
-
-    memory_region_init_io(&s->mr, OBJECT(s), &aspeed_i3c_device_ops,
-                          s, name, ASPEED_I3C_DEVICE_NR_REGS << 2);
-}
-
 static uint64_t aspeed_i3c_read(void *opaque, hwaddr addr, unsigned int size)
 {
     AspeedI3CState *s = ASPEED_I3C(opaque);
@@ -275,7 +120,7 @@ static void aspeed_i3c_instance_init(Object *obj)
 
     for (i = 0; i < ASPEED_I3C_NR_DEVICES; ++i) {
         object_initialize_child(obj, "device[*]", &s->devices[i],
-                TYPE_ASPEED_I3C_DEVICE);
+                TYPE_DW_I3C);
     }
 }
 
@@ -323,27 +168,6 @@ static void aspeed_i3c_realize(DeviceState *dev, Error **errp)
 
 }
 
-static const Property aspeed_i3c_device_properties[] = {
-    DEFINE_PROP_UINT8("device-id", AspeedI3CDevice, id, 0),
-};
-
-static void aspeed_i3c_device_class_init(ObjectClass *klass, const void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    dc->desc = "Aspeed I3C Device";
-    dc->realize = aspeed_i3c_device_realize;
-    device_class_set_legacy_reset(dc, aspeed_i3c_device_reset);
-    device_class_set_props(dc, aspeed_i3c_device_properties);
-}
-
-static const TypeInfo aspeed_i3c_device_info = {
-    .name = TYPE_ASPEED_I3C_DEVICE,
-    .parent = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(AspeedI3CDevice),
-    .class_init = aspeed_i3c_device_class_init,
-};
-
 static const VMStateDescription vmstate_aspeed_i3c = {
     .name = TYPE_ASPEED_I3C,
     .version_id = 1,
@@ -351,7 +175,7 @@ static const VMStateDescription vmstate_aspeed_i3c = {
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, AspeedI3CState, ASPEED_I3C_NR_REGS),
         VMSTATE_STRUCT_ARRAY(devices, AspeedI3CState, ASPEED_I3C_NR_DEVICES, 1,
-                             aspeed_i3c_device_vmstate, AspeedI3CDevice),
+                             vmstate_dw_i3c, DWI3C),
         VMSTATE_END_OF_LIST(),
     }
 };
@@ -376,7 +200,6 @@ static const TypeInfo aspeed_i3c_info = {
 
 static void aspeed_i3c_register_types(void)
 {
-    type_register_static(&aspeed_i3c_device_info);
     type_register_static(&aspeed_i3c_info);
 }
 
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c
new file mode 100644
index 0000000000..4b1a3f3f07
--- /dev/null
+++ b/hw/i3c/dw-i3c.c
@@ -0,0 +1,204 @@
+/*
+ * DesignWare I3C Controller
+ *
+ * Copyright (C) 2021 ASPEED Technology Inc.
+ * Copyright (C) 2025 Google, LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/error-report.h"
+#include "hw/i3c/i3c.h"
+#include "hw/i3c/dw-i3c.h"
+#include "hw/registerfields.h"
+#include "hw/qdev-properties.h"
+#include "qapi/error.h"
+#include "migration/vmstate.h"
+#include "trace.h"
+
+REG32(DEVICE_CTRL,                  0x00)
+REG32(DEVICE_ADDR,                  0x04)
+REG32(HW_CAPABILITY,                0x08)
+REG32(COMMAND_QUEUE_PORT,           0x0c)
+REG32(RESPONSE_QUEUE_PORT,          0x10)
+REG32(RX_TX_DATA_PORT,              0x14)
+REG32(IBI_QUEUE_STATUS,             0x18)
+REG32(IBI_QUEUE_DATA,               0x18)
+REG32(QUEUE_THLD_CTRL,              0x1c)
+REG32(DATA_BUFFER_THLD_CTRL,        0x20)
+REG32(IBI_QUEUE_CTRL,               0x24)
+REG32(IBI_MR_REQ_REJECT,            0x2c)
+REG32(IBI_SIR_REQ_REJECT,           0x30)
+REG32(RESET_CTRL,                   0x34)
+REG32(SLV_EVENT_CTRL,               0x38)
+REG32(INTR_STATUS,                  0x3c)
+REG32(INTR_STATUS_EN,               0x40)
+REG32(INTR_SIGNAL_EN,               0x44)
+REG32(INTR_FORCE,                   0x48)
+REG32(QUEUE_STATUS_LEVEL,           0x4c)
+REG32(DATA_BUFFER_STATUS_LEVEL,     0x50)
+REG32(PRESENT_STATE,                0x54)
+REG32(CCC_DEVICE_STATUS,            0x58)
+REG32(DEVICE_ADDR_TABLE_POINTER,    0x5c)
+    FIELD(DEVICE_ADDR_TABLE_POINTER, DEPTH, 16, 16)
+    FIELD(DEVICE_ADDR_TABLE_POINTER, ADDR,  0,  16)
+REG32(DEV_CHAR_TABLE_POINTER,       0x60)
+REG32(VENDOR_SPECIFIC_REG_POINTER,  0x6c)
+REG32(SLV_MIPI_PID_VALUE,           0x70)
+REG32(SLV_PID_VALUE,                0x74)
+REG32(SLV_CHAR_CTRL,                0x78)
+REG32(SLV_MAX_LEN,                  0x7c)
+REG32(MAX_READ_TURNAROUND,          0x80)
+REG32(MAX_DATA_SPEED,               0x84)
+REG32(SLV_DEBUG_STATUS,             0x88)
+REG32(SLV_INTR_REQ,                 0x8c)
+REG32(DEVICE_CTRL_EXTENDED,         0xb0)
+REG32(SCL_I3C_OD_TIMING,            0xb4)
+REG32(SCL_I3C_PP_TIMING,            0xb8)
+REG32(SCL_I2C_FM_TIMING,            0xbc)
+REG32(SCL_I2C_FMP_TIMING,           0xc0)
+REG32(SCL_EXT_LCNT_TIMING,          0xc8)
+REG32(SCL_EXT_TERMN_LCNT_TIMING,    0xcc)
+REG32(BUS_FREE_TIMING,              0xd4)
+REG32(BUS_IDLE_TIMING,              0xd8)
+REG32(I3C_VER_ID,                   0xe0)
+REG32(I3C_VER_TYPE,                 0xe4)
+REG32(EXTENDED_CAPABILITY,          0xe8)
+REG32(SLAVE_CONFIG,                 0xec)
+
+static const uint32_t dw_i3c_resets[DW_I3C_NR_REGS] = {
+    [R_HW_CAPABILITY]               = 0x000e00bf,
+    [R_QUEUE_THLD_CTRL]             = 0x01000101,
+    [R_I3C_VER_ID]                  = 0x3130302a,
+    [R_I3C_VER_TYPE]                = 0x6c633033,
+    [R_DEVICE_ADDR_TABLE_POINTER]   = 0x00080280,
+    [R_DEV_CHAR_TABLE_POINTER]      = 0x00020200,
+    [A_VENDOR_SPECIFIC_REG_POINTER] = 0x000000b0,
+    [R_SLV_MAX_LEN]                 = 0x00ff00ff,
+};
+
+static uint64_t dw_i3c_read(void *opaque, hwaddr offset, unsigned size)
+{
+    DWI3C *s = DW_I3C(opaque);
+    uint32_t addr = offset >> 2;
+    uint64_t value;
+
+    switch (addr) {
+    case R_COMMAND_QUEUE_PORT:
+        value = 0;
+        break;
+    default:
+        value = s->regs[addr];
+        break;
+    }
+
+    trace_dw_i3c_read(s->id, offset, value);
+
+    return value;
+}
+
+static void dw_i3c_write(void *opaque, hwaddr offset, uint64_t value,
+                         unsigned size)
+{
+    DWI3C *s = DW_I3C(opaque);
+    uint32_t addr = offset >> 2;
+
+    trace_dw_i3c_write(s->id, offset, value);
+
+    switch (addr) {
+    case R_HW_CAPABILITY:
+    case R_RESPONSE_QUEUE_PORT:
+    case R_IBI_QUEUE_DATA:
+    case R_QUEUE_STATUS_LEVEL:
+    case R_PRESENT_STATE:
+    case R_CCC_DEVICE_STATUS:
+    case R_DEVICE_ADDR_TABLE_POINTER:
+    case R_VENDOR_SPECIFIC_REG_POINTER:
+    case R_SLV_CHAR_CTRL:
+    case R_SLV_MAX_LEN:
+    case R_MAX_READ_TURNAROUND:
+    case R_I3C_VER_ID:
+    case R_I3C_VER_TYPE:
+    case R_EXTENDED_CAPABILITY:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: write to readonly register[0x%02" HWADDR_PRIx
+                      "] = 0x%08" PRIx64 "\n",
+                      __func__, offset, value);
+        break;
+    case R_RX_TX_DATA_PORT:
+        break;
+    case R_RESET_CTRL:
+        break;
+    default:
+        s->regs[addr] = value;
+        break;
+    }
+}
+
+const VMStateDescription vmstate_dw_i3c = {
+    .name = TYPE_DW_I3C,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]){
+        VMSTATE_UINT32_ARRAY(regs, DWI3C, DW_I3C_NR_REGS),
+        VMSTATE_END_OF_LIST(),
+    }
+};
+
+static const MemoryRegionOps dw_i3c_ops = {
+    .read = dw_i3c_read,
+    .write = dw_i3c_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void dw_i3c_reset_enter(Object *obj, ResetType type)
+{
+    DWI3C *s = DW_I3C(obj);
+
+    memcpy(s->regs, dw_i3c_resets, sizeof(s->regs));
+}
+
+static void dw_i3c_realize(DeviceState *dev, Error **errp)
+{
+    DWI3C *s = DW_I3C(dev);
+    g_autofree char *name = g_strdup_printf(TYPE_DW_I3C ".%d", s->id);
+
+    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
+
+    memory_region_init_io(&s->mr, OBJECT(s), &dw_i3c_ops, s, name,
+                          DW_I3C_NR_REGS << 2);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mr);
+}
+
+static const Property dw_i3c_properties[] = {
+    DEFINE_PROP_UINT8("device-id", DWI3C, id, 0),
+};
+
+static void dw_i3c_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    rc->phases.enter = dw_i3c_reset_enter;
+
+    dc->desc = "DesignWare I3C Controller";
+    dc->realize = dw_i3c_realize;
+    dc->vmsd = &vmstate_dw_i3c;
+    device_class_set_props(dc, dw_i3c_properties);
+}
+
+static const TypeInfo dw_i3c_info = {
+    .name = TYPE_DW_I3C,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(DWI3C),
+    .class_init = dw_i3c_class_init,
+};
+
+static void dw_i3c_register_types(void)
+{
+    type_register_static(&dw_i3c_info);
+}
+
+type_init(dw_i3c_register_types);
diff --git a/hw/i3c/meson.build b/hw/i3c/meson.build
index fb127613fe..83d75e7d5c 100644
--- a/hw/i3c/meson.build
+++ b/hw/i3c/meson.build
@@ -1,4 +1,5 @@
 i3c_ss = ss.source_set()
 i3c_ss.add(when: 'CONFIG_I3C', if_true: files('core.c'))
 i3c_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_i3c.c'))
+i3c_ss.add(when: 'CONFIG_DW_I3C', if_true: files('dw-i3c.c'))
 system_ss.add_all(when: 'CONFIG_I3C', if_true: i3c_ss)
diff --git a/hw/i3c/trace-events b/hw/i3c/trace-events
index cdf7cb07f6..2d944387db 100644
--- a/hw/i3c/trace-events
+++ b/hw/i3c/trace-events
@@ -3,8 +3,10 @@
 # aspeed_i3c.c
 aspeed_i3c_read(uint64_t offset, uint64_t data) "I3C read: offset 0x%" PRIx64 " data 0x%" PRIx64
 aspeed_i3c_write(uint64_t offset, uint64_t data) "I3C write: offset 0x%" PRIx64 " data 0x%" PRIx64
-aspeed_i3c_device_read(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%u] read: offset 0x%" PRIx64 " data 0x%" PRIx64
-aspeed_i3c_device_write(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%u] write: offset 0x%" PRIx64 " data 0x%" PRIx64
+
+# dw-i3c,c
+dw_i3c_read(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%u] read: offset 0x%" PRIx64 " data 0x%" PRIx64
+dw_i3c_write(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%u] write: offset 0x%" PRIx64 " data 0x%" PRIx64
 
 # core.c
 i3c_target_event(uint8_t address, uint8_t event) "I3C target 0x%" PRIx8 " event 0x%" PRIx8
diff --git a/include/hw/i3c/aspeed_i3c.h b/include/hw/i3c/aspeed_i3c.h
index 39679dfa1a..793ee111cb 100644
--- a/include/hw/i3c/aspeed_i3c.h
+++ b/include/hw/i3c/aspeed_i3c.h
@@ -10,29 +10,15 @@
 #ifndef ASPEED_I3C_H
 #define ASPEED_I3C_H
 
+#include "hw/i3c/dw-i3c.h"
 #include "hw/sysbus.h"
 
 #define TYPE_ASPEED_I3C "aspeed.i3c"
-#define TYPE_ASPEED_I3C_DEVICE "aspeed.i3c.device"
 OBJECT_DECLARE_TYPE(AspeedI3CState, AspeedI3CClass, ASPEED_I3C)
 
 #define ASPEED_I3C_NR_REGS (0x70 >> 2)
-#define ASPEED_I3C_DEVICE_NR_REGS (0x300 >> 2)
 #define ASPEED_I3C_NR_DEVICES 6
 
-OBJECT_DECLARE_SIMPLE_TYPE(AspeedI3CDevice, ASPEED_I3C_DEVICE)
-typedef struct AspeedI3CDevice {
-    /* <private> */
-    SysBusDevice parent;
-
-    /* <public> */
-    MemoryRegion mr;
-    qemu_irq irq;
-
-    uint8_t id;
-    uint32_t regs[ASPEED_I3C_DEVICE_NR_REGS];
-} AspeedI3CDevice;
-
 typedef struct AspeedI3CState {
     /* <private> */
     SysBusDevice parent;
@@ -43,6 +29,7 @@ typedef struct AspeedI3CState {
     qemu_irq irq;
 
     uint32_t regs[ASPEED_I3C_NR_REGS];
-    AspeedI3CDevice devices[ASPEED_I3C_NR_DEVICES];
+    DWI3C devices[ASPEED_I3C_NR_DEVICES];
+    uint8_t id;
 } AspeedI3CState;
 #endif /* ASPEED_I3C_H */
diff --git a/include/hw/i3c/dw-i3c.h b/include/hw/i3c/dw-i3c.h
new file mode 100644
index 0000000000..214f5ffed2
--- /dev/null
+++ b/include/hw/i3c/dw-i3c.h
@@ -0,0 +1,35 @@
+/*
+ * DesignWare I3C Controller
+ *
+ * Copyright (C) 2021 ASPEED Technology Inc.
+ * Copyright (C) 2025 Google, LLC.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef DW_I3C_H
+#define DW_I3C_H
+
+#include "hw/sysbus.h"
+
+#define TYPE_DW_I3C "dw.i3c"
+OBJECT_DECLARE_SIMPLE_TYPE(DWI3C, DW_I3C)
+
+#define DW_I3C_NR_REGS (0x300 >> 2)
+
+typedef struct DWI3C {
+    /* <private> */
+    SysBusDevice parent;
+
+    /* <public> */
+    MemoryRegion mr;
+    qemu_irq irq;
+
+    uint8_t id;
+    uint32_t regs[DW_I3C_NR_REGS];
+} DWI3C;
+
+/* Extern for other controllers that use DesignWare I3C. */
+extern const VMStateDescription vmstate_dw_i3c;
+
+#endif /* DW_I3C_H */
-- 
2.50.0.rc1.591.g9c95f17f64-goog


