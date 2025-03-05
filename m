Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFBE3C282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdSg-0007ta-7B; Tue, 04 Mar 2025 20:22:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdSe-0007tK-LC
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:22:12 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdSc-0006uK-RN
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:22:12 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43bcc02ca41so11953505e9.0
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741137729; x=1741742529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UmR5ArYjxZGIeXGnw2haxlZWQ2j6JF05kRSnp+2VEoM=;
 b=weizFo6v4wnjRaEC0Grk/N/RBTcCg66kguq8IYTA7DYE/L6Nu8MjPqpfDiP15ZCvHz
 YtuScyd9TopoVqpu9WdjrfKaQGbFiX3BROFwzD40uOEEIf+Qh0OBL9N92R5vHdDqHdMv
 tvlk1STLE++ImPXO0K4yADfS3t2ZOPd6EWne8iVmSxN+1eHZDG5rSyRuqexkKqQamx2I
 VMwdofi/LBDCiODJZ7tRbT1PJNb2wbHu1i7JmH/118+RoR5vxBI5Z2VfyC5tu7BxZ8GE
 i6CoyArN62ruGDy7xoLdoxuXl+CLvU2EvXldGXkMFgKBF7TcU+ZiSa5rfZvDFqFLYxvo
 fUaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741137729; x=1741742529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UmR5ArYjxZGIeXGnw2haxlZWQ2j6JF05kRSnp+2VEoM=;
 b=KOW02BBazUUq/wqVyM/H4reFFL2NikcNxfsESuQgHHjRnvWj+yhH1hNFyGLt+73+PT
 tYcNtM6D0iDguHDhwlLc9Wphqc54rVgG7q8D8AVsDvks0aqFpEmTzjtYPtykSZlhumpe
 bGF4x8lsUJxD7k1GvSHwdqu5c+iGUhibse9Dm40Y9ATPLjfZ3UODWL0tGI4p/yKwLTni
 KbTT19d85THxCVNQRZfba0n5RH4nUV5pS429ALkIZKeF+bAfnQ2V5QwmatKUOpMqNuo2
 8mEaL8V1HE9tFP2+DYq2ov4NTCy+qB+8sWQbL+rQiTejR2h9GLdCA3mysv3Pvrm69jDb
 PYHw==
X-Gm-Message-State: AOJu0YyEMJrUYzi53F1oK7VWeZA00hUwqGrGL4UmeYf6/ZqEZxj1ZMRb
 odpj/8voKLrZyCB+BGJaSKv8MgFQ2qke7WVIMQdUncJeJk7x9LU2nLQ0z5w/NjCpRIDIZ5DllNd
 xVwI=
X-Gm-Gg: ASbGncsCuHQq81jZpwUSl/wCFsv5hwtSP+P4Iv4jxDl1PkrtQskf7lCBEm3PAA1x3j9
 B4OuuCwWV4dShJ4p8a/jrKdRCN2pMu7t+WczTUYdWMiESI0DYbfNpmjnodhhIi7P1PIf/l3+d5z
 WUdVxl7hoy4BlGeAv0Fn3mPm/YL9EZSA24Qpm2Ws350TesTrOWDneMT0deqKtWIF7xrSiEEvQW5
 4N5282yHLF6hMph83Ds2XGGaE2tchK81wh7m2A3wTdMetViQyeDIKkADg3HEP62GIcsSeHvcxEV
 xwC8qlE1TgN1rGtiqcFjhTekuCB/QJUqHjTPUwxlGK/PraEMMi0KGWiLfutf67LHo7Rs0a/MHyt
 4tqCX0+wb4tiEPksPnZ4=
X-Google-Smtp-Source: AGHT+IFuCuvLOVyzRbu7oQrBKY9gHiTd9QO/uGfWj6sajSPfJVmrwXq1so2/nDfp81CSuVh5HiFMXw==
X-Received: by 2002:a05:6000:188b:b0:38f:2bd4:4f83 with SMTP id
 ffacd0b85a97d-3911f728a05mr750808f8f.16.1741137728704; 
 Tue, 04 Mar 2025 17:22:08 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e4795da5sm19606063f8f.15.2025.03.04.17.22.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Mar 2025 17:22:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <graf@amazon.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL 02/41] hw/misc/pvpanic: Add MMIO interface
Date: Wed,  5 Mar 2025 02:21:17 +0100
Message-ID: <20250305012157.96463-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305012157.96463-1-philmd@linaro.org>
References: <20250305012157.96463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

From: Alexander Graf <graf@amazon.com>

In addition to the ISA and PCI variants of pvpanic, let's add an MMIO
platform device that we can use in embedded arm environments.

Signed-off-by: Alexander Graf <graf@amazon.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <20241223221645.29911-8-phil@philjordan.eu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/misc/pvpanic.h |  1 +
 hw/misc/pvpanic-mmio.c    | 60 +++++++++++++++++++++++++++++++++++++++
 hw/misc/Kconfig           |  4 +++
 hw/misc/meson.build       |  1 +
 4 files changed, 66 insertions(+)
 create mode 100644 hw/misc/pvpanic-mmio.c

diff --git a/include/hw/misc/pvpanic.h b/include/hw/misc/pvpanic.h
index 9a71a5ad0d7..049a94c1125 100644
--- a/include/hw/misc/pvpanic.h
+++ b/include/hw/misc/pvpanic.h
@@ -26,6 +26,7 @@
 
 #define TYPE_PVPANIC_ISA_DEVICE "pvpanic"
 #define TYPE_PVPANIC_PCI_DEVICE "pvpanic-pci"
+#define TYPE_PVPANIC_MMIO_DEVICE "pvpanic-mmio"
 
 #define PVPANIC_IOPORT_PROP "ioport"
 
diff --git a/hw/misc/pvpanic-mmio.c b/hw/misc/pvpanic-mmio.c
new file mode 100644
index 00000000000..70097cecc74
--- /dev/null
+++ b/hw/misc/pvpanic-mmio.c
@@ -0,0 +1,60 @@
+/*
+ * QEMU simulated pvpanic device (MMIO frontend)
+ *
+ * Copyright © 2023 Amazon.com, Inc. or its affiliates. All Rights Reserved.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/qdev-properties.h"
+#include "hw/misc/pvpanic.h"
+#include "hw/sysbus.h"
+#include "standard-headers/misc/pvpanic.h"
+
+OBJECT_DECLARE_SIMPLE_TYPE(PVPanicMMIOState, PVPANIC_MMIO_DEVICE)
+
+#define PVPANIC_MMIO_SIZE 0x2
+
+struct PVPanicMMIOState {
+    SysBusDevice parent_obj;
+
+    PVPanicState pvpanic;
+};
+
+static void pvpanic_mmio_initfn(Object *obj)
+{
+    PVPanicMMIOState *s = PVPANIC_MMIO_DEVICE(obj);
+
+    pvpanic_setup_io(&s->pvpanic, DEVICE(s), PVPANIC_MMIO_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->pvpanic.mr);
+}
+
+static const Property pvpanic_mmio_properties[] = {
+    DEFINE_PROP_UINT8("events", PVPanicMMIOState, pvpanic.events,
+                      PVPANIC_PANICKED | PVPANIC_CRASH_LOADED),
+};
+
+static void pvpanic_mmio_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_props(dc, pvpanic_mmio_properties);
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+}
+
+static const TypeInfo pvpanic_mmio_info = {
+    .name          = TYPE_PVPANIC_MMIO_DEVICE,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(PVPanicMMIOState),
+    .instance_init = pvpanic_mmio_initfn,
+    .class_init    = pvpanic_mmio_class_init,
+};
+
+static void pvpanic_register_types(void)
+{
+    type_register_static(&pvpanic_mmio_info);
+}
+
+type_init(pvpanic_register_types)
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 82bd68b4bb8..ec0fa5aa9f8 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -148,6 +148,10 @@ config PVPANIC_ISA
     depends on ISA_BUS
     select PVPANIC_COMMON
 
+config PVPANIC_MMIO
+    bool
+    select PVPANIC_COMMON
+
 config AUX
     bool
     select I2C
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 0b5187a2f74..6d47de482c5 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -126,6 +126,7 @@ system_ss.add(when: 'CONFIG_ARMSSE_MHU', if_true: files('armsse-mhu.c'))
 
 system_ss.add(when: 'CONFIG_PVPANIC_ISA', if_true: files('pvpanic-isa.c'))
 system_ss.add(when: 'CONFIG_PVPANIC_PCI', if_true: files('pvpanic-pci.c'))
+system_ss.add(when: 'CONFIG_PVPANIC_MMIO', if_true: files('pvpanic-mmio.c'))
 system_ss.add(when: 'CONFIG_AUX', if_true: files('auxbus.c'))
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_hace.c',
-- 
2.47.1


