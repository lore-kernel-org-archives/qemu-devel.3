Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B9BC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 22:34:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXoxu-0001jo-1G; Fri, 04 Jul 2025 18:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uXoxi-0001gE-Kq
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 18:32:58 -0400
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uXoxd-0007Bt-6o
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 18:32:53 -0400
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-4a58c2430edso16466901cf.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 15:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751668367; x=1752273167; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RNTuphuGm9p7ud6YPEAB9vvpfF4veBp+TzIvzkfoEsQ=;
 b=F0ABcvYrTvShJLrF5AKHmfKEb2gBXO4QM7w/TAxZ24yf/902YGQ6UiaA+gpxhsvmKr
 Rvll+M2ONwe6ZDY+cIV2vPBJs2XBe9fk5KejgqWZSgktSBCnaGSphZHM7vqHQ5P93yLn
 GprdQttB4pPaQyIJ+kIXFtpRqGsaVEjW5xWp4+c3FhmqTaQfixXv3FXqaHhx1hXTlFwN
 Dbu406KR9BvUA/Ek50jP0r7fQ2t9dYwO07MZtwlaY7tVVEXhfSOsHq7b2uns27L6cGPG
 F3ErxARUt898svUEpwkANzI477lMblBY10eFpzCy4spQgtxlLWL6juZ++mZycv5Dr92j
 i38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751668367; x=1752273167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RNTuphuGm9p7ud6YPEAB9vvpfF4veBp+TzIvzkfoEsQ=;
 b=UyHIFxUjXepqY/EJMv50IBMzHluKyoaHktZ7Kp6r4Mq5smzYD7oZ7nG2iDB2VuTLLd
 U7U72vlpXnk9X9gwxx+9d8TH0WBtj5iQgHX9CpCmazovcUU5CavprgIUjEaU1P2xdzPP
 m8vJj1bVTE3axA1pP+5apm7Z4tA2aRMhjdo5TY4RlgqE71x1+JDTZ00X0rmNfFLJgwt8
 VQ0C7R1dpp79gE4uSjc4kePqp22r8x7Ih9iZSJNMHRFAXHwXrhbThNeq8tKMdbpV5/nL
 7aaQKNVovl35iwjfIRHpg6pR9joz6vxIyVuXN/vCZfXvcRL1UYA68m7F8BgilAguKcWG
 cpvA==
X-Gm-Message-State: AOJu0YzjT2ritgI54JKks5V79cpfSD5YKrc/jzDUWXpjhm2mYWmLEi8t
 /i2EWfmaB+O2KyhUI4bvvERDvGaiasosQv5OykztEQawZXnl+22bSFNaeYhlsw==
X-Gm-Gg: ASbGnctuVxENEKKtngsPwK4lA2zGCkFAzuGJSVVW+Cgsurbc4KqEEAvk5qJh2xQ9lNM
 9WBpYYD6aKhJgpXDfGaOQBYHLNndy9YbtEYp1BpjTkGzGUKM1+t9/yeLD0Y1jZYIX6MnTP9ElM3
 I+ojU/5/2nRuCL/wQt313Ef82m4yCcrBFD+g5rtSzDkbKlPEFTJ1Mr5IrD1Gb66Bq3xJVKzDsY4
 TSb5LSl4vSat9V1SRrbqGjBA80g5MHYGRP4xms8qGuQp7d+5aQKWm+EToZG2soqpiXujEEHgXjZ
 6daeRtoBGMAl08QB/pTQqJ7HxaPpqM8S9Vc6S5Lff9Q7LP3tyafFEJh9s9FOmQG07zdBrHVAU5q
 BYwZZkg==
X-Google-Smtp-Source: AGHT+IHzxua7tFm582y+3OR3jxnYTxgolXevGZv3UuAad0zM73+Vd0iiEJnpPy2awdz8juskUoRiEA==
X-Received: by 2002:a05:622a:418f:b0:4a9:8299:4e00 with SMTP id
 d75a77b69052e-4a994cf0d4bmr74040501cf.0.1751668366538; 
 Fri, 04 Jul 2025 15:32:46 -0700 (PDT)
Received: from user-jcksn.myfiosgateway.com
 ([2600:4040:2bcd:3800:7cf4:c69f:10f5:f5b9])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a994a3093asm21528851cf.36.2025.07.04.15.32.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 15:32:45 -0700 (PDT)
From: Jackson Donaldson <jackson88044@gmail.com>
X-Google-Original-From: Jackson Donaldson <jcksn@duck.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v4 08/11] MAX78000: TRNG Implementation
Date: Fri,  4 Jul 2025 18:32:36 -0400
Message-Id: <20250704223239.248781-9-jcksn@duck.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250704223239.248781-1-jcksn@duck.com>
References: <20250704223239.248781-1-jcksn@duck.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=jackson88044@gmail.com; helo=mail-qt1-x82c.google.com
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


