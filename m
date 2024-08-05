Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B208C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 18:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb26f-0005zo-PX; Mon, 05 Aug 2024 14:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sb26e-0005yP-E6
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 14:06:52 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sb26Z-0006OJ-U0
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 14:06:52 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42122ac2f38so110375e9.1
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 11:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722881206; x=1723486006; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MqeGnZInvHvb7oL2hFm59TF6/LgyPKhgLDZR7Hn5KKQ=;
 b=r5PAXhbJFwXxiz7JkIzg3tjW3ZCCAVjyECtGVqd5Y+aq6emGg89KIWgPIPEfr8HzAm
 tXJFd15jA7kG/g19MpA8GYrZJXRskmWsf+SFyM1RnTv6vAcKL8wDPXFMs/Rpd2Zv2YHe
 nnGzmj0mXNVOoAznjt8pblPlIvVdChp86h6X6O2wKZPjXK1iFZ0sYrrYerH8R66F7Bx8
 e1TUIuSYzzdy5PbxxJ9C5GPf6kUeeinc2m8pHJFgONZbGbml4K8dfq6eZl+FpfJkCot1
 HZm4gurUzJQfzPUTjOGPAANTtkVuBfU036rs0YrdgiSEUyOV+NI0YEVY989WzLScAUn9
 k1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722881206; x=1723486006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MqeGnZInvHvb7oL2hFm59TF6/LgyPKhgLDZR7Hn5KKQ=;
 b=G0z2rQBM76dKGmgA43UOLy8/EoFIcZ0rw1wYumXOoGHOCrDJyFCtEUwHAt6VzBWmfP
 6RExVHRTW0YRJuXl0ImfH6ymQ9LmLT/a3bajXplXPP8uG/HD9PZzED+vxHRDegmMzLnY
 MYeC1zP2Wm87UFWYRmlIxWGxnpKnozGBNeqofMjTl5gYEWp9k6E1HlS2BdUfUXbpFU06
 2VYUtXPlqSJkH7bFUeQoqsiCQIjHMdo2sI/7GcamypvXwazfNljbyXa6LIUjaekSFnN7
 b/vWzYb53PCUKTL02dpyg4wKf6oZDmjPEi/TqFZZfjJCZeLI6zjK+5UyM4+JMIXgCbN7
 /7gg==
X-Gm-Message-State: AOJu0YwLm2EJdF7qDYMFwVuQgEwe7rk6qUQ6S+FIvf3JP4iLFivSK35T
 bqrCFiAswu+WODmfxPTKyrPaqvhSdM4aB+Lgqnqf1SMamr9yM4QrTsSckmrwiBDTES4YrB73pWm
 l
X-Google-Smtp-Source: AGHT+IHsEmLBpVmSPDYqU+IwtEAHzg6KAJFal78C06N+pS5rwxIsOiAotF41zO/zKD3wzYsjYVDT8g==
X-Received: by 2002:a05:600c:1c8b:b0:428:e820:37dc with SMTP id
 5b1f17b1804b1-428e8203a6bmr94500865e9.7.1722881205614; 
 Mon, 05 Aug 2024 11:06:45 -0700 (PDT)
Received: from m1x-phil.lan (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428e6e01d0asm148028795e9.16.2024.08.05.11.06.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 05 Aug 2024 11:06:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Bibo Mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH-for-9.1 v6 03/15] hw/intc/loongson_ipi: Add
 TYPE_LOONGSON_IPI_COMMON stub
Date: Mon,  5 Aug 2024 20:06:10 +0200
Message-ID: <20240805180622.21001-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805180622.21001-1-philmd@linaro.org>
References: <20240805180622.21001-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

From: Bibo Mao <maobibo@loongson.cn>

Introduce LOONGSON_IPI_COMMON stubs, QDev parent of LOONGSON_IPI.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
[PMD: Extracted from bigger commit, added commit description]
Co-Developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Tested-by: Bibo Mao <maobibo@loongson.cn>
Acked-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Tested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-Id: <20240718133312.10324-7-philmd@linaro.org>
---
 MAINTAINERS                           |  4 ++++
 include/hw/intc/loongson_ipi.h        | 14 ++++++++++++--
 include/hw/intc/loongson_ipi_common.h | 26 ++++++++++++++++++++++++++
 hw/intc/loongson_ipi.c                | 10 +++++++---
 hw/intc/loongson_ipi_common.c         | 22 ++++++++++++++++++++++
 hw/intc/Kconfig                       |  4 ++++
 hw/intc/meson.build                   |  1 +
 7 files changed, 76 insertions(+), 5 deletions(-)
 create mode 100644 include/hw/intc/loongson_ipi_common.h
 create mode 100644 hw/intc/loongson_ipi_common.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e34c2bd4cd..5ca701cf0c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1250,8 +1250,10 @@ F: configs/devices/loongarch64-softmmu/default.mak
 F: hw/loongarch/
 F: include/hw/loongarch/virt.h
 F: include/hw/intc/loongarch_*.h
+F: include/hw/intc/loongson_ipi_common.h
 F: include/hw/intc/loongson_ipi.h
 F: hw/intc/loongarch_*.c
+F: hw/intc/loongson_ipi_common.c
 F: hw/intc/loongson_ipi.c
 F: include/hw/pci-host/ls7a.h
 F: hw/rtc/ls7a_rtc.c
@@ -1386,11 +1388,13 @@ Loongson-3 virtual platforms
 M: Huacai Chen <chenhuacai@kernel.org>
 R: Jiaxun Yang <jiaxun.yang@flygoat.com>
 S: Maintained
+F: hw/intc/loongson_ipi_common.c
 F: hw/intc/loongson_ipi.c
 F: hw/intc/loongson_liointc.c
 F: hw/mips/loongson3_bootp.c
 F: hw/mips/loongson3_bootp.h
 F: hw/mips/loongson3_virt.c
+F: include/hw/intc/loongson_ipi_common.h
 F: include/hw/intc/loongson_ipi.h
 F: include/hw/intc/loongson_liointc.h
 F: tests/avocado/machine_mips_loongson3v.py
diff --git a/include/hw/intc/loongson_ipi.h b/include/hw/intc/loongson_ipi.h
index efb772f384..9c9030761e 100644
--- a/include/hw/intc/loongson_ipi.h
+++ b/include/hw/intc/loongson_ipi.h
@@ -8,6 +8,8 @@
 #ifndef HW_LOONGSON_IPI_H
 #define HW_LOONGSON_IPI_H
 
+#include "qom/object.h"
+#include "hw/intc/loongson_ipi_common.h"
 #include "hw/sysbus.h"
 
 /* Mainy used by iocsr read and write */
@@ -31,7 +33,7 @@
 #define IPI_MBX_NUM           4
 
 #define TYPE_LOONGSON_IPI "loongson_ipi"
-OBJECT_DECLARE_SIMPLE_TYPE(LoongsonIPIState, LOONGSON_IPI)
+OBJECT_DECLARE_TYPE(LoongsonIPIState, LoongsonIPIClass, LOONGSON_IPI)
 
 typedef struct IPICore {
     LoongsonIPIState *ipi;
@@ -45,8 +47,16 @@ typedef struct IPICore {
     qemu_irq irq;
 } IPICore;
 
+struct LoongsonIPIClass {
+    LoongsonIPICommonClass parent_class;
+
+    DeviceRealize parent_realize;
+    DeviceUnrealize parent_unrealize;
+};
+
 struct LoongsonIPIState {
-    SysBusDevice parent_obj;
+    LoongsonIPICommonState parent_obj;
+
     MemoryRegion ipi_iocsr_mem;
     MemoryRegion ipi64_iocsr_mem;
     uint32_t num_cpu;
diff --git a/include/hw/intc/loongson_ipi_common.h b/include/hw/intc/loongson_ipi_common.h
new file mode 100644
index 0000000000..70ac69d0ba
--- /dev/null
+++ b/include/hw/intc/loongson_ipi_common.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Loongson ipi interrupt header files
+ *
+ * Copyright (C) 2021 Loongson Technology Corporation Limited
+ */
+
+#ifndef HW_LOONGSON_IPI_COMMON_H
+#define HW_LOONGSON_IPI_COMMON_H
+
+#include "qom/object.h"
+#include "hw/sysbus.h"
+
+#define TYPE_LOONGSON_IPI_COMMON "loongson_ipi_common"
+OBJECT_DECLARE_TYPE(LoongsonIPICommonState,
+                    LoongsonIPICommonClass, LOONGSON_IPI_COMMON)
+
+struct LoongsonIPICommonState {
+    SysBusDevice parent_obj;
+};
+
+struct LoongsonIPICommonClass {
+    SysBusDeviceClass parent_class;
+};
+
+#endif
diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index 8aab7e48e8..7d15c28e94 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -374,9 +374,12 @@ static Property ipi_properties[] = {
 static void loongson_ipi_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    LoongsonIPIClass *lic = LOONGSON_IPI_CLASS(klass);
 
-    dc->realize = loongson_ipi_realize;
-    dc->unrealize = loongson_ipi_unrealize;
+    device_class_set_parent_realize(dc, loongson_ipi_realize,
+                                    &lic->parent_realize);
+    device_class_set_parent_unrealize(dc, loongson_ipi_unrealize,
+                                      &lic->parent_unrealize);
     device_class_set_props(dc, ipi_properties);
     dc->vmsd = &vmstate_loongson_ipi;
 }
@@ -384,8 +387,9 @@ static void loongson_ipi_class_init(ObjectClass *klass, void *data)
 static const TypeInfo loongson_ipi_types[] = {
     {
         .name               = TYPE_LOONGSON_IPI,
-        .parent             = TYPE_SYS_BUS_DEVICE,
+        .parent             = TYPE_LOONGSON_IPI_COMMON,
         .instance_size      = sizeof(LoongsonIPIState),
+        .class_size         = sizeof(LoongsonIPIClass),
         .class_init         = loongson_ipi_class_init,
     }
 };
diff --git a/hw/intc/loongson_ipi_common.c b/hw/intc/loongson_ipi_common.c
new file mode 100644
index 0000000000..43002fe556
--- /dev/null
+++ b/hw/intc/loongson_ipi_common.c
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Loongson IPI interrupt common support
+ *
+ * Copyright (C) 2021 Loongson Technology Corporation Limited
+ */
+
+#include "qemu/osdep.h"
+#include "hw/sysbus.h"
+#include "hw/intc/loongson_ipi_common.h"
+
+static const TypeInfo loongarch_ipi_common_types[] = {
+    {
+        .name               = TYPE_LOONGSON_IPI_COMMON,
+        .parent             = TYPE_SYS_BUS_DEVICE,
+        .instance_size      = sizeof(LoongsonIPICommonState),
+        .class_size         = sizeof(LoongsonIPICommonClass),
+        .abstract           = true,
+    }
+};
+
+DEFINE_TYPES(loongarch_ipi_common_types)
diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index 58b6d3a710..a2a0fdca85 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -87,8 +87,12 @@ config GOLDFISH_PIC
 config M68K_IRQC
     bool
 
+config LOONGSON_IPI_COMMON
+    bool
+
 config LOONGSON_IPI
     bool
+    select LOONGSON_IPI_COMMON
 
 config LOONGARCH_PCH_PIC
     bool
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index afd1aa51ee..a09a527207 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -69,6 +69,7 @@ specific_ss.add(when: 'CONFIG_XIVE', if_true: files('xive.c'))
 specific_ss.add(when: ['CONFIG_KVM', 'CONFIG_XIVE'],
 		if_true: files('spapr_xive_kvm.c'))
 specific_ss.add(when: 'CONFIG_M68K_IRQC', if_true: files('m68k_irqc.c'))
+specific_ss.add(when: 'CONFIG_LOONGSON_IPI_COMMON', if_true: files('loongson_ipi_common.c'))
 specific_ss.add(when: 'CONFIG_LOONGSON_IPI', if_true: files('loongson_ipi.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_PCH_PIC', if_true: files('loongarch_pch_pic.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_PCH_MSI', if_true: files('loongarch_pch_msi.c'))
-- 
2.45.2


