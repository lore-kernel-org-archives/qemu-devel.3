Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF4D2C83F21
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 13:35:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaDtr-0004Pu-Te; Fri, 11 Jul 2025 09:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDte-0004MC-61
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:34:39 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDtb-0002w1-Ku
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:34:37 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-454f426b3e5so3490175e9.0
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 06:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752240874; x=1752845674; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=C5aEQ8IqDu8YxF4SP4TfNZxTFSEpR0LJNTlVcVb/ZfI=;
 b=v0tGUeXd2BzuLTTH7zZjIq0PeXM4NqHC8FMU7y68SyWPFdYWql35pfvqoNT413okYm
 EqFOpRmRvbeUDX3gsC3mgh8osOxOOS89xjebhBxki00gwerCi2PuwolgSS2A0/ICHdFT
 nmC9JI5Lfn15wl2qBUM0Hlumgp+Wbikn/esnXdyHs7eIJ8aTv+8byDc9cwD5TTQV/pFV
 WlrF8bh46KlKoaq3ReveHcMeRsZuQV5lW+IbvUdR4qWwIQEwWNX6+8Ea5o7X8Q+ObkoC
 0Sjk9JqFYvA41biup+nbAlpIjh+jLSD/shUMNfs+MRn668nEVRlOVal/CcXW7Pc/rVSE
 d70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752240874; x=1752845674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C5aEQ8IqDu8YxF4SP4TfNZxTFSEpR0LJNTlVcVb/ZfI=;
 b=gCd2agL6vCskH6P2Kws4gJUE6qR1W98jXZB/1bBDiRfbIZLFHENU6JK5K1kYVGY9Td
 0BeHQ7cz0h7Np/oDUEb3x8YLH6r7t0GHrbq9/DRztnSpy1WDjo/IyYRltdvLuV24b+Ez
 ZS7+IOS7e4tg1A9XFYnCLWuHK97MM6yrZb1sAIp4BrPQLb1xVgRzyKbxzbjtkeAprFWK
 ldAlZrIcU3Et34UrDqNvbwYvkdAez8GRUYFcHLvbrOmNcOhhENIvVkOO68Hs21pelbLM
 2E/iZdAV7kWYK4PhHN/vgtK3bd0tUnRhUXCwgJI1tJpVys+G/ysZzdOjdFiksc5pwUQU
 Bcaw==
X-Gm-Message-State: AOJu0YyBqNEgqOEq9uXKItcVBlVWkr7NRth4LbouWoE8BQP0u4eZPZIa
 xq1p3ONtOKOlrx6MauMNG25fixV7z7L8O3QfXaDAjbloyD10MnpK/QfKgeZk9yYL2BfV3UHFIyW
 CYz5W
X-Gm-Gg: ASbGnctaVrDH8G1jcyt5jFzzCu/idkUH2oVLu79Tra8Nw4r2AEQJu/+ck+4SL/ry0n+
 qi60jcnhm0LdBJv6N1Q5jJAIXNwjm5/I65eEG5CoRBaKxjHBKbfNV94mDbWer/UFUQHP9ob7Pip
 EzBtdySmWV69wAKOwGt/9Ds36HuPrS5CmIKkiglUSX4u4w8QektLXb0FyWTZpez/MioKK0S5xIW
 56MWjOjt8XGhhRf3r6J2lKQp2CDzUHQpRVkYSCzKVyonDWLfHHxMjHDi5xQxdrswcbzyAp7CeOz
 ARbry3lQC+E6V1ZsCuvufg3/JYzfCqVWgO93YQnGpGDh4l1FLJ+LtWrLpCOziO0I6LiBjtQgyew
 ryJD/7TKnf+wW9Pk7RsA5jLvCJE6h
X-Google-Smtp-Source: AGHT+IHF30OCZR525rEuWSloObZXsw1nss40gRjKuOpDo4OZ8Pt/K1egOsrJOQThAF6zNYJCfZWPqA==
X-Received: by 2002:a05:6000:2089:b0:3a6:e1bb:a083 with SMTP id
 ffacd0b85a97d-3b5f2dd2e52mr2847340f8f.25.1752240873919; 
 Fri, 11 Jul 2025 06:34:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d50df0cdsm89734145e9.25.2025.07.11.06.34.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 06:34:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/36] MAX78000: ICC Implementation
Date: Fri, 11 Jul 2025 14:33:55 +0100
Message-ID: <20250711133429.1423030-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711133429.1423030-1-peter.maydell@linaro.org>
References: <20250711133429.1423030-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

This commit implements the Instruction Cache Controller
for the MAX78000

Signed-off-by: Jackson Donaldson <jcksn@duck.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20250704223239.248781-3-jcksn@duck.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/misc/max78000_icc.h |  33 +++++++++
 hw/misc/max78000_icc.c         | 120 +++++++++++++++++++++++++++++++++
 hw/arm/Kconfig                 |   1 +
 hw/misc/Kconfig                |   3 +
 hw/misc/meson.build            |   1 +
 5 files changed, 158 insertions(+)
 create mode 100644 include/hw/misc/max78000_icc.h
 create mode 100644 hw/misc/max78000_icc.c

diff --git a/include/hw/misc/max78000_icc.h b/include/hw/misc/max78000_icc.h
new file mode 100644
index 00000000000..6fe2bb7a156
--- /dev/null
+++ b/include/hw/misc/max78000_icc.h
@@ -0,0 +1,33 @@
+/*
+ * MAX78000 Instruction Cache
+ *
+ * Copyright (c) 2025 Jackson Donaldson <jcksn@duck.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MAX78000_ICC_H
+#define HW_MAX78000_ICC_H
+
+#include "hw/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_MAX78000_ICC "max78000-icc"
+OBJECT_DECLARE_SIMPLE_TYPE(Max78000IccState, MAX78000_ICC)
+
+#define ICC_INFO       0x0
+#define ICC_SZ         0x4
+#define ICC_CTRL       0x100
+#define ICC_INVALIDATE 0x700
+
+struct Max78000IccState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+
+    uint32_t info;
+    uint32_t sz;
+    uint32_t ctrl;
+};
+
+#endif
diff --git a/hw/misc/max78000_icc.c b/hw/misc/max78000_icc.c
new file mode 100644
index 00000000000..6f7d2b20bf5
--- /dev/null
+++ b/hw/misc/max78000_icc.c
@@ -0,0 +1,120 @@
+/*
+ * MAX78000 Instruction Cache
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
+#include "hw/misc/max78000_icc.h"
+
+
+static uint64_t max78000_icc_read(void *opaque, hwaddr addr,
+                                    unsigned int size)
+{
+    Max78000IccState *s = opaque;
+    switch (addr) {
+    case ICC_INFO:
+        return s->info;
+
+    case ICC_SZ:
+        return s->sz;
+
+    case ICC_CTRL:
+        return s->ctrl;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad offset 0x%" HWADDR_PRIx "\n",
+                      __func__, addr);
+        return 0;
+
+    }
+}
+
+static void max78000_icc_write(void *opaque, hwaddr addr,
+                    uint64_t val64, unsigned int size)
+{
+    Max78000IccState *s = opaque;
+
+    switch (addr) {
+    case ICC_CTRL:
+        s->ctrl = 0x10000 | (val64 & 1);
+        break;
+
+    case ICC_INVALIDATE:
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad offset 0x%" HWADDR_PRIx "\n",
+                      __func__, addr);
+        break;
+    }
+}
+
+static const MemoryRegionOps max78000_icc_ops = {
+    .read = max78000_icc_read,
+    .write = max78000_icc_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+};
+
+static const VMStateDescription max78000_icc_vmstate = {
+    .name = TYPE_MAX78000_ICC,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(info, Max78000IccState),
+        VMSTATE_UINT32(sz, Max78000IccState),
+        VMSTATE_UINT32(ctrl, Max78000IccState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void max78000_icc_reset_hold(Object *obj, ResetType type)
+{
+    Max78000IccState *s = MAX78000_ICC(obj);
+    s->info = 0;
+    s->sz = 0x10000010;
+    s->ctrl = 0x10000;
+}
+
+static void max78000_icc_init(Object *obj)
+{
+    Max78000IccState *s = MAX78000_ICC(obj);
+
+    memory_region_init_io(&s->mmio, obj, &max78000_icc_ops, s,
+                        TYPE_MAX78000_ICC, 0x800);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+}
+
+static void max78000_icc_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    rc->phases.hold = max78000_icc_reset_hold;
+    dc->vmsd = &max78000_icc_vmstate;
+}
+
+static const TypeInfo max78000_icc_info = {
+    .name          = TYPE_MAX78000_ICC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(Max78000IccState),
+    .instance_init = max78000_icc_init,
+    .class_init    = max78000_icc_class_init,
+};
+
+static void max78000_icc_register_types(void)
+{
+    type_register_static(&max78000_icc_info);
+}
+
+type_init(max78000_icc_register_types)
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 44815af41f5..035568a085e 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -366,6 +366,7 @@ config ALLWINNER_R40
 config MAX78000_SOC
     bool
     select ARM_V7M
+    select MAX78000_ICC
 
 config RASPI
     bool
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index ec0fa5aa9f8..781bcf74ccc 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -47,6 +47,9 @@ config A9SCU
 config ARM11SCU
     bool
 
+config MAX78000_ICC
+    bool
+
 config MOS6522
     bool
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 6d47de482c5..a21a994ff83 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -70,6 +70,7 @@ system_ss.add(when: 'CONFIG_IMX', if_true: files(
   'imx_ccm.c',
   'imx_rngc.c',
 ))
+system_ss.add(when: 'CONFIG_MAX78000_ICC', if_true: files('max78000_icc.c'))
 system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files(
   'npcm_clk.c',
   'npcm_gcr.c',
-- 
2.43.0


