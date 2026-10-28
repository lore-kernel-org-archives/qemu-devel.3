Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3F0606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QW1jv3Hh;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=t+iVVFJO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7Hh-0004D8-LE; Wed, 28 Oct 2026 13:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7GW-00019c-9j
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:16:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7GQ-0003ub-DA
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:16:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=266/aZuuZJj1dv13T/cRFg8LVOsF8F1fa7XWd/oESG4=;
 b=QW1jv3HhbcOv1fFHhYpUBYda3CEc5TyAa/sXXUY2RMsBwdjBxnKGegTZsKbx3Ix7oR03pw
 H3DX12nMfYZ/PAae/3ZewpwAqGus6emt/vtQo2ECCGxdG2NyM2oS5nJgSa5JlqXmfOU1+n
 a/ulmM1feb1+93L7qDhaPmmyBE5phtU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27--NNue9VANRmW4pkid5uD-w-1; Wed, 28 Oct 2026 13:16:31 -0400
X-MC-Unique: -NNue9VANRmW4pkid5uD-w-1
X-Mimecast-MFC-AGG-ID: -NNue9VANRmW4pkid5uD-w_1793207789
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a359c7f47bso10207165e9.2
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207788; x=1793812588; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=266/aZuuZJj1dv13T/cRFg8LVOsF8F1fa7XWd/oESG4=;
 b=t+iVVFJOrsh4VkNYHJTY/HLfDTqdBiveKwUP7qq8J4cjqERiYwlRZEnezSnW62iLnk
 fJCXTyjujQi34IzCZEKx74ec1xTZ6+de+8FwJRkqwEOBr7XetxKHAMOksdODgOKq5aB1
 iXxv4Y0bMIsy8mTFZN7yNjtu85Z6YtnutzFrbZanADq+HtOMfRgxppQabkBCus/yDwW0
 1e6h0dcCN+E93+9cq8g6vcglyxI5EjSHBDAMlBiRLZNyyA/tGC7wZ/2WpBpghKXlyhkT
 r2qZVVgybunhlVxvgKVAWlwdP6PAQZVKGEMxah/U4al4B+YmDmVuL5Bkn8ARpujX/PCC
 W1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207788; x=1793812588;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=266/aZuuZJj1dv13T/cRFg8LVOsF8F1fa7XWd/oESG4=;
 b=EjJJPggEIBKeMMc9KYNJavQsUv/EIVxxIlSdQ7qzw3NnDQMVtFWJaxzuPD7PQp7ZXV
 SXEqEYSN+G554X6M6lY3Arqwpq3bOE+grTfdR1Z1INaxpkqTynJgYT6cJk0oWFGeHL2e
 byIk4NB1xGCqeHTK4ZZ3b9794a94v8FNlVJoqbvLwyXZXjKgFDhlPN+YVC7OEtDUFgqG
 L5qzIFIvbjBwFuKXf+Tf4M5ebui2PGIEozjsUlLSk7YgTpXQ/8IE6Sc5gSYlHjvEpRb1
 2kcBdDTfABJRDVZhk1EKtMzx/Fc8vyd7grjQRzFnv7/sNLQTfUbP+T6hBN9oYtw+8KSh
 yvmQ==
X-Gm-Message-State: AFq9FYIYOIdxkdeYkuu2LF4Cwm229ynoaldF19BdQ0a+ewpPGdmX2nFk
 D1MIEew4SMTD3aJyuS/dxOzOa+LW/DxmCgY/5O9KFfZF/rvWtzjA1v9D5ZrI1J/MrR7HLfMivqo
 D6w1x1WIXT1j/fr2L5jIoZWFRV8xlu/cCiTx8dzEJvyunE383HDO8BuCByNP0dbANvLkvsEzN5v
 krBlSXLe9iDSMmge5ALPRGK6xNjKCL+QwOiw==
X-Gm-Gg: AYBFou27DJ6wJGgKk3cHLAtCtTYmZh5zeKal/aCH+wAPfOI67jGQIWE9PHcoFJCr1eY
 MidwGzsCCgiizkXc9IaBdqqSMyZH02kzuTH0Ux8FgxkZnonY16AeElnxKMV5lFRhWb2+RilDxn8
 CoqzDQalAC6pa/KZlhGtiTHdgcxLydYdLmvnZiqmZ2NMueOBoVuHjkjdtPrYWpvZ+KwKqVErb1T
 j22ITLe0YiwEwmUlUPk2qXnbTGVe1zwg3z0PRpu885cfrl5tDerZ2RC6T8ev2o3GyJVRrTpp17C
 l132Z9QTpBHYG1HhdYBeUKuSmtlU2Pn8oebtljykv8ENlJRmaj/K93fHmIyFTtEUpVC+61g9pQn
 exTlLbmj3tnLaIobcD+fHqIxXPOt5KWrO57YhDVe8
X-Received: by 2002:a05:600c:8183:b0:4a2:1a:a129 with SMTP id
 5b1f17b1804b1-4a9677c92d0mr54489285e9.35.1793207788102; 
 Wed, 28 Oct 2026 10:16:28 -0700 (PDT)
X-Received: by 2002:a05:600c:8183:b0:4a2:1a:a129 with SMTP id
 5b1f17b1804b1-4a9677c92d0mr54488635e9.35.1793207787387; 
 Wed, 28 Oct 2026 10:16:27 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3eb8f248sm29239446f8f.6.2026.10.28.10.16.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:16:26 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:16:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Junjie Cao <junjie.cao@linux.dev>, Anisa Su <anisa.su@samsung.com>,
 linux-cxl@vger.kernel.org
Subject: [PULL 56/78] hw/pci-bridge: split CXL PXB into separate file
Message-ID: <e6b0101a30025ed22deb99f6c956be33d842be16.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daniel P. Berrangé <berrange@redhat.com>

If CONFIG_CXL=n is added to the Kconfig, the build fails to link
the PXB device:

/usr/bin/ld.bfd: libsystem.a.p/hw_pci-bridge_pci_expander_bridge.c.o: in function `pxb_cxl_realize':
/home/berrange/src/virt/qemu/build/../hw/pci-bridge/pci_expander_bridge.c:202:(.text+0x330): undefined reference to `cxl_component_register_block_init'
/usr/bin/ld.bfd: libsystem.a.p/hw_pci-bridge_pci_expander_bridge.c.o: in function `pxb_cxl_dev_reset':
/home/berrange/src/virt/qemu/build/../hw/pci-bridge/pci_expander_bridge.c:309:(.text+0x768): undefined reference to `cxl_component_register_init_common'

We cannot use CONFIG_CXL in pci_expander_bridge.c because the
identifier is poisoned. Instead the CXL pieces must be split
off into a separate source file which can be conditionally
built.

With this change, the stubs file is no longer required, since
the code referencing the stub was already protected by CONFIG_CXL.

Fixes: 6e4e3ae936e6 ("hw/cxl/component: Implement host bridge MMIO (8.2.5, table 142)")
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260928095646.3555447-3-berrange@redhat.com>
---
 hw/pci-bridge/pci_expander_bridge_common.h    |  28 +++
 ...der_bridge.h => pci_expander_bridge_cxl.h} |   0
 hw/cxl/cxl-host.c                             |   2 +-
 hw/pci-bridge/pci_expander_bridge.c           | 194 +----------------
 hw/pci-bridge/pci_expander_bridge_cxl.c       | 201 ++++++++++++++++++
 hw/pci-bridge/pci_expander_bridge_stubs.c     |  14 --
 hw/pci-bridge/meson.build                     |   2 +-
 7 files changed, 240 insertions(+), 201 deletions(-)
 create mode 100644 hw/pci-bridge/pci_expander_bridge_common.h
 rename include/hw/pci-bridge/{pci_expander_bridge.h => pci_expander_bridge_cxl.h} (100%)
 create mode 100644 hw/pci-bridge/pci_expander_bridge_cxl.c
 delete mode 100644 hw/pci-bridge/pci_expander_bridge_stubs.c

diff --git a/hw/pci-bridge/pci_expander_bridge_common.h b/hw/pci-bridge/pci_expander_bridge_common.h
new file mode 100644
index 0000000000..d894ed0add
--- /dev/null
+++ b/hw/pci-bridge/pci_expander_bridge_common.h
@@ -0,0 +1,28 @@
+/*
+ * PCI Expander Bridge Device Emulation Common Code
+ *
+ * Copyright (C) 2015 Red Hat Inc
+ *
+ * Authors:
+ *   Marcel Apfelbaum <marcel@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+enum BusType { PCI, PCIE, CXL };
+
+typedef struct PXBBus PXBBus;
+
+struct PXBBus {
+    /*< private >*/
+    PCIBus parent_obj;
+    /*< public >*/
+
+    char bus_path[8];
+};
+
+int pxb_bus_num(PCIBus *bus);
+void pxb_bus_class_init(ObjectClass *class, const void *data);
+bool pxb_dev_realize_common(PCIDevice *dev, enum BusType type,
+                            Error **errp);
+void pxb_dev_exitfn(PCIDevice *pci_dev);
diff --git a/include/hw/pci-bridge/pci_expander_bridge.h b/include/hw/pci-bridge/pci_expander_bridge_cxl.h
similarity index 100%
rename from include/hw/pci-bridge/pci_expander_bridge.h
rename to include/hw/pci-bridge/pci_expander_bridge_cxl.h
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index e279ce5fe3..cda4dfed50 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -20,7 +20,7 @@
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_host.h"
 #include "hw/pci/pcie_port.h"
-#include "hw/pci-bridge/pci_expander_bridge.h"
+#include "hw/pci-bridge/pci_expander_bridge_cxl.h"
 
 static void cxl_fixed_memory_window_config(CXLFixedMemoryWindowOptions *object,
                                            int index, Error **errp)
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 40ffbc4e08..2498df480b 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -18,57 +18,29 @@
 #include "hw/pci/pcie_port.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/pci/pci_bridge.h"
-#include "hw/pci-bridge/pci_expander_bridge.h"
-#include "hw/cxl/cxl.h"
 #include "qemu/range.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "system/numa.h"
 #include "hw/core/boards.h"
 #include "qom/object.h"
-
-enum BusType { PCI, PCIE, CXL };
+#include "pci_expander_bridge_common.h"
 
 #define TYPE_PXB_BUS "pxb-bus"
-typedef struct PXBBus PXBBus;
+
 DECLARE_INSTANCE_CHECKER(PXBBus, PXB_BUS,
                          TYPE_PXB_BUS)
 
 DECLARE_INSTANCE_CHECKER(PXBBus, PXB_PCIE_BUS,
                          TYPE_PXB_PCIE_BUS)
 
-DECLARE_INSTANCE_CHECKER(PXBBus, PXB_CXL_BUS,
-                         TYPE_PXB_CXL_BUS)
-
-struct PXBBus {
-    /*< private >*/
-    PCIBus parent_obj;
-    /*< public >*/
-
-    char bus_path[8];
-};
-
 OBJECT_DECLARE_SIMPLE_TYPE(PXBPCIEDev, PXB_PCIE_DEV)
 
 static GList *pxb_dev_list;
 
 #define TYPE_PXB_HOST "pxb-host"
 
-CXLComponentState *cxl_get_hb_cstate(PCIHostState *hb)
-{
-    CXLHost *host = PXB_CXL_HOST(hb);
-
-    return &host->cxl_cstate;
-}
-
-bool cxl_get_hb_passthrough(PCIHostState *hb)
-{
-    CXLHost *host = PXB_CXL_HOST(hb);
-
-    return host->passthrough;
-}
-
-static int pxb_bus_num(PCIBus *bus)
+int pxb_bus_num(PCIBus *bus)
 {
     PXBDev *pxb = PXB_DEV(bus->parent_dev);
 
@@ -96,7 +68,7 @@ static void prop_pxb_uid_get(Object *obj, Visitor *v, const char *name,
     visit_type_uint32(v, name, &uid, errp);
 }
 
-static void pxb_bus_class_init(ObjectClass *class, const void *data)
+void pxb_bus_class_init(ObjectClass *class, const void *data)
 {
     PCIBusClass *pbc = PCI_BUS_CLASS(class);
 
@@ -123,20 +95,11 @@ static const TypeInfo pxb_pcie_bus_info = {
     .class_init    = pxb_bus_class_init,
 };
 
-static const TypeInfo pxb_cxl_bus_info = {
-    .name          = TYPE_PXB_CXL_BUS,
-    .parent        = TYPE_CXL_BUS,
-    .instance_size = sizeof(PXBBus),
-    .class_init    = pxb_bus_class_init,
-};
-
 static const char *pxb_host_root_bus_path(PCIHostState *host_bridge,
                                           PCIBus *rootbus)
 {
-    PXBBus *bus = pci_bus_is_cxl(rootbus) ?
-                      PXB_CXL_BUS(rootbus) :
-                      pci_bus_is_express(rootbus) ? PXB_PCIE_BUS(rootbus) :
-                                                    PXB_BUS(rootbus);
+    PXBBus *bus = pci_bus_is_express(rootbus) ?
+        PXB_PCIE_BUS(rootbus) : PXB_BUS(rootbus);
 
     snprintf(bus->bus_path, 8, "0000:%02x", pxb_bus_num(rootbus));
     return bus->bus_path;
@@ -192,64 +155,6 @@ static const TypeInfo pxb_host_info = {
     .class_init    = pxb_host_class_init,
 };
 
-static void pxb_cxl_realize(DeviceState *dev, Error **errp)
-{
-    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
-    CXLHost *cxl = PXB_CXL_HOST(dev);
-    CXLComponentState *cxl_cstate = &cxl->cxl_cstate;
-    struct MemoryRegion *mr = &cxl_cstate->crb.component_registers;
-
-    cxl_component_register_block_init(OBJECT(dev), cxl_cstate,
-                                      TYPE_PXB_CXL_HOST);
-    sysbus_init_mmio(sbd, mr);
-}
-
-/*
- * Host bridge realization has no means of knowning state associated
- * with a particular machine. As such, it is nececssary to delay
- * final setup of the host bridge register space until later in the
- * machine bring up.
- */
-void pxb_cxl_hook_up_registers(CXLState *cxl_state, PCIBus *bus, Error **errp)
-{
-    PXBCXLDev *pxb =  PXB_CXL_DEV(pci_bridge_get_device(bus));
-    CXLHost *cxl = pxb->cxl_host_bridge;
-    CXLComponentState *cxl_cstate = &cxl->cxl_cstate;
-    struct MemoryRegion *mr = &cxl_cstate->crb.component_registers;
-    hwaddr offset;
-
-    offset = memory_region_size(mr) * cxl_state->next_mr_idx;
-    if (offset > memory_region_size(&cxl_state->host_mr)) {
-        error_setg(errp, "Insufficient space for pxb cxl host register space");
-        return;
-    }
-
-    memory_region_add_subregion(&cxl_state->host_mr, offset, mr);
-    cxl_state->next_mr_idx++;
-}
-
-static void pxb_cxl_host_class_init(ObjectClass *class, const void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(class);
-    PCIHostBridgeClass *hc = PCI_HOST_BRIDGE_CLASS(class);
-
-    hc->root_bus_path = pxb_host_root_bus_path;
-    dc->fw_name = "cxl";
-    dc->realize = pxb_cxl_realize;
-    /* Reason: Internal part of the pxb/pxb-pcie device, not usable by itself */
-    dc->user_creatable = false;
-}
-
-/*
- * This is a device to handle the MMIO for a CXL host bridge. It does nothing
- * else.
- */
-static const TypeInfo cxl_host_info = {
-    .name          = TYPE_PXB_CXL_HOST,
-    .parent        = TYPE_PCI_HOST_BRIDGE,
-    .instance_size = sizeof(CXLHost),
-    .class_init    = pxb_cxl_host_class_init,
-};
 
 /*
  * Registers the PXB bus as a child of pci host root bus.
@@ -297,34 +202,6 @@ static int pxb_map_irq_fn(PCIDevice *pci_dev, int pin)
     return pin - PCI_SLOT(pxb->devfn);
 }
 
-static void pxb_cxl_dev_reset(DeviceState *dev)
-{
-    CXLHost *cxl = PXB_CXL_DEV(dev)->cxl_host_bridge;
-    CXLComponentState *cxl_cstate = &cxl->cxl_cstate;
-    PCIHostState *hb = PCI_HOST_BRIDGE(cxl);
-    uint32_t *reg_state = cxl_cstate->crb.cache_mem_registers;
-    uint32_t *write_msk = cxl_cstate->crb.cache_mem_regs_write_mask;
-    int dsp_count = 0;
-
-    cxl_component_register_init_common(reg_state, write_msk, CXL2_RC, false);
-    /*
-     * The CXL specification allows for host bridges with no HDM decoders
-     * if they only have a single root port.
-     */
-    if (!PXB_CXL_DEV(dev)->hdm_for_passthrough) {
-        dsp_count = pcie_count_ds_ports(hb->bus);
-    }
-    /* Initial reset will have 0 dsp so wait until > 0 */
-    if (dsp_count == 1) {
-        cxl->passthrough = true;
-        /* Set Capability ID in header to NONE */
-        ARRAY_FIELD_DP32(reg_state, CXL_HDM_CAPABILITY_HEADER, ID, 0);
-    } else {
-        ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, TARGET_COUNT,
-                         8);
-    }
-}
-
 static gint pxb_compare(gconstpointer a, gconstpointer b)
 {
     const PXBDev *pxb_a = a, *pxb_b = b;
@@ -334,8 +211,8 @@ static gint pxb_compare(gconstpointer a, gconstpointer b)
            0;
 }
 
-static bool pxb_dev_realize_common(PCIDevice *dev, enum BusType type,
-                                   Error **errp)
+bool pxb_dev_realize_common(PCIDevice *dev, enum BusType type,
+                            Error **errp)
 {
     PXBDev *pxb = PXB_DEV(dev);
     DeviceState *ds, *bds = NULL;
@@ -417,7 +294,7 @@ static void pxb_dev_realize(PCIDevice *dev, Error **errp)
     pxb_dev_realize_common(dev, PCI, errp);
 }
 
-static void pxb_dev_exitfn(PCIDevice *pci_dev)
+void pxb_dev_exitfn(PCIDevice *pci_dev)
 {
     PXBDev *pxb = PXB_DEV(pci_dev);
 
@@ -496,67 +373,14 @@ static const TypeInfo pxb_pcie_dev_info = {
     },
 };
 
-static void pxb_cxl_dev_realize(PCIDevice *dev, Error **errp)
-{
-    /* A CXL PXB's parent bus is still PCIe */
-    if (!pci_bus_is_express(pci_get_bus(dev))) {
-        error_setg(errp, "pxb-cxl devices cannot reside on a PCI bus");
-        return;
-    }
-
-    if (!pxb_dev_realize_common(dev, CXL, errp)) {
-        return;
-    }
-    pxb_cxl_dev_reset(DEVICE(dev));
-}
-
-static const Property pxb_cxl_dev_properties[] = {
-    DEFINE_PROP_BOOL("hdm_for_passthrough", PXBCXLDev, hdm_for_passthrough, false),
-};
-
-static void pxb_cxl_dev_class_init(ObjectClass *klass, const void *data)
-{
-    DeviceClass *dc   = DEVICE_CLASS(klass);
-    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
-
-    k->realize             = pxb_cxl_dev_realize;
-    k->exit                = pxb_dev_exitfn;
-    /*
-     * XXX: These types of bridges don't actually show up in the hierarchy so
-     * vendor, device, class, etc. ids are intentionally left out.
-     */
-
-    dc->desc = "CXL Host Bridge";
-    device_class_set_props(dc, pxb_cxl_dev_properties);
-    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
-
-    /* Host bridges aren't hotpluggable. FIXME: spec reference */
-    dc->hotpluggable = false;
-    device_class_set_legacy_reset(dc, pxb_cxl_dev_reset);
-}
-
-static const TypeInfo pxb_cxl_dev_info = {
-    .name          = TYPE_PXB_CXL_DEV,
-    .parent        = TYPE_PXB_PCIE_DEV,
-    .instance_size = sizeof(PXBCXLDev),
-    .class_init    = pxb_cxl_dev_class_init,
-    .interfaces =
-        (const InterfaceInfo[]){
-            { INTERFACE_CONVENTIONAL_PCI_DEVICE },
-            {},
-        },
-};
 
 static void pxb_register_types(void)
 {
     type_register_static(&pxb_bus_info);
     type_register_static(&pxb_pcie_bus_info);
-    type_register_static(&pxb_cxl_bus_info);
     type_register_static(&pxb_host_info);
-    type_register_static(&cxl_host_info);
     type_register_static(&pxb_dev_info);
     type_register_static(&pxb_pcie_dev_info);
-    type_register_static(&pxb_cxl_dev_info);
 }
 
 type_init(pxb_register_types)
diff --git a/hw/pci-bridge/pci_expander_bridge_cxl.c b/hw/pci-bridge/pci_expander_bridge_cxl.c
new file mode 100644
index 0000000000..ceb8928f8f
--- /dev/null
+++ b/hw/pci-bridge/pci_expander_bridge_cxl.c
@@ -0,0 +1,201 @@
+/*
+ * CXL PCI Expander Bridge Device Emulation
+ *
+ * Copyright (C) 2015 Red Hat Inc
+ *
+ * Authors:
+ *   Marcel Apfelbaum <marcel@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/pci_bus.h"
+#include "hw/pci/pci_bridge.h"
+#include "hw/pci/pcie_port.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/pci-bridge/pci_expander_bridge_cxl.h"
+#include "qom/object.h"
+#include "pci_expander_bridge_common.h"
+
+DECLARE_INSTANCE_CHECKER(PXBBus, PXB_CXL_BUS,
+                         TYPE_PXB_CXL_BUS)
+
+CXLComponentState *cxl_get_hb_cstate(PCIHostState *hb)
+{
+    CXLHost *host = PXB_CXL_HOST(hb);
+
+    return &host->cxl_cstate;
+}
+
+bool cxl_get_hb_passthrough(PCIHostState *hb)
+{
+    CXLHost *host = PXB_CXL_HOST(hb);
+
+    return host->passthrough;
+}
+
+static const char *pxb_cxl_host_root_bus_path(PCIHostState *host_bridge,
+                                              PCIBus *rootbus)
+{
+    PXBBus *bus = PXB_CXL_BUS(rootbus);
+    snprintf(bus->bus_path, 8, "0000:%02x", pxb_bus_num(rootbus));
+    return bus->bus_path;
+}
+
+
+static const TypeInfo pxb_cxl_bus_info = {
+    .name          = TYPE_PXB_CXL_BUS,
+    .parent        = TYPE_CXL_BUS,
+    .instance_size = sizeof(PXBBus),
+    .class_init    = pxb_bus_class_init,
+};
+
+static void pxb_cxl_realize(DeviceState *dev, Error **errp)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    CXLHost *cxl = PXB_CXL_HOST(dev);
+    CXLComponentState *cxl_cstate = &cxl->cxl_cstate;
+    struct MemoryRegion *mr = &cxl_cstate->crb.component_registers;
+
+    cxl_component_register_block_init(OBJECT(dev), cxl_cstate,
+                                      TYPE_PXB_CXL_HOST);
+    sysbus_init_mmio(sbd, mr);
+}
+
+/*
+ * Host bridge realization has no means of knowning state associated
+ * with a particular machine. As such, it is nececssary to delay
+ * final setup of the host bridge register space until later in the
+ * machine bring up.
+ */
+void pxb_cxl_hook_up_registers(CXLState *cxl_state, PCIBus *bus, Error **errp)
+{
+    PXBCXLDev *pxb =  PXB_CXL_DEV(pci_bridge_get_device(bus));
+    CXLHost *cxl = pxb->cxl_host_bridge;
+    CXLComponentState *cxl_cstate = &cxl->cxl_cstate;
+    struct MemoryRegion *mr = &cxl_cstate->crb.component_registers;
+    hwaddr offset;
+
+    offset = memory_region_size(mr) * cxl_state->next_mr_idx;
+    if (offset > memory_region_size(&cxl_state->host_mr)) {
+        error_setg(errp, "Insufficient space for pxb cxl host register space");
+        return;
+    }
+
+    memory_region_add_subregion(&cxl_state->host_mr, offset, mr);
+    cxl_state->next_mr_idx++;
+}
+
+static void pxb_cxl_host_class_init(ObjectClass *class, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(class);
+    PCIHostBridgeClass *hc = PCI_HOST_BRIDGE_CLASS(class);
+
+    hc->root_bus_path = pxb_cxl_host_root_bus_path;
+    dc->fw_name = "cxl";
+    dc->realize = pxb_cxl_realize;
+    /* Reason: Internal part of the pxb/pxb-pcie device, not usable by itself */
+    dc->user_creatable = false;
+}
+
+/*
+ * This is a device to handle the MMIO for a CXL host bridge. It does nothing
+ * else.
+ */
+static const TypeInfo cxl_host_info = {
+    .name          = TYPE_PXB_CXL_HOST,
+    .parent        = TYPE_PCI_HOST_BRIDGE,
+    .instance_size = sizeof(CXLHost),
+    .class_init    = pxb_cxl_host_class_init,
+};
+
+static void pxb_cxl_dev_reset(DeviceState *dev)
+{
+    CXLHost *cxl = PXB_CXL_DEV(dev)->cxl_host_bridge;
+    CXLComponentState *cxl_cstate = &cxl->cxl_cstate;
+    PCIHostState *hb = PCI_HOST_BRIDGE(cxl);
+    uint32_t *reg_state = cxl_cstate->crb.cache_mem_registers;
+    uint32_t *write_msk = cxl_cstate->crb.cache_mem_regs_write_mask;
+    int dsp_count = 0;
+
+    cxl_component_register_init_common(reg_state, write_msk, CXL2_RC, false);
+    /*
+     * The CXL specification allows for host bridges with no HDM decoders
+     * if they only have a single root port.
+     */
+    if (!PXB_CXL_DEV(dev)->hdm_for_passthrough) {
+        dsp_count = pcie_count_ds_ports(hb->bus);
+    }
+    /* Initial reset will have 0 dsp so wait until > 0 */
+    if (dsp_count == 1) {
+        cxl->passthrough = true;
+        /* Set Capability ID in header to NONE */
+        ARRAY_FIELD_DP32(reg_state, CXL_HDM_CAPABILITY_HEADER, ID, 0);
+    } else {
+        ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, TARGET_COUNT,
+                         8);
+    }
+}
+
+static void pxb_cxl_dev_realize(PCIDevice *dev, Error **errp)
+{
+    /* A CXL PXB's parent bus is still PCIe */
+    if (!pci_bus_is_express(pci_get_bus(dev))) {
+        error_setg(errp, "pxb-cxl devices cannot reside on a PCI bus");
+        return;
+    }
+
+    if (!pxb_dev_realize_common(dev, CXL, errp)) {
+        return;
+    }
+    pxb_cxl_dev_reset(DEVICE(dev));
+}
+
+static const Property pxb_cxl_dev_properties[] = {
+    DEFINE_PROP_BOOL("hdm_for_passthrough", PXBCXLDev,
+                     hdm_for_passthrough, false),
+};
+
+static void pxb_cxl_dev_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc   = DEVICE_CLASS(klass);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+
+    k->realize             = pxb_cxl_dev_realize;
+    k->exit                = pxb_dev_exitfn;
+    /*
+     * XXX: These types of bridges don't actually show up in the hierarchy so
+     * vendor, device, class, etc. ids are intentionally left out.
+     */
+
+    dc->desc = "CXL Host Bridge";
+    device_class_set_props(dc, pxb_cxl_dev_properties);
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+
+    /* Host bridges aren't hotpluggable. FIXME: spec reference */
+    dc->hotpluggable = false;
+    device_class_set_legacy_reset(dc, pxb_cxl_dev_reset);
+}
+
+static const TypeInfo pxb_cxl_dev_info = {
+    .name          = TYPE_PXB_CXL_DEV,
+    .parent        = TYPE_PXB_PCIE_DEV,
+    .instance_size = sizeof(PXBCXLDev),
+    .class_init    = pxb_cxl_dev_class_init,
+    .interfaces =
+        (const InterfaceInfo[]){
+            { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+            {},
+        },
+};
+
+static void pxb_cxl_register_types(void)
+{
+    type_register_static(&pxb_cxl_bus_info);
+    type_register_static(&cxl_host_info);
+    type_register_static(&pxb_cxl_dev_info);
+}
+
+type_init(pxb_cxl_register_types)
diff --git a/hw/pci-bridge/pci_expander_bridge_stubs.c b/hw/pci-bridge/pci_expander_bridge_stubs.c
deleted file mode 100644
index b35180311f..0000000000
--- a/hw/pci-bridge/pci_expander_bridge_stubs.c
+++ /dev/null
@@ -1,14 +0,0 @@
-/*
- * SPDX-License-Identifier: GPL-2.0-or-later
- *
- * Stubs for calls made from machines to handle the case where CONFIG_PXB
- * is not enabled.
- */
-#include "qemu/osdep.h"
-#include "qapi/error.h"
-#include "hw/pci/pci.h"
-#include "hw/pci/pci_bus.h"
-#include "hw/pci-bridge/pci_expander_bridge.h"
-#include "hw/cxl/cxl.h"
-
-void pxb_cxl_hook_up_registers(CXLState *state, PCIBus *bus, Error **errp) {};
diff --git a/hw/pci-bridge/meson.build b/hw/pci-bridge/meson.build
index aa9959df04..563d3f5147 100644
--- a/hw/pci-bridge/meson.build
+++ b/hw/pci-bridge/meson.build
@@ -6,7 +6,7 @@ pci_ss.add(when: 'CONFIG_PCIE_PORT', if_true: files('pcie_root_port.c', 'gen_pci
                                                     'gen_pcie_upstream_port.c', 'gen_pcie_downstream_port.c'))
 pci_ss.add(when: 'CONFIG_PCIE_PCI_BRIDGE', if_true: files('pcie_pci_bridge.c'))
 pci_ss.add(when: 'CONFIG_PXB', if_true: files('pci_expander_bridge.c'))
-stub_ss.add(files('pci_expander_bridge_stubs.c'))
+pci_ss.add(when: 'CONFIG_CXL', if_true: files('pci_expander_bridge_cxl.c'))
 pci_ss.add(when: 'CONFIG_XIO3130', if_true: files('xio3130_upstream.c', 'xio3130_downstream.c'))
 pci_ss.add(when: 'CONFIG_CXL', if_true: files('cxl_root_port.c', 'cxl_upstream.c', 'cxl_downstream.c'))
 
-- 
MST


