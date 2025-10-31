Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85BDBCCF9FA
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 11:05:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEmnO-0008Hv-VO; Fri, 31 Oct 2025 06:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmmz-0007LY-6q; Fri, 31 Oct 2025 06:55:25 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmmr-0003Hk-1e; Fri, 31 Oct 2025 06:55:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dddIeKjFeOI753LczdbWijP9zTz/5l9oAffVWbuib5qoauV/S3ShxKwtqEQsUnQXIpSlKtpvgzx+MpMQ+tweRg7nuBWfCMQrnlFfCb+h8IctaKFGzrPytNivdIfqxub4ouGlgYbrjpQCaL1nZVHgeulver0SghthVzeHPXRi8LyzDQtjQTYXzw5YMlquM/cb6lRca+fMJ0drGoHd4ouixmDGpL1XMBNKmdjiYOEFcR38V1QcbG9jF93ZuqeY9ZKTRTM3wUlzlLP76DLXD/VXJakZWWopxL+GO83R1gfFR/wmVT6+d0kqYhz0UDHr7WUSLUtSZ7T5/SvX0Smp/z5tRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPkwmOpSJ/jJal9pgRM03GLjZ/b2EIdJlShVtjbOviA=;
 b=StOzhr1wjVH2Cv8rn6QuRSQUBjfCHjxJlH72MhXgoYCxJ+ayaIK9riGaDZPIoMlqUPXe4aoPhd5CcrpeQBZCFTgMx12ndEQ1rqxRVXCLbMuT4XVFcielgYguRajW7nHHSLJsDZMX6mJBYnrBZOGB8P7A/cyI2rYXHd3ikWGDtiEMU7APBiuUxhEb1cwoj/sD2iOlVP7DVsxjU6YO11yARt9ugQi3jEI7tW5nt/KdGH2+S2NCVuMZDEuiRl6ujBbu9WA/RHlIpJuYdNqYdb4gakTfIUmRpHv4+65NZr4OponxtlEeJpiPW1DaBxURURtERZ7GB2lHFWCNBLtOb+p/JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPkwmOpSJ/jJal9pgRM03GLjZ/b2EIdJlShVtjbOviA=;
 b=LGBEn0kciK9aNbMgQ9xobIQHBB70kmQ3/Gh6WM7AWqc5fcpFzOhDWfyCWLsBpz0VDDmUsHiiOwYLYgWXRsXyZPbvyhhQPYMRZAfHvNWmY8h9ROKcNpId6BgkeZzEVC65zS2ALNfS1p4z+2hjHVzfoi5kHvF5kKG+fC0nv/708eKaH1tZk0UJjTavG1xQCd5tZzb94xSBYhWXdrxovh692MNLo0tmzWHtX5yNz4L5AS17ewdkLImFBtZG8e0Mbr75FkXqa+kts48GmPGR/6KFLkEXz9cnPbYRf/8KmoqfluWIB7DQfS4beLV6C276CGYLEXS44GJwJhX6GlW8FjKfvQ==
Received: from MN2PR02CA0029.namprd02.prod.outlook.com (2603:10b6:208:fc::42)
 by SN7PR12MB7180.namprd12.prod.outlook.com (2603:10b6:806:2a8::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Fri, 31 Oct
 2025 10:55:07 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:fc:cafe::5c) by MN2PR02CA0029.outlook.office365.com
 (2603:10b6:208:fc::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Fri,
 31 Oct 2025 10:55:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 10:55:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 31 Oct
 2025 03:54:55 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 03:54:50 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v5 30/32] Extend get_cap() callback to support PASID
Date: Fri, 31 Oct 2025 10:50:03 +0000
Message-ID: <20251031105005.24618-31-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|SN7PR12MB7180:EE_
X-MS-Office365-Filtering-Correlation-Id: 74ab937f-bac9-4c4c-ae2a-08de186bf43b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aQQRI9yI0ZlVPr1eMpeX4JgfgNULoIXAnMVGb/Or5LYD5s3fVLUQGR/NvgVE?=
 =?us-ascii?Q?8/cwncapNXJMX62yXE0o7FpVfxqYDPRJ0RRoHhJd3tM8yPpp5IsltG36gq2A?=
 =?us-ascii?Q?FNRqs2+Zj3Ip8K0UpATFRlCKrC4swmGvwToajjBOsLdQCWqC9/IRqcq1m9Kd?=
 =?us-ascii?Q?pO4cf8UIcTbTxGoAJ5UHy4h+klUV+w4Mo6XW8sfC0twmV3XJOnARSzZMxaCg?=
 =?us-ascii?Q?mdCJjiGhHRazz1jPwSjldBUKFIBYNeqCIr6+up2D1Cm8xNNnotd8YmmL3r+0?=
 =?us-ascii?Q?ruW6j/jIv1ZVo/RsPfT7V5TZ6n70hiwIybSKQLvSR26Bb67vCp04ZLYQqT5f?=
 =?us-ascii?Q?6tKQ8sUSbbbjEVkH4i+ESFbVn4kKn69MWQX2zJL5/E5OsYUI5vBQfyema5zI?=
 =?us-ascii?Q?Bdg9j30ZedS4w8iJF/AMKZcejhTaPSAg3W9EY/CO8rW3P93WzkM0dhE4bnh8?=
 =?us-ascii?Q?BNapd0nfqj0zuG+ixe7Vbm9Ws+53CYgbkgDDTTBIscf/DEzq4kGrkbsxGq2h?=
 =?us-ascii?Q?FchorynBdRgdOYguRtPkMhrq3WOYRWWcdvZS5F58E4kDEnouOBf0OL9+uTws?=
 =?us-ascii?Q?G97qP4MIjbIYMaSuavm1yPNiY0ZGUmZOM3bvcxjnUYs6FdO8M2TFObF9Pupp?=
 =?us-ascii?Q?wjwtsVfXuiNSEeABZaCTRy2eU9vTC3i+6omGYfMK7w5OUYlNoq+fKQaZxoUU?=
 =?us-ascii?Q?sp6svO6jZdn52bDq7sEch3Ti08X4lf4VEkJ0Tvv74FclArYkV4UgtYWpbCOS?=
 =?us-ascii?Q?vCtXkp3GRrlSfz9G3UcGVLvNDG2HEGHisG1yvT1tAvZpJ6oSHijxpn3QVEJI?=
 =?us-ascii?Q?oXwRBq2VZv1IiIi6XnBftfqyt0nnSLHE6u3y2Oyxq8mbEyWZiycyq5LAmDG5?=
 =?us-ascii?Q?/o07qSvfC+DCkd3tmoXrsoSV4uy5XNcY10ttzD+SaRZlMioLKcvbiu1AaodW?=
 =?us-ascii?Q?2xIlWiKjmS0BuFKwUoeLHXD5rGFd3dbOZNzapWJOx7C6yqKUbdxws4lqP7aR?=
 =?us-ascii?Q?HYBbWwA51nIPIK6PpXmRpH7Pkl13YiSHLvVPHqvK1znZmus0yPRmCqa6SK4Q?=
 =?us-ascii?Q?1AwTEf29MPuqqYPXRcveaz6a9852wqusrhvbe3JyQxen+GnIht2/MeLqWYJu?=
 =?us-ascii?Q?ENNRcR54l0gBbv00tRYM4e0FJdd9OgAfMzFk8dMg/Zv2/ZehoxFDVRXTTrUN?=
 =?us-ascii?Q?MTrXI/stC/rEeubfOnKGFucpBFxa6Zie/0YUmx2jaI7lJYBTvsebawRLav6r?=
 =?us-ascii?Q?sT1uAlCmp/qczNh69NdhmImmrKdTH4sMV4zDYqyHT4fiK/ZpV6qk2C1lGF+i?=
 =?us-ascii?Q?tFemF0uTsQHEoDebE7IcxwjafHCIjzot4urx12nYWGiOjI4sX9WbADLpxRGA?=
 =?us-ascii?Q?QNkWc3BBE0+sDjTsLnHvP6fd8BHCg8oo3hNlSHfvnMDwaGAju5I0uGNEPkO9?=
 =?us-ascii?Q?IQWhhX0uXKgdTkpFyiS5iLynNIiCvxefkwwsgtrAM4jTaCi9jXJUey7aQuZJ?=
 =?us-ascii?Q?8QX4XaSSe9/8cMt4uXHJCUaLl4LFxCpx7HO1Kd9uzXR/N8IjNst9BWxMDu8t?=
 =?us-ascii?Q?ZQcCruWIDBfuK6rCdOs=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 10:55:06.9530 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ab937f-bac9-4c4c-ae2a-08de186bf43b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7180
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
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

Modify get_cap() callback so that it can return cap via an output
uint64_t param. And add support for generic iommu hw capability
info and max_pasid_log2(pasid width).

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 backends/iommufd.c                 | 18 +++++++++++++++---
 hw/i386/intel_iommu.c              |  5 +++--
 hw/vfio/container-legacy.c         |  8 ++++++--
 include/system/host_iommu_device.h | 14 ++++++++++----
 4 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index 6381f9664b..392f9cf2a8 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -523,19 +523,31 @@ bool host_iommu_device_iommufd_detach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
     return idevc->detach_hwpt(idev, errp);
 }
 
-static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
+static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap,
+                                uint64_t *out_cap, Error **errp)
 {
     HostIOMMUDeviceCaps *caps = &hiod->caps;
 
+    g_assert(out_cap);
+
     switch (cap) {
     case HOST_IOMMU_DEVICE_CAP_IOMMU_TYPE:
-        return caps->type;
+        *out_cap = caps->type;
+        break;
     case HOST_IOMMU_DEVICE_CAP_AW_BITS:
-        return vfio_device_get_aw_bits(hiod->agent);
+        *out_cap = vfio_device_get_aw_bits(hiod->agent);
+        break;
+    case HOST_IOMMU_DEVICE_CAP_GENERIC_HW:
+        *out_cap = caps->hw_caps;
+        break;
+    case HOST_IOMMU_DEVICE_CAP_MAX_PASID_LOG2:
+        *out_cap = caps->max_pasid_log2;
+        break;
     default:
         error_setg(errp, "%s: unsupported capability %x", hiod->name, cap);
         return -EINVAL;
     }
+    return 0;
 }
 
 static void hiod_iommufd_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 6a168d5107..91d0d643ea 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4444,6 +4444,7 @@ static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
                            Error **errp)
 {
     HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
+    uint64_t out_cap;
     int ret;
 
     if (!hiodc->get_cap) {
@@ -4452,11 +4453,11 @@ static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
     }
 
     /* Common checks */
-    ret = hiodc->get_cap(hiod, HOST_IOMMU_DEVICE_CAP_AW_BITS, errp);
+    ret = hiodc->get_cap(hiod, HOST_IOMMU_DEVICE_CAP_AW_BITS, &out_cap, errp);
     if (ret < 0) {
         return false;
     }
-    if (s->aw_bits > ret) {
+    if (s->aw_bits > out_cap) {
         error_setg(errp, "aw-bits %d > host aw-bits %d", s->aw_bits, ret);
         return false;
     }
diff --git a/hw/vfio/container-legacy.c b/hw/vfio/container-legacy.c
index a3615d7b5d..ac8370bd4b 100644
--- a/hw/vfio/container-legacy.c
+++ b/hw/vfio/container-legacy.c
@@ -1197,15 +1197,19 @@ static bool hiod_legacy_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
 }
 
 static int hiod_legacy_vfio_get_cap(HostIOMMUDevice *hiod, int cap,
-                                    Error **errp)
+                                    uint64_t *out_cap, Error **errp)
 {
+    g_assert(out_cap);
+
     switch (cap) {
     case HOST_IOMMU_DEVICE_CAP_AW_BITS:
-        return vfio_device_get_aw_bits(hiod->agent);
+        *out_cap = vfio_device_get_aw_bits(hiod->agent);
+        break;
     default:
         error_setg(errp, "%s: unsupported capability %x", hiod->name, cap);
         return -EINVAL;
     }
+    return 0;
 }
 
 static GList *
diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
index bfb2b60478..f89dbafd9e 100644
--- a/include/system/host_iommu_device.h
+++ b/include/system/host_iommu_device.h
@@ -94,13 +94,15 @@ struct HostIOMMUDeviceClass {
      *
      * @cap: capability to check.
      *
+     * @out_cap: 0 if a @cap is unsupported or else 1 or some positive
+     * value for some special @cap, i.e., HOST_IOMMU_DEVICE_CAP_AW_BITS.
+     *
      * @errp: pass an Error out when fails to query capability.
      *
-     * Returns: <0 on failure, 0 if a @cap is unsupported, or else
-     * 1 or some positive value for some special @cap,
-     * i.e., HOST_IOMMU_DEVICE_CAP_AW_BITS.
+     * Returns: <0 on failure, 0 on success.
      */
-    int (*get_cap)(HostIOMMUDevice *hiod, int cap, Error **errp);
+    int (*get_cap)(HostIOMMUDevice *hiod, int cap, uint64_t *out_cap,
+                   Error **errp);
     /**
      * @get_iova_ranges: Return the list of usable iova_ranges along with
      * @hiod Host IOMMU device
@@ -123,6 +125,10 @@ struct HostIOMMUDeviceClass {
  */
 #define HOST_IOMMU_DEVICE_CAP_IOMMU_TYPE        0
 #define HOST_IOMMU_DEVICE_CAP_AW_BITS           1
+/* Generic IOMMU HW capability info */
+#define HOST_IOMMU_DEVICE_CAP_GENERIC_HW        2
+/* PASID width */
+#define HOST_IOMMU_DEVICE_CAP_MAX_PASID_LOG2    3
 
 #define HOST_IOMMU_DEVICE_CAP_AW_BITS_MAX       64
 #endif
-- 
2.43.0


