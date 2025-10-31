Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7AB5CCF9FA
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 10:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEmmY-0006FN-CA; Fri, 31 Oct 2025 06:55:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmlz-0004fX-5y; Fri, 31 Oct 2025 06:54:27 -0400
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmlo-0002zE-UA; Fri, 31 Oct 2025 06:54:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sy5lmgiAWL7vnCRNPEF0kQwAxmzgc6Jx9um8itpQZzzpN6KGdZjleiNHCYI53EZWHPvTEKnVViu+obxgpt3Xjm7xekeiZGRoa1P52USFL+UzTO2zE4CobRrhU21kdQbYug2ld0cmF508on16MBCblDmE6yfvDbprk/EYr98FmqfZTqg34ZBBHNGofk+HEQGG+Z0cT3SoED0Xrp+K93KSdhC4PZP5Pkoi5QbQ9QP2TxC0MrlSRF6QSMkx6EXIQooaFL99xyBlJWyfoXpHPyfDGnwGI8S7OVNWTPRJE9FVuPCpClKLASRIIGEIYzkFD5yUrfLMwmAIaUgZV1HRc0+wdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/3tGnoLyqadzqVGyYrz0w+2fTck8+yeEPboDIBoOgw=;
 b=zK+gZ+xQwqxklcIO0QllLe18aws8F+ToTteLHnYc7a6bn09SKM1N6yOdq/pSjM/7wMg5ELAtzh4TaRkBW+HNLDG8RQxRB117kq6TTW6w2AvStdBdI9tnB8FCvhWlkiydK1ecn3PhlNZ4sXhC62D7BDcqsbzMDiZ+52CkqjEyVfrFjAbLMFyC5Dr0Zow+MIQ3fKaUFxnUXfYCVDpZlS+we5KKAHKVAKi5f73wTRVA/443fjAmWkXelNSEY+ac/tz4WLm2Rhugu9bupmiEVDlJSHq50d6E+Kg9X/V4qLcVm4W7rLhV1HtSVOnB6RLafDvPwPGCpELkretZH+F/TeBY6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/3tGnoLyqadzqVGyYrz0w+2fTck8+yeEPboDIBoOgw=;
 b=Cd83CjRhi8958Fb6E3tTy6gZ6AQHKgSjoUJf8l+/f/biACzA5uzkHkoOdBeCZGcgInf8d3lvAlHixpi6908Da9V5LBcigY7rUQjncVQzX031bRat38A+YYkuNB9FqWmtRpvfHCd6tC19G5fsebSHbRNnDFilBmibzXUwh5qPpv7Hnu0czmutlOH477Mavx8fiDUk8i2mU0yCAJmNCAXWTerAfAnsYwIt+n3oTsHgfO+3sqtK5YteA2KJW5Pp00Qad8AHBarf2n3CiFG8V7XnQG5oTNE8CvrW9xCtNkAFu3komFEtHTBSoRsu7jJb2soSJkj0vP9b1tB9fsJh00fBpg==
Received: from MW3PR05CA0020.namprd05.prod.outlook.com (2603:10b6:303:2b::25)
 by CH3PR12MB7641.namprd12.prod.outlook.com (2603:10b6:610:150::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 10:54:00 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:303:2b:cafe::68) by MW3PR05CA0020.outlook.office365.com
 (2603:10b6:303:2b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.5 via Frontend Transport; Fri,
 31 Oct 2025 10:53:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 10:53:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 31 Oct
 2025 03:53:49 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 03:53:45 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v5 16/32] hw/arm/smmuv3-accel: Make use of
 get_msi_address_space() callback
Date: Fri, 31 Oct 2025 10:49:49 +0000
Message-ID: <20251031105005.24618-17-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031105005.24618-1-skolothumtho@nvidia.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|CH3PR12MB7641:EE_
X-MS-Office365-Filtering-Correlation-Id: 9faf4361-ef81-4c1e-d24c-08de186bcc10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qZdHh8ohl81jHN6p2lLSTNZoXTuNqUU3zRML++eV2zAHPw/1k1Ml6LwbuRNj?=
 =?us-ascii?Q?/mvZex/uvsf9P+2M0y7iP05wP64mmZCEKk/dAdyNIg++wtfBYFcbthl8no3h?=
 =?us-ascii?Q?uIGKHqpM/3jGcnOlRe9SnIOB1A9rJjbzWTK224bNKFIuaiYa6bPHxYrZxEZa?=
 =?us-ascii?Q?p44YeV9g6Y+lvLNBVgb8rnT5o/za45PrYU4oDFaTFQ3DErouna0f/Yb0EpKD?=
 =?us-ascii?Q?t/MJPOY7asU6kuGhxip/HzGndleV/sT8xBYOhBshgcY/k11nhi+2ZJ6AdYtk?=
 =?us-ascii?Q?QM5LsOpNnnTs5lwBEA2f9xzXHak3kd2ohqRnN+bWl8lJoVdoVq7SXMJz0WCZ?=
 =?us-ascii?Q?ubAjxdR9mWQNL6G9o3rxT4sWii/cUolllrC+PrP8U5TwwufgcO4sx2Hxh5bi?=
 =?us-ascii?Q?VXo5iEfEibZCaYWGe80lRfR0LQqSF0pLWIbOnLH+ahTqXNtls+9f1kmdMQCp?=
 =?us-ascii?Q?KT8jF6RqxZVnc2k4BrHZMFFALlLkN5nQTFZGjwzUqYI+szEhGa+EMGIlA3Zy?=
 =?us-ascii?Q?KOkFt99JYxmayfe2NTd0leXRRtvZzsO/pfqDJVUm2rUyhAUjRxIKDwNpX1zT?=
 =?us-ascii?Q?EzsNYSw7wsxbQeV5t0MDQvlOHa1KMX6UUerZYuzakXBBXzvJGbAzExb6gFIr?=
 =?us-ascii?Q?gVSbc2FAlWUrr7dgcuNNjcmzRZP7TWDbauXBIlPmfZyG+3gJuUNjdt2FgtmR?=
 =?us-ascii?Q?bJK9Jdx4iEl534WyU/sgZtVVqz3i22x1wrESbU2oHP6T4Dv838nhtc3v6M00?=
 =?us-ascii?Q?3fFqZyNj0J5RnFQ2G/iauvx+oAb3qE1Jrbrrc6+NPcr76MkTwSaoJLL8mqqE?=
 =?us-ascii?Q?AmPlmgqMp5ORYFXfrtb0MAheCdYf8GkvfAmEK/t2D5DVcvIQXSZ/+JYgYLwc?=
 =?us-ascii?Q?m3YEAm1eWZ1jTU7cP2L5jZaqxbbzz8494V92angG+cnqMa/JwsJlCXrxFfWA?=
 =?us-ascii?Q?nDHXVzznCI44nUTZDvZf7iOBFS5ldqGdPI0iun2KmLCUb27C6Dbo+5QtKreV?=
 =?us-ascii?Q?yiq5BXO3toyIfR+PYt+aApclgKigKKmkQu91Fv3+m+DyWQWdLhDqj10iLY1K?=
 =?us-ascii?Q?4ijHww9o+BaDctIB9ZW77LXZnFqWYgPIzF8jvSdCoXR/ZnLsM/+ZdbyujrEu?=
 =?us-ascii?Q?2BfWrhD9ciUn/jMaeCS3XdPUq/sWYzlcY/+kSiMF+Ox8qDuq/uMoMf1MQlWK?=
 =?us-ascii?Q?tvb3Mv5zWT7CqwUDeeptTv44mdICNyqRmRzffE3I+eFBo47n7n3Dhjgt0PKD?=
 =?us-ascii?Q?aMR9IxouWEA9LzX9O5jenS/OMA+2GzmqFM4FXw2KudolcnHkMQD0aqJ8PTfl?=
 =?us-ascii?Q?3PwmrJBTj1C4oooZNuEiNyErTHZD6ZUCsNCJfOL3kBpYx+rdqbdySflhcBqR?=
 =?us-ascii?Q?DAfm0kytYHA4JpmkMOJ7lNqHpmjL8oWBmSm+HmFG06sgBBEo2NSgS23IJb2r?=
 =?us-ascii?Q?amdG2JJG75LHN9MSA9X5yDl0n+/tbmQPrjNcL/S8QPKOs4vt2C8WEfBSJySS?=
 =?us-ascii?Q?aCtBRdYvUtsKiW3ROCVU2ipEqAX05WyVY57y1L7DVVRNEkRfYWiY/1Ek8quy?=
 =?us-ascii?Q?YkeSFNH7dTZKrY0cR2Q=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 10:53:59.6035 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9faf4361-ef81-4c1e-d24c-08de186bcc10
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7641
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, KHOP_HELO_FCRDNS=0.399, SPF_HELO_NONE=0.001,
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

Implement support for get_msi_address_space() callback and return the
IOMMU address space if the device has S1 translation enabled by Guest.
Otherwise return system address space.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 0573ae3772..395c8175da 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -384,6 +384,26 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
     }
 }
 
+static AddressSpace *smmuv3_accel_get_msi_as(PCIBus *bus, void *opaque,
+                                             int devfn)
+{
+    SMMUState *bs = opaque;
+    SMMUPciBus *sbus = smmu_get_sbus(bs, bus);
+    SMMUv3AccelDevice *accel_dev = smmuv3_accel_get_dev(bs, sbus, bus, devfn);
+    SMMUDevice *sdev = &accel_dev->sdev;
+
+    /*
+     * If the assigned vfio-pci dev has S1 translation enabled by Guest,
+     * return IOMMU address space for MSI translation. Otherwise, return
+     * system address space.
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
 
@@ -477,6 +497,7 @@ static const PCIIOMMUOps smmuv3_accel_ops = {
     .get_viommu_flags = smmuv3_accel_get_viommu_flags,
     .set_iommu_device = smmuv3_accel_set_iommu_device,
     .unset_iommu_device = smmuv3_accel_unset_iommu_device,
+    .get_msi_address_space = smmuv3_accel_get_msi_as,
 };
 
 
-- 
2.43.0


