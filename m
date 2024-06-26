Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB72C30653
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 01:01:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMGrt-0008AM-85; Tue, 25 Jun 2024 20:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sMGq6-0007bf-DU
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 20:49:47 -0400
Received: from mail-mw2nam10on2060d.outbound.protection.outlook.com
 ([2a01:111:f403:2412::60d]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sMGp5-0008P0-8f
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 20:48:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZznCwzvT1WhPZWlypTI8piZCf6tOY3s891wKxRCtkw1OBAZWDqS5x16wpNtPIsF9b+EpEFKuUasrj/3Z5OawEngnqaea4Z93J3dHfa1eJak1OS8QEOPq8gL6hZm9G8mo1l4SV24OuRkLzycyB6+nVR7taHJSz0OuewiMvBRaB/Z6KTi9HfXRDtjfFxbRu7rc9BKAWpEQLSaA4o9chV24PvgH7WInC+KJMsION8JsBk99tgQSaRHZ8a4igUuEZeQbRkHaggnENK5POY9FjKqUEpCQFd/XQAuQUHg+oCjre+WcvRGg7Z+A/4mscss59l7E1BaEFEv4Nl0qqDibz65Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vBeQ2ESg7mBeqhgmI+k3egLqqRyw3wevs4tS2Tw3Uk=;
 b=JE67/ZkcKp28Bg3a77tNu88yy7ZE8dgPuCAzQ7dOCyKQsCuk7mMT72dF5AG2/JWgCOtV08tty6ghKeC2FrwNonGIbmNVBbpxHu1B5HT7d8ms+X6xgVDds2dJAoHs7+yccTafHim5Z3NEsS1e5+RCBUuw7MZZY2Ay/wvptex7oE+gd9qYv+YQFxC2xTQIasX+dz2s4Rc719mR7Y6/vtumUUOrkilvW2p2nZ2j0FK/oqDptJ9ahn9g6aa53KWl2Xk6/rAFHQSFWp4RNSJBiJCozyRstkuqlTdZzKj25pRscvyhREfwk+7HrT5gi9HpEEew50ftdrYZ5GuTcX09YFhMFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vBeQ2ESg7mBeqhgmI+k3egLqqRyw3wevs4tS2Tw3Uk=;
 b=KTDSk3KaB6HEPO76lOqU+X5IivS/kMP7nublGtJQBsMvUbQKKO8tprDhKcF2+EC8uCbb3GWCURQZKSojFT/jZSuZwoekmnFTmHWsZXDbBSkpGu2PA3FE3QQieomiUVRHaAhv21Z59t3d3v6oHPo+MvP564j7D23WvpTMDHtGYngxkst9au9aqKEHuAKWl8psXUHFRwMpR3owv9hZUBEIyPA0GXuwvm1k7DWbkBd5Ph1/CTYX9XKlOASXbejpCTPe42Zv7l3xfmaYwhUTsPik1YuKuoyI/QsZWmYeDpR4MvJwSk9DR05NSSKoEXFOI7/Jk26PebMgdCTRevJUKHNt7Q==
Received: from BN9PR03CA0934.namprd03.prod.outlook.com (2603:10b6:408:108::9)
 by IA0PR12MB8745.namprd12.prod.outlook.com (2603:10b6:208:48d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 00:29:43 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:108:cafe::83) by BN9PR03CA0934.outlook.office365.com
 (2603:10b6:408:108::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Wed, 26 Jun 2024 00:29:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 00:29:43 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Jun
 2024 17:29:32 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 25 Jun 2024 17:29:32 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 25 Jun 2024 17:29:31 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <peter.maydell@linaro.org>, <shannon.zhaosl@gmail.com>, <mst@redhat.com>, 
 <imammedo@redhat.com>, <anisinha@redhat.com>, <eric.auger@redhat.com>,
 <peterx@redhat.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <jgg@nvidia.com>,
 <shameerali.kolothum.thodi@huawei.com>, <jasowang@redhat.com>
Subject: [PATCH RFCv1 09/10] hw/arm/virt-acpi-build: Build IORT with multiple
 SMMU nodes
Date: Tue, 25 Jun 2024 17:28:36 -0700
Message-ID: <074b51a5a42875304d7d8d223d0bc644fa7a4736.1719361174.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719361174.git.nicolinc@nvidia.com>
References: <cover.1719361174.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|IA0PR12MB8745:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a97331d-57c5-44d5-c533-08dc95771345
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230038|82310400024|36860700011|1800799022|376012|7416012; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nGXMnlqXDhq5ATrnMoHz1WHN0DYTzUSCHVMZS/fxlUxP7DTrL6vJeAGpqJpo?=
 =?us-ascii?Q?RyoSCTwtl8P7Hx9xPPytg1QqrzrInxxjxGL2KvToSucgy333t7iZC192y3Gp?=
 =?us-ascii?Q?HKyIoMtixWmm3+6OuzD0r7mY58+RNSs0zTeijWiuaTyyhA0EsyrHUfUDSfIv?=
 =?us-ascii?Q?j60dE+HaOe3Npphs+Q9vM/NVIycz6CADMyRemCA8awnhju9X0LBjfDyk/toR?=
 =?us-ascii?Q?9z5M6oiYb2SHLl0fqdIfU0xOggfuczmGeGiO4wzw3oUv6yzTGJ0fQmEPlenO?=
 =?us-ascii?Q?9Ol6lVD5fC7bGABzBtSZiPqXHaVaMddl7gHRFVirl/oJ6WFD8SBbJt8E+EK5?=
 =?us-ascii?Q?82SW0t4QrJQwTIl+eJ5EpHfD18pgEJQ+T38SurdzaTgNiqB5u+lUXAy97C31?=
 =?us-ascii?Q?Cl6hXSY94FZRbhzZifMSGseyIfniHs5PtxaFj4IXCYraU4htigLVdlmrNOtW?=
 =?us-ascii?Q?EbTzKGhX9a9dSyI5qUqlezsMrvHlRF9xS5qslq65/sbDFAtOU+rizyqkl0Nj?=
 =?us-ascii?Q?00lIglrpp1Bhq+DOqiIl4Hhcefcn+pUyZCzprPq6p55C1gkpdbhJdalSmHG2?=
 =?us-ascii?Q?ELcsPsk81Ly9MnpM/97vIuxNbXkgNmsZ1tGNotUSKYhBQTUat1Q5mtTl0DTD?=
 =?us-ascii?Q?kID/zQYI8qtKjV5pK7yNLZAfImszJ1ffV8MRpWL2/OMJ/6Re0xirQPDn7jjL?=
 =?us-ascii?Q?n3ZuOYyx46hxAy+H+7DdnwDz8E0WwKCMvVa9X1+BYd4ePJ7QS1Z7N3iGF/38?=
 =?us-ascii?Q?gwvb7bNDP5UpWZqEbdiPrACmEu8H5ZIqE8ZCm/o0cav415eiewuR5d92HeMj?=
 =?us-ascii?Q?IIXrDzgmPzzaPvTm3RPb7PIPfzlL/k+etAOpQI/wjx2mDN+t1vrRS9Y/pLC0?=
 =?us-ascii?Q?N9aY/gbpIzZP2Bzr47VyGBdY3TB1a+Z04WVpSOaEPRjtv0qsAlXNFIeyqfPx?=
 =?us-ascii?Q?r4J1CH7hOdZP5NGIlvR7c4WzLQzJfFAwSOv1eM1xvzbhFYN4Eh992dIWRit+?=
 =?us-ascii?Q?Dvxdgupj4V7CpxpS39znNjc+tZHGioDkOgihProUuTw8gr9TEOMizhpl32Oh?=
 =?us-ascii?Q?6heY0SPS40l4dGlDKtVQJs3CiEzF2HuRCT8NTNP4f8V1R9KY6K69K6l6+WaI?=
 =?us-ascii?Q?uuZCXXpc3kgLF0nrFdVNjPKk+0OenpGy1X6lX0h6drdxRizOmkmLIbRRZ2wM?=
 =?us-ascii?Q?kn1u1KEQrJea4jY+ii4EKBcp96O5wtJ2oZN9SpsJAB3uMRlGzRrYlA+BzIhd?=
 =?us-ascii?Q?wiIpaTPAvtUwqlhU9uskdzIN3yc9DEdAzz8niSpLUv/MaAd0CvIxDPJPec6g?=
 =?us-ascii?Q?WHwMiPfv0eoXFdUTW2G8wfX3dqzrjqKmTYJDideOOYDaegYbhaHAKIDoQnDL?=
 =?us-ascii?Q?37s33qvh/19bx6Lz2KcVH5p6FI4l/5rlcz5P4F5aejbTizOnRGFFdBRbs3q5?=
 =?us-ascii?Q?rTO+GmcBIQkJC8/YV14lsh4fFZn750B8?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230038)(82310400024)(36860700011)(1800799022)(376012)(7416012); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 00:29:43.4879 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a97331d-57c5-44d5-c533-08dc95771345
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8745
Received-SPF: softfail client-ip=2a01:111:f403:2412::60d;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

There can be multiple PCI buses behind different SMMU nodes. And each pair
should be associated in the IORT table too when building the ID mappings.

Create multiple SMMU nodes if needed, store their offsets in an array.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 hw/arm/virt-acpi-build.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 91f53f90ca..6d8b9aea42 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -295,7 +295,7 @@ static int iort_idmap_compare(gconstpointer a, gconstpointer b)
 }
 
 static void
-build_iort_rmr_nodes(GArray *table_data, GArray *smmu_idmaps, int smmu_offset, uint32_t *id) {
+build_iort_rmr_nodes(GArray *table_data, GArray *smmu_idmaps, size_t *smmu_offset, uint32_t *id) {
     AcpiIortIdMapping *range;
     int i;
 
@@ -323,7 +323,7 @@ build_iort_rmr_nodes(GArray *table_data, GArray *smmu_idmaps, int smmu_offset, u
         build_append_int_noprefix(table_data, 1 , 4);
         /* Reference to Memory Range Descriptors */
         build_append_int_noprefix(table_data, 28 + ID_MAPPING_ENTRY_SIZE, 4);
-        build_iort_id_mapping(table_data, bdf, range->id_count, smmu_offset, 1);
+        build_iort_id_mapping(table_data, bdf, range->id_count, smmu_offset[i], 1);
 
         /* Table 19 Memory Range Descriptor */
 
@@ -345,25 +345,42 @@ static void
 build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 {
     int i, nb_nodes, rc_mapping_count;
-    size_t node_size, smmu_offset = 0;
+    size_t node_size, *smmu_offset;
     AcpiIortIdMapping *idmap;
     uint32_t id = 0;
     GArray *smmu_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
     GArray *its_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
     AcpiIortIdMappingVM idmap_vm = { .vms = vms, .smmu_idmaps = smmu_idmaps, };
+    int irq_offset = NUM_SMMU_IRQS;
+    hwaddr offset = SMMU_IO_LEN;
+    int irq, num_smmus = 0;
+    hwaddr base;
 
     AcpiTable table = { .sig = "IORT", .rev = 5, .oem_id = vms->oem_id,
                         .oem_table_id = vms->oem_table_id };
     /* Table 2 The IORT */
     acpi_table_begin(&table, table_data);
 
+    if (vms->num_nested_smmus) {
+        irq = vms->irqmap[VIRT_NESTED_SMMU] + ARM_SPI_BASE;
+        base = vms->memmap[VIRT_NESTED_SMMU].base;
+        num_smmus = vms->num_nested_smmus;
+    } else if (virt_has_smmuv3(vms)) {
+        irq = vms->irqmap[VIRT_SMMU] + ARM_SPI_BASE;
+        base = vms->memmap[VIRT_SMMU].base;
+        num_smmus = 1;
+    }
+    smmu_offset = g_new0(size_t, num_smmus);
+
+    nb_nodes = 2; /* RC, ITS */
+    nb_nodes += num_smmus; /* SMMU nodes */
+
     if (virt_has_smmuv3(vms)) {
         AcpiIortIdMapping next_range = {0};
 
         object_child_foreach_recursive(object_get_root(),
                                        iort_host_bridges, &idmap_vm);
 
-        nb_nodes = 3; /* RC, ITS, SMMUv3 */
 
         /* Sort the smmu idmap by input_base */
         g_array_sort(smmu_idmaps, iort_idmap_compare);
@@ -394,7 +411,6 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 
         rc_mapping_count = smmu_idmaps->len + its_idmaps->len;
     } else {
-        nb_nodes = 2; /* RC, ITS */
         rc_mapping_count = 1;
     }
     /* Number of IORT Nodes */
@@ -416,10 +432,9 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     /* GIC ITS Identifier Array */
     build_append_int_noprefix(table_data, 0 /* MADT translation_id */, 4);
 
-    if (virt_has_smmuv3(vms)) {
-        int irq =  vms->irqmap[VIRT_SMMU] + ARM_SPI_BASE;
+    for (i = 0; i < num_smmus; i++) {
+        smmu_offset[i] = table_data->len - table.table_offset;
 
-        smmu_offset = table_data->len - table.table_offset;
         /* Table 9 SMMUv3 Format */
         build_append_int_noprefix(table_data, 4 /* SMMUv3 */, 1); /* Type */
         node_size =  SMMU_V3_ENTRY_SIZE + ID_MAPPING_ENTRY_SIZE;
@@ -430,12 +445,13 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         /* Reference to ID Array */
         build_append_int_noprefix(table_data, SMMU_V3_ENTRY_SIZE, 4);
         /* Base address */
-        build_append_int_noprefix(table_data, vms->memmap[VIRT_SMMU].base, 8);
+        build_append_int_noprefix(table_data, base + i * offset, 8);
         /* Flags */
         build_append_int_noprefix(table_data, 1 /* COHACC Override */, 4);
         build_append_int_noprefix(table_data, 0, 4); /* Reserved */
         build_append_int_noprefix(table_data, 0, 8); /* VATOS address */
         /* Model */
+        irq += irq_offset;
         build_append_int_noprefix(table_data, 0 /* Generic SMMU-v3 */, 4);
         build_append_int_noprefix(table_data, irq, 4); /* Event */
         build_append_int_noprefix(table_data, irq + 1, 4); /* PRI */
@@ -487,7 +503,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
             range = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);
             /* output IORT node is the smmuv3 node */
             build_iort_id_mapping(table_data, range->input_base,
-                                  range->id_count, smmu_offset, 0);
+                                  range->id_count, smmu_offset[i], 0);
         }
 
         /* bypassed RIDs connect to ITS group node directly: RC -> ITS */
-- 
2.43.0


