Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EEB3C54E58
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 14:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ribdo-00038I-Nx; Fri, 08 Mar 2024 09:56:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1ribdd-0002t5-Fj; Fri, 08 Mar 2024 09:56:01 -0500
Received: from mail-bn8nam12on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2418::601]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1ribda-0005Ip-OX; Fri, 08 Mar 2024 09:55:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C166snbXI41zTfT3fPSkDGZBkM28R8UCU4f4b+/QuMzvsyPXmk1gCa8EwNqdV/LAa3P9pkx7h2+MdKA5wU7379hTXHmwLMg43Zl+rw/Dwja5XIy1i2x1Ulsjpq3bThzi/vqZluYqCx59xRjDlT4p1QzrH9+SYCk3JNMObN8IsciwOX6gJDGEPJB0Zle2pr8YK1DrG1TbLUwjE+9MF2PLt2Fd5j0pQn5UCuEbt0hBxQ8kl1EzMWuwAWWCHI7vgsjNogXGTffXHQXgoyni4+i3Coxsk4emZXGlx6E+ZRZeVaaL44NiGWA9/YJW3uS6ecWoCauu8FYeuGhUoZb7vkCH8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+Nfb9Fp9svwTRraIIDVALUSYVvUG9WY8BWqf0gGVtg=;
 b=Mc6LMcyYyadZjFOWHnURBfx0YrdVEH3jtBMoTkPIapdOqsZhY00wXEIU5UgtUSCtruPENX35sNF+VUxqh5xnO8VJq1qzR2p+UpCtJx6YVVsZwPCBu+HOXq148dzcJJBsk4KGGCZVJdEi8dUYnPXOOQjk0NJt3Se9IWLD6vacP8431Kn8JTRTmO9D3rHslhoKHjQ8UK5tbF7avv98tDEzpb/keVKKDSovipwXV7+mx7Qd9BbW9uJyiBqiVzLo8PyhNnME4Eb8GZSXMfHN8n7RQPXPggH9LU2+hwtFmjPPSwvujpo8/x6tMc3qA1TeOjqd9706spe1+46TzqUR6j6ZrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+Nfb9Fp9svwTRraIIDVALUSYVvUG9WY8BWqf0gGVtg=;
 b=D8agL/Y4iJokIFXXyiYlxjGVhGvI1m/nCuw3ECgH6WzvXhnmbUFxBZGbu/BzniGK2nSWrynnLCdmgFGOm5EnnGu7YAkE/NoQLegdSLBzdrG1Bxxsj/nhf1nqvFTZMR/aPF0h90f3jLBIv9BuulMXdKf3KsI+YDoPBKf7//ugjsSowAFyL/ZP1OE1UAfwM6sTImOOQ4gJ8dSg+x//SOgSLvOuXkVah3A61LpVz13d/BIaD/FuWr88fEBMnAr330+hOhabfr5SmtuDP12SCHz6EJsavV3cw7iaLh2rIGTn6y2FbIBLoRessAemy18s51OIdi0pb8sWcXQ0Rtee2b9l2g==
Received: from PA7P264CA0227.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:372::14)
 by DS0PR12MB8319.namprd12.prod.outlook.com (2603:10b6:8:f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 14:55:49 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10a6:102:372:cafe::d) by PA7P264CA0227.outlook.office365.com
 (2603:10a6:102:372::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26 via Frontend
 Transport; Fri, 8 Mar 2024 14:55:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Fri, 8 Mar 2024 14:55:47 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 8 Mar 2024
 06:55:26 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Fri, 8 Mar 2024 06:55:26 -0800
Received: from host-10-63-191-31.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Fri, 8 Mar 2024 06:55:26 -0800
From: <ankita@nvidia.com>
To: <ankita@nvidia.com>, <jgg@nvidia.com>, <marcel.apfelbaum@gmail.com>,
 <philmd@linaro.org>, <wangyanan55@huawei.com>, <alex.williamson@redhat.com>,
 <pbonzini@redhat.com>, <clg@redhat.com>, <shannon.zhaosl@gmail.com>,
 <peter.maydell@linaro.org>, <ani@anisinha.ca>, <berrange@redhat.com>,
 <eduardo@habkost.net>, <imammedo@redhat.com>, <mst@redhat.com>,
 <eblake@redhat.com>, <armbru@redhat.com>, <david@redhat.com>,
 <gshan@redhat.com>, <Jonathan.Cameron@huawei.com>
CC: <aniketa@nvidia.com>, <cjia@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <vsethi@nvidia.com>, <acurrid@nvidia.com>,
 <mochs@nvidia.com>, <dnigam@nvidia.com>, <udhoke@nvidia.com>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: [PATCH v9 1/3] qom: new object to associate device to NUMA node
Date: Fri, 8 Mar 2024 14:55:23 +0000
Message-ID: <20240308145525.10886-2-ankita@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240308145525.10886-1-ankita@nvidia.com>
References: <20240308145525.10886-1-ankita@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|DS0PR12MB8319:EE_
X-MS-Office365-Filtering-Correlation-Id: 471798c5-f0e0-40c8-b77c-08dc3f7fd6cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vrtNJgmfdGsLkwUgQ1eEYCrXXKUncCH02qXU8jZovIf6532HTrKO3x1SX77ZTdwNzHN8JqVQoJNxgauJ5ZyQohP75jA49zES36vQyR3arOSvYPjBYbwnFfvtBpKLLjZAeYElojxrRN1Z+oRyaHBqdmsaULfdDMFmiuucPvuu9ZDgtr7q3ne0UscSCOYws6V5FUnMudnR/lzEGuUGM0Yd9vPpmQzAUbhiapjPzY9SHOcZa2O+qWyusXUpmFT1+DKavcM7wAfPyWrOeSxcuiAbpLA34s+QIxJpjMALbYMFqCwK5XfJLCXk9FQK/+biGXrW8dPoymLUmW/V2Yem/PX7GnhufY5z8ADTckavfBXYSc87VKn0oF8whFZz16NbcS02gT/V1qRSSJL+xZ1lIZRz2KfpxltuzMufW0VDwNzgAe8xSbih6GBGzp0kW42bO/TRHeeWtxgyltGqIqwRzjt4Uy43y905zletSCeT0rAigH0r4LfUabsAylH4KtMJpYqMb3aEbitP433GIxEfyq3udbWRoAX0sjQ8WrxbdEYUS6biS5vSQWK/CNTq+m5+SV4Jd3hCX9k/iKHENMDm7N9zp2WZ3q8GQ9UgtO0/seV2f3v7+CtOnCGEhj5mgnzjV2D8s3aSFnMxSw9SZ6d9k6E3qZraaRubhaGoTg8Mk4zceceuGAbSBODCu2HqwGoPr3WcrWTivRs2OY5Ybg309q4PfUpxzv9LPz/cDXMJUwVnYmQB9tbIA2SKsF5LLA82Mfpp9tAK9uUwgpvwlWsNSC6dIQ==
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(7416005)(82310400014)(921011);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 14:55:47.5811 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 471798c5-f0e0-40c8-b77c-08dc3f7fd6cc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8319
Received-SPF: softfail client-ip=2a01:111:f403:2418::601;
 envelope-from=ankita@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
---
 hw/acpi/acpi_generic_initiator.c         | 71 ++++++++++++++++++++++++
 hw/acpi/meson.build                      |  1 +
 include/hw/acpi/acpi_generic_initiator.h | 22 ++++++++
 qapi/qom.json                            | 17 ++++++
 4 files changed, 111 insertions(+)
 create mode 100644 hw/acpi/acpi_generic_initiator.c
 create mode 100644 include/hw/acpi/acpi_generic_initiator.h

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
index fc1b952379..1424046164 100644
--- a/hw/acpi/meson.build
+++ b/hw/acpi/meson.build
@@ -1,5 +1,6 @@
 acpi_ss = ss.source_set()
 acpi_ss.add(files(
+  'acpi_generic_initiator.c',
   'acpi_interface.c',
   'aml-build.c',
   'bios-linker-loader.c',
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
diff --git a/qapi/qom.json b/qapi/qom.json
index c53ef978ff..81727310b1 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -794,6 +794,21 @@
 { 'struct': 'VfioUserServerProperties',
   'data': { 'socket': 'SocketAddress', 'device': 'str' } }
 
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
@@ -911,6 +926,7 @@
 ##
 { 'enum': 'ObjectType',
   'data': [
+    'acpi-generic-initiator',
     'authz-list',
     'authz-listfile',
     'authz-pam',
@@ -981,6 +997,7 @@
             'id': 'str' },
   'discriminator': 'qom-type',
   'data': {
+      'acpi-generic-initiator':     'AcpiGenericInitiatorProperties',
       'authz-list':                 'AuthZListProperties',
       'authz-listfile':             'AuthZListFileProperties',
       'authz-pam':                  'AuthZPAMProperties',
-- 
2.34.1


