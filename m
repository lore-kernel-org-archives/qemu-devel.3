Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1011DC43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 09:49:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiUKA-0004jf-Oq; Sat, 11 Jul 2026 05:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rdmitry0911@gmail.com>)
 id 1wiUK8-0004cx-L0
 for qemu-devel@nongnu.org; Sat, 11 Jul 2026 05:48:40 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rdmitry0911@gmail.com>)
 id 1wiUK6-0002w6-UQ
 for qemu-devel@nongnu.org; Sat, 11 Jul 2026 05:48:40 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-493f4638f4aso15714165e9.3
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2026 02:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783763317; x=1784368117; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XkzcBXaxEquIecTbbUMZNZVgd4+W1KBWYyNUxpYAGEs=;
 b=K9DDSaD83f0VFHeaC7wcGhEZwRC/tuXc/tDLqp/LPf+/WhQqwD6H2/NrQZ9sGLLUZ1
 LzcL0/RKLPH3vSeqQnZeu47vJH2ibBW4BX4lW/arPsYLt8XboHK29UcoN5yJ2f4E0pZU
 14GMy8rAyZxzkUUjY8lb++ckPfqGGex/NFfmvxogx8nopIfUdpRwQN1ZEXXxgRS5Swud
 Zp25nfiZzXRZfrYqfGkywQdcT4D3BeYnBam2vyVIOi93UePFvC2uWSGj8+9Miw+DFM2a
 YfqhGMYyqcraFWTuaNIUttaa/QZJ2yZvB5m2Qi2YEKHD+TlyBRAxkpdnJO+InXBZRh5r
 bznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783763317; x=1784368117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XkzcBXaxEquIecTbbUMZNZVgd4+W1KBWYyNUxpYAGEs=;
 b=nwfWMwWdaY8zg/BLveewzAlouLIDqtIeCIonlGxR71LcRuzpLwfZ/nTj/7e+pEppDO
 HOV6niwMhfwXuN688vp3EKgCot3flNonbNsnX/5ZN8pTAc+oP6DSEWVmK8CCmdifeJix
 K+/DPf9QBnBLw/XjaFOE/W6a0x1mpwnASmhBrcZr5H8NrKdaOhoxcTJViOpaZJjYQuZx
 T8oB2N2FLeyK+a0226PQ522oBopWdabHHSW1lZQiyfuzzuMhXM1K3HQjT+9jsVoNJbp8
 ZAaMaWdyFAXnu1o9bLqkGOqlMOLYV36cWc2rUnHWoRRmc1iNDfzrCP15j+VCbFDwiiS/
 ODLA==
X-Gm-Message-State: AOJu0Yw9StmcIJ4J0WTgFhYdrxv7H8YrcXitXh47VBCxZFXacvrfytcT
 skyipOtBPSGhqRJAWaQhoik5tZOskFxCnxR7NrTCqAnyyKnHELSgcEu/IoiAaMV3
X-Gm-Gg: AfdE7cncbFPN+LexNIK1ppdTPLHA5p9Z/3bpCZdxun5/7JCwebdbK9YSXbgkIdI/tIc
 89Xk8VfrPxGmvqrGKDRduyDoRQavy3ZQKMYwcL6CK0laJEghksLr5h3v6NqPo9fkkjDV9Su0sPE
 RTq8BjJjKVFqsuFo690V5Vj8FTUqfR+CV/9j+9mkqn/8Sr5ckhNbQ1OTdnDv7BafKLhdsHvxyiT
 y8wzcAWuAiJ5m60z85YUXjL3lybBXCQv01aTwML9+O+Q4c0dXJy8aSmKz4WDxJcCZqB2Y28hcL2
 d8qccKyhkh07gT28W02gqAnFM19Yf0FYLXm3r0Vs4txSaD4z5XxIcrVeoozXQjujFmJyAeVu1ZE
 tIoh+DnJCmofBLdIt/XFb8ic6JJc1MxmityPJcKZ/L8kziRUbAR8wfZOIeknPx3c+uAoo5YzMET
 Y6my2qHB7/0jjrL/wvsANElwiGqwpl9LX1OwTkvnw8Pa/0rKyFH1x3tep8JwL+wjmg4VKg0D5R0
 /sIjxY67aPuCs+sIMUg5iDmmjO+qQ==
X-Received: by 2002:a05:6000:2689:b0:474:cd60:1160 with SMTP id
 ffacd0b85a97d-47f2dd081aemr2292189f8f.46.1783763317245; 
 Sat, 11 Jul 2026 02:48:37 -0700 (PDT)
Received: from debian-for-building.localdomain
 (static.244.71.243.136.clients.your-server.de. [136.243.71.244])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039ad21sm66558181f8f.20.2026.07.11.02.48.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2026 02:48:36 -0700 (PDT)
From: Dmitry R <rdmitry0911@gmail.com>
To: qemu-devel@nongnu.org
Cc: Dmitry R <rdmitry0911@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v2 2/5] hw/pci-bridge: add Thunderbolt PCIe-to-PCI bridge
Date: Sat, 11 Jul 2026 12:47:58 +0300
Message-ID: <20260711094803.3589239-3-rdmitry0911@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260711094803.3589239-1-rdmitry0911@gmail.com>
References: <20260710133440.2845828-1-rdmitry0911@gmail.com>
 <20260711094803.3589239-1-rdmitry0911@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=rdmitry0911@gmail.com; helo=mail-wm1-x332.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add thunderbolt-pcie-pci-bridge for PCI endpoints tunnelled through the
Thunderbolt PCIe layer. The bridge exposes Thunderbolt-related ACPI
properties while leaving downstream PCI devices as regular QEMU devices.

Signed-off-by: Dmitry R <rdmitry0911@gmail.com>
---
 hw/pci-bridge/meson.build                   |   1 +
 hw/pci-bridge/thunderbolt_pcie_pci_bridge.c | 156 ++++++++++++++++++++
 2 files changed, 157 insertions(+)
 create mode 100644 hw/pci-bridge/thunderbolt_pcie_pci_bridge.c

diff --git a/hw/pci-bridge/meson.build b/hw/pci-bridge/meson.build
index fd0698fb33..8bb58ec84c 100644
--- a/hw/pci-bridge/meson.build
+++ b/hw/pci-bridge/meson.build
@@ -5,6 +5,7 @@ pci_ss.add(when: 'CONFIG_IOH3420', if_true: files('ioh3420.c'))
 pci_ss.add(when: 'CONFIG_PCIE_PORT', if_true: files('pcie_root_port.c', 'gen_pcie_root_port.c'))
 pci_ss.add(when: 'CONFIG_PCIE_PORT', if_true: files('thunderbolt_root_port.c'))
 pci_ss.add(when: 'CONFIG_PCIE_PCI_BRIDGE', if_true: files('pcie_pci_bridge.c'))
+pci_ss.add(when: 'CONFIG_PCIE_PCI_BRIDGE', if_true: files('thunderbolt_pcie_pci_bridge.c'))
 pci_ss.add(when: 'CONFIG_PXB', if_true: files('pci_expander_bridge.c'),
                                if_false: files('pci_expander_bridge_stubs.c'))
 pci_ss.add(when: 'CONFIG_XIO3130', if_true: files('xio3130_upstream.c', 'xio3130_downstream.c'))
diff --git a/hw/pci-bridge/thunderbolt_pcie_pci_bridge.c b/hw/pci-bridge/thunderbolt_pcie_pci_bridge.c
new file mode 100644
index 0000000000..afbf4871f4
--- /dev/null
+++ b/hw/pci-bridge/thunderbolt_pcie_pci_bridge.c
@@ -0,0 +1,156 @@
+/*
+ * Thunderbolt PCI Express to PCI Bridge
+ *
+ * This is the regular generic PCIe-to-PCI bridge used as a Thunderbolt PCIe
+ * tunnel endpoint. Downstream PCI devices are described normally so existing
+ * macOS drivers that are not IOPCITunnelCompatible can still bind to them.
+ *
+ * Copyright (C) 2026
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/module.h"
+#include "hw/acpi/aml-build.h"
+#include "hw/acpi/pcihp.h"
+#include "hw/acpi/acpi_aml_interface.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/pci_bridge.h"
+#include "qom/object.h"
+
+#define TYPE_THUNDERBOLT_PCIE_PCI_BRIDGE "thunderbolt-pcie-pci-bridge"
+
+static Aml *build_device_properties_dsd(Aml *properties)
+{
+    Aml *dsd;
+
+    dsd = aml_package(2);
+    aml_append(dsd, aml_touuid("DAFFD814-6EBA-4D8C-8A91-BC9BBF4AA301"));
+    aml_append(dsd, properties);
+
+    return aml_name_decl("_DSD", dsd);
+}
+
+static void append_bool_property(Aml *properties, const char *name)
+{
+    Aml *property = aml_package(2);
+
+    aml_append(property, aml_string("%s", name));
+    aml_append(property, aml_int(1));
+    aml_append(properties, property);
+}
+
+static void build_tunnelled_device_dsd(Aml *scope)
+{
+    Aml *properties = aml_package(1);
+
+    append_bool_property(properties, "IOPCITunnelled");
+
+    aml_append(scope, build_device_properties_dsd(properties));
+}
+
+static void build_tunnelled_device_acpi_properties(Aml *scope)
+{
+    build_tunnelled_device_dsd(scope);
+}
+
+static Aml *build_pci_static_endpoint_dsm(PCIDevice *pdev)
+{
+    Aml *method;
+    Aml *params;
+    Aml *pkg;
+
+    g_assert(pdev->acpi_index != 0);
+
+    method = aml_method("_DSM", 4, AML_SERIALIZED);
+    params = aml_local(0);
+    pkg = aml_package(1);
+    aml_append(pkg, aml_int(pdev->acpi_index));
+    aml_append(method, aml_store(pkg, params));
+    aml_append(method,
+        aml_return(aml_call5("EDSM", aml_arg(0), aml_arg(1), aml_arg(2),
+                             aml_arg(3), params)));
+
+    return method;
+}
+
+static bool thunderbolt_bridge_devfn_ignored(int devfn, const PCIBus *bus)
+{
+    const PCIDevice *pdev = bus->devices[devfn];
+
+    if (PCI_FUNC(devfn) && IS_PCI_BRIDGE(pdev) && DEVICE(pdev)->hotplugged) {
+        return true;
+    }
+
+    return false;
+}
+
+static void build_tunnelled_pci_bus_devices(Aml *parent_scope, PCIBus *bus)
+{
+    int devfn;
+
+    for (devfn = 0; devfn < ARRAY_SIZE(bus->devices); devfn++) {
+        PCIDevice *pdev = bus->devices[devfn];
+        int adr = PCI_SLOT(devfn) << 16 | PCI_FUNC(devfn);
+        Aml *dev;
+
+        if (!pdev || thunderbolt_bridge_devfn_ignored(devfn, bus)) {
+            continue;
+        }
+
+        dev = aml_device("S%.02X", devfn);
+        aml_append(dev, aml_name_decl("_ADR", aml_int(adr)));
+
+        call_dev_aml_func(DEVICE(pdev), dev);
+
+        if (pdev->acpi_index &&
+            !object_property_get_bool(OBJECT(pdev), "hotpluggable",
+                                      &error_abort)) {
+            aml_append(dev, build_pci_static_endpoint_dsm(pdev));
+        }
+
+        aml_append(parent_scope, dev);
+    }
+}
+
+static void build_thunderbolt_pcie_pci_bridge_aml(AcpiDevAmlIf *adev,
+                                                  Aml *scope)
+{
+    PCIBridge *br = PCI_BRIDGE(adev);
+
+    build_tunnelled_device_acpi_properties(scope);
+
+    if (!DEVICE(br)->hotplugged) {
+        PCIBus *sec_bus = pci_bridge_get_sec_bus(br);
+
+        build_tunnelled_pci_bus_devices(scope, sec_bus);
+
+        if (object_property_find(OBJECT(sec_bus), ACPI_PCIHP_PROP_BSEL)) {
+            build_append_pcihp_slots(scope, sec_bus);
+        }
+    }
+}
+
+static void thunderbolt_pcie_pci_bridge_class_init(ObjectClass *klass,
+                                                   const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    AcpiDevAmlIfClass *adevc = ACPI_DEV_AML_IF_CLASS(klass);
+
+    dc->desc = "Thunderbolt PCI Express to PCI Bridge";
+    adevc->build_dev_aml = build_thunderbolt_pcie_pci_bridge_aml;
+}
+
+static const TypeInfo thunderbolt_pcie_pci_bridge_info = {
+    .name       = TYPE_THUNDERBOLT_PCIE_PCI_BRIDGE,
+    .parent     = "pcie-pci-bridge",
+    .class_init = thunderbolt_pcie_pci_bridge_class_init,
+};
+
+static void thunderbolt_pcie_pci_bridge_register_types(void)
+{
+    type_register_static(&thunderbolt_pcie_pci_bridge_info);
+}
+
+type_init(thunderbolt_pcie_pci_bridge_register_types)
-- 
2.47.3


