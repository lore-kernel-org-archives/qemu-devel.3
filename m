Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9085EE20A8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 14:53:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voNC6-000387-6s; Fri, 06 Feb 2026 09:52:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1voNAv-0001PI-5R; Fri, 06 Feb 2026 09:51:14 -0500
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1voNAt-0007Xg-9z; Fri, 06 Feb 2026 09:51:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Szo3TZwTP8TBTuVZOQkKXgdl0hnrfC4VyGImh2lVU5u0lZrQfKy0lauCpeCJfS9OtgXOK3IE1VzY7m68egVLWVCyDYSAFdRd5SW5YhJLpekrFwWUIBCI2bi7+b0jyMvuPMKywMfLm4nh5Bfp0FCTnon14MBs4JO7C93Uq0EXLGXDQwdVU5uXPzs/gv0clvTUYJ+JfciZUVebcwykCJDEJqoCNT2OpvRYKw4PAnuT49g28ZTBEYATvn2ITND7OWPoEvciAG40D3MIO//xZZ1lntK2HE/l5rEZAfQKTtuvuGQKaavqk3UKcMTm8OpV9HO3xrt0QSqIOUqx9qNL8ea0mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzcr0C103emIDpdvJO6bxXW/F25M0iS5s68PyzCNJTE=;
 b=gchkwhLVq5LCWd+GbBR2EsB+RT4tBCU8XLcadSRJZ7kvs3gvBemQYSRQpA/dHLu/8bTc5ou4SWp9uzHpJ68UllZ5NHdjPj0HkYevgjc/gilyYWMM7hnD+gRunS9t495pnKSJl5gNuMR2sxTMDp9ZlHzHg9gjPdnxqZyELvO7mgHIwNEUJ7mkbKekU6Kvz/WzIFpbhZit96YdURBgfI3mUKv445QCh6VvJYIFNW+Se6RBAg4ay1rj1z0U/CPaV6/+qVTy3ZroBxFmT3dRqo0gNsmZETL0lGDNGgjThHURd9znSu8z8FmLPTdfCdtGs5nHGE+xDofxE9ebrnqFqfT7LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzcr0C103emIDpdvJO6bxXW/F25M0iS5s68PyzCNJTE=;
 b=VwtSbpD4t6/nMvqPcf5aa9+4DB1ap9XLarplOkeJzMhYy8PgIb2VGMQhvexwxBXDOzO1krJX9R4bRPYV23aA9+PhCTgAW8R0vSoAQjGA8TOP7K3rWIYimA+/eM7GHnvJh0QRJhIuSI1y7anJEcDQ5PFM9BX0XIq/8YYyoR2QP5xMY3eHIvfCKQOtlA6MiYVoFBOGzB6FOQKuk7b5WHoCeZKQTOKABeqfZfYBYp6xL087auDTNODoSn2oC/DLmng6mM2Wbbc98/Itc3+WmrL4044CXBTeYPoeGu2LW2jeIl566WW3TbDrW3M+xWJ0sX+I39O210lUw0WSrcgm/n6xaQ==
Received: from BY5PR13CA0019.namprd13.prod.outlook.com (2603:10b6:a03:180::32)
 by PH8PR12MB6770.namprd12.prod.outlook.com (2603:10b6:510:1c5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Fri, 6 Feb
 2026 14:51:00 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::49) by BY5PR13CA0019.outlook.office365.com
 (2603:10b6:a03:180::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Fri,
 6 Feb 2026 14:51:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 14:50:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:50:30 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:50:26 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v2 21/24] virt-acpi-build: Rename AcpiIortSMMUv3Dev to
 AcpiSMMUv3Dev
Date: Fri, 6 Feb 2026 14:48:20 +0000
Message-ID: <20260206144823.80655-22-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206144823.80655-1-skolothumtho@nvidia.com>
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|PH8PR12MB6770:EE_
X-MS-Office365-Filtering-Correlation-Id: aaad0662-82de-4624-fb1d-08de658f2330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+sHfgMs70ZV5Je/prFi1uh/ZYdmabwtHMD1IgtKoVoYZsP4cpD/yCrcR+saX?=
 =?us-ascii?Q?7WDVaVO5dVssidspEVVtXSkSKurscATfjEibt7e32dV7hyeklgR8wUgvEkas?=
 =?us-ascii?Q?JbDn8NAk+Ufky1VBuxeFEc1gY4TxjCxopj5JPU6hEmY6131GREwDRalMALsJ?=
 =?us-ascii?Q?ZH6TjlzQ5HeqsDIWjuJGo7l8/o4IMHdXDNr6DM6Jdkua9zrnR1HSDA2j2HUP?=
 =?us-ascii?Q?JvY+lDeSvv6X/j3KddEpWMpfvjjYLUw4N3u0sDjxUHdqWgDhX7B0ryu1NYnP?=
 =?us-ascii?Q?7BbszrJcUzw92jkx6kFoeJGlj/EsuJi5gJcin0t/4+3czg5r+1is7+F7LliD?=
 =?us-ascii?Q?eHS+QlQ2iD6bWcgetZWWHFNHKTBTQcfut48SloeVkf/YU5jFsDPeVv4LWpKk?=
 =?us-ascii?Q?qDBcRFD3O5wDPEfpgEpeBWD270+x9YiCgIqcKuWE0JDuwCgWUR9xGL0GatcK?=
 =?us-ascii?Q?uBrCg0a2dcdPFlYTWm6GvQ2OxSoIhBkSQQZtqv3SRM1gtJJlcaT3uSYwXqZs?=
 =?us-ascii?Q?akRJlcPpVba8XlgW+saACIz7cPwaRWGPtdfCRvgKBvkwtF8MpTIYTLnb4YVa?=
 =?us-ascii?Q?S9HR03xNYCHLAOfEcz2hKd9IoAx1AN/1JwmIzs6xo9PNO03QEc3Vd6LixNY+?=
 =?us-ascii?Q?3fcI7ncVFeN3bEqom/62sBQOa//PqWM0FAmv8n1frD/e4i7LHSQkZvdD4QcH?=
 =?us-ascii?Q?Rj9T8he4Dp5Qhp7v1GLONjM8XFj65aZTe4L33+5MegNG1bOKQMDC8tX8mL6q?=
 =?us-ascii?Q?J6kAa96CtRBQtIb9dDoTrAzpSQwA315CCvfkaNg0iWAdWES2d3JZqpEgOd+d?=
 =?us-ascii?Q?CcQxTM9+yj3nSI5mWmybUjymucBXzOGvtYnjO2z43Q1nnbgv87/+eozlkjn3?=
 =?us-ascii?Q?ncl4gw+Yf4I4EL4dVTnEidUEbXXXiPzongeDeqZ2y2ES/yNoG9sscrLVeUFS?=
 =?us-ascii?Q?FME3YeoFYeBHszzfgUxLkl296AYQNjcEZFYsWga0+ZEHEHbfYMmdNkdjDa77?=
 =?us-ascii?Q?MK0xB6rT1ehn0z72Hw1OhYNUnkLOYQcVaYexSbBISyDBg7WAobzePubyfgJs?=
 =?us-ascii?Q?DM1ch+01fkzU0NfvqZl33XhM2NvAT093ODLfM4N6AnrlseQVCMm64Q8F/5ZB?=
 =?us-ascii?Q?9jEi6Lg9WgpVSqYbGkbdNVxQ7Em4kVZLz+tsCz5ExuSdUwKIdXDG+vRXWlR9?=
 =?us-ascii?Q?iO5DYhfPPD/DbvWUup+QbIa6qG/12MF4bhCJ52Wv2ZWZTfXZK3eUfzLBnfA2?=
 =?us-ascii?Q?Yvsc//lZ+/ogjbuaGbmogfD1cJUCS1o2FH1NUbFLwHCCChR+PLJGDskUpqpR?=
 =?us-ascii?Q?Uy6JiUzlUb/daUPlXQV1zIOkTywj71TQd8fX3SmVKoO6cRQY0YUrFgbgcsYi?=
 =?us-ascii?Q?n7LCRLAlLLyKXl2sedhnhKenmkZXGgSpyXx9OlCP49tZxlGyhTL36m56y5V0?=
 =?us-ascii?Q?J9F68s7ASEKuXE7ufEYcjoJNyP6zoE5mr91enmAKS2aPAOKqrYywtL5vV2pd?=
 =?us-ascii?Q?c7wcQ+7mgorNw/ehCfFC0SdmR2c4PAsNSGrCPF797YrDIlj6gKKc3d5Y6iaV?=
 =?us-ascii?Q?KWGeLFzE8zQA1QkgTN90Bf0Ajuo1zOTYfQgSh6Afz/bMLeu1nTbbzKkUeZgH?=
 =?us-ascii?Q?OgzWurS+pCFDB25bIGaJXke0rZInE2FD6hxPOdH4+L+skpX6cIH6lyQ9dpTL?=
 =?us-ascii?Q?5gXKvQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: P1S2Zw9ShTOQQCewCHB3k07+qpXJzQRHLSuU8EgOleZY3ULn90u9+QfXUSAIxXzMhhj578YXvaocV7dmk9pms0OPQ6CX2Xje/G42R3jXnoxqingavULmDDs2H0PYQof8+Bpkqr+VX2EPQQM49IycLL/RBSco3OmtsatBKgikr+6d5fTWhj4DHEbFje843mFSmbFV6JbhVHGPkNpZgPahxrSc7DBrP/5vGE2gepxt4JtSAqWh1QmaIl5LvFp4x6vJ5m0S6e77oeOAYMOkpjeRLIUFNfKruTm5w9rBcnhhT914z075uciX+4C48kOd+g2LiauRjEAVkAfJi0bccvDhK7n9QAXlcN0FnjZL1i/Hs5N0Awv66X2eZ7sTRGMY7HEghT6HY7xzH0tmQiVOnCXKVRRhUjKAOuANgFEpcySc355i2BHkdLYRRa1KG+WHy5de
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:50:57.6825 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aaad0662-82de-4624-fb1d-08de658f2330
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6770
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
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

Rename struct AcpiIortSMMUv3Dev to AcpiSMMUv3Dev so that it is not
specific to IORT. Subsequent Tegra241 CMDQV support patch will use the
same struct to build CMDQV DSDT support as well.

No functional changes intended.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/virt-acpi-build.c | 44 ++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index c145678185..ae3b4aac52 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -339,24 +339,28 @@ static int iort_idmap_compare(gconstpointer a, gconstpointer b)
     return idmap_a->input_base - idmap_b->input_base;
 }
 
-typedef struct AcpiIortSMMUv3Dev {
+typedef struct AcpiSMMUv3Dev {
     int irq;
     hwaddr base;
+
+    /*
+     * IORT-only fields.
+     * These are used when building IORT SMMUv3 nodes.
+     */
     GArray *rc_smmu_idmaps;
-    /* Offset of the SMMUv3 IORT Node relative to the start of the IORT */
-    size_t offset;
+    size_t offset; /* Offset of the SMMUv3 node within the IORT table */
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
-    AcpiIortSMMUv3Dev sdev = {0};
+    AcpiSMMUv3Dev sdev = {0};
 
     sdev.rc_smmu_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
     object_child_foreach_recursive(object_get_root(), iort_host_bridges,
@@ -376,8 +380,8 @@ static int populate_smmuv3_legacy_dev(GArray *sdev_blob)
 
 static int smmuv3_dev_idmap_compare(gconstpointer a, gconstpointer b)
 {
-    AcpiIortSMMUv3Dev *sdev_a = (AcpiIortSMMUv3Dev *)a;
-    AcpiIortSMMUv3Dev *sdev_b = (AcpiIortSMMUv3Dev *)b;
+    AcpiSMMUv3Dev *sdev_a = (AcpiSMMUv3Dev *)a;
+    AcpiSMMUv3Dev *sdev_b = (AcpiSMMUv3Dev *)b;
     AcpiIortIdMapping *map_a = &g_array_index(sdev_a->rc_smmu_idmaps,
                                               AcpiIortIdMapping, 0);
     AcpiIortIdMapping *map_b = &g_array_index(sdev_b->rc_smmu_idmaps,
@@ -388,7 +392,7 @@ static int smmuv3_dev_idmap_compare(gconstpointer a, gconstpointer b)
 static int iort_smmuv3_devices(Object *obj, void *opaque)
 {
     VirtMachineState *vms = VIRT_MACHINE(qdev_get_machine());
-    AcpiIortSMMUv3Dev sdev = {0};
+    AcpiSMMUv3Dev sdev = {0};
     GArray *sdev_blob = opaque;
     AcpiIortIdMapping idmap;
     PlatformBusDevice *pbus;
@@ -421,7 +425,7 @@ static int iort_smmuv3_devices(Object *obj, void *opaque)
 }
 
 /*
- * Populate the struct AcpiIortSMMUv3Dev for all SMMUv3 devices and
+ * Populate the struct AcpiSMMUv3Dev for all SMMUv3 devices and
  * return the total number of idmaps.
  */
 static int populate_smmuv3_dev(GArray *sdev_blob)
@@ -442,10 +446,10 @@ static void create_rc_its_idmaps(GArray *its_idmaps, GArray *smmuv3_devs)
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
@@ -479,7 +483,7 @@ static void create_rc_its_idmaps(GArray *its_idmaps, GArray *smmuv3_devs)
 static void
 build_iort_rmr_nodes(GArray *table_data, GArray *smmuv3_devices, uint32_t *id)
 {
-    AcpiIortSMMUv3Dev *sdev;
+    AcpiSMMUv3Dev *sdev;
     AcpiIortIdMapping *idmap;
     int i;
 
@@ -487,7 +491,7 @@ build_iort_rmr_nodes(GArray *table_data, GArray *smmuv3_devices, uint32_t *id)
         uint16_t rmr_len;
         int bdf;
 
-        sdev = &g_array_index(smmuv3_devices, AcpiIortSMMUv3Dev, i);
+        sdev = &g_array_index(smmuv3_devices, AcpiSMMUv3Dev, i);
         if (!sdev->accel) {
             continue;
         }
@@ -544,13 +548,13 @@ static void
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
@@ -581,7 +585,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         }
         /* Calculate RMR nodes required. One per SMMUv3 with accelerated mode */
         for (i = 0; i < num_smmus; i++) {
-            sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, i);
+            sdev = &g_array_index(smmuv3_devs, AcpiSMMUv3Dev, i);
             if (sdev->ats) {
                 ats_needed = true;
             }
@@ -620,7 +624,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     }
 
     for (i = 0; i < num_smmus; i++) {
-        sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, i);
+        sdev = &g_array_index(smmuv3_devs, AcpiSMMUv3Dev, i);
         int smmu_mapping_count, offset_to_id_array;
         int irq = sdev->irq;
 
@@ -699,7 +703,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         AcpiIortIdMapping *range;
 
         for (i = 0; i < num_smmus; i++) {
-            sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, i);
+            sdev = &g_array_index(smmuv3_devs, AcpiSMMUv3Dev, i);
 
             /*
              * Map RIDs (input) from RC to SMMUv3 nodes: RC -> SMMUv3.
@@ -742,7 +746,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
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


