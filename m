Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D3F0C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 22:34:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXoxz-0001m7-Tc; Fri, 04 Jul 2025 18:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uXoxd-0001fL-Ex
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 18:32:58 -0400
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uXoxY-00078H-3P
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 18:32:47 -0400
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-4a7f61ea32aso26219241cf.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 15:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751668362; x=1752273162; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yd7LTn2YUlDT9S5rPLAcwZ///WOqOGbERBjMl7uiB8Y=;
 b=L+juQVf6WIPdtqxhY+fE2/94el917Cltb5GI+cuEM2silhCd8Es5Dn3kuUjuXpdx8P
 T0P3AaJdTEQinb2Bec1qggJMSWO1ulwVgv7JxEen9NdJy0lPQACBxl6i1lKj5jVzIBbi
 5OHtuZ0w7jdOutyYAUWLMCocYrt4DEwxe6w9xGMXD04kQxhcZ4PnaLAuhRYaCsh9ozSB
 Ojlt7bIp6IFfsktu5QA9pUb9Y2uU7d5EqzXFDiKNXuk9lQimscOqCcZ/mJ32kz6zLu3T
 YiEcxb3y33DSVHvZbV60vCO5ZvhcITwhIM2Fm2NCjxvLWXa6ntXAiOAjZkS8z+helhga
 GEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751668362; x=1752273162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yd7LTn2YUlDT9S5rPLAcwZ///WOqOGbERBjMl7uiB8Y=;
 b=XHi2DnycFVCUsu+t2vTxas6LQ/4dSuDPdfW3mbH/alFPEk7DK1W3zPDNJnXOtAquC3
 KAVh5/lZZYVvPvNwSVcQk5qLSbwr5Fsm3V8Kk4DoanI5Uy+2mWtqNwQyAmMuL4TVoIb+
 DoN0jB7IzH3VFvMquRAAQMCutwkFV9Xa8pgoG5+la5I1o0hNx4T8pz1N/Eg4f3+nW8b7
 yRE9B08KV/gMMm4nQxan5jXEiABT+gCV9gosY5BKPEouay03DF8tEHFLLsAw/SYY7LeA
 mvCRCtcyPncpBiNflAqlxLt9gDXefTWIMF9yNlWFoF/hd6VUVUqYlBOnWzGnRn8MQ+bu
 HHtg==
X-Gm-Message-State: AOJu0YxUwW3iSmPCTXUFFfAZK6DjB+V0LmehfE1WV2OOKLho9RxSxWGS
 Fd2gvFbmsB3wJ8RmPVC4hx3ULiMXEMDAWS8xSoHHUqJhVULSgvofSxSwjjWm+A==
X-Gm-Gg: ASbGnctzQbRE5NQ7i1w8sN7KF5JR4F6EDdBzSgp1/ZKNOo02jZEYXP/z+zCt6qoxYgF
 liZB/h2nACbSNNitIX4vC2zP+Ai3/x0no5awSXSfHT4jl9BP7FM51Af+wDkSaGfCdMEvFiGYcRJ
 2RveMFv5W9fORswkqzHlVAlr3HzJtTQqYynj+KltDWkhnIV0mI13voWjr9wPi4C5ob820/K6C8w
 xbZhnw0CRiAHsx+e0KMAnU06Cb0V+RG/oN3m4XCItczV9NbXmcCaXmZyQIe3alfYOcHuUQjwqen
 qCmiS/wLP66UFzcBCQR6ueQwdVCChM73HblFqzv38Tn2GYhpyCsrswKzEqTH+YaUD8+q2dLgMvb
 qjW9qww==
X-Google-Smtp-Source: AGHT+IEaDBoCiLk8uHvOeJJ2XulzUFJl+vQsOMXyRnlgQzpTAfJTm3iB+bijRx1qXpMg31yMRNCeaA==
X-Received: by 2002:a05:622a:3d0:b0:4a4:413c:ffb5 with SMTP id
 d75a77b69052e-4a9a68c13abmr7530801cf.2.1751668362362; 
 Fri, 04 Jul 2025 15:32:42 -0700 (PDT)
Received: from user-jcksn.myfiosgateway.com
 ([2600:4040:2bcd:3800:7cf4:c69f:10f5:f5b9])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a994a3093asm21528851cf.36.2025.07.04.15.32.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 15:32:41 -0700 (PDT)
From: Jackson Donaldson <jackson88044@gmail.com>
X-Google-Original-From: Jackson Donaldson <jcksn@duck.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v4 02/11] MAX78000: ICC Implementation
Date: Fri,  4 Jul 2025 18:32:30 -0400
Message-Id: <20250704223239.248781-3-jcksn@duck.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250704223239.248781-1-jcksn@duck.com>
References: <20250704223239.248781-1-jcksn@duck.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::836;
 envelope-from=jackson88044@gmail.com; helo=mail-qt1-x836.google.com
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

This commit implements the Instruction Cache Controller
for the MAX78000

Signed-off-by: Jackson Donaldson <jcksn@duck.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/Kconfig                 |   1 +
 hw/misc/Kconfig                |   3 +
 hw/misc/max78000_icc.c         | 120 +++++++++++++++++++++++++++++++++
 hw/misc/meson.build            |   1 +
 include/hw/misc/max78000_icc.h |  33 +++++++++
 5 files changed, 158 insertions(+)
 create mode 100644 hw/misc/max78000_icc.c
 create mode 100644 include/hw/misc/max78000_icc.h

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index ddaafa8faa..e3b419b468 100644
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
index ec0fa5aa9f..781bcf74cc 100644
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
 
diff --git a/hw/misc/max78000_icc.c b/hw/misc/max78000_icc.c
new file mode 100644
index 0000000000..6f7d2b20bf
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
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 6d47de482c..a21a994ff8 100644
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
diff --git a/include/hw/misc/max78000_icc.h b/include/hw/misc/max78000_icc.h
new file mode 100644
index 0000000000..6fe2bb7a15
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
-- 
2.34.1


