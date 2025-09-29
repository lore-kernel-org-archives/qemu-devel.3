Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CAE3CAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 13:55:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3E8X-0003br-9O; Mon, 29 Sep 2025 09:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E7G-0002l1-Uj; Mon, 29 Sep 2025 09:40:37 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E6u-0003NU-UA; Mon, 29 Sep 2025 09:40:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lu8XnFiDX9zVLPY8UFZos4G6owSFNIHw7bV42lZZ4Ms+SJSj2DI0zViVcem2lwNIE6L5zMUt9taP1zDZerjOD9ppeVzSiXTJUSrHXGiKn3lHu+HV05jRKpocRlaFEhjJRvR6QUju3MDL62COkyeny0PaAIJQCV1oKUq6KHtPfoedutxTFjnXVgY8rLmkT0YDZ+Va9uRJZM2pk54Li3osm56F6I+6grAtQeYZ9ONCBDz32VOCev+/gQWW5FJg0GgiXH/7dWoRRF4tAV5KPNu8PjnpN/VQFlDUi/yayCDNE1oR/wuK/j39fLWzHes2blSLuiyxg6y7NQqOUkCQij/91g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0jO6FH0QxeuFpOn0WMMp5VCAryvh1uzMdOQWEvJ+YA=;
 b=Jaj+AT8vY1HDOzZ6Ph8rJ9xzAGgwwzOvRANLb3MqBKOA4ZfltR0mh6XFQeEpgFXk9mU0XMDxxmESmHb96xmnMzkmZE4JZPjS2kRhewCsBAQrxR0cUgfpLttvTtvknd7+gS1P8N0PaXnGXbsFpc9/TEJjZYBv1MHVwTAs9r47Y5a0z/8DteC8ogGTCANrCRc+Wj0/zyvTxI0UzBuWkgAqO8ASifsaHUDKNgjdFuj2r5wh6D1oqUV0DBPrk1WNv9lwxPgKokaLXGUgnJIheopLfBbwKOyGK6Sa6yUYMaPhv3eddwvBnSjm64lT51Rh5sI1w+f30ULncxtjorzI90lffA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0jO6FH0QxeuFpOn0WMMp5VCAryvh1uzMdOQWEvJ+YA=;
 b=CjhYE34hte518Rz/WBwy6z9KLyp30ltDq9ByMlkkmpfVGWfeILHLVQqUs2Z8UzVxxg1Gj0pwHoE8esdqw4ROwyPNJ2B34HBHHI67BfJB11HItbnBiJeWf7ub3S9tbZAkDk13+tEJFlKw7idJzFOrUN/J1FNRlSk5oyd8xGO8KwIdHRl4MFP3bb6F6UZ7pfkgA7BERSC7lMhy5dTYYWgVIWBkJBOG5ak/f+PI523oCw0ywPe/BLAl/zfBQPps/l+/BoMzlIKSSQ43JEe6ao+Pw4J8wlriHfMtA3Jp4Rs0xJK2/KR7A8RN//NT90gtt459EuTM2gHBWjEllQypZtpUXA==
Received: from CH0PR03CA0438.namprd03.prod.outlook.com (2603:10b6:610:10e::14)
 by BL1PR12MB5779.namprd12.prod.outlook.com (2603:10b6:208:392::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Mon, 29 Sep
 2025 13:39:57 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::47) by CH0PR03CA0438.outlook.office365.com
 (2603:10b6:610:10e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Mon,
 29 Sep 2025 13:39:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Mon, 29 Sep 2025 13:39:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 29 Sep
 2025 06:39:41 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Sep
 2025 06:39:37 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <shameerkolothum@gmail.com>
Subject: [PATCH v4 09/27] hw/arm/smmuv3-accel: Support nested STE
 install/uninstall support
Date: Mon, 29 Sep 2025 14:36:25 +0100
Message-ID: <20250929133643.38961-10-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|BL1PR12MB5779:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c0e27dd-e7b7-4bae-c620-08ddff5dadb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rN62uIb/9Ejvv8Z7tA8ourZLeI5pGpuRjZHu0eFS3fTAJVD7eZvOTWXHW6gN?=
 =?us-ascii?Q?+HwHozqBf7+xocOl1hkQ2Q5Ys9Nf93KgSOzh8D4OURcOMvQh8xseBIl5UUff?=
 =?us-ascii?Q?hEqnvYN9ngzifRoObxetrMD/ocHthw4xV3ycukCsFK6fvdBWnv3dvc4hFcDN?=
 =?us-ascii?Q?TiaRAnR+90DaXiaFAm7JhyDQD7/xzPNvSPmABarixcgkP30NSBGCTEivtU6Q?=
 =?us-ascii?Q?plppn37MWssqz72WPI7a0RRpM/Ib/3GiztVP/nJi2ALrnOZ9Kr6RIgSLwsin?=
 =?us-ascii?Q?YZlSsNwIKbyazdNJTu203so5FmfBH4KfBGzVaxrDTMG5biuf5Vn5H5coVO/z?=
 =?us-ascii?Q?aNzA529gQMdcAAYIYvuA6mecd7fTcJRkY6r8lIZuiTFxIvpqpK5m+ZuIveq5?=
 =?us-ascii?Q?kYDIrz8m/Qol0+YOA83j082C/yvkbEgIFKWzrQYMUscrM1ZXln6oQI28EEW9?=
 =?us-ascii?Q?jEglSt7xEdQmAOhSQzNQDuLIk2tYT7u6HLliQrufZp0s7OwAmMhVZeCaKqjR?=
 =?us-ascii?Q?MVlS3xbY9RC5AMyX5h7+1Vxbm9Sp9oxGP9YuQkBSvcExcUv73ncmisaQydMT?=
 =?us-ascii?Q?TuLahC/fn39LgWM2tbq+brVoEUV6MS3i3Xu29/r6FY2pfA74AQoFW0dOK4iY?=
 =?us-ascii?Q?62rPsrfkBnnezje5KsIWsKBwbYa6yzAE9Hw1/AFG71jRI9xDlg248jViA5Wt?=
 =?us-ascii?Q?EZygXqX1rFlhB9U9MQlT5bYBe6DnBMn4qxI9i8K0TiTCHArPHUcInMFLYcIv?=
 =?us-ascii?Q?W612vBli5zepZtzqfi/5cZyL+MmUNLadP+IuK/Jl06A/U5qcMGmDT7uJzWAu?=
 =?us-ascii?Q?L/9a6JA5kJieyUp7okoyc+TfYXk5VoT97xsQqlPNkerN1qJIUXt2ikKyEcTN?=
 =?us-ascii?Q?4PxW4kT4Krw8fKhpAwC3aJccXlw+ohf7dbr4rQCAWZIbCLKYlypf5+KIGPwj?=
 =?us-ascii?Q?txspdAV3/ufaW9PFUx2tUndKt8iby6dys4UHT/R9NXMEx3ZbSG5namkOhrpw?=
 =?us-ascii?Q?hodqr2rEjFCWsxQYDWjEYzO2CJMmkGf1BTzkHF6vNhQMFiNSpVsGDJOWu9T2?=
 =?us-ascii?Q?uqemWg6N0zzR5BIk12q4pNnfu++gYq1E1p0mGNTcZNq3OZQzKorXH1iihcOi?=
 =?us-ascii?Q?cdDHMixgrLGNnIVpQNyVGRASAyDDrAEKBf/h63uzyzqhnAHiBlIHMJkhhy9z?=
 =?us-ascii?Q?RgynPyvsRX+dQszzzMNukgX4o1Rl16wztHRzbUxfiEdPDKUFwxSTqXgqyqOa?=
 =?us-ascii?Q?aZG7zTpl0e34Bch3Q7Qxl6pCspvkWOyAEwD6zCtKAWg1Xy14XRlWbydS9+V9?=
 =?us-ascii?Q?9okcvQPzIBBbosIydgBAWU1cWAbJCR17kXexh5hos0YeiijhWOdAt/o5vy3q?=
 =?us-ascii?Q?V3t0YwmO3Urkl/d08dGKb0XjPjGyUjW0j4UoeILW5B95VL/J6YlaXYnuaoAE?=
 =?us-ascii?Q?E9kMnZNASdYgBdhv3i14vFoO2z2eFH7y49xanQbnCnp/eUwEYG/cNb1rcQm3?=
 =?us-ascii?Q?xK+r5pMscPL06RCdiV+wr772ypu9s8TRb4m73t7Q2MQUXYugMXqSF9mfdD03?=
 =?us-ascii?Q?VYDorBHT7MQrUVXDskc=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 13:39:56.6497 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c0e27dd-e7b7-4bae-c620-08ddff5dadb9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5779
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

From: Nicolin Chen <nicolinc@nvidia.com>

Allocates a s1 HWPT for the Guest s1 stage and attaches that to the
pass-through vfio device. This will be invoked when Guest issues
SMMU_CMD_CFGI_STE/STE_RANGE.

While at it, we are also exporting both smmu_find_ste() and
smmuv3_flush_config() from smmuv3.c for use here.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c    | 164 +++++++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3-accel.h    |  22 ++++++
 hw/arm/smmuv3-internal.h |   3 +
 hw/arm/smmuv3.c          |  18 ++++-
 hw/arm/trace-events      |   1 +
 5 files changed, 205 insertions(+), 3 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 81fa738f6f..5c3825cecd 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -17,10 +17,174 @@
 #include "hw/vfio/pci.h"
 
 #include "smmuv3-accel.h"
+#include "smmuv3-internal.h"
 
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
+#define STE1_ETS      MAKE_64BIT_MASK(28, 2)
+#define STE1_MASK     (STE1_ETS | STE1_S1STALLD | STE1_S1CSH | STE1_S1COR | \
+                       STE1_S1CIR | STE1_S1DSS)
+
+static bool
+smmuv3_accel_dev_uninstall_nested_ste(SMMUv3AccelDevice *accel_dev, bool abort,
+                                      Error **errp)
+{
+    HostIOMMUDeviceIOMMUFD *idev = accel_dev->idev;
+    SMMUS1Hwpt *s1_hwpt = accel_dev->s1_hwpt;
+    uint32_t hwpt_id;
+
+    if (!s1_hwpt || !accel_dev->viommu) {
+        return true;
+    }
+
+    if (abort) {
+        hwpt_id = accel_dev->viommu->abort_hwpt_id;
+    } else {
+        hwpt_id = accel_dev->viommu->bypass_hwpt_id;
+    }
+
+    if (!host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp)) {
+        return false;
+    }
+
+    iommufd_backend_free_id(s1_hwpt->iommufd, s1_hwpt->hwpt_id);
+    accel_dev->s1_hwpt = NULL;
+    g_free(s1_hwpt);
+    return true;
+}
+
+static bool
+smmuv3_accel_dev_install_nested_ste(SMMUv3AccelDevice *accel_dev,
+                                    uint32_t data_type, uint32_t data_len,
+                                    void *data, Error **errp)
+{
+    SMMUViommu *viommu = accel_dev->viommu;
+    SMMUS1Hwpt *s1_hwpt = accel_dev->s1_hwpt;
+    HostIOMMUDeviceIOMMUFD *idev = accel_dev->idev;
+    uint32_t flags = 0;
+
+    if (!idev || !viommu) {
+        error_setg(errp, "Device 0x%x has no associated IOMMU dev or vIOMMU",
+                   smmu_get_sid(&accel_dev->sdev));
+        return false;
+    }
+
+    if (s1_hwpt) {
+        if (!smmuv3_accel_dev_uninstall_nested_ste(accel_dev, true, errp)) {
+            return false;
+        }
+    }
+
+    s1_hwpt = g_new0(SMMUS1Hwpt, 1);
+    s1_hwpt->iommufd = idev->iommufd;
+    if (!iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid,
+                                    viommu->core.viommu_id, flags, data_type,
+                                    data_len, data, &s1_hwpt->hwpt_id, errp)) {
+        return false;
+    }
+
+    if (!host_iommu_device_iommufd_attach_hwpt(idev, s1_hwpt->hwpt_id, errp)) {
+        iommufd_backend_free_id(idev->iommufd, s1_hwpt->hwpt_id);
+        return false;
+    }
+    accel_dev->s1_hwpt = s1_hwpt;
+    return true;
+}
+
+bool
+smmuv3_accel_install_nested_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
+                                Error **errp)
+{
+    SMMUv3AccelDevice *accel_dev;
+    SMMUEventInfo event = {.type = SMMU_EVT_NONE, .sid = sid,
+                           .inval_ste_allowed = true};
+    struct iommu_hwpt_arm_smmuv3 nested_data = {};
+    uint64_t ste_0, ste_1;
+    uint32_t config;
+    STE ste;
+    int ret;
+
+    if (!s->accel) {
+        return true;
+    }
+
+    accel_dev = container_of(sdev, SMMUv3AccelDevice, sdev);
+    if (!accel_dev->viommu) {
+        return true;
+    }
+
+    ret = smmu_find_ste(sdev->smmu, sid, &ste, &event);
+    if (ret) {
+        error_setg(errp, "Failed to find STE for Device 0x%x", sid);
+        return true;
+    }
+
+    config = STE_CONFIG(&ste);
+    if (!STE_VALID(&ste) || !STE_CFG_S1_ENABLED(config)) {
+        if (!smmuv3_accel_dev_uninstall_nested_ste(accel_dev,
+                                                   STE_CFG_ABORT(config),
+                                                   errp)) {
+            return false;
+        }
+        smmuv3_flush_config(sdev);
+        return true;
+    }
+
+    ste_0 = (uint64_t)ste.word[0] | (uint64_t)ste.word[1] << 32;
+    ste_1 = (uint64_t)ste.word[2] | (uint64_t)ste.word[3] << 32;
+    nested_data.ste[0] = cpu_to_le64(ste_0 & STE0_MASK);
+    nested_data.ste[1] = cpu_to_le64(ste_1 & STE1_MASK);
+
+    if (!smmuv3_accel_dev_install_nested_ste(accel_dev,
+                                             IOMMU_HWPT_DATA_ARM_SMMUV3,
+                                             sizeof(nested_data),
+                                             &nested_data, errp)) {
+        error_setg(errp, "Unable to install nested STE=%16LX:%16LX, sid=0x%x,"
+                   "ret=%d", nested_data.ste[1], nested_data.ste[0], sid, ret);
+        return false;
+    }
+    trace_smmuv3_accel_install_nested_ste(sid, nested_data.ste[1],
+                                          nested_data.ste[0]);
+    return true;
+}
+
+bool smmuv3_accel_install_nested_ste_range(SMMUv3State *s, SMMUSIDRange *range,
+                                           Error **errp)
+{
+    SMMUv3AccelState *s_accel = s->s_accel;
+    SMMUv3AccelDevice *accel_dev;
+
+    if (!s_accel || !s_accel->viommu) {
+        return true;
+    }
+
+    QLIST_FOREACH(accel_dev, &s_accel->viommu->device_list, next) {
+        uint32_t sid = smmu_get_sid(&accel_dev->sdev);
+
+        if (sid >= range->start && sid <= range->end) {
+            if (!smmuv3_accel_install_nested_ste(s, &accel_dev->sdev,
+                                                 sid, errp)) {
+                return false;
+            }
+        }
+    }
+    return true;
+}
+
 static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
                                                PCIBus *bus, int devfn)
 {
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 3c8506d1e6..f631443b09 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -22,9 +22,15 @@ typedef struct SMMUViommu {
     QLIST_HEAD(, SMMUv3AccelDevice) device_list;
 } SMMUViommu;
 
+typedef struct SMMUS1Hwpt {
+    IOMMUFDBackend *iommufd;
+    uint32_t hwpt_id;
+} SMMUS1Hwpt;
+
 typedef struct SMMUv3AccelDevice {
     SMMUDevice  sdev;
     HostIOMMUDeviceIOMMUFD *idev;
+    SMMUS1Hwpt *s1_hwpt;
     SMMUViommu *viommu;
     QLIST_ENTRY(SMMUv3AccelDevice) next;
 } SMMUv3AccelDevice;
@@ -35,10 +41,26 @@ typedef struct SMMUv3AccelState {
 
 #ifdef CONFIG_ARM_SMMUV3_ACCEL
 void smmuv3_accel_init(SMMUv3State *s);
+bool smmuv3_accel_install_nested_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
+                                     Error **errp);
+bool smmuv3_accel_install_nested_ste_range(SMMUv3State *s, SMMUSIDRange *range,
+                                           Error **errp);
 #else
 static inline void smmuv3_accel_init(SMMUv3State *s)
 {
 }
+static inline bool
+smmuv3_accel_install_nested_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
+                                Error **errp)
+{
+    return true;
+}
+static inline bool
+smmuv3_accel_install_nested_ste_range(SMMUv3State *s, SMMUSIDRange *range,
+                                      Error **errp)
+{
+    return true;
+}
 #endif
 
 #endif /* HW_ARM_SMMUV3_ACCEL_H */
diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index b6b7399347..b0dfa9465c 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -547,6 +547,9 @@ typedef struct CD {
     uint32_t word[16];
 } CD;
 
+int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event);
+void smmuv3_flush_config(SMMUDevice *sdev);
+
 /* STE fields */
 
 #define STE_VALID(x)   extract32((x)->word[0], 0, 1)
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index ef991cb7d8..1fd8aaa0c7 100644
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
@@ -900,7 +899,7 @@ static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event)
     return cfg;
 }
 
-static void smmuv3_flush_config(SMMUDevice *sdev)
+void smmuv3_flush_config(SMMUDevice *sdev)
 {
     SMMUv3State *s = sdev->smmu;
     SMMUState *bc = &s->smmu_state;
@@ -1330,6 +1329,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
         {
             uint32_t sid = CMD_SID(&cmd);
             SMMUDevice *sdev = smmu_find_sdev(bs, sid);
+            Error *local_err = NULL;
 
             if (CMD_SSEC(&cmd)) {
                 cmd_error = SMMU_CERROR_ILL;
@@ -1341,6 +1341,11 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
             }
 
             trace_smmuv3_cmdq_cfgi_ste(sid);
+            if (!smmuv3_accel_install_nested_ste(s, sdev, sid, &local_err)) {
+                error_report_err(local_err);
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
             smmuv3_flush_config(sdev);
 
             break;
@@ -1350,6 +1355,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
             uint32_t sid = CMD_SID(&cmd), mask;
             uint8_t range = CMD_STE_RANGE(&cmd);
             SMMUSIDRange sid_range;
+            Error *local_err = NULL;
 
             if (CMD_SSEC(&cmd)) {
                 cmd_error = SMMU_CERROR_ILL;
@@ -1361,6 +1367,12 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
             sid_range.end = sid_range.start + mask;
 
             trace_smmuv3_cmdq_cfgi_ste_range(sid_range.start, sid_range.end);
+            if (!smmuv3_accel_install_nested_ste_range(s, &sid_range,
+                                                       &local_err)) {
+                error_report_err(local_err);
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
             smmu_configs_inv_sid_range(bs, sid_range);
             break;
         }
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 86370d448a..3b1e9bf083 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -69,6 +69,7 @@ smmu_reset_exit(void) ""
 #smmuv3-accel.c
 smmuv3_accel_set_iommu_device(int devfn, uint32_t sid) "devfn=0x%x (sid=0x%x)"
 smmuv3_accel_unset_iommu_device(int devfn, uint32_t sid) "devfn=0x%x (sid=0x%x)"
+smmuv3_accel_install_nested_ste(uint32_t sid, uint64_t ste_1, uint64_t ste_0) "sid=%d ste=%"PRIx64":%"PRIx64
 
 # strongarm.c
 strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
-- 
2.43.0


