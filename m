Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F5BFC2BBCA
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 01:00:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMGrc-0008LR-3E; Tue, 25 Jun 2024 20:50:22 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sMGrG-0008AT-R4
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 20:50:12 -0400
Received: from mail-mw2nam10on20607.outbound.protection.outlook.com
 ([2a01:111:f403:2412::607]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sMGqO-00004w-Hy
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 20:49:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLwwTNf31EI5BVzUMV6hyEnbwzR9TD//RC/qYs0MumfAfdj2poecoV0JNB3lpMiQxytm9MEuG1KYzpJ5KMpDab3l822mnhUSw48Q9dGpUF/0B2hoXwFqyciFt0FRU4zE5sCZkWGLkt4T1BWnHQkicgv9yUDnt0kqwyKYnWuzxbgrnBqgYmgMThWHdXF/28tGPAQi2B/l7OJVklfOmxkMhOryunVX9EMQ7Fj19ZbN6IJ2kihObU5H1VbrXVCU6sUb7Xoy2I62foU0V/bRpw2jO1T6BudTRX4KOeX9y71CoXfw5/emfFB5jDmUZT1Z1QNtD/6rv1Ga1nB2CW3CN0WCEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wOvi1OGUotDm+vB1MY5ShyuvtP9VXlclIHrs5TuR3U=;
 b=Ql20/zTc1ZU4QbA51pNoL/t8dLyNrsrJE8m1di5nZo95yCP5JiwXOt7PfwXIHh/CndAvdaGxc3LsP61T6/DNr+PnpNOp8KiGESblb78ZIecvt3vD+74zSpD5hmH+C+1R58oREf1r2tEmlV/U9yBnjEKMykO7emguOQbcDb/sbMKodR7m6PHQooTNcynEmHv+zui7BTa2DMx/r/ZJn6bxlPXwgG2w1VDDCZlakqh29UWEJ6OEoCu7Aq4RE59bUSIo0r9BvjeCpfQ3fOQAdkD+Xso4Qq9YQ8+MCze02OvKDRVAlJ/J/nEpzdg/rmNNA+WG7NmKo0fK4uAKg+lfQ97jlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wOvi1OGUotDm+vB1MY5ShyuvtP9VXlclIHrs5TuR3U=;
 b=Tkb+d1FSUGocRUqUNEou00p1TATj+dOT5/F11h5RcbQPrKsphmJcIHUSek2HziLcp+nYn+MvMnU2K5HBUnulVjKg2gL8tn59/+QesG21fFfiBlrZDE1+ZQDEAiolOiT1IFVsm9lQaWOm8wv2QrvWMXXCXkF0DKZmfd87bcXKA9qkUL/Aq5on++yRE/4d391kRkTcUZVv8EK9JyRIS7BBw+uCUocoVR2KnCwE5NRcvx+lDWuPWZGOCzUufpvkFqdcSZyldEEyZdNWjOiytP1NecuJVPnpdekJH/iWRX/s08GGauB9w6ZDMBdScio6x19Aj0EL33wMb0Es7bXjR5OlHw==
Received: from CH2PR20CA0005.namprd20.prod.outlook.com (2603:10b6:610:58::15)
 by SN7PR12MB8002.namprd12.prod.outlook.com (2603:10b6:806:34b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.29; Wed, 26 Jun
 2024 00:29:43 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::c2) by CH2PR20CA0005.outlook.office365.com
 (2603:10b6:610:58::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Wed, 26 Jun 2024 00:29:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 00:29:42 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Jun
 2024 17:29:31 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 25 Jun 2024 17:29:31 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 25 Jun 2024 17:29:30 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <peter.maydell@linaro.org>, <shannon.zhaosl@gmail.com>, <mst@redhat.com>, 
 <imammedo@redhat.com>, <anisinha@redhat.com>, <eric.auger@redhat.com>,
 <peterx@redhat.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <jgg@nvidia.com>,
 <shameerali.kolothum.thodi@huawei.com>, <jasowang@redhat.com>
Subject: [PATCH RFCv1 08/10] hw/arm/virt-acpi-build: Handle reserved bus
 number of pxb buses
Date: Tue, 25 Jun 2024 17:28:35 -0700
Message-ID: <2f5791d4148859a71bc1eae041cf6c7d478b2cb2.1719361174.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719361174.git.nicolinc@nvidia.com>
References: <cover.1719361174.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|SN7PR12MB8002:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b133c44-5cb1-47ef-2b50-08dc957712a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230038|36860700011|376012|7416012|1800799022|82310400024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ITGw7nyVO0foD6UuBse2ibnHs5SVTLMJL07fOvmyTpjdpRehWdNDWKlVgn64?=
 =?us-ascii?Q?jDimucQvfYtGSwqYBoxODKnjbxoes3apj/qALPyKUtiV9pSSY4yAN2X0YbKA?=
 =?us-ascii?Q?I8aAzc1HliRX1IChgy6bNuW5sQ2LQIJuB5Ogv3LaB1dSGA5KqDo5luV/Wtvt?=
 =?us-ascii?Q?MjDQlaZx35uwiEk6Pi3e96O+s3WLPSU1j8viiAAMh+zC0kGg9LQb/cf+45EU?=
 =?us-ascii?Q?fHOVCHmdXLL4gwsN287i+mHMgm1AJTQ7A4wZ0FBPcCojYU1VA/scZ4aL+V4C?=
 =?us-ascii?Q?OgN1WP3fCfRnrraNSiqkbWfXcKc7TLgS5FbMiREIIU2rrWNYMBGBXIjHYB/Y?=
 =?us-ascii?Q?B0FbglRIjvHwOpoDxMuYFptrhYO+u8ohTLjxqY0+afRHHiK0IhmlKZkFeCPM?=
 =?us-ascii?Q?NHTn6IprGPSecPVN5eWGUg6wVM7huU53Ort1X/j7kPuMGKcHTSpx7iYlFb2L?=
 =?us-ascii?Q?cBRijukHeQN+VndwR+Z4VByELt+Xr23RDsB1N0qVRi3zS43Gr0NccE1I56l4?=
 =?us-ascii?Q?/juUeRWR7mgFK0tJKiNJNIZl8n7f0EDjyDiYn+3vbejOjH0x4fJxbTdQX4zz?=
 =?us-ascii?Q?12kkSHf30EZpnp09El71gsisUUsDT/vfrzOxxm0cXbp7cJWoemKXnAGyDCaw?=
 =?us-ascii?Q?gZfL36OS772M+Nsvt2wdBG+om/vCIIEKWu9gUAhxKd7PoGLA6FAfmHzoLfp0?=
 =?us-ascii?Q?P5rzR64cI8rQbbBsTKryQ6Bd/3PWIMMiOSc+kdpJrzDHKxVJd9qyB+a+fC07?=
 =?us-ascii?Q?Sh8NLFBvceo15UL5H2uxDZ1cDKcbQcCJavqDEuiFr3O1YnhzPaotAXbERDpN?=
 =?us-ascii?Q?Ke10N3Bcz04BQZnVXv2jNYxr6PMLNONAWZm8ycrrwzxp+rrFQ1iJQAvU0Sdr?=
 =?us-ascii?Q?l6wgMsgrz1PZKq+P//YsTEAQmq43kqYIYShWy0vy+ilcuYH8ABAs6fZnA+bp?=
 =?us-ascii?Q?RErz9MxFVMuTz6LZNaZ+dlSQpkD1HBb2SXcpJY2+z1NrGmcngGC6upMbWHMl?=
 =?us-ascii?Q?GJ0/+W5XE9kswUqwcg3W3Dwh5udcOb2bRCDPQnMLSphW/Jzl9JFKC7b2lDU0?=
 =?us-ascii?Q?eAYk0jeqmLHznScyyllp6CWTek22M00UgqBO7oEEuH23FCz9Z5gi2s00mpIC?=
 =?us-ascii?Q?jCmwTMz6kdW11MOaQ268g29oL0gwvpIpgjx1/d9W27UibBQXXC9HxOgt0IrR?=
 =?us-ascii?Q?47p91HmGyRFD/uqtzJywYmVNNg8A1SHr5SQO1j+uyk6UJZ04lEEObdrGSxqM?=
 =?us-ascii?Q?sBIJZJRlsRqUxb0QJ3FcOTNwYuf3DtFFvZEMa4lIVMWOhVEkOHpqSzND9pOE?=
 =?us-ascii?Q?xndyg38XiE4ywZ0YGGP0rOMVjMqFEmxPmDP6TY5/3a7tydp0xWgHy9RaLKtG?=
 =?us-ascii?Q?MOqh77/T0Jl3dzbFF+WINeun9nwBkW+BczMwXyBDqk5wAtqJrA=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230038)(36860700011)(376012)(7416012)(1800799022)(82310400024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 00:29:42.4641 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b133c44-5cb1-47ef-2b50-08dc957712a7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8002
Received-SPF: softfail client-ip=2a01:111:f403:2412::607;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Each pxb bus created for a nested SMMU has a reserved bus number, allowing
a hotplug device to attach to the bus in a later stage.

Read it out to apply to the id_count calculation.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 hw/arm/virt-acpi-build.c | 28 ++++++++++++++++++++++++----
 include/hw/arm/virt.h    | 13 +++++++++++++
 2 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index d5e72800f6..91f53f90ca 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -236,6 +236,12 @@ build_iort_id_mapping(GArray *table_data, uint32_t input_base,
     build_append_int_noprefix(table_data, flags, 4); /* Flags */
 }
 
+struct AcpiIortIdMappingVM {
+    VirtMachineState *vms;
+    GArray *smmu_idmaps;
+};
+typedef struct AcpiIortIdMappingVM AcpiIortIdMappingVM;
+
 struct AcpiIortIdMapping {
     uint32_t input_base;
     uint32_t id_count;
@@ -246,21 +252,34 @@ typedef struct AcpiIortIdMapping AcpiIortIdMapping;
 static int
 iort_host_bridges(Object *obj, void *opaque)
 {
-    GArray *idmap_blob = opaque;
+    AcpiIortIdMappingVM *idmap_vm = opaque;
+    VirtMachineState *vms = idmap_vm->vms;
 
     if (object_dynamic_cast(obj, TYPE_PCI_HOST_BRIDGE)) {
         PCIBus *bus = PCI_HOST_BRIDGE(obj)->bus;
 
         if (bus && !pci_bus_bypass_iommu(bus)) {
+            VirtNestedSmmu *nested_smmu = find_nested_smmu_by_pci_bus(vms, bus);
             int min_bus, max_bus;
 
-            pci_bus_range(bus, &min_bus, &max_bus);
+            if (vms->iommu == VIRT_IOMMU_NESTED_SMMUV3) {
+                /* PCI host bridge hehind a nested SMMU has reserved buses */
+                if (nested_smmu) {
+                    min_bus = pci_bus_num(nested_smmu->pci_bus);
+                    max_bus = min_bus + nested_smmu->reserved_bus_nums - 1;
+                } else {
+                    /* Not connected to a nested SMMU */
+                    return 0;
+                }
+            } else {
+                pci_bus_range(bus, &min_bus, &max_bus);
+            }
 
             AcpiIortIdMapping idmap = {
                 .input_base = min_bus << 8,
                 .id_count = (max_bus - min_bus + 1) << 8,
             };
-            g_array_append_val(idmap_blob, idmap);
+            g_array_append_val(idmap_vm->smmu_idmaps, idmap);
         }
     }
 
@@ -331,6 +350,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     uint32_t id = 0;
     GArray *smmu_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
     GArray *its_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
+    AcpiIortIdMappingVM idmap_vm = { .vms = vms, .smmu_idmaps = smmu_idmaps, };
 
     AcpiTable table = { .sig = "IORT", .rev = 5, .oem_id = vms->oem_id,
                         .oem_table_id = vms->oem_table_id };
@@ -341,7 +361,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         AcpiIortIdMapping next_range = {0};
 
         object_child_foreach_recursive(object_get_root(),
-                                       iort_host_bridges, smmu_idmaps);
+                                       iort_host_bridges, &idmap_vm);
 
         nb_nodes = 3; /* RC, ITS, SMMUv3 */
 
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index dfbc4bba3c..7ac392eb88 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -259,4 +259,17 @@ find_nested_smmu_by_sysfs(VirtMachineState *vms, char *node)
     return NULL;
 }
 
+static inline VirtNestedSmmu *
+find_nested_smmu_by_pci_bus(VirtMachineState *vms, PCIBus *pci_bus)
+{
+    VirtNestedSmmu *nested_smmu;
+
+    QLIST_FOREACH(nested_smmu, &vms->nested_smmu_list, next) {
+        if (nested_smmu->pci_bus == pci_bus) {
+            return nested_smmu;
+        }
+    }
+    return NULL;
+}
+
 #endif /* QEMU_ARM_VIRT_H */
-- 
2.43.0


