Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5629CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 13:50:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3E8e-0003jc-8N; Mon, 29 Sep 2025 09:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E7U-0002mw-ON; Mon, 29 Sep 2025 09:40:49 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E73-0003eG-Jr; Mon, 29 Sep 2025 09:40:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CwVTIoV3f+U8pjFydWyvnyXwwNRcDurPAQwiXhkOn4XmUVzTJ3g3VYWhJFucm/lWs87lNxsaLtedxYa4K86XADCs035IkkRnVP9lHijHmCErPrKfZzRiHzIYcSOf6sKNjo+FGylAHpgiTpM2XjO1k/v5Y+6u4TVrLrXrxcWTuHoTHgQSTJrpTK42qm4Uxln/6s6/LfS+U0j1CEUSrRNZZxQ13N0Ug4wI19W0FmqwFV6jvJpUcpOZpMWISrrsp++CWlE5yGjxohnXPFerry/PNgtlptDB2gN4qD+WvME/ipx0vLHHgvjRy0yypnFgh4fI6WlS0eEH7/hEy7Zf7k+o9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nf9x1sDoOLtOhbGbOcI5x/vZpjwn43AR0rUP/0f6J7A=;
 b=YMe9nXAOJ5ZNYQvGlvxvol+B/4X8QP5D9ycPTVILh+bScx2TXGY6LuolIdJIFTmm9Ush6qoRc1BYQCL/w0T742g87mYt6fW9pgz2RB0eohcYmunkui92aR+SvMm9MUUVF3rNbBbuhdlvXl5TynUKEPKSQD60tz7QSHm6LJOrclYDN8LRZ19RA7aHlt/n5U2FIDWD6xpbzAgXnPgaFWFKC+bSQ3/VEKqqc0VMkxT6DTPfoZq7YwY13jN0MzCL7u8GsSXq77fHY6ZnOQBhB09KTYbIKyYCsGUyIw4slnk6dqGw1lHhFzS7NFN/hhHwHmwU40/1z+7Bec4wCl8FIlTovA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nf9x1sDoOLtOhbGbOcI5x/vZpjwn43AR0rUP/0f6J7A=;
 b=ALtDuUpIVUhc+W79J1grQCUe+yqWpVg+VPmm3nU8BMl0lskjCiQlTsJ7gl99z4TbN2Rzg3WVIrOUNfh8XlNxi/BdBmtvJ/PdKospoUIcKwyGAeUvi1P5KQyf0gWnQqLSTfy+lzuESiv5I578+FmuLc9NFMkdLdnv/cgdOOHZggnoC+C4LjB5VK5IUs9lFipF7XovIcYa08r+EWqNPxixW6kca7xIuIbSIMGdvZtQxe+VVDHrVtQHQIVEpbB+Fl3kfqHra3aXHxqGtj0HoKSv39jKq1HbM3UJyCiE5XOfQv7SEqKvyDbksrmphujSQdA/sbE6jtUySSRNm4hA7PbBbQ==
Received: from CH2PR08CA0006.namprd08.prod.outlook.com (2603:10b6:610:5a::16)
 by SJ2PR12MB8881.namprd12.prod.outlook.com (2603:10b6:a03:546::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Mon, 29 Sep
 2025 13:40:06 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:5a:cafe::12) by CH2PR08CA0006.outlook.office365.com
 (2603:10b6:610:5a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.15 via Frontend Transport; Mon,
 29 Sep 2025 13:40:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Mon, 29 Sep 2025 13:40:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Mon, 29 Sep
 2025 06:39:54 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Sep
 2025 06:39:50 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <shameerkolothum@gmail.com>
Subject: [PATCH v4 12/27] hw/arm/smmuv3-accel: Make use of
 get_msi_address_space() callback
Date: Mon, 29 Sep 2025 14:36:28 +0100
Message-ID: <20250929133643.38961-13-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250929133643.38961-1-skolothumtho@nvidia.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|SJ2PR12MB8881:EE_
X-MS-Office365-Filtering-Correlation-Id: 82712470-82b0-46a8-0481-08ddff5db39c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?u2/nxeDmRZpPusGsQqzUDpK4vNvNAo1GSyAEyv07EJVeeU7KhGvzgT2hTjWg?=
 =?us-ascii?Q?5F7VEhMH0pwbhNILRvj+AcxkYl2TdivHNDbrPev667bzo08L9HH90JcyVBf6?=
 =?us-ascii?Q?5VkNkpUQqSRP9JvW4fZ2B0cbqkXEQ1SSin71ZqVSUVLCVWt1MODGM4iACE3O?=
 =?us-ascii?Q?hjLhnKJUMdhlzyMAIt5VGeEpqVP/aU/vnik0mQasT94WYyhNumV0vfPehHwq?=
 =?us-ascii?Q?C/xjoiS3kUPY9khqWHRPKuHyiYqnQlPA7MYjflrhiSTcf89JnOUrB3RqNNsR?=
 =?us-ascii?Q?znP+w5N2Eq+4mgIBU6CZmVCTJ6XakzBjNrwjxF8RyHgIpjDQFFWz1KcBey8v?=
 =?us-ascii?Q?O6J8uICQTNzKF9HUFYtIYEYy+vtnxYJUastmot0ZchAH5xARB1Cz7jE0BoYw?=
 =?us-ascii?Q?yE25tx5bS6haMWCL+324bXRAwKNuS6C5JYM9GDORyvfoQsWsG2b/fGI9zGy7?=
 =?us-ascii?Q?CieOiVJ44q1VgjV0rSuXsVo+CSNwldVRU+qVvoukdqYQgNtVMekEs38bwuOw?=
 =?us-ascii?Q?eT18h1KrUTKqWkvgIILwIWGAgWuRs5+GkPo5FQiS14iLZicdlJD0bHEvdbbe?=
 =?us-ascii?Q?8ckWmC4LF/WZfPFE8l9HVzCZytnPTDBv38n9fXkEt0cYg5HOT1pt2albNTzp?=
 =?us-ascii?Q?8RENp9oLnC9PznKbo2U3D8EQdCE0fweqStWw6XfQ8H8WCb4127g/+LiLHep2?=
 =?us-ascii?Q?e/WgjqmqjsPMl+twcEYlouyt4lp6/1sI6r5Mmn8PTVfnlqW2ws7PToFEK95l?=
 =?us-ascii?Q?gDRfGHBD5ar2JNtg5oFZw4celpvl8R5GD0pab2JEnrIEWPFsXz9NVmLKwAP3?=
 =?us-ascii?Q?VKRzPSY1Jy4JpHtN8fkWd9AHrrKW11+H5RLwtAG4CeLmvVw5sf3IfgkfJb1T?=
 =?us-ascii?Q?hMMESJVCnLWeXggBOTRA9qOuioxwbAb3xct2qUbDlvqwlzedMhM9o1iUaaem?=
 =?us-ascii?Q?DvJ41CNMoK653KWzbyXC3mGgiNd3gINsdoAWwR+PFYXrqAm2wPLxD+jHCLaC?=
 =?us-ascii?Q?vYmguuJsGKXNyJlxw8Bzjl9NGUgYhp+QXnV7a+Wo8x8qtuRcQrkP4qOOTVLW?=
 =?us-ascii?Q?Y53uyY6nCq+Fk5zUDl8zKxmgNUIgYGNmcYxKBcqdQuoCvrHehCqHeA8tJnUr?=
 =?us-ascii?Q?GBg5Fyd+BgexS4VYzPkyumKlHWRtbw+cSdX8XnnurX5Y7O2QmbzsyTMZDqaK?=
 =?us-ascii?Q?4VDKcmyRYhgnt0FGUDnRyLqkSDxfJRskSAfCOQ5bO8Vsj+eZECvqRlXgBeZ6?=
 =?us-ascii?Q?S8OuQqSATWkQN4TsHgkOoCTND0DP3d56kK5Cta3brJv6dXLGwsZ5aG3JItIC?=
 =?us-ascii?Q?poNct5htcvd9qlJwrweUM8b8Rr7DMFANo7r6nFvhZzJ3PrZKhvjyqpLeEga4?=
 =?us-ascii?Q?+zbgXjt6PdFrZXKOThgE59gLIdy3iHbfx2KHW146WgBGymt5QC7BiIQWJVt2?=
 =?us-ascii?Q?JyYMHU8qRJ9DOsDjSl2o2fuM5N1zAjDIDW8J9IkU05MTG7jf633NvCCO13oD?=
 =?us-ascii?Q?D4DRQauSJmhC2ilG1joinUXzgB/VGZ6/wjDDLx4XRs1J753eEUFJ11cCuMRT?=
 =?us-ascii?Q?0KiqRqUlb/z1ySQX3LI=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 13:40:06.5704 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82712470-82b0-46a8-0481-08ddff5db39c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8881
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FORGED_SPF_HELO=1, KHOP_HELO_FCRDNS=0.4, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Here we return the IOMMU address space if the device has S1 translation
enabled by Guest. Otherwise return system address space.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 790887ac31..f4e01fba6d 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -387,6 +387,26 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
     }
 }
 
+static AddressSpace *smmuv3_accel_find_msi_as(PCIBus *bus, void *opaque,
+                                              int devfn)
+{
+    SMMUState *bs = opaque;
+    SMMUPciBus *sbus = smmu_get_sbus(bs, bus);
+    SMMUv3AccelDevice *accel_dev = smmuv3_accel_get_dev(bs, sbus, bus, devfn);
+    SMMUDevice *sdev = &accel_dev->sdev;
+
+    /*
+     * If the assigned vfio-pci dev has S1 translation enabled by
+     * Guest, return IOMMU address space for MSI translation.
+     * Otherwise, return system address space.
+     */
+    if (accel_dev->s1_hwpt) {
+        return &sdev->as;
+    } else {
+        return &address_space_memory;
+    }
+}
+
 static bool smmuv3_accel_pdev_allowed(PCIDevice *pdev, bool *vfio_pci)
 {
 
@@ -475,6 +495,7 @@ static const PCIIOMMUOps smmuv3_accel_ops = {
     .get_viommu_flags = smmuv3_accel_get_viommu_flags,
     .set_iommu_device = smmuv3_accel_set_iommu_device,
     .unset_iommu_device = smmuv3_accel_unset_iommu_device,
+    .get_msi_address_space = smmuv3_accel_find_msi_as,
 };
 
 void smmuv3_accel_init(SMMUv3State *s)
-- 
2.43.0


