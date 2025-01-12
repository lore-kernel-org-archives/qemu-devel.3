Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C23BE7719E
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 21:05:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX56N-0004oP-Bb; Sun, 12 Jan 2025 16:02:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tX55U-0004TO-9a
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 16:01:36 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tX55R-0006NX-EC
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 16:01:35 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5d3f28a4fccso5255903a12.2
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 13:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1736715692; x=1737320492;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GvDhEz3acYJceXtOa/E3HfCa+FSJUVu7fX0WjN7zRao=;
 b=Lga7smrX+7rwfPjm4Uq3tZYxoHjCwXUTT/Somkxkqv73E9OWFupTtFgKSVgkW5k7yq
 vbblRRAAqAVefKy7nYwbGaOVJChhwSj7TCzEvfDu0UuKXir2mfKdAy02noY+olcJYCJW
 PVsejBwka9/DodecvfTMkyDBGinD7KC+37f7QVs3GvFYdRIdrdzScUhFnwNZiA6i7aEM
 FwAksMW59klRKeedUSgSkhDIk/xt7k79PMUkcdPn75OzRGCpkca5bfqMBlFI9X/Dw/uR
 8yH1ttdR9cwb9K6aPC6wAKkuiY8Q5HOWmsbriEJJyLSzIJJBo1TGN9sqMihkkj5IhtTx
 btmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736715692; x=1737320492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GvDhEz3acYJceXtOa/E3HfCa+FSJUVu7fX0WjN7zRao=;
 b=BeUxBGmiGNWzYt3h7nhHvFEMU5/uBblbMudVDjVPmKTMDSwqpIyb54PflVZSng3NTC
 4wqOz7MUki5vHRMeYuDHFg+vlK664q7PRHCzoXb+mIe7IUWyG/BIjoUSAhNt1hdxFVEw
 53qDp9Mi/JRv7d3BJTeOoH4V4oVKUUMtZULtaFdkARN0isoPQ940Dq7VTuAE2CsL4mIT
 nz12zdk4WDcFaFB8TIUYAaYsxKJH4oK84Q4erzRedpA+lpNYSOGIXS0f1hfB+yiWtgbi
 Gdd7vaJjH9osjptBsHaP55Y7FKlfCTGV8VeEWePgZ6vxVjD0ahdITpD8GtJKFAtVWMNZ
 VkCA==
X-Gm-Message-State: AOJu0YwpOYLfv1Wdfnp7nJlEyHySw5h0rCgCFafcK/ZBIEi2aMJBQ/EN
 lHtAYodkuDmr5RP8x1LdHa8nAeC8wMtF+2H7mL8Yo6NqC6Dx5lk1ZkBHfkZP1eRNgOK2MJn0mXW
 cAQ==
X-Gm-Gg: ASbGncsD+xJmbJmfXgEjZPRK0U/5/MhH6ftMG4D9Kl0aJRUSst11zTi0CmYdh0+LLrK
 6HvOxJHnFVgR/osZzna1HdzQ4nmLK0/UL6OIToU8OBDfGR8gI0m0+yRr4BOSY32jDJzbo/PdeTv
 i7+hyFkdt/ZjDmSJ8YXXwtd+n8wImPv7OokWqlm0OW4p2rsNHWf9Vu3Wr/Ze05Kr9HvFWiW+UzS
 kfdZbS+qKmXoD+1Bs8n4xEuzl+pjBg6xZXuOuOedYlkOssQShwC8LRoCr+ztrYZPCUO1dIPtrl8
 g7m3ffFT0Pg7KwfzPalegEaf27vNyiM0
X-Google-Smtp-Source: AGHT+IFOYlfdo3gXl+57p29DLtWoMertRVpUkwtPWvSBy5fcZ0tnTi1sBU6HyfjUGQly9Cv3L0wDqg==
X-Received: by 2002:a17:906:3fcf:b0:ab2:f5cb:c039 with SMTP id
 a640c23a62f3a-ab2f5cbc22dmr529508166b.54.1736715691652; 
 Sun, 12 Jan 2025 13:01:31 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c905e283sm418276666b.31.2025.01.12.13.01.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 13:01:31 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: agraf@csgraf.de, phil@philjordan.eu, peter.maydell@linaro.org,
 pbonzini@redhat.com, mst@redhat.com, stefanha@redhat.com, kwolf@redhat.com,
 hreitz@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, marcandre.lureau@redhat.com, philmd@linaro.org,
 eblake@redhat.com, armbru@redhat.com, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, Alexander Graf <graf@amazon.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v17 04/11] hw/misc/pvpanic: Add MMIO interface
Date: Sun, 12 Jan 2025 22:00:49 +0100
Message-Id: <20250112210056.16658-5-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250112210056.16658-1-phil@philjordan.eu>
References: <20250112210056.16658-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::52d;
 envelope-from=phil@philjordan.eu; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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
---

v3:
 * Rebased on upstream, updated a header path

v15:
 * Constified the property table.

v16:
 * Removed the DEFINE_PROP_END_OF_LIST marker to match recent upstream
   changes.

 hw/misc/Kconfig           |  4 +++
 hw/misc/meson.build       |  1 +
 hw/misc/pvpanic-mmio.c    | 60 +++++++++++++++++++++++++++++++++++++++
 include/hw/misc/pvpanic.h |  1 +
 4 files changed, 66 insertions(+)
 create mode 100644 hw/misc/pvpanic-mmio.c

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 8f9ce2f68c..16cf872e40 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -150,6 +150,10 @@ config PVPANIC_ISA
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
index 55f493521b..6187caaf71 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -124,6 +124,7 @@ system_ss.add(when: 'CONFIG_ARMSSE_MHU', if_true: files('armsse-mhu.c'))
 
 system_ss.add(when: 'CONFIG_PVPANIC_ISA', if_true: files('pvpanic-isa.c'))
 system_ss.add(when: 'CONFIG_PVPANIC_PCI', if_true: files('pvpanic-pci.c'))
+system_ss.add(when: 'CONFIG_PVPANIC_MMIO', if_true: files('pvpanic-mmio.c'))
 system_ss.add(when: 'CONFIG_AUX', if_true: files('auxbus.c'))
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_hace.c',
diff --git a/hw/misc/pvpanic-mmio.c b/hw/misc/pvpanic-mmio.c
new file mode 100644
index 0000000000..70097cecc7
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
diff --git a/include/hw/misc/pvpanic.h b/include/hw/misc/pvpanic.h
index 9a71a5ad0d..049a94c112 100644
--- a/include/hw/misc/pvpanic.h
+++ b/include/hw/misc/pvpanic.h
@@ -26,6 +26,7 @@
 
 #define TYPE_PVPANIC_ISA_DEVICE "pvpanic"
 #define TYPE_PVPANIC_PCI_DEVICE "pvpanic-pci"
+#define TYPE_PVPANIC_MMIO_DEVICE "pvpanic-mmio"
 
 #define PVPANIC_IOPORT_PROP "ioport"
 
-- 
2.39.5 (Apple Git-154)


