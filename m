Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F167EC83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 13:40:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaDuX-0005Kc-RL; Fri, 11 Jul 2025 09:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDtk-0004OY-5N
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:34:46 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDth-0002zg-W8
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:34:43 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a5257748e1so1612294f8f.2
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 06:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752240880; x=1752845680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uZm8K2Z4owBWHBWBi2KxHz/YZ075aCoUBIbwy/8Ca/4=;
 b=Aj4aVOWgVkg6p9LA90bQyzzjyPHe+rNPK9y1K2BmEZbjeK8WRc3OHlMxqmmlZ8n3Dd
 TuXNx7qhdep2/+Aw/mj8IwXZrk+zUcSPFWZBiAUTEZgdQvFXtEoA5Hwt636Vr+WJtrvf
 CqQ3xb2Gwwo72OSj/sV3RXcI4iDm7kCJOkzPNbfiQ1xoQETWx/oDPLykg8/RnkdfG8vy
 JIynA2wPop/M+TRjNBi82O33Iq1tPZqcnYrYwyx8naqE2dWF7SSjwBKnZxOtcOF0PPNY
 Z+aifpVBe4fCv1pNtoXJaRLazNLZ85QLmkzmactnD8Qna2pgR3qgIC1jicrVj9Y6bMun
 63lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752240880; x=1752845680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uZm8K2Z4owBWHBWBi2KxHz/YZ075aCoUBIbwy/8Ca/4=;
 b=dReppXxMKQjWOrBniA4fiUnS5gS7DM/vl1Utwqs3f1ZXSDC+iCtMRdR2pkasDSRuRU
 7+Qj8GoRTwr2Im+23g3Fm3llUPq9N2jo2ANnJZ9IULjkAZlY0hpbrgW1JDEHA8vkeDkV
 3Hsn8o9YiYHfU3/DlCcXwIIV9FRkyo7XX8/3t1Ru0gIpScf4FOefsTUOVGo/PVnhZKOW
 JcNaJrVz2XTgEHRj+Xpv8cT08RAdwnUWAHNYyYXTEJf0QxDZYOGpNVAh6YNtlsjIAOpo
 CdVlTa35r8mCDIgisL9O7OEPNXNR9l7QBXWIWIvNNZR19NCdXN9RJQBtKBQhh7aHLHnw
 tE4w==
X-Gm-Message-State: AOJu0YxY/99SQqtVc+IKKwZzPuYVnKa+sz/lfarUtZ2Jj4jz6hQ0gGdL
 5QPvFNenFF1XXvpI0RY7R5UgeQ6mePewuNgdHbFfOLtrvf6BeBhyXRs+t19pc2hcLb8eOMVvpjC
 gt8Dv
X-Gm-Gg: ASbGncvxzR4PW9Cf08cmmgk0hIuJUwF+f0E/PIvbo2CrmSIzpqF1IR70wvYEpbBoQIq
 TnRMuhLDzRx9Puw6QOEcCCDuySLqu8JciOyV2YsojLgBd3SOlQdRBsWdsUEapN8o6/icKNAeQwE
 4GVk5XMxaYAaFQkzbkwIs2jeEoorkaBDaDRzzRKLNfmNo7mtES2K7nSO3WG9HuftRxGrum2I823
 jqJYi7/AcDwhIb+ns/hh5a934Q+WrRinF/vNrO1R3zBxN43VlfOfA+mllyj6vh+V7KX7uikdXe2
 ygDea0WW8oUt95wpnCMYJ+vJ5Grk/wazXetSm0ZqRHQcNrj0d7dPh7DNNblNMb3M0tOzjvAPPbx
 OwoR3XzkpIUVf2V44Ws6OMQwvY85N
X-Google-Smtp-Source: AGHT+IFRFZCG14TkcZg5inTmtrH7JYPqcw9MeejGtBlISiQ+DwZ1Jw9cMh+meKHlC5geggIS8Eo6Qw==
X-Received: by 2002:a05:6000:2910:b0:3a6:d26a:f0f5 with SMTP id
 ffacd0b85a97d-3b5f2dc374emr2265403f8f.21.1752240879978; 
 Fri, 11 Jul 2025 06:34:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d50df0cdsm89734145e9.25.2025.07.11.06.34.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 06:34:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/36] MAX78000: TRNG Implementation
Date: Fri, 11 Jul 2025 14:34:01 +0100
Message-ID: <20250711133429.1423030-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711133429.1423030-1-peter.maydell@linaro.org>
References: <20250711133429.1423030-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

From: Jackson Donaldson <jackson88044@gmail.com>

This commit implements the True Random Number
Generator for the MAX78000

Signed-off-by: Jackson Donaldson <jcksn@duck.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20250704223239.248781-9-jcksn@duck.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/misc/max78000_gcr.h  |   1 +
 include/hw/misc/max78000_trng.h |  35 ++++++++
 hw/misc/max78000_gcr.c          |   6 ++
 hw/misc/max78000_trng.c         | 139 ++++++++++++++++++++++++++++++++
 hw/arm/Kconfig                  |   1 +
 hw/misc/Kconfig                 |   3 +
 hw/misc/meson.build             |   1 +
 7 files changed, 186 insertions(+)
 create mode 100644 include/hw/misc/max78000_trng.h
 create mode 100644 hw/misc/max78000_trng.c

diff --git a/include/hw/misc/max78000_gcr.h b/include/hw/misc/max78000_gcr.h
index f04c8a3ee7b..23ddf0885b9 100644
--- a/include/hw/misc/max78000_gcr.h
+++ b/include/hw/misc/max78000_gcr.h
@@ -123,6 +123,7 @@ struct Max78000GcrState {
     DeviceState *uart0;
     DeviceState *uart1;
     DeviceState *uart2;
+    DeviceState *trng;
 
 };
 
diff --git a/include/hw/misc/max78000_trng.h b/include/hw/misc/max78000_trng.h
new file mode 100644
index 00000000000..c5a8129b6a0
--- /dev/null
+++ b/include/hw/misc/max78000_trng.h
@@ -0,0 +1,35 @@
+/*
+ * MAX78000 True Random Number Generator
+ *
+ * Copyright (c) 2025 Jackson Donaldson <jcksn@duck.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef HW_MAX78000_TRNG_H
+#define HW_MAX78000_TRNG_H
+
+#include "hw/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_MAX78000_TRNG "max78000-trng"
+OBJECT_DECLARE_SIMPLE_TYPE(Max78000TrngState, MAX78000_TRNG)
+
+#define CTRL 0
+#define STATUS 4
+#define DATA 8
+
+#define RND_IE (1 << 1)
+
+struct Max78000TrngState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+
+    uint32_t ctrl;
+    uint32_t status;
+    uint32_t data;
+
+    qemu_irq irq;
+};
+
+#endif
diff --git a/hw/misc/max78000_gcr.c b/hw/misc/max78000_gcr.c
index 8c282f3916f..5916ee615a9 100644
--- a/hw/misc/max78000_gcr.c
+++ b/hw/misc/max78000_gcr.c
@@ -14,6 +14,7 @@
 #include "migration/vmstate.h"
 #include "hw/qdev-properties.h"
 #include "hw/char/max78000_uart.h"
+#include "hw/misc/max78000_trng.h"
 #include "hw/misc/max78000_gcr.h"
 
 
@@ -157,6 +158,9 @@ static void max78000_gcr_write(void *opaque, hwaddr addr,
         if (val & UART0_RESET) {
             device_cold_reset(s->uart0);
         }
+        if (val & TRNG_RESET) {
+            device_cold_reset(s->trng);
+        }
         /* TODO: As other devices are implemented, add them here */
         break;
 
@@ -257,6 +261,8 @@ static const Property max78000_gcr_properties[] = {
                      TYPE_MAX78000_UART, DeviceState*),
     DEFINE_PROP_LINK("uart2", Max78000GcrState, uart2,
                      TYPE_MAX78000_UART, DeviceState*),
+    DEFINE_PROP_LINK("trng", Max78000GcrState, trng,
+                        TYPE_MAX78000_TRNG, DeviceState*),
 };
 
 static const MemoryRegionOps max78000_gcr_ops = {
diff --git a/hw/misc/max78000_trng.c b/hw/misc/max78000_trng.c
new file mode 100644
index 00000000000..ecdaef53b6c
--- /dev/null
+++ b/hw/misc/max78000_trng.c
@@ -0,0 +1,139 @@
+/*
+ * MAX78000 True Random Number Generator
+ *
+ * Copyright (c) 2025 Jackson Donaldson <jcksn@duck.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "trace.h"
+#include "hw/irq.h"
+#include "migration/vmstate.h"
+#include "hw/misc/max78000_trng.h"
+#include "qemu/guest-random.h"
+
+static uint64_t max78000_trng_read(void *opaque, hwaddr addr,
+                                    unsigned int size)
+{
+    uint32_t data;
+
+    Max78000TrngState *s = opaque;
+    switch (addr) {
+    case CTRL:
+        return s->ctrl;
+
+    case STATUS:
+        return 1;
+
+    case DATA:
+        /*
+         * When interrupts are enabled, reading random data should cause a
+         * new interrupt to be generated; since there's always a random number
+         * available, we could qemu_set_irq(s->irq, s->ctrl & RND_IE). Because
+         * of how trng_write is set up, this is always a noop, so don't
+         */
+        qemu_guest_getrandom_nofail(&data, sizeof(data));
+        return data;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%"
+            HWADDR_PRIx "\n", __func__, addr);
+        break;
+    }
+    return 0;
+}
+
+static void max78000_trng_write(void *opaque, hwaddr addr,
+                    uint64_t val64, unsigned int size)
+{
+    Max78000TrngState *s = opaque;
+    uint32_t val = val64;
+    switch (addr) {
+    case CTRL:
+        /* TODO: implement AES keygen */
+        s->ctrl = val;
+
+        /*
+         * This device models random number generation as taking 0 time.
+         * A new random number is always available, so the condition for the
+         * RND interrupt is always fulfilled; we can just set irq to 1.
+         */
+        if (val & RND_IE) {
+            qemu_set_irq(s->irq, 1);
+        } else{
+            qemu_set_irq(s->irq, 0);
+        }
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%"
+            HWADDR_PRIx "\n", __func__, addr);
+        break;
+    }
+}
+
+static void max78000_trng_reset_hold(Object *obj, ResetType type)
+{
+    Max78000TrngState *s = MAX78000_TRNG(obj);
+    s->ctrl = 0;
+    s->status = 0;
+    s->data = 0;
+}
+
+static const MemoryRegionOps max78000_trng_ops = {
+    .read = max78000_trng_read,
+    .write = max78000_trng_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+};
+
+static const VMStateDescription max78000_trng_vmstate = {
+    .name = TYPE_MAX78000_TRNG,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(ctrl, Max78000TrngState),
+        VMSTATE_UINT32(status, Max78000TrngState),
+        VMSTATE_UINT32(data, Max78000TrngState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void max78000_trng_init(Object *obj)
+{
+    Max78000TrngState *s = MAX78000_TRNG(obj);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
+
+    memory_region_init_io(&s->mmio, obj, &max78000_trng_ops, s,
+                        TYPE_MAX78000_TRNG, 0x1000);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+
+}
+
+static void max78000_trng_class_init(ObjectClass *klass, const void *data)
+{
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    rc->phases.hold = max78000_trng_reset_hold;
+    dc->vmsd = &max78000_trng_vmstate;
+
+}
+
+static const TypeInfo max78000_trng_info = {
+    .name          = TYPE_MAX78000_TRNG,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(Max78000TrngState),
+    .instance_init = max78000_trng_init,
+    .class_init    = max78000_trng_class_init,
+};
+
+static void max78000_trng_register_types(void)
+{
+    type_register_static(&max78000_trng_info);
+}
+
+type_init(max78000_trng_register_types)
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index a96349ee118..c7aae4c9e76 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -369,6 +369,7 @@ config MAX78000_SOC
     select MAX78000_ICC
     select MAX78000_UART
     select MAX78000_GCR
+    select MAX78000_TRNG
 
 config RASPI
     bool
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index fde2266b8fc..dd6a6e54dad 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -53,6 +53,9 @@ config MAX78000_GCR
 config MAX78000_ICC
     bool
 
+config MAX78000_TRNG
+    bool
+
 config MOS6522
     bool
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 283d06dad4d..c7c57d924bf 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -72,6 +72,7 @@ system_ss.add(when: 'CONFIG_IMX', if_true: files(
 ))
 system_ss.add(when: 'CONFIG_MAX78000_GCR', if_true: files('max78000_gcr.c'))
 system_ss.add(when: 'CONFIG_MAX78000_ICC', if_true: files('max78000_icc.c'))
+system_ss.add(when: 'CONFIG_MAX78000_TRNG', if_true: files('max78000_trng.c'))
 system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files(
   'npcm_clk.c',
   'npcm_gcr.c',
-- 
2.43.0


