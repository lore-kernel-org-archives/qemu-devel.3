Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B34B1CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:50:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN9d-0004c1-LH; Sat, 30 Aug 2025 11:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1uruU6-0002mu-Tj; Fri, 29 Aug 2025 04:29:25 -0400
Received: from mail-bn8nam12on2062c.outbound.protection.outlook.com
 ([2a01:111:f403:2418::62c]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1uruU0-0006N4-Vs; Fri, 29 Aug 2025 04:29:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s8kpZ/NsOIqZqOYRl45vWOptzsdEOS8/O0zm7/bpl834uKpXsOry5pbQpjnTpFdbkgRGsU2Xh3kH+QHbrGtnRnztxJY6lFfNgCfhkDjJuYL4Q9tASplub/8p/Cn3+GQpY6PGmOPWBgLxQlCi4IPVQnwP2sJoXrTh2S1CQRFjhrzO0frP13Z81wlDm3vL7qwd2k2LfwX8TRqNLb72sIJOxYGtWTTy6UlOdv3Exk8TpkKYv2+SNY5zpZE3zwC3HVCN77+6gF1WJ2cDfqgR3o+tqwl8giQEfx6/K2frVve9CN8H6rpNO7fqTWi6B3OdiRBUO+5tW8vhx5xCV7S8FYOIMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wkDCZ33ieBrMEZ4vwAUXe4s73a+GoRs2PzdECC33nY=;
 b=F937zVPpcfl6+ENFpfCHp/x+Dd5vDK2kPyVOsOzVEVoPHKTyAe/LrWPY0CBJg7TOaL3NPy8/1LvaPUdvVD6oav+0v3LapZkF5DYL9jWYwyJhZTvoKD2geACz5vdq95JMLaOac0Uk6G4jDNWU1x5YP76pmnTEI116vFjChgKD+NHah1JOlFkC4vTX+gGmhzKQzfewiaoeJ5rdij1Aw2MnCmft/7l6lnAXlryTGOnL8vrABwl7DNTPgWYo0O/vGdbozEGKEVGExYU6T5A16VVngZqpZo5rz4nx1sdqla6wnf+Bcqk3tf7FciTB+ReoB1YQRQ/sFhwiIqFkWEqRwA1wFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wkDCZ33ieBrMEZ4vwAUXe4s73a+GoRs2PzdECC33nY=;
 b=rkD7bD5+5AiStQOKagxaG1a73auCXa8FF4VyNTojTdn4lrxHak04EfASdG1wJv+PicOj1YcV5+Je05kCtNc3TVrxz0AXBG4tEjkL/GLbhjaOxnY0LxzRW7EUR1MwMjxh9ZjrCczSNciWWXiQbffXbMajVJOuIUSWOT7Jf+8BEaOlUJCxavHCAnxTh0uXfn++uYigCoe3czBMQF1MVQwwavZSTcqbTZ8qT7hV+J0CBpLEHC//uokYWD1cf7SyXEWV+w676gqvDBCapyoHanhVCpHR/ILSUP94zox30bpTyG44Z0oE4ZDPMrvoR/0SyEl+yX7FLBQVWw/uaFZZuO1ctQ==
Received: from MW4PR04CA0080.namprd04.prod.outlook.com (2603:10b6:303:6b::25)
 by SJ2PR12MB8064.namprd12.prod.outlook.com (2603:10b6:a03:4cc::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 29 Aug
 2025 08:29:03 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:303:6b:cafe::a8) by MW4PR04CA0080.outlook.office365.com
 (2603:10b6:303:6b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Fri,
 29 Aug 2025 08:29:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Fri, 29 Aug 2025 08:29:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 29 Aug
 2025 01:28:45 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 29 Aug
 2025 01:28:41 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <imammedo@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: [PATCH v9 02/11] hw/arm/virt-acpi-build: Re-arrange SMMUv3 IORT build
Date: Fri, 29 Aug 2025 09:25:24 +0100
Message-ID: <20250829082543.7680-3-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829082543.7680-1-skolothumtho@nvidia.com>
References: <20250829082543.7680-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|SJ2PR12MB8064:EE_
X-MS-Office365-Filtering-Correlation-Id: 8caf052f-63c4-46bb-4b84-08dde6d61bfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dWw1K25Gc3YyK2pFTHNRY3hmR1RkQlJFYmVJWElQWExTZkxkUjlpU0luMFBn?=
 =?utf-8?B?VDc4bFNnNGE4a0FwVHl0UlVYeUFlNTN2eU9QSzJDdnBPMnVLOG9aZlZ2NWps?=
 =?utf-8?B?OG4wdk1sR2dIb3kvNHQ0SklFTm1ZS3Q4dkxyYkNabDlFWkJwQU4yM2lyKy9q?=
 =?utf-8?B?bG9ZejZHcHU3Wko5TCtrYWtFSkYwdGNCc0k1dUxpZDc0SFR6TXRwVVFlYmhk?=
 =?utf-8?B?N2VJRWpoS1dwTlRldkZnZ3ZwcXRVbGZONkJXT0J2SEp2TEZhMkN5dFpUaXJv?=
 =?utf-8?B?NHFsVktXSHJ5SWNjRHpQVW9Fckl3WTJxcEF1WGo2T0hrRTg3N3gyYTlIM3Q2?=
 =?utf-8?B?TUd0OWRtNkY5UFpWM2J5dFNLVUtNSFNMazhPdm9VTHRLNmplakNGZ2Fyc0ZY?=
 =?utf-8?B?M0RYeTlZWXR3ZEI0WWF1WXBVSERvMWo5NDZGRzVUZEZ4THowOEVmUXlLbk01?=
 =?utf-8?B?UXVMZld3RzZHTFZhVGFpZlVreENKc2JhSkVsUXo4aHN3OHVtcWJZYXY1U3lv?=
 =?utf-8?B?RXZCUE9UYWh1Y2JBYVBGbTZJdXlCK05MMEQyYkdVWXh0K1hrZ2xVMjhYc3l0?=
 =?utf-8?B?T3ora2ZLT1FweDVSd1paUHUvQWl1V3RYbFZkZGhKZTBMVXl0TkEwb0drVGZB?=
 =?utf-8?B?K2RYRHdnZnk1bDhSTXdIbFQzVUY3Nk5PRXlBQjU5L0xua2hnMzVTUTVyWmJQ?=
 =?utf-8?B?WG5TU0FtamUzOTU2OHdJVXY3K0VvNFBURjhhdVFjSmlJVmxxRXgrRFI3K3lC?=
 =?utf-8?B?a1RONmZLa2J5cldqU1FDaEQ4NGF4d2FHdWlpUTY4NjZNbGNBMFhxenRsRUxo?=
 =?utf-8?B?ME1IditJbDdiLzJGOVU5N2p2YjNZSlNQcENvbWliSFJtb3I1S3I0eUdtbkNX?=
 =?utf-8?B?RXhYMWZMRGFJeVBaMzlObU0zbFBKeWk0TkwxVW9VTmVzbkxHaE9FM2I5WUZC?=
 =?utf-8?B?Q2VuWFd6T3FCbTlGYmZNT2NTSmpTZGlRRFFVcmtWWmlsdGVuR1ZzMGMxUHlX?=
 =?utf-8?B?UEJaN2lNSDQ1WTJvZjQwaVpVQjYvcVRqdUpueVl5SmhvWlJBWFNubVRMTkU0?=
 =?utf-8?B?aHk0NVFuWFpURjlERjNodmlka1lXbEo1eE1OODcyVGJ3N1Zlc21raGFTNnla?=
 =?utf-8?B?WStibFppckhCT2N5eDBQcUZWTTBOQll4eS8yMFVEMXl0ZFQ5ZjJmZmh0M3pr?=
 =?utf-8?B?bXdHcStCbVNkTGJqK2NFSHh1T1NwQ3pFb1lOb3hvL1N3M2psNkdabHBrOW9L?=
 =?utf-8?B?cm5tRlBScWROaFA3c3crYVlza3pQc3lkY3ZUZDVjZkN5c3NvQmFVRVBSdW9H?=
 =?utf-8?B?aEs3QWNGRlIrcmVGa0VDVW0wcjhCNUE2ZkVpU0hGdC95MXBhMHExZGw4V1BJ?=
 =?utf-8?B?OUlPdkxmSmk0VmRSTERwdkZPeEtTVnE5TUcyQi9wVFM3NlBZdjFEOExLQlhp?=
 =?utf-8?B?cjVWNHFKbEdGMGsxeXd1S3EvRm1Ec1VpZTIxb2I0U01qbXR5VTFSbUxRS2JF?=
 =?utf-8?B?ZjRGdTAxYnMxVjFOMWducWppMlFZd0dnRjIyV2pGSG1iQ29kZWJKY1FCYlQ4?=
 =?utf-8?B?S09IUGh6YTdrOFhtN1NqZlFOOUFNM0FvRHpoVWs5S0RMNzNhMkVaVVEydWpq?=
 =?utf-8?B?bDZOL3NmSWRUN2dZaFdZZi9oZldieVZURGRrNVc5VzYvZUkvb3VjL1RSQ3ZQ?=
 =?utf-8?B?ZExwSCt1NDROclc3Z05nY3lUQnJQRjM3Q1NkaGVPV3lCOHdleC81T3U0Ukd6?=
 =?utf-8?B?T1FvTWZDYXd1WFhvRzhyVVhQRmZzWmlwVkdZZTVydlk4Q3VqVHZ0eCtwd1Q4?=
 =?utf-8?B?MGVCcVVFbm5vYytsWWkrYlkvbkI0aXB5bTNlOFBETjdPQU5CUmh2clQ4VDNR?=
 =?utf-8?B?MFJPbGNXd0xVY0lXOGlFRlAxVGxWeTZ4ZHJQekJobzF1MXc0Z1VocmhZRGk0?=
 =?utf-8?B?V1lkWEdmVm50WSs1aEwxcjVaL0hxbzM2Rk1EYTJsWGdIZ1lmYTBjbThSR2VR?=
 =?utf-8?B?WkIyVFVQUG85UjdtcTBOR2FRNzZyQVI1N1p1eU5DWWtmdXVqQnBDUXRITytp?=
 =?utf-8?Q?ZZwxkU?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 08:29:02.2558 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8caf052f-63c4-46bb-4b84-08dde6d61bfc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8064
Received-SPF: permerror client-ip=2a01:111:f403:2418::62c;
 envelope-from=skolothumtho@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FORGED_SPF_HELO=1, KHOP_HELO_FCRDNS=0.399,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 29 Aug 2025 09:59:54 -0400
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

Introduce a new struct AcpiIortSMMUv3Dev to hold all the information
required for SMMUv3 IORT node and use that for populating the node.

The current machine wide SMMUv3 is named as legacy SMMUv3 as we will
soon add support for user-creatable SMMUv3 devices. These changes will
be useful to have common code paths when we add that support.

Tested-by: Nathan Chen <nathanc@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/virt-acpi-build.c | 137 ++++++++++++++++++++++++++-------------
 hw/arm/virt.c            |   1 +
 include/hw/arm/virt.h    |   1 +
 3 files changed, 94 insertions(+), 45 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index b01fc4f8ef..bef4fabe56 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -305,29 +305,65 @@ static int iort_idmap_compare(gconstpointer a, gconstpointer b)
     return idmap_a->input_base - idmap_b->input_base;
 }
 
+typedef struct AcpiIortSMMUv3Dev {
+    int irq;
+    hwaddr base;
+    GArray *rc_smmu_idmaps;
+    /* Offset of the SMMUv3 IORT Node relative to the start of the IORT */
+    size_t offset;
+} AcpiIortSMMUv3Dev;
+
+/*
+ * Populate the struct AcpiIortSMMUv3Dev for the legacy SMMUv3 and
+ * return the total number of associated idmaps.
+ */
+static int populate_smmuv3_legacy_dev(GArray *sdev_blob)
+{
+    VirtMachineState *vms = VIRT_MACHINE(qdev_get_machine());
+    AcpiIortSMMUv3Dev sdev;
+
+    sdev.rc_smmu_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
+    object_child_foreach_recursive(object_get_root(), iort_host_bridges,
+                                   sdev.rc_smmu_idmaps);
+    /*
+     * There can be only one legacy SMMUv3("iommu=smmuv3") as it is a machine
+     * wide one. Since it may cover multiple PCIe RCs(based on "bypass_iommu"
+     * property), may have multiple SMMUv3 idmaps. Sort it by input_base.
+     */
+    g_array_sort(sdev.rc_smmu_idmaps, iort_idmap_compare);
+
+    sdev.base = vms->memmap[VIRT_SMMU].base;
+    sdev.irq = vms->irqmap[VIRT_SMMU] + ARM_SPI_BASE;
+    g_array_append_val(sdev_blob, sdev);
+    return sdev.rc_smmu_idmaps->len;
+}
+
 /* Compute ID ranges (RIDs) from RC that are directed to the ITS Group node */
-static void create_rc_its_idmaps(GArray *its_idmaps, GArray *smmu_idmaps)
+static void create_rc_its_idmaps(GArray *its_idmaps, GArray *smmuv3_devs)
 {
     AcpiIortIdMapping *idmap;
     AcpiIortIdMapping next_range = {0};
+    AcpiIortSMMUv3Dev *sdev;
 
-    /*
-     * Based on the RID ranges that are directed to the SMMU, determine the
-     * bypassed RID ranges, i.e., the ones that are directed to the ITS Group
-     * node and do not pass through the SMMU, by subtracting the SMMU-bound
-     * ranges from the full RID range (0x0000–0xFFFF).
-     */
-     for (int i = 0; i < smmu_idmaps->len; i++) {
-        idmap = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);
+    for (int i = 0; i < smmuv3_devs->len; i++) {
+        sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, i);
+        /*
+         * Based on the RID ranges that are directed to the SMMU, determine the
+         * bypassed RID ranges, i.e., the ones that are directed to the ITS
+         * Group node and do not pass through the SMMU, by subtracting the
+         * SMMU-bound ranges from the full RID range (0x0000–0xFFFF).
+         */
+         for (int j = 0; j < sdev->rc_smmu_idmaps->len; j++) {
+            idmap = &g_array_index(sdev->rc_smmu_idmaps, AcpiIortIdMapping, j);
 
-        if (next_range.input_base < idmap->input_base) {
-            next_range.id_count = idmap->input_base - next_range.input_base;
-            g_array_append_val(its_idmaps, next_range);
-        }
+            if (next_range.input_base < idmap->input_base) {
+                next_range.id_count = idmap->input_base - next_range.input_base;
+                g_array_append_val(its_idmaps, next_range);
+            }
 
-        next_range.input_base = idmap->input_base + idmap->id_count;
+            next_range.input_base = idmap->input_base + idmap->id_count;
+        }
     }
-
     /*
      * Append the last RC -> ITS ID mapping.
      *
@@ -341,7 +377,6 @@ static void create_rc_its_idmaps(GArray *its_idmaps, GArray *smmu_idmaps)
     }
 }
 
-
 /*
  * Input Output Remapping Table (IORT)
  * Conforms to "IO Remapping Table System Software on ARM Platforms",
@@ -351,9 +386,12 @@ static void
 build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 {
     int i, nb_nodes, rc_mapping_count;
-    size_t node_size, smmu_offset = 0;
+    AcpiIortSMMUv3Dev *sdev;
+    size_t node_size;
+    int num_smmus = 0;
     uint32_t id = 0;
-    GArray *rc_smmu_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
+    int rc_smmu_idmaps_len = 0;
+    GArray *smmuv3_devs = g_array_new(false, true, sizeof(AcpiIortSMMUv3Dev));
     GArray *rc_its_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
 
     AcpiTable table = { .sig = "IORT", .rev = 3, .oem_id = vms->oem_id,
@@ -361,22 +399,21 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     /* Table 2 The IORT */
     acpi_table_begin(&table, table_data);
 
-    if (vms->iommu == VIRT_IOMMU_SMMUV3) {
-        object_child_foreach_recursive(object_get_root(),
-                                       iort_host_bridges, rc_smmu_idmaps);
-
-        /* Sort the smmu idmap by input_base */
-        g_array_sort(rc_smmu_idmaps, iort_idmap_compare);
+    if (vms->legacy_smmuv3_present) {
+        rc_smmu_idmaps_len = populate_smmuv3_legacy_dev(smmuv3_devs);
+    }
 
-        nb_nodes = 2; /* RC and SMMUv3 */
-        rc_mapping_count = rc_smmu_idmaps->len;
+    num_smmus = smmuv3_devs->len;
+    if (num_smmus) {
+        nb_nodes = num_smmus + 1; /* RC and SMMUv3 */
+        rc_mapping_count = rc_smmu_idmaps_len;
 
         if (vms->its) {
             /*
              * Knowing the ID ranges from the RC to the SMMU, it's possible to
              * determine the ID ranges from RC that go directly to ITS.
              */
-            create_rc_its_idmaps(rc_its_idmaps, rc_smmu_idmaps);
+            create_rc_its_idmaps(rc_its_idmaps, smmuv3_devs);
 
             nb_nodes++; /* ITS */
             rc_mapping_count += rc_its_idmaps->len;
@@ -411,9 +448,10 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         build_append_int_noprefix(table_data, 0 /* MADT translation_id */, 4);
     }
 
-    if (vms->iommu == VIRT_IOMMU_SMMUV3) {
-        int irq =  vms->irqmap[VIRT_SMMU] + ARM_SPI_BASE;
+    for (i = 0; i < num_smmus; i++) {
+        sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, i);
         int smmu_mapping_count, offset_to_id_array;
+        int irq = sdev->irq;
 
         if (vms->its) {
             smmu_mapping_count = 1; /* ITS Group node */
@@ -422,7 +460,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
             smmu_mapping_count = 0; /* No ID mappings */
             offset_to_id_array = 0; /* No ID mappings array */
         }
-        smmu_offset = table_data->len - table.table_offset;
+        sdev->offset = table_data->len - table.table_offset;
         /* Table 9 SMMUv3 Format */
         build_append_int_noprefix(table_data, 4 /* SMMUv3 */, 1); /* Type */
         node_size =  SMMU_V3_ENTRY_SIZE +
@@ -435,7 +473,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         /* Reference to ID Array */
         build_append_int_noprefix(table_data, offset_to_id_array, 4);
         /* Base address */
-        build_append_int_noprefix(table_data, vms->memmap[VIRT_SMMU].base, 8);
+        build_append_int_noprefix(table_data, sdev->base, 8);
         /* Flags */
         build_append_int_noprefix(table_data, 1 /* COHACC Override */, 4);
         build_append_int_noprefix(table_data, 0, 4); /* Reserved */
@@ -486,21 +524,26 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     build_append_int_noprefix(table_data, 0, 3); /* Reserved */
 
     /* Output Reference */
-    if (vms->iommu == VIRT_IOMMU_SMMUV3) {
+    if (num_smmus) {
         AcpiIortIdMapping *range;
 
-        /*
-         * Map RIDs (input) from RC to SMMUv3 nodes: RC -> SMMUv3.
-         *
-         * N.B.: The mapping from SMMUv3 to ITS Group node (SMMUv3 -> ITS) is
-         * defined in the SMMUv3 table, where all SMMUv3 IDs are mapped to the
-         * ITS Group node, if ITS is available.
-         */
-        for (i = 0; i < rc_smmu_idmaps->len; i++) {
-            range = &g_array_index(rc_smmu_idmaps, AcpiIortIdMapping, i);
-            /* Output IORT node is the SMMUv3 node. */
-            build_iort_id_mapping(table_data, range->input_base,
-                                  range->id_count, smmu_offset);
+        for (i = 0; i < num_smmus; i++) {
+            sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, i);
+
+            /*
+             * Map RIDs (input) from RC to SMMUv3 nodes: RC -> SMMUv3.
+             *
+             * N.B.: The mapping from SMMUv3 to ITS Group node (SMMUv3 -> ITS)
+             * is defined in the SMMUv3 table, where all SMMUv3 IDs are mapped
+             * to the ITS Group node, if ITS is available.
+             */
+             for (int j = 0; j < sdev->rc_smmu_idmaps->len; j++) {
+                range = &g_array_index(sdev->rc_smmu_idmaps,
+                                       AcpiIortIdMapping, j);
+                /* Output IORT node is the SMMUv3 node. */
+                build_iort_id_mapping(table_data, range->input_base,
+                                      range->id_count, sdev->offset);
+            }
         }
 
         if (vms->its) {
@@ -525,8 +568,12 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     }
 
     acpi_table_end(linker, &table);
-    g_array_free(rc_smmu_idmaps, true);
     g_array_free(rc_its_idmaps, true);
+    for (i = 0; i < num_smmus; i++) {
+        sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, i);
+        g_array_free(sdev->rc_smmu_idmaps, true);
+    }
+    g_array_free(smmuv3_devs, true);
 }
 
 /*
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9326cfc895..4663184654 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1650,6 +1650,7 @@ static void create_pcie(VirtMachineState *vms)
                 qemu_fdt_setprop_cells(ms->fdt, nodename, "iommu-map",
                                        0x0, vms->iommu_phandle, 0x0, 0x10000);
             }
+            vms->legacy_smmuv3_present = true;
             break;
         default:
             g_assert_not_reached();
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 365a28b082..ea2cff05b0 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -179,6 +179,7 @@ struct VirtMachineState {
     char *oem_table_id;
     bool ns_el2_virt_timer_irq;
     CXLState cxl_devices_state;
+    bool legacy_smmuv3_present;
 };
 
 #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
-- 
2.43.0


