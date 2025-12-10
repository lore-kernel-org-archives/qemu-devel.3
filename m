Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC9CD3C54A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 13:41:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTKQL-00084z-Uj; Wed, 10 Dec 2025 08:40:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vTKPw-0007i4-23; Wed, 10 Dec 2025 08:39:45 -0500
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vTKPs-0001Sw-7a; Wed, 10 Dec 2025 08:39:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XmD1V6ExYj6jG0w5dHHfrLI6ERF7719svjalAddHtQTg73izAmYNvWLmsyhQRS1/mD6pQnppxNVQygGq+irRXX033TAN+TiJ9M4NhFFCA9000of3PtWoD5kmWAwiPwwdJpkigTG0Qwe78bVfFGr8HyrHDKqbSjpQTz8uWCubq3vrmk2g7baaN/Ve6b9l/fEJa8xZi9Hd3pmB/8PX9WjRpQxzEVwwF4P6k/Slh7YkTBtVBglQpz1ok9A1Y2vVDBVQpnftrBnoEaUsmh2Aybn+VOmz+4366/rM8N/CALb5XVrxvpQqfqM2mpq9ponuMZa1FA+aoC0gGY67IlAxgIWgfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RqUItNDWOFOhFJ7ZMdOdYilYD+yhQNOXV0sw/8agsSQ=;
 b=po7n+y210aX6rZ9kPp0AI+4ZwLbZVKfQIqUcygqZR8/tmVE79pDiVBWgmcTgBPhGtTXLlV63qEGXKXBlsPh0JLL/ab3N8ZYO1cNTEHPq6R5cO+WGEvwLDN4PEoJvKQJFZVlhGBb9kyctEjZu+qz1lBZZi+J1EIjV3ceYlCwl5cU1xQhpV/r885wPet4euWdL2i5L8H2zeHmGNZOpYOQxjSB96tFUEa+zL5s4rrisPJpWo3SEkOdoH3Iv6EqzYY5mZbtT3NtN4UP5cvmIc/mdaRvP/FZt7Ex9PdqrXtYvB+MZXBtUY0jJvx7/aYDXw94E3BHnD4mlSFi5SPJ2Regjmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqUItNDWOFOhFJ7ZMdOdYilYD+yhQNOXV0sw/8agsSQ=;
 b=Fj2SGecxDLoVsC21gYSTcZBNIMlEJrd6XHNdYC1WbyVIul7eP9A52G8TDVo/OO2fkQ9rYqy4YJPXL+tdi8DeCJLWgOMG/tthe6Hnk6SSvbc1k37Zxpbgd+V9NAgedbz2WY/h0GcGJ/MXsn8i+y+jM3TgkgGotG/r/TDjCtfz65B8fs+GwjntRAIqSPxVTfCH52ZEkXZE1DN9Y1MIgj0lNZ4CMdlkymzK7UU+kPr4b4SfvQDqQb3MOT0SkBhV2gxo9nBGKHCMdG9E2XxtIi/r6SFzSiDutmSCsoJj2/TuvVNRzgFECPKhETJPUsWgBFlNBVeWR1jAgRqJRDfAXG9kBg==
Received: from SJ0PR13CA0064.namprd13.prod.outlook.com (2603:10b6:a03:2c4::9)
 by MW4PR12MB6801.namprd12.prod.outlook.com (2603:10b6:303:1e8::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Wed, 10 Dec
 2025 13:39:32 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::55) by SJ0PR13CA0064.outlook.office365.com
 (2603:10b6:a03:2c4::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.8 via Frontend Transport; Wed,
 10 Dec 2025 13:39:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 10 Dec 2025 13:39:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 05:39:09 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 05:39:07 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jgg@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: [RFC PATCH 14/16] virt-acpi-build: Rename AcpiIortSMMUv3Dev to
 AcpiSMMUv3Dev
Date: Wed, 10 Dec 2025 13:37:35 +0000
Message-ID: <20251210133737.78257-15-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251210133737.78257-1-skolothumtho@nvidia.com>
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|MW4PR12MB6801:EE_
X-MS-Office365-Filtering-Correlation-Id: e0131c7c-9890-435e-80b1-08de37f18cb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1N0yZYbN+Zb9Qzz8NdNcHiSRvVTmYoEDAnvK65TxIk7FnONWXgpNbBnFLJfK?=
 =?us-ascii?Q?yZI6WYjNQPeiq0ce87vfdReFLHv9/8KuJRepcaDHqqM3hv7D52PQ1r1VEnbl?=
 =?us-ascii?Q?qNXwlM3/fnL3GVxAos/wXSbF0bPz+5LsdNjnifcgZpioJ6R5CHhl3zy41PVy?=
 =?us-ascii?Q?2PB8+SDMxbHG7KErnKduZGcAMeFMKBiUZ5D3h2KyF9KncWk7TRIEO9LQjOeL?=
 =?us-ascii?Q?ucZLy9hDtV6UBsfzhTviZBNctvWJPgnzkS8XFvk3LUw2023LuUh0Pq/C/wmU?=
 =?us-ascii?Q?vQKcQQFAfpsH+yD7u5W2sPiRy/GZkRNUBWzXtY3J0r/ntffOPsToLTWzEzsh?=
 =?us-ascii?Q?7I5PXn/CNwja/yduxz8UBuTN871HKYpCMYvvS8rlOfdEnx3KFNUs+5voJ1VZ?=
 =?us-ascii?Q?UBKp+5+4lA2O6iOEcWpuoE8+E6e7TTNqkWxMWZ7mP7Bu9imw1n32rVUAC7tP?=
 =?us-ascii?Q?S1corM32ZzrCUHlTpT4TzpUzmoR3AEX4eiz5XqQbIf/xHpQDPs5lukUsuQrX?=
 =?us-ascii?Q?RLmFPwCj3GemhaJ//RQETLf1ylpn0raNTAcSDMh6C/JV3KiFagzw60XFg5pP?=
 =?us-ascii?Q?Mj7gSU5dTvCXBk3+bl3BuY+247g7JPnY2/yxJSXNM760q94WQQAXeiluUNLq?=
 =?us-ascii?Q?Ib17XahtrV+JvBPjOPSrd6weW2MH0eh9I+oLRlxzTHT/msRWLBeLV/M8fN9j?=
 =?us-ascii?Q?qOLuYnMe7871kVukn1O1JGMxxIGj2R/QP0Uj5NV334m9qOsz77qLuGvO7Kvh?=
 =?us-ascii?Q?rSrElsA9YbdhkqRvZ9DbJLhATsrGniqEG3PGwymuhxlyJyGnyYIYy8aqwEAh?=
 =?us-ascii?Q?PJAWmfqsvSm2/GiGE+5881mn4hLfYCHY96iQGQoYMzbGnfqTFizacKgfk3/B?=
 =?us-ascii?Q?Oh4uZfLuQbfVqM/8FfmmcTiXRGqF35nC5YQg8Hxcf/S35disTAJGFrA0ncwP?=
 =?us-ascii?Q?y2lUj78gyebnfZJWQCxJfX8W42awsOF/dxkrTbOchzHmKREsRRa1K9Ny2SJ8?=
 =?us-ascii?Q?db5pKop/49UAU7bj8mon3nSQiVcCjtPbhdA/t+MdXXS0KuTQREBLK4CdbOz9?=
 =?us-ascii?Q?fhcLIUV5LqA7HQDDxRL2jKfRBEuGXVepviPDJsl4lZc9buC2yXZ8n99o0CvD?=
 =?us-ascii?Q?XmGzq+tzuOfrcJY/p9rtn/fZfiZK+xd9eMIPtbb5kps/2wqyN9nJs4K1v+Ee?=
 =?us-ascii?Q?FTkoRRFemW6smtgG8mTOebM4SFw7YdBeUrYinN4GSYz0gyHjMsmmD9dMbZTE?=
 =?us-ascii?Q?17Z4TH7LRGOCheot8nYLVFyA1IpZi7bSz6uJCKCw9JiOu/xZMAxs+IoFrVg0?=
 =?us-ascii?Q?HKzWGqP2DYXtx9pNB+cYnsmp6DjRGJYtBKSI+Jp/BBLdNXMAx3bEgXuhpXAG?=
 =?us-ascii?Q?2xEQmy+kV3LRcMaxcAfLtT76XeoY5PqWVSv7Gt6fY/m60t5tXb2YVs6evo/6?=
 =?us-ascii?Q?8T7BYP/6dgo+YCkMaBAowzWeVMunu+BgQ0azlNkYlMGYdMy3jTTi+HfTy0Fe?=
 =?us-ascii?Q?RCFSxmqbYgZS2cXLRzcGLm6ah/XUPDu3ZD1Qep5M7SbZGis7h10g0Q08i4jA?=
 =?us-ascii?Q?gFj/Fd50CqNiPHdCUuA=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 13:39:31.9357 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0131c7c-9890-435e-80b1-08de37f18cb8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6801
Received-SPF: softfail client-ip=2a01:111:f403:c000::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Rename struct AcpiIortSMMUv3Dev to AcpiSMMUv3Dev so that it is not
specific to IORT. Subsequent Tegra241 CMDQV support patch will use the
same struct to build CMDQV DSDT support as well.

No functional changes intended.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/virt-acpi-build.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 1e3779991e..4f8d36dae0 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -339,7 +339,7 @@ static int iort_idmap_compare(gconstpointer a, gconstpointer b)
     return idmap_a->input_base - idmap_b->input_base;
 }
 
-typedef struct AcpiIortSMMUv3Dev {
+typedef struct AcpiSMMUv3Dev {
     int irq;
     hwaddr base;
     GArray *rc_smmu_idmaps;
@@ -347,16 +347,16 @@ typedef struct AcpiIortSMMUv3Dev {
     size_t offset;
     bool accel;
     bool ats;
-} AcpiIortSMMUv3Dev;
+} AcpiSMMUv3Dev;
 
 /*
- * Populate the struct AcpiIortSMMUv3Dev for the legacy SMMUv3 and
+ * Populate the struct AcpiSMMUv3Dev for the legacy SMMUv3 and
  * return the total number of associated idmaps.
  */
 static int populate_smmuv3_legacy_dev(GArray *sdev_blob)
 {
     VirtMachineState *vms = VIRT_MACHINE(qdev_get_machine());
-    AcpiIortSMMUv3Dev sdev;
+    AcpiSMMUv3Dev sdev;
 
     sdev.rc_smmu_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
     object_child_foreach_recursive(object_get_root(), iort_host_bridges,
@@ -376,8 +376,8 @@ static int populate_smmuv3_legacy_dev(GArray *sdev_blob)
 
 static int smmuv3_dev_idmap_compare(gconstpointer a, gconstpointer b)
 {
-    AcpiIortSMMUv3Dev *sdev_a = (AcpiIortSMMUv3Dev *)a;
-    AcpiIortSMMUv3Dev *sdev_b = (AcpiIortSMMUv3Dev *)b;
+    AcpiSMMUv3Dev *sdev_a = (AcpiSMMUv3Dev *)a;
+    AcpiSMMUv3Dev *sdev_b = (AcpiSMMUv3Dev *)b;
     AcpiIortIdMapping *map_a = &g_array_index(sdev_a->rc_smmu_idmaps,
                                               AcpiIortIdMapping, 0);
     AcpiIortIdMapping *map_b = &g_array_index(sdev_b->rc_smmu_idmaps,
@@ -391,7 +391,7 @@ static int iort_smmuv3_devices(Object *obj, void *opaque)
     GArray *sdev_blob = opaque;
     AcpiIortIdMapping idmap;
     PlatformBusDevice *pbus;
-    AcpiIortSMMUv3Dev sdev;
+    AcpiSMMUv3Dev sdev;
     int min_bus, max_bus;
     SysBusDevice *sbdev;
     PCIBus *bus;
@@ -421,7 +421,7 @@ static int iort_smmuv3_devices(Object *obj, void *opaque)
 }
 
 /*
- * Populate the struct AcpiIortSMMUv3Dev for all SMMUv3 devices and
+ * Populate the struct AcpiSMMUv3Dev for all SMMUv3 devices and
  * return the total number of idmaps.
  */
 static int populate_smmuv3_dev(GArray *sdev_blob)
@@ -442,10 +442,10 @@ static void create_rc_its_idmaps(GArray *its_idmaps, GArray *smmuv3_devs)
 {
     AcpiIortIdMapping *idmap;
     AcpiIortIdMapping next_range = {0};
-    AcpiIortSMMUv3Dev *sdev;
+    AcpiSMMUv3Dev *sdev;
 
     for (int i = 0; i < smmuv3_devs->len; i++) {
-        sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, i);
+        sdev = &g_array_index(smmuv3_devs, AcpiSMMUv3Dev, i);
         /*
          * Based on the RID ranges that are directed to the SMMU, determine the
          * bypassed RID ranges, i.e., the ones that are directed to the ITS
@@ -479,7 +479,7 @@ static void create_rc_its_idmaps(GArray *its_idmaps, GArray *smmuv3_devs)
 static void
 build_iort_rmr_nodes(GArray *table_data, GArray *smmuv3_devices, uint32_t *id)
 {
-    AcpiIortSMMUv3Dev *sdev;
+    AcpiSMMUv3Dev *sdev;
     AcpiIortIdMapping *idmap;
     int i;
 
@@ -487,7 +487,7 @@ build_iort_rmr_nodes(GArray *table_data, GArray *smmuv3_devices, uint32_t *id)
         uint16_t rmr_len;
         int bdf;
 
-        sdev = &g_array_index(smmuv3_devices, AcpiIortSMMUv3Dev, i);
+        sdev = &g_array_index(smmuv3_devices, AcpiSMMUv3Dev, i);
         if (!sdev->accel) {
             continue;
         }
@@ -544,13 +544,13 @@ static void
 build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 {
     int i, nb_nodes, rc_mapping_count;
-    AcpiIortSMMUv3Dev *sdev;
+    AcpiSMMUv3Dev *sdev;
     size_t node_size;
     bool ats_needed = false;
     int num_smmus = 0;
     uint32_t id = 0;
     int rc_smmu_idmaps_len = 0;
-    GArray *smmuv3_devs = g_array_new(false, true, sizeof(AcpiIortSMMUv3Dev));
+    GArray *smmuv3_devs = g_array_new(false, true, sizeof(AcpiSMMUv3Dev));
     GArray *rc_its_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
 
     AcpiTable table = { .sig = "IORT", .rev = 5, .oem_id = vms->oem_id,
@@ -581,7 +581,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         }
         /* Calculate RMR nodes required. One per SMMUv3 with accelerated mode */
         for (i = 0; i < num_smmus; i++) {
-            sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, i);
+            sdev = &g_array_index(smmuv3_devs, AcpiSMMUv3Dev, i);
             if (sdev->ats) {
                 ats_needed = true;
             }
@@ -620,7 +620,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     }
 
     for (i = 0; i < num_smmus; i++) {
-        sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, i);
+        sdev = &g_array_index(smmuv3_devs, AcpiSMMUv3Dev, i);
         int smmu_mapping_count, offset_to_id_array;
         int irq = sdev->irq;
 
@@ -699,7 +699,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         AcpiIortIdMapping *range;
 
         for (i = 0; i < num_smmus; i++) {
-            sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, i);
+            sdev = &g_array_index(smmuv3_devs, AcpiSMMUv3Dev, i);
 
             /*
              * Map RIDs (input) from RC to SMMUv3 nodes: RC -> SMMUv3.
@@ -742,7 +742,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     acpi_table_end(linker, &table);
     g_array_free(rc_its_idmaps, true);
     for (i = 0; i < num_smmus; i++) {
-        sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, i);
+        sdev = &g_array_index(smmuv3_devs, AcpiSMMUv3Dev, i);
         g_array_free(sdev->rc_smmu_idmaps, true);
     }
     g_array_free(smmuv3_devs, true);
-- 
2.43.0


