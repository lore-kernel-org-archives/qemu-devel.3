Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 242A1C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 00:02:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubT6S-0002Bk-0B; Mon, 14 Jul 2025 20:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1ubT6P-0001zJ-3G
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 20:00:57 -0400
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1ubT6N-00086h-1k
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 20:00:56 -0400
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6fafb6899c2so46273356d6.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 17:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752537654; x=1753142454; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RNTuphuGm9p7ud6YPEAB9vvpfF4veBp+TzIvzkfoEsQ=;
 b=KTfKwSpuusB4+dTvHvyPGqG7CFlRo95OK1kKpzaxS/r41Oi/XsQgJ2rLfBDtWXnuXF
 0ULMfGljR1yDdg1dJKuF8Zkc2cOGcz1dig3wxYqlh1E5kIBwwOoBUEOGromxVA1wzTsQ
 f59+7HP+npbk6Pjne02tFn3qaBVJlMr7XTbymLOIgn8JxYhq6ZrSSRDzvW8nQ0S+eYfg
 JON0Hr8wcHQfX4upiQcrZ0v3o+AVp8C/G+R63oSyWnccivUcGmoWfKz/B1FnBLuVHjZs
 iiv8t13qdPopb1kxNgeld7Lgo1A31ymzyvJ7MNZ67jQfmgFrq5/F0KEJ0rHfhD/qeSok
 cg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752537654; x=1753142454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RNTuphuGm9p7ud6YPEAB9vvpfF4veBp+TzIvzkfoEsQ=;
 b=R2xI9ym1UPXpTWCqzsmvs/URx0HZ1FZGWic7A7EFujE7yWJxzG1OodPHqvq+7mo0EZ
 cHxmqvCWyRKCKj/4MvmuXb4v0YyC9MLqDegWSLrkkGz2CQd8ZGTNesuzi972/a1QphBY
 gQ6m/2RFk65QotStZ9X0s9HtfV+g+RlgQ9J6ALi50n7dk0EfJ53f2LetsGjvn9ojlNa+
 nPylqhF2RJytkdd+D2nXrWMM6obCOla0LRDdxmMS8Pe6HwrSFVcF2tnX8axXj7a62/Ta
 Apw8usCsl9KB24SKbd0xFD15Ol5OgJvVir0Y2McEtv+DPNIewCDfvDuHkigFAZYqoeQa
 Lg0g==
X-Gm-Message-State: AOJu0YxKhVRolpAZReajfHUR4oPrxS94LxklodlsrzmwjED8KVPtca4Y
 zjiDPLDJjLn8z91WcsdBt4tCMU9GxHeDV7tKLx/pKXq35TaMA22tqMISJdGnyg==
X-Gm-Gg: ASbGnct7vM0s/2FNQQMqWvHIFXd0QXlJF+DNQgpwWiQz7DOt2SpQzAdcR17r13ybyL5
 WYq8I+KTB7IOEigpTO7Eensavt2zfchfRyeyRQHKi/V2jP3TMPgC1KyLTb8NVaeNQn7OwLDV3fE
 47o5BNA7cPQeg34mVbeTWeMFKufvRSNmtfSlflMbbnWz1vmfF9ygsbnWLbIcLT50L3iHfUZl0sn
 NnKTVSiJ1bA8bTqpDk/dK/PfaLjJGOD4BZJGsQ/2Nu1jJCo3xiIDNR9jWBo8V7jb7a/XRIt+bok
 V1zTDCilXGT6TQyg8GF+EIUrEbKGurHvO5Is8iA6YzhDeqktMw8fLMHg2PEq7dlga4pvLgBdzzy
 EDI654Z+IfoQusSlDLK/dRv0N0xth2ley1wt2Y5ZqXnXYAUk=
X-Google-Smtp-Source: AGHT+IHDm9WPF/3jZ39fopr4wm2PmQMtNK8fm/VKekIj/rqTBwwgShS3ofiu4K+dnvjBNmMbpMCisg==
X-Received: by 2002:a05:6214:601b:b0:702:c3af:2f44 with SMTP id
 6a1803df08f44-704e1e5e034mr20183136d6.20.1752537653278; 
 Mon, 14 Jul 2025 17:00:53 -0700 (PDT)
Received: from user-jcksn.mynetworksettings.com
 ([2600:4040:b51a:4200:2f17:e99b:e0cd:fdf7])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70497d8eee2sm52296276d6.97.2025.07.14.17.00.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 17:00:52 -0700 (PDT)
From: Jackson Donaldson <jackson88044@gmail.com>
X-Google-Original-From: Jackson Donaldson <jcksn@duck.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v5 08/11] MAX78000: TRNG Implementation
Date: Mon, 14 Jul 2025 20:00:42 -0400
Message-Id: <20250715000045.57332-9-jcksn@duck.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715000045.57332-1-jcksn@duck.com>
References: <20250715000045.57332-1-jcksn@duck.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2e;
 envelope-from=jackson88044@gmail.com; helo=mail-qv1-xf2e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This commit implements the True Random Number
Generator for the MAX78000

Signed-off-by: Jackson Donaldson <jcksn@duck.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/Kconfig                  |   1 +
 hw/misc/Kconfig                 |   3 +
 hw/misc/max78000_gcr.c          |   6 ++
 hw/misc/max78000_trng.c         | 139 ++++++++++++++++++++++++++++++++
 hw/misc/meson.build             |   1 +
 include/hw/misc/max78000_gcr.h  |   1 +
 include/hw/misc/max78000_trng.h |  35 ++++++++
 7 files changed, 186 insertions(+)
 create mode 100644 hw/misc/max78000_trng.c
 create mode 100644 include/hw/misc/max78000_trng.h

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 41bb64458f..fcac62be6f 100644
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
index fde2266b8f..dd6a6e54da 100644
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
 
diff --git a/hw/misc/max78000_gcr.c b/hw/misc/max78000_gcr.c
index 8c282f3916..5916ee615a 100644
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
index 0000000000..ecdaef53b6
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
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 283d06dad4..c7c57d924b 100644
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
diff --git a/include/hw/misc/max78000_gcr.h b/include/hw/misc/max78000_gcr.h
index f04c8a3ee7..23ddf0885b 100644
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
index 0000000000..c5a8129b6a
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
-- 
2.34.1


