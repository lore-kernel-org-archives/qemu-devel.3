Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 256A3C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 12:46:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdUwu-0005fo-I3; Fri, 23 Feb 2024 07:46:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rdUuv-0000r7-3k
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 07:44:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rdUus-0003v4-M4
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 07:44:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708692278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u1Am5sp9Le7YOg3uMyFUE5fw0vwzFtnOClC84CQOA8c=;
 b=cGiWc9FkoWDHx2t6jbAHvYceUSbHzoU8+o9HnOoXnLzSfprIm3rlDZQomlUsDwizR3vPAW
 kVAcCzpdfkkPK4TeiwUoehD06h/wrRk7W3brN6t0Gtd/gCGtOaIKWQcIbgah86B/dlfDzr
 jzhuO9+98cRCgwgVrFfby2IRnNOA9HY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-eNDPJYk1N1O9r_5NGCK6BA-1; Fri, 23 Feb 2024 07:44:36 -0500
X-MC-Unique: eNDPJYk1N1O9r_5NGCK6BA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-33d07c0825aso135806f8f.2
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 04:44:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708692274; x=1709297074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u1Am5sp9Le7YOg3uMyFUE5fw0vwzFtnOClC84CQOA8c=;
 b=FxXZF8L8rTK6KoUoVS4iOikf4I0wk2E6+xuNz5EVX4kocVaeLUIuhVyH8U+fBwpa+R
 hlP2ou7+6f2ukz2mvo4o61D7WNqWgJo9VYFGAR4ilOItCMZEeQOrgnYNBCfU3d/yaLeI
 izKpKKCGkFMh1jXfC6lgA55V3l7DmkV8dCPRb942v5qSAFL8XbqQDaeXCQQyUfXWk0ub
 g282Bo6UQde+rlKXZdAygzIbYMZgGeffhfh4sqSczXkWHupHHlCL1gZvXWGsrDrKKv0z
 7ahs8cbmwZGXzzU26CvDpKKqE+7RSBc7991gDpYQIrtRb7kHNcmSDy+aIDOvkTzxSvna
 UpqQ==
X-Gm-Message-State: AOJu0Yw/xztg7t67SKiVE6ZqrKV7wz3W9QOfVBtKiMBzJ65JHWnqgGxY
 7HYeiu5W3yqdN5AyJIQ8UNsVGO3qnP9pkZpxuMu9g9ZRyWeVCl7nnxiXp3r7719S52288Npu/Y+
 NW++NgVZcqZmS7sg9VVvV2ke3ZQ0lvtGKkFddVADrdouQeFYZFFVeNEvl09XeA5PAXD/S9GY56m
 lgZBnn7JywXB6WGHMRDZaC/nZlRorP5To+MADb
X-Received: by 2002:a5d:5149:0:b0:33d:6554:e1f9 with SMTP id
 u9-20020a5d5149000000b0033d6554e1f9mr1418137wrt.50.1708692274641; 
 Fri, 23 Feb 2024 04:44:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMqhEWqMsdXAlAhQ4efGPGxJ4VMWHCJq5ogZrMg9ssUoCgOmhZT18pBKI0CKyzNNPkYOvl2A==
X-Received: by 2002:a5d:5149:0:b0:33d:6554:e1f9 with SMTP id
 u9-20020a5d5149000000b0033d6554e1f9mr1418120wrt.50.1708692274276; 
 Fri, 23 Feb 2024 04:44:34 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 m4-20020a5d6a04000000b0033ae7d768b2sm2624792wru.117.2024.02.23.04.44.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 04:44:32 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	balaton@eik.bme.hu
Subject: [PATCH 09/10] usb: extract sysbus-ohci to a separate file
Date: Fri, 23 Feb 2024 13:44:05 +0100
Message-ID: <20240223124406.234509-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240223124406.234509-1-pbonzini@redhat.com>
References: <20240223124406.234509-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Split the sysbus version to a separate file so that it is not
included in PCI-only machines, and adjust Kconfig for machines
that do need sysbus-ohci.  The copyrights are based on the
time and employer of balrog and Paul Brook's contributions.

While adjusting the SM501 dependency, move it to the right place
instead of keeping it in the R4D machine.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/usb/hcd-ohci-sysbus.c | 91 ++++++++++++++++++++++++++++++++++++++++
 hw/usb/hcd-ohci.c        | 58 ------------------------
 hw/arm/Kconfig           | 12 +++--
 hw/display/Kconfig       |  1 +
 hw/ppc/Kconfig           |  2 +-
 hw/sh4/Kconfig           |  1 -
 hw/usb/Kconfig           |  4 ++
 hw/usb/meson.build       |  1 +
 8 files changed, 105 insertions(+), 65 deletions(-)
 create mode 100644 hw/usb/hcd-ohci-sysbus.c

diff --git a/hw/usb/hcd-ohci-sysbus.c b/hw/usb/hcd-ohci-sysbus.c
new file mode 100644
index 00000000000..4e4481232b6
--- /dev/null
+++ b/hw/usb/hcd-ohci-sysbus.c
@@ -0,0 +1,91 @@
+/*
+ * QEMU USB OHCI Emulation
+ * Copyright (c) 2006 Openedhand Ltd.
+ * Copyright (c) 2010 CodeSourcery
+ * Copyright (c) 2024 Red Hat, Inc.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/irq.h"
+#include "qapi/error.h"
+#include "qemu/module.h"
+#include "qemu/timer.h"
+#include "hw/usb.h"
+#include "migration/vmstate.h"
+#include "hw/sysbus.h"
+#include "hw/qdev-dma.h"
+#include "hw/qdev-properties.h"
+#include "trace.h"
+#include "hcd-ohci.h"
+
+
+static void ohci_realize_pxa(DeviceState *dev, Error **errp)
+{
+    OHCISysBusState *s = SYSBUS_OHCI(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    Error *err = NULL;
+
+    usb_ohci_init(&s->ohci, dev, s->num_ports, s->dma_offset,
+                  s->masterbus, s->firstport,
+                  &address_space_memory, ohci_sysbus_die, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    sysbus_init_irq(sbd, &s->ohci.irq);
+    sysbus_init_mmio(sbd, &s->ohci.mem);
+}
+
+static void usb_ohci_reset_sysbus(DeviceState *dev)
+{
+    OHCISysBusState *s = SYSBUS_OHCI(dev);
+    OHCIState *ohci = &s->ohci;
+
+    ohci_hard_reset(ohci);
+}
+
+static Property ohci_sysbus_properties[] = {
+    DEFINE_PROP_STRING("masterbus", OHCISysBusState, masterbus),
+    DEFINE_PROP_UINT32("num-ports", OHCISysBusState, num_ports, 3),
+    DEFINE_PROP_UINT32("firstport", OHCISysBusState, firstport, 0),
+    DEFINE_PROP_DMAADDR("dma-offset", OHCISysBusState, dma_offset, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void ohci_sysbus_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = ohci_realize_pxa;
+    set_bit(DEVICE_CATEGORY_USB, dc->categories);
+    dc->desc = "OHCI USB Controller";
+    device_class_set_props(dc, ohci_sysbus_properties);
+    dc->reset = usb_ohci_reset_sysbus;
+}
+
+static const TypeInfo ohci_sysbus_info = {
+    .name          = TYPE_SYSBUS_OHCI,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(OHCISysBusState),
+    .class_init    = ohci_sysbus_class_init,
+};
+
+static void ohci_register_types(void)
+{
+    type_register_static(&ohci_sysbus_info);
+}
+
+type_init(ohci_register_types)
diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index d73b53f33c8..fc8fc91a1d1 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -1955,31 +1955,6 @@ void ohci_sysbus_die(struct OHCIState *ohci)
     ohci_bus_stop(ohci);
 }
 
-static void ohci_realize_pxa(DeviceState *dev, Error **errp)
-{
-    OHCISysBusState *s = SYSBUS_OHCI(dev);
-    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
-    Error *err = NULL;
-
-    usb_ohci_init(&s->ohci, dev, s->num_ports, s->dma_offset,
-                  s->masterbus, s->firstport,
-                  &address_space_memory, ohci_sysbus_die, &err);
-    if (err) {
-        error_propagate(errp, err);
-        return;
-    }
-    sysbus_init_irq(sbd, &s->ohci.irq);
-    sysbus_init_mmio(sbd, &s->ohci.mem);
-}
-
-static void usb_ohci_reset_sysbus(DeviceState *dev)
-{
-    OHCISysBusState *s = SYSBUS_OHCI(dev);
-    OHCIState *ohci = &s->ohci;
-
-    ohci_hard_reset(ohci);
-}
-
 static const VMStateDescription vmstate_ohci_state_port = {
     .name = "ohci-core/port",
     .version_id = 1,
@@ -2054,36 +2029,3 @@ const VMStateDescription vmstate_ohci_state = {
         NULL
     }
 };
-
-static Property ohci_sysbus_properties[] = {
-    DEFINE_PROP_STRING("masterbus", OHCISysBusState, masterbus),
-    DEFINE_PROP_UINT32("num-ports", OHCISysBusState, num_ports, 3),
-    DEFINE_PROP_UINT32("firstport", OHCISysBusState, firstport, 0),
-    DEFINE_PROP_DMAADDR("dma-offset", OHCISysBusState, dma_offset, 0),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void ohci_sysbus_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    dc->realize = ohci_realize_pxa;
-    set_bit(DEVICE_CATEGORY_USB, dc->categories);
-    dc->desc = "OHCI USB Controller";
-    device_class_set_props(dc, ohci_sysbus_properties);
-    dc->reset = usb_ohci_reset_sysbus;
-}
-
-static const TypeInfo ohci_sysbus_info = {
-    .name          = TYPE_SYSBUS_OHCI,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(OHCISysBusState),
-    .class_init    = ohci_sysbus_class_init,
-};
-
-static void ohci_register_types(void)
-{
-    type_register_static(&ohci_sysbus_info);
-}
-
-type_init(ohci_register_types)
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 29abe1da29c..ffb9041b07f 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -185,7 +185,7 @@ config PXA2XX
     select SERIAL
     select SD
     select SSI
-    select USB_OHCI
+    select USB_OHCI_SYSBUS
     select PCMCIA
 
 config GUMSTIX
@@ -256,7 +256,7 @@ config REALVIEW
     select PL310  # cache controller
     select ARM_SBCON_I2C
     select DS1338 # I2C RTC+NVRAM
-    select USB_OHCI
+    select USB_OHCI_SYSBUS
 
 config SBSA_REF
     bool
@@ -337,7 +337,7 @@ config VERSATILE
     select PL080  # DMA controller
     select PL190  # Vector PIC
     select REALVIEW
-    select USB_OHCI
+    select USB_OHCI_SYSBUS
 
 config VEXPRESS
     bool
@@ -393,6 +393,7 @@ config ALLWINNER_A10
     select AXP2XX_PMU
     select SERIAL
     select UNIMP
+    select USB_OHCI_SYSBUS
 
 config ALLWINNER_H3
     bool
@@ -406,7 +407,7 @@ config ALLWINNER_H3
     select ARM_TIMER
     select ARM_GIC
     select UNIMP
-    select USB_OHCI
+    select USB_OHCI_SYSBUS
     select USB_EHCI_SYSBUS
     select SD
 
@@ -422,7 +423,7 @@ config ALLWINNER_R40
     select ARM_TIMER
     select ARM_GIC
     select UNIMP
-    select USB_OHCI
+    select USB_OHCI_SYSBUS
     select USB_EHCI_SYSBUS
     select SD
 
@@ -528,6 +529,7 @@ config NPCM7XX
     select SSI
     select UNIMP
     select PCA954X
+    select USB_OHCI_SYSBUS
 
 config FSL_IMX25
     bool
diff --git a/hw/display/Kconfig b/hw/display/Kconfig
index 1aafe1923d2..07acb37dc66 100644
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -77,6 +77,7 @@ config SM501
     select I2C
     select DDC
     select SERIAL
+    select USB_OHCI_SYSBUS
 
 config TCX
     bool
diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index d497fa2b825..d49e7847909 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -67,7 +67,7 @@ config SAM460EX
     select SM501
     select SMBUS_EEPROM
     select USB_EHCI_SYSBUS
-    select USB_OHCI
+    select USB_OHCI_SYSBUS
     select FDT_PPC
 
 config AMIGAONE
diff --git a/hw/sh4/Kconfig b/hw/sh4/Kconfig
index ab733a3f760..e0c4ecd1a53 100644
--- a/hw/sh4/Kconfig
+++ b/hw/sh4/Kconfig
@@ -6,7 +6,6 @@ config R2D
     select I82378 if TEST_DEVICES
     select IDE_MMIO
     select PFLASH_CFI02
-    select USB_OHCI_PCI
     select PCI
     select SM501
     select SH7750
diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index 0f486764ed6..f569ed7eeaa 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -11,6 +11,10 @@ config USB_OHCI
     bool
     select USB
 
+config USB_OHCI_SYSBUS
+    bool
+    select USB_OHCI
+
 config USB_OHCI_PCI
     bool
     default y if PCI_DEVICES
diff --git a/hw/usb/meson.build b/hw/usb/meson.build
index 2c13c528785..94f0e3b034d 100644
--- a/hw/usb/meson.build
+++ b/hw/usb/meson.build
@@ -15,6 +15,7 @@ system_ss.add(when: 'CONFIG_USB', if_true: files(
 system_ss.add(when: 'CONFIG_USB_UHCI', if_true: files('hcd-uhci.c'))
 system_ss.add(when: 'CONFIG_USB_OHCI', if_true: files('hcd-ohci.c'))
 system_ss.add(when: 'CONFIG_USB_OHCI_PCI', if_true: files('hcd-ohci-pci.c'))
+system_ss.add(when: 'CONFIG_USB_OHCI_SYSBUS', if_true: files('hcd-ohci-sysbus.c'))
 system_ss.add(when: 'CONFIG_USB_EHCI', if_true: files('hcd-ehci.c'))
 system_ss.add(when: 'CONFIG_USB_EHCI_PCI', if_true: files('hcd-ehci-pci.c'))
 system_ss.add(when: 'CONFIG_USB_EHCI_SYSBUS', if_true: files('hcd-ehci.c', 'hcd-ehci-sysbus.c'))
-- 
2.43.0


