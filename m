Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62564D3C909
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 13:40:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTKPD-0007KV-BE; Wed, 10 Dec 2025 08:39:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vTKP0-0007IU-4I; Wed, 10 Dec 2025 08:38:47 -0500
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vTKOy-0001HS-Hs; Wed, 10 Dec 2025 08:38:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uNaSLXxClNdq+ZGHkXDL8+KhQ600EADcCVE3I3nHgRJ+ec/ze4biWSkvslybzlSabeHDKQ73o4kqF3eWdb17/cbG3+d+uuf2ts0SQv2FScdQ35NFJlQinwOtNV4L3AzoAJ1erpqjJcvlWy323+TyUxVmKNbZhWY/RwxdU3MCCysbC60K0uxuTFAT6rcBFWB3MWwq4HqSw89ebV4EKs+wL2iZkkPuteBVV6m2dAYyhRzjONXru4PGxEnxGvJU3mcnQXlX4Wz12vY47o3MPhG7+Gtkt+wu7r+9hap5EVGmY1lbCYQHjNazs2DQKXhnvINsCGa31uHDqoRu7MA6sDEO3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdJHdHh59k+xUrBiaqwwxqoLqUTmSXpZWR25Wr3elyk=;
 b=JIIGQYIb2OHOehtce8PuVtylct70iugb6loODzXPDPq2DEGaS/0lj8TCP12wMmlGj+AcUV+YGyxC05Ukpk9L7Th+2BrQ7rD1OTYCsjru0mvvCdjx82wc3a3qb7NzQofgIlEnorz6Gpf9KS+WdJam0xOyX52LPV/pa+eNfYxgPfxkOfZpUbPIt7NzBtXzCsxrAa1hjaOE/qq79UEuZwdBGePvziyTktAgVEDJjMsApNKA1p0PFGctcfR1CUrhawKEO5JgiY/zWG1qsntQdwDRsTkRPynv2M/UFqNB+J4zSC0P3tlSDu1XRDFsIW3pJRV+Rij1guduKW48JU+YMCPqFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdJHdHh59k+xUrBiaqwwxqoLqUTmSXpZWR25Wr3elyk=;
 b=pU8td1yj+GPyGOGOrDF6/sq5YKzJFB3zi+fH6xejaZ4jrOAcxWXFcM3ZPy0/g9SYElqpQ4oZqHxkcZP0FDf1SbXXXzm5ktpvRSOb3/9VO3VJ2tSIET8h32PCfP7Gdp9skqj/0tUjax8ZrEvlYh71FNtOnbA1x1wOT5uCOTyVA/eNUC4hm9KbnbjlaELpbTCBkcEWbYZqmsju6xjEUZDKbPfvp+ZgHxHzA46/CBI4PVB6NiRp9M40r+UqB5mE41Fi4fHKuUd6amfq+qi800WpD9o6a3VyN39X4UFN1jeJPEbeJGY32qBMcVmXa3q8nfiv8ZF3ozdMkV7mkItZy243ow==
Received: from BY5PR03CA0001.namprd03.prod.outlook.com (2603:10b6:a03:1e0::11)
 by PH7PR12MB8779.namprd12.prod.outlook.com (2603:10b6:510:26b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Wed, 10 Dec
 2025 13:38:37 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::cc) by BY5PR03CA0001.outlook.office365.com
 (2603:10b6:a03:1e0::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.15 via Frontend Transport; Wed,
 10 Dec 2025 13:38:39 +0000
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
 15.20.9412.4 via Frontend Transport; Wed, 10 Dec 2025 13:38:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 05:38:18 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 05:38:15 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jgg@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: [RFC PATCH 01/16] backends/iommufd: Update
 iommufd_backend_get_device_info
Date: Wed, 10 Dec 2025 13:37:22 +0000
Message-ID: <20251210133737.78257-2-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|PH7PR12MB8779:EE_
X-MS-Office365-Filtering-Correlation-Id: 38807e02-18cf-4493-431f-08de37f16bf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sSOesRfflBmTdzI9Z3mQfQNECyzWYEsOkDtXFO30UzhSR0NIWMOGJc4rR8Si?=
 =?us-ascii?Q?0lu2w01opPNwg/yI+lLKHZBDEtr99Jlx9Xqb/uVg81EZtmKiKpmf+/X9F9No?=
 =?us-ascii?Q?V1UXzLkXwdZl9IFKrvb8QjD3whT4P8PW7UqJ4YFhKl+WXdeuYMzlki2mceFt?=
 =?us-ascii?Q?2Lv4hzoycdh0PWA6FYzHFeKxo/v1pFZYPh5iLI+05iGE5EUZTm6fREkMRDXn?=
 =?us-ascii?Q?kZOPfSINEMkaoIvX09lQFB2YSiB9krmoImx0TNSJUrq4OVKwTWm0Q1vjnziI?=
 =?us-ascii?Q?K+bJri4jQerA+zoq8dh2s7L95d4IRFF64jKJ7+XLAlale6OPBxPRmIAXKe3d?=
 =?us-ascii?Q?IWm3BjdNPb6ycVvpA+poO/w90Nf1LKRph/F1FDiRpD3cTRdekzjttR8Di/aJ?=
 =?us-ascii?Q?USP1laFoIPD9pLIL1zJDkYlD9B+EYUWzWqkwB5A/yknijCd1weD1//WcuCHa?=
 =?us-ascii?Q?b2QnhkY3RYvgZaydZzfkKCmt9ijN7lXaJ99GHs7pm0fQnEWCvjvzOIy2JI0E?=
 =?us-ascii?Q?Zd6Z+G/PdOCbxPY/+fUe3NchKzKMJZAG2mgzLPhCGRj4l/61obuMZvaSswzY?=
 =?us-ascii?Q?li4PyKfcefhDKdL8Uz7vzO+hfSLWjW4M4Vkt3odjWTu340SuLgvmCTH0dAMY?=
 =?us-ascii?Q?vPQQP/SpwUVPdEwvrXVeMS0YLwp2p73HXit1Y22zSqpj5vMfW2+PR0TGRLgE?=
 =?us-ascii?Q?ls9ROfVNucMQ8FdODnp9k2ErcX2aAGq2zI5tJ7h8WxUXhKdj43mwcXhcCtzW?=
 =?us-ascii?Q?31sVf8F1U2ELdepzHElhF7gj3aq4uAbVoKgVLa5jsExVNKBBtFaidoxICx+t?=
 =?us-ascii?Q?Y50WmC9YL1RadrHYKvJBGM66CRk5k7Jld8vgdROWctOwQwxDucQ22O5YFOrk?=
 =?us-ascii?Q?RPB3fQ10+DXDxjvi6Jp3bo3OFv+OtWUq2r513cUupegJ1eXM9dpKGVFecVzW?=
 =?us-ascii?Q?iV+DHVFKpd98/Ts3exPOAoS0F6WFiXIRxT2v3Jw0qJWHaKDUg6PFHvc0NTDs?=
 =?us-ascii?Q?LeiSDpRSlnI6Cv46uhRG4n9jmAG989qMxuwQPxQleiMKVClGoZ9S0kuYL182?=
 =?us-ascii?Q?r+T4nIxTCpOOyoE8D4Y57+/ccKaTjjcMh/WA9oL5MUGTkdJaHWgC0nHBPiae?=
 =?us-ascii?Q?W+T+Cyg5FCF5KCjUfZf2BoN+IOeX0FJaBeZVPRhsf8RFhW6YIXTmmEyksmmk?=
 =?us-ascii?Q?5OqB2YyG+reQaMVl6osARyD43WFTS6vOr4pcOtPhese0YCTPuKCRmYoZBhrV?=
 =?us-ascii?Q?hbM4mwCs6bw9d12JdAvLgJEpChbIDDfUi35VfmKKJOf8W91P2rZYIeD+mtqd?=
 =?us-ascii?Q?VxnC7x6EQx3o/zIGmqeRegO+pJvrab1zFQ7BHgY2BdtDGD+1G5CM3hsC6Xgx?=
 =?us-ascii?Q?I0ko3pT2QeyteabCgCsAhZTjLPj0iphLBxp+wfLiwbRq+O7cE4qlPMhwPX5s?=
 =?us-ascii?Q?Kp8F27jLtVBcjhvKilloYBm5GxTyYIYnRC664PI89MPS+7Uzr67og4tHmyky?=
 =?us-ascii?Q?fPq9GOqCbU9ZP+xVwamK4c/Pm8rcR2IymrBOGh5PzjQUVc2iex1ESWuXdiut?=
 =?us-ascii?Q?5+lJM+A08sqECW051rU=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 13:38:36.9476 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38807e02-18cf-4493-431f-08de37f16bf3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8779
Received-SPF: softfail client-ip=2a01:111:f403:c001::2;
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

The updated IOMMUFD uAPI introduces the ability for userspace to request
a specific hardware info data type via IOMMU_GET_HW_INFO. Update
iommufd_backend_get_device_info() to set IOMMU_HW_INFO_FLAG_INPUT_TYPE
when a non-zero type is supplied, and adjust all callers to pass an
explicitly initialised type value.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 backends/iommufd.c    | 7 +++++++
 hw/arm/smmuv3-accel.c | 2 +-
 hw/vfio/iommufd.c     | 6 ++----
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index 633aecd525..938c8fe669 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -386,16 +386,23 @@ bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be,
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
index d320c62b04..300c35ccb5 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -115,7 +115,7 @@ smmuv3_accel_hw_compatible(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
                            Error **errp)
 {
     struct iommu_hw_info_arm_smmuv3 info;
-    uint32_t data_type;
+    uint32_t data_type = 0;
     uint64_t caps;
 
     if (!iommufd_backend_get_device_info(idev->iommufd, idev->devid, &data_type,
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index bbe944d7cc..670bdfc53b 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -306,7 +306,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
     ERRP_GUARD();
     IOMMUFDBackend *iommufd = vbasedev->iommufd;
     VFIOContainer *bcontainer = VFIO_IOMMU(container);
-    uint32_t type, flags = 0;
+    uint32_t type = 0, flags = 0;
     uint64_t hw_caps;
     VFIOIOASHwpt *hwpt;
     uint32_t hwpt_id;
@@ -631,8 +631,6 @@ skip_ioas_alloc:
     bcontainer->initialized = true;
 
 found_container:
-    vbasedev->cpr.ioas_id = container->ioas_id;
-
     ret = ioctl(devfd, VFIO_DEVICE_GET_INFO, &dev_info);
     if (ret) {
         error_setg_errno(errp, errno, "error getting device info");
@@ -889,7 +887,7 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
     HostIOMMUDeviceIOMMUFD *idev;
     HostIOMMUDeviceCaps *caps = &hiod->caps;
     VendorCaps *vendor_caps = &caps->vendor_caps;
-    enum iommu_hw_info_type type;
+    enum iommu_hw_info_type type = 0;
     uint8_t max_pasid_log2;
     uint64_t hw_caps;
 
-- 
2.43.0


