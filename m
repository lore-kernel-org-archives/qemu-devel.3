Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD02FCA0FF0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 20:56:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur0hy-0000ck-N8; Tue, 26 Aug 2025 16:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3SB-uaAwKCos2pqxwt78tup2v33v0t.r315t19-stAt0232v29.36v@flex--nabihestefan.bounces.google.com>)
 id 1ur0hs-0000cK-2O
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 16:55:52 -0400
Received: from mail-oa1-x49.google.com ([2001:4860:4864:20::49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3SB-uaAwKCos2pqxwt78tup2v33v0t.r315t19-stAt0232v29.36v@flex--nabihestefan.bounces.google.com>)
 id 1ur0hg-0001pT-51
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 16:55:49 -0400
Received: by mail-oa1-x49.google.com with SMTP id
 586e51a60fabf-30cce9bb2bbso9622542fac.1
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 13:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1756241737; x=1756846537; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=rrk17bOWN4rAiKUjPaUfCKwbjGpmwomRUQHYGMcZBZw=;
 b=CO1ANCwx9U5V+y5RmiIPc38yRhJWg/CpJwNPIRn4h8MxHXgs4Bl+HKAKfMrfiafQBf
 XMtQwzOCUv+A+h7YeHhEWk9fABKONeWWj1D8amPIX7oinyfk58uuETn6mi6pdS0rFzcg
 4io0Untj9OOAqWcKfqFombzsvWoYYc84R9Yy1OqUerAoKw2MhbbzEDzbTOSjGdZtysK0
 YjqvO17OQ2DT/xyhfGMrNvXQQb23siyIxqBewY8ek6D6SvCuL0yBwF/3wk2g/YiRIFlU
 pGyfZu9x98GqhiaTFWl4B9Q/nG6ObUIcKJw1UCLghKbta5gjz3/i7fMt5BwtiUuEJYK7
 J3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756241737; x=1756846537;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rrk17bOWN4rAiKUjPaUfCKwbjGpmwomRUQHYGMcZBZw=;
 b=YWkLpj7WBvWcOog/7UyjRAG2Q3BMhGZTcwzRKQOa+mPTsU6cXR236kUuFTXx5jUVN5
 Ym8tIeBRYlvKW41QEretDzAhZRx0ntkA9vCOb6XIxz51TKHP9U4AfJLWbuEmeaPjC/3R
 rYu9odRUthOjbaus0+H/UtJW2OeKSWSJl6g1GSdQJbW1ix1jPq1N2FTszCboAfPFNoL4
 0QpO4wud/Ql98aYIOcfKQ+m2vtw2IZG/vaToG3SSS2CsJFZ+F80ZDT3Wwh2S5qeQtI91
 zNOa1/fY8nRAc0IF6gIYjeR8cOfQKjhp5zws331DuxfR9PgZjkbLYmiMJNq4ZQiVYXuO
 67Og==
X-Gm-Message-State: AOJu0YyGlW/7gN7zxqRIeQWaOjSuhIhYQLZT7rnkbZTT3RH4PhDXBnfI
 FFhBEMwg1uaDPn+8gnBGy1QWk8ucoTu2DYV7ZYUcnNJ0znFGjYG0kB36PibjhjYVkqXQSoCkm82
 xepvt9v9GAo05+IOb/KJ/CGdLKi+AiytLc9+HN+iZEIcsmZVeXs/tth5b6CTl2kT8l7r6r3omHq
 A4PBaZyrIGdMCzeYUDHXYXPa9iqzqZqf3ZUCwE78EllSwQSoMtPb+/ssjCX24DEnxeVj8=
X-Google-Smtp-Source: AGHT+IFBXs4dH+Zp79Y1v0NDygyviKvBJ8CTzK3jBwzph9pkKAImXWh38LBXgdf6ivBpM01kN3MtaqyC3eqtoemP89g=
X-Received: from oacpd6.prod.google.com ([2002:a05:6871:7a86:b0:30b:b9fc:7b56])
 (user=nabihestefan job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6870:d03:b0:310:b613:5fd5 with SMTP id
 586e51a60fabf-314dcb549e9mr9448275fac.10.1756241736875; 
 Tue, 26 Aug 2025 13:55:36 -0700 (PDT)
Date: Tue, 26 Aug 2025 20:55:31 +0000
In-Reply-To: <20250826205532.1500639-1-nabihestefan@google.com>
Mime-Version: 1.0
References: <20250826205532.1500639-1-nabihestefan@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250826205532.1500639-2-nabihestefan@google.com>
Subject: [PATCH 1/2] hw/pci-bridge: Create Initial revision for PLX Virtual
 Switch
From: Nabih Estefan <nabihestefan@google.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, 
 venture@google.com, nabihestefan@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2001:4860:4864:20::49;
 envelope-from=3SB-uaAwKCos2pqxwt78tup2v33v0t.r315t19-stAt0232v29.36v@flex--nabihestefan.bounces.google.com;
 helo=mail-oa1-x49.google.com
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

Create a PLX PEX PCIe Virtual Switch implementation that can be used
for modeling trays. This is the initial step that basically acts as an
upstream and downstream pair forming a bridge.

Change-Id: Iddbd59e5b53c5f4925a5656c3d5299c212d23fb9
Signed-off-by: Nabih Estefan <nabihestefan@google.com>
---
 hw/pci-bridge/Kconfig                  |   5 +
 hw/pci-bridge/meson.build              |   1 +
 hw/pci-bridge/plx_vswitch_downstream.c | 188 +++++++++++++++++++++++++
 hw/pci-bridge/plx_vswitch_upstream.c   | 178 +++++++++++++++++++++++
 include/hw/pci-bridge/plx_vswitch.h    |  43 ++++++
 5 files changed, 415 insertions(+)
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
index 0000000000..3038352233
--- /dev/null
+++ b/hw/pci-bridge/plx_vswitch_downstream.c
@@ -0,0 +1,188 @@
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
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
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
+static const Property plx_vswitch_downstream_pci_properties[] = {
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
index 0000000000..d3d0bdc0db
--- /dev/null
+++ b/hw/pci-bridge/plx_vswitch_upstream.c
@@ -0,0 +1,178 @@
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
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
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
+        error_setg(errp, "Device ID invalid, it must always be supplied");
+        return;
+    }
+
+    if (vs->subsystem_vendor_id == 0xffff) {
+        error_setg(errp, "Subsystem Vendor ID invalid, it must always be supplied");
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
+static const Property plx_vswitch_upstream_pci_properties[] = {
+    DEFINE_PROP_UINT16("vendor-id", PlxVSwitchPci, vendor_id, 0xffff),
+    DEFINE_PROP_UINT16("device-id", PlxVSwitchPci, device_id, 0xffff),
+    DEFINE_PROP_UINT16("subsystem-vendor-id", PlxVSwitchPci,
+                       subsystem_vendor_id, 0xffff),
+    DEFINE_PROP_UINT16("subsystem-device-id", PlxVSwitchPci,
+                       subsystem_device_id, 0xffff),
+    DEFINE_PROP_UINT32("class-revision", PlxVSwitchPci, class_revision,
+                       0xff000000 /* Unknown class */),
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
index 0000000000..ad695c3899
--- /dev/null
+++ b/include/hw/pci-bridge/plx_vswitch.h
@@ -0,0 +1,43 @@
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
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
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
2.51.0.318.gd7df087d1a-goog


