Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF89CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 13:46:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3E7k-0002oh-Va; Mon, 29 Sep 2025 09:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E74-0002jU-Nd; Mon, 29 Sep 2025 09:40:24 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E6r-0003MA-AO; Mon, 29 Sep 2025 09:40:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SEXyYRPEMbEbOV5HQsSFd739NbMEc7MAoEzaiks9QxxHfANAU4rZN0X/03hQziLkZ+/lCjHOhSMI1YH9GNAnK0NsKT6FsTJfXnmucycxSjNguF0WXNqjCtHKE2aMl6Y3lShpgyzDyYUZnRsq3XdGfFyIvNzrdSxeS/D/iN7+/BgEdTeXO4f3qGANyuGd0qrkRCaOy359J8sKSHroTVVbb3g7X8tPuM9z/xwv9TzjuCwXKMCdk90X8qzJMvswFHYRhgScNcg3jClZiIZ54XDYF2IGK7lO8dZkbSFkyvKSaYeK4oJ0XwcL20lqML5U2ZMIalf+G0PR9A4Fk1t0j1+JSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKbq/PA9peimeNrX4nT30f7C4SA9pbtPEsi9zaYUFNw=;
 b=nJ6OkoUtbXpU3kqbE9AcyDxbyMgE1mEeVmIblI5HNzSHq5aOE5ubJEswv5DdIkzrlCEaInRwDo+wdT/ewDvHx1w44M7gckTPry0BWcaJESjQORiA26RspZYuuTSsgGAtZEx4T8Xyj1pdoBLcJSdm0UgqdKW/k4SlSczKNLCt+ySazXmW1QvkJ/U9WkFckwoLQGrO5RX0ebBxUgsV+9MXxRmEVlOPszJiIIm1M91z2pUuL/45uZreS/Wv3aubh5eZI4QwqL9pHb6wyssh6mSEyQf6sbwqoU5G7i+q+QE9FharzF/Y3QfrqjkQLl5HhZxGTK799GVM3gOJz9C4brVqLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKbq/PA9peimeNrX4nT30f7C4SA9pbtPEsi9zaYUFNw=;
 b=Daf6XWECiFbl8ulNcSCW6RNrpeg3q65kz4XsqIWLoKLhf6uodA8dPqVkabBnE1xNJaxATPGvGLaIWS0Or1cGe5F+muXUxZpngT04dSmEaxhP+0bNB8Js4x0I5dsT0FXZEHCoHH9tYBu8+UN4CyBYROqXValRvbY+GYn5fDB9Yz6Sh29kVipO+J3BbtStLsM7isWKYockWaWxV8lmp60n451Mg+SCcfovhCHqsOtWRBOz7BKLKQk7A7H4B2Z1W1/xPgJr74055nJG6X3july0FMpHh9yPgzWmtZ4SMzuoF0ZjCQh22WBOBjAZNAxD5byK6bGX64G7eIyNE2IaOXCpNA==
Received: from CH0PR03CA0101.namprd03.prod.outlook.com (2603:10b6:610:cd::16)
 by LV3PR12MB9354.namprd12.prod.outlook.com (2603:10b6:408:211::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 13:39:53 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:cd:cafe::74) by CH0PR03CA0101.outlook.office365.com
 (2603:10b6:610:cd::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Mon,
 29 Sep 2025 13:39:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Mon, 29 Sep 2025 13:39:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Mon, 29 Sep
 2025 06:39:39 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Sep
 2025 06:39:31 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <shameerkolothum@gmail.com>
Subject: [PATCH v4 08/27] hw/arm/smmuv3-accel: Add set/unset_iommu_device
 callback
Date: Mon, 29 Sep 2025 14:36:24 +0100
Message-ID: <20250929133643.38961-9-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250929133643.38961-1-skolothumtho@nvidia.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|LV3PR12MB9354:EE_
X-MS-Office365-Filtering-Correlation-Id: 509fbfd8-dcc8-4c6e-aff6-08ddff5dab75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R3lMVVk1Nm56dDRVSThtTXFBc1laaUlablZRMU9haGpWbjlNQTFVcEFNR2Yy?=
 =?utf-8?B?Z1Nld1JBOTRTc1BsYkZFSTdEWFhjOGkvOU9hS0NrT2xsZDZKNC9McThMb29X?=
 =?utf-8?B?b09mUnFNeDNzcjZNb0RPNHcrM3FrWjBqQ0NyUWFXSzBsc2s2WDQ5Vm9CZ3h3?=
 =?utf-8?B?WUZjK0dPajdmck1vdStsd1lLdHUyeG1pZDQrNmY2Rm54Mi9OSHQ4WktjdU1X?=
 =?utf-8?B?Rm04ME1DclBqOS9WZGFSaC9PZE5YcFR4R25MM1dmMEdleXlDU0xoYkNqNWFu?=
 =?utf-8?B?d1FWdG1aaHZhQTBSSWpQanRkdTEvbG55VUZ6SGl2RDdwQWlhQWFQU05lZmp5?=
 =?utf-8?B?a2hIS1lqUktJZEtaL2VWdGJRUzBjVk1tb2VtR0REK1lEZVh5cDE4bVN0bzhY?=
 =?utf-8?B?U2hURklSeHVOdDdUTTRDcHdsSHdDWDVjcUJKNjRtNmVrSWxoWUhMajgzaEQ1?=
 =?utf-8?B?QjRFRVF1TUlJdWxNT0FHUWZlUmViOFpDU3pLakMyOGE0L1lBQ1cvY3FpSlV6?=
 =?utf-8?B?dkVSdmNkUGt4KzZqYUszbnRmcm1NU3A0SkNBbDdhYmlYTVRiZ0N0YUg5eTdB?=
 =?utf-8?B?VnhPSVhrVXk3V0Q3RHNuQVBuaVl6b0xSQiswdTduaStzMkpWK0diYUs4Z2hS?=
 =?utf-8?B?QlJ5dUhCOTVDRlg4QldUeDNjN1ZFanZvdDRJbzFUc3QyY1ZTSndzUEZHa3da?=
 =?utf-8?B?aSs5c1IybmdzeFZTSjJJSytTWEhIb25EcHlad0hiKzRBTlR6YlNPa2VxMTVE?=
 =?utf-8?B?NXR1T2tiY0J5M3FuekVFb3d0S0pGUHlrcjc1TS9ZeExFYjczaGR2cS9OclVs?=
 =?utf-8?B?a3JtdjByUE5HMmd3VDdnQ05vMk9OaHJ1YjhkdUZ6dDRiaXJUelJRY0dWSEpn?=
 =?utf-8?B?U3ZkOVRKUG5CTU1lcU9tTHlFK21wSGYyZzhQNEozbzgvVC9idkRlZEdvSjcw?=
 =?utf-8?B?Q0dLbWtCU1VKeGw5ZHJuWHVPZTZvNmkxcUVMejNPcUw3a1dsZCs4RElzZXJN?=
 =?utf-8?B?NVRKMGVTdEZ0SGtmSEkybVlqenltR050U1hyclBrcmF5cG5DOUs2RkZPalgv?=
 =?utf-8?B?UWRraHdHTW10b0dibVlDVmhiRkZMbGVhOFA5NHlkcWxpVzczQXVEbjI3YytP?=
 =?utf-8?B?eXZ1T1dDWDIvRVFkd1Y1eWI1YU1tYm5ZWGI5SWZnUlZ5blhIY3QwbGt0cTFD?=
 =?utf-8?B?ZUtNUnBtQ2hoaStub2wybUpSMHkxYlczYkU1R3BPSU9PMlJCMnlUNFJ0QnZm?=
 =?utf-8?B?elR0a2NuRHJEMGNJdlFGODZrUHkyUWk1QW1mYkpvMzdybjNvL3dVeUZFR2hF?=
 =?utf-8?B?QW9RSFhpSkZKRzNCWERDeXJmZUlnMnhrNVlEUUtSUEttdlhkeXA3MWRWZUw5?=
 =?utf-8?B?MFBlTDNUODB6ZkcrSGxXcE9PTkd0TlhVUldMcXBlZlZ1NlJYSk9Uak5sT0tX?=
 =?utf-8?B?NW8rVDhUME42ZXV1SmptdWwwSERBaldqTGFQemkycGNNTDdpWUpmODhhaXpR?=
 =?utf-8?B?ZVNQcjZic0NFTUt5RVdvYmxhNWg0UlM4VDl3aW9BcTVTdEdHMHpsZUFUWE85?=
 =?utf-8?B?STUxN3M1SHR1V0NDZnBXTUQ4WjFMbktrOXZqeHlqcGp4a2VZM2NLQzByRGpX?=
 =?utf-8?B?YUEzRjl3c3BYN3BzRTJId2RhZ3RzWVJqR0psRk91cmVXSmRBeUlVUHYrKy91?=
 =?utf-8?B?R1JvbXE2L1hVaTBGR1A3N0M2dys0NCtzYjQvQ2RvUXpheWVGNG9HSk0rWlJB?=
 =?utf-8?B?b3IvZnNNRGpUU0tLVFFNazZiVnh0aXlaZ2NodEl4RmhsMXFSck9CWkRxc2hV?=
 =?utf-8?B?dEJJdlYxdCtJalFYZUU3aHZrT3FaSEhmbFVDN0J1ajU4b1JzMnV1MG9EdWNr?=
 =?utf-8?B?YjhMZHJERC85VndzOFFrUXJHSm9XQldRUW5hUHkwbFllcVdWYUFrb1FqNzhR?=
 =?utf-8?B?Q25RcEtvb1RENHVDM0lNblBNR1RiTDRIcFVTY2p3L1hzSUdhMEZpMlBMTmtE?=
 =?utf-8?B?YlltRFJKRGpuRzlyWUdtZHl3UlhZUVNKYTkxbXA2QXNuRVRjMWJSd1M3OHFJ?=
 =?utf-8?B?Slp2UDQrMXZyZCtuNkxYRk9WbDhmV25OUTNlYlZXT0k4SEtYMFVnTzB0S1BI?=
 =?utf-8?Q?syaY=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 13:39:52.8790 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 509fbfd8-dcc8-4c6e-aff6-08ddff5dab75
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9354
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

From: Nicolin Chen <nicolinc@nvidia.com>

Implement a set_iommu_device callback:
 -If found an existing viommu reuse that.
 -Else,
    Allocate a vIOMMU with the nested parent S2 hwpt allocated by VFIO.
    Though, iommufd’s vIOMMU model supports nested translation by
    encapsulating a S2 nesting parent HWPT, devices cannot attach to this
    parent HWPT directly. So two proxy nested HWPTs (bypass and abort) are
    allocated to handle device attachments.
 -And add the dev to viommu device list

Also add an unset_iommu_device to unwind/cleanup above.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c   | 150 ++++++++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3-accel.h   |  17 +++++
 hw/arm/trace-events     |   4 ++
 include/hw/arm/smmuv3.h |   1 +
 4 files changed, 172 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 6b0e512d86..81fa738f6f 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "trace.h"
 
 #include "hw/arm/smmuv3.h"
 #include "hw/iommu.h"
@@ -17,6 +18,9 @@
 
 #include "smmuv3-accel.h"
 
+#define SMMU_STE_VALID      (1ULL << 0)
+#define SMMU_STE_CFG_BYPASS (1ULL << 3)
+
 static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
                                                PCIBus *bus, int devfn)
 {
@@ -35,6 +39,149 @@ static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
     return accel_dev;
 }
 
+static bool
+smmuv3_accel_dev_alloc_viommu(SMMUv3AccelDevice *accel_dev,
+                              HostIOMMUDeviceIOMMUFD *idev, Error **errp)
+{
+    struct iommu_hwpt_arm_smmuv3 bypass_data = {
+        .ste = { SMMU_STE_CFG_BYPASS | SMMU_STE_VALID, 0x0ULL },
+    };
+    struct iommu_hwpt_arm_smmuv3 abort_data = {
+        .ste = { SMMU_STE_VALID, 0x0ULL },
+    };
+    SMMUDevice *sdev = &accel_dev->sdev;
+    SMMUState *bs = sdev->smmu;
+    SMMUv3State *s = ARM_SMMUV3(bs);
+    SMMUv3AccelState *s_accel = s->s_accel;
+    uint32_t s2_hwpt_id = idev->hwpt_id;
+    SMMUViommu *viommu;
+    uint32_t viommu_id;
+
+    if (s_accel->viommu) {
+        accel_dev->viommu = s_accel->viommu;
+        return true;
+    }
+
+    if (!iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
+                                      IOMMU_VIOMMU_TYPE_ARM_SMMUV3,
+                                      s2_hwpt_id, &viommu_id, errp)) {
+        return false;
+    }
+
+    viommu = g_new0(SMMUViommu, 1);
+    viommu->core.viommu_id = viommu_id;
+    viommu->core.s2_hwpt_id = s2_hwpt_id;
+    viommu->core.iommufd = idev->iommufd;
+
+    if (!iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid,
+                                    viommu->core.viommu_id, 0,
+                                    IOMMU_HWPT_DATA_ARM_SMMUV3,
+                                    sizeof(abort_data), &abort_data,
+                                    &viommu->abort_hwpt_id, errp)) {
+        goto free_viommu;
+    }
+
+    if (!iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid,
+                                    viommu->core.viommu_id, 0,
+                                    IOMMU_HWPT_DATA_ARM_SMMUV3,
+                                    sizeof(bypass_data), &bypass_data,
+                                    &viommu->bypass_hwpt_id, errp)) {
+        goto free_abort_hwpt;
+    }
+
+    viommu->iommufd = idev->iommufd;
+
+    s_accel->viommu = viommu;
+    accel_dev->viommu = viommu;
+    return true;
+
+free_abort_hwpt:
+    iommufd_backend_free_id(idev->iommufd, viommu->abort_hwpt_id);
+free_viommu:
+    iommufd_backend_free_id(idev->iommufd, viommu->core.viommu_id);
+    g_free(viommu);
+    return false;
+}
+
+static bool smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
+                                          HostIOMMUDevice *hiod, Error **errp)
+{
+    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(hiod);
+    SMMUState *bs = opaque;
+    SMMUv3State *s = ARM_SMMUV3(bs);
+    SMMUv3AccelState *s_accel = s->s_accel;
+    SMMUPciBus *sbus = smmu_get_sbus(bs, bus);
+    SMMUv3AccelDevice *accel_dev = smmuv3_accel_get_dev(bs, sbus, bus, devfn);
+    SMMUDevice *sdev = &accel_dev->sdev;
+    uint16_t sid = smmu_get_sid(sdev);
+
+    if (!idev) {
+        return true;
+    }
+
+    if (accel_dev->idev) {
+        if (accel_dev->idev != idev) {
+            error_setg(errp, "Device 0x%x already has an associated IOMMU dev",
+                       sid);
+            return false;
+        }
+        return true;
+    }
+
+    if (!smmuv3_accel_dev_alloc_viommu(accel_dev, idev, errp)) {
+        error_setg(errp, "Device 0x%x: Unable to alloc viommu", sid);
+        return false;
+    }
+
+    accel_dev->idev = idev;
+    QLIST_INSERT_HEAD(&s_accel->viommu->device_list, accel_dev, next);
+    trace_smmuv3_accel_set_iommu_device(devfn, sid);
+    return true;
+}
+
+static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
+                                            int devfn)
+{
+    SMMUState *bs = opaque;
+    SMMUv3State *s = ARM_SMMUV3(bs);
+    SMMUPciBus *sbus = g_hash_table_lookup(bs->smmu_pcibus_by_busptr, bus);
+    SMMUv3AccelDevice *accel_dev;
+    SMMUViommu *viommu;
+    SMMUDevice *sdev;
+    uint16_t sid;
+
+    if (!sbus) {
+        return;
+    }
+
+    sdev = sbus->pbdev[devfn];
+    if (!sdev) {
+        return;
+    }
+
+    sid = smmu_get_sid(sdev);
+    accel_dev = container_of(sdev, SMMUv3AccelDevice, sdev);
+    if (!host_iommu_device_iommufd_attach_hwpt(accel_dev->idev,
+                                               accel_dev->idev->hwpt_id,
+                                               NULL)) {
+        error_report("Unable to attach dev 0x%x to the default HW pagetable",
+                     sid);
+    }
+
+    accel_dev->idev = NULL;
+    QLIST_REMOVE(accel_dev, next);
+    trace_smmuv3_accel_unset_iommu_device(devfn, sid);
+
+    viommu = s->s_accel->viommu;
+    if (QLIST_EMPTY(&viommu->device_list)) {
+        iommufd_backend_free_id(viommu->iommufd, viommu->bypass_hwpt_id);
+        iommufd_backend_free_id(viommu->iommufd, viommu->abort_hwpt_id);
+        iommufd_backend_free_id(viommu->iommufd, viommu->core.viommu_id);
+        g_free(viommu);
+        s->s_accel->viommu = NULL;
+    }
+}
+
 static bool smmuv3_accel_pdev_allowed(PCIDevice *pdev, bool *vfio_pci)
 {
 
@@ -121,6 +268,8 @@ static uint64_t smmuv3_accel_get_viommu_flags(void *opaque)
 static const PCIIOMMUOps smmuv3_accel_ops = {
     .get_address_space = smmuv3_accel_find_add_as,
     .get_viommu_flags = smmuv3_accel_get_viommu_flags,
+    .set_iommu_device = smmuv3_accel_set_iommu_device,
+    .unset_iommu_device = smmuv3_accel_unset_iommu_device,
 };
 
 void smmuv3_accel_init(SMMUv3State *s)
@@ -128,4 +277,5 @@ void smmuv3_accel_init(SMMUv3State *s)
     SMMUState *bs = ARM_SMMU(s);
 
     bs->iommu_ops = &smmuv3_accel_ops;
+    s->s_accel = g_new0(SMMUv3AccelState, 1);
 }
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 70da16960f..3c8506d1e6 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -10,12 +10,29 @@
 #define HW_ARM_SMMUV3_ACCEL_H
 
 #include "hw/arm/smmu-common.h"
+#include "system/iommufd.h"
+#include <linux/iommufd.h>
 #include CONFIG_DEVICES
 
+typedef struct SMMUViommu {
+    IOMMUFDBackend *iommufd;
+    IOMMUFDViommu core;
+    uint32_t bypass_hwpt_id;
+    uint32_t abort_hwpt_id;
+    QLIST_HEAD(, SMMUv3AccelDevice) device_list;
+} SMMUViommu;
+
 typedef struct SMMUv3AccelDevice {
     SMMUDevice  sdev;
+    HostIOMMUDeviceIOMMUFD *idev;
+    SMMUViommu *viommu;
+    QLIST_ENTRY(SMMUv3AccelDevice) next;
 } SMMUv3AccelDevice;
 
+typedef struct SMMUv3AccelState {
+    SMMUViommu *viommu;
+} SMMUv3AccelState;
+
 #ifdef CONFIG_ARM_SMMUV3_ACCEL
 void smmuv3_accel_init(SMMUv3State *s);
 #else
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index f3386bd7ae..86370d448a 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -66,6 +66,10 @@ smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s
 smmuv3_inv_notifiers_iova(const char *name, int asid, int vmid, uint64_t iova, uint8_t tg, uint64_t num_pages, int stage) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" stage=%d"
 smmu_reset_exit(void) ""
 
+#smmuv3-accel.c
+smmuv3_accel_set_iommu_device(int devfn, uint32_t sid) "devfn=0x%x (sid=0x%x)"
+smmuv3_accel_unset_iommu_device(int devfn, uint32_t sid) "devfn=0x%x (sid=0x%x)"
+
 # strongarm.c
 strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
 strongarm_ssp_read_underrun(void) "SSP rx underrun"
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index bb7076286b..5f3e9089a7 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -66,6 +66,7 @@ struct SMMUv3State {
 
     /* SMMU has HW accelerator support for nested S1 + s2 */
     bool accel;
+    struct SMMUv3AccelState  *s_accel;
 };
 
 typedef enum {
-- 
2.43.0


