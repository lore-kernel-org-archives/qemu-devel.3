Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE7ABC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:34:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAd6-0004iy-Oo; Tue, 12 Mar 2024 18:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAbw-0002nx-Vd
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:28:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAbo-0004Ya-Ro
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:28:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NKjNHtkXPHoAzSk29a1QOldo8lgRrG30XA8l+09SuTY=;
 b=TBQTCnpogQ4IC1wKf3NIQZBCofqbCQMDvzPcs+tNI2OHqCrz0l7ba72AGR82ZS1N4Gcyu/
 TP0AvVqpQs4X+0/KjNuxNeLM5bH0JkwfV2EItqPWEwX1OFuD3G9W3BeAzq3rphRF5vbQeb
 JPMnDmBqPxesQQt6pEUsho1GZ5wOpAc=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-L4dEMc-RPeqzurL0GXCX0g-1; Tue, 12 Mar 2024 18:28:30 -0400
X-MC-Unique: L4dEMc-RPeqzurL0GXCX0g-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-513b1027dd5so2937228e87.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:28:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282508; x=1710887308;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NKjNHtkXPHoAzSk29a1QOldo8lgRrG30XA8l+09SuTY=;
 b=NBwMz7hjsQ2psE6oSLZNaNCE2xjrcZZxtmxgEVruCc25l/eBx571+kMAzGAOMwWkhY
 GjDkksqqT6NQ2zxzddKv/ZnAyiV1gGufn/8AXJtNQDnGmPk3XP2515FlxM2NCoC7rDxY
 3Qpvcm0schVN1xoG2wLFvoIOsDaLCVYXPquddSvc7qxbq6QV26cRcU6yAbKLAUHr5m2H
 iKfojni2wMdyxnqsqbb6zTZaMPjn6fersLbzGQP2oT5hWdcGXDeLOWdJl9Ww+26wa5PK
 fCNN4/KXTdklw8nfG2pvs4V73gwbobNl8eI6FOXYZByWxev04vMFZ6j5/Dv+0FE2nN6+
 kO7w==
X-Gm-Message-State: AOJu0YwGw0Qky27GAHttOSawGq6geQJa+99wP7/OOBfpg24nmrDDrC+z
 L00nGZgdxIsgQjvh/7mlKpiZVmnO97BQntjkIX6kmyV0zSwgpSpe4SUTFvDrM0GsSm6RmFTgr0B
 RFRMQ0yvl72VbwG/XBvlGFbQCCvCKpzt3hrnxCzFVZGG44ItDiBakOnXXoeEFUWcTpww74E5L4u
 lknFGt4hdqKfEsWyT1hX+73a/u7bmZlKJj
X-Received: by 2002:a19:434f:0:b0:513:c147:e66a with SMTP id
 m15-20020a19434f000000b00513c147e66amr1654656lfj.32.1710282508251; 
 Tue, 12 Mar 2024 15:28:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+BIPJVZdOHVJ0RQIqDpf/EIIkrKAzl+iLCPO9VtEntktC4BqJ3KZ+X1Rlv73oEAOwqvj8Gw==
X-Received: by 2002:a19:434f:0:b0:513:c147:e66a with SMTP id
 m15-20020a19434f000000b00513c147e66amr1654633lfj.32.1710282507743; 
 Tue, 12 Mar 2024 15:28:27 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 ho14-20020a1709070e8e00b00a44d3847811sm4254673ejc.102.2024.03.12.15.28.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:28:27 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:28:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ankit Agrawal <ankita@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>
Subject: [PULL 54/68] qom: new object to associate device to NUMA node
Message-ID: <b64b7ed8bb5d475eab3b4188ef0076e332937c62.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710282274.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Ankit Agrawal <ankita@nvidia.com>

NVIDIA GPU's support MIG (Mult-Instance GPUs) feature [1], which allows
partitioning of the GPU device resources (including device memory) into
several (upto 8) isolated instances. Each of the partitioned memory needs
a dedicated NUMA node to operate. The partitions are not fixed and they
can be created/deleted at runtime.

Unfortunately Linux OS does not provide a means to dynamically create/destroy
NUMA nodes and such feature implementation is not expected to be trivial. The
nodes that OS discovers at the boot time while parsing SRAT remains fixed. So
we utilize the Generic Initiator (GI) Affinity structures that allows
association between nodes and devices. Multiple GI structures per BDF is
possible, allowing creation of multiple nodes by exposing unique PXM in each
of these structures.

Implement the mechanism to build the GI affinity structures as Qemu currently
does not. Introduce a new acpi-generic-initiator object to allow host admin
link a device with an associated NUMA node. Qemu maintains this association
and use this object to build the requisite GI Affinity Structure.

When multiple NUMA nodes are associated with a device, it is required to
create those many number of acpi-generic-initiator objects, each representing
a unique device:node association.

Following is one of a decoded GI affinity structure in VM ACPI SRAT.
[0C8h 0200   1]                Subtable Type : 05 [Generic Initiator Affinity]
[0C9h 0201   1]                       Length : 20

[0CAh 0202   1]                    Reserved1 : 00
[0CBh 0203   1]           Device Handle Type : 01
[0CCh 0204   4]             Proximity Domain : 00000007
[0D0h 0208  16]                Device Handle : 00 00 20 00 00 00 00 00 00 00 00
00 00 00 00 00
[0E0h 0224   4]        Flags (decoded below) : 00000001
                                     Enabled : 1
[0E4h 0228   4]                    Reserved2 : 00000000

[0E8h 0232   1]                Subtable Type : 05 [Generic Initiator Affinity]
[0E9h 0233   1]                       Length : 20

An admin can provide a range of acpi-generic-initiator objects, each
associating a device (by providing the id through pci-dev argument)
to the desired NUMA node (using the node argument). Currently, only PCI
device is supported.

For the grace hopper system, create a range of 8 nodes and associate that
with the device using the acpi-generic-initiator object. While a configuration
of less than 8 nodes per device is allowed, such configuration will prevent
utilization of the feature to the fullest. The following sample creates 8
nodes per PCI device for a VM with 2 PCI devices and link them to the
respecitve PCI device using acpi-generic-initiator objects:

-numa node,nodeid=2 -numa node,nodeid=3 -numa node,nodeid=4 \
-numa node,nodeid=5 -numa node,nodeid=6 -numa node,nodeid=7 \
-numa node,nodeid=8 -numa node,nodeid=9 \
-device vfio-pci-nohotplug,host=0009:01:00.0,bus=pcie.0,addr=04.0,rombar=0,id=dev0 \
-object acpi-generic-initiator,id=gi0,pci-dev=dev0,node=2 \
-object acpi-generic-initiator,id=gi1,pci-dev=dev0,node=3 \
-object acpi-generic-initiator,id=gi2,pci-dev=dev0,node=4 \
-object acpi-generic-initiator,id=gi3,pci-dev=dev0,node=5 \
-object acpi-generic-initiator,id=gi4,pci-dev=dev0,node=6 \
-object acpi-generic-initiator,id=gi5,pci-dev=dev0,node=7 \
-object acpi-generic-initiator,id=gi6,pci-dev=dev0,node=8 \
-object acpi-generic-initiator,id=gi7,pci-dev=dev0,node=9 \

-numa node,nodeid=10 -numa node,nodeid=11 -numa node,nodeid=12 \
-numa node,nodeid=13 -numa node,nodeid=14 -numa node,nodeid=15 \
-numa node,nodeid=16 -numa node,nodeid=17 \
-device vfio-pci-nohotplug,host=0009:01:01.0,bus=pcie.0,addr=05.0,rombar=0,id=dev1 \
-object acpi-generic-initiator,id=gi8,pci-dev=dev1,node=10 \
-object acpi-generic-initiator,id=gi9,pci-dev=dev1,node=11 \
-object acpi-generic-initiator,id=gi10,pci-dev=dev1,node=12 \
-object acpi-generic-initiator,id=gi11,pci-dev=dev1,node=13 \
-object acpi-generic-initiator,id=gi12,pci-dev=dev1,node=14 \
-object acpi-generic-initiator,id=gi13,pci-dev=dev1,node=15 \
-object acpi-generic-initiator,id=gi14,pci-dev=dev1,node=16 \
-object acpi-generic-initiator,id=gi15,pci-dev=dev1,node=17 \

Link: https://www.nvidia.com/en-in/technologies/multi-instance-gpu [1]
Cc: Jonathan Cameron <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
Message-Id: <20240308145525.10886-2-ankita@nvidia.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 qapi/qom.json                            | 17 ++++++
 include/hw/acpi/acpi_generic_initiator.h | 22 ++++++++
 hw/acpi/acpi_generic_initiator.c         | 71 ++++++++++++++++++++++++
 hw/acpi/meson.build                      |  1 +
 4 files changed, 111 insertions(+)
 create mode 100644 include/hw/acpi/acpi_generic_initiator.h
 create mode 100644 hw/acpi/acpi_generic_initiator.c

diff --git a/qapi/qom.json b/qapi/qom.json
index 032c6fa037..baae3a183f 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -811,6 +811,21 @@
 { 'struct': 'IOMMUFDProperties',
   'data': { '*fd': 'str' } }
 
+##
+# @AcpiGenericInitiatorProperties:
+#
+# Properties for acpi-generic-initiator objects.
+#
+# @pci-dev: PCI device ID to be associated with the node
+#
+# @node: NUMA node associated with the PCI device
+#
+# Since: 9.0
+##
+{ 'struct': 'AcpiGenericInitiatorProperties',
+  'data': { 'pci-dev': 'str',
+            'node': 'uint32' } }
+
 ##
 # @RngProperties:
 #
@@ -928,6 +943,7 @@
 ##
 { 'enum': 'ObjectType',
   'data': [
+    'acpi-generic-initiator',
     'authz-list',
     'authz-listfile',
     'authz-pam',
@@ -999,6 +1015,7 @@
             'id': 'str' },
   'discriminator': 'qom-type',
   'data': {
+      'acpi-generic-initiator':     'AcpiGenericInitiatorProperties',
       'authz-list':                 'AuthZListProperties',
       'authz-listfile':             'AuthZListFileProperties',
       'authz-pam':                  'AuthZPAMProperties',
diff --git a/include/hw/acpi/acpi_generic_initiator.h b/include/hw/acpi/acpi_generic_initiator.h
new file mode 100644
index 0000000000..16de1d3d80
--- /dev/null
+++ b/include/hw/acpi/acpi_generic_initiator.h
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES. All rights reserved
+ */
+
+#ifndef ACPI_GENERIC_INITIATOR_H
+#define ACPI_GENERIC_INITIATOR_H
+
+#include "qom/object_interfaces.h"
+
+#define TYPE_ACPI_GENERIC_INITIATOR "acpi-generic-initiator"
+
+typedef struct AcpiGenericInitiator {
+    /* private */
+    Object parent;
+
+    /* public */
+    char *pci_dev;
+    uint16_t node;
+} AcpiGenericInitiator;
+
+#endif
diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
new file mode 100644
index 0000000000..130d6ae8c1
--- /dev/null
+++ b/hw/acpi/acpi_generic_initiator.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES. All rights reserved
+ */
+
+#include "qemu/osdep.h"
+#include "hw/acpi/acpi_generic_initiator.h"
+#include "hw/boards.h"
+#include "qemu/error-report.h"
+
+typedef struct AcpiGenericInitiatorClass {
+    ObjectClass parent_class;
+} AcpiGenericInitiatorClass;
+
+OBJECT_DEFINE_TYPE_WITH_INTERFACES(AcpiGenericInitiator, acpi_generic_initiator,
+                   ACPI_GENERIC_INITIATOR, OBJECT,
+                   { TYPE_USER_CREATABLE },
+                   { NULL })
+
+OBJECT_DECLARE_SIMPLE_TYPE(AcpiGenericInitiator, ACPI_GENERIC_INITIATOR)
+
+static void acpi_generic_initiator_init(Object *obj)
+{
+    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
+
+    gi->node = MAX_NODES;
+    gi->pci_dev = NULL;
+}
+
+static void acpi_generic_initiator_finalize(Object *obj)
+{
+    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
+
+    g_free(gi->pci_dev);
+}
+
+static void acpi_generic_initiator_set_pci_device(Object *obj, const char *val,
+                                                  Error **errp)
+{
+    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
+
+    gi->pci_dev = g_strdup(val);
+}
+
+static void acpi_generic_initiator_set_node(Object *obj, Visitor *v,
+                                            const char *name, void *opaque,
+                                            Error **errp)
+{
+    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
+    uint32_t value;
+
+    if (!visit_type_uint32(v, name, &value, errp)) {
+        return;
+    }
+
+    if (value >= MAX_NODES) {
+        error_printf("%s: Invalid NUMA node specified\n",
+                     TYPE_ACPI_GENERIC_INITIATOR);
+        exit(1);
+    }
+
+    gi->node = value;
+}
+
+static void acpi_generic_initiator_class_init(ObjectClass *oc, void *data)
+{
+    object_class_property_add_str(oc, "pci-dev", NULL,
+        acpi_generic_initiator_set_pci_device);
+    object_class_property_add(oc, "node", "int", NULL,
+        acpi_generic_initiator_set_node, NULL, NULL);
+}
diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
index 5441c9b1e4..fa5c07db90 100644
--- a/hw/acpi/meson.build
+++ b/hw/acpi/meson.build
@@ -1,5 +1,6 @@
 acpi_ss = ss.source_set()
 acpi_ss.add(files(
+  'acpi_generic_initiator.c',
   'acpi_interface.c',
   'aml-build.c',
   'bios-linker-loader.c',
-- 
MST


