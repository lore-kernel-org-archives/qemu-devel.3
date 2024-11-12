Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C3E2D42BAF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 17:07:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAuKW-0005j8-Jj; Tue, 12 Nov 2024 12:05:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1tAuHd-0003Jw-RC; Tue, 12 Nov 2024 12:02:32 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1tAuHa-0001Tv-5Y; Tue, 12 Nov 2024 12:02:29 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2110a622d76so52164985ad.3; 
 Tue, 12 Nov 2024 09:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731430944; x=1732035744; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i3odCHCWhA+GQA7jNI4gUL8tsAQ9mYVU/wGNl+NW4Yw=;
 b=Rt/zDa/wy77DVkfatvtf3lNrfuz8x6W2B14X1aD3PfPLqDsmox0rKRdxFWUnuLTaYm
 zoJY2V+aREDQj/A7t7SBTBygwYU63qQ+wW0flBt+xjPEZ0MSKo7Cw2+C67Ub7zoJVgJ6
 2KNocxnYT5N+1lMiI7y3t/nRG8RUAfj5LxWjVPROipUTq4wQqto0cH7Cy2lSP4elkVLt
 V+D2oupgN/zIUzrQehr4IYqt+NMs8oS0gXCdXLGTb1ebqN9J5vtueOBwJ/2ocq7s0eKz
 1EzQ0l6TKfuUIPOCm8m3ZkeymM4EeBGdohPFJognYi3qS2ungdWeD6yC0PHLpXqYwXNn
 kGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731430944; x=1732035744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i3odCHCWhA+GQA7jNI4gUL8tsAQ9mYVU/wGNl+NW4Yw=;
 b=IJn3s/N/gRSyNmwQhhPJw81putONtPhvUI3DeyNHy7cjmuGVjCAOI5VKMC2cn/YNKj
 s4IMmgnl3O695a5A+kzbZpF7Cuq/eV2GBrDtY2P5TbJrIAy/4X4kGA1u8KdKimZFzdKA
 eWVzaGL8bTXgMXEPrVN00hrocerjQuMsCgCwRVkujVZDr+CohtP09e/u8yvQw0YRzixY
 wVDqVIfcEhTlppkCFF2TKKfmeQbdN/Yh5rbTGF/1T6R1I3Mc8WNT/JB9eIVMykqsVDxS
 1oTdJ/M0fkmKd3SxqVG5Jpf8+qyuQBWGTcGCD7/Cefc3C9+jzO5pRo8GUwH9XPNhxMhF
 Q1MA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYb5auGAdLVc5SdmrdOkIOaRWfUsAYUZAaHJ33z7PhJE+f7GoaoBLYmf+z/mEkDtcSdZLqyyLSww==@nongnu.org
X-Gm-Message-State: AOJu0YziWiVFqNP85sqh/LaVL+yQGYwxRe3Unogbr/LB+Gna278YmVBl
 RZIuGsY9ALXK+S9XPCe3bGSPZ1uvOsN0w+IBxpI6u2YRDYYXElhnxiOr9A==
X-Google-Smtp-Source: AGHT+IEnnHZoZcdF3uE6zrCwwgdXbpIz9YT2W07VZCTkxd40dqLtSI4EQPUmmzKjws36BuW+Hlvjrw==
X-Received: by 2002:a17:902:ec8d:b0:20c:c9db:7c45 with SMTP id
 d9443c01a7336-21183c9b37fmr241893075ad.20.1731430943999; 
 Tue, 12 Nov 2024 09:02:23 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177e6b74bsm95792965ad.247.2024.11.12.09.02.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 09:02:23 -0800 (PST)
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
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Guenter Roeck <linux@roeck-us.net>
Subject: [RESEND PATCH 05/10] usb/uhci: Add support for usb-uhci-sysbus
Date: Tue, 12 Nov 2024 09:01:47 -0800
Message-ID: <20241112170152.217664-6-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112170152.217664-1-linux@roeck-us.net>
References: <20241112170152.217664-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=groeck7@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Changes since RFC:
- Rebased to v9.1.0-1673-g134b443512

 hw/arm/Kconfig           |   1 +
 hw/usb/Kconfig           |   4 ++
 hw/usb/hcd-uhci-sysbus.c | 100 +++++++++++++++++++++++++++++++++++++++
 hw/usb/hcd-uhci-sysbus.h |  23 +++++++++
 hw/usb/meson.build       |   1 +
 5 files changed, 129 insertions(+)
 create mode 100644 hw/usb/hcd-uhci-sysbus.c
 create mode 100644 hw/usb/hcd-uhci-sysbus.h

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 1b25e73578..3f92ae429a 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -540,6 +540,7 @@ config ASPEED_SOC
     select MAX31785
     select FSI_APB2OPB_ASPEED
     select AT24C
+    select USB_UHCI_SYSBUS
 
 config MPS2
     bool
diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index bab4d2d67d..f51aa82370 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -11,6 +11,10 @@ config USB_UHCI_PCI
     depends on PCI
     select USB_UHCI
 
+config USB_UHCI_SYSBUS
+    bool
+    select USB_UHCI
+
 config USB_OHCI
     bool
     select USB
diff --git a/hw/usb/hcd-uhci-sysbus.c b/hw/usb/hcd-uhci-sysbus.c
new file mode 100644
index 0000000000..3a6c56c3df
--- /dev/null
+++ b/hw/usb/hcd-uhci-sysbus.c
@@ -0,0 +1,100 @@
+/*
+ * QEMU USB UHCI Emulation
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
+#include "hcd-uhci.h"
+#include "hcd-uhci-sysbus.h"
+
+static void uhci_sysbus_reset(UHCIState *uhci)
+{
+    uhci_state_reset(uhci);
+}
+
+static void uhci_sysbus_realize(DeviceState *dev, Error **errp)
+{
+    UHCISysBusState *s = SYSBUS_UHCI(dev);
+    UHCIState *uhci = &s->uhci;
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    Error *err = NULL;
+
+    uhci->masterbus = s->masterbus;
+    uhci->firstport = s->firstport;
+    uhci->maxframes = s->maxframes;
+    uhci->frame_bandwidth = s->frame_bandwidth;
+    uhci->as = &address_space_memory;
+    uhci->uhci_reset = uhci_sysbus_reset;
+
+    usb_uhci_init(uhci, dev, &err);
+
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    sysbus_init_irq(sbd, &uhci->irq);
+    sysbus_init_mmio(sbd, &uhci->mem);
+}
+
+static void uhci_sysbus_reset_sysbus(DeviceState *dev)
+{
+    UHCISysBusState *s = SYSBUS_UHCI(dev);
+    UHCIState *uhci = &s->uhci;
+
+    uhci_sysbus_reset(uhci);
+}
+
+static Property uhci_sysbus_properties[] = {
+    DEFINE_PROP_STRING("masterbus", UHCISysBusState, masterbus),
+    DEFINE_PROP_UINT32("firstport", UHCISysBusState, firstport, 0),
+    DEFINE_PROP_UINT32("bandwidth", UHCISysBusState, frame_bandwidth, 1280),
+    DEFINE_PROP_UINT32("maxframes", UHCISysBusState, maxframes, 128),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void uhci_sysbus_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = uhci_sysbus_realize;
+    set_bit(DEVICE_CATEGORY_USB, dc->categories);
+    dc->desc = "UHCI USB Controller";
+    device_class_set_props(dc, uhci_sysbus_properties);
+    device_class_set_legacy_reset(dc, uhci_sysbus_reset_sysbus);
+}
+
+static const TypeInfo uhci_sysbus_types[] = {
+    {
+        .name          = TYPE_SYSBUS_UHCI,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(UHCISysBusState),
+        .class_init    = uhci_sysbus_class_init,
+    },
+};
+
+DEFINE_TYPES(uhci_sysbus_types);
diff --git a/hw/usb/hcd-uhci-sysbus.h b/hw/usb/hcd-uhci-sysbus.h
new file mode 100644
index 0000000000..c491b9fc92
--- /dev/null
+++ b/hw/usb/hcd-uhci-sysbus.h
@@ -0,0 +1,23 @@
+#ifndef HW_USB_HCD_UHCI_SYSBUS_H
+#define HW_USB_HCD_UHCI_SYSBUS_H
+
+#include "hcd-uhci.h"
+
+#define TYPE_SYSBUS_UHCI "sysbus-uhci"
+
+OBJECT_DECLARE_SIMPLE_TYPE(UHCISysBusState, SYSBUS_UHCI)
+
+struct UHCISysBusState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+    UHCIState uhci;
+
+    char *masterbus;
+    uint32_t firstport;
+    uint32_t frame_bandwidth;
+    uint32_t maxframes;
+    uint32_t num_ports;
+};
+
+#endif /* HW_USB_HCD_UHCI_SYSBUS_H */
diff --git a/hw/usb/meson.build b/hw/usb/meson.build
index dc36e2d490..ff27aa7d04 100644
--- a/hw/usb/meson.build
+++ b/hw/usb/meson.build
@@ -14,6 +14,7 @@ system_ss.add(when: 'CONFIG_USB', if_true: files(
 # usb host adapters
 system_ss.add(when: 'CONFIG_USB_UHCI', if_true: files('hcd-uhci.c'))
 system_ss.add(when: 'CONFIG_USB_UHCI_PCI', if_true: files('hcd-uhci-pci.c'))
+system_ss.add(when: 'CONFIG_USB_UHCI_SYSBUS', if_true: files('hcd-uhci-sysbus.c'))
 system_ss.add(when: 'CONFIG_USB_OHCI', if_true: files('hcd-ohci.c'))
 system_ss.add(when: 'CONFIG_USB_OHCI_PCI', if_true: files('hcd-ohci-pci.c'))
 system_ss.add(when: 'CONFIG_USB_OHCI_SYSBUS', if_true: files('hcd-ohci-sysbus.c'))
-- 
2.45.2


