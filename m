Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9949DE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 19:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNzxB-0003OS-G0; Wed, 18 Dec 2024 14:43:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <32iVjZwcKCvMqZiopmZbjjbgZ.XjhlZhp-YZqZgijibip.jmb@flex--venture.bounces.google.com>)
 id 1tNzxA-0003OJ-AG
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 14:43:28 -0500
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <32iVjZwcKCvMqZiopmZbjjbgZ.XjhlZhp-YZqZgijibip.jmb@flex--venture.bounces.google.com>)
 id 1tNzx7-0000EG-OD
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 14:43:28 -0500
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-2ee9f66cb12so28933a91.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 11:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1734551002; x=1735155802; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=g5ORhUozwW1nyegMzxRrPr5n9HZTHet8H6RYA1NXbgQ=;
 b=s8vrTJ9ky6HiSNNWS5u9qJ/ih/cy4Ba6vi+wb+jcQJ68gYHnt/fjvKsRX6jgiOsm45
 MlTtHdaeIWP/dYLz47/ExF8ur8uQ1vC6IYMcrseX/GvpI4oXOp67mz57ZD15CJKwleDr
 qnbLcAZ2tJz5dT9x0h++IAEURLaP+9L7tJLvWOWIGFyPv9dlcFqRIoY5hQN2+DQrF5GJ
 xSLurqbNt1Zam16vRs9b20nZJU/xSc4cIRf3CBbszbt222evp6UZ58++oAqYsW0Az8wI
 oDNRwTj0dupnAv922eb447zPOfrVNDeTiaFfnLYWqw9m/T7m89iDIO/Au5UpXweT6Z0j
 kNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734551002; x=1735155802;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g5ORhUozwW1nyegMzxRrPr5n9HZTHet8H6RYA1NXbgQ=;
 b=QIA68OlYiMyHlt00JAZJxNpZXiCVmcQPoAcnjGN8iD6I3ptTbCRCkkxXR5vDZz3eat
 bGV+oOdwxQnKRRt8yG78mdeVrm6p+nDY/5ZXeKuUz7MhNdJ9SgLn09LVTdJN8BYNok3J
 SyaQ11Z4whD3tMZ/+FtMjsam/W5voY9R40RVeeDRTg83l5szFhz0MI2d+zfqImH05ejJ
 gJWvFCk9m2u1Czi5qtJ7kDXMsDYWv3Sz2oGqHuigQgqCInETYcZgmFaw+JjwgAuHcYU/
 UHks2QICNY2bMs8JZ/SYQfXtXu5ZaxUobMBu2yiSXN7uEV+hlUY5EdGHD1518a9cOJfv
 Sy+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVs8KUVGzUbGQGniPa9ZpiN+YOwusHiPWTwuHIwOG+v+tpZy5jsdZDJWi1x4TZXo+NJ3eaNTAJIf8kx@nongnu.org
X-Gm-Message-State: AOJu0Yy8vXt4l0F7jW1nlmbX1viHhJO8+OhlJf3IeiHMwiT/+2MGIhrW
 MLn9924bqfarf6igvYXQF0nM61TbyYdfmdHX/uXPHdTIFevBroilwbM8qUdNPvUzSL4uhDjVkD6
 3jPy4Cg==
X-Google-Smtp-Source: AGHT+IHUl3ena2T7RV4oLFh1kbp/au5rO/Zdosjd5BObRogy5nDMU0cAlrtiwMiieyNjRCdUALrC9qvNWu/M
X-Received: from pgpz6.prod.google.com ([2002:a65:52c6:0:b0:7ff:8d:e293])
 (user=venture job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:54c4:b0:2f4:434d:c7f0
 with SMTP id 98e67ed59e1d1-2f443ce980emr908585a91.12.1734551002399; Wed, 18
 Dec 2024 11:43:22 -0800 (PST)
Date: Wed, 18 Dec 2024 19:43:19 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241218194320.2832636-1-venture@google.com>
Subject: [PATCH v2] hw/pci-bridge: Create PLX Virtual Switch Device
From: Patrick Leis <venture@google.com>
To: peter.maydell@linaro.org, mst@redhat.com, marcel.apfelbaum@gmail.com
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, 
 Nabih Estefan <nabihestefan@google.com>, Patrick Leis <venture@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=32iVjZwcKCvMqZiopmZbjjbgZ.XjhlZhp-YZqZgijibip.jmb@flex--venture.bounces.google.com;
 helo=mail-pj1-x104a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

From: Nabih Estefan <nabihestefan@google.com>

Create a PLX PEX PCIe Virtual Switch implementation that can be used
for modeling trays. This is a generalized version of the xio3130 switch where
we can set the PCI information on creation, allowing us to model different
trays without creating specific devices for all of them. It is used the same
way the xio3130 switch is used + the PCI Signature information

Signed-off-by: Nabih Estefan <nabihestefan@google.com>
Signed-off-by: Patrick Leis <venture@google.com>
---
v2: fix reset function assignment
---
 hw/pci-bridge/Kconfig                  |   5 +
 hw/pci-bridge/meson.build              |   1 +
 hw/pci-bridge/plx_vswitch_downstream.c | 187 +++++++++++++++++++++++++
 hw/pci-bridge/plx_vswitch_upstream.c   | 177 +++++++++++++++++++++++
 include/hw/pci-bridge/plx_vswitch.h    |  41 ++++++
 5 files changed, 411 insertions(+)
 create mode 100644 hw/pci-bridge/plx_vswitch_downstream.c
 create mode 100644 hw/pci-bridge/plx_vswitch_upstream.c
 create mode 100644 include/hw/pci-bridge/plx_vswitch.h

diff --git a/hw/pci-bridge/Kconfig b/hw/pci-bridge/Kconfig
index 449ec98643..dbba09d8b3 100644
--- a/hw/pci-bridge/Kconfig
+++ b/hw/pci-bridge/Kconfig
@@ -27,6 +27,11 @@ config IOH3420
     default y if PCI_DEVICES
     depends on PCI_EXPRESS && MSI_NONBROKEN
 
+config PLX_VSWITCH
+    bool
+    default y if PCI_DEVICES
+    depends on PCI_EXPRESS && MSI_NONBROKEN
+
 config I82801B11
     bool
     default y if PCI_DEVICES
diff --git a/hw/pci-bridge/meson.build b/hw/pci-bridge/meson.build
index 2e0eb0d233..02c18558bd 100644
--- a/hw/pci-bridge/meson.build
+++ b/hw/pci-bridge/meson.build
@@ -7,6 +7,7 @@ pci_ss.add(when: 'CONFIG_PCIE_PCI_BRIDGE', if_true: files('pcie_pci_bridge.c'))
 pci_ss.add(when: 'CONFIG_PXB', if_true: files('pci_expander_bridge.c'),
                                if_false: files('pci_expander_bridge_stubs.c'))
 pci_ss.add(when: 'CONFIG_XIO3130', if_true: files('xio3130_upstream.c', 'xio3130_downstream.c'))
+pci_ss.add(when: 'CONFIG_PLX_VSWITCH', if_true: files('plx_vswitch_upstream.c', 'plx_vswitch_downstream.c'))
 pci_ss.add(when: 'CONFIG_CXL', if_true: files('cxl_root_port.c', 'cxl_upstream.c', 'cxl_downstream.c'))
 
 # Sun4u
diff --git a/hw/pci-bridge/plx_vswitch_downstream.c b/hw/pci-bridge/plx_vswitch_downstream.c
new file mode 100644
index 0000000000..a00d393657
--- /dev/null
+++ b/hw/pci-bridge/plx_vswitch_downstream.c
@@ -0,0 +1,187 @@
+/*
+ * PLX PEX PCIe Virtual Switch - Downstream
+ *
+ * Copyright 2024 Google LLC
+ * Author: Nabih Estefan <nabihestefan@google.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+ * for more details.
+ *
+ * Based on xio3130_downstream.c and guest_only_pci.c
+ */
+
+#include "qemu/osdep.h"
+#include "hw/pci/pci_ids.h"
+#include "hw/pci/msi.h"
+#include "hw/pci/pcie.h"
+#include "hw/pci/pcie_port.h"
+#include "hw/pci-bridge/plx_vswitch.h"
+#include "hw/qdev-properties-system.h"
+#include "hw/qdev-properties.h"
+#include "hw/registerfields.h"
+#include "migration/vmstate.h"
+#include "qapi/error.h"
+#include "qemu/module.h"
+
+#define TYPE_PLX_VSWITCH_DOWNSTREAM_PCI "plx-vswitch-downstream-pci"
+OBJECT_DECLARE_SIMPLE_TYPE(PlxVSwitchPci, PLX_VSWITCH_DOWNSTREAM_PCI)
+
+
+static void plx_vswitch_downstream_write_config(PCIDevice *d, uint32_t address,
+                                         uint32_t val, int len)
+{
+    pci_bridge_write_config(d, address, val, len);
+    pcie_cap_flr_write_config(d, address, val, len);
+    pcie_aer_write_config(d, address, val, len);
+}
+
+static void plx_vswitch_downstream_reset(DeviceState *qdev)
+{
+    PCIDevice *d = PCI_DEVICE(qdev);
+
+    pcie_cap_deverr_reset(d);
+    pcie_cap_arifwd_reset(d);
+    pci_bridge_reset(qdev);
+}
+
+static void plx_vswitch_downstream_realize(PCIDevice *d, Error **errp)
+{
+    PlxVSwitchPci *vs = PLX_VSWITCH_DOWNSTREAM_PCI(d);
+    PCIEPort *p = PCIE_PORT(d);
+    int rc;
+
+    if (vs->vendor_id == 0xffff) {
+        error_setg(errp, "Vendor ID invalid, it must always be supplied");
+        return;
+    }
+    if (vs->device_id == 0xffff) {
+        error_setg(errp, "Device ID invalid, it must always be supplied");
+        return;
+    }
+
+    if (vs->subsystem_vendor_id == 0xffff) {
+        error_setg(errp,
+                   "Subsystem Vendor ID invalid, it must always be supplied");
+        return;
+    }
+
+    uint16_t ssvid = vs->subsystem_vendor_id;
+    uint16_t ssdid = vs->subsystem_device_id;
+
+    pci_set_word(&d->config[PCI_VENDOR_ID], vs->vendor_id);
+    pci_set_word(&d->config[PCI_DEVICE_ID], vs->device_id);
+    pci_set_long(&d->config[PCI_CLASS_REVISION], vs->class_revision);
+
+    pci_bridge_initfn(d, TYPE_PCIE_BUS);
+    pcie_port_init_reg(d);
+
+    rc = msi_init(d, PLX_VSWITCH_MSI_OFFSET, PLX_VSWITCH_MSI_NR_VECTOR,
+                  PLX_VSWITCH_MSI_SUPPORTED_FLAGS & PCI_MSI_FLAGS_64BIT,
+                  PLX_VSWITCH_MSI_SUPPORTED_FLAGS & PCI_MSI_FLAGS_MASKBIT,
+                  errp);
+    if (rc < 0) {
+        assert(rc == -ENOTSUP);
+        goto err_bridge;
+    }
+
+    rc = pci_bridge_ssvid_init(d, PLX_VSWITCH_SSVID_OFFSET, ssvid, ssdid,
+                               errp);
+    if (rc < 0) {
+        goto err_msi;
+    }
+
+    rc = pcie_cap_init(d, PLX_VSWITCH_EXP_OFFSET, PCI_EXP_TYPE_DOWNSTREAM,
+                       p->port, errp);
+    if (rc < 0) {
+        goto err_msi;
+    }
+    pcie_cap_flr_init(d);
+    pcie_cap_deverr_init(d);
+    pcie_cap_arifwd_init(d);
+
+    rc = pcie_aer_init(d, PCI_ERR_VER, PLX_VSWITCH_AER_OFFSET,
+                       PCI_ERR_SIZEOF, errp);
+    if (rc < 0) {
+        goto err;
+    }
+
+    return;
+
+err:
+    pcie_cap_exit(d);
+err_msi:
+    msi_uninit(d);
+err_bridge:
+    pci_bridge_exitfn(d);
+}
+
+static void plx_vswitch_downstream_exitfn(PCIDevice *d)
+{
+    pcie_aer_exit(d);
+    pcie_cap_exit(d);
+    msi_uninit(d);
+    pci_bridge_exitfn(d);
+}
+
+static const VMStateDescription vmstate_plx_vswitch_downstream = {
+    .name = PLX_VSWITCH_DOWNSTREAM,
+    .priority = MIG_PRI_PCI_BUS,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_PCI_DEVICE(parent_obj.parent_obj, PCIEPort),
+        VMSTATE_STRUCT(parent_obj.parent_obj.exp.aer_log,
+                       PCIEPort, 0, vmstate_pcie_aer_log, PCIEAERLog),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static Property plx_vswitch_downstream_pci_properties[] = {
+    DEFINE_PROP_UINT16("vendor-id", PlxVSwitchPci, vendor_id, 0xffff),
+    DEFINE_PROP_UINT16("device-id", PlxVSwitchPci, device_id, 0xffff),
+    DEFINE_PROP_UINT16("subsystem-vendor-id", PlxVSwitchPci,
+                       subsystem_vendor_id, 0),
+    DEFINE_PROP_UINT16("subsystem-device-id", PlxVSwitchPci,
+                       subsystem_device_id, 0),
+    DEFINE_PROP_UINT32("class-revision", PlxVSwitchPci, class_revision,
+                       0xff000000 /* Unknown class */),
+    DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
+                    QEMU_PCIE_SLTCAP_PCP_BITNR, true),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void plx_vswitch_downstream_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+    dc->desc = "Downstream Port of PLX PEX PCIe Virtual Switch";
+    device_class_set_legacy_reset(dc, plx_vswitch_downstream_reset);
+    dc->vmsd = &vmstate_plx_vswitch_downstream;
+    device_class_set_props(dc, plx_vswitch_downstream_pci_properties);
+
+    k->config_write = plx_vswitch_downstream_write_config;
+    k->realize = plx_vswitch_downstream_realize;
+    k->exit = plx_vswitch_downstream_exitfn;
+}
+
+static const TypeInfo plx_vswitch_downstream_pci_types[] = {
+    {
+        .name = TYPE_PLX_VSWITCH_DOWNSTREAM_PCI,
+        .parent = TYPE_PCIE_PORT,
+        .class_init = plx_vswitch_downstream_class_init,
+        .interfaces = (InterfaceInfo[]) {
+            { INTERFACE_PCIE_DEVICE },
+            { }
+        }
+    },
+};
+DEFINE_TYPES(plx_vswitch_downstream_pci_types)
diff --git a/hw/pci-bridge/plx_vswitch_upstream.c b/hw/pci-bridge/plx_vswitch_upstream.c
new file mode 100644
index 0000000000..ba23e90bd6
--- /dev/null
+++ b/hw/pci-bridge/plx_vswitch_upstream.c
@@ -0,0 +1,177 @@
+/*
+ * PLX PEX PCIe Virtual Switch - Upstream
+ *
+ * Copyright 2024 Google LLC
+ * Author: Nabih Estefan <nabihestefan@google.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+ * for more details.
+ *
+ * Based on xio3130_upstream.c and guest_only_pci.c
+ */
+
+#include "qemu/osdep.h"
+#include "hw/pci/pci_ids.h"
+#include "hw/pci/msi.h"
+#include "hw/pci/pcie.h"
+#include "hw/pci/pcie_port.h"
+#include "hw/pci-bridge/plx_vswitch.h"
+#include "hw/qdev-properties-system.h"
+#include "hw/registerfields.h"
+#include "migration/vmstate.h"
+#include "qemu/module.h"
+
+#define TYPE_PLX_VSWITCH_UPSTREAM_PCI "plx-vswitch-upstream-pci"
+OBJECT_DECLARE_SIMPLE_TYPE(PlxVSwitchPci, PLX_VSWITCH_UPSTREAM_PCI)
+
+static void plx_vswitch_upstream_write_config(PCIDevice *d, uint32_t address,
+                                          uint32_t val, int len)
+{
+    pci_bridge_write_config(d, address, val, len);
+    pcie_cap_flr_write_config(d, address, val, len);
+    pcie_aer_write_config(d, address, val, len);
+}
+
+static void plx_vswitch_upstream_reset(DeviceState *qdev)
+{
+    PCIDevice *d = PCI_DEVICE(qdev);
+
+    pci_bridge_reset(qdev);
+    pcie_cap_deverr_reset(d);
+}
+
+static void plx_vswitch_upstream_realize(PCIDevice *d, Error **errp)
+{
+    PlxVSwitchPci *vs = PLX_VSWITCH_UPSTREAM_PCI(d);
+    PCIEPort *p = PCIE_PORT(d);
+    int rc;
+
+    if (vs->vendor_id == 0xffff) {
+        error_setg(errp, "Vendor ID invalid, it must always be supplied");
+        return;
+    }
+    if (vs->device_id == 0xffff) {
+        error_setg(errp, "Device ID invalid, it must be specified");
+        return;
+    }
+
+    if (vs->subsystem_vendor_id == 0xffff) {
+        error_setg(errp, "Subsystem Vendor ID invalid, it must be specified");
+        return;
+    }
+
+    uint16_t ssvid = vs->subsystem_vendor_id;
+    uint16_t ssdid = vs->subsystem_device_id;
+
+    pci_set_word(&d->config[PCI_VENDOR_ID], vs->vendor_id);
+    pci_set_word(&d->config[PCI_DEVICE_ID], vs->device_id);
+    pci_set_long(&d->config[PCI_CLASS_REVISION], vs->class_revision);
+
+    pci_bridge_initfn(d, TYPE_PCIE_BUS);
+    pcie_port_init_reg(d);
+
+    rc = msi_init(d, PLX_VSWITCH_MSI_OFFSET, PLX_VSWITCH_MSI_NR_VECTOR,
+                  PLX_VSWITCH_MSI_SUPPORTED_FLAGS & PCI_MSI_FLAGS_64BIT,
+                  PLX_VSWITCH_MSI_SUPPORTED_FLAGS & PCI_MSI_FLAGS_MASKBIT,
+                  errp);
+    if (rc < 0) {
+        assert(rc == -ENOTSUP);
+        goto err_bridge;
+    }
+
+    rc = pci_bridge_ssvid_init(d, PLX_VSWITCH_SSVID_OFFSET, ssvid, ssdid, errp);
+    if (rc < 0) {
+        goto err_msi;
+    }
+
+    rc = pcie_cap_init(d, PLX_VSWITCH_EXP_OFFSET, PCI_EXP_TYPE_UPSTREAM,
+                       p->port, errp);
+    if (rc < 0) {
+        goto err_msi;
+    }
+    pcie_cap_flr_init(d);
+    pcie_cap_deverr_init(d);
+
+    rc = pcie_aer_init(d, PCI_ERR_VER, PLX_VSWITCH_AER_OFFSET,
+                       PCI_ERR_SIZEOF, errp);
+    if (rc < 0) {
+        goto err;
+    }
+
+    return;
+
+err:
+    pcie_cap_exit(d);
+err_msi:
+    msi_uninit(d);
+err_bridge:
+    pci_bridge_exitfn(d);
+}
+
+static void plx_vswitch_upstream_exitfn(PCIDevice *d)
+{
+    pcie_aer_exit(d);
+    pcie_cap_exit(d);
+    msi_uninit(d);
+    pci_bridge_exitfn(d);
+}
+
+static const VMStateDescription vmstate_plx_vswitch_upstream = {
+    .name = PLX_VSWITCH_UPSTREAM,
+    .priority = MIG_PRI_PCI_BUS,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_PCI_DEVICE(parent_obj.parent_obj, PCIEPort),
+        VMSTATE_STRUCT(parent_obj.parent_obj.exp.aer_log, PCIEPort, 0,
+                       vmstate_pcie_aer_log, PCIEAERLog),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static Property plx_vswitch_upstream_pci_properties[] = {
+    DEFINE_PROP_UINT16("vendor-id", PlxVSwitchPci, vendor_id, 0xffff),
+    DEFINE_PROP_UINT16("device-id", PlxVSwitchPci, device_id, 0xffff),
+    DEFINE_PROP_UINT16("subsystem-vendor-id", PlxVSwitchPci,
+                       subsystem_vendor_id, 0xffff),
+    DEFINE_PROP_UINT16("subsystem-device-id", PlxVSwitchPci,
+                       subsystem_device_id, 0xffff),
+    DEFINE_PROP_UINT32("class-revision", PlxVSwitchPci, class_revision,
+                       0xff000000 /* Unknown class */),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void plx_vswitch_upstream_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+    dc->desc = "Upstream Port of PLX PEX PCIe Virtual Switch";
+    device_class_set_legacy_reset(dc, plx_vswitch_upstream_reset);
+    dc->vmsd = &vmstate_plx_vswitch_upstream;
+    device_class_set_props(dc, plx_vswitch_upstream_pci_properties);
+    k->config_write = plx_vswitch_upstream_write_config;
+    k->realize = plx_vswitch_upstream_realize;
+    k->exit = plx_vswitch_upstream_exitfn;
+}
+
+static const TypeInfo plx_vswitch_upstream_pci_types[] = {
+    {
+        .name = TYPE_PLX_VSWITCH_UPSTREAM_PCI,
+        .parent = TYPE_PCIE_PORT,
+        .class_init = plx_vswitch_upstream_class_init,
+        .interfaces = (InterfaceInfo[]) {
+            { INTERFACE_PCIE_DEVICE },
+            { }
+        }
+    },
+};
+DEFINE_TYPES(plx_vswitch_upstream_pci_types)
diff --git a/include/hw/pci-bridge/plx_vswitch.h b/include/hw/pci-bridge/plx_vswitch.h
new file mode 100644
index 0000000000..4542ecf5e0
--- /dev/null
+++ b/include/hw/pci-bridge/plx_vswitch.h
@@ -0,0 +1,41 @@
+/*
+ * PLX PEX PCIe Virtual Switch
+ *
+ * Copyright 2024 Google LLC
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+ * for more details.
+ */
+
+#ifndef HW_PCI_BRIDGE_PLX_VSWITCH
+#define HW_PCI_BRIDGE_PLX_VSWITCH
+
+#define PLX_VSWITCH_DOWNSTREAM "plx-vswitch-downstream"
+#define PLX_VSWITCH_UPSTREAM "plx-vswitch-upstream"
+
+#define PLX_VSWITCH_MSI_OFFSET              0x70
+#define PLX_VSWITCH_MSI_SUPPORTED_FLAGS     PCI_MSI_FLAGS_64BIT
+#define PLX_VSWITCH_MSI_NR_VECTOR           1
+#define PLX_VSWITCH_SSVID_OFFSET            0x80
+#define PLX_VSWITCH_EXP_OFFSET              0x90
+#define PLX_VSWITCH_AER_OFFSET              0x100
+
+typedef struct PlxVSwitchPci {
+    PCIDevice parent;
+
+    /* PCI config properties */
+    uint16_t vendor_id;
+    uint16_t device_id;
+    uint16_t subsystem_vendor_id;
+    uint16_t subsystem_device_id;
+    uint32_t class_revision;
+} PlxVSwitchPci;
+
+#endif
-- 
2.47.1.613.gc27f4b7a9f-goog


