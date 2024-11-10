Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8272BD5E399
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Nov 2024 05:01:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tA03s-0008Ho-Q9; Sun, 10 Nov 2024 00:00:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tA03q-0008HZ-HL
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 00:00:30 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tA03o-0000Oz-Ip
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 00:00:30 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-720e94d36c8so3948984b3a.1
 for <qemu-devel@nongnu.org>; Sat, 09 Nov 2024 21:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731214826; x=1731819626; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HbK1vozDVr2AohpLEAWE6Hd0hmgqPtr12KqKza6rqB8=;
 b=F8e1tVYgHxLlHdGRslOAWP2LIxThgmBVp84wztI+WZXuof2tkDDKwS+ORqNspqhxCN
 ECWpplCqvIhHGSHju2KErS6iFybn6E0a2hOYW77O3C3JYunjEVZFhrkJjWYzog+Oa1PE
 Me/+WYoiqd3UOL0ycjxOisS+eaHUVC6HG9/5fLQRRE/9Xb/JDZGfTGE2SlKT2Cky0M4o
 tD+qXVtYc6lgBzj8KO2oFnpb+dKAlb/fpjWCLABEp4bAYL9ui2ARtoi3CpmJ4k+JbUo6
 R/jNc9395aY5VdY6yQ118s2VCmgawjN7DT0NKO4QxDdBHUnvC+5X3RnKUgmZ+K4huk5N
 vjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731214826; x=1731819626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HbK1vozDVr2AohpLEAWE6Hd0hmgqPtr12KqKza6rqB8=;
 b=ANp+EbnkwSiVd3l8FgbKZFr7tQCcsF+opYMM88HsKTP0wH0FdfhnECONJdvq1Nw1ox
 GZnUOHpCKGddZgH3lXj7pNmAbb/O1C96Ck3nRZbxD95gBCI2z0qs/b6HiKBukyTZh6bs
 yjHgowKERPO63g3nJ6VllqgsnTIuypJbAaJdl7r11CKInmZxLb50dNhdOTNpdCETavJM
 EzWcTND0UB01zpuhYG1rg3y598ZkRjSzZjZZYl7a/pEcVgUPh7kJWFkRIiNPaXep8G+o
 XBycubg35iLVpdDT+2yz5dibWBSSFaeDTYk9572SD8qWcwqBmEPC37sNmBfDugXbZu4k
 hDkA==
X-Gm-Message-State: AOJu0YyD32nm5dbQYRLnPfoKNPq1uWzpwEUuSOrifSqnsIG6Ku0rJjI1
 6Uolttcy78HzxwWZjH8W03zjtmQ/r/JR6eUvQLogQ1w1KR21/13HvMNiAg==
X-Google-Smtp-Source: AGHT+IG05PoM+AMKPUiqaMBKVQsHrgMaWblDVKcz1+JIF4uWSlxd+dsVcRdJvhANMOelGzHKWUEDFg==
X-Received: by 2002:a05:6a00:35cd:b0:71e:6f09:c0a8 with SMTP id
 d2e1a72fcca58-724122d2bb3mr15289246b3a.10.1731214826265; 
 Sat, 09 Nov 2024 21:00:26 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72407a18d8csm6709215b3a.149.2024.11.09.21.00.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Nov 2024 21:00:25 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 2/2] hw/usb: Add TI TUSB73X0 XHCI controller model
Date: Sun, 10 Nov 2024 15:00:08 +1000
Message-ID: <20241110050009.389367-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241110050009.389367-1-npiggin@gmail.com>
References: <20241110050009.389367-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This controller is accepted by IBM Power firmware when the subsystem IDs
are set to Power servers. Firmware is picky about device support so the
NEC driver does not work.

The TI HW has some interesting differences from NEC, notably a separate
BAR for MSIX, and PM capabilities. The spec is freely available without
sign-up.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/pci/pci_ids.h |  1 +
 include/hw/usb/xhci.h    |  1 +
 hw/usb/hcd-xhci-ti.c     | 94 ++++++++++++++++++++++++++++++++++++++++
 hw/usb/Kconfig           |  5 +++
 hw/usb/meson.build       |  1 +
 5 files changed, 102 insertions(+)
 create mode 100644 hw/usb/hcd-xhci-ti.c

diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
index f1a53fea8d..fdb692db51 100644
--- a/include/hw/pci/pci_ids.h
+++ b/include/hw/pci/pci_ids.h
@@ -182,6 +182,7 @@
 #define PCI_VENDOR_ID_HP                 0x103c
 
 #define PCI_VENDOR_ID_TI                 0x104c
+#define PCI_DEVICE_ID_TI_TUSB73X0        0x8241
 
 #define PCI_VENDOR_ID_MOTOROLA           0x1057
 #define PCI_DEVICE_ID_MOTOROLA_MPC106    0x0002
diff --git a/include/hw/usb/xhci.h b/include/hw/usb/xhci.h
index 5c90e1373e..203ec1fca3 100644
--- a/include/hw/usb/xhci.h
+++ b/include/hw/usb/xhci.h
@@ -3,6 +3,7 @@
 
 #define TYPE_XHCI "base-xhci"
 #define TYPE_NEC_XHCI "nec-usb-xhci"
+#define TYPE_TI_XHCI "ti-usb-xhci"
 #define TYPE_QEMU_XHCI "qemu-xhci"
 #define TYPE_XHCI_SYSBUS "sysbus-xhci"
 
diff --git a/hw/usb/hcd-xhci-ti.c b/hw/usb/hcd-xhci-ti.c
new file mode 100644
index 0000000000..a3f7ef8ba2
--- /dev/null
+++ b/hw/usb/hcd-xhci-ti.c
@@ -0,0 +1,94 @@
+/*
+ * USB xHCI controller emulation
+ * Datasheet https://www.ti.com/product/TUSB7340
+ *
+ * Copyright (c) 2011 Securiforest
+ * Date: 2011-05-11 ;  Author: Hector Martin <hector@marcansoft.com>
+ * Based on usb-xhci-nec.c, emulates TI TUSB73X0
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
+#include "hw/usb.h"
+#include "qemu/module.h"
+#include "hw/pci/pci.h"
+#include "hw/qdev-properties.h"
+
+#include "hcd-xhci-pci.h"
+
+OBJECT_DECLARE_SIMPLE_TYPE(XHCITiState, TI_XHCI)
+
+struct XHCITiState {
+    /*< private >*/
+    XHCIPciState parent_obj;
+    /*< public >*/
+    uint32_t flags;
+    uint32_t intrs;
+    uint32_t slots;
+};
+
+static Property ti_xhci_properties[] = {
+    DEFINE_PROP_ON_OFF_AUTO("msi", XHCIPciState, msi, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO("msix", XHCIPciState, msix, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_UINT32("intrs", XHCITiState, intrs, 8),
+    DEFINE_PROP_UINT32("slots", XHCITiState, slots, XHCI_MAXSLOTS),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void ti_xhci_instance_init(Object *obj)
+{
+    XHCIPciState *pci = XHCI_PCI(obj);
+    XHCITiState *ti = TI_XHCI(obj);
+
+    pci->xhci.flags    = ti->flags;
+    pci->xhci.numintrs = ti->intrs;
+    pci->xhci.numslots = ti->slots;
+
+    pci->cache_line_size = 0x0;
+    pci->pm_cap_off = 0x40;
+    pci->pcie_cap_off = 0x70;
+    pci->msi_cap_off = 0x48;
+    pci->msix_cap_off = 0xc0;
+    pci->msix_bar_nr = 0x2;
+    pci->msix_bar_size = 0x800000;
+    pci->msix_table_off = 0x0;
+    pci->msix_pba_off = 0x1000;
+}
+
+static void ti_xhci_class_init(ObjectClass *klass, void *data)
+{
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_props(dc, ti_xhci_properties);
+    k->vendor_id    = PCI_VENDOR_ID_TI;
+    k->device_id    = PCI_DEVICE_ID_TI_TUSB73X0;
+    k->revision     = 0x02;
+}
+
+static const TypeInfo ti_xhci_info = {
+    .name          = TYPE_TI_XHCI,
+    .parent        = TYPE_XHCI_PCI,
+    .instance_size = sizeof(XHCITiState),
+    .instance_init = ti_xhci_instance_init,
+    .class_init    = ti_xhci_class_init,
+};
+
+static void ti_xhci_register_types(void)
+{
+    type_register_static(&ti_xhci_info);
+}
+
+type_init(ti_xhci_register_types)
diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index 5fbecd2f43..8e5c4747af 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -49,6 +49,11 @@ config USB_XHCI_NEC
     default y if PCI_DEVICES
     select USB_XHCI_PCI
 
+config USB_XHCI_TI
+    bool
+    default y if PCI_DEVICES
+    select USB_XHCI_PCI
+
 config USB_XHCI_SYSBUS
     bool
     select USB_XHCI
diff --git a/hw/usb/meson.build b/hw/usb/meson.build
index 1b4d1507e4..b874a93f16 100644
--- a/hw/usb/meson.build
+++ b/hw/usb/meson.build
@@ -23,6 +23,7 @@ system_ss.add(when: 'CONFIG_USB_XHCI', if_true: files('hcd-xhci.c'))
 system_ss.add(when: 'CONFIG_USB_XHCI_PCI', if_true: files('hcd-xhci-pci.c'))
 system_ss.add(when: 'CONFIG_USB_XHCI_SYSBUS', if_true: files('hcd-xhci-sysbus.c'))
 system_ss.add(when: 'CONFIG_USB_XHCI_NEC', if_true: files('hcd-xhci-nec.c'))
+system_ss.add(when: 'CONFIG_USB_XHCI_TI', if_true: files('hcd-xhci-ti.c'))
 system_ss.add(when: 'CONFIG_USB_DWC2', if_true: files('hcd-dwc2.c'))
 system_ss.add(when: 'CONFIG_USB_DWC3', if_true: files('hcd-dwc3.c'))
 
-- 
2.45.2


