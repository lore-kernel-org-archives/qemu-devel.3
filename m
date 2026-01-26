Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C31CF65D5
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 10:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkK75-0008CU-AD; Mon, 26 Jan 2026 05:46:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK6b-0007Oz-As; Mon, 26 Jan 2026 05:46:05 -0500
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK6Z-0005aO-1S; Mon, 26 Jan 2026 05:46:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZcUwes2R7Lj2i5qsNTZVmlsogpNNShUOtDXg3+L7Sz10PhC/Hnh+5538Icpky5t5lTSJCLMj2Piz//miqfzP5uJjwVwNpJ8Nusy/N3ebbrNi1NlIRu3Wm/Q6edTHY56SDKsEIPmSmRJRErIGKxdBDWVw6nVDTvxzK4Hj+DxhCp91w75AgYKnkwh6izYjINdkR9Q4AiMB3uMMn+vWuEMYOLWMXSp/8Nq6JMNzcyngalwQF7Q61DlwTF92lI8GMZrkw5NvPj8IZ2Nu6zNAcEPorNX8HPkOHcCrlmHL68U51ughU1yYMeQEd/T8raWrD9jHR9X/0RT+9jFluYJABzORaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhsEHnKE4qYLS5Uz/f9Ukllw3Gi8G60LhBInlsybxbs=;
 b=AnVoaKPHkkJvDN+aaD/GHXlpD5OyxHJMmImH/Lb+aqrrSHn2Zq6XQnMCxmLfbqMQpA6bwUIX398SuyRnnHkO1e0xxXjj3FgSYvp7R8IZMv2RdgtaZI9hwwMsVNLg0eUKDw6z1/1bFidMp5TSl3izbZPoQcxZKAxXTaWgG5gvtMcZn7vxBHEB47KnkYKpg90zxG+42iP/qaPBYDrF/sWULBa0BMUhU7AWixxygC0ox6srISsLuyQPtzRr1nlrOjoUzEGwYaRZFP35l8h2QGI/kq7Ynn8MxM5/xRAxKCNSsCGa3o1ziCrirIyuGrQ1my3nxu+CGnWYgxtzXWpCCG+Mcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhsEHnKE4qYLS5Uz/f9Ukllw3Gi8G60LhBInlsybxbs=;
 b=pcLP8+IDwGpwh4hlFqlRIOLkKko8+YnME54Vbvc66vm/WkI0M9u7gRZ5UFZ7WaRU77wDV5c2pty40nQyD8QVq6DMJw8BdeeIhHn+w4gd/Euv2AS2oVY7KveCZJ+pTshm1u0nDbQuwsofr9OSI8WnsXBySmj+hS+1EMH7FQ5yaJa0owcp4ba9cU+aAgkm4gFLzQVhCriN4o2OW7Cp9eGrxQGH/URnFM1IuoYg5+Ysypq8kRDunNcOp2A6ZGKgpYktav1JpiGBxbEVazXPHI9kn8XVC31mygUtk8WrbVJjclPmETvB3iuCbQE0/kfNd0UbeWQq9dEyu7DK/+PuAO4hWg==
Received: from MN2PR05CA0049.namprd05.prod.outlook.com (2603:10b6:208:236::18)
 by PH7PR12MB5733.namprd12.prod.outlook.com (2603:10b6:510:1e0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 10:45:51 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::4c) by MN2PR05CA0049.outlook.office365.com
 (2603:10b6:208:236::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Mon,
 26 Jan 2026 10:45:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 10:45:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:45:37 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:45:33 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v9 14/37] hw/arm/smmuv3-accel: Add nested vSTE
 install/uninstall support
Date: Mon, 26 Jan 2026 10:43:11 +0000
Message-ID: <20260126104342.253965-15-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126104342.253965-1-skolothumtho@nvidia.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|PH7PR12MB5733:EE_
X-MS-Office365-Filtering-Correlation-Id: 4949bbe0-2af2-4153-f344-08de5cc812f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|7416014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NitkV3pWUXQyQ2xwajR5V0pyZElaMjVKRVNPd3pqMGZ4Z2tlL2ZDWFlNVmV6?=
 =?utf-8?B?VzF1TXFGUzAwck1ja0ZLSnlQbE42NXRGWElZWlBBNEhINkdHaWdxRWc5Yjlw?=
 =?utf-8?B?RWk0elVLSmJtSDU4c3JBWWpHdTlJdjE5Uk5rcGZ3VnMwQWFpUVBlS2JBc0p1?=
 =?utf-8?B?UThuNXlBZnRRMUFDTFduRWhUVkdxaTRwdW94REhpVjRPSnA1Mkl5TzNCM3k2?=
 =?utf-8?B?U2I5OXpncjk5WG5SVkE0VU52VmxQOFppSkVmQmNkaHMxMGZWREx6Wlp2dVNJ?=
 =?utf-8?B?MzMxdFpGYWRCQnFER0F1bGVROW9UVndQNTBIYTlmSGd1VlcwWU5vaDFna2sz?=
 =?utf-8?B?UVZQeVZLSVMrZVVGZ3B4NkdTRWZrL25iOHBGUHdKWGFxdStUZEdzWXhKUFdJ?=
 =?utf-8?B?Uys0V0J2Zm5DVTVCaTB2N2hsdXpxSFREWWlNUm5sRUpVcEFic3ZsRmFpWWsr?=
 =?utf-8?B?WlZNT0JFanIzc2wrY2JlMnRqTjVtQ0RqakNRblRGR0luTTRoSUxmZTMwTy9v?=
 =?utf-8?B?bzFXeE9ZNjVUcHdsN2l6eXdSTzNBa25zb1NaZG54b0Uram4ybmZXWDIzNU5q?=
 =?utf-8?B?anB0UTNmb0VMVjVWZjVWNGcyL1M0VTRLekVXSmtYanJkSEVQb1ZXZnJ1OEI4?=
 =?utf-8?B?R3Zjd1MzT3NYaFJ2SHBFbmdRTVEyckwxUDlxbjgza3V5dCtBY0ltNXJJeWJU?=
 =?utf-8?B?VWM1VllvMExDcFhuU2xFY2licmtKNVVDMzhxSFhmdmUwcmcwRkc1NTFnNkh1?=
 =?utf-8?B?MHBnMml0bDJWTlRsblpTL0luL1FnSzRVSDJ3THErTGhoU0FnYXBLWFBLRzZR?=
 =?utf-8?B?cEYvZW4weXIveVJYakY2WVNmaHFHc0ZqVnpkbjE3WkwvMUs3cjB1SGZDTlp2?=
 =?utf-8?B?VGJRRlBJeDNhK2NjWEJNMGVEWkFiSTZNT3dSK0dtYjhzTytqMWFtTUxXWTF6?=
 =?utf-8?B?ZEdNWGp0akdVWUEwMkZQVVZKQkttWGMxSDJ3ajBVVXJRWU8vS2NlVDJLWGRZ?=
 =?utf-8?B?Wkp1ekEwSmttY1ZjeWFudWhXT0hVeVROZnBucTcwejJHRmJ3YTFybURBUUZ1?=
 =?utf-8?B?QStPMnh5U1hCeE1hN2V5R3BuNnFNRGl4cmU1M1VFUmVqaUlndXM4NVowTWRm?=
 =?utf-8?B?V1E0M3dNdHZab3kwWHA2VmJrMGRoMTlmSDM2VVBTUGMwWDZLYkdMYUNzbkM5?=
 =?utf-8?B?SzRESmVOQjZ3MUhRY3doRVZQdnU2Rm85YXlmNDRwQU9JL2FFd29nZVJwbkgv?=
 =?utf-8?B?QlFSak1PMWJWaVhwR3YzTDNBd2ZvSUFDdVRlb0lwZVVJV0l0aTcxTG9HRlFl?=
 =?utf-8?B?bTAyQWZEMVp2SG1aekQzTGsvcjdheU9KZm9uV2hwaWpFVStpTm5UWWdwVTdG?=
 =?utf-8?B?UWgxeVd5RWVvZ2o0MUJpSUdSQWpSZTZBSi9VeVRYL3FidEVrYnErTWhVQUhO?=
 =?utf-8?B?UndLcUZCYmxGSC9PRkR2b3ZEcEU3OTRWKzZHeHF5RFhzTjRmdWRzbUxmZ01H?=
 =?utf-8?B?TUlYdjEzWmpGakQwa0RpQVoyTG53Vk5PbFZCZGdRemZDQ05Kb0hsT1hBdGR2?=
 =?utf-8?B?NTRTUkYzMks1OHZDWEZQTHlENXc0T2ZZYm1MQnhqQ3gzMjhxS2hnckl3UzdT?=
 =?utf-8?B?ZHZleS9rZmZYNklnbitQVjJpZlRlc3BBZHIwa0pjRzM2bjBURzJuU2tXeHRr?=
 =?utf-8?B?aVozSHlta3pjYVN1bVkxdXRlSFpvT1NwS1dIVG9ZYkNaNm5LNHlmcDhZbEFX?=
 =?utf-8?B?bXlIVXh6TFFrWnVLSEFYMU1uTXkxV3JzaVY4UFRLNTJobm1aenRZSngwTGRi?=
 =?utf-8?B?V0FLWDM3QXFpZ2Z2cjRTa01YaDcyb1Z3N3RuUlZua0h6dHE4SW9vNVdqV1N1?=
 =?utf-8?B?cXh1OS83YVduc0RCTnhoU0pmNll6STAzZnoyTEJEUHpCamdFWWR3akUydnhU?=
 =?utf-8?B?WHYweFc5NVExb2Y4WE1EbHd0M1FSR0VMYmxyZmVIRHI3a3N2MmpXQkh1TWVs?=
 =?utf-8?B?QXBHUDRzRkRJd1c1SkJBNzdTOW1hTGpTeklTYU1CRG9acXNLQmJLSEZCcTRr?=
 =?utf-8?B?eFFRNUNuSWZwNEtHWVlLWUpGdWVqL1BVcS91ZUhndXNZb1lpYVAzaUxwbUJ2?=
 =?utf-8?B?cVpXejJMWlA1THVaVDJxaTRNamhFeHFYM0NyMFlUVXV2VFRXQmh5bVdrcTJJ?=
 =?utf-8?B?TG1IYVhOL09mYUF5OEZXQzFLS3Rpd2pTYUx3ckc3T08vam13aHRiZkd1cEhw?=
 =?utf-8?B?eFhGVWlvVGMrZXVvUlpnaU1DRGlnPT0=?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:45:51.2702 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4949bbe0-2af2-4153-f344-08de5cc812f7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5733
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Nicolin Chen <nicolinc@nvidia.com>

A device placed behind a vSMMU instance must have corresponding vSTEs
(bypass, abort, or translate) installed. The bypass and abort proxy nested
HWPTs are pre-allocated.

For translat HWPT, a vDEVICE object is allocated and associated with the
vIOMMU for each guest device. This allows the host kernel to establish a
virtual SID to physical SID mapping, which is required for handling
invalidations and event reporting.

An translate HWPT is allocated based on the guest STE configuration and
attached to the device when the guest issues SMMU_CMD_CFGI_STE or
SMMU_CMD_CFGI_STE_RANGE, provided the STE enables S1 translation.

If the guest STE is invalid or S1 translation is disabled, the device is
attached to one of the pre-allocated ABORT or BYPASS HWPTs instead.

While at it, export smmu_find_ste() for use here.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c          | 197 +++++++++++++++++++++++++++++++++
 hw/arm/smmuv3-accel.h          |  22 ++++
 hw/arm/smmuv3-internal.h       |   1 +
 hw/arm/smmuv3.c                |  11 +-
 hw/arm/trace-events            |   2 +
 include/hw/arm/smmuv3-common.h |  18 +++
 6 files changed, 249 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 9c2b917a11..877b7e0e17 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -51,6 +51,188 @@ static uint32_t smmuv3_accel_gbpa_hwpt(SMMUv3State *s, SMMUv3AccelState *accel)
            accel->abort_hwpt_id : accel->bypass_hwpt_id;
 }
 
+static bool
+smmuv3_accel_alloc_vdev(SMMUv3AccelDevice *accel_dev, int sid, Error **errp)
+{
+    SMMUv3AccelState *accel = accel_dev->s_accel;
+    HostIOMMUDeviceIOMMUFD *idev = accel_dev->idev;
+    IOMMUFDVdev *vdev = accel_dev->vdev;
+    uint32_t vdevice_id;
+
+    if (!idev || vdev) {
+        return true;
+    }
+
+    if (!iommufd_backend_alloc_vdev(idev->iommufd, idev->devid,
+                                    accel->viommu->viommu_id, sid,
+                                    &vdevice_id, errp)) {
+            return false;
+    }
+
+    vdev = g_new(IOMMUFDVdev, 1);
+    vdev->vdevice_id = vdevice_id;
+    vdev->virt_id = sid;
+    accel_dev->vdev = vdev;
+    return true;
+}
+
+static SMMUS1Hwpt *
+smmuv3_accel_dev_alloc_translate(SMMUv3AccelDevice *accel_dev, STE *ste,
+                                 Error **errp)
+{
+    uint64_t ste_0 = (uint64_t)ste->word[0] | (uint64_t)ste->word[1] << 32;
+    uint64_t ste_1 = (uint64_t)ste->word[2] | (uint64_t)ste->word[3] << 32;
+    HostIOMMUDeviceIOMMUFD *idev = accel_dev->idev;
+    SMMUv3AccelState *accel = accel_dev->s_accel;
+    struct iommu_hwpt_arm_smmuv3 nested_data = {
+        .ste = {
+            cpu_to_le64(ste_0 & STE0_MASK),
+            cpu_to_le64(ste_1 & STE1_MASK),
+        },
+    };
+    uint32_t hwpt_id = 0, flags = 0;
+    SMMUS1Hwpt *s1_hwpt;
+
+    if (!iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid,
+                                    accel->viommu->viommu_id, flags,
+                                    IOMMU_HWPT_DATA_ARM_SMMUV3,
+                                    sizeof(nested_data), &nested_data,
+                                    &hwpt_id, errp)) {
+            return NULL;
+    }
+
+    s1_hwpt = g_new0(SMMUS1Hwpt, 1);
+    s1_hwpt->hwpt_id = hwpt_id;
+    trace_smmuv3_accel_translate_ste(accel_dev->vdev->virt_id, hwpt_id,
+                                     nested_data.ste[1], nested_data.ste[0]);
+    return s1_hwpt;
+}
+
+bool smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
+                              Error **errp)
+{
+    SMMUEventInfo event = {.type = SMMU_EVT_NONE, .sid = sid,
+                           .inval_ste_allowed = true};
+    SMMUv3AccelState *accel = s->s_accel;
+    SMMUv3AccelDevice *accel_dev;
+    HostIOMMUDeviceIOMMUFD *idev;
+    uint32_t config, hwpt_id = 0;
+    SMMUS1Hwpt *s1_hwpt = NULL;
+    const char *type;
+    STE ste;
+
+    if (!accel || !accel->viommu) {
+        return true;
+    }
+
+    accel_dev = container_of(sdev, SMMUv3AccelDevice, sdev);
+    if (!accel_dev->s_accel) {
+        return true;
+    }
+
+    idev = accel_dev->idev;
+    if (!smmuv3_accel_alloc_vdev(accel_dev, sid, errp)) {
+        return false;
+    }
+
+    if (smmu_find_ste(sdev->smmu, sid, &ste, &event)) {
+        /* No STE found, nothing to install */
+        return true;
+    }
+
+    /*
+     * Install the STE based on SMMU enabled/config:
+     * - attach a pre-allocated HWPT for abort/bypass
+     * - or a new HWPT for translate STE
+     *
+     * Note: The vdev remains associated with accel_dev even if HWPT
+     * attach/alloc fails, since the Guest–Host SID mapping stays
+     * valid as long as the device is behind the accelerated SMMUv3.
+     */
+    if (!smmu_enabled(s)) {
+        hwpt_id = smmuv3_accel_gbpa_hwpt(s, accel);
+    } else {
+        config = STE_CONFIG(&ste);
+
+        if (!STE_VALID(&ste) || STE_CFG_ABORT(config)) {
+            hwpt_id = accel->abort_hwpt_id;
+        } else if (STE_CFG_BYPASS(config)) {
+            hwpt_id = accel->bypass_hwpt_id;
+        } else if (STE_CFG_S1_TRANSLATE(config)) {
+            s1_hwpt = smmuv3_accel_dev_alloc_translate(accel_dev, &ste, errp);
+            if (!s1_hwpt) {
+                return false;
+            }
+            hwpt_id = s1_hwpt->hwpt_id;
+       }
+    }
+
+    if (!hwpt_id) {
+        error_setg(errp, "Invalid STE config for sid 0x%x",
+                   smmu_get_sid(&accel_dev->sdev));
+        return false;
+    }
+
+    if (!host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp)) {
+        if (s1_hwpt) {
+            iommufd_backend_free_id(idev->iommufd, s1_hwpt->hwpt_id);
+            g_free(s1_hwpt);
+        }
+        return false;
+    }
+
+    /* Free the previous s1_hwpt */
+    if (accel_dev->s1_hwpt) {
+        iommufd_backend_free_id(idev->iommufd, accel_dev->s1_hwpt->hwpt_id);
+        g_free(accel_dev->s1_hwpt);
+    }
+
+    accel_dev->s1_hwpt = s1_hwpt;
+    if (hwpt_id == accel->abort_hwpt_id) {
+        type = "abort";
+    } else if (hwpt_id == accel->bypass_hwpt_id) {
+        type = "bypass";
+    } else {
+        type = "translate";
+    }
+
+    trace_smmuv3_accel_install_ste(sid, type, hwpt_id);
+    return true;
+}
+
+bool smmuv3_accel_install_ste_range(SMMUv3State *s, SMMUSIDRange *range,
+                                    Error **errp)
+{
+    SMMUv3AccelState *accel = s->s_accel;
+    SMMUv3AccelDevice *accel_dev;
+    Error *local_err = NULL;
+    bool all_ok = true;
+
+    if (!accel || !accel->viommu) {
+        return true;
+    }
+
+    QLIST_FOREACH(accel_dev, &accel->device_list, next) {
+        uint32_t sid = smmu_get_sid(&accel_dev->sdev);
+
+        if (sid >= range->start && sid <= range->end) {
+            if (!smmuv3_accel_install_ste(s, &accel_dev->sdev,
+                                          sid, &local_err)) {
+                error_append_hint(&local_err, "Device 0x%x: Failed to install "
+                                  "STE\n", sid);
+                error_report_err(local_err);
+                local_err = NULL;
+                all_ok = false;
+            }
+        }
+    }
+
+    if (!all_ok) {
+        error_setg(errp, "Failed to install all STEs properly");
+    }
+    return all_ok;
+}
+
 static bool
 smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
                           Error **errp)
@@ -161,6 +343,7 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
     HostIOMMUDeviceIOMMUFD *idev;
     SMMUv3AccelDevice *accel_dev;
     SMMUv3AccelState *accel;
+    IOMMUFDVdev *vdev;
     SMMUDevice *sdev;
 
     if (!sbus) {
@@ -181,6 +364,20 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
                      "0x%x", idev->devid);
     }
 
+    if (accel_dev->s1_hwpt) {
+        iommufd_backend_free_id(accel_dev->idev->iommufd,
+                                accel_dev->s1_hwpt->hwpt_id);
+        g_free(accel_dev->s1_hwpt);
+        accel_dev->s1_hwpt = NULL;
+    }
+
+    vdev = accel_dev->vdev;
+    if (vdev) {
+        iommufd_backend_free_id(accel->viommu->iommufd, vdev->vdevice_id);
+        g_free(vdev);
+        accel_dev->vdev = NULL;
+    }
+
     accel_dev->idev = NULL;
     accel_dev->s_accel = NULL;
     QLIST_REMOVE(accel_dev, next);
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index efb631db4f..4e20b646dc 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -27,19 +27,41 @@ typedef struct SMMUv3AccelState {
     QLIST_HEAD(, SMMUv3AccelDevice) device_list;
 } SMMUv3AccelState;
 
+typedef struct SMMUS1Hwpt {
+    uint32_t hwpt_id;
+} SMMUS1Hwpt;
+
 typedef struct SMMUv3AccelDevice {
     SMMUDevice sdev;
     HostIOMMUDeviceIOMMUFD *idev;
+    SMMUS1Hwpt *s1_hwpt;
+    IOMMUFDVdev *vdev;
     QLIST_ENTRY(SMMUv3AccelDevice) next;
     SMMUv3AccelState *s_accel;
 } SMMUv3AccelDevice;
 
 #ifdef CONFIG_ARM_SMMUV3_ACCEL
 void smmuv3_accel_init(SMMUv3State *s);
+bool smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
+                              Error **errp);
+bool smmuv3_accel_install_ste_range(SMMUv3State *s, SMMUSIDRange *range,
+                                    Error **errp);
 #else
 static inline void smmuv3_accel_init(SMMUv3State *s)
 {
 }
+static inline bool
+smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
+                         Error **errp)
+{
+    return true;
+}
+static inline bool
+smmuv3_accel_install_ste_range(SMMUv3State *s, SMMUSIDRange *range,
+                               Error **errp)
+{
+    return true;
+}
 #endif
 
 #endif /* HW_ARM_SMMUV3_ACCEL_H */
diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index 687ee6aaca..a6464425ec 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -353,6 +353,7 @@ typedef struct SMMUEventInfo {
     } while (0)
 
 void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *event);
+int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event);
 
 static inline int oas2bits(int oas_field)
 {
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index ade2b43ab8..7e29284267 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -630,8 +630,7 @@ bad_ste:
  * Supports linear and 2-level stream table
  * Return 0 on success, -EINVAL otherwise
  */
-static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
-                         SMMUEventInfo *event)
+int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event)
 {
     dma_addr_t addr, strtab_base;
     uint32_t log2size;
@@ -1341,6 +1340,10 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
             }
 
             trace_smmuv3_cmdq_cfgi_ste(sid);
+            if (!smmuv3_accel_install_ste(s, sdev, sid, errp)) {
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
             smmuv3_flush_config(sdev);
 
             break;
@@ -1361,6 +1364,10 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
             sid_range.end = sid_range.start + mask;
 
             trace_smmuv3_cmdq_cfgi_ste_range(sid_range.start, sid_range.end);
+            if (!smmuv3_accel_install_ste_range(s, &sid_range, errp)) {
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
             smmu_configs_inv_sid_range(bs, sid_range);
             break;
         }
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 2aaa0c40c7..8135c0c734 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -69,6 +69,8 @@ smmu_reset_exit(void) ""
 #smmuv3-accel.c
 smmuv3_accel_set_iommu_device(int devfn, uint32_t devid) "devfn=0x%x (idev devid=0x%x)"
 smmuv3_accel_unset_iommu_device(int devfn, uint32_t devid) "devfn=0x%x (idev devid=0x%x)"
+smmuv3_accel_translate_ste(uint32_t vsid, uint32_t hwpt_id, uint64_t ste_1, uint64_t ste_0) "vSID=0x%x hwpt_id=0x%x ste=%"PRIx64":%"PRIx64
+smmuv3_accel_install_ste(uint32_t vsid, const char * type, uint32_t hwpt_id) "vSID=0x%x ste type=%s hwpt_id=0x%x"
 
 # strongarm.c
 strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
diff --git a/include/hw/arm/smmuv3-common.h b/include/hw/arm/smmuv3-common.h
index 153310248d..415b7ccde5 100644
--- a/include/hw/arm/smmuv3-common.h
+++ b/include/hw/arm/smmuv3-common.h
@@ -99,10 +99,28 @@ REG32(STE_7, 28)
 #define STE_CFG_S2_ENABLED(config) (config & 0x2)
 #define STE_CFG_ABORT(config)      (!(config & 0x4))
 #define STE_CFG_BYPASS(config)     (config == 0x4)
+#define STE_CFG_S1_TRANSLATE(config)  (config == 0x5)
 
 #define SMMU_STE_VALID      (1ULL << 0)
 #define SMMU_STE_CFG_BYPASS (1ULL << 3)
 
+#define STE0_V       MAKE_64BIT_MASK(0, 1)
+#define STE0_CONFIG  MAKE_64BIT_MASK(1, 3)
+#define STE0_S1FMT   MAKE_64BIT_MASK(4, 2)
+#define STE0_CTXPTR  MAKE_64BIT_MASK(6, 50)
+#define STE0_S1CDMAX MAKE_64BIT_MASK(59, 5)
+#define STE0_MASK    (STE0_S1CDMAX | STE0_CTXPTR | STE0_S1FMT | STE0_CONFIG | \
+                      STE0_V)
+
+#define STE1_S1DSS    MAKE_64BIT_MASK(0, 2)
+#define STE1_S1CIR    MAKE_64BIT_MASK(2, 2)
+#define STE1_S1COR    MAKE_64BIT_MASK(4, 2)
+#define STE1_S1CSH    MAKE_64BIT_MASK(6, 2)
+#define STE1_S1STALLD MAKE_64BIT_MASK(27, 1)
+#define STE1_EATS     MAKE_64BIT_MASK(28, 2)
+#define STE1_MASK     (STE1_EATS | STE1_S1STALLD | STE1_S1CSH | STE1_S1COR | \
+                       STE1_S1CIR | STE1_S1DSS)
+
 /* Update STE fields */
 #define STE_SET_VALID(ste, v)                                                 \
     ((ste)->word[0] = FIELD_DP32((ste)->word[0], STE_0, VALID, (v)))
-- 
2.43.0


