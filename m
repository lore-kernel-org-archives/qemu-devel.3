Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 783DBC53200
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 01:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnRA8-00051A-Oc; Fri, 24 Jul 2026 21:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wnRA7-0004zG-55
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 21:26:47 -0400
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wnRA5-0006G1-AR
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 21:26:46 -0400
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-97723f98735so608760241.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 18:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784942804; x=1785547604; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AHe+xJkUhH4lTnbCnaYnt4eY4xiiCDpGlriXZBo47jA=;
 b=EG+VJvj8jCUEZKwrv0dALOjdnMiaLwlU0uYeJvc+f6orsbzPHhQbCBsO6wqJCzTQe2
 o8ZwlYHdOVANBtn0IWiCnNHEd1NyTV6Rvn8BYQFTx+U+eZtJy7jnmu1WevmJQaODFH41
 ++dVb2MaGpp47fAn+3ljjV4M1cClxegj5ISc4tX1CG2ImYorlPO8UrZhyiFnMs0Ygkn+
 Fdi3BvTHnbJS2D5zwaMC8s1xJ3T4RUHtPmxJwc2rbUvshhzb1mQmlY6YqLsH3JJF826k
 +o/spD/cR3Vj+EXJC5VEhVQMO7HjLKgQAhBgnvgF1+OWDEu/5W5ff7YgsLsgs4LZSwjX
 sFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784942804; x=1785547604;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AHe+xJkUhH4lTnbCnaYnt4eY4xiiCDpGlriXZBo47jA=;
 b=ZLRcxaq8zGyjWXQTPgLzQfFuYIEcKKu9OZJ6ggDF3qkPfpjW5LRn8bERKzH91ddnhP
 fyjDJBm45cULBaTZPoF9wxyzUJAokQ8U+D5E8r8f1J933us2Y7LMNH1O8pnLdVXM8QJi
 LhSlrj2FRxrfe5N3GXppFNpzTlv+s4XZLDAK0FOlYUH7utQsGRE/9drBynZWlmLJJ0ZH
 9iX5Z29M8E0YJhLmsIQVcCggnGuJ36usZZhZufdKDpU8kmhDEAE3Pqdb1mTHUO8VfydQ
 NU4uhG+6SqoyTJqdrCBddEtscoYzL7cl+xuYUh4bu8alaWPR4jz2upISGMw8O6hGR/pP
 5EoQ==
X-Gm-Message-State: AOJu0YyDfP9D1yomvfaQroDWFd60XX0nXhDG9K5bxlvmjxLcdLM3KvKM
 SRSwEuzhZLv+aUOkT2DnkVz0x4O1ENROul4MEeH3bInUenK0NS1hlD8pqGzPm7on
X-Gm-Gg: AR+sD13QKcpCsKaJ5OsublgmfNCoeCTFFymliM1KI7/SCJ6OyvPRe5K36MSBKMHTHEY
 UVboyXBdrFi8JQs12y+Io9JWlUTQch62kyi2CXW1SdtxBppboY2dN/UzocIoiOMIwW4VGKgvIax
 9NandjY1jb0pK5j1BpAH5/WZXJUQmEbmR75Qre5N607+XyvabkzS6T/KiFUynH2HUMfGB56RA5u
 UqCIGA3L9wCYMB9HQ0Sa/4BCYzjciMCti/QVkzJSFdIWGTdAWOl4MwhQd0jnaOsELD1iIxbmKGL
 5dgHXJBpLH750qCa/pilhIgeAJ86WNBbVARVSPBvMLxEeCT13wzdZEFmkEbMVI6ryjrd9Imgy3j
 H04yap4NaL8K1yAdtz9qRN0cgiPqATCCeXE+sY8B4pMwQRCTc06CBgND/NkjhpOCF8JHmuboDa+
 s+A4bVRC1Yz4VKAok9xJP2CssAAZbL1R8wxDWYm4zOg8Q=
X-Received: by 2002:a05:6102:4bc3:b0:744:dd70:a364 with SMTP id
 ada2fe7eead31-7503e76a392mr796437137.9.1784942804096; 
 Fri, 24 Jul 2026 18:26:44 -0700 (PDT)
Received: from localhost.localdomain ([146.71.8.128])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-97774c388d7sm1092856241.1.2026.07.24.18.26.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Jul 2026 18:26:43 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Sergey Kambalin <sergey.kambalin@auriga.com>,
 Sergey Kambalin <serg.oker@gmail.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>
Subject: [PATCH 3/5] hw/misc/bcm2838_thermal: add BCM2838 thermal sensor
Date: Fri, 24 Jul 2026 21:26:33 -0400
Message-ID: <20260725012635.4925-4-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260725012635.4925-1-marcelomanzo@gmail.com>
References: <20260725012635.4925-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::92d;
 envelope-from=marcelomanzo@gmail.com; helo=mail-ua1-x92d.google.com
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

From: Sergey Kambalin <serg.oker@gmail.com>

Add a dummy BCM2838 (BCM2711/Raspberry Pi 4B) thermal sensor: a
single status register that always reports a fixed 25C reading with
both "valid" bits set. Real hardware reports live temperature; a
fixed reading is enough for guests that just probe the sensor and
read it, without modeling actual thermal behavior.

Part of Sergey Kambalin's original Raspberry Pi 4B series (patchwork
series 829638, posted to qemu-devel in 2024, never merged). Ported
to current master by Marcelo Manzo: header paths moved under
hw/core/, class_init()'s const void *data. No functional change
otherwise (this device has no reset or migration state to begin
with).

Boot-tested: guest's thermal_zone0/temp reports 25310 (25.31C),
matching the fixed reading this device returns.

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
---
 hw/misc/bcm2838_thermal.c         | 98 +++++++++++++++++++++++++++++++
 hw/misc/meson.build               |  1 +
 include/hw/misc/bcm2838_thermal.h | 23 ++++++++
 3 files changed, 122 insertions(+)
 create mode 100644 hw/misc/bcm2838_thermal.c
 create mode 100644 include/hw/misc/bcm2838_thermal.h

diff --git a/hw/misc/bcm2838_thermal.c b/hw/misc/bcm2838_thermal.c
new file mode 100644
index 00000000..40148ddb
--- /dev/null
+++ b/hw/misc/bcm2838_thermal.c
@@ -0,0 +1,98 @@
+/*
+ * BCM2838 dummy thermal sensor
+ *
+ * Copyright (C) 2022 Maksim Kopusov <maksim.kopusov@auriga.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "hw/misc/bcm2838_thermal.h"
+#include "hw/core/registerfields.h"
+#include "migration/vmstate.h"
+#include "qemu/error-report.h"
+
+REG32(STAT, 0x200)
+FIELD(STAT, DATA, 0, 10)
+FIELD(STAT, VALID_1, 10, 1)
+FIELD(STAT, VALID_2, 16, 1)
+
+#define BCM2838_THERMAL_SIZE 0xf00
+
+#define THERMAL_OFFSET_C 410040
+#define THERMAL_COEFF  (-487.0f)
+#define MILLIDEGREE_COEFF 1000
+
+static uint16_t bcm2838_thermal_temp2adc(int temp_C)
+{
+    return (temp_C * MILLIDEGREE_COEFF - THERMAL_OFFSET_C) / THERMAL_COEFF;
+}
+
+static uint64_t bcm2838_thermal_read(void *opaque, hwaddr addr, unsigned size)
+{
+    uint32_t val = 0;
+
+    switch (addr) {
+    case A_STAT:
+        /* Temperature is always 25°C */
+        val = FIELD_DP32(val, STAT, DATA, bcm2838_thermal_temp2adc(25));
+        val = FIELD_DP32(val, STAT, VALID_1, 1);
+        val = FIELD_DP32(val, STAT, VALID_2, 1);
+
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s can't access addr: 0x%"HWADDR_PRIx,
+                     TYPE_BCM2838_THERMAL, addr);
+    }
+    return val;
+}
+
+static void bcm2838_thermal_write(void *opaque, hwaddr addr,
+                                      uint64_t value, unsigned size)
+{
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: write 0x%" PRIx64
+                                " to 0x%" HWADDR_PRIx "\n",
+                __func__, value, addr);
+}
+
+static const MemoryRegionOps bcm2838_thermal_ops = {
+    .read = bcm2838_thermal_read,
+    .write = bcm2838_thermal_write,
+    .impl.max_access_size = 4,
+    .valid.min_access_size = 4,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void bcm2838_thermal_realize(DeviceState *dev, Error **errp)
+{
+    Bcm2838ThermalState *s = BCM2838_THERMAL(dev);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &bcm2838_thermal_ops,
+                          s, TYPE_BCM2838_THERMAL, BCM2838_THERMAL_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
+}
+
+static void bcm2838_thermal_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = bcm2838_thermal_realize;
+
+    /* This device has no state: no need for vmstate or reset */
+}
+
+static const TypeInfo bcm2838_thermal_info = {
+    .name = TYPE_BCM2838_THERMAL,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(Bcm2838ThermalState),
+    .class_init = bcm2838_thermal_class_init,
+};
+
+static void bcm2838_thermal_register_types(void)
+{
+    type_register_static(&bcm2838_thermal_info);
+}
+
+type_init(bcm2838_thermal_register_types)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index cf73ab4c..b4ac064d 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -95,6 +95,7 @@ system_ss.add(when: 'CONFIG_RASPI', if_true: files(
   'bcm2835_cprman.c',
   'bcm2835_powermgt.c',
   'bcm2838_rng200.c',
+  'bcm2838_thermal.c',
 ))
 system_ss.add(when: 'CONFIG_SLAVIO', if_true: files('slavio_misc.c'))
 system_ss.add(when: 'CONFIG_ZYNQ', if_true: files('zynq_slcr.c'))
diff --git a/include/hw/misc/bcm2838_thermal.h b/include/hw/misc/bcm2838_thermal.h
new file mode 100644
index 00000000..1ba524ed
--- /dev/null
+++ b/include/hw/misc/bcm2838_thermal.h
@@ -0,0 +1,23 @@
+/*
+ * BCM2838 dummy thermal sensor
+ *
+ * Copyright (C) 2022 Maksim Kopusov <maksim.kopusov@auriga.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef BCM2838_THERMAL_H
+#define BCM2838_THERMAL_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_BCM2838_THERMAL "bcm2838-thermal"
+OBJECT_DECLARE_SIMPLE_TYPE(Bcm2838ThermalState, BCM2838_THERMAL)
+
+struct Bcm2838ThermalState {
+    SysBusDevice busdev;
+    MemoryRegion iomem;
+};
+
+#endif /* BCM2838_THERMAL_H */
-- 
2.47.1


