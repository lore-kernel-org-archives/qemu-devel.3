Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D423CE7B02
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 12:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smY2f-00021U-On; Fri, 06 Sep 2024 08:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1smY2I-0000jD-I9; Fri, 06 Sep 2024 08:25:59 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1smY2E-00023C-BU; Fri, 06 Sep 2024 08:25:58 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5e1b35030aeso84132eaf.3; 
 Fri, 06 Sep 2024 05:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725625552; x=1726230352; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EnnupCvhQ8KE0wwFyPh0tSJOdtMBtiG9kjDtVdWQvl4=;
 b=Sc21bxXh6bu414VUjzerh4EJqRYlZJCuHEiIhB4qQaOgEIRkar/IcpajabXE0abtNH
 07EvXxGv/XfE2fDTPjRqEsncWDefz8wyBEf0tp4dXGXPYZSKM37wJiBwumCs3fAmltEv
 ImzqkqKfYphN1pCGW37KbJbcb3RqZhPxscwxL3a4lCxT3K5sPubHV5QaKsBvJJ/uB18A
 X9OOmZ9cxfqGQYL09i9mQ+1VeuYKOR5LYUzSOTJw+ZNE72w8aJC+Ed0xFQyTifNVn+Ah
 4bg+PxU85II2xf4tYG920PbXX3Z+tTyNrkfUqfTYGlOjW3eb3m0BqZCM/UbVuxDy28sD
 7HLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725625552; x=1726230352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EnnupCvhQ8KE0wwFyPh0tSJOdtMBtiG9kjDtVdWQvl4=;
 b=L/6rZZ+pbDcONHYY/eLx3oGx1ITfoNdM3/2YX4ahJGrA5a/DT7Fo+6In6PzyMN3XUl
 Ar/9O3uihWhMwwpe/pJhZRu4/BaEihhESw+865nBJzaGFwyVGqN6VyF01WQhnitW5Ycf
 BNtcylzdYxPS+UKW0Z6fuKIe70TklD1TONKDfwjvhaX5gCkAc6F3J0KQsA2xD29bK9Nx
 YFL9nTFBunRXRi5yzSh/zEHprTSAJVk4zdXnCrfIPzSc/rg+m2n5EDTE/et2XsLGvzvu
 IElYoAnN3HsT/kadWuuhCzjOC92K5MYzelP+kwMoQLI6cNFCNjMiNGoZgjX/TZz7Bv6K
 f7bA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtRHGfCSJ92lymrFy9lTQ2cE7U5KsbTted98VfIyCBW52++tfDENy4x/2YMF2f0yQXmVZL/NfUhA==@nongnu.org
X-Gm-Message-State: AOJu0YwIW3O9MpygJSaboq3IIM0LB8fUUtuhKZ5c6/vDPdh5SIJIp2ui
 xYv7FziSV9K6/DS0LW4C0Pe6FE5r/6DjpOyUqGT1QVq6qlyU3DhRXvj89Q==
X-Google-Smtp-Source: AGHT+IFnG1xjoozb0cN/esVgeRxdHOmzVfnOhIbnngZqO4oqsc2rR7MfbkAJ8FW2/c54YPYR0NdDTQ==
X-Received: by 2002:a05:6870:4192:b0:254:7f9f:3f21 with SMTP id
 586e51a60fabf-27b82eaa432mr2637243fac.27.1725625551924; 
 Fri, 06 Sep 2024 05:25:51 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-718dd273d77sm575408b3a.95.2024.09.06.05.25.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 05:25:51 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, BALATON Zoltan <balaton@eik.bme.hu>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH 3/8] usb/uhci: Move PCI-related code into a separate file
Date: Fri,  6 Sep 2024 05:25:37 -0700
Message-ID: <20240906122542.3808997-4-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240906122542.3808997-1-linux@roeck-us.net>
References: <20240906122542.3808997-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=groeck7@gmail.com; helo=mail-oo1-xc2a.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Some machines (like Aspeed ARM) only have a sysbus UHCI controller.
The current UHCI implementation only supports PCI based UHCI controllers.
Move the UHCI-PCI device code into a separate file so that it is possible
to create a sysbus UHCI device without PCI dependency.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/isa/Kconfig                |   4 +-
 hw/isa/vt82c686.c             |   4 +-
 hw/usb/Kconfig                |   6 +-
 hw/usb/hcd-uhci-pci.c         | 255 ++++++++++++++++++++++++++++++++++
 hw/usb/hcd-uhci-pci.h         |  63 +++++++++
 hw/usb/hcd-uhci.c             | 221 +++++------------------------
 hw/usb/hcd-uhci.h             |  30 ++--
 hw/usb/meson.build            |   1 +
 hw/usb/vt82c686-uhci-pci.c    |  18 +--
 include/hw/southbridge/piix.h |   4 +-
 10 files changed, 386 insertions(+), 220 deletions(-)
 create mode 100644 hw/usb/hcd-uhci-pci.c
 create mode 100644 hw/usb/hcd-uhci-pci.h

diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
index 73c6470805..b0e536fad9 100644
--- a/hw/isa/Kconfig
+++ b/hw/isa/Kconfig
@@ -47,7 +47,7 @@ config PIIX
     select IDE_PIIX
     select ISA_BUS
     select MC146818RTC
-    select USB_UHCI
+    select USB_UHCI_PCI
 
 config VT82C686
     bool
@@ -55,7 +55,7 @@ config VT82C686
     select ISA_SUPERIO
     select ACPI
     select ACPI_SMBUS
-    select USB_UHCI
+    select USB_UHCI_PCI
     select APM
     select I8254
     select I8257
diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 505b44c4e6..de317b11cb 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -26,7 +26,7 @@
 #include "hw/intc/i8259.h"
 #include "hw/irq.h"
 #include "hw/dma/i8257.h"
-#include "hw/usb/hcd-uhci.h"
+#include "hw/usb/hcd-uhci-pci.h"
 #include "hw/timer/i8254.h"
 #include "hw/rtc/mc146818rtc.h"
 #include "migration/vmstate.h"
@@ -598,7 +598,7 @@ struct ViaISAState {
     ViaSuperIOState via_sio;
     MC146818RtcState rtc;
     PCIIDEState ide;
-    UHCIState uhci[2];
+    UHCIPCIState uhci[2];
     ViaPMState pm;
     ViaAC97State ac97;
     PCIDevice mc97;
diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index 84bc7fbe36..7d034738ce 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -2,10 +2,14 @@ config USB
     bool
 
 config USB_UHCI
+    bool
+    select USB
+
+config USB_UHCI_PCI
     bool
     default y if PCI_DEVICES
     depends on PCI
-    select USB
+    select USB_UHCI
 
 config USB_OHCI
     bool
diff --git a/hw/usb/hcd-uhci-pci.c b/hw/usb/hcd-uhci-pci.c
new file mode 100644
index 0000000000..4036fe9c27
--- /dev/null
+++ b/hw/usb/hcd-uhci-pci.c
@@ -0,0 +1,255 @@
+/*
+ * USB UHCI controller emulation
+ * PCI code
+ *
+ * Copyright (c) 2005 Fabrice Bellard
+ *
+ * Copyright (c) 2008 Max Krasnyansky
+ *     Magor rewrite of the UHCI data structures parser and frame processor
+ *     Support for fully async operation and multiple outstanding transactions
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/irq.h"
+#include "hw/usb.h"
+#include "migration/vmstate.h"
+#include "hw/pci/pci.h"
+#include "hw/qdev-properties.h"
+#include "qapi/error.h"
+#include "qemu/main-loop.h"
+#include "qemu/module.h"
+#include "qom/object.h"
+#include "hcd-uhci-pci.h"
+
+struct UHCIPCIDeviceClass {
+    PCIDeviceClass parent_class;
+    UHCIPCIInfo info;
+};
+
+static const VMStateDescription vmstate_uhci = {
+    .name = "pci_uhci",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_PCI_DEVICE(dev, UHCIPCIState),
+        VMSTATE_STRUCT(state, UHCIPCIState, 1, vmstate_uhci_state, UHCIState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void uhci_pci_reset(UHCIState *uhci)
+{
+    UHCIPCIState *pstate = container_of(uhci, UHCIPCIState, state);
+    PCIDevice *d = &pstate->dev;
+
+    d->config[0x6a] = 0x01; /* usb clock */
+    d->config[0x6b] = 0x00;
+
+    uhci_state_reset(uhci);
+}
+
+void usb_uhci_common_realize_pci(PCIDevice *dev, Error **errp)
+{
+    Error *err = NULL;
+    UHCIPCIDeviceClass *u = UHCI_PCI_GET_CLASS(dev);
+    UHCIPCIState *uhci = UHCI_PCI(dev);
+    UHCIState *s = &uhci->state;
+    uint8_t *pci_conf = dev->config;
+
+    pci_conf[PCI_CLASS_PROG] = 0x00;
+    /* TODO: reset value should be 0. */
+    pci_conf[USB_SBRN] = USB_RELEASE_1; /* release number */
+    pci_config_set_interrupt_pin(pci_conf, u->info.irq_pin + 1);
+
+    s->irq = pci_allocate_irq(dev);
+    s->masterbus = uhci->masterbus;
+    s->firstport = uhci->firstport;
+    s->maxframes = uhci->maxframes;
+    s->frame_bandwidth = uhci->frame_bandwidth;
+    s->as = pci_get_address_space(dev);
+    s->uhci_reset = uhci_pci_reset;
+
+    usb_uhci_init(s, DEVICE(dev), &err);
+
+    /*
+     * Use region 4 for consistency with real hardware.  BSD guests seem
+     * to rely on this.
+     */
+    pci_register_bar(dev, 4, PCI_BASE_ADDRESS_SPACE_IO, &s->mem);
+}
+
+static void uhci_pci_reset_pci(DeviceState *dev)
+{
+    PCIDevice *d = PCI_DEVICE(dev);
+    UHCIPCIState *uhci = UHCI_PCI(d);
+
+    uhci_pci_reset(&uhci->state);
+}
+
+static void usb_uhci_pci_exit(PCIDevice *dev)
+{
+    UHCIPCIState *uhci = UHCI_PCI(dev);
+    UHCIState *s = &uhci->state;
+
+    usb_uhci_exit(s);
+
+    qemu_free_irq(s->irq);
+}
+
+static Property uhci_properties_companion[] = {
+    DEFINE_PROP_STRING("masterbus", UHCIPCIState, masterbus),
+    DEFINE_PROP_UINT32("firstport", UHCIPCIState, firstport, 0),
+    DEFINE_PROP_UINT32("bandwidth", UHCIPCIState, frame_bandwidth, 1280),
+    DEFINE_PROP_UINT32("maxframes", UHCIPCIState, maxframes, 128),
+    DEFINE_PROP_END_OF_LIST(),
+};
+static Property uhci_properties_standalone[] = {
+    DEFINE_PROP_UINT32("bandwidth", UHCIPCIState, frame_bandwidth, 1280),
+    DEFINE_PROP_UINT32("maxframes", UHCIPCIState, maxframes, 128),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void uhci_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+
+    k->class_id  = PCI_CLASS_SERIAL_USB;
+    dc->vmsd = &vmstate_uhci;
+    dc->reset = uhci_pci_reset_pci;
+    set_bit(DEVICE_CATEGORY_USB, dc->categories);
+}
+
+static const TypeInfo uhci_pci_type_info = {
+    .name = TYPE_UHCI_PCI,
+    .parent = TYPE_PCI_DEVICE,
+    .instance_size = sizeof(UHCIPCIState),
+    .class_size    = sizeof(UHCIPCIDeviceClass),
+    .class_init    = uhci_pci_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
+};
+
+void uhci_pci_data_class_init(ObjectClass *klass, void *data)
+{
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    UHCIPCIDeviceClass *u = UHCI_PCI_CLASS(klass);
+    UHCIPCIInfo *info = data;
+
+    k->realize = info->realize ? info->realize : usb_uhci_common_realize_pci;
+    k->exit = info->unplug ? usb_uhci_pci_exit : NULL;
+    k->vendor_id = info->vendor_id;
+    k->device_id = info->device_id;
+    k->revision  = info->revision;
+    if (!info->unplug) {
+        /* uhci controllers in companion setups can't be hotplugged */
+        dc->hotpluggable = false;
+        device_class_set_props(dc, uhci_properties_companion);
+    } else {
+        device_class_set_props(dc, uhci_properties_standalone);
+    }
+    if (info->notuser) {
+        dc->user_creatable = false;
+    }
+    u->info = *info;
+}
+
+static UHCIPCIInfo uhci_pci_info[] = {
+    {
+        .name      = TYPE_PIIX3_USB_UHCI,
+        .vendor_id = PCI_VENDOR_ID_INTEL,
+        .device_id = PCI_DEVICE_ID_INTEL_82371SB_2,
+        .revision  = 0x01,
+        .irq_pin   = 3,
+        .unplug    = true,
+    },{
+        .name      = TYPE_PIIX4_USB_UHCI,
+        .vendor_id = PCI_VENDOR_ID_INTEL,
+        .device_id = PCI_DEVICE_ID_INTEL_82371AB_2,
+        .revision  = 0x01,
+        .irq_pin   = 3,
+        .unplug    = true,
+    },{
+        .name      = TYPE_ICH9_USB_UHCI(1), /* 00:1d.0 */
+        .vendor_id = PCI_VENDOR_ID_INTEL,
+        .device_id = PCI_DEVICE_ID_INTEL_82801I_UHCI1,
+        .revision  = 0x03,
+        .irq_pin   = 0,
+        .unplug    = false,
+    },{
+        .name      = TYPE_ICH9_USB_UHCI(2), /* 00:1d.1 */
+        .vendor_id = PCI_VENDOR_ID_INTEL,
+        .device_id = PCI_DEVICE_ID_INTEL_82801I_UHCI2,
+        .revision  = 0x03,
+        .irq_pin   = 1,
+        .unplug    = false,
+    },{
+        .name      = TYPE_ICH9_USB_UHCI(3), /* 00:1d.2 */
+        .vendor_id = PCI_VENDOR_ID_INTEL,
+        .device_id = PCI_DEVICE_ID_INTEL_82801I_UHCI3,
+        .revision  = 0x03,
+        .irq_pin   = 2,
+        .unplug    = false,
+    },{
+        .name      = TYPE_ICH9_USB_UHCI(4), /* 00:1a.0 */
+        .vendor_id = PCI_VENDOR_ID_INTEL,
+        .device_id = PCI_DEVICE_ID_INTEL_82801I_UHCI4,
+        .revision  = 0x03,
+        .irq_pin   = 0,
+        .unplug    = false,
+    },{
+        .name      = TYPE_ICH9_USB_UHCI(5), /* 00:1a.1 */
+        .vendor_id = PCI_VENDOR_ID_INTEL,
+        .device_id = PCI_DEVICE_ID_INTEL_82801I_UHCI5,
+        .revision  = 0x03,
+        .irq_pin   = 1,
+        .unplug    = false,
+    },{
+        .name      = TYPE_ICH9_USB_UHCI(6), /* 00:1a.2 */
+        .vendor_id = PCI_VENDOR_ID_INTEL,
+        .device_id = PCI_DEVICE_ID_INTEL_82801I_UHCI6,
+        .revision  = 0x03,
+        .irq_pin   = 2,
+        .unplug    = false,
+    }
+};
+
+static void uhci_pci_register_types(void)
+{
+    TypeInfo type_info = {
+        .parent        = TYPE_UHCI_PCI,
+        .class_init    = uhci_pci_data_class_init,
+    };
+    int i;
+
+    type_register_static(&uhci_pci_type_info);
+
+    for (i = 0; i < ARRAY_SIZE(uhci_pci_info); i++) {
+        type_info.name = uhci_pci_info[i].name;
+        type_info.class_data = uhci_pci_info + i;
+        type_register(&type_info);
+    }
+}
+
+type_init(uhci_pci_register_types)
diff --git a/hw/usb/hcd-uhci-pci.h b/hw/usb/hcd-uhci-pci.h
new file mode 100644
index 0000000000..25d3e0eb97
--- /dev/null
+++ b/hw/usb/hcd-uhci-pci.h
@@ -0,0 +1,63 @@
+/*
+ * USB UHCI controller emulation
+ *
+ * Copyright (c) 2005 Fabrice Bellard
+ *
+ * Copyright (c) 2008 Max Krasnyansky
+ *     Magor rewrite of the UHCI data structures parser and frame processor
+ *     Support for fully async operation and multiple outstanding transactions
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+#ifndef HW_USB_HCD_UHCI_PCI_H
+#define HW_USB_HCD_UHCI_PCI_H
+
+#include "hcd-uhci.h"
+
+#define TYPE_UHCI_PCI "pci-uhci"
+
+struct UHCIPCIState {
+    PCIDevice dev;
+    UHCIState state;
+
+    /* Properties */
+    char *masterbus;
+    uint32_t firstport;
+    uint32_t frame_bandwidth;
+    uint32_t maxframes;
+    uint32_t num_ports;
+};
+
+OBJECT_DECLARE_TYPE(UHCIPCIState, UHCIPCIDeviceClass, UHCI_PCI)
+
+typedef struct UHCIPCIInfo {
+    const char *name;
+    uint16_t   vendor_id;
+    uint16_t   device_id;
+    uint8_t    revision;
+    uint8_t    irq_pin;
+    void       (*realize)(PCIDevice *dev, Error **errp);
+    bool       unplug;
+    bool       notuser; /* disallow user_creatable */
+} UHCIPCIInfo;
+
+void usb_uhci_common_realize_pci(PCIDevice *dev, Error **errp);
+void uhci_pci_data_class_init(ObjectClass *klass, void *data);
+
+#endif /* HW_USB_HCD_UHCI_PCI_H */
diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
index 8bc163f688..68b72f8d3b 100644
--- a/hw/usb/hcd-uhci.c
+++ b/hw/usb/hcd-uhci.c
@@ -30,7 +30,6 @@
 #include "hw/usb.h"
 #include "hw/usb/uhci-regs.h"
 #include "migration/vmstate.h"
-#include "hw/pci/pci.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
@@ -62,11 +61,6 @@ enum {
 
 typedef struct UHCIAsync UHCIAsync;
 
-struct UHCIPCIDeviceClass {
-    PCIDeviceClass parent_class;
-    UHCIInfo       info;
-};
-
 /*
  * Pending async transaction.
  * 'packet' must be the first field because completion
@@ -302,20 +296,13 @@ static void uhci_update_irq(UHCIState *s)
     qemu_set_irq(s->irq, level);
 }
 
-static void uhci_reset(DeviceState *dev)
+void uhci_state_reset(UHCIState *s)
 {
-    PCIDevice *d = PCI_DEVICE(dev);
-    UHCIState *s = UHCI(d);
-    uint8_t *pci_conf;
     int i;
     UHCIPort *port;
 
     trace_usb_uhci_reset();
 
-    pci_conf = s->dev.config;
-
-    pci_conf[0x6a] = 0x01; /* usb clock */
-    pci_conf[0x6b] = 0x00;
     s->cmd = 0;
     s->status = UHCI_STS_HCHALTED;
     s->status2 = 0;
@@ -336,6 +323,11 @@ static void uhci_reset(DeviceState *dev)
     uhci_update_irq(s);
 }
 
+static void uhci_reset(UHCIState *s)
+{
+        s->uhci_reset(s);
+}
+
 static const VMStateDescription vmstate_uhci_port = {
     .name = "uhci port",
     .version_id = 1,
@@ -357,13 +349,12 @@ static int uhci_post_load(void *opaque, int version_id)
     return 0;
 }
 
-static const VMStateDescription vmstate_uhci = {
+const VMStateDescription vmstate_uhci_state = {
     .name = "uhci",
-    .version_id = 3,
+    .version_id = 4,
     .minimum_version_id = 1,
     .post_load = uhci_post_load,
     .fields = (const VMStateField[]) {
-        VMSTATE_PCI_DEVICE(dev, UHCIState),
         VMSTATE_UINT8_EQUAL(num_ports_vmstate, UHCIState, NULL),
         VMSTATE_STRUCT_ARRAY(ports, UHCIState, UHCI_PORTS, 1,
                              vmstate_uhci_port, UHCIPort),
@@ -409,11 +400,11 @@ static void uhci_port_write(void *opaque, hwaddr addr,
                 port = &s->ports[i];
                 usb_device_reset(port->port.dev);
             }
-            uhci_reset(DEVICE(s));
+            uhci_reset(s);
             return;
         }
         if (val & UHCI_CMD_HCRESET) {
-            uhci_reset(DEVICE(s));
+            uhci_reset(s);
             return;
         }
         s->cmd = val;
@@ -628,9 +619,21 @@ static USBDevice *uhci_find_device(UHCIState *s, uint8_t addr)
     return NULL;
 }
 
+static void uhci_dma_read(UHCIState *s, dma_addr_t addr, void *buf,
+                          dma_addr_t len)
+{
+        dma_memory_read(s->as, addr, buf, len, MEMTXATTRS_UNSPECIFIED);
+}
+
+static void uhci_dma_write(UHCIState *s, dma_addr_t addr, void *buf,
+                           dma_addr_t len)
+{
+        dma_memory_write(s->as, addr, buf, len, MEMTXATTRS_UNSPECIFIED);
+}
+
 static void uhci_read_td(UHCIState *s, UHCI_TD *td, uint32_t link)
 {
-    pci_dma_read(&s->dev, link & ~0xf, td, sizeof(*td));
+    uhci_dma_read(s, link & ~0xf, td, sizeof(*td));
     le32_to_cpus(&td->link);
     le32_to_cpus(&td->ctrl);
     le32_to_cpus(&td->token);
@@ -712,7 +715,7 @@ static int uhci_complete_td(UHCIState *s, UHCI_TD *td, UHCIAsync *async,
     }
 
     if (pid == USB_TOKEN_IN) {
-        pci_dma_write(&s->dev, td->buffer, async->buf, len);
+        uhci_dma_write(s, td->buffer, async->buf, len);
         if ((td->ctrl & TD_CTRL_SPD) && len < max_len) {
             *int_mask |= 0x02;
             /* short packet: do not update QH */
@@ -848,7 +851,7 @@ static int uhci_handle_td(UHCIState *s, UHCIQueue *q, uint32_t qh_addr,
     switch (pid) {
     case USB_TOKEN_OUT:
     case USB_TOKEN_SETUP:
-        pci_dma_read(&s->dev, td->buffer, async->buf, max_len);
+        uhci_dma_read(s, td->buffer, async->buf, max_len);
         usb_handle_packet(q->ep->dev, &async->packet);
         if (async->packet.status == USB_RET_SUCCESS) {
             async->packet.actual_length = max_len;
@@ -976,7 +979,7 @@ static void uhci_process_frame(UHCIState *s)
 
     frame_addr = s->fl_base_addr + ((s->frnum & 0x3ff) << 2);
 
-    pci_dma_read(&s->dev, frame_addr, &link, 4);
+    uhci_dma_read(s, frame_addr, &link, 4);
     le32_to_cpus(&link);
 
     int_mask = 0;
@@ -1016,7 +1019,7 @@ static void uhci_process_frame(UHCIState *s)
                 }
             }
 
-            pci_dma_read(&s->dev, link & ~0xf, &qh, sizeof(qh));
+            uhci_dma_read(s, link & ~0xf, &qh, sizeof(qh));
             le32_to_cpus(&qh.link);
             le32_to_cpus(&qh.el_link);
 
@@ -1041,7 +1044,7 @@ static void uhci_process_frame(UHCIState *s)
         if (old_td_ctrl != td.ctrl) {
             /* update the status bits of the TD */
             val = cpu_to_le32(td.ctrl);
-            pci_dma_write(&s->dev, (link & ~0xf) + 4, &val, sizeof(val));
+            uhci_dma_write(s, (link & ~0xf) + 4, &val, sizeof(val));
         }
 
         switch (ret) {
@@ -1069,7 +1072,7 @@ static void uhci_process_frame(UHCIState *s)
                 /* update QH element link */
                 qh.el_link = link;
                 val = cpu_to_le32(qh.el_link);
-                pci_dma_write(&s->dev, (curr_qh & ~0xf) + 4, &val, sizeof(val));
+                uhci_dma_write(s, (curr_qh & ~0xf) + 4, &val, sizeof(val));
 
                 if (!depth_first(link)) {
                     /* done with this QH */
@@ -1178,20 +1181,11 @@ static USBPortOps uhci_port_ops = {
 static USBBusOps uhci_bus_ops = {
 };
 
-void usb_uhci_common_realize(PCIDevice *dev, Error **errp)
+void usb_uhci_init(UHCIState *s, DeviceState *dev, Error **errp)
 {
     Error *err = NULL;
-    UHCIPCIDeviceClass *u = UHCI_GET_CLASS(dev);
-    UHCIState *s = UHCI(dev);
-    uint8_t *pci_conf = s->dev.config;
     int i;
 
-    pci_conf[PCI_CLASS_PROG] = 0x00;
-    /* TODO: reset value should be 0. */
-    pci_conf[USB_SBRN] = USB_RELEASE_1; /* release number */
-    pci_config_set_interrupt_pin(pci_conf, u->info.irq_pin + 1);
-    s->irq = pci_allocate_irq(dev);
-
     if (s->masterbus) {
         USBPort *ports[UHCI_PORTS];
         for (i = 0; i < UHCI_PORTS; i++) {
@@ -1212,25 +1206,17 @@ void usb_uhci_common_realize(PCIDevice *dev, Error **errp)
                               USB_SPEED_MASK_LOW | USB_SPEED_MASK_FULL);
         }
     }
-    s->bh = qemu_bh_new_guarded(uhci_bh, s, &DEVICE(dev)->mem_reentrancy_guard);
+    s->bh = qemu_bh_new_guarded(uhci_bh, s, &dev->mem_reentrancy_guard);
     s->frame_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, uhci_frame_timer, s);
     s->num_ports_vmstate = UHCI_PORTS;
     QTAILQ_INIT(&s->queues);
 
-    memory_region_init_io(&s->io_bar, OBJECT(s), &uhci_ioport_ops, s,
+    memory_region_init_io(&s->mem, OBJECT(s), &uhci_ioport_ops, s,
                           "uhci", 0x20);
-
-    /*
-     * Use region 4 for consistency with real hardware.  BSD guests seem
-     * to rely on this.
-     */
-    pci_register_bar(&s->dev, 4, PCI_BASE_ADDRESS_SPACE_IO, &s->io_bar);
 }
 
-static void usb_uhci_exit(PCIDevice *dev)
+void usb_uhci_exit(UHCIState *s)
 {
-    UHCIState *s = UHCI(dev);
-
     trace_usb_uhci_exit();
 
     if (s->frame_timer) {
@@ -1248,144 +1234,3 @@ static void usb_uhci_exit(PCIDevice *dev)
         usb_bus_release(&s->bus);
     }
 }
-
-static Property uhci_properties_companion[] = {
-    DEFINE_PROP_STRING("masterbus", UHCIState, masterbus),
-    DEFINE_PROP_UINT32("firstport", UHCIState, firstport, 0),
-    DEFINE_PROP_UINT32("bandwidth", UHCIState, frame_bandwidth, 1280),
-    DEFINE_PROP_UINT32("maxframes", UHCIState, maxframes, 128),
-    DEFINE_PROP_END_OF_LIST(),
-};
-static Property uhci_properties_standalone[] = {
-    DEFINE_PROP_UINT32("bandwidth", UHCIState, frame_bandwidth, 1280),
-    DEFINE_PROP_UINT32("maxframes", UHCIState, maxframes, 128),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void uhci_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
-
-    k->class_id  = PCI_CLASS_SERIAL_USB;
-    dc->vmsd = &vmstate_uhci;
-    dc->reset = uhci_reset;
-    set_bit(DEVICE_CATEGORY_USB, dc->categories);
-}
-
-static const TypeInfo uhci_pci_type_info = {
-    .name = TYPE_UHCI,
-    .parent = TYPE_PCI_DEVICE,
-    .instance_size = sizeof(UHCIState),
-    .class_size    = sizeof(UHCIPCIDeviceClass),
-    .abstract = true,
-    .class_init = uhci_class_init,
-    .interfaces = (InterfaceInfo[]) {
-        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
-        { },
-    },
-};
-
-void uhci_data_class_init(ObjectClass *klass, void *data)
-{
-    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    UHCIPCIDeviceClass *u = UHCI_CLASS(klass);
-    UHCIInfo *info = data;
-
-    k->realize = info->realize ? info->realize : usb_uhci_common_realize;
-    k->exit = info->unplug ? usb_uhci_exit : NULL;
-    k->vendor_id = info->vendor_id;
-    k->device_id = info->device_id;
-    k->revision  = info->revision;
-    if (!info->unplug) {
-        /* uhci controllers in companion setups can't be hotplugged */
-        dc->hotpluggable = false;
-        device_class_set_props(dc, uhci_properties_companion);
-    } else {
-        device_class_set_props(dc, uhci_properties_standalone);
-    }
-    if (info->notuser) {
-        dc->user_creatable = false;
-    }
-    u->info = *info;
-}
-
-static UHCIInfo uhci_info[] = {
-    {
-        .name      = TYPE_PIIX3_USB_UHCI,
-        .vendor_id = PCI_VENDOR_ID_INTEL,
-        .device_id = PCI_DEVICE_ID_INTEL_82371SB_2,
-        .revision  = 0x01,
-        .irq_pin   = 3,
-        .unplug    = true,
-    },{
-        .name      = TYPE_PIIX4_USB_UHCI,
-        .vendor_id = PCI_VENDOR_ID_INTEL,
-        .device_id = PCI_DEVICE_ID_INTEL_82371AB_2,
-        .revision  = 0x01,
-        .irq_pin   = 3,
-        .unplug    = true,
-    },{
-        .name      = TYPE_ICH9_USB_UHCI(1), /* 00:1d.0 */
-        .vendor_id = PCI_VENDOR_ID_INTEL,
-        .device_id = PCI_DEVICE_ID_INTEL_82801I_UHCI1,
-        .revision  = 0x03,
-        .irq_pin   = 0,
-        .unplug    = false,
-    },{
-        .name      = TYPE_ICH9_USB_UHCI(2), /* 00:1d.1 */
-        .vendor_id = PCI_VENDOR_ID_INTEL,
-        .device_id = PCI_DEVICE_ID_INTEL_82801I_UHCI2,
-        .revision  = 0x03,
-        .irq_pin   = 1,
-        .unplug    = false,
-    },{
-        .name      = TYPE_ICH9_USB_UHCI(3), /* 00:1d.2 */
-        .vendor_id = PCI_VENDOR_ID_INTEL,
-        .device_id = PCI_DEVICE_ID_INTEL_82801I_UHCI3,
-        .revision  = 0x03,
-        .irq_pin   = 2,
-        .unplug    = false,
-    },{
-        .name      = TYPE_ICH9_USB_UHCI(4), /* 00:1a.0 */
-        .vendor_id = PCI_VENDOR_ID_INTEL,
-        .device_id = PCI_DEVICE_ID_INTEL_82801I_UHCI4,
-        .revision  = 0x03,
-        .irq_pin   = 0,
-        .unplug    = false,
-    },{
-        .name      = TYPE_ICH9_USB_UHCI(5), /* 00:1a.1 */
-        .vendor_id = PCI_VENDOR_ID_INTEL,
-        .device_id = PCI_DEVICE_ID_INTEL_82801I_UHCI5,
-        .revision  = 0x03,
-        .irq_pin   = 1,
-        .unplug    = false,
-    },{
-        .name      = TYPE_ICH9_USB_UHCI(6), /* 00:1a.2 */
-        .vendor_id = PCI_VENDOR_ID_INTEL,
-        .device_id = PCI_DEVICE_ID_INTEL_82801I_UHCI6,
-        .revision  = 0x03,
-        .irq_pin   = 2,
-        .unplug    = false,
-    }
-};
-
-static void uhci_register_types(void)
-{
-    TypeInfo uhci_type_info = {
-        .parent        = TYPE_UHCI,
-        .class_init    = uhci_data_class_init,
-    };
-    int i;
-
-    type_register_static(&uhci_pci_type_info);
-
-    for (i = 0; i < ARRAY_SIZE(uhci_info); i++) {
-        uhci_type_info.name = uhci_info[i].name;
-        uhci_type_info.class_data = uhci_info + i;
-        type_register(&uhci_type_info);
-    }
-}
-
-type_init(uhci_register_types)
diff --git a/hw/usb/hcd-uhci.h b/hw/usb/hcd-uhci.h
index 6d26b94e92..1ffa93f703 100644
--- a/hw/usb/hcd-uhci.h
+++ b/hw/usb/hcd-uhci.h
@@ -32,6 +32,7 @@
 #include "qemu/timer.h"
 #include "hw/pci/pci_device.h"
 #include "hw/usb.h"
+#include "hw/sysbus.h"
 
 typedef struct UHCIQueue UHCIQueue;
 
@@ -42,9 +43,12 @@ typedef struct UHCIPort {
     uint16_t ctrl;
 } UHCIPort;
 
-typedef struct UHCIState {
-    PCIDevice dev;
-    MemoryRegion io_bar;
+typedef struct UHCIState UHCIState;
+
+struct UHCIState {
+    MemoryRegion mem;
+    AddressSpace *as;
+    void (*uhci_reset)(UHCIState *);
     USBBus bus; /* Note unused when we're a companion controller */
     uint16_t cmd; /* cmd register */
     uint16_t status;
@@ -72,24 +76,18 @@ typedef struct UHCIState {
     char *masterbus;
     uint32_t firstport;
     uint32_t maxframes;
-} UHCIState;
+};
 
-#define TYPE_UHCI "pci-uhci-usb"
-OBJECT_DECLARE_TYPE(UHCIState, UHCIPCIDeviceClass, UHCI)
+#define TYPE_UHCI "uhci-usb"
+OBJECT_DECLARE_TYPE(UHCIState, UHCIDeviceClass, UHCI)
 
-typedef struct UHCIInfo {
-    const char *name;
-    uint16_t   vendor_id;
-    uint16_t   device_id;
-    uint8_t    revision;
-    uint8_t    irq_pin;
-    void       (*realize)(PCIDevice *dev, Error **errp);
-    bool       unplug;
-    bool       notuser; /* disallow user_creatable */
-} UHCIInfo;
+extern const VMStateDescription vmstate_uhci_state;
 
 void uhci_data_class_init(ObjectClass *klass, void *data);
 void usb_uhci_common_realize(PCIDevice *dev, Error **errp);
+void usb_uhci_init(UHCIState *s, DeviceState *dev, Error **errp);
+void uhci_state_reset(UHCIState *s);
+void usb_uhci_exit(UHCIState *s);
 
 #define TYPE_PIIX3_USB_UHCI "piix3-usb-uhci"
 #define TYPE_PIIX4_USB_UHCI "piix4-usb-uhci"
diff --git a/hw/usb/meson.build b/hw/usb/meson.build
index d7de1003e3..a41b54ac02 100644
--- a/hw/usb/meson.build
+++ b/hw/usb/meson.build
@@ -13,6 +13,7 @@ system_ss.add(when: 'CONFIG_USB', if_true: files(
 
 # usb host adapters
 system_ss.add(when: 'CONFIG_USB_UHCI', if_true: files('hcd-uhci.c'))
+system_ss.add(when: 'CONFIG_USB_UHCI_PCI', if_true: files('hcd-uhci-pci.c'))
 system_ss.add(when: 'CONFIG_USB_OHCI', if_true: files('hcd-ohci.c'))
 system_ss.add(when: 'CONFIG_USB_OHCI_PCI', if_true: files('hcd-ohci-pci.c'))
 system_ss.add(when: 'CONFIG_USB_OHCI_SYSBUS', if_true: files('hcd-ohci-sysbus.c'))
diff --git a/hw/usb/vt82c686-uhci-pci.c b/hw/usb/vt82c686-uhci-pci.c
index 6162806172..7fdb4697f9 100644
--- a/hw/usb/vt82c686-uhci-pci.c
+++ b/hw/usb/vt82c686-uhci-pci.c
@@ -1,17 +1,17 @@
 #include "qemu/osdep.h"
 #include "hw/irq.h"
 #include "hw/isa/vt82c686.h"
-#include "hcd-uhci.h"
+#include "hcd-uhci-pci.h"
 
 static void uhci_isa_set_irq(void *opaque, int irq_num, int level)
 {
-    UHCIState *s = opaque;
+    UHCIPCIState *s = opaque;
     via_isa_set_irq(&s->dev, 0, level);
 }
 
 static void usb_uhci_vt82c686b_realize(PCIDevice *dev, Error **errp)
 {
-    UHCIState *s = UHCI(dev);
+    UHCIPCIState *s = UHCI_PCI(dev);
     uint8_t *pci_conf = s->dev.config;
 
     /* USB misc control 1/2 */
@@ -21,12 +21,12 @@ static void usb_uhci_vt82c686b_realize(PCIDevice *dev, Error **errp)
     /* USB legacy support  */
     pci_set_long(pci_conf + 0xc0, 0x00002000);
 
-    usb_uhci_common_realize(dev, errp);
-    object_unref(s->irq);
-    s->irq = qemu_allocate_irq(uhci_isa_set_irq, s, 0);
+    usb_uhci_common_realize_pci(dev, errp);
+    object_unref(s->state.irq);
+    s->state.irq = qemu_allocate_irq(uhci_isa_set_irq, &s->state, 0);
 }
 
-static UHCIInfo uhci_info[] = {
+static UHCIPCIInfo uhci_info[] = {
     {
         .name      = TYPE_VT82C686B_USB_UHCI,
         .vendor_id = PCI_VENDOR_ID_VIA,
@@ -41,9 +41,9 @@ static UHCIInfo uhci_info[] = {
 };
 
 static const TypeInfo vt82c686b_usb_uhci_type_info = {
-    .parent         = TYPE_UHCI,
+    .parent         = TYPE_UHCI_PCI,
     .name           = TYPE_VT82C686B_USB_UHCI,
-    .class_init     = uhci_data_class_init,
+    .class_init     = uhci_pci_data_class_init,
     .class_data     = uhci_info,
 };
 
diff --git a/include/hw/southbridge/piix.h b/include/hw/southbridge/piix.h
index 86709ba2e4..ceb05548fe 100644
--- a/include/hw/southbridge/piix.h
+++ b/include/hw/southbridge/piix.h
@@ -16,7 +16,7 @@
 #include "hw/acpi/piix4.h"
 #include "hw/ide/pci.h"
 #include "hw/rtc/mc146818rtc.h"
-#include "hw/usb/hcd-uhci.h"
+#include "hw/usb/hcd-uhci-pci.h"
 
 /* PIRQRC[A:D]: PIRQx Route Control Registers */
 #define PIIX_PIRQCA 0x60
@@ -57,7 +57,7 @@ struct PIIXState {
 
     MC146818RtcState rtc;
     PCIIDEState ide;
-    UHCIState uhci;
+    UHCIPCIState uhci;
     PIIX4PMState pm;
 
     uint32_t smb_io_base;
-- 
2.45.2


