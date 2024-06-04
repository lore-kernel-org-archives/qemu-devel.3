Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 971C3C27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 19:08:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEZVz-0005Dw-Av; Tue, 04 Jun 2024 15:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZVx-00052h-Ac
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:08:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZVu-0000z7-Q5
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:08:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717528085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FToX8nMommt2bWG5vJjpEFOZKUdMNE6ay6dx9s5p/pc=;
 b=LYrj1OfyOPibPTBit0wtVJbRIrqJibYl/E9j0xDx9tSRzuf6m2KjyJ7AbkEgUEZs3+x2Jp
 NH6KgjiKPEXoYLqKJ2Vv05c/uj7N/XVaEzXIQQR8mtkr8v3qrgxgLsLo4v9PUU+mNbl4Pp
 9kTjVk7cjwlgrhGwTf2JRLbnm0AZCh8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-Sl8Vm8k6O8-Kw6J4rF8UTQ-1; Tue, 04 Jun 2024 15:08:04 -0400
X-MC-Unique: Sl8Vm8k6O8-Kw6J4rF8UTQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42155e1f0aaso2906695e9.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 12:08:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717528082; x=1718132882;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FToX8nMommt2bWG5vJjpEFOZKUdMNE6ay6dx9s5p/pc=;
 b=M7YYTVpYJAW4FZOyegrKbWdQlnGPPOL50bKhfn33eJ1YagWVdPi3dIthZfY8vuj5Rl
 4WCU0KwkrV1Ht1aOosEbFxsfnUM0eL9ea+kkNpJXkzg6ibG9diqgN14DX4aKKGsBwasf
 M6LetaTGcLx7/KszlwceqkQFMy05TSkj4DaX9+OcvbjIlCq41Pd1ZLFT71ip0hjwAAEW
 /WW2XLg/YgyGPP4LUwqzBsMDT8DcUhTQDKcdj0NfTw+k6a7LbPDsaUlpl4IVx08W4RgG
 3nMeohVlr4KgphB87HUhAabkFyVUnzXba7BBmm3HqRzf/DPsgyKrC1VRLy/nOEvKM8mx
 c8+g==
X-Gm-Message-State: AOJu0YxKYg2UK6/BcKR4X7Crlj0M2l2uKEri59JgyOXfzwB6aUDCgLGx
 uEpTvCjElh2ainbt+tvc1LmNMiN7wP5Q2fPgjg4m0hgXCeWPRr3o4Ew9n34Eb145C+Z4dNz1IVd
 q/T5Sc7C+aBc0eioYmQMSBFTaT1izw6TiUhNXb4fsoQUd8++x2xNQlXiSgNYKkBHcxwQRbmnql0
 PGrhVP9vilLWasU8CvL9rqhieePWoBkQ==
X-Received: by 2002:a05:600c:444b:b0:41b:e244:164a with SMTP id
 5b1f17b1804b1-421562c3371mr4845065e9.6.1717528082218; 
 Tue, 04 Jun 2024 12:08:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJaOL/+OkRJVs75/qdfBNOPf62huFZURwenKy52bPDuJru+73jhPReJeXni0XtkFQNi188QA==
X-Received: by 2002:a05:600c:444b:b0:41b:e244:164a with SMTP id
 5b1f17b1804b1-421562c3371mr4844795e9.6.1717528081610; 
 Tue, 04 Jun 2024 12:08:01 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:552:cf5c:2b13:215c:b9df:f231])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd064b030sm12422694f8f.105.2024.06.04.12.07.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 12:07:57 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:07:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 33/46] hw/acpi: Generic Port Affinity Structure support
Message-ID: <b2366d461b9133880913d84742f120d14222a6e6.1717527933.git.mst@redhat.com>
References: <cover.1717527933.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1717527933.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

These are very similar to the recently added Generic Initiators
but instead of representing an initiator of memory traffic they
represent an edge point beyond which may lie either targets or
initiators.  Here we add these ports such that they may
be targets of hmat_lb records to describe the latency and
bandwidth from host side initiators to the port.  A descoverable
mechanism such as UEFI CDAT read from CXL devices and switches
is used to discover the remainder fo the path and the OS can build
up full latency and bandwidth numbers as need for work and data
placement decisions.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240524100507.32106-4-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 qapi/qom.json                            |  35 ++++++
 include/hw/acpi/acpi_generic_initiator.h |  18 ++-
 include/hw/pci/pci_bridge.h              |   1 +
 hw/acpi/acpi_generic_initiator.c         | 145 +++++++++++++++++------
 hw/pci-bridge/pci_expander_bridge.c      |   1 -
 5 files changed, 160 insertions(+), 40 deletions(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index 38dde6d785..9d1d86bdad 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -826,6 +826,39 @@
   'data': { 'pci-dev': 'str',
             'node': 'uint32' } }
 
+
+##
+# @AcpiGenericPortProperties:
+#
+# Properties for acpi-generic-port objects.
+#
+# @pci-bus: QOM path of the PCI bus of the hostbridge associated with
+#     this SRAT Generic Port Affinity Structure.  This is the same as
+#     the bus parameter for the root ports attached to this host bridge.
+#     The resulting SRAT Generic Port Affinity Structure will refer to
+#     the ACPI object in DSDT that represents the host bridge (e.g.
+#     ACPI0016 for CXL host bridges.) See ACPI 6.5 Section 5.2.16.7 for
+#     more information.
+#
+# @node: Similar to a NUMA node ID, but instead of providing a reference
+#     point used for defining NUMA distances and access characteristics
+#     to memory or from an initiator (e.g. CPU), this node defines the
+#     boundary point between non-discoverable system buses which must be
+#     described by firmware, and a discoverable bus.  NUMA distances
+#     and access characteristics are defined to and from that point.
+#     For system software to establish full initiator to target
+#     characteristics this information must be combined with information
+#     retrieved from the discoverable part of the path.  An example would
+#     use CDAT (see UEFI.org) information read from devices and switches
+#     in conjunction with link characteristics read from PCIe
+#     Configuration space.
+#
+# Since: 9.1
+##
+{ 'struct': 'AcpiGenericPortProperties',
+  'data': { 'pci-bus': 'str',
+            'node': 'uint32' } }
+
 ##
 # @RngProperties:
 #
@@ -953,6 +986,7 @@
 { 'enum': 'ObjectType',
   'data': [
     'acpi-generic-initiator',
+    'acpi-generic-port',
     'authz-list',
     'authz-listfile',
     'authz-pam',
@@ -1025,6 +1059,7 @@
   'discriminator': 'qom-type',
   'data': {
       'acpi-generic-initiator':     'AcpiGenericInitiatorProperties',
+      'acpi-generic-port':          'AcpiGenericPortProperties',
       'authz-list':                 'AuthZListProperties',
       'authz-listfile':             'AuthZListFileProperties',
       'authz-pam':                  'AuthZPAMProperties',
diff --git a/include/hw/acpi/acpi_generic_initiator.h b/include/hw/acpi/acpi_generic_initiator.h
index dd4be19c8f..1a899af30f 100644
--- a/include/hw/acpi/acpi_generic_initiator.h
+++ b/include/hw/acpi/acpi_generic_initiator.h
@@ -30,6 +30,12 @@ typedef struct AcpiGenericInitiator {
     AcpiGenericNode parent;
 } AcpiGenericInitiator;
 
+#define TYPE_ACPI_GENERIC_PORT "acpi-generic-port"
+
+typedef struct AcpiGenericPort {
+    AcpiGenericInitiator parent;
+} AcpiGenericPort;
+
 /*
  * ACPI 6.3:
  * Table 5-81 Flags – Generic Initiator Affinity Structure
@@ -49,8 +55,16 @@ typedef enum {
  * Table 5-80 Device Handle - PCI
  */
 typedef struct PCIDeviceHandle {
-    uint16_t segment;
-    uint16_t bdf;
+    union {
+        struct {
+            uint16_t segment;
+            uint16_t bdf;
+        };
+        struct {
+            uint64_t hid;
+            uint32_t uid;
+        };
+    };
 } PCIDeviceHandle;
 
 void build_srat_generic_pci_initiator(GArray *table_data);
diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
index 5cd452115a..5456e24883 100644
--- a/include/hw/pci/pci_bridge.h
+++ b/include/hw/pci/pci_bridge.h
@@ -102,6 +102,7 @@ typedef struct PXBPCIEDev {
     PXBDev parent_obj;
 } PXBPCIEDev;
 
+#define TYPE_PXB_CXL_BUS "pxb-cxl-bus"
 #define TYPE_PXB_DEV "pxb"
 OBJECT_DECLARE_SIMPLE_TYPE(PXBDev, PXB_DEV)
 
diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
index c054e0e27d..78b80dcf08 100644
--- a/hw/acpi/acpi_generic_initiator.c
+++ b/hw/acpi/acpi_generic_initiator.c
@@ -7,6 +7,7 @@
 #include "hw/acpi/acpi_generic_initiator.h"
 #include "hw/acpi/aml-build.h"
 #include "hw/boards.h"
+#include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_device.h"
 #include "qemu/error-report.h"
 
@@ -18,6 +19,10 @@ typedef struct AcpiGenericInitiatorClass {
      AcpiGenericNodeClass parent_class;
 } AcpiGenericInitiatorClass;
 
+typedef struct AcpiGenericPortClass {
+    AcpiGenericInitiatorClass parent;
+} AcpiGenericPortClass;
+
 OBJECT_DEFINE_ABSTRACT_TYPE(AcpiGenericNode, acpi_generic_node,
                             ACPI_GENERIC_NODE, OBJECT)
 
@@ -30,6 +35,13 @@ OBJECT_DEFINE_TYPE_WITH_INTERFACES(AcpiGenericInitiator, acpi_generic_initiator,
 
 OBJECT_DECLARE_SIMPLE_TYPE(AcpiGenericInitiator, ACPI_GENERIC_INITIATOR)
 
+OBJECT_DEFINE_TYPE_WITH_INTERFACES(AcpiGenericPort, acpi_generic_port,
+                   ACPI_GENERIC_PORT, ACPI_GENERIC_NODE,
+                   { TYPE_USER_CREATABLE },
+                   { NULL })
+
+OBJECT_DECLARE_SIMPLE_TYPE(AcpiGenericPort, ACPI_GENERIC_PORT)
+
 static void acpi_generic_node_init(Object *obj)
 {
     AcpiGenericNode *gn = ACPI_GENERIC_NODE(obj);
@@ -53,6 +65,14 @@ static void acpi_generic_initiator_finalize(Object *obj)
 {
 }
 
+static void acpi_generic_port_init(Object *obj)
+{
+}
+
+static void acpi_generic_port_finalize(Object *obj)
+{
+}
+
 static void acpi_generic_node_set_pci_device(Object *obj, const char *val,
                                              Error **errp)
 {
@@ -79,42 +99,61 @@ static void acpi_generic_node_set_node(Object *obj, Visitor *v,
     }
 
     gn->node = value;
-    ms->numa_state->nodes[gn->node].has_gi = true;
+    if (object_dynamic_cast(obj, TYPE_ACPI_GENERIC_INITIATOR)) {
+        ms->numa_state->nodes[gn->node].has_gi = true;
+    }
 }
 
 static void acpi_generic_node_class_init(ObjectClass *oc, void *data)
 {
-    object_class_property_add_str(oc, "pci-dev", NULL,
-        acpi_generic_node_set_pci_device);
     object_class_property_add(oc, "node", "int", NULL,
         acpi_generic_node_set_node, NULL, NULL);
 }
 
 static void acpi_generic_initiator_class_init(ObjectClass *oc, void *data)
 {
+    object_class_property_add_str(oc, "pci-dev", NULL,
+        acpi_generic_node_set_pci_device);
+}
+
+static void acpi_generic_port_class_init(ObjectClass *oc, void *data)
+{
+    /*
+     * Despite the ID representing a root bridge bus, same storage
+     * can be used.
+     */
+    object_class_property_add_str(oc, "pci-bus", NULL,
+        acpi_generic_node_set_pci_device);
 }
 
 /*
  * ACPI 6.3:
  * Table 5-78 Generic Initiator Affinity Structure
+ * ACPI 6.5:
+ * Table 5-67 Generic Port Affinity Structure
  */
 static void
-build_srat_generic_pci_initiator_affinity(GArray *table_data, int node,
-                                          PCIDeviceHandle *handle)
+build_srat_generic_node_affinity(GArray *table_data, int node,
+                                 PCIDeviceHandle *handle, bool gp, bool pci)
 {
-    uint8_t index;
-
-    build_append_int_noprefix(table_data, 5, 1);  /* Type */
+    build_append_int_noprefix(table_data, gp ? 6 : 5, 1);  /* Type */
     build_append_int_noprefix(table_data, 32, 1); /* Length */
     build_append_int_noprefix(table_data, 0, 1);  /* Reserved */
-    build_append_int_noprefix(table_data, 1, 1);  /* Device Handle Type: PCI */
+    /* Device Handle Type: PCI / ACPI */
+    build_append_int_noprefix(table_data, pci ? 1 : 0, 1);
     build_append_int_noprefix(table_data, node, 4);  /* Proximity Domain */
 
     /* Device Handle - PCI */
-    build_append_int_noprefix(table_data, handle->segment, 2);
-    build_append_int_noprefix(table_data, handle->bdf, 2);
-    for (index = 0; index < 12; index++) {
-        build_append_int_noprefix(table_data, 0, 1);
+    if (pci) {
+        /* Device Handle - PCI */
+        build_append_int_noprefix(table_data, handle->segment, 2);
+        build_append_int_noprefix(table_data, handle->bdf, 2);
+        build_append_int_noprefix(table_data, 0, 12);
+    } else {
+        /* Device Handle - ACPI */
+        build_append_int_noprefix(table_data, handle->hid, 8);
+        build_append_int_noprefix(table_data, handle->uid, 4);
+        build_append_int_noprefix(table_data, 0, 4);
     }
 
     build_append_int_noprefix(table_data, GEN_AFFINITY_ENABLED, 4); /* Flags */
@@ -127,37 +166,69 @@ static int build_all_acpi_generic_initiators(Object *obj, void *opaque)
     GArray *table_data = opaque;
     PCIDeviceHandle dev_handle;
     AcpiGenericNode *gn;
-    PCIDevice *pci_dev;
     Object *o;
 
-    if (!object_dynamic_cast(obj, TYPE_ACPI_GENERIC_INITIATOR)) {
+    if (!object_dynamic_cast(obj, TYPE_ACPI_GENERIC_NODE)) {
         return 0;
     }
 
     gn = ACPI_GENERIC_NODE(obj);
-    if (gn->node >= ms->numa_state->num_nodes) {
-        error_printf("%s: Specified node %d is invalid.\n",
-                     TYPE_ACPI_GENERIC_INITIATOR, gn->node);
-        exit(1);
+
+    if (object_dynamic_cast(OBJECT(gn), TYPE_ACPI_GENERIC_INITIATOR)) {
+        PCIDevice *pci_dev;
+
+        if (gn->node >= ms->numa_state->num_nodes) {
+            error_printf("%s: node %d is invalid.\n",
+                         TYPE_ACPI_GENERIC_INITIATOR, gn->node);
+            exit(1);
+        }
+
+        o = object_resolve_path_type(gn->pci_dev, TYPE_PCI_DEVICE, NULL);
+        if (!o) {
+            error_printf("%s: device must be a PCI device.\n",
+                         TYPE_ACPI_GENERIC_INITIATOR);
+            exit(1);
+        }
+        pci_dev = PCI_DEVICE(o);
+
+        dev_handle.segment = 0;
+        dev_handle.bdf = PCI_BUILD_BDF(pci_bus_num(pci_get_bus(pci_dev)),
+                                       pci_dev->devfn);
+        build_srat_generic_node_affinity(table_data,
+                                         gn->node, &dev_handle, false, true);
+
+        return 0;
+    } else { /* TYPE_ACPI_GENERIC_PORT */
+        PCIBus *bus;
+        const char *hid = "ACPI0016";
+
+        if (gn->node >= ms->numa_state->num_nodes) {
+            error_printf("%s: node %d is invalid.\n",
+                         TYPE_ACPI_GENERIC_PORT, gn->node);
+            exit(1);
+        }
+
+        o = object_resolve_path_type(gn->pci_dev, TYPE_PCI_BUS, NULL);
+        if (!o) {
+            error_printf("%s: device must be a PCI host bridge.\n",
+                         TYPE_ACPI_GENERIC_PORT);
+            exit(1);
+        }
+        bus = PCI_BUS(o);
+        /* Need to know if this is a PXB Bus so below an expander bridge */
+        if (!object_dynamic_cast(OBJECT(bus), TYPE_PXB_CXL_BUS)) {
+            error_printf("%s: device is not a bus below a host bridge.\n",
+                         TYPE_ACPI_GENERIC_PORT);
+            exit(1);
+        }
+        /* Copy without trailing NULL */
+        memcpy(&dev_handle.hid, hid, sizeof(dev_handle.hid));
+        dev_handle.uid = pci_bus_num(bus);
+        build_srat_generic_node_affinity(table_data,
+                                         gn->node, &dev_handle, true, false);
+
+        return 0;
     }
-
-    o = object_resolve_path_type(gn->pci_dev, TYPE_PCI_DEVICE, NULL);
-    if (!o) {
-        error_printf("%s: Specified device must be a PCI device.\n",
-                     TYPE_ACPI_GENERIC_INITIATOR);
-        exit(1);
-    }
-
-    pci_dev = PCI_DEVICE(o);
-
-    dev_handle.segment = 0;
-    dev_handle.bdf = PCI_BUILD_BDF(pci_bus_num(pci_get_bus(pci_dev)),
-                                   pci_dev->devfn);
-
-    build_srat_generic_pci_initiator_affinity(table_data,
-                                              gn->node, &dev_handle);
-
-    return 0;
 }
 
 void build_srat_generic_pci_initiator(GArray *table_data)
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 0411ad31ea..f5431443b9 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -38,7 +38,6 @@ DECLARE_INSTANCE_CHECKER(PXBBus, PXB_BUS,
 DECLARE_INSTANCE_CHECKER(PXBBus, PXB_PCIE_BUS,
                          TYPE_PXB_PCIE_BUS)
 
-#define TYPE_PXB_CXL_BUS "pxb-cxl-bus"
 DECLARE_INSTANCE_CHECKER(PXBBus, PXB_CXL_BUS,
                          TYPE_PXB_CXL_BUS)
 
-- 
MST


