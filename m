Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F715CD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 11:49:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU18B-0004VQ-Ne; Mon, 01 Jun 2026 07:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU186-0004UE-U2; Mon, 01 Jun 2026 07:48:27 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU185-0004k5-Af; Mon, 01 Jun 2026 07:48:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/L/f4MYyGSSs0Lbe3dgnxjjOok7tmZcPuQ4APB/mPNtRDUwY98rh+2yr+jFvINQ5y9BoRCcDUxEerr/hhCuz+MHA2EH26WdwF4I3IhC6XNxWm1CAxoprysnD8/3yxoBoug7BlXjyTZl4nNS8anLbI3azgKdh7wjyeeu5Gd/pgm2H7n/Q9/DWtAXMYGgXE+G1Z9AuQm9AzLjDW5/qWI8yJhXB2WuhQGS69RXAaxA/BpobOZNu+xw9zzN8JIx4kSOCuVVcY1oglcFBi2kP0qqlOZbkJc894D2fY1e8mRdf5ifyp3HEtL+WEsN/Q2vawguvD0R7JibsiS1UgxX4ATteg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwFwoyfxSEXw8CWFQ+Dm08LgxLWLcsipJeOJVuAo2nA=;
 b=ffwEEeI15zYuHxj57AtZ8rcYW6tGBgzg4qUYOJpp8gY8JgJtUFPsmV08B8pBb8yr7fa/WFGbX4cvPLZeSdafanOE2nSamwtkwDTXBW/8OI7WBhiDZPHbgY88rM5fMS8jiZQt+CyPPhVTS0CxKyQrfZ7ihBgDD6Sk+qUmPR7rtGvJXaxLpDk9MrwVDjKBqj9S+9ohrFxlUwTTPgQQs+9YqRzbOAtvl89jTCJooIn1SARy4Y1JPMUQy4KFTeTttvehzr/i8j+kOs/nGKHxjWoxuVee4EOSK7bTzHdGdGsZH+hSURBhX2Sm7lquj5zjJI8wmlOEyQJ9/cjugkzkbqkP0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwFwoyfxSEXw8CWFQ+Dm08LgxLWLcsipJeOJVuAo2nA=;
 b=ZiyyMWkNoxjIH7qaUR6dOh6bKh7OP0Ba3c3Nm/57TetlBqwzIGZcYNtSOYPlCJrfJTAcs8b+zainov7Co1qdVVTETFJz7CB2ApMT4N2cQ/H+VsNl2QmO3YGgTTHZ4sfVQ+ln2XfwQ3mO8noZfLrEQb1XhJB9+FfDzQRjPu8fUUQSIEDgGOjuojIzoUfg0lSMlmFaNyfR0+FzBtB9W28KgrrlwoOpKoiUuK1yAMceJpNEE6iSDe6n6Y/U0jiZyRRciTSGol9OrYHMM40C2ByNvlk0jUzWDuSZ6SWdvjAJAmJOth6ZXZL5+Z1qQ95Oa5twwYwRKwn3x8ye2dAzFjhaVg==
Received: from BN9P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::13)
 by CY5PR12MB9056.namprd12.prod.outlook.com (2603:10b6:930:34::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Mon, 1 Jun 2026
 11:48:15 +0000
Received: from BN2PEPF000055DD.namprd21.prod.outlook.com
 (2603:10b6:408:13e:cafe::aa) by BN9P220CA0008.outlook.office365.com
 (2603:10b6:408:13e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Mon, 1
 Jun 2026 11:48:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055DD.mail.protection.outlook.com (10.167.245.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Mon, 1 Jun 2026 11:48:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:47:57 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:47:53 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v6 01/31] backends/iommufd: Update
 iommufd_backend_get_device_info
Date: Mon, 1 Jun 2026 12:41:51 +0100
Message-ID: <20260601114221.457995-2-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601114221.457995-1-skolothumtho@nvidia.com>
References: <20260601114221.457995-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DD:EE_|CY5PR12MB9056:EE_
X-MS-Office365-Filtering-Correlation-Id: af534491-5140-4d6c-e2ef-08debfd3a95f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|22082099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 3zm0jDoye5bBwusUf7rRRR1RhJM8MrVTVnMjd770xe09fgqgNPwkH2BQh7dBnCgjrQAQ2diDRDG45W6XYeXBSpObpF25FrPJadhGLFQgbogdfJw/h2dVjzLZeXvAG6k/qwlgBewHaOl2ricbQ4L6+LdbESxeIBIdr6DdMSGFoJOwgkKgmFHuoVxjRlaM5+e8a8JtDiHt9LU4LpiUD7iEWPTg9qn1YDJdl7odRYcJ4VNEu+pPSZbF186ofjSbvtahQy2NqNIXirBIkq762MctssdgHtvh2fQqRVJ2MhpJctOlJH/FwDrWU3oj1KscCJg8ret+33brkE9LfWwyLQNIvsrEB2OEOnNcL9nTGlbm3VsM+r3n6L6k9XguBSkYffdm4cxLRtu4uVh9jWMuOEEi1o7DJazRMOJKTmtPWm0miRKk+FadbO57X98Pm0BX13y4yTIDtUJVX28NBWqEF/6CfUBZCnMJ7i53LHi0JUzheMboPcMHbX2VM7PHkz3LJvVakB8HDvRoZvu3WQcpdRxwdCz4SlR5DNU7SysPh8ly+X8EC87eu8PshVwYAw+kN7v7wWkrW2HjJ5AMoPKY+BStGedEo9eWDauAckfKM4Zyo2OdlTi7FwY4WHnqD9Od95qtfL9c2Ac+1SPsrjV6a3/D7XvBsJayRndOsB/iXld2aRmk9obDrJboArL2dzQOK0I9EFieryfqFCdIOdQ3dO9pJzISIygMeYgXKnhW3CxP2Og=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(22082099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Tt8xTWs1BxK72dTYXD2sTK2TJa38LXJfqPSeXBJQEtqHqVR4BUgBxz/hFCxUTQ371kcWsnGuYckVO+7UEmvSYtXWWf4L/2El2LSzUemvKQdySnU/yYEF9GDui1O0DF/ijSOcC3yDsFQLgPUmmfYsKRfsz2Sq1Jq9eb6VlEmSV4uSRMQaFJPIOoyjtZif9KW5a2ecoNweE4vtKTBoShIMp7xeDVPFruNwI+t1zwNQ8XR1PG09DYoVD6VMpgGoT9Q+83VMm+w6B79hp7z9Zs8RMwa4Q3QYLg4/s8z2/ahvsYofv2O6WfedUx0nghzWn9IJUqmB9TpFCh1tsoKXug+9m22U+e2KrXHFJi0+Vc2gi/mBlPa/Fw4qbK67D5JCrlph85747BVII8DEdD/kG4gepdtjae+rH/S84F85aTmPaoC/Xyj5uGuwSPoNo4Jr+mqo
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 11:48:13.1876 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af534491-5140-4d6c-e2ef-08debfd3a95f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9056
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

From: Nicolin Chen <nicolinc@nvidia.com>

The updated IOMMUFD uAPI introduces the ability for userspace to request
a specific hardware info data type via IOMMU_GET_HW_INFO. Update
iommufd_backend_get_device_info() to set IOMMU_HW_INFO_FLAG_INPUT_TYPE
when a non-zero type is supplied, and adjust all callers to pass a type
value explicitly initialised to zero (IOMMU_HW_INFO_TYPE_DEFAULT) when
no specific type is requested.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 backends/iommufd.c    | 7 +++++++
 hw/arm/smmuv3-accel.c | 2 +-
 hw/vfio/iommufd.c     | 4 ++--
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index 410b044370..8c3a981392 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -390,16 +390,23 @@ bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be,
     return true;
 }
 
+/*
+ * @type can carry a desired HW info type defined in the uapi headers. If caller
+ * doesn't have one, indicating it wants the default type, then @type should be
+ * zeroed (i.e. IOMMU_HW_INFO_TYPE_DEFAULT).
+ */
 bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
                                      uint32_t *type, void *data, uint32_t len,
                                      uint64_t *caps, uint8_t *max_pasid_log2,
                                      Error **errp)
 {
     struct iommu_hw_info info = {
+        .flags = (*type) ? IOMMU_HW_INFO_FLAG_INPUT_TYPE : 0,
         .size = sizeof(info),
         .dev_id = devid,
         .data_len = len,
         .data_uptr = (uintptr_t)data,
+        .in_data_type = *type,
     };
 
     if (ioctl(be->fd, IOMMU_GET_HW_INFO, &info)) {
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 06dadf9cc7..163d3e7279 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -176,7 +176,7 @@ smmuv3_accel_hw_compatible(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *hiodi,
                            Error **errp)
 {
     struct iommu_hw_info_arm_smmuv3 info;
-    uint32_t data_type;
+    uint32_t data_type = IOMMU_HW_INFO_TYPE_DEFAULT;
     uint64_t caps;
 
     if (!iommufd_backend_get_device_info(hiodi->iommufd, hiodi->devid,
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index df148a49a7..495a59cc2e 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -353,7 +353,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
     IOMMUFDBackend *iommufd = vbasedev->iommufd;
     VFIOContainer *bcontainer = VFIO_IOMMU(container);
     bool viommu_nesting, viommu_nesting_dirty;
-    uint32_t type, flags = 0;
+    uint32_t type = IOMMU_HW_INFO_TYPE_DEFAULT, flags = 0;
     uint64_t hw_caps;
     VendorCaps caps;
     VFIOIOASHwpt *hwpt;
@@ -948,7 +948,7 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
     HostIOMMUDeviceIOMMUFD *hiodi;
     HostIOMMUDeviceCaps *caps = &hiod->caps;
     VendorCaps *vendor_caps = &caps->vendor_caps;
-    enum iommu_hw_info_type type;
+    uint32_t type = IOMMU_HW_INFO_TYPE_DEFAULT;
     uint8_t max_pasid_log2;
     uint64_t hw_caps;
 
-- 
2.43.0


